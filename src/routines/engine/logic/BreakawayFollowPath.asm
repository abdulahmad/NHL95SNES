BreakawayFollowPath:				; follow the computer breakaway path and choose when to shoot
	lda.w gmclock
	bne BreakawayGlideStopped
	lda.w Ypos,x
	sta.b d0
	ldy.w pfgoal,x
	bne .1
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.1:									; A = pflags,x, if $0002 bits clear go to .2, A and $FFFD, ...
	lda.w pflags,x
	bit.w #$0002
	beq .2
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	stz.w sopathpoint
	lda.w seed
	and.w #$0003
	sta.w temp3,x
	jsr.w InitBreakawayPath
.2:									; if sopathnext < 0 go to .5, if d0 - sopathnext < 0 go to .3, ...
	lda.w sopathnext
	bmi .5
	lda.b d0
	cmp.w sopathnext
	bmi .3
	jsr.w AdvanceBreakawayPath
	lda.w facedir,x
	sta.w sopathface
.3:									; d0 = sopathx, d1 = sopathy, if pfgoal,x is not 0 go to .4, ...
	lda.w sopathx
	sta.b d0
	lda.w sopathy
	sta.b d1
	lda.w pfgoal,x
	bne .4
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.4:									; a0+2 = BreakawayNoCallback>>16, a0 = BreakawayNoCallback, ...
	lda.w #BreakawayNoCallback>>16
	sta.b a0+2
	lda.w #BreakawayNoCallback
	sta.b a0
	lda.w temp2,x
	sec
	sbc.w impactstep
	sta.w temp2,x
	jml.l skateto
.5:									; A = facedir,x, A - sopathface, if the result = 0 go to .3, A + 1, ...
	lda.w facedir,x
	sec
	sbc.w sopathface
	beq .3
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .6
	jsl.l RandomWord
	and.w #$0F80
	bne .3
	bra .7
.6:									; call RandomWord, if the result is not 0 go to .3
	jsl.l RandomWord
	and.w #$0600
	bne .3
.7:									; call RandomWord, A and $0001, A + 1, A + 1, ...
	jsl.l RandomWord
	and.w #$0001
	inc a
	inc a
	sta.b d0
	ldy.w sopathside
	bpl .8
	lda.b d0
	clc
	adc.w #$0003
	sta.b d0
.8:									; passdir = d0, passspeed = $0014, A = $0000, A - Xpos,x, ...
	lda.b d0
	sta.w passdir
	lda.w #$0014
	sta.w passspeed
	lda.w #$0000
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pfgoal,x
	bne .9
	lda.w #$FEF2
	sec
	sbc.w Ypos,x
	sta.b d1
	bra .10
.9:									; A = $010E, A - Ypos,x, d1 = A
	lda.w #$010E
	sec
	sbc.w Ypos,x
	sta.b d1
.10:								; call vtoa, call Findhittype, if zero go to .11, ...
	jsl.l vtoa
	jsl.l Findhittype
	beq .11
	lda.w #SPAonetimeb&$FFFF
	bra .12
.11:								; A = SPAonetimef
	lda.w #SPAonetimef&$FFFF
.12:								; call SetSPAFromA, call updateanim, SPAcnt,x = $0002, go to doshot
	jsl.l SetSPAFromA
	jsl.l updateanim
	lda.w #$0002
	sta.w SPAcnt,x
	jml.l doshot
