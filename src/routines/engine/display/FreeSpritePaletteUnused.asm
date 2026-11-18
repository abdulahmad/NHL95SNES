FreeSpritePaletteUnused:			; gives back sprite object X's palette ($34,x): with more users (the low
									; byte of SpritePalUse) one fewer, else its slot back on PalSlotList
									; (PalSlotsUsed - 1); nothing calls it
	phx
	lda.b $34,x
	and.w #$00FF
	asl a
	tax
	lda.w SpritePalUse,x
	bit.w #$00FF
	bne .1
	xba
	ora.w #$FF00
	sta.w SpritePalUse,x
	and.w #$00FF
	ldx.w PalSlotNext
	dex
	dex
	sta.w PalSlotList,x
	stx.w PalSlotNext
	dec.w PalSlotsUsed
	plx
	rts
.1:									; A - 1, SpritePalUse,x = A, pull X, return
	dec a
	sta.w SpritePalUse,x
	plx
	rts
