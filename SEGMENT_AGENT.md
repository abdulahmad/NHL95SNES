# NHL 95 SNES segment agent

This file is the queue and the history. Do not rewrite it as a whole file. Edit it in place.
(Adapted from the NHL94SNES and NHLPA93SNES SEGMENT_AGENT.md.)

## Current rules (Oct 2026; these override older notes below)

Naming lineage is 92G -> 93G -> 94G -> 95G, and the SNES ports sit beside their Genesis parents (93S from 92G/93G, 94S from 93S plus
the 94G features, **95S from 94S plus the 95G features**).
- A routine, variable or table that does the same job as its parent's takes the parent's name: **NHL94SNES** first (its names already
  trace back through 93S, 94G, 93G and 92G), then **NHL95Genesis** for 95 features. Match by purpose, not identical code.
- Earlier games' names win: when 94S and 95G both have a name for the same thing, 94S (or the earlier game it took the name from) keeps it.
- Clash rule: if one name would mean two different things, the earliest game's meaning keeps the name and the later one gets a new name.
- Fix the earliest repo first, then propagate the change down the lineage.
- Team names: 94 and 95 use NYIslanders / NYRangers (short NYI / NYR).

Source style (same as the sibling repos):
- No rename-history, provenance or origin-tag comments ("was X", "from 93G", "renamed"). That history lives in `docs/name_map.csv` only.
- No hardcoded addresses in comments, and no hand-kept derived counts (sizes, numbers of entries, totals) the assembler can compute.
- Never write an address where a label works: pointers, table offsets and sizes are label expressions. A number is only for a
  value with no label yet (inside a still-incbin segment), or an incbin split point.
