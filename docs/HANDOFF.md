# Handoff

## State (2026-10-31)

- Full build MATCH (SHA-1 `0b939f267377801d2c805b05c06a7ee6c880c5fc`, 1,048,576 bytes); `tools/verify_all.sh` MATCH (full build and
  all 256 segments built on their own from their stubs).
- Source: bankC0_0000 (data, $C00000-$C00F48: TeamPalettes, ArrowFontTiles, GradientBarTiles, MeterFontTiles, UnusedPalette,
  SoundRAMClear), bankC0_1000 ($C00F49-$C01A38: SoundDriver, SMSG 3.07w, as SPC700) and bankC0_2000 ($C01A39-$C03CF8: the
  text routine's three fonts), bankC0_3000 ($C03CF9-$C04641: WonCheckTiles, WonCheckPalette, Away/HomeUniformPalettes),
  bankC0_4000 ($C04642-$C05DAB: tile sets, HDMA tables, colour hooks, BitMaskTable, the Tampa Bay photos), bankC0_5000
  ($C05DAC-$C06E6C: the Toronto photos), bankC0_6000 ($C06E6D-$C07ECA: the Vancouver photos),
  bankC0_7000 ($C07ECB-$C07FFF: TeamSongs, DefaultSongs, a sound list, fill), bankC0_8000 ($C08000-$C09004: data, then the
  engine start: NMI, IRQ, hooks, waits, RandomWord, screen routines, multiplies), bankC0_9000 ($C09005-$C09A23: the rest of
  the math, then game code with CODE_ names), bankC0_A000 ($C09A24-$C0B5BE: asstab, asspuckc_postab, tables, Sample19-21),
  the sound samples after it to bankC0_F000 (Sample15, the vector entry points, the headers, the vectors): bank $C0 is all source.
  Bank $C6: frame source and placement tables, raw frame tiles and VezinaPic. Banks $C7-$CB: raw frame tiles, each followed
  by an award picture (SelkePic, ConnSmythePic, JenningsPic, ArtRossPic, NorrisPic). Bank $CC: raw frame tiles, then the
  rink map set (IceRinkMap, IceRinkTiles). Bank $CD: the rest of the rink set (IceRinkPalette), the player photo sets of
  WSH, WPG, ANH, BOS, BUF, CGY, CHI, DAL, DET, EDM and FLA, HartPic, then DATA8_CDF94A (a per-frame table that runs into
  bank $CE). Bank $CE: DATA8_CE0192 (the parallel per-frame table), the photo sets of HFD, LA, MTL, NJ, NYI, NYR, OTW, PHI,
  PIT, QUE, SJ and STL, PresidentsPic, the Stanley Cup map set and a zero fill. Bank $CF: the sound code, the sound table,
  SampleList, the sounds and four samples, then the frame code, its layout data and a zero fill. Every segment is source.
- Next: no segment is left (see `SEGMENT_AGENT.md`, `PROMPT.md`); what remains is naming (the Unsure list). Banks $C0-$CF are all source (the code banks $C4
  / $C5 were done before $C3, out of ROM order, approved by the project lead). Bank $C1: the sprite data, TeamNicknameTiles, the
  map sets of the pause screen, faceoff box, pad buttons, playoff bracket and team name bars. Bank $C2: the end of the team name
  bars, the title screen sets, CenterIceTiles / CenterIcePalettes, the two developer credits, the ref windows, Sample09-12. Bank
  $C3: the team database (TeamList, PlayerList, the player and team records as labels and ROM cuts, since the names are
  licensed), data tables and text, PhotoPaletteTable, game code ($C36B83-$C38EFD), then samples 03, 04, 05, 28, 07, 08, 24, 25,
  30, 29 and a zero fill. Banks $C4 / $C5: game code (CODE_ names; the seed rules are in the notes below). Bank $CF:
  the sound code and data, the frame code and its layout data. Onboarding: McMarkis.
- Sound samples: the sample list at $CF05DD (33 entries of 4 bytes: a long pointer, then a zero) gives their starts; each is a
  12-byte header, then 9-byte BRR blocks up to the one with the end flag (bit 0 of the block header). In bank $C0 (list index,
  start): 19 $C09C54, 20 $C0A2AB, 21 $C0A965, 22 $C0B5BF, 1 $C0BE7A, 0 $C0C1CB, 13 $C0D359, 32 $C0D42B, 18 $C0DE06, 16 $C0E5C5,
  17 $C0EAA2, 14 $C0EC5E, 15 $C0F288; the others are in banks $C2, $C3, $C4 and $CF.

## Notes for the next segments

- Bank $C6 frame tables: DATA8_C60000 / DATA8_C60848 are 1060 parallel low-word and bank/layout words. CODE_C5F368 uses A as
  a frame index; it queues raw ROM transfers to VRAM, without an unpacker. A layout word at $CFF27C gives two equal
  transfers of twice its low byte, followed by a transfer of its high byte (zero parts skipped). There are 759 nonzero-bank
  pointers in banks $C6-$CC, with 95 in $C6 ($C62968-$C6FDE7), 105 in $C7 ($C7053E-$C7FE7D), 116 in $C8 ($C80559-$C8FE38),
  108 in $C9 ($C9076B-$C9FFEA), 117 in $CA ($CA09D9-$CAFDF8), 112 in $CB ($CB08B5-$CBFDD4) and 106 in $CC ($CC05E5-$CCEEA4).
  Within each bank their transfer extents exactly meet the next pointer. Entries with bank zero are retained literally
  (including 0 and 1). CODE_C382B8 updates changed frame indices; CODE_C521EB and the bankC5_5000 setup also queue fixed
  frame indices. Three more word tables start at $C61090, $C618D8 and $C62120, each 1060 words, read by the bank $CF frame
  code. The code uses the first and second on its normal path, the second and third on its mirrored path.

- Code runs in banks $C0-$CF (reset `jml $C580C6`, NMI `jml $C08B45`), mostly with DB = $80. The engine is not the 94S engine: the
  unpacker, the transfer queues and the sound driver are different code, so 94S names need a purpose match, not a code match.
- Packed data: `lda #addr / ldx #bank / jsl $C581E1` unpacks to [$2C] ($C581D7 sets [$2C] = $7E:50DC first; $C58A65 unpacks a
  $1000 buffer and queues it for VRAM at Y). Header: size word, format word (0, 2, 4, 6, 8: the jump table at $C58219), stream.
  `python3 tools/unpack95.py lst/nhl95snes.sfc ADDR...` (a model of the five formats; format 8 not yet seen) gives the exact
  end and checks the size; keep the stream as a ROM cut after `dw size, format`.
- Map sets (MapSetToVRAM to VRAM and CGRAM; $C5881C / $C58812 to a WRAM buffer) are three chunks, each a length word
  (the bytes after it), so the next chunk is at chunk + length + 2: the map (width, height, flags with bit 7 packed, then an
  LZSS count word and stream), the tiles (tile count word, flags $80, the bits per pixel twice, a zero, then the LZSS count word and
  stream), the colours (palette count byte, colours per palette word, colour count word, the colours). In bank $C1 from
  $C1BA31: the pause screen (Info / Stats / Options tabs, periods, penalty boxes), the faceoff boxes (4 frames of 12 x 10, as
  94S FaceOffMap), a pad's four buttons with tape-deck symbols ($C373C7, not traced), the playoff bracket with the Stanley
  Cup (100 x 28), and the city name bars of the 26 teams (12 x 52, it ends in bank $C2 at $C20AB8).
- asstab (bankC0_A000) holds long pointers to the assignment routines: the bank $C5 ones are $C51CC1 (entry 27, source),
  $C545C7 (12) and $C5474A (10), source in bankC5_4000. 95 Genesis reorders asstab ("in a new order"),
  so the SNES entries are not named from 94S by index.
- Code pointers set with immediates (seeds for the code banks): lda #bank, sta $65 / lda #low, sta $63 then a call to
  CODE_C45950 (a routine; otherwise data read through [$63]); lda #low with ldx #bank (either order) then jsl / jmp / bra
  to SetNMIHook, SetFrameHook or the task starters CODE_C4B743 / CODE_C4B763; and lda #routine, sta $0002,x (a task's next
  routine, same bank). The pipeline writes these immediates as labels (label>>16 for the bank).
