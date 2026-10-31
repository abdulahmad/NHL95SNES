# Contributing to NHL 95 SNES

This is a bit-perfect disassembly of NHL '95 for the SNES, assembled with asar 1.91. There is one release. The ROM is `lst/nhl95snes.sfc`
(committed for now, temporary).

The rules are the same as [NHL94SNES CONTRIBUTING.md](https://github.com/abdulahmad/NHL94SNES/blob/main/CONTRIBUTING.md); read that file for
the full comment-layout rules (tabs of 4, trailing comments at column 36, 110-column limit, `;` paragraphs of at most 3 lines). The short form:

## 1. Every build must still match

Before every push: `./build.sh` must print `MATCH`, and `sh tools/verify_segment.sh <segment>` for every segment you touched. A comment-only
or rename-only change must not change a single byte. Never commit `Extracted/`, `output/` or patch files.

## 2. Names

- Earliest game's name for the same routine, variable or constant, matched by purpose (94S, which carries 93S/94G/93G/92G, then 95G).
  Copy the spelling and capitalisation exactly.
- Never reuse a name for a different item. Record every rename in `docs/name_map.csv`. No `(was X)` comments.

## 3. Names, not numbers

- A value an earlier game names uses the name. The address of a labelled table or routine is written as the label, never as a number.
  Offsets inside data are `label-base` expressions. No macros.

## 4. Comments

- Every defined symbol has a comment on its line. Every file starts with a short header. Only write what you checked in the code.
- No IDA names (`loc_`, `sub_`), no hard-coded ROM or RAM addresses in comments.
- `python3 tools/check_comments.py` checks width, column, paragraph length and doubled `;` markers. It must print
  `comment layout OK` for the files you touched.

## 5. Commits

- Small commits, one topic each; push to main or open a PR from a fork. Never force-push.

## Checklist

- [ ] `./build.sh` matches and `tools/verify_segment.sh` matches for the segments touched
- [ ] `python3 tools/check_comments.py` is clean for the files you touched
- [ ] new symbols have comments, new constants replace the numbers they stand for
- [ ] names follow the lineage; renames are in `docs/name_map.csv`
