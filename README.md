# NHL '95 (SNES)

> **🤝 Making a mod, hack, port or other derivative work from this repo? You must credit me and everyone credited in this repo, clearly, in your own repo and in every release. See [Credits and derivative works](#credits-and-derivative-works).**

> **📀 Game data is not included.** This repository has the assembly code only. Put your own dump of the cartridge (headerless) at `lst/nhl95snes.sfc` (gitignored); the build checks its SHA-1 and size and tells you exactly what it needs when it is missing. The graphics and the player names are extracted from it when you build. ROMs and patch files are never committed.

## 🚧 Current Status

- Every byte of the cartridge is source (banks $C0-$CF) and the build is byte-identical to the retail ROM.
- Aligned layout (on the `claude/project-thread-ggw7zu` branch): `src/banks/` lists each bank's files in ROM order; 1,348
  routines are in `src/routines/`, in folders named after the NHL95Genesis source files; 1,399 data files are in
  `src/data/`. Where each routine went and why: `docs/routines95s.csv`.
- Next: naming against NHL95Genesis and NHL94SNES (see `docs/HANDOFF.md`).

**AI agent or new contributor: start with [START_HERE.md](START_HERE.md).**

Reverse engineered source of NHL '95 for the SNES, assembled with asar 1.91 (the same assembler as [NHL94SNES](https://github.com/abdulahmad/NHL94SNES) and [NHLPA93SNES](https://github.com/abdulahmad/NHLPA93SNES)). The ROM is HiROM (FastROM), 1 MB. The full build is byte-identical to the retail ROM:

| | |
|---|---|
| File | `lst/nhl95snes.sfc` (headerless) |
| Size | 1,048,576 bytes |
| SHA-1 | `0b939f267377801d2c805b05c06a7ee6c880c5fc` |
| CRC32 | `2E9B1463` |

## Lineage

NHL '95 SNES is a separate code base, related to [NHL95Genesis](https://github.com/abdulahmad/NHL95Genesis) (the 95 game) and [NHL94SNES](https://github.com/abdulahmad/NHL94SNES) (the earlier SNES game). The folders and names follow NHL95Genesis; NHL94SNES decides only where NHL95Genesis has nothing (SNES-only engine jobs, data, banks). Names are matched by purpose, not by identical code. The rules are in [docs/RULES.md](docs/RULES.md).

## Layout

- `src/nhl95snes.asm` includes the RAM and register equates, then `src/banks/bCx_<content>.asm` in ROM order. Each bank
  file has the bank's `org` and lists its files.
- `src/routines/<95G file>/<Routine>.asm`: one routine (a fall-through run) per file. The folders mirror NHL95Genesis:
  `engine/<file>/`, `front/<file>/`, and its top files (`hockey/`, `main/`, `display/`...). SNES-only jobs that 95G does
  not have keep the NHL94SNES folder (`sound/`, `decompress/`).
- `src/data/{gfx,sound,text,tables}/`: one asset (or one family of records) per file, as in NHL94SNES.
- `tools/prebuild.py` checks the ROM (path, SHA-1, CRC32, size) and runs `tools/extract.py`, which cuts it into
  `Extracted/segments/` (gitignored); the data files `incbin` those cuts.
- `tools/verify_all.sh` is the clean check: deletes `output/` and `Extracted/`, extracts, builds. Last line MATCH.
- `tools/inventory95.py` writes `docs/routines95s.csv`; `tools/move95.py` did the move from 4 KB segments to this layout.

## Build

`sh tools/setup.sh` once (builds asar 1.91 into `tools/bin`, gitignored; Windows: `tools\setup.ps1`). Then `./build.sh` (Windows: `build.ps1`). Needs Python 3. It ends with `MATCH`; the ROM is `output/nhl95snes.sfc`.

## AI assistance

This project is AI-assisted. The work is directed by a strict ruleset and curated by hand, with the aim of producing clean, correct, correctly labelled and commented code that closely matches what the original developers likely had. We can't guarantee it's perfect, and ultimately this will always be a work in progress. If you see something that needs fixing, raise an issue, or even better, raise a PR.

## Credits and derivative works

Thanks to chaos, StaticEck, McMarkis and Drezz for their help with the disassembly.

Special thanks to smozoma and kingraph, whose past contributions to the NHL modding community made this work easier.

And thank you to the original developers of the game.

This project is the result of my work and the work of the people credited above. If you build anything from it, including mods, ROM or EXE hacks, ports, released forks, tools, or any other derivative work, you must credit us:

- Put the credit in your repo's README, near the top and not buried in a footer, and in the notes of every release you publish, including any text file shipped inside a release archive.
- Name me and link to this repository.
- Name everyone credited here: chaos, StaticEck, McMarkis (Mhopkinsinc) and Drezz, with special thanks to smozoma and kingraph.
- If you only use part of this repo (docs, a tool, labels, a file format description), the credit still applies.
- If you are unsure, over-credit.

Credit is the condition for using this work. Please do not release a derivative without it.
