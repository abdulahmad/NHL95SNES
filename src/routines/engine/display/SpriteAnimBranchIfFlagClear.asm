SpriteAnimBranchIfFlagClear:		; jump to the byte position if animation flag $4000 is clear
	lda.w $0022,y
	bit.w #$4000
	beq .1
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim
.1:									; X = tmp1, A = $01,x, A and $00FF, $0030,y = A, ...
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	sta.w $0030,y
	tyx
	jmp.w ReadSpriteAnim
