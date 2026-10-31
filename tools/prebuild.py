#!/usr/bin/env python3
# prebuild.py: run before every build (build.sh, build.ps1, tools/verify_all.sh).
# Usage: python3 tools/prebuild.py
# The ROM must be present (and the right version); then makes sure Extracted/ is complete, and runs
# the extractor if it is not. If the ROM is missing or wrong, stops with the path, file name, SHA-1
# and size it must have.
import hashlib, json, os, subprocess, sys

GAME = "NHL '95 (SNES)"
EXTRACTOR = 'tools/extract.py'
ROM = {'label': "NHL '95 SNES retail (USA, header title \"NHL '95\", version 1.0)", 'file': 'lst/nhl95snes.sfc',
       'sha1': '0b939f267377801d2c805b05c06a7ee6c880c5fc', 'crc32': '2E9B1463', 'size': 0x100000}
# ---------------------------------------------------------------------------------------------
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
EXTRACTED = os.path.join(ROOT, 'Extracted')
MARKER = os.path.join(EXTRACTED, '.extract-complete.json')

def sha1_of(data): return hashlib.sha1(data).hexdigest()
def size_text(n):
    unit = f'{n // 0x100000} MB' if n >= 0x100000 else f'{n // 1024} KB'
    return f'{n} bytes (0x{n:X}, {unit})'

def stop(lines):
    print('', file=sys.stderr)
    print('*** BUILD STOPPED: ROM file needed ***', file=sys.stderr)
    print('\n'.join(lines), file=sys.stderr)
    print('', file=sys.stderr)
    print(f'lst/ holds a copy of the ROM for now (temporary). When it is gone, use your own dump of the {GAME} cartridge,', file=sys.stderr)
    print('saved under exactly that file name (no copier header), then run the build again. The', file=sys.stderr)
    print('segment files in Extracted/ are then extracted from it automatically.', file=sys.stderr)
    print('', file=sys.stderr)
    sys.exit(1)

def extracted_state():
    if not os.path.isdir(EXTRACTED): return 'Extracted/ is missing'
    if not os.path.exists(MARKER): return 'Extracted/ is incomplete (no .extract-complete.json marker)'
    try: m = json.load(open(MARKER))
    except Exception: return 'the Extracted/ marker is unreadable'
    if m.get('extractorSha1') != sha1_of(open(os.path.join(ROOT, EXTRACTOR), 'rb').read()):
        return f'{EXTRACTOR} changed since the last extraction'
    if m.get('romSha1') != ROM['sha1']: return 'Extracted/ came from an unknown ROM'
    if not m.get('files'): return 'the Extracted/ marker lists no files'
    for f in m['files']:
        p = os.path.join(EXTRACTED, f['path'])
        if not os.path.exists(p): return f"Extracted/{f['path']} is missing"
        if os.path.getsize(p) != f['size']: return f"Extracted/{f['path']} has the wrong size"
    return None

# 1. The ROM this build needs.
rom_path = os.path.join(ROOT, ROM['file'])
block = [f"  {ROM['label']}",
         f'    Put it at:  {rom_path}',
         f"                ({ROM['file']} in the repo folder)",
         f"    SHA-1:      {ROM['sha1']}",
         f"    CRC32:      {ROM['crc32']}",
         f"    Size:       {size_text(ROM['size'])}"]
if not os.path.exists(rom_path):
    stop(['This build needs this ROM, exactly the version shown:'] + block)
data = open(rom_path, 'rb').read()
if sha1_of(data) != ROM['sha1'] or len(data) != ROM['size']:
    stop([f'Found {rom_path}, but it is not the right ROM:',
          f'    its SHA-1 is {sha1_of(data)}, size {size_text(len(data))}.',
          '    (a bad dump, a hack, another revision, or a file with a 512-byte copier header)',
          'This build needs this ROM, exactly the version shown:'] + block)

# 2. Extracted/ segments: extract again if missing or incomplete.
why = extracted_state()
if not why:
    print('prebuild: ROM OK, Extracted/ complete.'); sys.exit(0)
print(f'prebuild: {why}; extracting from {ROM["file"]} ...')
r = subprocess.run([sys.executable, os.path.join(ROOT, EXTRACTOR), rom_path], cwd=ROOT, capture_output=True, text=True)
after = extracted_state() if r.returncode == 0 else 'the extractor failed'
if after:
    print(r.stdout + r.stderr, file=sys.stderr)
    print(f'*** BUILD STOPPED: extraction failed ({after}) ***', file=sys.stderr); sys.exit(1)
for l in r.stdout.splitlines(): print('prebuild: ' + l)
print('prebuild: Extracted/ complete.')
