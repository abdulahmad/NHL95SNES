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
- There is no quick-pass disassembler in this repo yet. NHL94SNES's `tools/disasm65816.py` is LoROM; adapt it to HiROM (TODO.md).

## Unsure

- (none yet)
