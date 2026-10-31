# Handoff

## State (2026-10-31)

- Full build MATCH (SHA-1 `0b939f267377801d2c805b05c06a7ee6c880c5fc`, 1,048,576 bytes); `tools/verify_all.sh` MATCH (full build and
  all 256 segments built on their own from their stubs).
- All 256 segments are incbin. Trial: the cartridge header ($C0:FFC0-$C0:FFDF) is source as `CartHeader` in `src/bankC0_F000.asm`;
  the vectors after it are still incbin. `docs/name_map.csv` is empty.
- Next: segment bankC0_0000 (see `SEGMENT_AGENT.md`, `PROMPT.md`). Onboarding: McMarkis.

## Setup notes

- asar 1.91 on PATH or in `tools/bin/` (`tools/setup.sh`). Python 3.
- ROM at `lst/nhl95snes.sfc` (committed for now, temporary). `Extracted/` and `output/` are generated and gitignored.
- `python3 tools/disasm65816.py lst/nhl95snes.sfc output/quickpass` is the quick-pass disassembler (NHL94SNES's, ported to HiROM).
  It starts at the vectors only; reset and NMI soon reach indirect jumps (`jml [$04AA]`) and inline-parameter calls, so add
  `--entry ADDR:M:X` for the routines you work on. It also writes `xref.txt` (every long operand into the ROM).
- Windows: `python3` must be a real Python (not the Store alias). `tools/verify_segment.sh` normalises the asar path, because
  Windows cannot start a relative program path written with forward slashes.

## Unsure

- (none yet)