- An indexed long read from the first byte of a bank (lda.l $C30000,x, $C00000,x, $C40000,x) uses the bank as a base for
  an offset (a record, glyph or list pointer), so it stays a number even where a label sits at that address.
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
- Player photos: PhotoPaletteTable ($C35EAB, read 1-based) has a long pointer (dd) per team in team order to the team's photo set: 6 palettes of
  16 colours, then the 6 photos packed (format 2, $1B00 bytes: 48 x 48 linear 4bpp each). In bank $C0: TB at $C04CE7, TOR
  $C05DAC, VAN $C06E6D; the other 23 sets are in banks $CD-$CE.
- The engine in bank $C0 is 94S's bank $80 engine rebuilt: match routines to 94S by code (src/routines/snes there) and take
  the names; RAM names go in `src/ram95s.asm`. Hooks: SetNMIHook / SetFrameHook take X:A; the NMI calls NMIHook first, then
  FrameHook, both with M 16, X 8. Code still in incbin segments is called by number (jsl.l $C4C58B ...). Team variables: $17C9 is used as the home team and $17CB as the away team (white and dark jerseys).

- Award pictures: AwardPictures (bankC4_D000) holds a map set per award, indexed by the award number ($63); CODE_C4D963
  prints the award's name from AwardNames and CODE_C4D99C its description from AwardDescs (offsets of packed text in bank
  $C3: 5-bit codes read by CODE_C4C3BA, 0-25 letters, $1A end, $1B space, $1C case toggle, $1D-$1F a 3-bit index into
  DATA8_C4C420), then loads the picture. The order: 0 Vezina, 1 Selke, 2 Conn Smythe, 3 Jennings, 4 Hart, 5 Art Ross, 6
  Norris, 7 Presidents. Names as 95G AwardPictures (VezinaPic, ...): <Name>PicMap / Tiles / Palette. Each picture follows
  the last raw frame of its bank: VezinaPic $C6FDE8-$C7053D, SelkePic $C7FE7E-$C80558, then ConnSmythePic ($C8FE39-$C9076A),
  JenningsPic ($C9FFEB-$CA09D8), ArtRossPic ($CAFDF9-$CB08B4), NorrisPic ($CBFDD5-$CC05E4); HartPic ($CDF32B-$CDF949) and
  PresidentsPic ($CEF0AB-$CEF3E8) follow photo sets instead. The frames of bank $CC end at $CCEEA5; the rink map set follows
  (IceRinkMap, below). ../work/framesseg.py BANK J writes a raw-frame segment (and the picture in the last one), awards.py
  holds the names.
