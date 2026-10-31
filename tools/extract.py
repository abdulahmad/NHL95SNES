#!/usr/bin/env python3
# extract.py: cut the ROM into the 4 KB segment files that the incbin segments include.
# Usage: python3 tools/extract.py lst/nhl95snes.sfc   (tools/prebuild.py runs it when needed)
# Writes Extracted/segments/bankXX_YYYY.bin, then Extracted/.extract-complete.json last.
import hashlib, json, os, shutil, sys
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
rom = open(sys.argv[1], 'rb').read()
out = os.path.join(ROOT, 'Extracted'); shutil.rmtree(out, ignore_errors=True)
os.makedirs(os.path.join(out, 'segments'))
files = []
for o in range(0, len(rom), 0x1000):
    name = f'segments/bank{0xC0 + o // 0x10000:02X}_{o % 0x10000:04X}.bin'
    open(os.path.join(out, name), 'wb').write(rom[o:o + 0x1000])
    files.append({'path': name, 'size': 0x1000})
marker = {'romSha1': hashlib.sha1(rom).hexdigest(),
          'extractorSha1': hashlib.sha1(open(__file__, 'rb').read()).hexdigest(), 'files': files}
json.dump(marker, open(os.path.join(out, '.extract-complete.json'), 'w'), indent=1)
print(f'ROM: {sys.argv[1]} sha1 {marker["romSha1"]}')
print(f'Extracted {len(files)} slices')
