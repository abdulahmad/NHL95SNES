AddIntermissionGoals:				; in season and playoff play (OptPlayMode 2 / 3), adds a random 0-1 goals
									; to each team of each of the day's computer games not yet done
	lda.w OptPlayMode
	cmp.w #$0002
	beq .1
	cmp.w #$0003
	beq .1
	rtl
.1:									; tmp0 = DayGameCount, Y = $8EF8
	lda.w DayGameCount
	sta.b tmp0
	pea.w $7E7F
	plb
	ldy.w #$8EF8
.loop:								; loop: if $0000,y is not 0 go to .3, if $0006,y < 0 go to .3, ...
	lda.w $0000,y
	bne .3
	lda.w $0006,y
	bmi .3
	jsr.w RandomIntermissionGoal
	adc.w $000A,y
	sta.w $000A,y
	jsr.w RandomIntermissionGoal
	adc.w $0008,y
	sta.w $0008,y
	jsr.w RandomIntermissionGoal
	cmp.w #$0014
	bcs .3
	cmp.w #$000A
	lda.w $0006,y
	adc.w #$0000
	cmp.w #$0002
	bcc .2
	lda.w #$0002
.2:									; $0006,y = A
	sta.w $0006,y
.3:									; A = Y, A + $010A, Y = A, tmp0 - 1, ...
	clc
	tya
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	plb
	rtl