- Per-frame offsets: DATA8_CDF94A ($CDF94A, into bank $CE) and DATA8_CE0192 ($CE0192) are two more 1060-word tables
  indexed by the frame number (as DATA8_C60000). CODE_C37FE2 takes the frame from $0856,y and puts the first in $7F
  (negated when $08E0,y has bit $0800) and the second, negated, in $83. What the offsets place is not traced.
- Rink: IceRinkMap ($CCEEA5) is a three-chunk map set like the award pictures, but 32 x 170 tiles (the two rink halves,
  85 rows each), 520 tiles and 4 palettes, to $CD25DF. CODE_C52037 loads it (CODE_C58812); CODE_C55524 finds its tiles chunk.
  It is split at the tiles chunk: IceRinkMap ends bankCC_E000, bankCC_F000 is IceRinkTiles (header and stream start);
  the stream runs on through bankCD_0000 / bankCD_1000 to IceRinkPalette ($CD2559) at the end of bankCD_1000.
- Stanley Cup: StanleyCupMap / Tiles / Palette ($CEF3E9-$CEFE76, 8 x 14 tiles, 87 tiles, one palette) after
  PresidentsPic; rendered as the Stanley Cup and named as 94S StanleyCupMap / Tiles / Palette. CODE_C4DFD6 loads it
  (through CODE_C5881C). Zeros fill bank $CE after it.
