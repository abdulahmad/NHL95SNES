# TODO

- Quick-pass 65816 disassembler for HiROM (port NHL94SNES `tools/disasm65816.py`: bank $C0-$CF file mapping, $80 mirror, vectors at $00:FFE4+).
- Decide whether code segments use $C0-$CF orgs (now) or the $80-$8F FastROM mirror where the code runs from it; asar `hirom` handles both.
- Cross-reference tables against NHL94SNES and NHL95Genesis for names.
- Vectors after `CartHeader` as source once the handlers they point to have labels.
- Asset extraction (graphics, sound, names) as in NHL94SNES, so the ROM can leave the repo.
