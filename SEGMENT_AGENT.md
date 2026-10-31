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

bankC5_3000 (org $C5308D), code banks first (approved by the project lead, 2026-10-31); the ROM-order queue goes on at
bankC3_0000 (org $C30000) afterwards. <- CURRENT

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
| bankC3_0000 | incbin | $C30000 | $C30FFF | |
| bankC3_1000 | incbin | $C31000 | $C31FFF | |
| bankC3_2000 | incbin | $C32000 | $C32FFF | |
| bankC3_3000 | incbin | $C33000 | $C33FFF | |
| bankC3_4000 | incbin | $C34000 | $C34FFF | |
| bankC3_5000 | incbin | $C35000 | $C35FFF | |
| bankC3_6000 | incbin | $C36000 | $C36FFF | |
| bankC3_7000 | incbin | $C37000 | $C37FFF | |
| bankC3_8000 | incbin | $C38000 | $C38FFF | |
| bankC3_9000 | incbin | $C39000 | $C39FFF | |
| bankC3_A000 | incbin | $C3A000 | $C3AFFF | |
| bankC3_B000 | incbin | $C3B000 | $C3BFFF | |
| bankC3_C000 | incbin | $C3C000 | $C3CFFF | |
| bankC3_D000 | incbin | $C3D000 | $C3DFFF | |
| bankC3_E000 | incbin | $C3E000 | $C3EFFF | |
| bankC3_F000 | incbin | $C3F000 | $C3FFFF | |
| bankC4_0000 | incbin | $C40000 | $C40FFF | |
| bankC4_1000 | incbin | $C41000 | $C41FFF | |
| bankC4_2000 | incbin | $C42000 | $C42FFF | |
| bankC4_3000 | incbin | $C43000 | $C43FFF | |
| bankC4_4000 | incbin | $C44000 | $C44FFF | |
| bankC4_5000 | incbin | $C45000 | $C45FFF | |
| bankC4_6000 | incbin | $C46000 | $C46FFF | |
| bankC4_7000 | incbin | $C47000 | $C47FFF | |
| bankC4_8000 | incbin | $C48000 | $C48FFF | |
| bankC4_9000 | incbin | $C49000 | $C49FFF | |
| bankC4_A000 | incbin | $C4A000 | $C4AFFF | |
| bankC4_B000 | incbin | $C4B000 | $C4BFFF | |
| bankC4_C000 | incbin | $C4C000 | $C4CFFF | |
| bankC4_D000 | incbin | $C4D000 | $C4DFFF | |
| bankC4_E000 | incbin | $C4E000 | $C4EFFF | |
| bankC4_F000 | incbin | $C4F000 | $C4FFFF | |
| bankC5_0000 | matched 4342 bytes | $C50000 | $C510F5 | Opening (the cold start Reset_Fast jumps to, 94S name), game code with CODE_ names and their callers, tables read with long addresses (DATA8_ with their readers); five small routines with no caller found are decoded and say so; out of ROM order, end moved +$F6 |
| bankC5_1000 | matched 3858 bytes | $C510F6 | $C52007 | game code with CODE_ names and their callers, asstab entry 27 (CODE_C51CC1), tables read with long addresses (DATA8_ with their readers); seven small routines with no caller found are decoded and say so; out of ROM order, org moved to $C510F6, end moved +$8 |
| bankC5_2000 | matched 4229 bytes | $C52008 | $C5308C | game code with CODE_ names and their callers, three continuations stored in a pointer that CODE_C52898 jumps back through, records between code (DATA8_), tables read with long addresses; out of ROM order, org moved to $C52008, end moved +$8D |
| bankC5_3000 | incbin <- CURRENT | $C5308D | $C53FFF | org moved to $C5308D |
| bankC5_4000 | incbin | $C54000 | $C54FFF | |
| bankC5_5000 | incbin | $C55000 | $C55FFF | |
| bankC5_6000 | incbin | $C56000 | $C56FFF | |
| bankC5_7000 | incbin | $C57000 | $C5800B | end moved +$C (a routine ends at $C5800B) |
| bankC5_8000 | matched 4044 bytes | $C5800C | $C58FD7 | Reset_Fast, SetBGMapRegs, Decompress (DecompressFormats, UnpackFormat0-8), DecompressLZSS, MapSetToVRAM, QueueVRAMDMALen, DecompressToVRAM, FadeOutWait, SetupHDMA, game code (CODE_); out of ROM order; org moved to $C5800C, end moved -$28 (first boundary no branch crosses) |
| bankC5_9000 | matched 4001 bytes | $C58FD8 | $C59F78 | game code with CODE_ names and their callers, jump tables DATA8_C5967A / C59EF2 / C59EFA, untraced data; out of ROM order; org moved to $C58FD8, end moved -$87 (first boundary no branch crosses) |
| bankC5_A000 | matched 4157 bytes | $C59F79 | $C5AFB5 | game code with CODE_ names and their callers, jump tables DATA8_C5A81B / C5AC73, tables read with long addresses (DATA8_ with their readers); out of ROM order; org moved to $C59F79, end moved -$4A (first boundary no branch crosses) |
| bankC5_B000 | matched 4138 bytes | $C5AFB6 | $C5BFDF | game code with CODE_ names and their callers, jump tables DATA8_C5B56C / C5BB6C / C5BEDD, tables read with long addresses (DATA8_ with their readers), three callbacks passed to a list routine; out of ROM order, org moved to $C5AFB6, end moved -$20 |
| bankC5_C000 | matched 4141 bytes | $C5BFE0 | $C5D00C | game code with CODE_ names and their callers, the sort compare table DATA8_C5C0AE, tables read with long addresses (DATA8_ with their readers), three callbacks; out of ROM order, org moved to $C5BFE0, end moved +$D |
| bankC5_D000 | matched 3922 bytes | $C5D00D | $C5DF5E | game code with CODE_ names and their callers, three return points of indirect calls (pea label-1, then jmp through a pointer); out of ROM order, org moved to $C5D00D, end moved -$A1 |
| bankC5_E000 | matched 4370 bytes | $C5DF5F | $C5F070 | game code, then the sprite object routines CreateSprite, UploadSpriteFrame, AnimateSprites (with the script command table DATA8_C5EABA), CreateSpriteSharePal; 12 small routines with no caller found are decoded and say so; out of ROM order, org moved to $C5DF5F, end moved +$71 |
| bankC5_F000 | matched 3983 bytes | $C5F071 | $C5FFFF | UnpackStream0 (its loop runs through the bank $85 mirror and code built in the DMA registers), BuildSpriteOAM, game code with CODE_ names, the zero fill (padbyte / pad); out of ROM order, org moved to $C5F071 |
| bankC6_0000 | incbin | $C60000 | $C60FFF | |
| bankC6_1000 | incbin | $C61000 | $C61FFF | |
| bankC6_2000 | incbin | $C62000 | $C62FFF | |
| bankC6_3000 | incbin | $C63000 | $C63FFF | |
| bankC6_4000 | incbin | $C64000 | $C64FFF | |
| bankC6_5000 | incbin | $C65000 | $C65FFF | |
| bankC6_6000 | incbin | $C66000 | $C66FFF | |
| bankC6_7000 | incbin | $C67000 | $C67FFF | |
| bankC6_8000 | incbin | $C68000 | $C68FFF | |
| bankC6_9000 | incbin | $C69000 | $C69FFF | |
| bankC6_A000 | incbin | $C6A000 | $C6AFFF | |
| bankC6_B000 | incbin | $C6B000 | $C6BFFF | |
| bankC6_C000 | incbin | $C6C000 | $C6CFFF | |
| bankC6_D000 | incbin | $C6D000 | $C6DFFF | |
| bankC6_E000 | incbin | $C6E000 | $C6EFFF | |
| bankC6_F000 | incbin | $C6F000 | $C6FFFF | |
| bankC7_0000 | incbin | $C70000 | $C70FFF | |
| bankC7_1000 | incbin | $C71000 | $C71FFF | |
| bankC7_2000 | incbin | $C72000 | $C72FFF | |
| bankC7_3000 | incbin | $C73000 | $C73FFF | |
| bankC7_4000 | incbin | $C74000 | $C74FFF | |
| bankC7_5000 | incbin | $C75000 | $C75FFF | |
| bankC7_6000 | incbin | $C76000 | $C76FFF | |
| bankC7_7000 | incbin | $C77000 | $C77FFF | |
| bankC7_8000 | incbin | $C78000 | $C78FFF | |
| bankC7_9000 | incbin | $C79000 | $C79FFF | |
| bankC7_A000 | incbin | $C7A000 | $C7AFFF | |
| bankC7_B000 | incbin | $C7B000 | $C7BFFF | |
| bankC7_C000 | incbin | $C7C000 | $C7CFFF | |
| bankC7_D000 | incbin | $C7D000 | $C7DFFF | |
| bankC7_E000 | incbin | $C7E000 | $C7EFFF | |
| bankC7_F000 | incbin | $C7F000 | $C7FFFF | |
| bankC8_0000 | incbin | $C80000 | $C80FFF | |
| bankC8_1000 | incbin | $C81000 | $C81FFF | |
| bankC8_2000 | incbin | $C82000 | $C82FFF | |
| bankC8_3000 | incbin | $C83000 | $C83FFF | |
| bankC8_4000 | incbin | $C84000 | $C84FFF | |
| bankC8_5000 | incbin | $C85000 | $C85FFF | |
| bankC8_6000 | incbin | $C86000 | $C86FFF | |
| bankC8_7000 | incbin | $C87000 | $C87FFF | |
| bankC8_8000 | incbin | $C88000 | $C88FFF | |
| bankC8_9000 | incbin | $C89000 | $C89FFF | |
| bankC8_A000 | incbin | $C8A000 | $C8AFFF | |
| bankC8_B000 | incbin | $C8B000 | $C8BFFF | |
| bankC8_C000 | incbin | $C8C000 | $C8CFFF | |
| bankC8_D000 | incbin | $C8D000 | $C8DFFF | |
| bankC8_E000 | incbin | $C8E000 | $C8EFFF | |
| bankC8_F000 | incbin | $C8F000 | $C8FFFF | |
| bankC9_0000 | incbin | $C90000 | $C90FFF | |
| bankC9_1000 | incbin | $C91000 | $C91FFF | |
| bankC9_2000 | incbin | $C92000 | $C92FFF | |
| bankC9_3000 | incbin | $C93000 | $C93FFF | |
| bankC9_4000 | incbin | $C94000 | $C94FFF | |
| bankC9_5000 | incbin | $C95000 | $C95FFF | |
| bankC9_6000 | incbin | $C96000 | $C96FFF | |
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