- Bank $CF: the sound code ($CF0000-$CF04E2; SPCUpload as 94S, the rest CODE_ names), DATA8_CF04E3 (40 sounds: a long
  pointer and a flag byte), DATA8_CF0583 (four lists of sample records), DATA8_CF05D4, SampleList (33 long pointers as dd;
  entries 26 and 27 share Sample26), DATA8_CF0661 / DATA8_CF0663, then the sounds back to back ($CF0679-$CF95A3 and
  $CFC262-$CFC560; each a length word and its data; CODE_CF0313 sends the samples listed from +3), Sample26, Sample31,
  Sample23, Sample06, and code again from $CFEE1D. ../work/sndseg.py J writes the data segments and keeps the sound table
  and SampleList entries current. For bank $CF the whole-bank decode drops the raw jsl search of bank $C3 (all source now;
  it seeded sample bytes) and a seed with the wrong M/X at $CF0204; $CF0000,x / $CF0001,x are bank bases (3-byte records).
  The end of the bank: two jml stubs with no caller ($CFEE1D, $CFEE21), the frame code CODE_CFEE25 / CODE_CFEE6C (mirrored /
  normal; layout from DATA8_C60848+1, the record through DATA8_CFF3A2 / DATA8_CFF3A0 and the handler table DATA8_CFEEAE),
  DATA8_CFF27C (the size words CODE_C5F368 reads), the 141 layout records, CODE_CFFD9E / CODE_CFFF88 (the top layouts jump
  there through the pointer table) and zeros. The records are read as $CF0000-$CF0008,x (bank bases; numbers).
- Naming pass (94S by code): ../work/match94.py compares every call target in the bank $C3/$C4/$C5/$CF pickles (body
  flooded over branches, calls not followed) with each NHL94SNES routine (mnemonic + addressing mode, 4-gram candidates,
  difflib score); imm94.py compares their immediates. Accepted: score >= 0.95, similar length, one claimant per 94S name,
  a clear runner-up gap; small value changes (DumpInTarget $FFA4 / $FFA8, CompShoot, ClearOffsidesIfAllPlayers $5C / $58)
  are 95 tuning of the same routine. ../work/rename.py MAP renames everywhere (stubs too), re-aligns comments and adds
  name_map rows (source 94S+code; the note gives the 94S purpose). Matches below 0.95 are in ../work/match94.txt for review.
  The pairs also map RAM: 95 $1020,x = 94S pfteam, $10F5 = sflags (chkpk2), $17DB / $1813 = homelines / awaylines.
- RAM names (94S by code): ../work/rammap.py aligns each routine named after a 94S routine with its 94S source; where the
  instructions agree and the 94S operand is a RAM name (ram94s.asm, +N allowed), the 95 operand votes for it. Names with 3 or
  more votes and 90% agreement are in src/ram95s.asm (the main address when a name also lands on its +$1C puck slot);
  ../work/ramapply.py replaces exact operands in code lines ($XX direct page, $XXXX absolute, indexed and indirect). Left as
  numbers: pei (asar does not take pei (label)), jmp / jml / jsr operands, immediates, long operands, the SPC700 files, and
  addresses with fewer votes (rammap.txt has them, weak or mixed). A direct page address on a direct indexed operand
  (`lda.b $30,x`, `sta.w $0006,y`) stays a number: X / Y holds a record (a sprite object, a queue entry), so it is a field
  offset, not the variable (no vote came from an indexed form); only PadRaw1 / PadRaw2 take a pad index there.
