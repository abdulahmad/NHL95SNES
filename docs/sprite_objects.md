# DATA8_C08000 / bank $C1: who reads it and what it is

Research notes (read-only, ROM `lst/nhl95snes.sfc`). Verified means "read in the ROM bytes / disassembly"; guesses are marked.
Scratch scripts: `work/recs.py` (record dump), `work/c1dec.py` (decodes every frame's $C1 stream), `work/f2.py`, `work/f3.py`.

## Why simple searches found nothing

The engine reads this block through **direct-page indexing with D = 0**: `tax / lda.b $00,x`. Direct-page reads always use
bank $00, and in HiROM bank $00 $8000-$FFFF mirrors $C08000-$C0FFFF. So X holds a record pointer ($80xx) and no absolute
operand names it. The only fixed references are long reads of the header in the bank $00 mirror:
`adc.l $008000`, `lda.l $008002`, `lda.l $008004` (bytes `6F 00 80 00`, `AF 04 80 00`, `6F 02 80 00`).

## Routines (verified)

| Address | Proposed role | Evidence |
|---|---|---|
| $C5E665 | **create a sprite object from a record index** (jsl; A = record index, $18 = x, $1A = y, $D9 = attributes; carry clear on success, X = object) | `sta $10` ... `lda $10 / asl / adc.l $008000 / txy / tax / lda $00,x` = record pointer from the list at [$8000]. About 45 `jsl $C5E665` callers in banks $C4/$C5, e.g. `lda $17CB / jsl $C5E665` ($C55A5B), `lda $17C9 / jsl` ($C55A67, $C5906A, $C5BCF1, $C5C0ED), `lda #$0020 / jsl` etc. |
| $C5EEF3 | same, but shares the palette slot of the object in Y (`sty $1C`, copies its $34, `inc $46B8,x`) | same record lookup at $C5EF46 (`adc.l $008000`) |
| $C5E8A5 | **upload the current frame's tiles** (jsr; X = object): decode if packed, push VRAM transfers on the $00 queue | `lda $28,x / asl / adc $26,x / tax / lda $00,x / tax` = frame header; flags byte +4 tested with `bit #1` / `bit #2`; `jsr $F071` at $C5E8ED and $C5E93F; callers $C558FD, $C5EA84 |
| $C5F071 | **format-0 decoder without header** (jsr from bank $C5): A = stream address, Y = stream bank, dp $08 = output address in bank $7E; returns Y = output end | sets D = $4300, stream pointer [$12] = $4312-$4314; builds `mvn $7E,<bank> / jmp $F097` in $4320-$4325 for literals (runs in bank $85 so `jmp $4320` hits the DMA registers); `mvn $7E,$7E` for copies; command < $80: cmd+1 literals; $80+: (cmd&$7F)+1 bytes from absolute output offset (word), 0 ends; `jml $C5F0D0` / `rts` with D = 0. Same rules as unpack95.py format 0, minus the 4-byte header. |
| $C5F0D1 | **build OAM for all sprite objects** (jsl; uses the stack as the OAM write pointer, `tsx / ldx $28 / txs ... pha`) | walks $1AE2,y (count $1B02); frame header via `$28,x`/`$26,x`; piece table `lda.l $C19660,x` (+2 = $C19662, pieces $C19664/$C19665); small loop then large loop; h-flip variant at $C5F234 (`bit #$4000` on obj $36) with `sbc.l $C19660,x`; frame list $28,$2A,$2C... ends at a negative entry ($C5F224) |
| $C5E9C7 | animation tick for all objects (jsl): `$0E -= $0A`; on underflow reload from $0C and read the script byte at obj $30 + $32; bit 7 = command ($C5EAAF) | callers $C37171, $C4006C, $C4B0FB.., $C4D343 |
| $C5E851 / $C5E86F | allocate small / large sprite VRAM for the record's maximum counts (from record +7 / +8) | `adc $1B0A / cmp $E3`, `adc $1B0C / cmp $DF`; $C5E86F maps a large slot to a tile through **DATA8_C04AA9** (`lda.l $C04AA9,x`, also at $C5E7F2) |
| $C4B567 area | reads the piece-table origin of an object's frame (`lda.l $C19660,x`, negated into $18D2/$18D4) | entry not traced |

## Data layout (verified against the ROM)

### Header at $C08000
- `+0 dw $87A0`: the record list (41 words, $C087A0-$C087F1).
- `+2 dl $C10000`: the palette table (16 colours = 32 bytes per palette; 39 palettes $C10000-$C104DF).
  $C5E730/$C5E73D: CGRAM transfer of 32 bytes from [$008002] + index*32, bank [$008004], to sprite palette (slot+8)*16.

### Record (27 bytes, list entry points at +0)
| Off | Size | Meaning | Status |
|---|---|---|---|
| +0 | dw | frame list start (→ obj $26) | verified |
| +2 | dw | frame list end (→ obj $2E); the word **at** this address → obj $32 (animation script pointer, see below) | verified; script list selection by SetSpriteAnim |
| +4 | dl | $C104E0, $C104E3, $C104E5 ...: each points at the word $04E2 → the byte $00 at $C104E2 (an empty list) | read but discarded at $C5E6CA/$C5E6CC (dead loads); purpose unknown |
| +7 | db | max small (8x8) sprites over the frames | verified (VRAM allocation) |
| +8 | db | max large (16x16) sprites over the frames | verified |
| +9 | db | max of (small + large) | value check only; load at $C5E6C0 discarded |
| +10..+17 | 4 x dw | signed box x1, x2, y1, y2 (e.g. -24,23,-24,23) | not seen read; guess: bounding box |
| +18 | dw | palette index (0-38) → obj $34 low byte | verified ($C5E6E1) |
| +20 | dw | number of frames (1, 32, 6, 6 ...) | matches list length; read not seen |
| +22 | db | always $03 | unknown |
| +23 | ... | the frame list (words → frame headers), then the script word(s) | verified |

### Frame header (8 bytes)
| Off | Size | Meaning |
|---|---|---|
| +0 | db | number of small 8x8 sprites (32 bytes each) |
| +1 | db | number of large 16x16 sprites (128 bytes each, uploaded as top halves then bottom halves, nLarge*64 bytes each) |
| +2 | dw | offset into the piece table at **$C19660**: dw x origin, dw y origin, then one (x, y) byte pair per small sprite, then per large sprite (2*(small+large)+4 bytes) |
| +4 | db | flags: bit 0 = the stream (small part and what follows) is format-0 packed; bit 1 = the large part is packed; 0 = raw tiles, DMA'd straight from ROM |
| +5 | dl | the tile data in bank $C1 |

Check: every frame's stream decodes (c1dec.py) to exactly (small + 4*large) * 32 bytes, and each stream ends where the next
frame's data starts, $C10533 → $C19660 with no gap. Flag-0 frames (rec 28 frames $844B-$84C3) are raw 32-byte tiles at
$C16514-$C16713. So bank $C1 $C10533-$C1965F is all sprite tile data and $C19660-$C19B67 is the piece table
(last entry: offset $04E8 + 2*(10+4)+4). $C19B68 starts something else.

### Records
- 0-27: one frame each, palette = record index, box about 48 x 48 centred. **Guess (strong): team logos** (26 teams + 2
  all-star teams), because callers pass the home/away team ($17C9, $17CB) as the record index. Not rendered yet.
- 28: 32 frames (small sprites), script at $853E. 29: 6 frames. 30: 6 frames, box 0..63 x -61..7. 31-40: single frames,
  some large (rec 33: 24 large sprites; rec 38: 1 small + 15 large). Purpose not checked; callers use e.g. #$1C, #$1D, #$1F,
  #$20-#$27.

### Animation script (traced from the interpreter)

The record's +2 word points to a **list of 16-bit script pointers**, immediately after the frame list.
CreateSprite loads list entry zero. SetSpriteAnim uses A * 2 to select an entry from obj $2E, stores A in
$1E, loads the pointer into $32, and clears position $30 and timer $0E. The list and scripts are accessed
with D = 0 through bank $00's ROM mirror. There is no stored script length or checked script index.
The additional words at Sprite28FramesEnd are script pointers, not part of the first script.

AnimateSprites visits the active list backwards. AnimateSpriteObject skips an object if bit 0 differs
between direct-page $26 and object $38. Otherwise it computes **timer - speed - 1** (`clc / sbc`),
using object $0E and $0A, and tests the result's sign (`bmi`, not the carry/borrow). A nonnegative result
is stored. A negative result enters BeginSpriteAnimStep: save the active-list index in tmp0, reload
$0E from $0C and start ReadSpriteAnim. Changing speed or reload within a script does not change this
already reloaded timer. CreateSprite initializes all three timer fields to $0100.

ReadSpriteAnim adds position $30 to pointer $32 and reads a word, but interprets only its low byte.
Bytes $00-$7F select a frame index in the record's frame list. A different frame replaces $28 and puts
$FFFF in $2A; if object flags $22 have bit $2000 set, UploadSpriteAnimFrame adjusts VRAM placement and
calls UploadSpriteFrame. An unchanged frame bypasses both the list reset and upload. Either way the
position advances one byte and processing yields to AnimateNextSprite.

Bytes with bit 7 set go through DispatchSpriteAnim: position advances past the opcode, then
`(byte & $7F) * 2` indexes SpriteAnimCommands. Its entries cover $80-$9D only; $9E-$FF are not checked
and would dispatch through following code bytes. Operands are raw bytes, not recursively decoded as
commands; words are little endian. Below, **p** is the position of the opcode. Unless a row says yield,
hold or delete, the handler immediately reads another script byte in the same timer step. There is
no command-chain limit. Hold means position is restored to p and the object is revisited on a later
timer expiry; it does not clear any animation flag. Yield means leave the position advanced.

| Byte | Operands after opcode | Handler | Verified action |
|---|---|---|---|
| $80 | none | SpriteAnimHold | Hold at p |
| $81 | none | SpriteAnimRestart | Set position 0 and continue in the same script |
| $82 | word displacement | SpriteAnimJumpRelative | Set position to p + displacement (16-bit wrap); displacement is relative to the opcode, not its end |
| $83 | byte script index | SpriteAnimSelectScript | Store index in $1E and $20, load pointer from list $2E, clear position and timer, continue in selected script; does not set flag $4000 |
| $84 | none | SpriteAnimHold84 | Jump to SpriteAnimHold |
| $85 | word reload | SpriteAnimSetReload | Store in $0C; next position p + 3 |
| $86 | word speed | SpriteAnimSetSpeed | Store in $0A; next position p + 3 |
| $87 | byte count n, then n frame bytes | SpriteAnimSetFrames | Widen frames into words starting at $28, append $FFFF, upload the list with UploadSpriteFrames, yield at p + n + 2 |
| $88 | none | SpriteAnimDelete | Call DeleteSprite with X = object; the encoded JSR/RTL mismatch prevents assuming a valid return (see below) |
| $89 | byte index | CODE_C5EBB8 | BRK for index >= 4; otherwise read a pointer from UploadSpriteFrames + 2*index and increment the word it addresses through DB, then continue at p + 2 |
| $8A | byte ignored | SpriteAnimSkipByte | Read and mask the operand, discard it, continue at p + 2 |
| $8B | none | SpriteAnimToggleHFlip | XOR object $36 with $4000 |
| $8C | none | SpriteAnimToggleVFlip | XOR object $36 with $8000 |
| $8D | none | SpriteAnimYield | Yield at p + 1 |
| $8E | byte index | CODE_C5EC1A | JSR through the word at UploadSpriteFrames + 2*index in the program bank; carry set on return holds at p, clear consumes the operand and continues at p + 2 |
| $8F | none | SpriteAnimHold8F | Jump to SpriteAnimHold |
| $90 | none | SpriteAnimRestoreScript | Copy saved $20 to $1E, select that script, clear position and timer, set flags $22 bit $4000, continue |
| $91 | none | SpriteAnimHold | Hold at p |
| $92 | none | SpriteAnimHold | Hold at p |
| $93 | none | SpriteAnimSetHFlip | Set object $36 bit $4000 |
| $94 | none | SpriteAnimClearHFlip | Clear object $36 bit $4000 |
| $95 | none | SpriteAnimSetVFlip | Set object $36 bit $8000 |
| $96 | none | SpriteAnimClearVFlip | Clear object $36 bit $8000 |
| $97 | none | SpriteAnimToggleFlips | XOR object $36 with $C000 |
| $98 | none | SpriteAnimHold | Hold at p |
| $99 | none | SpriteAnimHold | Hold at p |
| $9A | none | SpriteAnimHold | Hold at p |
| $9B | none | SpriteAnimClearFlag4000 | Clear flags $22 bit $4000 and continue at p + 1; this does not itself stop the tick |
| $9C | byte absolute position | SpriteAnimBranchIfFlagClear | If flags $22 bit $4000 is clear, set position to the operand; otherwise skip it (p + 2) |
| $9D | byte ignored | SpriteAnimSkipByteAlt | Read a word at p + 1 and discard it, but consume only one byte; continue at p + 2 |

The horizontal flip attribute selects mirrored piece placement in BuildSpriteOAM and is included in
OAM tile attributes. Bit $8000 is passed to OAM as vertical **tile** flip; the OAM builder does not
select a vertically mirrored piece-placement path. The commands should not be read as proof of whole
multi-piece vertical mirroring.

SetSpriteAnim with an unchanged script number returns immediately if flags $22 bit $4000 is set;
otherwise it sets that bit and clears position and timer. With a changed script it also clears the
vertical tile flip attribute. Thus $9B allows an external SetSpriteAnim call to restart the same
script. $80 holds without clearing this flag. $83 saves its index in $20 for $90; SetSpriteAnim does
not change that saved index (CreateSprite initializes it to zero).

#### Literal behavior that does not establish an intended command contract

- $87 has no count/range validation. The existing scripts use n = 2, occupying $28/$2A with the
  terminator in $2C. A third frame would place its terminator over the script-list pointer at $2E.
  A zero count enters the loop anyway and wraps the word counter. UploadSpriteFrames queues each
  selected frame's small and large tile transfers consecutively, using the same packed/raw frame
  flags as UploadSpriteFrame. The handler always calls this uploader, without testing flag $2000.
- $88 uses `jsr.w DeleteSprite`, but DeleteSprite returns with `rtl`. The following instructions
  restore tmp0 and jump to AnimateNextSprite, but that continuation cannot be treated as a working
  return contract. No $88 occurs in the record scripts in bankC0_8000.
- $89 and $8E use **code bytes** at UploadSpriteFrames as a pointer table. Its first four words are
  $1886, $B59B, $8510, $B510 (the beginning of `stx / txy / lda / sta / lda`), not an identified data
  table. $89 checks index < 4; $8E has no bound check or proven callee-preservation contract. Their
  mechanical operations are documented above, but their intended jobs remain unnamed. Neither
  command occurs in the record scripts in bankC0_8000.
- $8A and $9D have no persistent effect except consuming one operand byte. No external call is
  present; names such as sound or callback would be speculation.


## Object RAM (bank $00, X = object) used by these routines
$05 x, $08 y, $0A speed, $0C reload, $0E timer, $10/$12 small VRAM word address, $14 large VRAM address, $16/$18 large slot,
$1A/$1C small/large counts, $1E current script, $20 saved script, $22 flags (bit 0 = drawn), $24 record index, $26 frame list, $28/$2A/$2C frame numbers
($FFFF = none), $2E list end, $30 script position, $32 script pointer, $34 palette (low = index, high = CGRAM slot),
$36 attributes (bit $4000 = h flip). Lists: $1AE2 active objects (count $1B02, max 8), $1AF2 free list ($1B04),
$46B8 palette use per index, $46A8 free palette slots ($1B06, count $1B08).

## Names from the sibling projects (purpose matches, not code matches)
- NHL94SNES `TeamLogoSprites` ($81ABDE): "packed sprite set: the team logos, then Wales, Campbell, NHL, NHLPA" and
  `LogoPaletteTable`. 95's record block plays the same role (logos as sprites with a palette per logo) but with a
  different format and engine. Possible names (suggestions): `LogoSprites` / `SpriteRecords` for DATA8_C08000,
  `SpritePalettes` for $C10000, `SpritePieces` for $C19660, `CreateSprite` ($C5E665), `CreateSpriteSharePal` ($C5EEF3),
  `UploadSpriteFrame` ($C5E8A5), `UnpackStream0` ($C5F071), `BuildSpriteOAM` ($C5F0D1), `AnimateSprites` ($C5E9C7).
- 94S `InitSprites` / `SpriteFrameStart` / `DrawSprite` are a different engine; no code match checked.

## Open questions
- Render records 0-27 (palette = record index, tiles + pieces) to confirm the team logos and the team order.
- What records 28-40 are (rec 28: 32 small frames; rec 33-36 big).
- The intended contracts of commands $89/$8E and the JSR/RTL mismatch in $88 (literal behavior above).
- Record +4 (pointer to $04E2 / the 00 byte), +10..+17 (box) and +22: no reader seen.
- The entry and job of the $C4B567 code that reads the piece origin.
