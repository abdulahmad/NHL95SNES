;	Segment build for bankC4_C000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_C000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
InitPlayerTeams = $C4D05B
ClearCreatedPlayerTeams = $C4D0D5
DrawText = $C4BE34
DrawNextTextCharacter = $C4BE53		; read the next character and prepare its glyph for drawing
DrawGlyphRow = $C4BF1A				; load a glyph row and dispatch by its destination pixel column
CopyToRAM7E = $C58AF3
ClearRAM7E = $C58B11

incsrc "../bankC4_C000.asm"
