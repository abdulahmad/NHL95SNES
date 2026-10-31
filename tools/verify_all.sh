#!/bin/sh
# verify_all.sh: clean check. Deletes Extracted/ and output/, extracts fresh, builds the whole ROM, then builds every segment on
# its own from its stub and checks it (tools/verify_segment.sh --all). The last line is MATCH or FAIL.
cd "$(dirname "$0")/.."
rm -rf output Extracted
fail=0; mkdir -p output; LOG=output/verify_all.log
./build.sh >$LOG 2>&1
grep -qiE 'error' $LOG && { echo "ASM ERRORS"; fail=1; }
tail -1 $LOG | grep -qx MATCH || { echo "TOP:"; tail -15 $LOG; fail=1; }
[ -s output/nhl95snes.sfc ] || { echo "TOP NO BIN"; fail=1; }
sh tools/verify_segment.sh --all || fail=1
[ $fail = 0 ] && echo MATCH || { echo FAIL; exit 1; }
