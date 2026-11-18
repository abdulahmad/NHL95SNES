defaultsprites_0:					; clear object state, load initial fields and sort the objects
	ldx.w #$0000
.loop:								; loop: Xpos,x = 0, X + 1, X + 1, if X is not $07CC go to .loop, ...
	stz.w Xpos,x
	inx
	inx
	cpx.w #$07CC
	bne .loop
	stz.b d6
	stz.b a1
	stz.b a2
	stz.b a3
	stz.b a4
.loop2:								; loop: X = a2, Y = a3, SCnum,y = d6, oldframe,y = $FFFF, ...
	ldx.b a2
	ldy.b a3
	lda.b d6
	sta.w SCnum,y
	lda.w #$FFFF
	sta.w oldframe,y
	sta.w frame+$20,y
	sta.w pnum,y
	lda.l SortObjInitTable,x
	sta.w Xpos,y
	lda.l SortObjInitTable+2,x
	sta.w Ypos,y
	lda.l SortObjInitTable+6,x
	sta.w frame,y
	lda.l SortObjInitTable+8,x
	sta.w attribute,y
	lda.l SortObjInitTable+10,x
	sta.w radiusx,y
	lda.l SortObjInitTable+12,x
	sta.w radiusy,y
	lda.b d6
	asl a
	asl a
	asl a
	tay
	lda.l SortObjInitTable+14,x
	sta.w asslist,y
	ldy.b a3
	sta.w asscur,y
	lda.l SortObjInitTable+16,x
	sta.w pflags,y
	lda.w #$0000
	sta.w pfnc,y
	cpy.w #$001E
	bne .1
	lda.w #$0001
	sta.w pfnc,y
.1:									; A + 1, A and $0001, pfgoal,y = A, if X < $006C go to .2, ...
	cpx.w #$006C
	rol a
	inc a
	and.w #$0001
	sta.w pfgoal,y
	cpx.w #$006C
	bcc .2
	cpx.w #$00D8
	bcs .2
	lda.w #$0034
	sta.w pfteam,y
.2:									; a3 + 1, a3 + 1, A 8-bit, A = d6, ...
	inc.b a3
	inc.b a3
	sep #$20
	lda.b d6
	asl a
	ldy.b a1
	sta.w OOlist,y
	inc.b a1
	rep #$30
	ldy.b a4
	lda.b d6
	sta.w OOlistpos,y
	inc.b a4
	inc.b a4
	inc.b d6
	lda.b a2
	clc
	adc.w #$0012
	sta.b a2
	lda.b d6
	cmp.w #$0010
	beq .3
	jmp.w .loop2
.3:									; position+24 = $FFFF, position+26 = A, frame+$38 = frame+$18, ...
	lda.w #$FFFF
	sta.w position+24
	sta.w position+26
	lda.w frame+$18
	sta.w frame+$38
	lda.w frame+$1A
	sta.w frame+$3A
	lda.w frame+$1E
	sta.w frame+$3E
	jmp.w SprSort