- No macros. Plain instructions and data directives only.
- Local labels in 92 style: `.loop`, `.next`, `.done`, `.exit`, and plain numbers for trivial jumps.
- File headers are short plain-English stories of what the file does.
- Never reuse a name for a different item (clash rule: the earliest game's meaning keeps the name; the later item gets a new one).
- No guessing: a wrong name is worse than an auto name. Unsure items go under Unsure in `docs/HANDOFF.md`.

Work in small steps: every change is built and checked byte for byte against the reference ROM, then committed and pushed to main
(no force push). Keep `docs/HANDOFF.md` current after each push.

## Current segment

bankC9_6000 (org $C9620B): banks $C0-$C8 are all source. <- CURRENT

## Sources

- Reference ROM: `lst/nhl95snes.sfc` (committed for now, temporary; `tools/prebuild.py` says what it must be).
- Each segment `src/bankXX_YYYY.asm` starts as an `org` plus an `incbin` of its 4 KB from `Extracted/segments/` (cut from the ROM by
  `tools/extract.py`, run automatically by the prebuild check).
- Names: NHL94SNES (https://github.com/abdulahmad/NHL94SNES) for code that matches 94S, NHL95Genesis
  (https://github.com/abdulahmad/NHL95Genesis) for 95 features, then NHL94Genesis / NHLPA93SNES / NHLPA93Genesis / NHL92Genesis down the
  lineage. NHL94SNESVault (https://github.com/Mhopkinsinc/NHL94SNESVault) for SNES-only systems it already names.
- Memory map: HiROM, FastROM (header map mode $31). The ROM is banks $C0-$CF (64 KB each); the same bytes appear at $80-$8F:$8000-$FFFF
  (upper half) and $40-$4F. The reset and NMI vectors point into bank $00 ($00:FD17...), the mirror of $C0:FD17. Segments use the $C0-$CF
  orgs. Code that runs in the $80 mirror needs the right bank in its absolute operands; keep operand sizes explicit.

## Build and verify

- `./build.sh` runs the prebuild check, assembles `src/nhl95snes.asm` with asar 1.91 into `output/nhl95snes.sfc`, and compares SHA-1 with
  `lst/nhl95snes.sfc`. It prints MATCH or MISMATCH plus the first differing offsets.
- `sh tools/verify_segment.sh bankXX_YYYY` assembles `src/stubinc/bankXX_YYYY_stub.asm` on its own (`output/seg/`) and compares the
  segment's range (its org to the next segment's org) with the ROM, then the same range of the full build.
- `sh tools/verify_all.sh` deletes Extracted/ and output/, extracts fresh, builds, and checks every segment. Last line MATCH or FAIL.

## Segment files and stubs

- A segment file has one `org` and is included by `src/nhl95snes.asm` in ROM order.
- Its stub `src/stubinc/<segment>_stub.asm` sets `hirom`, defines the outside labels the segment uses as equates (values read from the ROM),
  then `incsrc`s the segment. A label another converted segment defines: an equate in your stub only (the full build has the label itself).
  A duplicate symbol in the stub build means an equate names a label the file already defines.
- A segment's end may move to a routine or table boundary; move the next segment's org (and cut its incbin with
  `incbin "../Extracted/segments/<file>.bin":<start>..<end>`) in the same commit, and note it in the row. Split a big segment into more
  files the same way; give each new file its own stub.
- RAM names go in `src/ram95s.asm` (create it with the first name, include it at the top of `src/nhl95snes.asm` and in the stubs that need
  it). Hardware register names go in `src/inc/` (copy NHL94SNES's).
- After the segment phase the source is regrouped into the hybrid layout (`src/banks`, `src/routines/<module>`, `src/data`) as in 93S/94S.

## History

- 2026-10-31: bootstrap. 256 incbin segments, a stub per segment, prebuild ROM check (SHA-1/CRC32/size), extractor, asar build, segment and
  full verify (MATCH). Trial: `CartHeader` (cartridge header) as source in bankC0_F000.
- 2026-10-31: `tools/disasm65816.py`, the NHL94SNES quick-pass disassembler ported to HiROM (bank $C0-$CF file mapping, system
  banks only above $8000, vectors in bank $00, run bank kept per instruction, `--codemap` optional, `xref.txt` of long operands).
  `tools/verify_segment.sh` runs asar on Windows too.
- 2026-10-31: bankC0_0000 matched (data only). Four packed sets (TeamPalettes, ArrowFontTiles, GradientBarTiles, MeterFontTiles):
  header as dw, stream as a ROM cut; their ends come from `tools/unpack95.py`, a model of the bank $C5 unpacker. UnusedPalette.
  SoundRAMClear as `arch spc700` source; SPC and DSP register names (94S) in `src/inc/spc_regs.asm`. End moved to $C00F48,
  bankC0_1000 org to $C00F49.
- 2026-10-31: bankC0_1000 matched: SoundDriver, the whole SMSG 3.07w upload (init block at sound RAM $1000, main block at $0120)
  as `arch spc700` source from `tools/spc700dis.py` (94S's, ported: HiROM, whole upload streams). Entries: the tcall vectors,
  the command and event tables. Named: the init, the command loop, the tick, the dispatch calls, the tables; internals keep
  .lXXXX labels with cross-reference comments. End moved to $C01A38, bankC0_2000 org to $C01A39.
- 2026-10-31: bankC0_2000 matched: the three fonts of the text routine at $C4BE34 (font in $0C, flags in $0E), ends found from
  the font addresses the callers pass ($1A39, $1FF9, $3239) and the packed set at $C03CF9. Glyph data stays incbin. End moved
  to $C03CF8 (two segments' worth, one unit of data), bankC0_3000 org to $C03CF9.
- 2026-10-31: bankC0_3000 matched: WonCheckTiles and WonCheckPalette, then the uniform palettes, named AwayUniformPalettes and
  HomeUniformPalettes after the two bases the code adds team * 64 to (94S keeps two tables; here they interleave). End moved to
  $C04641, bankC0_4000 org to $C04642.
- 2026-10-31: bankC0_4000 matched: two packed tile sets, HDMA tables, two NMI colour hooks (the first code in source; the SNES
  register names copied from 94S into `src/inc/snes_regs.asm`), small tables (BitMaskTable from 94S), then the Tampa Bay player
  photos. End moved to $C05DAB, bankC0_5000 org to $C05DAC.
- 2026-10-31: bankC0_5000 matched: the Toronto photo set (PhotoPalettesTOR, PlayerPhotosTOR). End moved to $C06E6C, bankC0_6000
  org to $C06E6D.
- 2026-10-31: stub headers rewrapped (comments only) so `tools/check_comments.py` passes on all of src. bankC0_6000 matched: the
  Vancouver photo set. End moved to $C07ECA, bankC0_7000 org to $C07ECB.
- 2026-10-31: bankC0_7000 matched: TeamSongs and DefaultSongs (94S names: six songs per home team, $FF picks a default at
  random), a sound list, then the $CD fill to $C08000. The lower half of bank $C0 is all source; bankC0_8000 is code.
- 2026-10-31: bankC0_8000 matched: the start of the engine is 94S's bank $80 engine rebuilt (same InitHooks and seed, same
  hooks, waits, RandomWord and multiplies), so the 94S names and RAM names apply (src/ram95s.asm started). The data in front
  of it is mostly not traced. End moved to $C09004, bankC0_9000 org to $C09005.
- 2026-10-31: bankC0_9000 matched: the rest of 94S's math (94S names; 95S has no MulFrac8 / MulFrac16), then 95S game code with
  CODE_ names and cross-reference comments (callers from the code banks only). End moved to $C09A23, bankC0_A000 org to $C09A24.
- 2026-10-31: bankC0_A000 matched: asstab and asspuckc_postab (the 93S tables, same shape and nearly the same values), more game
  tables, then the first sound samples (12-byte header + BRR, found by the end flags). End moved to $C0B5BE, bankC0_B000 org to
  $C0B5BF.
- 2026-10-31: bankC0_B000 matched: Sample22, Sample01. End moved to $C0C1CA, bankC0_C000 org to $C0C1CB.
- 2026-10-31: bankC0_C000 matched: Sample00. End moved to $C0D358, bankC0_D000 org to $C0D359.
- 2026-10-31: bankC0_D000 matched: Sample13, Sample32, Sample18. End moved to $C0E5C4, bankC0_E000 org to $C0E5C5.
- 2026-10-31: bankC0_E000 matched: Sample16, Sample17, Sample14. End moved to $C0F287, bankC0_F000 org to $C0F288.
- 2026-10-31: bankC0_F000 matched: Sample15, the reset / NMI / COP / BRK entry points, the fill, the extended header and the
  vectors. CartHeader is back as source (the bankC0_E000 commit had replaced this file with an incbin when it moved the org).
  Bank $C0 is all source.
- 2026-10-31: bankC1_0000 matched as data: 39 palettes, a word run and the first blocks the DATA8_C08000 records point at
  (their reader is not traced, so the blocks keep DATA8_ names and stay incbin). End moved to $C110B7, bankC1_1000 org to
  $C110B8.
- 2026-10-31: code banks first (approved): bank $C1 cannot be named until the code that reads it is traced. bankC5_8000
  matched out of ROM order: the reset, Decompress and its formats (as tools/unpack95.py models them), the LZSS and map set
  unpackers, the transfer queue helpers, HDMA set-up, then game code. Decoded by recursive descent (M/X carried through
  calls, jump tables sized against the decoded code, the inline parameters of SetBGMapRegs and SetupHDMA kept as db).
  tools/disasm65816.py: mvn / mvp operands now in asar's order.
- 2026-10-31: bankC5_9000 matched (game code, CODE_ names). bankC5_8000 and bankC5_9000 now refer to each other's labels
  (jump table entries, jsr targets), with equates in their stubs. End moved to $C59F78, bankC5_A000 org to $C59F79.
- 2026-10-31: bankC5_A000 matched (game code, CODE_ names). Seeds: the jsl into the range, the jsr / jmp / table targets of
  bankC5_8000 and bankC5_9000, and a descent of the whole bank for jsr from the code not yet written (two more entries).
  Long operands into the segment are labels (the tables get DATA8_ names with their readers); bankC5_9000's numeric
  jsr / jmp into it are labels now. End moved to $C5AFB5, bankC5_B000 org to $C5AFB6.
- 2026-10-31: bankC5_B000 matched (game code, CODE_ names). Three routines are callbacks: code passes their address (lda #, then
  ldx, ldy, jsr to a list routine in bankC5_5000), so they are seeds, and the lda operands are labels (also the one in
  bankC5_A000). A table read 2 bytes before its start is written as its label - 2. End moved to $C5BFDF, bankC5_C000 org to
  $C5BFE0.
- 2026-10-31: bankC5_C000 matched (game code, CODE_ names). A sort (CODE_C5C029) jumps through $9F to one of 7 compare routines
  from DATA8_C5C0AE, written as a jump table; three more callbacks (two passed to the list routine in bankC5_5000, one to a
  routine in bankC5_D000). End moved to $C5D00C, bankC5_D000 org to $C5D00D.
- 2026-10-31: bankC5_D000 matched (game code, CODE_ names). Some calls push a return address (pea label-1) and jump through a
  direct page pointer; the decoder now follows the return point, and the pea operands are labels. End moved to $C5DF5E,
  bankC5_E000 org to $C5DF5F.
- 2026-10-31: bankC5_E000 matched: game code, then the sprite object routines, named from docs/sprite_objects.md (CreateSprite,
  UploadSpriteFrame, AnimateSprites, CreateSpriteSharePal); calls to them in the other bank $C5 segments use the names. Twelve
  small routines that nothing traced reaches (six store a setting in SRAM, each after a 00 00) are decoded as code marked "no
  caller found". End moved to $C5F070, bankC5_F000 org to $C5F071.
- 2026-10-31: bankC5_F000 matched: UnpackStream0 and BuildSpriteOAM (docs/sprite_objects.md), then game code and a zero fill to
  the end of the bank. UnpackStream0 jumps to its own loop through the bank $85 mirror (jml label-$400000) so that jmp DMAP2
  runs the mvn it builds in the DMA registers, which jumps back to the loop; those operands are labels. The upper half of bank
  $C5 ($C5800C-$C5FFFF) is all source. Next: the lower half, bankC5_0000 (org $C50000).
- 2026-10-31: bankC5_0000 matched: Opening (Reset_Fast ends with jml to it, as 94S Reset_Fast ends with jml Opening, the cold
  start), then game code. Long operands and jsl targets anywhere in the full build now come out as their labels (from the asar
  symbol file), e.g. InitHooks, asstab and the bank $C0 math routines. End moved to $C510F5, bankC5_1000 org to $C510F6.
- 2026-10-31: bankC5_1000 matched (game code, CODE_ names). asstab (bankC0_A000) points at three bank $C5 routines; entry 27
  (CODE_C51CC1) is here and the table uses its label now. The routines are not named from 94S by index: 95 Genesis reorders
  asstab, so the SNES order is not known. End moved to $C52007, bankC5_2000 org to $C52008.
- 2026-10-31: bankC5_2000 matched (game code, CODE_ names). Three routines store a continuation address (lda #label, sta to a
  direct page pointer) before jumping to CODE_C52898, which jumps back through it; they are seeds and the lda operands are
  labels. Some 14-byte records sit between pieces of code (each bra skips one); they stay data. End moved to $C5308C,
  bankC5_3000 org to $C5308D.
- 2026-10-31: bankC5_3000 matched (game code, CODE_ names). Seven routines have no reference anywhere in the ROM (no jsl, jml or
  pointer through any bank $C5 mirror); their bytes are code, so they are decoded and marked "no caller found". End moved to
  $C53FE4, bankC5_4000 org to $C53FE5.
- 2026-10-31: bankC5_4000 matched (game code, CODE_ names): asstab entries 10 and 12 (CODE_C5474A, CODE_C545C7) are seeds and
  the table uses their labels. Jump tables in the lower half point below $8000, so the table sizer now takes targets in the
  scanned range or known as code from the whole-bank descent (it used to stop at any target below $8000). End moved to $C54F04,
  bankC5_5000 org to $C54F05.
- 2026-10-31: bankC5_5000 matched (game code, CODE_ names). Six jump tables sit side by side (DATA8_C55012 to C55038); the code
  picks one by a state word and indexes it, so their sizes come from where the next one starts. Their routines are in
  bankC5_6000 / 7000, so the entries stay numbers until those segments are written (the pipeline relabels dw tables). A word
  table in bank $C4 reads as jml $C55CBA; that false seed is dropped. End moved to $C56004, bankC5_6000 org to $C56005.
- 2026-10-31: bankC5_6000 matched (game code, CODE_ names): four more callbacks of the list routine CODE_C55ABC (one loads A
  last, after ldx / ldy), two jump tables, and the day and month names written as text (MonthJanuary ... MonthDecember). The
  callback comments of bankC5_B000 / C000 now name CODE_C55ABC and CODE_C5D8E7. End moved to $C56F5B, bankC5_7000 org to
  $C56F5C.
- 2026-10-31: bankC5_7000 matched: game code, a jump table read with a long address and jumped to through a pointer
  (DATA8_C57810), and two callbacks of CODE_C55ABC, one pushed with pea and pulled into A (its pea operands are labels). Bank
  $C5 is all source. The code-first track goes on with bank $C4 (bank $C3 starts with the team database): next bankC4_0000 (org
  $C40000).
- 2026-10-31: bankC4_6000 matched (game code, CODE_ names), with two 13-entry jump tables whose unused entries are $0000; such
  entries now stay $0000 (DATA8_C570E8 in bankC5_7000 had one written as Opening; fixed). End moved to $C4702D, bankC4_7000 org
  to $C4702E.
- 2026-10-31: bankC3_6000 matched: the end of the data run of bank $C3, then its code. The callee analysis now follows php / plp
  (a callee that restores the flags returns with the widths of its caller); rechecking all written segments changed nothing. An
  indexed long read from the first byte of a bank ($C30000,x and the like) is a bank base, not the label there: those stay
  numbers (TeamList, TeamPalettes and CODE_C40000 had been put on such reads; reverted). End moved to $C36FF1, bankC3_7000 org
  to $C36FF2.
- 2026-10-31: bankC4_E000 matched (game code, CODE_ names; no gaps). End moved to $C4F01D, bankC4_F000 org to $C4F01E.
- 2026-10-31: bankC4_F000 matched: game code, Sample02, then zeros to the end (padbyte / pad). Bank $C4 is all source. Next:
  bank $C3 (bankC3_0000, org $C30000), in ROM order and the next code bank: it starts with the team database, whose records hold
  licensed player names and should stay ROM cuts (HANDOFF).
- 2026-10-31: bankC4_D000 matched (game code, CODE_ names), with task routines and a jump table. For a seed of unknown state the
  descent keeps 16-bit A and index unless that decode fails sooner than another state succeeds (a short false jml had made 8-bit
  look right); rechecking all written segments changed nothing. End moved to $C4DFD5, bankC4_E000 org to $C4DFD6.
- 2026-10-31: bankC4_C000 matched (game code, CODE_ names). CODE_C4BF1A dispatches by pushing a routine address - 1 from
  DATA8_C4C07D and returning: written as dw label-1. A callee that returns with other register widths (sep / rep before all its
  returns) now sets the state of its caller; rechecking all written segments with it changed nothing. End moved to $C4CFF4,
  bankC4_D000 org to $C4CFF5.
- 2026-10-31: bankC4_B000 matched (game code, CODE_ names). Routines are passed as X:A long pointers (lda #low, ldx #bank, in
  either order, then jsl / jmp / bra) to SetNMIHook and the task starters CODE_C4B743 / CODE_C4B763, and tasks keep their next
  routine in field 2 (lda #routine, sta $0002,x): all are seeds now, and the immediates are labels (31 here). End moved to
  $C4BF46, bankC4_C000 org to $C4BF47.
- 2026-10-31: bankC4_A000 matched (game code, CODE_ names), with asstab routines and a table read with long addresses. End moved
  to $C4B00E, bankC4_B000 org to $C4B00F.
- 2026-10-31: bankC4_9000 matched (game code, CODE_ names), with asstab routines and a few tables read with long addresses. End
  moved to $C49FBC, bankC4_A000 org to $C49FBD.
- 2026-10-31: bankC4_8000 matched (game code, CODE_ names). asstab entry 0 is an rtl here; it takes the 94S name rtss (entry 0
  is the empty assignment in both the 94 and the 95 Genesis order). End moved to $C492F7, bankC4_9000 org to $C492F8.
- 2026-10-31: bankC4_7000 matched (game code, CODE_ names), with asstab routines (asstab uses their labels now). End moved to
  $C47FB4, bankC4_8000 org to $C47FB5.
- 2026-10-31: bankC4_5000 matched (game code, CODE_ names), with three jump tables and CODE_C45950, the routine the long routine
  pointers (lda #bank, lda #low) are handed to; the notes of those routines name it now. End moved to $C45FAB, bankC4_6000 org
  to $C45FAC.
- 2026-10-31: bankC4_4000 matched (game code, CODE_ names). Raw jsl matches in bank $C3 now count only from $C36000 (its lower
  part is the team database), and a seed that starts with brk is dropped: one such false seed had cut into real code. End moved
  to $C44F1F, bankC4_5000 org to $C44F20.
- 2026-10-31: bankC4_3000 matched (game code, CODE_ names): seven asstab routines (asstab uses their labels now) and a routine
  passed as a long pointer. A code address that one call site passes as a data pointer keeps its code label. End moved to
  $C43FC7, bankC4_4000 org to $C43FC8.
- 2026-10-31: bankC4_2000 matched: the rest of the data run, then game code. asstab long pointers (dd / dl in source) are now
  trusted seeds; a long pointer set with lda #bank, sta / lda #low, sta and handed to the routine at $C45950 is code, otherwise
  data read through it: both get labels (label>>16 for the bank). End moved to $C4313D, bankC4_3000 org to $C4313E.
- 2026-10-31: bankC4_1000 matched: data only (no code reaches it). The tables get DATA8_ labels where code reads them with a
  long address, and bankC4_0000 / bankC5_C000 use those labels now. From DATA8_C41E48 the data looks like animation lists (8
  word pointers, one per direction, to frame / value pairs ending with a negative word): not traced yet. End moved to $C4202F,
  bankC4_2000 org to $C42030.
- 2026-10-31: bankC4_0000 matched: game code, then the start of a run of data tables that goes on to about $C42D10. Bank $C4 has
  data between its code, so the seeds now come only from calls in decoded code (the bank $C5 segments, bank $C0) and raw matches
  in banks not decoded yet, plus a whole-bank descent from those (c4trust) whose seeds are dropped if they land inside a decoded
  instruction; jump tables of 40 or more entries are treated as misdecodes. End moved to $C41005, bankC4_1000 org to $C41006.
- 2026-10-31: bankC1_0000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C110B8.
- 2026-10-31: bankC1_1000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C1211C.
- 2026-10-31: bankC1_2000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C130D2.
- 2026-10-31: bankC1_3000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C14077.
- 2026-10-31: bankC1_4000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C15241.
- 2026-10-31: bankC1_5000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C16064.
- 2026-10-31: bankC1_6000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C17138.
- 2026-10-31: bankC1_7000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C18034.
- 2026-10-31: bankC1_8000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others). Next org $C19084.
- 2026-10-31: bankC1_9000 matched: sprite frame tiles named by sprite and frame (the records were rendered: team logos 0-27
  in 94S team order, then the EA intro, NHL and NHLPA logos and others); SpritePieces as source. Next org $C19B68.
- 2026-10-31: SpriteObjects (was DATA8_C08000) is source in bankC0_8000: the header, the records, frame lists, frame headers and
  scripts, with the bank $C1 labels (the pieces offset as label - SpritePieces, the frame count as a label difference).
- 2026-10-31: bankC1_A000 matched: TeamNicknameTiles (rendered: the 28 team nicknames in dot-matrix letters, a set for
  Decompress), the whole of it, so the end moved to $C1BA30. Next org $C1BA31 (map sets: map, tiles and colours).
- 2026-10-31: bankC1_B000 matched: the pause screen's map set (rendered: the Info / Stats / Options tabs, periods and penalty
  boxes) as PauseScreenMap, PauseScreenTiles and PauseScreenPalette, the chunk lengths as label differences. Next org $C1CFE2.
- 2026-10-31: bankC1_C000 matched: the faceoff box's map set (rendered: 4 frames of 12 x 10, the referee dropping the puck,
  as 94S FaceOffMap) as FaceOffMap, FaceOffTiles and FaceOffPalette. Next org $C1D778.
- 2026-10-31: bankC1_D000 matched: two map sets, a pad's four buttons with tape-deck symbols (PadButtons*, not traced) and
  the playoff bracket with the Stanley Cup (PlayoffBracket*, 94S PlayoffBracketMap). Next org $C1E9B2.
- 2026-10-31: bankC1_E000 matched: the map chunk of the team name bars' map set (TeamNameBarsMap; rendered: the city names
  of the 26 teams on bars in team colours). Its tiles chunk runs on into bank $C2, so bankC1_F000 starts with it. Next
  org $C1EE6B.
- 2026-10-31: bankC1_F000 matched: TeamNameBarsTiles, the tiles chunk of the team name bars' map set; its stream runs on
  into bank $C2, where bankC2_0000 has the TeamNameBarsPalette label. Bank $C1 is all source. Next org $C20000.
- 2026-10-31: bankC2_0000 matched: the end of the team name bars' set (TeamNameBarsPalette), then the map chunk of the
  title screen's first set (TitlePlayersMap). The setup at $C4D213 loads three sets in mode 1: TitlePlayers on BG1,
  TitleGoalie on BG2, TitleLogo (2bpp: EA SPORTS presents NHL '95) on BG3. Next org $C20DE6.
- 2026-10-31: bankC2_1000 matched: TitlePlayersTiles, the tiles chunk of the title players' set, the whole of it. Next
  org $C22C8B.
- 2026-10-31: bankC2_2000 matched: TitlePlayersPalette, then TitleGoalieMap (the title screen's BG2, 64 x 20 tiles).
  Next org $C2334F.
- 2026-10-31: bankC2_3000 matched: TitleGoalieTiles' header and the start of its stream (677 tiles, 16000 bytes of LZSS
  that run on to $C271CE, where bankC2_7000 has the TitleGoaliePalette label). Next org $C24000.
- 2026-10-31: bankC2_4000 matched: the middle of TitleGoalieTiles' stream. Next org $C25000.
- 2026-10-31: bankC2_5000 matched: the middle of TitleGoalieTiles' stream. Next org $C26000.
- 2026-10-31: bankC2_6000 matched: the middle of TitleGoalieTiles' stream. Next org $C27000.
- 2026-10-31: bankC2_7000 matched: the end of the title goalie's set, then the title logo's set (2bpp: EA SPORTS presents
  NHL '95, 94S TitleLogoTiles). The packed set after it is CenterIceTiles (rendered: the 28 teams' centre ice logos; the
  game screen setup sends the home team's to VRAM); bankC2_8000 starts there. Next org $C2792B.
- 2026-10-31: bankC2_8000 matched: CenterIceTiles' header and the start of its stream (format 4, 672 tiles; the stream
  ends at $C2ADC9 in bankC2_A000). Next org $C29000.
- 2026-10-31: bankC2_9000 matched: the middle of CenterIceTiles' stream. Next org $C2A000.
- 2026-10-31: bankC2_A000 matched: the end of CenterIceTiles, CenterIcePalettes (16 colours per team, as source), and the
  Visual Concepts credit's map set (VisualConcepts*; one screen shows it with the High Score Productions credit). Next
  org $C2BB69.
- 2026-10-31: bankC2_B000 matched: the High Score Productions credit's map set (HighScore*, 6 palettes). Next org
  $C2CC6E.
- 2026-10-31: bankC2_C000 matched: the ref windows' map set (RefsMap, RefTiles: 94S names; RefPalette). The rest of the
  bank is sound samples 9-12 (the sample list's entries are 4 bytes: a long pointer and a zero). Next org $C2DF3B.
- 2026-10-31: bankC2_D000 matched: Sample09 (it ends where Sample10 starts). Next org $C2E51D.
- 2026-10-31: bankC2_E000 matched: Sample10 (it ends where Sample11 starts). Next org $C2F4AA.
- 2026-10-31: bankC2_F000 matched: Sample11, Sample12, then zeros to the end (padbyte / pad). Bank $C2 is all source.
  Next org $C30000.
- 2026-10-31: bankC3_1000 matched: player records of the team database, each a label (Player### by its PlayerList index) and a
  ROM cut, since the records hold licensed names. Bank $C3 is done records first (bankC3_1000-4000) and the tables last
  (bankC3_0000: TeamList, PlayerList), so every commit builds.
- 2026-10-31: bankC3_2000 matched: more player records (labels and ROM cuts).
- 2026-10-31: bankC3_3000 matched: the last player records, then the team records from $C337BC, labelled by city as 94S labels
  them (Anaheim ... AllStarsWest), each a ROM cut.
- 2026-10-31: bankC3_4000 matched: the last team records, a 29th record of the same form that TeamList does not point at
  (DATA8_C34427), then the game's data tables and text (high-bit letters, e.g. Period Over) as db, labelled where code reads
  them; bankC4_8000 / bankC5_6000 use those labels.
- 2026-10-31: bankC3_0000 matched: TeamList (a word per team to its record, as 94S TeamList) and PlayerList (a word per player
  to its record plus flags in bits 14-15) as source with the labels, then the first player records. The team database is all
  source now (the record bodies stay ROM cuts).
- 2026-10-31: bankC3_5000 matched: more data tables and text, and PhotoPaletteTable (a long pointer per team to its photo set,
  as 94S PhotoPaletteTable); the code reads it 1-based, so its readers use PhotoPaletteTable-4 / -2.
- 2026-10-31: bankC3_7000 matched (game code, CODE_ names). Several routines here have no jsl, jml, pointer or lda # reference
  anywhere in the ROM; their bytes are code, so they are decoded and marked no caller found. End moved to $C37FE1, bankC3_8000
  org to $C37FE2.
- 2026-10-31: bankC3_8000 matched: the rest of bank $C3's code and the data tables it reads (DATA8_ labels; bank $C4 code uses
  them now, e.g. a table of squares at DATA8_C3884A). The sound samples start after it. End moved to $C38EFD, bankC3_9000 org to
  $C38EFE.
- 2026-10-31: bankC3_9000 matched: sound samples 3 and 4 (labels and ROM cuts). The rest of bank $C3 is samples back to back
  (03, 04, 05, 28, 07, 08, 24, 25, 30, 29) to $C3FE0F, then zeros; each segment starts at a sample.
- 2026-10-31: bankC3_A000 matched: Sample05 (labels and ROM cuts).
- 2026-10-31: bankC3_B000 matched: Sample28, Sample07 (labels and ROM cuts).
- 2026-10-31: bankC3_C000 matched: Sample08, Sample24 (labels and ROM cuts).
- 2026-10-31: bankC3_D000 matched: Sample25, Sample30 (labels and ROM cuts).
- 2026-10-31: bankC3_E000 matched: the start of Sample29 (labels and ROM cuts).
- 2026-10-31: bankC3_F000 matched: the rest of Sample29, then zeros to the end of the bank (labels and ROM cuts).
- 2026-10-31: bankC6_0000 matched: frame source low words and bank/layout words. Transfer extents come from CODE_C5F368 and its
  size lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_1000 matched: parallel frame placement word tables. Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_2000 matched: frame placement words and raw frame tiles. Transfer extents come from CODE_C5F368 and its
  size lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_3000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_4000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_5000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_6000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_7000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_8000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_9000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_A000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_B000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_C000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_D000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_E000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC6_F000 matched: the last raw frame tiles and a trophy map set, rendered and traced through DATA8_C4DA55 to
  CODE_C4D99C. Map and tile LZSS sizes and ends match the chunk headers. The complete set ends at $C7053E; bankC7_0000 starts
  there. The specific trophy is not named. Bank $C6 is all source.
- 2026-10-31: bankC7_0000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_1000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_2000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_3000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_4000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_5000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_6000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_7000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_8000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_9000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_A000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_B000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_C000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_D000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_E000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC7_F000 matched: raw frame tiles; trophy map set (ends in next bank). Transfer extents come from CODE_C5F368
  and its size lookup; pointer entries use labels as targets become source. The map set after the last frame is the second
  entry of DATA8_C4DA55 (rendered: a trophy); map and tile LZSS ends match the chunk lengths. Bank $C7
  is all source.
- 2026-10-31: award pictures named. CODE_C4D963 / CODE_C4D99C index AwardNames, AwardDescs and AwardPictures with the same
  award number; the decoded title text (5-bit packed text in bank $C3, CODE_C4C3BA) names each picture: DATA8_C6FDE8 is
  VezinaPicMap, DATA8_C7FE7E SelkePicMap (95G AwardPictures names), with their Tiles / Palette chunks. The pictures still
  in incbin banks stay numbers in AwardPictures until their segments are written.
- 2026-10-31: bankC8_0000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_1000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_2000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_3000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_4000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_5000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_6000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_7000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_8000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_9000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_A000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_B000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_C000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_D000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_E000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC8_F000 matched: raw frame tiles; ConnSmythePic, an award picture (ends in next bank). Transfer extents come
  from CODE_C5F368 and its size lookup; pointer entries use labels as targets become source. ConnSmythePic is AwardPictures entry 2; its map
  and tile LZSS ends match the chunk lengths and it runs to $C9076A. Bank $C8 is all source.
- 2026-10-31: bankC9_0000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC9_1000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC9_2000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC9_3000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC9_4000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.
- 2026-10-31: bankC9_5000 matched: raw frame tiles (poses not traced). Transfer extents come from CODE_C5F368 and its size
  lookup; pointer entries use labels as targets become source.

## ROM map

The first row that is still incbin is the current segment.

| File | Status | Org | End | Note |
|---|---|---|---|---|
| bankC0_0000 | matched 3913 bytes | $C00000 | $C00F48 | TeamPalettes, ArrowFontTiles, GradientBarTiles, MeterFontTiles (packed for the bank $C5 unpacker: size, format, ROM cut), UnusedPalette, SoundRAMClear (SPC700 source); end moved -$B7 (the sound driver's upload blocks start at $C00F49) |
| bankC0_1000 | matched 2800 bytes | $C00F49 | $C01A38 | SoundDriver (SMSG 3.07w) as `arch spc700` source: init block (.init, .dspregs, .tcallvectors, .version), main block (.mainloop, .command, .tick, .commands, .events, .bootrom, pitch and sine tables); driver internals keep auto labels (.lXXXX); org moved to $C00F49, end moved -$5C7 (a font starts at $C01A39) |
| bankC0_2000 | matched 8896 bytes | $C01A39 | $C03CF8 | BoldFontGlyphs, ItalicFontGlyphs, ThinFontGlyphs (the text routine's fonts, incbin; ThinFontGlyphs starts inside ItalicFontGlyphs' lowercase set); org moved to $C01A39, end moved +$CF9 (a packed set starts at $C03CF9) |
| bankC0_3000 | matched 2377 bytes | $C03CF9 | $C04641 | WonCheckTiles (packed), WonCheckPalette, AwayUniformPalettes / HomeUniformPalettes (94S names; one interleaved table, 64 bytes per team); org moved to $C03CF9, end moved +$642 (a packed set starts at $C04642) |
| bankC0_4000 | matched 5994 bytes | $C04642 | $C05DAB | DigitFontTiles, LinePieceTiles (packed), BG3ScrollHDMA1/2, MainScreenHDMA, BlueColours(Hook), DarkBlueColours(Hook) (code), BackdropColour, BitMaskTable (94S), PhotoPalettesTB, PlayerPhotosTB; untraced tables keep DATA8_ names; org moved to $C04642, end moved +$DAC (the Tampa Bay photos end at $C05DAB) |
| bankC0_5000 | matched 4289 bytes | $C05DAC | $C06E6C | PhotoPalettesTOR, PlayerPhotosTOR (Toronto's photo set); org moved to $C05DAC, end moved +$E6D (the set ends at $C06E6C) |
| bankC0_6000 | matched 4190 bytes | $C06E6D | $C07ECA | PhotoPalettesVAN, PlayerPhotosVAN (Vancouver's photo set); org moved to $C06E6D, end moved +$ECB (the set ends at $C07ECA) |
| bankC0_7000 | matched 309 bytes | $C07ECB | $C07FFF | TeamSongs, DefaultSongs (94S names), DATA8_C07F7B (a sound list), $CD fill (padbyte / pad) to the end of the lower half; org moved to $C07ECB |
| bankC0_8000 | matched 4101 bytes | $C08000 | $C09004 | data (SpriteObjects, TiledBackMap, DATA8_C08939, DATA8_C08B17), then the engine as in 94S: InitHooks, NullHook, NMI_Fast, NMI_HookReturn, NMI_Tick, NMI_FrameHookReturn, BCDTable, IRQ, IRQ_Fast, IRQOff, SetIRQ, Clear/SetFrameHook, Clear/SetNMIHook, WaitFrame(s), WaitDMAQueue, WaitNoButtons, JoyDirIndex, RandomWord, BlankScreen, forceblack, ScreenOn, ResetPPURegs, Mul8U/XS/S, Mul16x8U/XS/S, Mul16x8HiU; first RAM names in src/ram95s.asm; end moved +5 (Mul16x8Hi_Zero) |
| bankC0_9000 | matched 2591 bytes | $C09005 | $C09A23 | Mul16x8HiXS, Mul16x8HiS, Mul16S, Mul16XS, Mul16U, Div16S, Div32x32U, Div32S, Div32U, Div_8Bits, Div16U, Div_Overflow, Div16x8U, DivX8U, DivX8S (94S); then game code with auto names (CODE_C092B3 .. CODE_C099F4, cross references on each label); org moved to $C09005, end moved -$5DC (tables start at $C09A24) |
| bankC0_A000 | matched 7067 bytes | $C09A24 | $C0B5BE | asstab, asspuckc_postab (93S names), BitMaskTable2, untraced tables (DATA8_), then Sample19, Sample20, Sample21 (sound samples, incbin); org moved to $C09A24, end moved +$5BF (Sample21 ends at $C0B5BE) |
| bankC0_B000 | matched 3084 bytes | $C0B5BF | $C0C1CA | Sample22, Sample01 (sound samples, incbin); org moved to $C0B5BF, end moved +$1CB (the last sample ends at $C0C1CA) |
| bankC0_C000 | matched 4494 bytes | $C0C1CB | $C0D358 | Sample00 (sound samples, incbin); org moved to $C0C1CB, end moved +$359 (the last sample ends at $C0D358) |
| bankC0_D000 | matched 4716 bytes | $C0D359 | $C0E5C4 | Sample13, Sample32, Sample18 (sound samples, incbin); org moved to $C0D359, end moved +$5C5 (the last sample ends at $C0E5C4) |
| bankC0_E000 | matched 3267 bytes | $C0E5C5 | $C0F287 | Sample16, Sample17, Sample14 (sound samples, incbin); org moved to $C0E5C5, end moved +$288 (the last sample ends at $C0F287) |
| bankC0_F000 | matched 3448 bytes | $C0F288 | $C0FFFF | Sample15, Reset, NullInterrupt, NMI, BRKHandler (the vector entry points), $CD fill, ExtHeader, CartHeader, the vectors as label expressions; org moved to $C0F288 |
| bankC1_0000 | matched 4280 bytes | $C10000 | $C110B7 | SpritePalettes, DATA8_C104E0, sprite frame tiles LogoANHTiles, LogoBOSTiles, LogoBUFTiles (incbin, named by sprite and frame); end moved +$B8 |
| bankC1_1000 | matched 4196 bytes | $C110B8 | $C1211B | sprite frame tiles LogoCGYTiles, LogoCHITiles, LogoDALTiles, LogoDETTiles ... LogoEDMTiles (incbin, named by sprite and frame); org moved to $C110B8, end moved +$11C |
| bankC1_2000 | matched 4022 bytes | $C1211C | $C130D1 | sprite frame tiles LogoFLATiles, LogoHFDTiles, LogoLATiles, LogoMTLTiles ... LogoNJTiles (incbin, named by sprite and frame); org moved to $C1211C, end moved +$D2 |
| bankC1_3000 | matched 4005 bytes | $C130D2 | $C14076 | sprite frame tiles LogoNYITiles, LogoNYRTiles, LogoOTWTiles, LogoPHITiles ... LogoPITTiles (incbin, named by sprite and frame); org moved to $C130D2, end moved +$77 |
| bankC1_4000 | matched 4554 bytes | $C14077 | $C15240 | sprite frame tiles LogoQUETiles, LogoSJTiles, LogoSTLTiles, LogoTBTiles ... LogoVANTiles (incbin, named by sprite and frame); org moved to $C14077, end moved +$241 |
| bankC1_5000 | matched 3619 bytes | $C15241 | $C16063 | sprite frame tiles LogoWSHTiles, LogoWPGTiles, LogoASETiles, LogoASWTiles ... Sprite28Tiles02 (incbin, named by sprite and frame); org moved to $C15241, end moved +$64 |
| bankC1_6000 | matched 4308 bytes | $C16064 | $C17137 | sprite frame tiles Sprite28Tiles03, Sprite28Tiles04, Sprite28Tiles05, Sprite28Tiles06 ... SkaterTiles01 (incbin, named by sprite and frame); org moved to $C16064, end moved +$138 |
| bankC1_7000 | matched 3836 bytes | $C17138 | $C18033 | sprite frame tiles SkaterTiles02, SkaterTiles03, SkaterTiles04, SkaterTiles05 ... EASportsTiles (incbin, named by sprite and frame); org moved to $C17138, end moved +$34 |
| bankC1_8000 | matched 4176 bytes | $C18034 | $C19083 | sprite frame tiles EALogoETiles, EALogoATiles, SportsWordTiles, ElectronicWordTiles ... BlackBoxTiles (incbin, named by sprite and frame); org moved to $C18034, end moved +$84 |
| bankC1_9000 | matched 2788 bytes | $C19084 | $C19B67 | sprite frame tiles NHLShieldTiles, NHLPATiles and SpritePieces (incbin, named by sprite and frame); org moved to $C19084, end moved -$498 |
| bankC1_A000 | matched 7881 bytes | $C19B68 | $C1BA30 | TeamNicknameTiles (packed format 0, incbin after its header); org moved to $C19B68, end moved +$A31 |
| bankC1_B000 | matched 5553 bytes | $C1BA31 | $C1CFE1 | PauseScreenMap, PauseScreenTiles, PauseScreenPalette (a map set: headers and colours as source, the LZSS streams incbin); org moved to $C1BA31, end moved +$FE2 |
| bankC1_C000 | matched 1942 bytes | $C1CFE2 | $C1D777 | FaceOffMap, FaceOffTiles, FaceOffPalette (a map set: headers and colours as source, the LZSS streams incbin); org moved to $C1CFE2, end moved +$778 |
| bankC1_D000 | matched 4666 bytes | $C1D778 | $C1E9B1 | PadButtonsMap/Tiles/Palette, PlayoffBracketMap/Tiles/Palette (map sets: headers and colours as source, the LZSS streams incbin); org moved to $C1D778, end moved +$9B2 |
| bankC1_E000 | matched 1209 bytes | $C1E9B2 | $C1EE6A | TeamNameBarsMap (the map chunk of a map set: header as source, the LZSS stream incbin); org moved to $C1E9B2, end moved -$195 |
| bankC1_F000 | matched 4501 bytes | $C1EE6B | $C1FFFF | TeamNameBarsTiles (the tiles chunk of a map set: header as source, the LZSS stream incbin, it runs on into bank $C2); org moved to $C1EE6B |
| bankC2_0000 | matched 3558 bytes | $C20000 | $C20DE5 | the rest of TeamNameBarsTiles' stream, TeamNameBarsPalette, TitlePlayersMap (map set chunks: headers and colours as source, the LZSS streams incbin); end moved -$21A |
| bankC2_1000 | matched 7845 bytes | $C20DE6 | $C22C8A | TitlePlayersTiles (the tiles chunk of a map set: header as source, the LZSS stream incbin); org moved to $C20DE6, end moved +$C8B |
| bankC2_2000 | matched 1732 bytes | $C22C8B | $C2334E | TitlePlayersPalette, TitleGoalieMap (map set chunks: headers and colours as source, the LZSS stream incbin); org moved to $C22C8B, end moved +$34F |
| bankC2_3000 | matched 3249 bytes | $C2334F | $C23FFF | TitleGoalieTiles (the tiles chunk of a map set: header as source, the start of the LZSS stream incbin); org moved to $C2334F |
| bankC2_4000 | matched 4096 bytes | $C24000 | $C24FFF | the middle of TitleGoalieTiles' LZSS stream (incbin) |
| bankC2_5000 | matched 4096 bytes | $C25000 | $C25FFF | the middle of TitleGoalieTiles' LZSS stream (incbin) |
| bankC2_6000 | matched 4096 bytes | $C26000 | $C26FFF | the middle of TitleGoalieTiles' LZSS stream (incbin) |
| bankC2_7000 | matched 2347 bytes | $C27000 | $C2792A | the rest of TitleGoalieTiles' stream, TitleGoaliePalette, TitleLogoMap/Tiles/Palette (map set chunks: headers and colours as source, the LZSS streams incbin); end moved -$6D5 |
| bankC2_8000 | matched 5845 bytes | $C2792B | $C28FFF | CenterIceTiles (packed format 4: header as source, the start of the stream incbin); org moved to $C2792B |
| bankC2_9000 | matched 4096 bytes | $C29000 | $C29FFF | the middle of CenterIceTiles' stream (incbin) |
| bankC2_A000 | matched 7017 bytes | $C2A000 | $C2BB68 | the rest of CenterIceTiles' stream, CenterIcePalettes (source), VisualConceptsMap/Tiles/Palette (a map set: headers and colours as source, the LZSS streams incbin); end moved +$B69 |
| bankC2_B000 | matched 4357 bytes | $C2BB69 | $C2CC6D | HighScoreMap/Tiles/Palette (a map set: headers and colours as source, the LZSS streams incbin); org moved to $C2BB69, end moved +$C6E |
| bankC2_C000 | matched 4813 bytes | $C2CC6E | $C2DF3A | RefsMap, RefTiles, RefPalette (a map set: headers and colours as source, the LZSS streams incbin); org moved to $C2CC6E, end moved +$F3B |
| bankC2_D000 | matched 1506 bytes | $C2DF3B | $C2E51C | Sample09 (incbin); org moved to $C2DF3B, end moved +$51D |
| bankC2_E000 | matched 3981 bytes | $C2E51D | $C2F4A9 | Sample10 (incbin); org moved to $C2E51D, end moved +$4AA |
| bankC2_F000 | matched 2902 bytes | $C2F4AA | $C2FFFF | Sample11, Sample12 (incbin), the zero fill (padbyte / pad); org moved to $C2F4AA |
| bankC3_0000 | matched 4103 bytes | $C30000 | $C31006 | TeamList (94S name; words to the team records), PlayerList (words to the player records, flags in bits 14-15), the first player records (labels and ROM cuts); written last in the bank so the labels exist; end moved +$7 |
| bankC3_1000 | matched 4090 bytes | $C31007 | $C32000 | player records (218: Player101 ... Player318, by PlayerList index), labels and ROM cuts (the names are licensed); out of ROM order inside the bank: PlayerList in bankC3_0000 needs these labels first; org moved to $C31007, end moved +$1 |
| bankC3_2000 | matched 4103 bytes | $C32001 | $C33007 | player records (219: Player319 ... Player537, by PlayerList index), labels and ROM cuts (the names are licensed); out of ROM order inside the bank; org moved to $C32001, end moved +$8 |
| bankC3_3000 | matched 4132 bytes | $C33008 | $C3402B | the last player records (106), then team records AllStarsEast ... Washington (labels by city, as 94S, and ROM cuts: the names are licensed); out of ROM order inside the bank; org moved to $C33008, end moved +$2C |
| bankC3_4000 | matched 4052 bytes | $C3402C | $C34FFF | the last team records Pittsburgh ... Washington (labels by city, ROM cuts), a team record not in TeamList (DATA8_C34427), then data tables and text (db, DATA8_ labels where code reads them); out of ROM order inside the bank; org moved to $C3402C |
| bankC3_5000 | matched 4096 bytes | $C35000 | $C35FFF | data tables and text (db, DATA8_ labels where code reads them), PhotoPaletteTable (dd per team, 94S name) |
| bankC3_6000 | matched 4082 bytes | $C36000 | $C36FF1 | data tables (db, DATA8_ labels where code reads them) to $C36B82, then game code with CODE_ names and their callers; out of ROM order, end moved -$E |
| bankC3_7000 | matched 4080 bytes | $C36FF2 | $C37FE1 | game code with CODE_ names and their callers; routines with no reference anywhere are decoded and say so; out of ROM order, org moved to $C36FF2, end moved -$1E |
| bankC3_8000 | matched 3868 bytes | $C37FE2 | $C38EFD | the rest of the game code with CODE_ names and their callers, data tables read with long addresses (a squares table, ...); out of ROM order, org moved to $C37FE2, end moved -$102 |
| bankC3_9000 | matched 7467 bytes | $C38EFE | $C3AC28 | Sample03, Sample04 (labels and ROM cuts); org moved to the sample start; org moved to $C38EFE, end moved +$C29 |
| bankC3_A000 | matched 2379 bytes | $C3AC29 | $C3B573 | Sample05 (labels and ROM cuts); org moved to $C3AC29, end moved +$574 |
| bankC3_B000 | matched 4506 bytes | $C3B574 | $C3C70D | Sample28, Sample07 (labels and ROM cuts); org moved to $C3B574, end moved +$70E |
| bankC3_C000 | matched 3615 bytes | $C3C70E | $C3D52C | Sample08, Sample24 (labels and ROM cuts); org moved to $C3C70E, end moved +$52D |
| bankC3_D000 | matched 4866 bytes | $C3D52D | $C3E82E | Sample25, Sample30 (labels and ROM cuts); org moved to $C3D52D, end moved +$82F |
| bankC3_E000 | matched 2001 bytes | $C3E82F | $C3EFFF | the start of Sample29 (labels and ROM cuts); org moved to $C3E82F |
| bankC3_F000 | matched 4096 bytes | $C3F000 | $C3FFFF | the rest of Sample29, then zeros to the end of the bank (labels and ROM cuts) |
| bankC4_0000 | matched 4102 bytes | $C40000 | $C41005 | game code with CODE_ names and their callers, jump tables DATA8_C400FE / C40130, then data tables (DATA8_ with their readers); out of ROM order, end moved +$6 |
| bankC4_1000 | matched 4138 bytes | $C41006 | $C4202F | data tables (not traced), DATA8_ labels where code reads them with long addresses; from DATA8_C41E48 they look like animation lists (word pointers per direction to frame / value pairs); out of ROM order, org moved to $C41006, end moved +$30 |
| bankC4_2000 | matched 4366 bytes | $C42030 | $C4313D | more data tables (not traced), then game code with CODE_ names: asstab routines, one routine passed as a long pointer (lda #bank / #low) to the routine at $C45950; out of ROM order, org moved to $C42030, end moved +$13E |
| bankC4_3000 | matched 3722 bytes | $C4313E | $C43FC7 | game code with CODE_ names and their callers, asstab routines, a routine passed as a long pointer, a table read through a long pointer; out of ROM order, org moved to $C4313E, end moved -$38 |
| bankC4_4000 | matched 3928 bytes | $C43FC8 | $C44F1F | game code with CODE_ names and their callers, tables read with long addresses (DATA8_ with their readers); out of ROM order, org moved to $C43FC8, end moved -$E0 |
| bankC4_5000 | matched 4236 bytes | $C44F20 | $C45FAB | game code with CODE_ names and their callers, jump tables DATA8_C45ACD / C45ADD / C45C7D, CODE_C45950 (takes the long routine pointers); out of ROM order, org moved to $C44F20, end moved -$54 |
| bankC4_6000 | matched 4226 bytes | $C45FAC | $C4702D | game code with CODE_ names and their callers, jump tables DATA8_C46DB0 / C46F93 (unused indexes are $0000), tables read with long addresses; out of ROM order, org moved to $C45FAC, end moved +$2E |
| bankC4_7000 | matched 3975 bytes | $C4702E | $C47FB4 | game code with CODE_ names and their callers, asstab routines; out of ROM order, org moved to $C4702E, end moved -$4B |
| bankC4_8000 | matched 4931 bytes | $C47FB5 | $C492F7 | game code with CODE_ names and their callers, rtss (asstab entry 0, 94S name), asstab routines; out of ROM order, org moved to $C47FB5, end moved +$2F8 |
| bankC4_9000 | matched 3269 bytes | $C492F8 | $C49FBC | game code with CODE_ names and their callers, asstab routines, tables read with long addresses; out of ROM order, org moved to $C492F8, end moved -$43 |
| bankC4_A000 | matched 4178 bytes | $C49FBD | $C4B00E | game code with CODE_ names and their callers, asstab routines, tables read with long addresses; out of ROM order, org moved to $C49FBD, end moved +$F |
| bankC4_B000 | matched 3896 bytes | $C4B00F | $C4BF46 | game code with CODE_ names and their callers: a task system (routine pointers in X:A, the next routine in field 2), print entry points; uncalled entries say so; out of ROM order, org moved to $C4B00F, end moved -$B9 |
| bankC4_C000 | matched 4270 bytes | $C4BF47 | $C4CFF4 | game code with CODE_ names and their callers, an rts-dispatch table DATA8_C4C07D (dw label-1), text code in 8-bit mode, a character table; out of ROM order, org moved to $C4BF47, end moved -$B |
| bankC4_D000 | matched 4065 bytes | $C4CFF5 | $C4DFD5 | game code with CODE_ names and their callers, task routines, the jump table DATA8_C4DC51, data tables; out of ROM order, org moved to $C4CFF5, end moved -$2A |
| bankC4_E000 | matched 4168 bytes | $C4DFD6 | $C4F01D | game code with CODE_ names and their callers; out of ROM order, org moved to $C4DFD6, end moved +$1E |
| bankC4_F000 | matched 4066 bytes | $C4F01E | $C4FFFF | game code with CODE_ names, Sample02 (incbin), the zero fill (padbyte / pad); out of ROM order, org moved to $C4F01E |
| bankC5_0000 | matched 4342 bytes | $C50000 | $C510F5 | Opening (the cold start Reset_Fast jumps to, 94S name), game code with CODE_ names and their callers, tables read with long addresses (DATA8_ with their readers); five small routines with no caller found are decoded and say so; out of ROM order, end moved +$F6 |
| bankC5_1000 | matched 3858 bytes | $C510F6 | $C52007 | game code with CODE_ names and their callers, asstab entry 27 (CODE_C51CC1), tables read with long addresses (DATA8_ with their readers); seven small routines with no caller found are decoded and say so; out of ROM order, org moved to $C510F6, end moved +$8 |
| bankC5_2000 | matched 4229 bytes | $C52008 | $C5308C | game code with CODE_ names and their callers, three continuations stored in a pointer that CODE_C52898 jumps back through, records between code (DATA8_), tables read with long addresses; out of ROM order, org moved to $C52008, end moved +$8D |
| bankC5_3000 | matched 3928 bytes | $C5308D | $C53FE4 | game code with CODE_ names and their callers, tables read with long addresses (DATA8_ with their readers); seven routines with no caller found are decoded and say so; out of ROM order, org moved to $C5308D, end moved -$1B |
| bankC5_4000 | matched 3872 bytes | $C53FE5 | $C54F04 | game code with CODE_ names and their callers, asstab entries 10 and 12, the jump table DATA8_C54D3A, tables read with long addresses (DATA8_ with their readers); out of ROM order, org moved to $C53FE5, end moved -$FB |
| bankC5_5000 | matched 4352 bytes | $C54F05 | $C56004 | game code with CODE_ names and their callers, seven jump tables (six picked by a menu state, DATA8_C55012-C55038; DATA8_C55D6B used by bankC5_6000), tables read with long addresses; out of ROM order, org moved to $C54F05, end moved +$5 |
| bankC5_6000 | matched 3927 bytes | $C56005 | $C56F5B | game code with CODE_ names and their callers, jump tables DATA8_C566DE / C570E8, four callbacks of CODE_C55ABC, the day and month names (text), tables read with long addresses; out of ROM order, org moved to $C56005, end moved -$A4 |
| bankC5_7000 | matched 4272 bytes | $C56F5C | $C5800B | game code with CODE_ names and their callers, jump tables DATA8_C570E8 / C57810 / C57DCD, two callbacks of CODE_C55ABC (one pushed with pea); out of ROM order, org moved to $C56F5C |
| bankC5_8000 | matched 4044 bytes | $C5800C | $C58FD7 | Reset_Fast, SetBGMapRegs, Decompress (DecompressFormats, UnpackFormat0-8), DecompressLZSS, MapSetToVRAM, QueueVRAMDMALen, DecompressToVRAM, FadeOutWait, SetupHDMA, game code (CODE_); out of ROM order; org moved to $C5800C, end moved -$28 (first boundary no branch crosses) |
| bankC5_9000 | matched 4001 bytes | $C58FD8 | $C59F78 | game code with CODE_ names and their callers, jump tables DATA8_C5967A / C59EF2 / C59EFA, untraced data; out of ROM order; org moved to $C58FD8, end moved -$87 (first boundary no branch crosses) |
| bankC5_A000 | matched 4157 bytes | $C59F79 | $C5AFB5 | game code with CODE_ names and their callers, jump tables DATA8_C5A81B / C5AC73, tables read with long addresses (DATA8_ with their readers); out of ROM order; org moved to $C59F79, end moved -$4A (first boundary no branch crosses) |
| bankC5_B000 | matched 4138 bytes | $C5AFB6 | $C5BFDF | game code with CODE_ names and their callers, jump tables DATA8_C5B56C / C5BB6C / C5BEDD, tables read with long addresses (DATA8_ with their readers), three callbacks passed to a list routine; out of ROM order, org moved to $C5AFB6, end moved -$20 |
| bankC5_C000 | matched 4141 bytes | $C5BFE0 | $C5D00C | game code with CODE_ names and their callers, the sort compare table DATA8_C5C0AE, tables read with long addresses (DATA8_ with their readers), three callbacks; out of ROM order, org moved to $C5BFE0, end moved +$D |
| bankC5_D000 | matched 3922 bytes | $C5D00D | $C5DF5E | game code with CODE_ names and their callers, three return points of indirect calls (pea label-1, then jmp through a pointer); out of ROM order, org moved to $C5D00D, end moved -$A1 |
| bankC5_E000 | matched 4370 bytes | $C5DF5F | $C5F070 | game code, then the sprite object routines CreateSprite, UploadSpriteFrame, AnimateSprites (with the script command table DATA8_C5EABA), CreateSpriteSharePal; 12 small routines with no caller found are decoded and say so; out of ROM order, org moved to $C5DF5F, end moved +$71 |
| bankC5_F000 | matched 3983 bytes | $C5F071 | $C5FFFF | UnpackStream0 (its loop runs through the bank $85 mirror and code built in the DMA registers), BuildSpriteOAM, game code with CODE_ names, the zero fill (padbyte / pad); out of ROM order, org moved to $C5F071 |
| bankC6_0000 | matched 4240 bytes | $C60000 | $C6108F | frame source low words and bank/layout words; end moved +$90 |
| bankC6_1000 | matched 4240 bytes | $C61090 | $C6211F | parallel frame placement word tables; org moved to $C61090, end moved +$120 |
| bankC6_2000 | matched 3976 bytes | $C62120 | $C630A7 | frame placement words and raw frame tiles; org moved to $C62120, end moved +$A8 |
| bankC6_3000 | matched 4224 bytes | $C630A8 | $C64127 | raw frame tiles (poses not traced); org moved to $C630A8, end moved +$128 |
| bankC6_4000 | matched 4000 bytes | $C64128 | $C650C7 | raw frame tiles (poses not traced); org moved to $C64128, end moved +$C8 |
| bankC6_5000 | matched 4288 bytes | $C650C8 | $C66187 | raw frame tiles (poses not traced); org moved to $C650C8, end moved +$188 |
| bankC6_6000 | matched 4064 bytes | $C66188 | $C67167 | raw frame tiles (poses not traced); org moved to $C66188, end moved +$168 |
| bankC6_7000 | matched 4224 bytes | $C67168 | $C681E7 | raw frame tiles (poses not traced); org moved to $C67168, end moved +$1E8 |
| bankC6_8000 | matched 3744 bytes | $C681E8 | $C69087 | raw frame tiles (poses not traced); org moved to $C681E8, end moved +$88 |
| bankC6_9000 | matched 4384 bytes | $C69088 | $C6A1A7 | raw frame tiles (poses not traced); org moved to $C69088, end moved +$1A8 |
| bankC6_A000 | matched 3936 bytes | $C6A1A8 | $C6B107 | raw frame tiles (poses not traced); org moved to $C6A1A8, end moved +$108 |
| bankC6_B000 | matched 4000 bytes | $C6B108 | $C6C0A7 | raw frame tiles (poses not traced); org moved to $C6B108, end moved +$A8 |
| bankC6_C000 | matched 4160 bytes | $C6C0A8 | $C6D0E7 | raw frame tiles (poses not traced); org moved to $C6C0A8, end moved +$E8 |
| bankC6_D000 | matched 4352 bytes | $C6D0E8 | $C6E1E7 | raw frame tiles (poses not traced); org moved to $C6D0E8, end moved +$1E8 |
| bankC6_E000 | matched 3712 bytes | $C6E1E8 | $C6F067 | raw frame tiles (poses not traced); org moved to $C6E1E8, end moved +$68 |
| bankC6_F000 | matched 5334 bytes | $C6F068 | $C7053D | raw frame tiles; trophy map set (ends in next bank) |
| bankC7_0000 | matched 2944 bytes | $C7053E | $C710BD | raw frame tiles (poses not traced); org moved to $C7053E, end moved +$BE |
| bankC7_1000 | matched 4320 bytes | $C710BE | $C7219D | raw frame tiles (poses not traced); org moved to $C710BE, end moved +$19E |
| bankC7_2000 | matched 4032 bytes | $C7219E | $C7315D | raw frame tiles (poses not traced); org moved to $C7219E, end moved +$15E |
| bankC7_3000 | matched 4320 bytes | $C7315E | $C7423D | raw frame tiles (poses not traced); org moved to $C7315E, end moved +$23E |
| bankC7_4000 | matched 3840 bytes | $C7423E | $C7513D | raw frame tiles (poses not traced); org moved to $C7423E, end moved +$13E |
| bankC7_5000 | matched 4320 bytes | $C7513E | $C7621D | raw frame tiles (poses not traced); org moved to $C7513E, end moved +$21E |
| bankC7_6000 | matched 3808 bytes | $C7621E | $C770FD | raw frame tiles (poses not traced); org moved to $C7621E, end moved +$FE |
| bankC7_7000 | matched 4128 bytes | $C770FE | $C7811D | raw frame tiles (poses not traced); org moved to $C770FE, end moved +$11E |
| bankC7_8000 | matched 4320 bytes | $C7811E | $C791FD | raw frame tiles (poses not traced); org moved to $C7811E, end moved +$1FE |
| bankC7_9000 | matched 3712 bytes | $C791FE | $C7A07D | raw frame tiles (poses not traced); org moved to $C791FE, end moved +$7E |
| bankC7_A000 | matched 4480 bytes | $C7A07E | $C7B1FD | raw frame tiles (poses not traced); org moved to $C7A07E, end moved +$1FE |
| bankC7_B000 | matched 3840 bytes | $C7B1FE | $C7C0FD | raw frame tiles (poses not traced); org moved to $C7B1FE, end moved +$FE |
| bankC7_C000 | matched 4320 bytes | $C7C0FE | $C7D1DD | raw frame tiles (poses not traced); org moved to $C7C0FE, end moved +$1DE |
| bankC7_D000 | matched 3808 bytes | $C7D1DE | $C7E0BD | raw frame tiles (poses not traced); org moved to $C7D1DE, end moved +$BE |
| bankC7_E000 | matched 4064 bytes | $C7E0BE | $C7F09D | raw frame tiles (poses not traced); org moved to $C7E0BE, end moved +$9E |
| bankC7_F000 | matched 5307 bytes | $C7F09E | $C80558 | raw frame tiles; trophy map set (ends in next bank); org moved to $C7F09E, end moved +$559 |
| bankC8_0000 | matched 3168 bytes | $C80559 | $C811B8 | raw frame tiles (poses not traced); org moved to $C80559, end moved +$1B9 |
| bankC8_1000 | matched 4224 bytes | $C811B9 | $C82238 | raw frame tiles (poses not traced); org moved to $C811B9, end moved +$239 |
| bankC8_2000 | matched 3552 bytes | $C82239 | $C83018 | raw frame tiles (poses not traced); org moved to $C82239, end moved +$19 |
| bankC8_3000 | matched 4320 bytes | $C83019 | $C840F8 | raw frame tiles (poses not traced); org moved to $C83019, end moved +$F9 |
| bankC8_4000 | matched 4224 bytes | $C840F9 | $C85178 | raw frame tiles (poses not traced); org moved to $C840F9, end moved +$179 |
| bankC8_5000 | matched 4160 bytes | $C85179 | $C861B8 | raw frame tiles (poses not traced); org moved to $C85179, end moved +$1B9 |
| bankC8_6000 | matched 3680 bytes | $C861B9 | $C87018 | raw frame tiles (poses not traced); org moved to $C861B9, end moved +$19 |
| bankC8_7000 | matched 4096 bytes | $C87019 | $C88018 | raw frame tiles (poses not traced); org moved to $C87019, end moved +$19 |
| bankC8_8000 | matched 4192 bytes | $C88019 | $C89078 | raw frame tiles (poses not traced); org moved to $C88019, end moved +$79 |
| bankC8_9000 | matched 4224 bytes | $C89079 | $C8A0F8 | raw frame tiles (poses not traced); org moved to $C89079, end moved +$F9 |
| bankC8_A000 | matched 4256 bytes | $C8A0F9 | $C8B198 | raw frame tiles (poses not traced); org moved to $C8A0F9, end moved +$199 |
| bankC8_B000 | matched 3776 bytes | $C8B199 | $C8C058 | raw frame tiles (poses not traced); org moved to $C8B199, end moved +$59 |
| bankC8_C000 | matched 4416 bytes | $C8C059 | $C8D198 | raw frame tiles (poses not traced); org moved to $C8C059, end moved +$199 |
| bankC8_D000 | matched 4000 bytes | $C8D199 | $C8E138 | raw frame tiles (poses not traced); org moved to $C8D199, end moved +$139 |
| bankC8_E000 | matched 4224 bytes | $C8E139 | $C8F1B8 | raw frame tiles (poses not traced); org moved to $C8E139, end moved +$1B9 |
| bankC8_F000 | matched 5554 bytes | $C8F1B9 | $C9076A | raw frame tiles; ConnSmythePic, an award picture (ends in next bank); org moved to $C8F1B9, end moved +$76B |
| bankC9_0000 | matched 2400 bytes | $C9076B | $C910CA | raw frame tiles (poses not traced); org moved to $C9076B, end moved +$CB |
| bankC9_1000 | matched 4256 bytes | $C910CB | $C9216A | raw frame tiles (poses not traced); org moved to $C910CB, end moved +$16B |
| bankC9_2000 | matched 3776 bytes | $C9216B | $C9302A | raw frame tiles (poses not traced); org moved to $C9216B, end moved +$2B |
| bankC9_3000 | matched 4128 bytes | $C9302B | $C9404A | raw frame tiles (poses not traced); org moved to $C9302B, end moved +$4B |
| bankC9_4000 | matched 4448 bytes | $C9404B | $C951AA | raw frame tiles (poses not traced); org moved to $C9404B, end moved +$1AB |
| bankC9_5000 | matched 4192 bytes | $C951AB | $C9620A | raw frame tiles (poses not traced); org moved to $C951AB, end moved +$20B |
| bankC9_6000 | incbin | $C9620B | $C96FFF | <- CURRENT |
| bankC9_7000 | incbin | $C97000 | $C97FFF | |
| bankC9_8000 | incbin | $C98000 | $C98FFF | |
| bankC9_9000 | incbin | $C99000 | $C99FFF | |
| bankC9_A000 | incbin | $C9A000 | $C9AFFF | |
| bankC9_B000 | incbin | $C9B000 | $C9BFFF | |
| bankC9_C000 | incbin | $C9C000 | $C9CFFF | |
| bankC9_D000 | incbin | $C9D000 | $C9DFFF | |
| bankC9_E000 | incbin | $C9E000 | $C9EFFF | |
| bankC9_F000 | incbin | $C9F000 | $C9FFFF | |
| bankCA_0000 | incbin | $CA0000 | $CA0FFF | |
| bankCA_1000 | incbin | $CA1000 | $CA1FFF | |
| bankCA_2000 | incbin | $CA2000 | $CA2FFF | |
| bankCA_3000 | incbin | $CA3000 | $CA3FFF | |
| bankCA_4000 | incbin | $CA4000 | $CA4FFF | |
| bankCA_5000 | incbin | $CA5000 | $CA5FFF | |
| bankCA_6000 | incbin | $CA6000 | $CA6FFF | |
| bankCA_7000 | incbin | $CA7000 | $CA7FFF | |
| bankCA_8000 | incbin | $CA8000 | $CA8FFF | |
| bankCA_9000 | incbin | $CA9000 | $CA9FFF | |
| bankCA_A000 | incbin | $CAA000 | $CAAFFF | |
| bankCA_B000 | incbin | $CAB000 | $CABFFF | |
| bankCA_C000 | incbin | $CAC000 | $CACFFF | |
| bankCA_D000 | incbin | $CAD000 | $CADFFF | |
| bankCA_E000 | incbin | $CAE000 | $CAEFFF | |
| bankCA_F000 | incbin | $CAF000 | $CAFFFF | |
| bankCB_0000 | incbin | $CB0000 | $CB0FFF | |
| bankCB_1000 | incbin | $CB1000 | $CB1FFF | |
| bankCB_2000 | incbin | $CB2000 | $CB2FFF | |
| bankCB_3000 | incbin | $CB3000 | $CB3FFF | |
| bankCB_4000 | incbin | $CB4000 | $CB4FFF | |
| bankCB_5000 | incbin | $CB5000 | $CB5FFF | |
| bankCB_6000 | incbin | $CB6000 | $CB6FFF | |
| bankCB_7000 | incbin | $CB7000 | $CB7FFF | |
| bankCB_8000 | incbin | $CB8000 | $CB8FFF | |
| bankCB_9000 | incbin | $CB9000 | $CB9FFF | |
| bankCB_A000 | incbin | $CBA000 | $CBAFFF | |
| bankCB_B000 | incbin | $CBB000 | $CBBFFF | |
| bankCB_C000 | incbin | $CBC000 | $CBCFFF | |
| bankCB_D000 | incbin | $CBD000 | $CBDFFF | |
| bankCB_E000 | incbin | $CBE000 | $CBEFFF | |
| bankCB_F000 | incbin | $CBF000 | $CBFFFF | |
| bankCC_0000 | incbin | $CC0000 | $CC0FFF | |
| bankCC_1000 | incbin | $CC1000 | $CC1FFF | |
| bankCC_2000 | incbin | $CC2000 | $CC2FFF | |
| bankCC_3000 | incbin | $CC3000 | $CC3FFF | |
| bankCC_4000 | incbin | $CC4000 | $CC4FFF | |
| bankCC_5000 | incbin | $CC5000 | $CC5FFF | |
| bankCC_6000 | incbin | $CC6000 | $CC6FFF | |
| bankCC_7000 | incbin | $CC7000 | $CC7FFF | |
| bankCC_8000 | incbin | $CC8000 | $CC8FFF | |
| bankCC_9000 | incbin | $CC9000 | $CC9FFF | |
| bankCC_A000 | incbin | $CCA000 | $CCAFFF | |
| bankCC_B000 | incbin | $CCB000 | $CCBFFF | |
| bankCC_C000 | incbin | $CCC000 | $CCCFFF | |
| bankCC_D000 | incbin | $CCD000 | $CCDFFF | |
| bankCC_E000 | incbin | $CCE000 | $CCEFFF | |
| bankCC_F000 | incbin | $CCF000 | $CCFFFF | |
| bankCD_0000 | incbin | $CD0000 | $CD0FFF | |
| bankCD_1000 | incbin | $CD1000 | $CD1FFF | |
| bankCD_2000 | incbin | $CD2000 | $CD2FFF | |
| bankCD_3000 | incbin | $CD3000 | $CD3FFF | |
| bankCD_4000 | incbin | $CD4000 | $CD4FFF | |
| bankCD_5000 | incbin | $CD5000 | $CD5FFF | |
| bankCD_6000 | incbin | $CD6000 | $CD6FFF | |
| bankCD_7000 | incbin | $CD7000 | $CD7FFF | |
| bankCD_8000 | incbin | $CD8000 | $CD8FFF | |
| bankCD_9000 | incbin | $CD9000 | $CD9FFF | |
| bankCD_A000 | incbin | $CDA000 | $CDAFFF | |
| bankCD_B000 | incbin | $CDB000 | $CDBFFF | |
| bankCD_C000 | incbin | $CDC000 | $CDCFFF | |
| bankCD_D000 | incbin | $CDD000 | $CDDFFF | |
| bankCD_E000 | incbin | $CDE000 | $CDEFFF | |
| bankCD_F000 | incbin | $CDF000 | $CDFFFF | |
| bankCE_0000 | incbin | $CE0000 | $CE0FFF | |
| bankCE_1000 | incbin | $CE1000 | $CE1FFF | |
| bankCE_2000 | incbin | $CE2000 | $CE2FFF | |
| bankCE_3000 | incbin | $CE3000 | $CE3FFF | |
| bankCE_4000 | incbin | $CE4000 | $CE4FFF | |
| bankCE_5000 | incbin | $CE5000 | $CE5FFF | |
| bankCE_6000 | incbin | $CE6000 | $CE6FFF | |
| bankCE_7000 | incbin | $CE7000 | $CE7FFF | |
| bankCE_8000 | incbin | $CE8000 | $CE8FFF | |
| bankCE_9000 | incbin | $CE9000 | $CE9FFF | |
| bankCE_A000 | incbin | $CEA000 | $CEAFFF | |
| bankCE_B000 | incbin | $CEB000 | $CEBFFF | |
| bankCE_C000 | incbin | $CEC000 | $CECFFF | |
| bankCE_D000 | incbin | $CED000 | $CEDFFF | |
| bankCE_E000 | incbin | $CEE000 | $CEEFFF | |
| bankCE_F000 | incbin | $CEF000 | $CEFFFF | |
| bankCF_0000 | incbin | $CF0000 | $CF0FFF | |
| bankCF_1000 | incbin | $CF1000 | $CF1FFF | |
| bankCF_2000 | incbin | $CF2000 | $CF2FFF | |
| bankCF_3000 | incbin | $CF3000 | $CF3FFF | |
| bankCF_4000 | incbin | $CF4000 | $CF4FFF | |
| bankCF_5000 | incbin | $CF5000 | $CF5FFF | |
| bankCF_6000 | incbin | $CF6000 | $CF6FFF | |
| bankCF_7000 | incbin | $CF7000 | $CF7FFF | |
| bankCF_8000 | incbin | $CF8000 | $CF8FFF | |
| bankCF_9000 | incbin | $CF9000 | $CF9FFF | |
| bankCF_A000 | incbin | $CFA000 | $CFAFFF | |
| bankCF_B000 | incbin | $CFB000 | $CFBFFF | |
| bankCF_C000 | incbin | $CFC000 | $CFCFFF | |
| bankCF_D000 | incbin | $CFD000 | $CFDFFF | |
| bankCF_E000 | incbin | $CFE000 | $CFEFFF | |
| bankCF_F000 | incbin | $CFF000 | $CFFFFF | |