- Local labels: ../work/locals.py turns each CODE_ label that only branches / jmps of its own routine use (no other file or
  stub names it) into a 92-style local: .loop / .loop2 for a loop head, .rtl / .rts for a lone return, else .1, .2 ... per
  routine, with a generated summary of the code after it ("if d2 >= $00E2 go to .9, call X, ..."); name_map has a row each.
  4181 labels in banks $C0 / $C3 / $C4 / $C5 / $CF. refresh_locals.py regenerates only those summaries (never the
  hand-written local labels). About 1400 CODE_ labels stay top level: entries, jump table and pointer targets, labels used
  across routines.
- Purpose names (95-only screens): ../work/textdec.py decodes the packed text (OFF... or --scan); textmap.py writes
  strings.txt (the string starts) and textrefs.txt (the strings each routine passes). Menu item lists are a count, then
  word pairs whose second word is the offset of a length-prefixed text in bank $C3 (bit 7 set on each character). The
  pause menu: tabs Info / Stats / Options / quit prompt (DATA8_C5501C ...). A routine takes a 95G or 94S name only after
  reading it against that routine (source genesis+purpose / 94S+purpose; code for names made from the code);
  ../work/purpose.py MAP renames, writes the label's comment and follows the local label rows. Named so far: the Stanley
  Cup screen and the season awards, the pause menu screens, the scouting report, the trade screens, the League Menu and
  its screens, free agents, record holders, change goalie, the controller setup. ../work/pages.py lists the text pages
  CODE_C4BB5A prints (a descriptor: margins, title, lines) with the routine that passes each: the screens' titles.
- The front end is a state machine: a screen's entry draws its page, sets the state $99 and returns; CODE_C59651 runs
  the handler of the state from DATA8_C5967A each frame. The setup screen's start runs DATA8_C58DD0 by play mode
  ($1864: Exhibition, Practice, Season, Trades, Free Agent, Release, Make Player). Not named yet: the Make Player and
  user name entry screens (CODE_C59643, CODE_C5A09B, CODE_C59768, CODE_C5D1EF), the pause screen CODE_C54E6D (94S
  splits it into Pausemode / Pausemode_menu), the season warning CODE_C59588.

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

- Banks $C6-$CC: individual frame poses and placement-table axes are not traced. Raw planar tile inspection shows player
  parts and small indicators; labels remain DATA8_ names. The null-bank frame slots are not assumed unused. The bank $CF
  frame code (CODE_CFEE25 / CODE_CFEE6C) reads them by label now, the layout through DATA8_C60848+1.

- ArrowFontTiles and MeterFontTiles are named from their rendered tiles; the screens that load them (VRAM $4A00 from $C5521E,
  VRAM $4800 from $C521EB / $C55826) are not traced, so neither is matched to a 94S font (SmallFontTiles, BigFontTiles) yet.
- GradientBarTiles: rendered bars; where they are drawn (VRAM $0640 from $C4D864, $0010 from $C59119) is not traced.
- UnusedPalette: no operand or pointer in the ROM is $0EE5; a computed address could still reach it.
- Home / away: $17C9 = home, $17CB = away is read from the jersey colours they get (white for $17C9, as 94S home), not from
  the setup code. The last pair of uniform palettes (after the all-star teams) is not traced. The team order is 94S's (the
  sprite logos render WSH before WPG).
