# START HERE (instructions for the agent and new contributors)

Welcome. This repo is set up for **McMarkis (Mhopkinsinc)**, who leads the NHL '95 SNES disassembly, and the agents working with him. Read this
file, then `SEGMENT_AGENT.md` (rules, queue and history), `CONTRIBUTING.md` and `docs/HANDOFF.md`.

## Hard rules

- Never change a ROM byte. Every commit must build to MATCH (SHA-1 `0b939f267377801d2c805b05c06a7ee6c880c5fc`).
- The ROM in `lst/` is committed for now (temporary). Never commit anything else derived from the game: no `Extracted/`, no `output/`, no patches, no other dumps.
- Never force-push, never rewrite pushed history, never push a commit that does not MATCH.
- Small commits: one segment (or one file group) per commit.
- No macros. No address where a label works.

## 1. Setup (fresh clone)

- `lst/nhl95snes.sfc` is in the repo. If it is ever missing, `./build.sh` tells you the exact path, SHA-1, CRC32 and size it needs.
- Linux / macOS: `sh tools/setup.sh` builds asar 1.91 into `tools/bin/asar`. Windows: `powershell -ExecutionPolicy Bypass -File tools\setup.ps1`.
- Python 3 for the prebuild check, the extractor and the verify scripts.

## 2. Build and confirm MATCH

`./build.sh`. The prebuild check cuts the ROM into `Extracted/segments/` on the first run. The last line must be `MATCH`.
`sh tools/verify_all.sh` is the clean check (full build plus every segment built on its own). On a fresh clone, if it is not MATCH, stop and report.

## 3. Work loop

Run `PROMPT.md` once per segment, in ROM-map order. After each segment: MATCH, `sh tools/verify_segment.sh <segment>`, commit, push, update
`docs/HANDOFF.md`. Stop after one bank (16 segments) and report.

## 4. When stuck

- A name or change that cannot be made without changing bytes: leave it and list it with the reason in `docs/HANDOFF.md`.
- 5 failed builds in a row: `git checkout -- <file>` back to the last MATCH state and note what was tried.
