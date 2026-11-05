# Handoff

## Now (alignment)

- Plan: the 95S alignment plan (`alignment-plan/95s_alignment_plan.md` in the Code Cleanup project files). Rules: `docs/RULES.md`.
- Stage / unit: move `src/data/tables/CreditsList.asm` → `CreditsPages.asm` (file follows the 93G label).
- Branch: `cursor/creditspages-file-399a`
- Last check: `./build.sh` MATCH; `python3 tools/check_comments.py` comment layout OK; `python3 tools/check_scope.py` scope OK (2026-11-05).
- Phase: 0 done (kit). 1 done (95S in the report on nhl-disasm-report's `claude/project-thread-ggw7zu`: segment-layout
  reader, counts `95S~95G` and `95S~94S` at 0, 699 95S known pairs then, 752 now; `tools/gate.sh` PAIRING OK). 2 done: `tools/inventory95.py`
  wrote `docs/routines95s.csv` (4,470 labels, 1,348 routines, 2,809 data runs; rules: 95G 283, family 158, 94S 95,
  callers 724, plurality 68, span 16, follows 4, UNSURE 0).
- Phase 3 done: `tools/move95.py` moved the 256 segments to `src/banks/` (16 bank files), `src/routines/` (1,348 routine
  files, folders from `docs/routines95s.csv`) and `src/data/` (1,399 files). Same 10,228 labels at the same addresses
  (symbol file compared before and after). `src/stubinc/` and `tools/verify_segment.sh` are gone; `tools/verify_all.sh`
  is now extract + full build.
- Phase 4 done (first pass): namer agents read every 95S folder against its 95G file (and the 94S folder for SNES
  jobs); `tools/rename95.py` applied the 32 renames marked sure (old names in name_map.csv `old_name`), and 67 routine
  files moved to the folder the inventory now gives them. 26 unsure matches were left alone (list: the Code Cleanup project
  file `95s-inventory/naming_pass.md`). Report pairing gate OK (752 known pairs).
- Phase 5 done: `ram95s.asm` renames padlast / padnew / tmpassatt to the 94S (93S, 94G) padlast1 / padnew1 / tmpasses,
  then the merged order (94S's order, 95G-only names after the 95G name before them, 95S-only names after the name
  before them). Matched names out of order: 1 against 94S (penshot), 0 against 95G. A wider RAM naming pass by reading
  (180 95S-only names) did not run then (rate limit); it ran in the deep dive below.
- Deep dive done: the 26 unsure matches read again against 95G and 94S (bodies and callers). 12 were the same job and are
  renamed (GetFrameHot to GetHot, NMI_Fast to VBlank, DrawDayGames to DrawGamesToday ...; 4 files moved to their 95G
  folders); 14 keep their names because no routine in 95G or 94S does the same job (list and reasons: the naming notes).
  RAM pass: of the 177 names neither 95G nor 94S has, two are the same variable as a 94S name (fadestep to fadein,
  pausepad to sfpj, now in 94S's order); the rest are Visual Concepts engine state (tasks, sprites, sound driver,
  transfer queues, the bit-packed save RAM) with no partner. DemoMode and RandomState are not demoflag and seed: 95S
  has those too, at other addresses.
- Last check: `tools/verify_all.sh` MATCH (2026-11-03).
- Phase 6 done: advisor review (opus): layout, folders and 10 renames checked against their partners, verdict done
  after its fixes (DrawPeriodStats moved from 94S's `period/` to `front/stats/`; RULES "This repo" and Learned brought
  up to date). Pairing baseline: every 95S count is 0, the floor. The all-games plan marks Stage E done.
- Next: nothing in the plan. Open, optional: the 14 kept names (reasons in the naming notes); about 38 source comments
  that name 94S to say what 95S lacks or shares (allowed by RULES, not checked by a tool). 93S and 94S `waitxsr` became
  `waitx` in their repos (2026-11-03). `docs/name_map.csv` file column repaired by address (3,949 rows, mostly local labels).
  2026-11-04: CONTRIBUTING.md rewrite (no push-to-main; live verify is `tools/verify_all.sh`, not `verify_segment.sh`).
- Unsure: none.

## Segment work: state (2026-10-31, finished)

- Full build MATCH (SHA-1 `0b939f267377801d2c805b05c06a7ee6c880c5fc`, 1,048,576 bytes); `tools/verify_all.sh` MATCH (full build and
  all 256 segments built on their own from their stubs).
