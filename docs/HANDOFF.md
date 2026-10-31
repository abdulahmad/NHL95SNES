# Handoff

## State (2026-10-31)

- Full build MATCH (SHA-1 `0b939f267377801d2c805b05c06a7ee6c880c5fc`, 1,048,576 bytes); `tools/verify_all.sh` MATCH (full build and
  all 256 segments built on their own from their stubs).
- Source: bankC0_0000 (data, $C00000-$C00F48: TeamPalettes, ArrowFontTiles, GradientBarTiles, MeterFontTiles, UnusedPalette,
  SoundRAMClear), bankC0_1000 ($C00F49-$C01A38: SoundDriver, SMSG 3.07w, as SPC700) and bankC0_2000 ($C01A39-$C03CF8: the
  text routine's three fonts), bankC0_3000 ($C03CF9-$C04641: WonCheckTiles, WonCheckPalette, Away/HomeUniformPalettes),
  bankC0_4000 ($C04642-$C05DAB: tile sets, HDMA tables, colour hooks, BitMaskTable, the Tampa Bay photos), bankC0_5000
  ($C05DAC-$C06E6C: the Toronto photos), bankC0_6000 ($C06E6D-$C07ECA: the Vancouver photos),
  bankC0_7000 ($C07ECB-$C07FFF: TeamSongs, DefaultSongs, a sound list, fill). The lower half of bank $C0 is all source.
  `CartHeader` in bankC0_F000. The other segments are incbin.
- Next: segment bankC0_8000 (code: the upper half of bank $C0 holds engine code, e.g. the NMI at $C08B45 and the frame hook
  setters at $C08D59 / $C08D73) (see `SEGMENT_AGENT.md`, `PROMPT.md`). Onboarding: McMarkis.

## Notes for the next segments

- Code runs in banks $C0-$CF (reset `jml $C580C6`, NMI `jml $C08B45`), mostly with DB = $80. The engine is not the 94S engine: the
  unpacker, the transfer queues and the sound driver are different code, so 94S names need a purpose match, not a code match.
- Packed data: `lda #addr / ldx #bank / jsl $C581E1` unpacks to [$2C] ($C581D7 sets [$2C] = $7E:50DC first; $C58A65 unpacks a
  $1000 buffer and queues it for VRAM at Y). Header: size word, format word (0, 2, 4, 6, 8: the jump table at $C58219), stream.
  `python3 tools/unpack95.py lst/nhl95snes.sfc ADDR...` (a model of the five formats; format 8 not yet seen) gives the exact
  end and checks the size; keep the stream as a ROM cut after `dw size, format`.
- Transfer queues are separate stacks: $00 VRAM, $04 CGRAM (the $C4CC5x loop writes CGADD and DMAs to CGDATA). A record is
  pushed as size, destination, bank, source while $06 is decremented (busy).
- Sound: $CF001A sends SoundRAMClear ($C00F05), then the sound driver upload blocks at $C00F49 (SMSG 3.07w Jason Andersen / John
  Schappert 8/17/1994: $D8 bytes at sound RAM $1000, $0A0C bytes at $0120, start $1000) through the IPL upload routine at
  $CF004B (94S calls the same job SPCUpload). Driver protocol: command 1-$20 on port 3, arguments on ports 0-2, status on
  port 2 (bit 7 busy); commands can also be queued in spcQueue. `python3 tools/spc700dis.py lst/nhl95snes.sfc C00F49 --entry ..`
  disassembles the whole upload; the entries are the tcall vectors, .commands and .events (only 4 events; the words after them are
  code).
- Text routine $C4BE34: font address in $0C (bank $C0), flags in $0E (bit 0: 64 byte glyphs, bit 1: lowercase codes use the
  second set at glyph $2B, bit 2: another per-character table); glyph = character - '0'; per-character bytes at $C4C48B, $C4C4B6,
  $C4C4D7, $C4C502. Fonts: BoldFontGlyphs, ItalicFontGlyphs, ThinFontGlyphs.
- Player photos: the table at $C35EAB has a long pointer (dd) per team in team order to the team's photo set: 6 palettes of
  16 colours, then the 6 photos packed (format 2, $1B00 bytes: 48 x 48 linear 4bpp each). In bank $C0: TB at $C04CE7, TOR
  $C05DAC, VAN $C06E6D; the other 23 sets are in banks $CD-$CE.
- NMI frame hook: $C08D73 stores A (address) and X (bank) at $049B; the NMI at $C08B45 calls it with M 16, X 8; $C08D64 puts the
  default back. `src/inc/snes_regs.asm` (94S's) has the register names. Team variables: $17C9 is used as the home team and $17CB as the away team (white and dark jerseys).

## Setup notes

- asar 1.91 on PATH or in `tools/bin/` (`tools/setup.sh`). Python 3.
- ROM at `lst/nhl95snes.sfc` (committed for now, temporary). `Extracted/` and `output/` are generated and gitignored.
- `python3 tools/disasm65816.py lst/nhl95snes.sfc output/quickpass` is the quick-pass disassembler (NHL94SNES's, ported to HiROM).
  It starts at the vectors only; reset and NMI soon reach indirect jumps (`jml [$04AA]`) and inline-parameter calls, so add
  `--entry ADDR:M:X` for the routines you work on. It also writes `xref.txt` (every long operand into the ROM).
- Windows: `python3` must be a real Python (not the Store alias). `tools/verify_segment.sh` normalises the asar path, because
  Windows cannot start a relative program path written with forward slashes.
- `tools/check_comments.py` with no arguments checks all of src and is clean; keep it so.

## Unsure

- ArrowFontTiles and MeterFontTiles are named from their rendered tiles; the screens that load them (VRAM $4A00 from $C5521E,
  VRAM $4800 from $C521EB / $C55826) are not traced, so neither is matched to a 94S font (SmallFontTiles, BigFontTiles) yet.
- GradientBarTiles: rendered bars; where they are drawn (VRAM $0640 from $C4D864, $0010 from $C59119) is not traced.
- UnusedPalette: no operand or pointer in the ROM is $0EE5; a computed address could still reach it.
- Home / away: $17C9 = home, $17CB = away is read from the jersey colours they get (white for $17C9, as 94S home), not from
  the setup code. The last pair of uniform palettes (after the all-star teams) is not traced.
- bankC0_4000: DATA8_C0491A, DATA8_C04AA9, DATA8_C04CAB, DATA8_C04CB7, DATA8_C04CBF, DATA8_C04CC3 are not traced to a purpose.
  DigitFontTiles and LinePieceTiles are named from the rendered tiles; BG3ScrollHDMA1/2 from the HDMA set-up.
- WonCheckTiles / WonCheckPalette: named from the rendered tiles; the screen is not traced.
- Fonts: named from their rendered glyphs; the screens that draw with them are not traced. The meaning of flag $4000 is not
  traced.
- SoundDriver: the 32 command and 4 event handlers and the 16 tcall routines keep auto labels; naming them needs the CPU side
  (bank $CF) traced. .l0481 has no static reference (a patched call may reach it). Sound RAM buffers ($F000-$FE03, $FF00)
  stay numbers.
