#!/bin/sh
# verify_segment.sh bankXX_YYYY [--all]: build that segment on its own from src/stubinc/<segment>_stub.asm (output/seg/) and compare
# its range with lst/nhl95snes.sfc; when output/nhl95snes.sfc (./build.sh) exists, compare the same range of the full build too.
# A segment's range runs from its org to the next segment's org, so a segment whose end moved is still checked over its range.
# --all checks every segment and prints only the ones that differ, then MATCH or FAIL.
cd "$(dirname "$0")/.."
python3 tools/prebuild.py >/dev/null || exit 1
ASAR=asar; [ -x tools/bin/asar ] && ASAR=tools/bin/asar
python3 - "$ASAR" "$1" <<'PY'
import re, sys, glob, os, subprocess
asar, arg = os.path.normpath(sys.argv[1]), sys.argv[2] if len(sys.argv) > 2 else ''  # normpath: Windows only starts a relative path written with backslashes
ROM = 'lst/nhl95snes.sfc'; FULL = 'output/nhl95snes.sfc'
def org(f):
    m = re.search(r'^\s*org\s+\$([0-9A-Fa-f]{6})', open(f).read(), re.M)
    a = int(m[1], 16); return ((a >> 16) & 0x3F) * 0x10000 + (a & 0xFFFF)
segs = sorted(glob.glob('src/bank*_*.asm'), key=org)
names = [os.path.basename(f)[:-4] for f in segs]
ref = open(ROM, 'rb').read(); full = open(FULL, 'rb').read() if os.path.exists(FULL) else None
def first(a, b): return next(k for k in range(len(b)) if k >= len(a) or a[k] != b[k])
def check(i):
    s = names[i]; lo = org(segs[i]); hi = org(segs[i + 1]) if i + 1 < len(segs) else len(ref)
    out = f'output/seg/{s}.sfc'; os.makedirs('output/seg', exist_ok=True)
    if os.path.exists(out): os.remove(out)
    r = subprocess.run([asar, '--fix-checksum=off', f'src/stubinc/{s}_stub.asm', out], capture_output=True, text=True)
    if r.returncode or not os.path.exists(out): return f'{s}: ASSEMBLY FAILED\n{r.stdout}{r.stderr}'
    a = open(out, 'rb').read()[lo:hi]; b = ref[lo:hi]
    if a != b: d = first(a, b); return f'{s}: DIFFER at ROM offset ${lo + d:05X} (segment build: built {a[d] if d < len(a) else None}, retail {b[d]})'
    if full is not None and full[lo:hi] != b: d = first(full[lo:hi], b); return f'{s}: DIFFER at ROM offset ${lo + d:05X} (full build)'
    return None
if arg == '--all':
    bad = [r for r in (check(i) for i in range(len(segs))) if r]
    for r in bad: print(r)
    print('FAIL' if bad else 'MATCH'); sys.exit(1 if bad else 0)
if arg not in names: print(f'{arg}: no src/{arg}.asm' if arg else 'usage: tools/verify_segment.sh <bankXX_YYYY | --all>'); sys.exit(1)
r = check(names.index(arg)); print(r or f'{arg}: MATCH'); sys.exit(1 if r else 0)
PY