- Sprite objects (`docs/sprite_objects.md`): SpriteObjects in bankC0_8000 is source (header, SpriteRecordList, 41 records
  <Name>Sprite, frame lists, frame headers <Name>Frame[NN], animation scripts), pointing at bank $C1: SpritePalettes, the frame
  tiles <Name>Tiles[NN] (incbin) and SpritePieces (source). The records were rendered: 0-27 the team logos in 94S team order
  (WSH before WPG, then ASE, ASW), 28 not known (an arrow, then a spinning disc), 29 a pad and 1-5, 30 a skater, then the EA
  intro pieces, a box, the NHL and NHLPA logos. Readers in bank $C5 (CreateSprite, CreateSpriteSharePal, UploadSpriteFrame and
  AnimateSprites are source in bankC5_E000): $C5E665 (create), $C5EEF3, $C5E8A5 (frame to VRAM), $C5F071 (format 0 without a
  header), $C5F0D1 (OAM), $C5E9C7 (scripts, commands at $C5EAAF).
- PadButtonsMap: a map set of a pad's four buttons with tape-deck symbols (rewind, fast forward, play); it may be the
  replay controls, but its loader ($C373C7, bank $C3) is not traced, so the name only says what it shows.
- TeamNameBarsMap: the city name bars of the 26 teams (12 x 2 tiles each) are unpacked right after the playoff bracket
  (from bank $C4), so they probably fill the bracket's slots (94S colours its slots with TeamBlockPalettes); not traced.
- CenterIceTiles: named as 94S's centre ice logos (the home team's logo on ice blue goes to VRAM in the game screen setup,
  with its colours to palette 3); where the map puts it on the rink is not traced.
- Team database (bank $C3): PlayerList's bits 14-15 (0, $4000, $8000) group like goalies, defence and forwards (63, 218,
  406 players) but the code that reads them is not traced; a player record is taken to hold a packed name and the ratings
  (not decoded); DATA8_C34427 has the form of a team record but TeamList does not point at it.
- bankC0_A000: the sample header (12 bytes: a pitch-like word, two volume-like bytes, ...) is not decoded; the samples are
  named by their index in the sample list. DATA8_C09BC4 also gets a long pointer from CODE_C09910 the way CODE_C09681 does.
- bankC0_9000: the game code keeps CODE_ names: menus and a list with pad input (CODE_C097A2), a string copy to the heap
  (CODE_C099F4). Its RAM ($1878-$18B6, $0806, $2364, ...) is not named yet. There is a brk at $C09419.
- asar: mvn / mvp take the operands in byte order, destination bank first (`mvn $7E,$C0` copies from $C0 to $7E).
- Code banks: decode by recursive descent from the jsl targets in code banks (not from raw byte scans, which give false
  entries), carry M/X through calls, size jump tables against the decoded code, and skip the 6 inline parameter bytes after
  calls to SetBGMapRegs and SetupHDMA. Several routines end in brk traps (the map unpacker's unhandled header forms).
- asar: write a branch to a label, never to a number (bcc $C090D2 assembled the low byte as the offset); pei is `pei ($nn)`.
- bankC0_8000: DATA8_C08939 and DATA8_C08B17 have no reader found. TiledBackMap is named from
  its pattern (94S MenuBackMap may be the same job: not checked). TransfersReady, DMAEnShadow, QueueBusy are named from the
  NMI code only. Mul8S's A-positive / X-negative path multiplies A by -A (tya where 94S has txa): that is in the ROM.
- bankC0_4000: DATA8_C0491A, DATA8_C04AA9, DATA8_C04CAB, DATA8_C04CB7, DATA8_C04CBF, DATA8_C04CC3 are not traced to a purpose.
  DigitFontTiles and LinePieceTiles are named from the rendered tiles; BG3ScrollHDMA1/2 from the HDMA set-up.
- WonCheckTiles / WonCheckPalette: named from the rendered tiles; the screen is not traced.
- Fonts: named from their rendered glyphs; the screens that draw with them are not traced. The meaning of flag $4000 is not
  traced.
- SoundDriver: the 32 command and 4 event handlers and the 16 tcall routines keep auto labels; naming them needs the CPU side
  (bank $CF) traced. .l0481 has no static reference (a patched call may reach it). Sound RAM buffers ($F000-$FE03, $FF00)
  stay numbers.