- Source: bankC0_0000 (data, $C00000-$C00F48: TeamPalettes, ArrowFontTiles, GradientBarTiles, MeterFontTiles, GamePalette0,
  SoundRAMClear), bankC0_1000 ($C00F49-$C01A38: SoundDriver, SMSG 3.07w, as SPC700) and bankC0_2000 ($C01A39-$C03CF8: the
  text routine's three fonts), bankC0_3000 ($C03CF9-$C04641: WonCheckTiles, WonCheckPalette, Away/HomeUniformPalettes),
  bankC0_4000 ($C04642-$C05DAB: tile sets, HDMA tables, colour hooks, BitMaskTable, the Tampa Bay photos), bankC0_5000
  ($C05DAC-$C06E6C: the Toronto photos), bankC0_6000 ($C06E6D-$C07ECA: the Vancouver photos),
  bankC0_7000 ($C07ECB-$C07FFF: TeamSongs, DefaultSongs, a sound list, fill), bankC0_8000 ($C08000-$C09004: data, then the
  engine start: NMI, IRQ, hooks, waits, RandomWord, screen routines, multiplies), bankC0_9000 ($C09005-$C09A23: the rest of
  the math, then game code), bankC0_A000 ($C09A24-$C0B5BE: asstab, asspuckc_postab, tables, Sample19-21),
  the sound samples after it to bankC0_F000 (Sample15, the vector entry points, the headers, the vectors): bank $C0 is all source.
  Bank $C6: frame source and placement tables, raw frame tiles and VezinaPic. Banks $C7-$CB: raw frame tiles, each followed
  by an award picture (SelkePic, ConnSmythePic, JenningsPic, ArtRossPic, NorrisPic). Bank $CC: raw frame tiles, then the
  rink map set (IceRinkMap, IceRinkTiles). Bank $CD: the rest of the rink set (IceRinkPalette), the player photo sets of
  WSH, WPG, ANH, BOS, BUF, CGY, CHI, DAL, DET, EDM and FLA, HartPic, then FrameHotX (a per-frame table that runs into
  bank $CE). Bank $CE: FrameHotY (the parallel per-frame table), the photo sets of HFD, LA, MTL, NJ, NYI, NYR, OTW, PHI,
  PIT, QUE, SJ and STL, PresidentsPic, the Stanley Cup map set and a zero fill. Bank $CF: the sound code, the sound table,
  SampleList, the sounds and four samples, then the frame code, its layout data and a zero fill. Every segment is source.
- Next: no segment is left (see `SEGMENT_AGENT.md`, `PROMPT.md`); what remains is naming (the Unsure list). Banks $C0-$CF are all source (the code banks $C4
  / $C5 were done before $C3, out of ROM order, approved by the project lead). Bank $C1: the sprite data, TeamNicknameTiles, the
  map sets of the pause screen, faceoff box, pad buttons, playoff bracket and team name bars. Bank $C2: the end of the team name
  bars, the title screen sets, CenterIceTiles / CenterIcePalettes, the two developer credits, the ref windows, Sample09-12. Bank
  $C3: the team database (TeamList, PlayerList, the player and team records as labels and ROM cuts, since the names are
  licensed), data tables and text, PhotoPaletteTable, game code ($C36B83-$C38EFD), then samples 03, 04, 05, 28, 07, 08, 24, 25,
  30, 29 and a zero fill. Banks $C4 / $C5: game code (the seed rules are in the notes below). Bank $CF:
  the sound code and data, the frame code and its layout data. Onboarding: McMarkis.
- Sound samples: the sample list at $CF05DD (33 entries of 4 bytes: a long pointer, then a zero) gives their starts; each is a
  12-byte header, then 9-byte BRR blocks up to the one with the end flag (bit 0 of the block header). In bank $C0 (list index,
  start): 19 $C09C54, 20 $C0A2AB, 21 $C0A965, 22 $C0B5BF, 1 $C0BE7A, 0 $C0C1CB, 13 $C0D359, 32 $C0D42B, 18 $C0DE06, 16 $C0E5C5,
  17 $C0EAA2, 14 $C0EC5E, 15 $C0F288; the others are in banks $C2, $C3, $C4 and $CF.

## Notes for the next segments

- Bank $C6 frame tables: FrameTileSource / FrameBankLayout are 1060 parallel low-word and bank/layout words. QueueFrameTiles uses A as
  a frame index; it queues raw ROM transfers to VRAM, without an unpacker. A layout word at $CFF27C gives two equal
  transfers of twice its low byte, followed by a transfer of its high byte (zero parts skipped). There are 759 nonzero-bank
  pointers in banks $C6-$CC, with 95 in $C6 ($C62968-$C6FDE7), 105 in $C7 ($C7053E-$C7FE7D), 116 in $C8 ($C80559-$C8FE38),
  108 in $C9 ($C9076B-$C9FFEA), 117 in $CA ($CA09D9-$CAFDF8), 112 in $CB ($CB08B5-$CBFDD4) and 106 in $CC ($CC05E5-$CCEEA4).
  Within each bank their transfer extents exactly meet the next pointer. Entries with bank zero are retained literally
  (including 0 and 1). UpdateGameObjectSprites updates changed frame indices; $C521EB and the bankC5_5000 setup also queue fixed
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
  94S FaceOffMap), a pad's four buttons with tape-deck symbols (PadButtonsMap, the instant replay legend), the playoff bracket with the Stanley
  Cup (100 x 28), and the city name bars of the 26 teams (12 x 52, it ends in bank $C2 at $C20AB8).
- asstab (bankC0_A000) holds long pointers to the assignment routines in the order of 94S asstab (95 Genesis reorders
  its table, the SNES one does not); every entry is named from 94S and was checked side by side.
- Code pointers set with immediates (seeds for the code banks): lda #bank, sta $65 / lda #low, sta $63 then a call to
  skateto (a routine; otherwise data read through [$63]); lda #low with ldx #bank (either order) then jsl / jmp / bra
  to SetNMIHook, SetFrameHook or the task starters StartTasks / AddTask; and lda #routine, sta $0002,x (a task's next
  routine, same bank). The pipeline writes these immediates as labels (label>>16 for the bank). ../work/ptrpairs.py
  finds the other ldx #bank / lda #address pairs before a call (MapSetToVRAM, Decompress, MapSetToWRAM ...) and writes
  those on a label (or inside the same item, label+n) as labels; the ones past the end of PhotoPaletteTable and
  the length-prefixed tile strings for QueueVRAMDMALen after TeamCityNames' texts have no label yet and stay numbers.
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

- Award pictures: AwardPictures (bankC4_D000) holds a map set per award, indexed by the award number ($63); $C4D963
  prints the award's name from AwardNames and $C4D99C its description from AwardDescs (offsets of packed text in bank
  $C3: 5-bit codes read by UnpackText, 0-25 letters, $1A end, $1B space, $1C case toggle, $1D-$1F a 3-bit index into
  PackedTextSymbols), then loads the picture. The order: 0 Vezina, 1 Selke, 2 Conn Smythe, 3 Jennings, 4 Hart, 5 Art Ross, 6
  Norris, 7 Presidents. Names as 95G AwardPictures (VezinaPic, ...): <Name>PicMap / Tiles / Palette. Each picture follows
  the last raw frame of its bank: VezinaPic $C6FDE8-$C7053D, SelkePic $C7FE7E-$C80558, then ConnSmythePic ($C8FE39-$C9076A),
  JenningsPic ($C9FFEB-$CA09D8), ArtRossPic ($CAFDF9-$CB08B4), NorrisPic ($CBFDD5-$CC05E4); HartPic ($CDF32B-$CDF949) and
  PresidentsPic ($CEF0AB-$CEF3E8) follow photo sets instead. The frames of bank $CC end at $CCEEA5; the rink map set follows
  (IceRinkMap, below). ../work/framesseg.py BANK J writes a raw-frame segment (and the picture in the last one), awards.py
  holds the names.
