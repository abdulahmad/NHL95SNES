#!/bin/sh
# Check the ROM (tools/prebuild.py), assemble src/nhl95snes.asm with asar and verify byte-identical to lst/nhl95snes.sfc.
cd "$(dirname "$0")"
python3 tools/prebuild.py || exit 1
mkdir -p output
ASAR=asar; [ -x tools/bin/asar ] && ASAR=tools/bin/asar
if command -v sha1sum >/dev/null; then SHA="sha1sum"; else SHA="shasum -a 1"; fi
rm -f output/nhl95snes.sfc
$ASAR --fix-checksum=off --symbols=wla --symbols-path=output/nhl95snes.sym src/nhl95snes.asm output/nhl95snes.sfc || { echo "MISMATCH (assembly failed)"; exit 1; }
ref=$($SHA lst/nhl95snes.sfc | cut -d' ' -f1); out=$($SHA output/nhl95snes.sfc | cut -d' ' -f1)
echo "ref $ref  $(wc -c <lst/nhl95snes.sfc) bytes"; echo "out $out  $(wc -c <output/nhl95snes.sfc) bytes"
if [ "$ref" = "$out" ]; then echo MATCH; else echo MISMATCH; cmp -l lst/nhl95snes.sfc output/nhl95snes.sfc | head -20; exit 1; fi
