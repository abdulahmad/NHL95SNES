# NHL '95 (SNES)

> **🤝 Making a mod, hack, port or other derivative work from this repo? You must credit me and everyone credited in this repo, clearly, in your own repo and in every release. See [Credits and derivative works](#credits-and-derivative-works).**

> **Temporary:** the retail ROM is committed in `lst/` for convenience while the repo is young. It will be removed as the repo gets closer to final; after that you supply your own copy (the build finds it by SHA-1 and size, any file name, and tells you exactly what it needs when it is missing). Patch files are never committed.

## 🚧 Current Status

- Bootstrapped: the whole cartridge is 256 segments of 4 KB, each an `incbin` of its ROM bytes, and the build is byte-identical to the retail ROM.
- Every segment also builds on its own from its stub (`src/stubinc/<segment>_stub.asm`) and is checked against its ROM range.
- Trial: the cartridge header at the end of bank $C0 is source (`CartHeader` in `src/bankC0_F000.asm`).
- Segments bankC0_0000 (data: team palettes, packed tile sets, the sound RAM clear program) bankC0_1000 (the SMSG sound driver as
  SPC700) bankC0_2000 (the text fonts), bankC0_3000 (uniform palettes) bankC0_4000 (tables, two colour hooks, the Tampa Bay photos) bankC0_5000 and
  bankC0_6000 (the Toronto and Vancouver photos) and bankC0_7000 (team songs) are source; the queue is in SEGMENT_AGENT.md.

**AI agent or new contributor: start with [START_HERE.md](START_HERE.md).**

Reverse engineered source of NHL '95 for the SNES, assembled with asar 1.91 (the same assembler as [NHL94SNES](https://github.com/abdulahmad/NHL94SNES) and [NHLPA93SNES](https://github.com/abdulahmad/NHLPA93SNES)). The ROM is HiROM (FastROM), 1 MB. The full build is byte-identical to the retail ROM:

| | |
|---|---|
| File | `lst/nhl95snes.sfc` (headerless) |
| Size | 1,048,576 bytes |
| SHA-1 | `0b939f267377801d2c805b05c06a7ee6c880c5fc` |
| CRC32 | `2E9B1463` |

## Lineage

NHL '95 SNES is based on [NHL94SNES](https://github.com/abdulahmad/NHL94SNES) (the 94 SNES code base it was built from) and [NHL95Genesis](https://github.com/abdulahmad/NHL95Genesis) (the 95 features). Names come from those two repos, matched by purpose, not by identical code, and the earlier game's name wins: 94S (and through it 93S, 94G, 93G, 92G) first, then 95G for what is new in 95. See SEGMENT_AGENT.md.

## Layout

- `src/nhl95snes.asm` includes the segments in ROM order. Each `src/bankXX_YYYY.asm` has one `org` and starts as an `incbin` of `Extracted/segments/bankXX_YYYY.bin`.
- `src/stubinc/<segment>_stub.asm` builds one segment on its own: `hirom`, the outside labels it uses (equates), then the segment file.
- `tools/prebuild.py` checks the ROM (path, SHA-1, CRC32, size) and runs `tools/extract.py`, which cuts it into `Extracted/segments/` (gitignored).
- `tools/verify_segment.sh <segment>` builds one segment from its stub and compares it (and the full build's range) with the ROM; `--all` does every segment.
- `tools/verify_all.sh` is the clean check: deletes `output/` and `Extracted/`, extracts, builds, checks every segment. Last line MATCH.

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