- Per-frame offsets: FrameHotX ($CDF94A, into bank $CE) and FrameHotY ($CE0192) are two more 1060-word tables
  indexed by the frame number (as FrameTileSource). GetHot takes the frame from $0856,y and puts the first in $7F
  (negated when $08E0,y has bit $0800) and the second, negated, in $83: the hot spot, as 95G GetHot
  (checkpuckcoll_ccx / PuckCollisionStickRange test the stick's reach with it; pucknorm_move and skatetopuck use it).
- Rink: IceRinkMap ($CCEEA5) is a three-chunk map set like the award pictures, but 32 x 170 tiles (the two rink halves,
  85 rows each), 520 tiles and 4 palettes, to $CD25DF. setupice loads it (MapSetToUnpackbuf); $C55524 finds its tiles chunk.
  It is split at the tiles chunk: IceRinkMap ends bankCC_E000, bankCC_F000 is IceRinkTiles (header and stream start);
  the stream runs on through bankCD_0000 / bankCD_1000 to IceRinkPalette ($CD2559) at the end of bankCD_1000.
- Stanley Cup: StanleyCupMap / Tiles / Palette ($CEF3E9-$CEFE76, 8 x 14 tiles, 87 tiles, one palette) after
  PresidentsPic; rendered as the Stanley Cup and named as 94S StanleyCupMap / Tiles / Palette. StanleyCupScreen loads it
  (through MapSetToWRAM). Zeros fill bank $CE after it.
- Bank $CF: the sound code ($CF0000-$CF04E2; SPCUpload as 94S, the rest named from the code), SoundSequenceTable (40 sounds: a long
  pointer and a flag byte), SampleVolumeOverrideLists (four lists of sample records), SongLists, SampleList (33 long pointers as dd;
  entries 26 and 27 share Sample26), SampleListTailUnused / TeamSongSoundList, then the sounds back to back ($CF0679-$CF95A3 and
  $CFC262-$CFC560; each a length word and its data; LoadSequence sends the samples listed from +3), Sample26, Sample31,
  Sample23, Sample06, and code again from $CFEE1D. ../work/sndseg.py J writes the data segments and keeps the sound table
  and SampleList entries current. For bank $CF the whole-bank decode drops the raw jsl search of bank $C3 (all source now;
  it seeded sample bytes) and a seed with the wrong M/X at $CF0204; $CF0000,x / $CF0001,x are bank bases (3-byte records).
  The end of the bank: the continuations NextSortedGameObjectJump / PadTagFrameDoneJump (their addresses go in $A5), the frame code DrawFrameLayoutFlip / DrawFrameLayout (mirrored /
  normal; layout from FrameBankLayout+1, the record through LayoutPointers / $CFF3A0 and the handler table LayoutBigPieces),
  LayoutSizes (the size words QueueFrameTiles reads), the 141 layout records, GoalFrameLayout / PuckFrameLayout (the top layouts jump
  there through the pointer table) and zeros. The records are read as $CF0000-$CF0008,x (bank bases; numbers).
- Naming pass (94S by code): ../work/match94.py compares every call target in the bank $C3/$C4/$C5/$CF pickles (body
  flooded over branches, calls not followed) with each NHL94SNES routine (mnemonic + addressing mode, 4-gram candidates,
  difflib score); imm94.py compares their immediates. Accepted: score >= 0.95, similar length, one claimant per 94S name,
  a clear runner-up gap; small value changes (DumpInTarget $FFA4 / $FFA8, CompShoot, ClearOffsidesIfAllPlayers $5C / $58)
  are 95 tuning of the same routine. ../work/rename.py MAP renames everywhere (stubs too), re-aligns comments and adds
  name_map rows (source 94S+code; the note gives the 94S purpose). Matches below 0.95 are in ../work/match94.txt for review.
  The pairs also map RAM: 95 $1020,x = 94S pfteam, $10F5 = sflags (chkpk2), $17DB / $1813 = homelines / awaylines.
- RAM names (94S by code): ../work/rammap.py aligns each routine named after a 94S routine with its 94S source; where the
  instructions agree and the 94S operand is a RAM name (ram94s.asm, +N allowed: a number or a ram94s.asm name such as
  puckscnum; an older version read a name offset as +0, which had put OldYpos and puckcross on the puck slot / the
  frames word, since fixed), the 95 operand votes for it. Names with 3 or
  more votes and 90% agreement are in src/ram95s.asm (the main address when a name also lands on its +$1C puck slot);
  ../work/ramapply.py replaces exact operands in code lines ($XX direct page, $XXXX absolute, indexed and indirect). Left as
  numbers: pei (asar does not take pei (label)), jmp / jml / jsr operands, immediates, long operands, the SPC700 files, and
  addresses with fewer votes (rammap.txt has them, weak or mixed). A direct page address on a direct indexed operand
  (`lda.b $30,x`, `sta.w $0006,y`) stays a number: X / Y holds a record (a sprite object, a queue entry), so it is a field
  offset, not the variable (no vote came from an indexed form); only PadRaw1 / PadRaw2 take a pad index there.
  ../work/rammapl.py takes the votes rammap.py cannot see: 94S keeps many variables at long addresses ($7E3xxx, sta.l)
  where 95 uses absolute ones, so it pairs 94S .l operands with 95 .w ones. ../work/bracket.py checks fewer votes against
  the layout: 94S and 95 addresses of the names given so far differ by constant offsets over runs (team fields -1251 /
  -1247, per-object arrays -1315 / -1251 ...); a candidate is named when the named neighbours on both sides have its exact
  offset and its 95 uses are the routines 94S names for it.
  ../work/local94.py compares unnamed routines with 94S local subroutines (a called .label to its return): five
  were the same code (setplayer .8 = AttributeCalc ...); they take names from the code. Save RAM (bank $30): the
  season keeps its records there as bit fields; ram95s.asm has a save RAM section (95 Genesis SR* block names where
  the job matches, SeasonDay ...), written by ../work/srnames.py (long operands; offsets by longfix.py). Every save
  RAM address the traced code reads has a name now. The Practice list's two option routines,
  SaveOptHomePracPlayers / SaveOptAwayPracPlayers, save SRhomepracplayers / SRawaypracplayers.
  Code that moves the direct page (lda #$2100 / tcd, also $0100, $0300, $0400, $1E00) reads its .b operands from
  there: no RAM name on them (../work/dpmoved.py); with D = $2100 they are the PPU registers, written NAME&$FF as
  the bank $C0 engine does.
- Local labels: ../work/locals.py turns each CODE_ label that only branches / jmps of its own routine use (no other file or
  stub names it) into a 92-style local: .loop / .loop2 for a loop head, .rtl / .rts for a lone return, else .1, .2 ... per
  routine, with a generated summary of the code after it ("if d2 >= $00E2 go to .9, call X, ..."); name_map has a row each.
  4181 labels in banks $C0 / $C3 / $C4 / $C5 / $CF. refresh_locals.py regenerates only those summaries (never the
  hand-written local labels). About 1400 CODE_ labels stay top level: entries, jump table and pointer targets, labels used
  across routines.
- Purpose names (95-only screens): ../work/textdec.py decodes the packed text (OFF... or --scan); textmap.py writes
  strings.txt (the string starts) and textrefs.txt (the strings each routine passes). Menu item lists are a count, then
  word pairs whose second word is the offset of a length-prefixed text in bank $C3 (bit 7 set on each character). The
  pause menu: tabs Info / Stats / Options / quit prompt (PauseInfoJumps ...). A routine takes a 95G or 94S name only after
  reading it against that routine (source genesis+purpose / 94S+purpose; code for names made from the code);
  ../work/purpose.py MAP renames, writes the label's comment and follows the local label rows. Named so far: the Stanley
  Cup screen and the season awards, the pause menu screens, the scouting report, the trade screens, the League Menu and
  its screens, free agents, record holders, change goalie, the controller setup, create player, the user name entry,
  the game setup screen, the start-up screens (IntroSequence ... TitleScreen), the work buffer and text helpers. ../work/pages.py lists the text pages
  PrintTextPage prints (a descriptor: margins, title, lines) with the routine that passes each: the screens' titles.
- The front end is a state machine: a screen's entry draws its page, sets the state $99 and returns; ScreenStateLoop runs
  the handler of the state from ScreenStateHandlers each frame. The setup screen's start runs PlayModeStarts by play mode
  ($1864: Exhibition, Practice, Season, Trades, Free Agent, Release, Make Player). The start-up screens run a task list
  (StartTasks, AddTask, RunTasks through jmlvector, RemoveTask). The pause: Pausemode (game loop) and Intermission
  call Pausemode_menu, as in 94S. The text: Print<Font><Align>[Str] (UnpackText or CopyString, then DrawText,
  QueueTextTiles, MapTextTiles), the fonts by label; flag $4000 (Print<Font>FixedLeft ...) takes the glyph width
  from p0 (DrawNextTextCharacter: bit $0E puts bit 14 in V).
  Sound calls: QueueSoundCmd, StartSound, LoadSounds (the driver is not 94S's). Gameloop, PlayShootout, StartPer,
  StartGame_go, ReadPads match 94S; weak RAM votes are taken only where a side by side was read (../work/side.py
  ADDR NAME; bank $C0 code is read from the source). ../work/resum2.py refreshes the generated summaries after RAM names.
  SpriteAnimCommands is now traced. Bank $C3's game code is named (3 CODE_ labels left: bare rtl entries and an
  unclear helper). A 94S match below the 0.85 propagation threshold can still hold: read it side by side (FallDown,
  checkpuckcoll_ccx, SetScore were found that way; a size difference keeps the score low). Bank $C4's engine code
  is named (a Codex run, reviewed and cherry-picked: the assignment, collision, goal avoidance, penalty clock,
  goalie and text rendering helpers). A second Codex run named the front-end tasks (title, intro, credits), the
  bracket, playoff seeding, scouting text and line selection. The save reset and the saved rosters are named since
  (ClearSeasonData, InitSavedRosters, InitPlayerTeams, SetGoalieIndexes ...), as are prefmes, CheckInjury and
  ShowInjuryBox (each where 94S calls it). What is left in bank $C4 is shared tails and uncalled fragments.
  ../work/callalign.py aligns the call lists of same-named 95 / 94S routines and lists the CODE_ calls standing where
  94S calls a named routine (CheckPAL was found that way); the rest of its list is on the Unsure list.
  Layout records: a count byte, then 1-4 x / y pairs for 16 x 16 pieces; then the same for 8 x 8 pieces
  (LayoutBigPieces / LayoutSmallPieces).
  Code that follows an exit (rtl, jml) with no label and no pointer to it can be a leftover 94S routine that the
  trace never reached: ShootoutShooters (after ShootoutWonBy, labelled now) and 94S ShooterSelectList, still inline
  after PickShooterRow's rtl. Several 94S calls became bare rtl stubs that keep the 94S name (eraser, StartBenchCheer,
  InitScores, DoHiLights, printscores1 = ldx a3).
  Bank $C5: the front end's screen states 0-13 have named handlers (ScreenStateHandlers); each scrolling list's row
  routine is Draw<Screen>Row; the map set unpackers, Framer and the screen set-ups are named. bankC5_9000-C000 (the
  setup screen, Create Player, League Menu, Games Today, leaders, standings, free agents) were named by a second Claude
  thread. It left 34 labels: shared tails, loop heads, ReadTeamStatBits' unrolled shift entries. In these screens
  palette 0 marks the cell or line under the cursor and palette 3 is the normal look. The helpers are named by
  palette number (SetupLinePalette0 / 3, GridCellPalette0 / 3 ...), not "highlight". A Codex run on bankC5_3000-7000 stopped at
  its usage limit after three commits (roster and face off pads, line energy bars, pause tabs).
  Still unnamed in bank $C5: the rest of bankC5_3000 / 4000 / 5000 / 7000, the bankC5_D000 roster / trade list
  helpers, the bankC5_E000 sprite helpers (the Edit Lines screen, the season records and the playoffs are named).
  Play mode 1 is Practice (the setup strings and PlayModeStarts order: Exhibition, Practice, Season ...; 95 Genesis
  checks practice where 95S tests OptPlayMode 1). The game frame is named
  as in 94S (DoGameFrame, updateplayers, setvideo, updatescroll, PeriodOver, the face offs, SetupPenaltyShot, the line
  change box); bare rtl stubs sit where 94S calls StartBenchCheer, UpdateBenchCheer, InitScores and DoHiLights, and
  SetHor / ClrHor keep only the puck speed halving and the sfhormode count. Hand-checked RAM names go in with
  ../work/ramhand.py (fixoff.py writes $XXXX as NAME+K; relabel.py and movename.py correct a name already given).
- RAM names, second pass (584 names now, 33 of them save RAM; 51 raw operands left at 45 addresses, all buffer or
  record offsets or on the Unsure list):
  - ../work/ramsurvey.py lists the raw absolute operands by use, with the routines using them. It leaves out pea,
    hardware registers, and indexed operands below $0200 (record fields with a base pointer in X / Y).
  - neigh94.py gives the 94S symbol at the offset of the named neighbours on each side. Take it only when both sides
    agree and the uses do the 94S job (puckdist, PenSum, tmPenalties ...).
  - spell94.py writes a raw operand as NAME+K where 94S code writes that NAME+K at the matching address (Xpos+1,
    PadControlObj+2, tmap+2 ...).
  - rangefix.py NAME FROM TO writes every operand inside a named block as NAME+$K. resum2.py takes RESUM_ADDR for the
    summaries after fixoff.py / rangefix.py.
  - Before renaming a low address, check its indexed uses: $0100,y ... $0110,x were player record fields (roster
    table base in Y / X), not BandScroll, and had to be put back.
  - Code running with the data bank at $30 writes save RAM as NAME&$FFFF (InitSaveRAM, ClearSeasonData ...).
  - Shared areas have neutral names: ScratchBuf ($364E, 2 KB: DecompressLZSS's window and the screens' lists) and
    ListBuf ($3E4E). HomeRoster / VisRoster are the two LoadTeamRoster tables; their fields are written +K.
  - $7E RAM above $2000 reached only with absolute operands gets a $XXXX name in the low RAM section (TaskSlots,
    gamesstarted). A name goes in the long section ($7Exxxx / $7Fxxxx) only when code also reaches it with long
    operands (unpackbuf, rinkmapbuf, RefsMapBuf, pausesavebuf); its absolute operands then read NAME&$FFFF /
    (NAME+$K)&$FFFF (CopyRefereeFrameToVRAM runs with data bank $7F). ../work/longname.py MAP adds long names,
    longw.py NAME SIZE rewrites their operands, long2low.py moves a name that has no long uses.
  - fixoff.py takes NAME-K too (OOlist-1,y, mesarea-1,x as 94S writes them). resum2.py refreshes summaries quoting
    direct page names; comaddr.py lists hand-written comments that still quote a named address (most hits are values).
  - Left as numbers on purpose: offsets from a base in X / Y (PutClockDigit's $0700,x ... into the pause map,
    CheckGlyphLeftOverlap's glyph buffer, EditLinesScreen / PrintPositionCounts text map cells, the roster bonus fields
    $0430-$043C), and the code that moves D.
- Data tables (PR #3): ../work/datasurvey.py lists the DATA8_ labels (size, comment, references; --list FILE...).
  - 94S names by content: a table-matching script (not kept) compares each table with every labelled db / dw block of the 94S source (local
    labels split a 94S table into blocks, so sublist / priolist were compared by hand); datamap.py aligns 95 / 94S
    routine pairs (as rammap.py) for table operands. A 94S local table gets a code name from what 94S says it holds.
  - Packed text pointer tables in bank $C3: textdec.py OFF... decodes the strings (city names stay out of the source).
  - Packed texts the code prints, the setup tables and the text pages use carry Txt labels named from their words
    (txtlabels.py: TxtPlayMode, TxtNoPenalties ...); their comments quote textdec's decoding. textdec shows the
    symbol codes $3A-$40 as ASCII; from context the font draws = as a full stop, @ as a comma, ? as a colon and ;
    as an exclamation mark; > (U>D, Wins>Losses>Ties, Multi>Game) and < (win<) are not settled.
  - The decoder often put several labels inside one table (fields of records, the next entry, the next segment):
    foldlabel.py LABEL BASE K drops one (operands read BASE+K, the stub line goes, the name_map row says BASE+K);
    mergetable.py folds a run of field labels and lays the records out as dw (SortObjInitTable).
  - Tables named by index where the content is not traced: Layout000-Layout141 (LayoutPointers entry), FrameTiles002
    -FrameTiles423 (frame number), Sequence00-Sequence39 (SoundSequenceTable entry).
  - Raw pointer pairs (lda #$00BB / sta P+2, lda #$XXXX / sta P): ptrpairs2.py lists those that start a label and
    writes #LABEL>>16 / #LABEL&$FFFF (--skip / --nolabel for chance matches: a pair in the unreachable
    printscores1_per falls on RatingColumns). stubfix.py adds the outside labels a segment stub then needs.
- Frames (PR #3): ../work/framerender.py draws frames as the game does (QueueFrameTiles' three tile blocks, the
  DrawFrameLayout record and offsets, team 0's home sprite palette) and writes contact sheets (`sheet FIRST COUNT
  OUT.png`, `info N...`). spfmap.py lines the SPA lists up with 94S's and 95 Genesis's by name and direction (frame
  votes); spfgroups.py holds the SPF groups (`check`, `expr N`, `write src/frames95s.asm`); spadw.py writes SPA lists
  as dw rows; spfrows.py writes their name_map rows. Segment stubs that use SPF names include frames95s.asm.
- Parallel work: the repo is the T3 project "NHL95SNES"; a Codex thread on its own worktree branch (codex/<topic>)
  works beside the main checkout and is merged by cherry-pick (name_map.csv conflicts: keep both sides,
  ../work/resolve_namemap.py). Brief it with the rules and the tools that are safe to run (side.py only reads).
  When a picked commit's source hunks conflict with renames made here meanwhile, ../work/mergefix.py COMMIT
  [FILE=theirs] keeps one side of each hunk with every rename of both name_maps applied. Then it updates old label
  names left in comments (`python3 mergefix.py HEAD` after a clean pick does only that). Take theirs for a file where
  their side writes a new label comment.

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

- Frames: src/frames95s.asm puts the 1060 frame slots in 40 SPF groups, from the SPA lists that use them, the code
  that sets frames, the renders (framerender.py) and 95 Genesis's frame sheet, which 95 follows up to $29D. Not in a
  group: $312 and $319, the first frames of SPAflip, alone in a run where 95 Genesis has its board check frames.
  Empty slots outside the groups: $000, $059-$06E, $070-$071, $073-$07A, $18B-$1B2, $2A5-$2BC, $2F3-$329 (but $312,
  $319), $3CC-$3EB, $3FC-$41A. The less obvious groups were checked by eye on the renders: SPFPen (jumping over the
  boards into the box or onto the bench, sitting on +6), SPFcatch, SPFpump2 (a stick pump, not 95 Genesis's cup) and
  $312 / $319 as the start of the flip. The layout code frames render through GoalFrameLayout / PuckFrameLayout's
  pieces (framerender.py has both). The tile blocks
  keep their index names (FrameTiles002 ...). The bank $CF frame code (DrawFrameLayoutFlip / DrawFrameLayout) adds
  FrameOffsetX / FrameOffsetXFlip and FrameOffsetY and reads the layout through FrameBankLayout+1.

- ArrowFontTiles: InitPauseScreen -> PauseScreenDraw loads VRAM $4A00; PrintPauseItemText writes its character
  tiles into PauseMapBuf. MeterFontTiles: setupice and RestoreGameScreen load VRAM $4800 for the rink HUD;
  DrawScoreBox / DrawPeriodBox select its text and frame tiles. No one-to-one match to 94S SmallFontTiles or
  BigFontTiles established: shared use on a screen is insufficient to identify these mixed tile sets.

- GradientBarTiles: team-colour name backplates. SeasonAwards loads VRAM $0640 and maps a bar at $5245;
  award winner routines reuse it. setoptions, SetupScreen and the playoff exit load $0010; DrawSetupTeams,
  SetupStatsPage and the roster-management screens use MapTileBlock (9 x 2 tiles), while DrawGameMarks
  writes the two Games Today team bars directly. No earlier-game asset identity established.

- Home / away: the setup code confirms $17C9 = home, $17CB = away: ExhibitionOptions' "Home Team" line sets HomeTeam
  and its "Visiting Team" line VisTeam; the jerseys agree (white for HomeTeam, as 94S home). The last pair of uniform
  palettes (after the all-star teams) is not traced. The team order is 94S's (the
  sprite logos render WSH before WPG).
- Sprite objects (`docs/sprite_objects.md`): SpriteObjects in bankC0_8000 is source (header, SpriteRecordList, 41
  records <Name>Sprite, frame lists, frame headers <Name>Frame[NN], animation scripts), pointing at bank $C1:
  SpritePalettes, the frame tiles <Name>Tiles[NN] (incbin) and SpritePieces (source). The records were rendered: 0-27
  the team logos in 94S team order (WSH before WPG, then ASE, ASW), 28 small symbols (scroll arrows, a shine, a
  sparkle, the copyright and registered marks), 29 a pad and 1-5, 30 the face off box's centre, then the EA intro
  pieces, a box, the NHL and NHLPA logos. Readers in bank $C5 (CreateSprite, CreateSpriteSharePal, UploadSpriteFrame
  and AnimateSprites are source in bankC5_E000): $C5E665 (create), $C5EEF3, $C5E8A5 (frame to VRAM), $C5F071 (format 0
  without a header), $C5F0D1 (OAM), AnimateSprites (scripts, dispatched through SpriteAnimCommands). The command bytes
  $80-$9D are documented in sprite_objects.md; no record script uses $89 or $8E, whose handlers
  (SpriteAnimIncWordUnused / SpriteAnimCallUnused) treat UploadSpriteFrames code bytes as pointers. SpriteAnimDelete
  ($88) calls the RTL-returning DeleteSprite via JSR; no record script uses it. The unreached helpers are named from
  what they do with the Unused suffix (CopySpriteFrameUnused, ClearSpriteFrameUnused, CopySpriteFramesUnused,
  StartSpriteAnimUnused, FreeSpritePaletteUnused); their intended entry contracts are unverified.
- PadButtonsMap: confirmed instant replay controller legend. ReplayMode unpacks it with MapSetToWRAM,
  adjusts entries by $3E4B, then queues tiles to $44B0, map to $5821 and colours to CGRAM $70.
  Genesis ReplayMap is a replay banner; that is not evidence for renaming this four-button legend.

- TeamNameBarsMap: confirmed playoff bracket slot labels. SetupPlayoffBracket loads it; RebuildBracketTeams
  calls PopulateBracketTeams, which uses TeamBarRoundCells and CopyBracketTeamBar to copy team*48 bytes
  as two rows of 12 tiles into rinkmapbuf. QueueBracketColumn uploads the composed columns.

- CenterIceTiles: setupice and RestoreGameScreen upload HomeTeam*768 bytes to VRAM $2080. Decoded
  IceRinkMap references tiles $208-$21F as a 6 x 4 block at columns 21-26, rows 42-45 (zero-based storage
  coordinates). Entries $1A08-$1A1F select palette 6, matching CGRAM $60; the former palette 3 claim was wrong.
  setupice copies the map to rinkmapbuf and updatescroll_rows sends visible rows. The complete screen-space
  interpretation of the split rink map remains open; the existing 94S centre ice name is retained.

- Team database (bank $C3), traced through LoadSeasonRoster, roster columns and free agents:
  PlayerList low 14 bits are a byte address within bank $C3, not a word index. Bits 14-15 are
  0 goalie, $4000 defence, $8000 forward. LoadSeasonRoster counts/sorts goalies at roster +2,
  forwards at +4 and the remaining defence at +6; MarkFreeAgentLimits maps them to position
  groups 0/1/3. No individual LD/RD/LW/C/RW position byte is established in the ROM record.
  The working roster loader copies eight bytes into roster +$110 + player*32 and unpacks +8:
  - +0: binary sweater number (converted through BCDTable for display)
  - +1 high/low: weight / agility; displayed weight = 140 + 8 * weight
  - +2 high/low: speed / offensive awareness
  - +3 high/low: defensive awareness / shot power (goalie puck control)
  - +4 high: checking; bit 0: hand (0 right, 1 left); bits 1-3: fighting
  - +5 high/low: stickhandling / shot accuracy
  - +6 high/low: endurance / spodds; for goalies stick right / stick left
  - +7 high/low: pass accuracy / aggression; for goalies glove right / glove left
  - +8 onward: packed text, five-bit symbols with three-bit extensions, terminator $1A
  CalcRosterAttrib selects high nibble for even mask bit n, low for odd, at byte floor(n/2).
  Gameplay normally masks rating levels to three bits; display/overall readers take four.
  RatingNibble converts create-player values 0-15 to stored levels 0-6, not packed-name data.
  GetPlayerNamePointer and FormatPlayerNumInitial are 94S code nothing reaches (GetPlayerNumInitial, their only caller, has no
  caller); they keep 94S's length/plain-name contract: the former
  doubles the already byte-addressed entry and dereferences again. They do not establish the
  actual packed record layout. NHL94SNES GetPlayerRecord instead walks length+8 records via
  Playerdata (team offset 0); its CalcAttrib reads the trailing eight attributes. Do not apply
  that name-first layout to 95's attribute-first records. TeamRecordUnused still has no TeamList
  reference. No separate use for otherwise masked upper rating bits is established here.
- Sample headers (bankC0_A000 and the other Sample labels), traced CPU to SoundDriver:
  +0 word default DSP pitch; +2 byte left volume; +3 byte right volume; +4 byte note
  transpose; +5 signed fine tuning; +6 ADSR1; +7 ADSR2 if +6 bit 7 is set, otherwise GAIN;
  +8 word loop offset (zero stays zero; nonzero adds allocation base); +10 word BRR byte
  count; +12 starts BRR. LoadSample populates SampleParams / SampleNoteParams and
  LoadSampleEnvelopeAndData populates SampleEnvelopes / SampleDirectory. UploadSoundTables
  transfers these to the driver. SoundDriver.setDefaultSamplePitch and .setDefaultSampleVolume
  write pitch/stereo volume, .setSampleEnvelope chooses ADSR2 versus GAIN; .l0263 adds +4
  before division by 12 and uses signed +5 to adjust the note-table pitch. Sequence channels
  can instead select the default pitch. Every header byte has a reader; no unused field found.
  These are not 94S's prebuilt SPC upload blocks; no equivalent earlier field labels were found.
  Samples retain their sample-list index names. MaxSpeed also gets a long pointer from
  PrintShooterRows the way InitShooters does.
- bankC0_9000: there is a brk at $C09419 (in the ROM, not reached by the traced code).
- asar: mvn / mvp take the operands in byte order, destination bank first (`mvn $7E,$C0` copies from $C0 to $7E).
- Code banks: decode by recursive descent from the jsl targets in code banks (not from raw byte scans, which give false
  entries), carry M/X through calls, size jump tables against the decoded code, and skip the 6 inline parameter bytes after
  calls to SetBGMapRegs and SetupHDMA. Several routines end in brk traps (the map unpacker's unhandled header forms).
- asar: write a branch to a label, never to a number (bcc $C090D2 assembled the low byte as the offset); pei is `pei ($nn)`.
- bankC0_8000: TileSetUnused and BluesPaletteUnused have no reader. MenuBackMap takes 94S's
  name: the same job (the menu screens' background, SetupScreen and the others), packed as one map set in 95. TransfersReady, DMAEnShadow, QueueBusy are named from the
  NMI code only. Mul8S's A-positive / X-negative path multiplies A by -A (tya where 94S has txa): that is in the ROM.
- bankC0_4000: WordListUnused has no reader; MenuGradientHDMA / BracketGradientHDMA follow BG2ScrollHDMA. LargeSlotTiles maps a 16 x 16 sprite slot to
  its first tile; DivisionCodes / DivisionTeamCounts, after DivisionNames, are picked by the same division number.
  DigitFontTiles and LinePieceTiles are named from the rendered tiles; BG3ScrollHDMA1/2 from the HDMA set-up.
- WonCheckTiles / WonCheckPalette: GamesToday loads them; DrawDayGames and DrawGameInSlot call
  DrawGameMarks, which chooses the marks using SeasonDay, SRDayPlayed and SRUserGames. Confirmed as the
  Games Today selection/played markers; earlier-game asset equivalence is unproven.

- Fonts: BoldFontGlyphs draws bracket/award headings, stats values and roster lists; ItalicFontGlyphs draws
  setup options, name entry and season team stats; ThinFontGlyphs draws team labels on stats, scouting,
  awards and Games Today. PrintTextPage dispatches bold/italic by row flags; the Render wrappers set the
  glyph pointer and DrawText rasterizes each string, then SendTextMap uploads the map. Earlier-game glyph
  equivalence remains unproven; these are not whole-font DMA loads.

- SoundDriver: CPU uploads and queue sends, sample/sequence starts, volume/pitch controls and data reception are
  named from the CPU/SPC trace. The CPU only ever queues commands 1, 3, 4, 8, 9 and $15 (QueueSoundCmd's callers;
  UploadSoundData sends $19). Commands 5 / 30 (.snapshotDSPUnused: the DSP registers to $F000) and 31
  (.runPortCodeUnused: runs code the host writes into the ports), 11 (.pauseAndStopSequencesUnused: saves the
  flags, sets $15 bit 4, then resets the sequences) and 12 (.restoreSequenceFlagsUnused) are never sent. Command 10
  (.startSequencePlayback) is also the end of .playSound for a sequence; $15 bit 7 is playing, bit 4 paused.
  All tcall targets and events are named. setupSequencePointers patches tcall 14 to readRawEventByte (.l0481)
  for a zero first sequence byte, otherwise readPackedEventByte; the old missing-reference question is resolved.
  Remaining auto labels inside SoundDriver are control-flow joins, loops, patched instruction sites and helpers
  without a separately documented contract. Sound RAM buffers stay numbers.
  The CPU continuations are named by role (SPCUploadBlockBytes, SPCUploadNextBlock, SPCUploadBlockHandshake,
  QueueSoundCmdReturn, LoadSampleEnvelopeAndData, StartSelectedTeamSong); they are not separate entry points.
  StartCrowdSound starts sound 2 (the crowd) unless CrowdSoundOn is set; puckfaceoff2 and Pausemode call it; StartMenuMusic
  reloads and starts sequence $A4 when MenuMusicPending (TitleScreen's song task has not started it yet) or
  MenuMusicVisited (set by its first call) is set. $4ABC / $4ABE / $4BC0 are only written at sound setup (SoundInitUnused, SoundInitUnused2, SoundUploadUnused).
  SampleListTailUnused has no reader. SampleVolumeOverrideLists: its four lists match the flag bytes of
  sequences 35-39 ($80, $80, $81, $82, $83; the others 0), so the flag was meant to select one. LoadSequence
  tests r2 (the address's low word) instead of r2+2: below $8000 it takes address bits 8-14 as the index, past the
  4 entries. No sequence reads one of the four lists; 8 sequences (1, 12, 13, 14, 21, 25, 32, 38) read stray bytes
  as overrides (by a simulation of the code: samples 5, 7, 8, $17, $18, $19, $1E). That is in the ROM.
- Scoreboard: DrawScoreBox (team abbreviations, scores) and DrawPeriodBox (showclockdma, the period text, a power play
  frame) together do 94S printscores1's job, split differently, so they have code names.
- GetPlayerRecord takes 94S's name by purpose: PlayerShortName reads its a0 as 94S's does, but 95 finds the record
  through an offset table where 94S walks the records.
  The third Claude thread followed its reads for all 662 roster players. It doubles the PlayerList pointer before
  reading, so it never reaches a real player record: not named.
- setlccords (was setlccords) is resolved: the bytes at $C54120 are `ldy.w #$5AB5`. The old `phy` entry at $C54122 was
  its operand's last byte, and that entry's caller was a false match. $18AA is LCBoxesClosed (CloseLCBoxes, ShowGoalBox
  and ShowInjuryBox count it up; the face off clears it; setlccords opens the top line change box lower while it is set).
- dp $A5 is tmp3: 95 keeps 94S's direct page register block (d0-d7, a0-a3, tmp0-tmp4) in order, $26 lower, and $A5
  is tmp3's slot, used as a scratch word. dp $00 / $02 / $04 are 95's transfer queue stack pointers (VRAMQueueSP,
  VRAMModeQueueSP, CGRAMQueueSP); 94S has no such queues.
- The work registers' high words are written REG+2 (a0+2, d1+2 ...), as 94S does; the absolute $0085 operands are d1+2
  (DrawGameMarks reaches the registers absolutely with the direct page moved). The bracket's team bar colours are
  unpackbuf+$3E60 (after TeamNameBarsMap's map and tiles), their darkened copy unpackbuf+$3E80. hattrick's only use found
  in 95 is puckfaceoff2's clear; recsfxvol / recsfxvol2 are recorded and restored by the replay but nothing else sets them.
- No DATA8_ labels are left (the data table pass: ../work/agent_runs/tools-claude-data/REPORT.md has banks $C4 / $C5):
  - Not tables: 20 runs of unreached rtl / rts / pla / jmp bytes after an exit are written as instructions with an
    "unreached" comment, their labels dropped; 94S has such bare rtls too. DATA8_C3803D was 94S projxy's off-screen
    exit (.t1x), now projxy's unreached .1.
  - MenuGradientHDMA / BracketGradientHDMA followed the 0 that ends BG2ScrollHDMA (the old label's first byte);
    SetupHDMA's inline parameters point at them. Every ROM table SetupHDMA is given is now named in its inline
    parameters (dl): also BG2ScrollHDMA, BracketWindowHDMA1 / 2 and TitleBG34HDMA; the $7E ones are RAM.
  - Nothing reads: WordListUnused, TileSetUnused, BluesPaletteUnused, SpriteField4DataUnused (sprite record
    field +4 points into it but the code drops the field), TeamRecordUnused (licensed names), HighBitMasksUnused,
    SampleListTailUnused. Named from their form; what they were for is not known.
  - The SPA lists (bank $C4, 59 of them) carry 94S names (SPAgpoke / SPAgcover from GoalieUpdateState, which is
    94S assgoalie's code) except the two wall lists. Those are SPAwallin / SPAwallout from their users: 95 plays one
    sequence for every direction, forward going into the bench or penalty box, reversed coming out, and neither
    94S's nor 95 Genesis's left / right users match. The lists are dw rows as in 94S (.d0-.d7 direction labels, the
    flag, then SPFgroup+n / time pairs). The code's SPA immediates read #SPAname&$FFFF, range bounds stay numbers
    as in 94S. FrictionFactors has 94S updateplayers' bytes but no 95
    reader.
- No CODE_ labels are left. Code that nothing reaches is named from what it does with an Unused suffix (94S's style,
  as GoalieUnused): SetTasksDoneUnused, SendTextMapPartUnused, TransferQueueStubUnused, FadeStep5Unused,
  EraseBoxUnused, CheckGameSelectedUnused, CopySpriteFrameUnused, ClearSpriteFrameUnused, CopySpriteFramesUnused,
  StartSpriteAnimUnused and FreeSpritePaletteUnused: each follows an exit (rtl, rts, jmp) and no operand, pointer,
  pea or table word reaches it. SpriteAnimIncWordUnused ($89) and SpriteAnimCallUnused ($8E) are SpriteAnimCommands
  entries for commands no record script uses. What any of them was for is not known. Two labels that their routines run into
  (setpersonel's CODE_C54320, GoalFrameLayout's CODE_CFFF0F) were dropped. Two math helpers with no caller are
  named from their registers: Mul16x8XS24 and Div32x16U.
- FixLineForward / FixLineDefence were first named the wrong way round. The range right after the goalies is the
  forwards (roster +4 is the forward count, GetForwardCount). Line bytes +1 / +2 are LD / RD (the slot texts), so the
  routine that fixes those is FixLineDefence.
