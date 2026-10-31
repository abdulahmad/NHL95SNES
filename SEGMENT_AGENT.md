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

bankC0_3000 (org $C03CF9). <- CURRENT

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

## ROM map

The first row that is still incbin is the current segment.

| File | Status | Org | End | Note |
|---|---|---|---|---|
| bankC0_0000 | matched 3913 bytes | $C00000 | $C00F48 | TeamPalettes, ArrowFontTiles, GradientBarTiles, MeterFontTiles (packed for the bank $C5 unpacker: size, format, ROM cut), UnusedPalette, SoundRAMClear (SPC700 source); end moved -$B7 (the sound driver's upload blocks start at $C00F49) |
| bankC0_1000 | matched 2800 bytes | $C00F49 | $C01A38 | SoundDriver (SMSG 3.07w) as `arch spc700` source: init block (.init, .dspregs, .tcallvectors, .version), main block (.mainloop, .command, .tick, .commands, .events, .bootrom, pitch and sine tables); driver internals keep auto labels (.lXXXX); org moved to $C00F49, end moved -$5C7 (a font starts at $C01A39) |
| bankC0_2000 | matched 8896 bytes | $C01A39 | $C03CF8 | BoldFontGlyphs, ItalicFontGlyphs, ThinFontGlyphs (the text routine's fonts, incbin; ThinFontGlyphs starts inside ItalicFontGlyphs' lowercase set); org moved to $C01A39, end moved +$CF9 (a packed set starts at $C03CF9) |
| bankC0_3000 | incbin <- CURRENT | $C03CF9 | $C03FFF | org moved to $C03CF9: starts with a packed set (size $0600, format 2) that $C5ACBE unpacks |
| bankC0_4000 | incbin | $C04000 | $C04FFF | |
| bankC0_5000 | incbin | $C05000 | $C05FFF | |
| bankC0_6000 | incbin | $C06000 | $C06FFF | |
| bankC0_7000 | incbin | $C07000 | $C07FFF | |
| bankC0_8000 | incbin | $C08000 | $C08FFF | |
| bankC0_9000 | incbin | $C09000 | $C09FFF | |
| bankC0_A000 | incbin | $C0A000 | $C0AFFF | |
| bankC0_B000 | incbin | $C0B000 | $C0BFFF | |
| bankC0_C000 | incbin | $C0C000 | $C0CFFF | |
| bankC0_D000 | incbin | $C0D000 | $C0DFFF | |
| bankC0_E000 | incbin | $C0E000 | $C0EFFF | |
| bankC0_F000 | incbin (cartridge header is source) | $C0F000 | $C0FFFF | |
| bankC1_0000 | incbin | $C10000 | $C10FFF | |
| bankC1_1000 | incbin | $C11000 | $C11FFF | |
| bankC1_2000 | incbin | $C12000 | $C12FFF | |
| bankC1_3000 | incbin | $C13000 | $C13FFF | |
| bankC1_4000 | incbin | $C14000 | $C14FFF | |
| bankC1_5000 | incbin | $C15000 | $C15FFF | |
| bankC1_6000 | incbin | $C16000 | $C16FFF | |
| bankC1_7000 | incbin | $C17000 | $C17FFF | |
| bankC1_8000 | incbin | $C18000 | $C18FFF | |
| bankC1_9000 | incbin | $C19000 | $C19FFF | |
| bankC1_A000 | incbin | $C1A000 | $C1AFFF | |
| bankC1_B000 | incbin | $C1B000 | $C1BFFF | |
| bankC1_C000 | incbin | $C1C000 | $C1CFFF | |
| bankC1_D000 | incbin | $C1D000 | $C1DFFF | |
| bankC1_E000 | incbin | $C1E000 | $C1EFFF | |
| bankC1_F000 | incbin | $C1F000 | $C1FFFF | |
| bankC2_0000 | incbin | $C20000 | $C20FFF | |
| bankC2_1000 | incbin | $C21000 | $C21FFF | |
| bankC2_2000 | incbin | $C22000 | $C22FFF | |
| bankC2_3000 | incbin | $C23000 | $C23FFF | |
| bankC2_4000 | incbin | $C24000 | $C24FFF | |
| bankC2_5000 | incbin | $C25000 | $C25FFF | |
| bankC2_6000 | incbin | $C26000 | $C26FFF | |
| bankC2_7000 | incbin | $C27000 | $C27FFF | |
| bankC2_8000 | incbin | $C28000 | $C28FFF | |
| bankC2_9000 | incbin | $C29000 | $C29FFF | |
| bankC2_A000 | incbin | $C2A000 | $C2AFFF | |
| bankC2_B000 | incbin | $C2B000 | $C2BFFF | |
| bankC2_C000 | incbin | $C2C000 | $C2CFFF | |
| bankC2_D000 | incbin | $C2D000 | $C2DFFF | |
| bankC2_E000 | incbin | $C2E000 | $C2EFFF | |
| bankC2_F000 | incbin | $C2F000 | $C2FFFF | |
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
| bankC5_0000 | incbin | $C50000 | $C50FFF | |
| bankC5_1000 | incbin | $C51000 | $C51FFF | |
| bankC5_2000 | incbin | $C52000 | $C52FFF | |
| bankC5_3000 | incbin | $C53000 | $C53FFF | |
| bankC5_4000 | incbin | $C54000 | $C54FFF | |
| bankC5_5000 | incbin | $C55000 | $C55FFF | |
| bankC5_6000 | incbin | $C56000 | $C56FFF | |
| bankC5_7000 | incbin | $C57000 | $C57FFF | |
| bankC5_8000 | incbin | $C58000 | $C58FFF | |
| bankC5_9000 | incbin | $C59000 | $C59FFF | |
| bankC5_A000 | incbin | $C5A000 | $C5AFFF | |
| bankC5_B000 | incbin | $C5B000 | $C5BFFF | |
| bankC5_C000 | incbin | $C5C000 | $C5CFFF | |
| bankC5_D000 | incbin | $C5D000 | $C5DFFF | |
| bankC5_E000 | incbin | $C5E000 | $C5EFFF | |
| bankC5_F000 | incbin | $C5F000 | $C5FFFF | |
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
