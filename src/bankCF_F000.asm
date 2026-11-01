; Segment bankCF_F000: the rest of the frame code, the layout data (size words, record pointers, records),
; two routines the top layouts jump to, then zeros to the end of the ROM.
org $CFF0CB
CODE_CFF0CB:						; called from other segments
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	lda.l $CF0003,x
	and.w #$00FF
	sta.b $E9
	lda.l $CF0004,x
	and.w #$00FF
	sta.b $F1
	inc.b tmp1
	jmp.w CODE_CFF203
CODE_CFF0F6:						; called from other segments
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
CODE_CFF0FF:						; called from other segments
	sta.b $E7
CODE_CFF101:						; called from other segments
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	lda.l $CF0003,x
	and.w #$00FF
	sta.b $E9
	lda.l $CF0004,x
	and.w #$00FF
	sta.b $F1
	lda.l $CF0005,x
	and.w #$00FF
	sta.b $EB
	lda.l $CF0006,x
	and.w #$00FF
	sta.b $F3
	lda.b tmp1
	inc a
	inc a
	sta.b tmp1
	jmp.w CODE_CFF1C6
CODE_CFF137:						; called from other segments
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	lda.l $CF0003,x
	and.w #$00FF
	sta.b $E9
	lda.l $CF0004,x
	and.w #$00FF
	sta.b $F1
	lda.l $CF0005,x
	and.w #$00FF
	sta.b $EB
	lda.l $CF0006,x
	and.w #$00FF
	sta.b $F3
	lda.l $CF0007,x
	and.w #$00FF
	sta.b $ED
	lda.l $CF0008,x
	and.w #$00FF
	sta.b $F5
	clc
	lda.b tmp1
	adc.w #$0003
	sta.b tmp1
	lda.b tmp1
	pha
	dec a
	sta.b tmp1
	ldx.w #$0000
	clc
	lda.b $ED
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F5, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F5
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to CODE_CFF1C6
	pla
	bra CODE_CFF1C6
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFF1C6:						; from CODE_CFF101, CODE_CFF137
	lda.b tmp1
	pha
	dec a
	sta.b tmp1
	ldx.w #$0000
	clc
	lda.b $EB
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F3, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F3
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to CODE_CFF203
	pla
	bra CODE_CFF203
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFF203:						; from CODE_CFF0CB, CODE_CFF1C6
	lda.b tmp1
	pha
	dec a
	sta.b tmp1
	ldx.w #$0000
	clc
	lda.b $E9
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc CODE_CFF231
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to CODE_CFF231
	cmp.w #$0100
	bcs CODE_CFF231
CODE_CFF221:						; called from other segments
	sta.b tmp0
	lda.b $F1
	adc.b $0C
	bpl CODE_CFF234
	cmp.w #$FFF9
	and.w #$00FF
	bcs CODE_CFF239
CODE_CFF231:						; from CODE_CFF203, CODE_CFF234
	pla
	bra CODE_CFF240
CODE_CFF234:						; from CODE_CFF221
	cmp.w #$00E0
	bcs CODE_CFF231
CODE_CFF239:						; from CODE_CFF221
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFF240:						; from CODE_CFF231 and other segments
	pei ($A1)
	ldx.w #$0000
	clc
	lda.b $E7
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $EF, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $EF
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to CODE_CFF279
	pla
	bra CODE_CFF279
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFF279:						; from CODE_CFF240 and other segments
	jmp ($00A5)
DATA8_CFF27C:						; per layout (the high byte of a DATA8_C60848 word) a size word:
									; QueueFrameTiles queues two transfers of twice its low byte, then one
									; of its high byte (zero parts skipped)
	dw $0000,$8080,$8080,$6080,$6080,$6080,$6080,$8080
	dw $8080,$8080,$8080,$6080,$6080,$8080,$8080,$8080
	dw $8080,$8080,$8080,$8080,$8080,$8080,$8080,$8080
	dw $8080,$8080,$8080,$8080,$8080,$6080,$6080,$8080
	dw $8080,$8080,$8080,$8080,$8080,$8080,$8080,$8080
	dw $8080,$0020,$0020,$0040,$0040,$8080,$8080,$8080
	dw $8080,$8080,$8080,$8080,$8080,$8080,$8080,$8080
	dw $8080,$6080,$6080,$8080,$8080,$8080,$8080,$6080
	dw $6080,$8080,$8080,$6080,$6080,$8080,$8080,$6080
	dw $6080,$8080,$8080,$8080,$8080,$6080,$6080,$6080
	dw $6080,$4080,$4080,$6080,$6080,$8080,$8080,$2080
	dw $2080,$8080,$8080,$4080,$4080,$8080,$8080,$8080
	dw $8080,$6080,$6080,$8080,$8080,$6080,$6080,$4080
	dw $4080,$2080,$2080,$4080,$4080,$8060,$8060,$6080
	dw $6080,$6080,$6080,$8080,$8080,$8080,$8080,$4080
	dw $4080,$8080,$8080,$2000,$2000,$0080,$0080,$2080
	dw $2080,$8080,$8080,$8080,$8080,$2060,$2060,$0080
	dw $0080,$8080,$8080,$8080,$8080,$0060,$0060,$0080
	dw $0080,$2000
DATA8_CFF3A0:						; CODE_CFEE6C reads layout A at DATA8_CFF3A0+2A (layout 0 is skipped,
									; so this word is not read); $8F-$91 jump through it
	dw $2000
DATA8_CFF3A2:						; per layout a pointer in this bank: entries 0-141 a layout record
									; (its first byte picks the handler in DATA8_CFEEAE), 142-145 code
									; that CODE_CFEE25 / CODE_CFEE6C jump to
	dw DATA8_CFF4C6&$FFFF,DATA8_CFF4D8&$FFFF,DATA8_CFF4EA&$FFFF,DATA8_CFF4FA&$FFFF
	dw DATA8_CFF50A&$FFFF,DATA8_CFF51A&$FFFF,DATA8_CFF52A&$FFFF,DATA8_CFF53C&$FFFF
	dw DATA8_CFF54E&$FFFF,DATA8_CFF560&$FFFF,DATA8_CFF572&$FFFF,DATA8_CFF582&$FFFF
	dw DATA8_CFF592&$FFFF,DATA8_CFF5A4&$FFFF,DATA8_CFF5B6&$FFFF,DATA8_CFF5C8&$FFFF
	dw DATA8_CFF5DA&$FFFF,DATA8_CFF5EC&$FFFF,DATA8_CFF5FE&$FFFF,DATA8_CFF610&$FFFF
	dw DATA8_CFF622&$FFFF,DATA8_CFF634&$FFFF,DATA8_CFF646&$FFFF,DATA8_CFF658&$FFFF
	dw DATA8_CFF66A&$FFFF,DATA8_CFF67C&$FFFF,DATA8_CFF68E&$FFFF,DATA8_CFF6A0&$FFFF
	dw DATA8_CFF6B2&$FFFF,DATA8_CFF6C2&$FFFF,DATA8_CFF6D2&$FFFF,DATA8_CFF6E4&$FFFF
	dw DATA8_CFF6F6&$FFFF,DATA8_CFF708&$FFFF,DATA8_CFF71A&$FFFF,DATA8_CFF72C&$FFFF
	dw DATA8_CFF73E&$FFFF,DATA8_CFF750&$FFFF,DATA8_CFF762&$FFFF,DATA8_CFF774&$FFFF
	dw DATA8_CFF786&$FFFF,DATA8_CFF786&$FFFF,DATA8_CFF78A&$FFFF,DATA8_CFF790&$FFFF
	dw DATA8_CFF796&$FFFF,DATA8_CFF7A8&$FFFF,DATA8_CFF7BA&$FFFF,DATA8_CFF7CC&$FFFF
	dw DATA8_CFF7DE&$FFFF,DATA8_CFF7F0&$FFFF,DATA8_CFF802&$FFFF,DATA8_CFF814&$FFFF
	dw DATA8_CFF826&$FFFF,DATA8_CFF838&$FFFF,DATA8_CFF84A&$FFFF,DATA8_CFF85C&$FFFF
	dw DATA8_CFF86E&$FFFF,DATA8_CFF87E&$FFFF,DATA8_CFF88E&$FFFF,DATA8_CFF8A0&$FFFF
	dw DATA8_CFF8B2&$FFFF,DATA8_CFF8C4&$FFFF,DATA8_CFF8D6&$FFFF,DATA8_CFF8E6&$FFFF
	dw DATA8_CFF8F6&$FFFF,DATA8_CFF908&$FFFF,DATA8_CFF91A&$FFFF,DATA8_CFF92A&$FFFF
	dw DATA8_CFF93A&$FFFF,DATA8_CFF94C&$FFFF,DATA8_CFF95E&$FFFF,DATA8_CFF96E&$FFFF
	dw DATA8_CFF97E&$FFFF,DATA8_CFF990&$FFFF,DATA8_CFF9A2&$FFFF,DATA8_CFF9B4&$FFFF
	dw DATA8_CFF9C6&$FFFF,DATA8_CFF9D6&$FFFF,DATA8_CFF9E6&$FFFF,DATA8_CFF9F6&$FFFF
	dw DATA8_CFFA06&$FFFF,DATA8_CFFA14&$FFFF,DATA8_CFFA22&$FFFF,DATA8_CFFA32&$FFFF
	dw DATA8_CFFA42&$FFFF,DATA8_CFFA54&$FFFF,DATA8_CFFA66&$FFFF,DATA8_CFFA72&$FFFF
	dw DATA8_CFFA7E&$FFFF,DATA8_CFFA90&$FFFF,DATA8_CFFAA2&$FFFF,DATA8_CFFAB0&$FFFF
	dw DATA8_CFFABE&$FFFF,DATA8_CFFAD0&$FFFF,DATA8_CFFAE2&$FFFF,DATA8_CFFAF4&$FFFF
	dw DATA8_CFFB06&$FFFF,DATA8_CFFB16&$FFFF,DATA8_CFFB26&$FFFF,DATA8_CFFB38&$FFFF
	dw DATA8_CFFB4A&$FFFF,DATA8_CFFB5A&$FFFF,DATA8_CFFB6A&$FFFF,DATA8_CFFB78&$FFFF
	dw DATA8_CFFB86&$FFFF,DATA8_CFFB92&$FFFF,DATA8_CFFB9E&$FFFF,DATA8_CFFBAC&$FFFF
	dw DATA8_CFFBBA&$FFFF,DATA8_CFFBCA&$FFFF,DATA8_CFFBDA&$FFFF,DATA8_CFFBEA&$FFFF
	dw DATA8_CFFBFA&$FFFF,DATA8_CFFC0A&$FFFF,DATA8_CFFC1A&$FFFF,DATA8_CFFC2C&$FFFF
	dw DATA8_CFFC3E&$FFFF,DATA8_CFFC50&$FFFF,DATA8_CFFC62&$FFFF,DATA8_CFFC70&$FFFF
	dw DATA8_CFFC7E&$FFFF,DATA8_CFFC90&$FFFF,DATA8_CFFCA2&$FFFF,DATA8_CFFCA6&$FFFF
	dw DATA8_CFFCAA&$FFFF,DATA8_CFFCB4&$FFFF,DATA8_CFFCBE&$FFFF,DATA8_CFFCCA&$FFFF
	dw DATA8_CFFCD6&$FFFF,DATA8_CFFCE8&$FFFF,DATA8_CFFCFA&$FFFF,DATA8_CFFD0C&$FFFF
	dw DATA8_CFFD1E&$FFFF,DATA8_CFFD28&$FFFF,DATA8_CFFD32&$FFFF,DATA8_CFFD3C&$FFFF
	dw DATA8_CFFD46&$FFFF,DATA8_CFFD58&$FFFF,DATA8_CFFD6A&$FFFF,DATA8_CFFD7C&$FFFF
	dw DATA8_CFFD8E&$FFFF,DATA8_CFFD96&$FFFF,CODE_CFFD9E&$FFFF,CODE_CFFD9E&$FFFF
	dw CODE_CFFF88&$FFFF,CODE_CFFF88&$FFFF
DATA8_CFF4C6:						; layout record for DATA8_CFF3A2 entry 0; not traced further
	db $06,$20,$09,$10,$00,$10,$10,$00,$00,$06,$30,$13,$20,$19,$2F,$1B
	db $08,$10
DATA8_CFF4D8:						; layout record for DATA8_CFF3A2 entry 1; not traced further
	db $06,$08,$09,$18,$00,$18,$10,$28,$00,$06,$00,$13,$10,$19,$01,$1B
	db $28,$10
DATA8_CFF4EA:						; layout record for DATA8_CFF3A2 entry 2; not traced further
	db $06,$12,$00,$11,$10,$15,$20,$05,$20,$04,$0A,$08,$1D,$30,$00,$30
DATA8_CFF4FA:						; layout record for DATA8_CFF3A2 entry 3; not traced further
	db $06,$03,$00,$04,$10,$00,$20,$10,$20,$04,$13,$08,$00,$30,$1D,$30
DATA8_CFF50A:						; layout record for DATA8_CFF3A2 entry 4; not traced further
	db $06,$18,$05,$18,$15,$08,$00,$08,$10,$04,$00,$02,$28,$14,$28,$0C
DATA8_CFF51A:						; layout record for DATA8_CFF3A2 entry 5; not traced further
	db $06,$08,$05,$08,$15,$18,$00,$18,$10,$04,$28,$02,$00,$14,$00,$0C
DATA8_CFF52A:						; layout record for DATA8_CFF3A2 entry 6; not traced further
	db $06,$30,$08,$20,$08,$10,$07,$00,$07,$06,$40,$10,$20,$00,$40,$08
	db $28,$00
DATA8_CFF53C:						; layout record for DATA8_CFF3A2 entry 7; not traced further
	db $06,$08,$08,$18,$08,$28,$07,$38,$07,$06,$00,$10,$20,$00,$00,$08
	db $18,$00
DATA8_CFF54E:						; layout record for DATA8_CFF3A2 entry 8; not traced further
	db $06,$18,$09,$18,$19,$08,$00,$08,$10,$06,$28,$0D,$28,$20,$30,$20
	db $00,$05
DATA8_CFF560:						; layout record for DATA8_CFF3A2 entry 9; not traced further
	db $06,$10,$09,$10,$19,$20,$00,$20,$10,$06,$08,$0D,$08,$20,$00,$20
	db $30,$05
DATA8_CFF572:						; layout record for DATA8_CFF3A2 entry 10; not traced further
	db $06,$20,$08,$10,$08,$20,$18,$10,$18,$04,$24,$00,$08,$08,$00,$07
DATA8_CFF582:						; layout record for DATA8_CFF3A2 entry 11; not traced further
	db $06,$00,$08,$10,$08,$00,$18,$10,$18,$04,$04,$00,$20,$08,$28,$07
DATA8_CFF592:						; layout record for DATA8_CFF3A2 entry 12; not traced further
	db $06,$20,$08,$10,$06,$10,$16,$00,$12,$06,$2B,$00,$20,$1B,$08,$0A
	db $08,$22
DATA8_CFF5A4:						; layout record for DATA8_CFF3A2 entry 13; not traced further
	db $06,$03,$08,$13,$06,$13,$16,$23,$12,$06,$00,$00,$0B,$1B,$23,$0A
	db $23,$22
DATA8_CFF5B6:						; layout record for DATA8_CFF3A2 entry 14; not traced further
	db $06,$30,$14,$20,$0B,$10,$09,$00,$00,$06,$28,$1B,$10,$01,$20,$1B
	db $18,$19
DATA8_CFF5C8:						; layout record for DATA8_CFF3A2 entry 15; not traced further
	db $06,$00,$14,$10,$0B,$20,$09,$30,$00,$06,$10,$1B,$28,$01,$18,$1B
	db $20,$19
DATA8_CFF5DA:						; layout record for DATA8_CFF3A2 entry 16; not traced further
	db $06,$15,$08,$10,$18,$00,$18,$05,$08,$06,$25,$08,$2D,$08,$2D,$00
	db $25,$00
DATA8_CFF5EC:						; layout record for DATA8_CFF3A2 entry 17; not traced further
	db $06,$10,$08,$15,$18,$25,$18,$20,$08,$06,$08,$08,$00,$08,$00,$00
	db $08,$00
DATA8_CFF5FE:						; layout record for DATA8_CFF3A2 entry 18; not traced further
	db $06,$28,$00,$18,$03,$18,$13,$08,$13,$06,$28,$10,$10,$0B,$10,$23
	db $00,$17
DATA8_CFF610:						; layout record for DATA8_CFF3A2 entry 19; not traced further
	db $06,$00,$00,$10,$03,$10,$13,$20,$13,$06,$08,$10,$20,$0B,$20,$23
	db $30,$17
DATA8_CFF622:						; layout record for DATA8_CFF3A2 entry 20; not traced further
	db $06,$28,$08,$18,$08,$25,$18,$15,$18,$06,$27,$00,$08,$14,$10,$10
	db $00,$16
DATA8_CFF634:						; layout record for DATA8_CFF3A2 entry 21; not traced further
	db $06,$00,$08,$10,$08,$03,$18,$13,$18,$06,$09,$00,$28,$14,$20,$10
	db $30,$16
DATA8_CFF646:						; layout record for DATA8_CFF3A2 entry 22; not traced further
	db $06,$10,$08,$00,$08,$19,$18,$09,$18,$06,$00,$00,$1C,$28,$14,$28
	db $0C,$28
DATA8_CFF658:						; layout record for DATA8_CFF3A2 entry 23; not traced further
	db $06,$09,$08,$19,$08,$00,$18,$10,$18,$06,$21,$00,$05,$28,$0D,$28
	db $15,$28
DATA8_CFF66A:						; layout record for DATA8_CFF3A2 entry 24; not traced further
	db $06,$30,$00,$18,$01,$18,$11,$08,$0E,$06,$28,$01,$28,$11,$28,$09
	db $00,$1A
DATA8_CFF67C:						; layout record for DATA8_CFF3A2 entry 25; not traced further
	db $06,$00,$00,$18,$01,$18,$11,$28,$0E,$06,$10,$01,$10,$11,$10,$09
	db $38,$1A
DATA8_CFF68E:						; layout record for DATA8_CFF3A2 entry 26; not traced further
	db $06,$20,$0D,$10,$00,$10,$10,$00,$16,$06,$34,$03,$30,$0B,$20,$05
	db $10,$20
DATA8_CFF6A0:						; layout record for DATA8_CFF3A2 entry 27; not traced further
	db $06,$0C,$0D,$1C,$00,$1C,$10,$2C,$16,$06,$00,$03,$04,$0B,$14,$05
	db $24,$20
DATA8_CFF6B2:						; layout record for DATA8_CFF3A2 entry 28; not traced further
	db $06,$18,$0B,$08,$0B,$18,$1B,$08,$1B,$04,$15,$03,$00,$15,$0D,$00
DATA8_CFF6C2:						; layout record for DATA8_CFF3A2 entry 29; not traced further
	db $06,$00,$0B,$10,$0B,$00,$1B,$10,$1B,$04,$0B,$03,$20,$15,$13,$00
DATA8_CFF6D2:						; layout record for DATA8_CFF3A2 entry 30; not traced further
	db $06,$00,$08,$10,$08,$20,$08,$30,$08,$06,$08,$00,$10,$00,$18,$00
	db $20,$00
DATA8_CFF6E4:						; layout record for DATA8_CFF3A2 entry 31; not traced further
	db $06,$30,$08,$20,$08,$10,$08,$00,$08,$06,$30,$00,$28,$00,$20,$00
	db $18,$00
DATA8_CFF6F6:						; layout record for DATA8_CFF3A2 entry 32; not traced further
	db $06,$00,$10,$10,$10,$20,$10,$20,$00,$06,$08,$08,$10,$08,$18,$08
	db $18,$00
DATA8_CFF708:						; layout record for DATA8_CFF3A2 entry 33; not traced further
	db $06,$20,$10,$10,$10,$00,$10,$00,$00,$06,$20,$08,$18,$08,$10,$08
	db $10,$00
DATA8_CFF71A:						; layout record for DATA8_CFF3A2 entry 34; not traced further
	db $06,$28,$09,$18,$00,$18,$10,$00,$06,$06,$38,$10,$28,$01,$10,$0A
	db $10,$12
DATA8_CFF72C:						; layout record for DATA8_CFF3A2 entry 35; not traced further
	db $06,$08,$09,$18,$00,$18,$10,$30,$06,$06,$00,$10,$10,$01,$28,$0A
	db $28,$12
DATA8_CFF73E:						; layout record for DATA8_CFF3A2 entry 36; not traced further
	db $06,$06,$18,$0A,$08,$1A,$08,$00,$28,$06,$10,$30,$10,$28,$12,$00
	db $1A,$00
DATA8_CFF750:						; layout record for DATA8_CFF3A2 entry 37; not traced further
	db $06,$14,$18,$10,$08,$00,$08,$1A,$28,$06,$12,$30,$12,$28,$10,$00
	db $08,$00
DATA8_CFF762:						; layout record for DATA8_CFF3A2 entry 38; not traced further
	db $06,$10,$00,$10,$10,$00,$0A,$00,$1A,$06,$20,$00,$09,$2A,$20,$18
	db $08,$02
DATA8_CFF774:						; layout record for DATA8_CFF3A2 entry 39; not traced further
	db $06,$08,$00,$08,$10,$18,$0A,$18,$1A,$06,$00,$00,$17,$2A,$00,$18
	db $18,$02
DATA8_CFF786:						; layout record for DATA8_CFF3A2 entries 40, 41; not traced further
	db $00,$00,$00,$08
DATA8_CFF78A:						; layout record for DATA8_CFF3A2 entry 42; not traced further
	db $02,$10,$10,$00,$00,$08
DATA8_CFF790:						; layout record for DATA8_CFF3A2 entry 43; not traced further
	db $02,$00,$10,$10,$00,$08
DATA8_CFF796:						; layout record for DATA8_CFF3A2 entry 44; not traced further
	db $06,$00,$20,$00,$10,$10,$20,$00,$00,$06,$10,$18,$18,$10,$10,$10
	db $18,$18
DATA8_CFF7A8:						; layout record for DATA8_CFF3A2 entry 45; not traced further
	db $06,$10,$20,$10,$10,$00,$20,$10,$00,$06,$08,$18,$00,$10,$08,$10
	db $00,$18
DATA8_CFF7BA:						; layout record for DATA8_CFF3A2 entry 46; not traced further
	db $06,$08,$18,$18,$18,$08,$08,$18,$08,$06,$00,$17,$00,$1F,$18,$00
	db $20,$00
DATA8_CFF7CC:						; layout record for DATA8_CFF3A2 entry 47; not traced further
	db $06,$10,$18,$00,$18,$10,$08,$00,$08,$06,$20,$17,$20,$1F,$08,$00
	db $00,$00
DATA8_CFF7DE:						; layout record for DATA8_CFF3A2 entry 48; not traced further
	db $06,$20,$0B,$10,$08,$10,$18,$00,$18,$06,$18,$00,$10,$00,$08,$08
	db $08,$10
DATA8_CFF7F0:						; layout record for DATA8_CFF3A2 entry 49; not traced further
	db $06,$00,$0B,$10,$08,$10,$18,$20,$18,$06,$10,$00,$18,$00,$20,$08
	db $20,$10
DATA8_CFF802:						; layout record for DATA8_CFF3A2 entry 50; not traced further
	db $06,$0A,$10,$14,$00,$10,$20,$00,$20,$06,$24,$08,$24,$00,$1A,$10
	db $1A,$18
DATA8_CFF814:						; layout record for DATA8_CFF3A2 entry 51; not traced further
	db $06,$12,$10,$08,$00,$0C,$20,$1C,$20,$06,$00,$08,$00,$00,$0A,$10
	db $0A,$18
DATA8_CFF826:						; layout record for DATA8_CFF3A2 entry 52; not traced further
	db $06,$10,$10,$00,$10,$10,$00,$00,$00,$06,$20,$00,$20,$08,$28,$00
	db $28,$08
DATA8_CFF838:						; layout record for DATA8_CFF3A2 entry 53; not traced further
	db $06,$10,$10,$20,$10,$10,$00,$20,$00,$06,$08,$00,$08,$08,$00,$00
	db $00,$08
DATA8_CFF84A:						; layout record for DATA8_CFF3A2 entry 54; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$06,$20,$18,$20,$10,$28,$18
	db $28,$10
DATA8_CFF85C:						; layout record for DATA8_CFF3A2 entry 55; not traced further
	db $06,$10,$00,$20,$00,$10,$10,$20,$10,$06,$08,$18,$08,$10,$00,$18
	db $00,$10
DATA8_CFF86E:						; layout record for DATA8_CFF3A2 entry 56; not traced further
	db $06,$16,$08,$19,$18,$09,$18,$06,$08,$04,$10,$00,$08,$00,$00,$00
DATA8_CFF87E:						; layout record for DATA8_CFF3A2 entry 57; not traced further
	db $06,$03,$08,$00,$18,$10,$18,$13,$08,$04,$11,$00,$19,$00,$21,$00
DATA8_CFF88E:						; layout record for DATA8_CFF3A2 entry 58; not traced further
	db $06,$18,$20,$08,$20,$10,$10,$0C,$00,$06,$04,$01,$00,$24,$00,$18
	db $08,$18
DATA8_CFF8A0:						; layout record for DATA8_CFF3A2 entry 59; not traced further
	db $06,$00,$20,$10,$20,$08,$10,$0C,$00,$06,$1C,$01,$20,$24,$20,$18
	db $18,$18
DATA8_CFF8B2:						; layout record for DATA8_CFF3A2 entry 60; not traced further
	db $06,$18,$0E,$18,$1E,$08,$04,$08,$14,$06,$28,$1F,$00,$00,$00,$13
	db $00,$1B
DATA8_CFF8C4:						; layout record for DATA8_CFF3A2 entry 61; not traced further
	db $06,$08,$0E,$08,$1E,$18,$04,$18,$14,$06,$00,$1F,$28,$00,$28,$13
	db $28,$1B
DATA8_CFF8D6:						; layout record for DATA8_CFF3A2 entry 62; not traced further
	db $06,$20,$22,$10,$18,$10,$08,$00,$18,$04,$20,$1A,$18,$28,$0C,$00
DATA8_CFF8E6:						; layout record for DATA8_CFF3A2 entry 63; not traced further
	db $06,$00,$22,$10,$18,$10,$08,$20,$18,$04,$08,$1A,$10,$28,$1C,$00
DATA8_CFF8F6:						; layout record for DATA8_CFF3A2 entry 64; not traced further
	db $06,$08,$0A,$28,$0A,$18,$00,$18,$10,$06,$10,$02,$00,$12,$28,$02
	db $00,$0A
DATA8_CFF908:						; layout record for DATA8_CFF3A2 entry 65; not traced further
	db $06,$20,$0A,$00,$0A,$10,$00,$10,$10,$06,$20,$02,$30,$12,$08,$02
	db $30,$0A
DATA8_CFF91A:						; layout record for DATA8_CFF3A2 entry 66; not traced further
	db $06,$08,$00,$18,$00,$08,$10,$18,$10,$04,$00,$18,$00,$20,$08,$20
DATA8_CFF92A:						; layout record for DATA8_CFF3A2 entry 67; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$04,$20,$18,$20,$20,$18,$20
DATA8_CFF93A:						; layout record for DATA8_CFF3A2 entry 68; not traced further
	db $06,$28,$16,$10,$17,$10,$07,$00,$00,$06,$20,$0C,$20,$14,$20,$1C
	db $20,$24
DATA8_CFF94C:						; layout record for DATA8_CFF3A2 entry 69; not traced further
	db $06,$00,$16,$18,$17,$18,$07,$28,$00,$06,$10,$0C,$10,$14,$10,$1C
	db $10,$24
DATA8_CFF95E:						; layout record for DATA8_CFF3A2 entry 70; not traced further
	db $06,$10,$00,$00,$00,$20,$00,$00,$10,$04,$30,$08,$30,$10,$30,$18
DATA8_CFF96E:						; layout record for DATA8_CFF3A2 entry 71; not traced further
	db $06,$18,$00,$28,$00,$08,$00,$28,$10,$04,$00,$08,$00,$10,$00,$18
DATA8_CFF97E:						; layout record for DATA8_CFF3A2 entry 72; not traced further
	db $06,$00,$1B,$10,$00,$10,$10,$20,$10,$06,$20,$08,$30,$10,$30,$18
	db $20,$00
DATA8_CFF990:						; layout record for DATA8_CFF3A2 entry 73; not traced further
	db $06,$28,$1B,$18,$00,$18,$10,$08,$10,$06,$10,$08,$00,$10,$00,$18
	db $10,$00
DATA8_CFF9A2:						; layout record for DATA8_CFF3A2 entry 74; not traced further
	db $06,$28,$09,$18,$00,$18,$10,$08,$10,$06,$10,$08,$00,$10,$00,$18
	db $10,$00
DATA8_CFF9B4:						; layout record for DATA8_CFF3A2 entry 75; not traced further
	db $06,$00,$09,$10,$00,$10,$10,$20,$10,$06,$20,$08,$30,$10,$30,$18
	db $20,$00
DATA8_CFF9C6:						; layout record for DATA8_CFF3A2 entry 76; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$04,$20,$18,$28,$1C,$30,$1E
DATA8_CFF9D6:						; layout record for DATA8_CFF3A2 entry 77; not traced further
	db $06,$18,$00,$28,$00,$18,$10,$28,$10,$04,$10,$18,$08,$1C,$00,$1E
DATA8_CFF9E6:						; layout record for DATA8_CFF3A2 entry 78; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$04,$20,$1A,$24,$22,$27,$2A
DATA8_CFF9F6:						; layout record for DATA8_CFF3A2 entry 79; not traced further
	db $06,$0F,$00,$1F,$00,$0F,$10,$1F,$10,$04,$07,$1A,$03,$22,$00,$2A
DATA8_CFFA06:						; layout record for DATA8_CFF3A2 entry 80; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$02,$1B,$20,$23,$20
DATA8_CFFA14:						; layout record for DATA8_CFF3A2 entry 81; not traced further
	db $06,$0B,$00,$1B,$00,$0B,$10,$1B,$10,$02,$08,$20,$00,$20
DATA8_CFFA22:						; layout record for DATA8_CFF3A2 entry 82; not traced further
	db $06,$10,$00,$00,$10,$10,$10,$20,$0A,$04,$08,$00,$08,$08,$30,$13
DATA8_CFFA32:						; layout record for DATA8_CFF3A2 entry 83; not traced further
	db $06,$18,$00,$28,$10,$18,$10,$08,$0A,$04,$28,$00,$28,$08,$00,$13
DATA8_CFFA42:						; layout record for DATA8_CFF3A2 entry 84; not traced further
	db $06,$08,$00,$18,$09,$08,$10,$08,$20,$06,$28,$0C,$00,$0B,$00,$13
	db $00,$1B
DATA8_CFFA54:						; layout record for DATA8_CFF3A2 entry 85; not traced further
	db $06,$18,$00,$08,$09,$18,$10,$18,$20,$06,$00,$0C,$28,$0B,$28,$13
	db $28,$1B
DATA8_CFFA66:						; layout record for DATA8_CFF3A2 entry 86; not traced further
	db $06,$20,$02,$10,$00,$10,$10,$00,$10,$00,$08,$08
DATA8_CFFA72:						; layout record for DATA8_CFF3A2 entry 87; not traced further
	db $06,$00,$02,$10,$00,$10,$10,$20,$10,$00,$20,$08
DATA8_CFFA7E:						; layout record for DATA8_CFF3A2 entry 88; not traced further
	db $06,$10,$00,$20,$10,$10,$10,$00,$0A,$06,$20,$00,$20,$08,$28,$08
	db $28,$00
DATA8_CFFA90:						; layout record for DATA8_CFF3A2 entry 89; not traced further
	db $06,$10,$00,$00,$10,$10,$10,$20,$0A,$06,$08,$00,$08,$08,$00,$08
	db $00,$00
DATA8_CFFAA2:						; layout record for DATA8_CFF3A2 entry 90; not traced further
	db $06,$10,$00,$20,$10,$10,$10,$00,$0A,$02,$20,$00,$20,$08
DATA8_CFFAB0:						; layout record for DATA8_CFF3A2 entry 91; not traced further
	db $06,$10,$00,$00,$10,$10,$10,$20,$0A,$02,$08,$00,$08,$08
DATA8_CFFABE:						; layout record for DATA8_CFF3A2 entry 92; not traced further
	db $06,$20,$08,$10,$08,$20,$18,$10,$18,$06,$20,$00,$18,$00,$08,$0E
	db $00,$0E
DATA8_CFFAD0:						; layout record for DATA8_CFF3A2 entry 93; not traced further
	db $06,$00,$08,$10,$08,$00,$18,$10,$18,$06,$08,$00,$10,$00,$20,$0E
	db $28,$0E
DATA8_CFFAE2:						; layout record for DATA8_CFF3A2 entry 94; not traced further
	db $06,$28,$09,$18,$00,$18,$10,$08,$10,$06,$2F,$01,$10,$08,$00,$10
	db $00,$18
DATA8_CFFAF4:						; layout record for DATA8_CFF3A2 entry 95; not traced further
	db $06,$00,$09,$10,$00,$10,$10,$20,$10,$06,$01,$01,$20,$08,$30,$10
	db $30,$18
DATA8_CFFB06:						; layout record for DATA8_CFF3A2 entry 96; not traced further
	db $06,$28,$09,$18,$00,$18,$10,$08,$10,$04,$10,$08,$00,$10,$00,$18
DATA8_CFFB16:						; layout record for DATA8_CFF3A2 entry 97; not traced further
	db $06,$00,$09,$10,$00,$10,$10,$20,$10,$04,$20,$08,$30,$10,$30,$18
DATA8_CFFB26:						; layout record for DATA8_CFF3A2 entry 98; not traced further
	db $06,$18,$04,$18,$14,$08,$04,$08,$14,$06,$00,$13,$00,$1B,$28,$00
	db $00,$0B
DATA8_CFFB38:						; layout record for DATA8_CFF3A2 entry 99; not traced further
	db $06,$08,$04,$08,$14,$18,$04,$18,$14,$06,$28,$13,$28,$1B,$00,$00
	db $28,$0B
DATA8_CFFB4A:						; layout record for DATA8_CFF3A2 entry 100; not traced further
	db $06,$10,$20,$10,$10,$10,$00,$00,$00,$04,$08,$10,$08,$18,$08,$20
DATA8_CFFB5A:						; layout record for DATA8_CFF3A2 entry 101; not traced further
	db $06,$00,$20,$00,$10,$00,$00,$10,$00,$04,$10,$10,$10,$18,$10,$20
DATA8_CFFB6A:						; layout record for DATA8_CFF3A2 entry 102; not traced further
	db $06,$20,$10,$10,$10,$08,$00,$18,$00,$02,$30,$10,$00,$00
DATA8_CFFB78:						; layout record for DATA8_CFF3A2 entry 103; not traced further
	db $06,$08,$10,$18,$10,$20,$00,$10,$00,$02,$00,$10,$30,$00
DATA8_CFFB86:						; layout record for DATA8_CFF3A2 entry 104; not traced further
	db $06,$00,$20,$00,$10,$10,$20,$00,$00,$00,$10,$18
DATA8_CFFB92:						; layout record for DATA8_CFF3A2 entry 105; not traced further
	db $06,$10,$20,$10,$10,$00,$20,$10,$00,$00,$08,$18
DATA8_CFFB9E:						; layout record for DATA8_CFF3A2 entry 106; not traced further
	db $06,$18,$18,$18,$08,$08,$18,$08,$08,$02,$00,$0D,$19,$00
DATA8_CFFBAC:						; layout record for DATA8_CFF3A2 entry 107; not traced further
	db $06,$00,$18,$00,$08,$10,$18,$10,$08,$02,$20,$0D,$07,$00
DATA8_CFFBBA:						; layout record for DATA8_CFF3A2 entry 108; not traced further
	db $04,$10,$08,$00,$08,$10,$18,$06,$18,$28,$10,$28,$08,$18,$08,$00
DATA8_CFFBCA:						; layout record for DATA8_CFF3A2 entry 109; not traced further
	db $04,$00,$08,$10,$08,$00,$18,$06,$00,$28,$08,$28,$10,$18,$10,$00
DATA8_CFFBDA:						; layout record for DATA8_CFF3A2 entry 110; not traced further
	db $06,$00,$00,$10,$00,$00,$10,$10,$10,$04,$00,$20,$08,$20,$10,$20
DATA8_CFFBEA:						; layout record for DATA8_CFF3A2 entry 111; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$04,$18,$20,$10,$20,$08,$20
DATA8_CFFBFA:						; layout record for DATA8_CFF3A2 entry 112; not traced further
	db $06,$18,$00,$18,$10,$08,$00,$08,$10,$04,$00,$00,$00,$08,$00,$10
DATA8_CFFC0A:						; layout record for DATA8_CFF3A2 entry 113; not traced further
	db $06,$00,$00,$00,$10,$10,$00,$10,$10,$04,$20,$00,$20,$08,$20,$10
DATA8_CFFC1A:						; layout record for DATA8_CFF3A2 entry 114; not traced further
	db $06,$00,$08,$10,$08,$01,$18,$11,$18,$06,$16,$00,$0E,$00,$04,$28
	db $11,$28
DATA8_CFFC2C:						; layout record for DATA8_CFF3A2 entry 115; not traced further
	db $06,$11,$08,$01,$08,$10,$18,$00,$18,$06,$03,$00,$0B,$00,$15,$28
	db $08,$28
DATA8_CFFC3E:						; layout record for DATA8_CFF3A2 entry 116; not traced further
	db $06,$11,$10,$01,$10,$10,$20,$00,$20,$06,$18,$00,$18,$08,$15,$30
	db $08,$30
DATA8_CFFC50:						; layout record for DATA8_CFF3A2 entry 117; not traced further
	db $06,$00,$10,$10,$10,$01,$20,$11,$20,$06,$01,$00,$01,$08,$04,$30
	db $11,$30
DATA8_CFFC62:						; layout record for DATA8_CFF3A2 entry 118; not traced further
	db $06,$20,$10,$10,$10,$00,$10,$09,$00,$02,$30,$17,$01,$08
DATA8_CFFC70:						; layout record for DATA8_CFF3A2 entry 119; not traced further
	db $06,$08,$10,$18,$10,$28,$10,$1F,$00,$02,$00,$17,$2F,$08
DATA8_CFFC7E:						; layout record for DATA8_CFF3A2 entry 120; not traced further
	db $06,$00,$00,$10,$00,$00,$10,$10,$10,$06,$0F,$20,$0F,$28,$07,$20
	db $07,$28
DATA8_CFFC90:						; layout record for DATA8_CFF3A2 entry 121; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$06,$09,$20,$09,$28,$11,$20
	db $11,$28
DATA8_CFFCA2:						; layout record for DATA8_CFF3A2 entry 122; not traced further
	db $08,$00,$00,$00
DATA8_CFFCA6:						; layout record for DATA8_CFF3A2 entry 123; not traced further
	db $08,$00,$00,$00
DATA8_CFFCAA:						; layout record for DATA8_CFF3A2 entry 124; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$08
DATA8_CFFCB4:						; layout record for DATA8_CFF3A2 entry 125; not traced further
	db $06,$00,$00,$10,$00,$00,$10,$10,$10,$08
DATA8_CFFCBE:						; layout record for DATA8_CFF3A2 entry 126; not traced further
	db $06,$10,$00,$00,$00,$10,$10,$00,$10,$00,$20,$18
DATA8_CFFCCA:						; layout record for DATA8_CFF3A2 entry 127; not traced further
	db $06,$08,$00,$18,$00,$08,$10,$18,$10,$00,$00,$18
DATA8_CFFCD6:						; layout record for DATA8_CFF3A2 entry 128; not traced further
	db $06,$10,$08,$00,$08,$13,$18,$03,$18,$06,$02,$00,$0A,$00,$12,$28
	db $0A,$28
DATA8_CFFCE8:						; layout record for DATA8_CFF3A2 entry 129; not traced further
	db $06,$03,$08,$13,$08,$00,$18,$10,$18,$06,$19,$00,$11,$00,$09,$28
	db $11,$28
DATA8_CFFCFA:						; layout record for DATA8_CFF3A2 entry 130; not traced further
	db $06,$13,$02,$03,$02,$10,$12,$00,$12,$06,$2B,$00,$23,$00,$2B,$08
	db $23,$08
DATA8_CFFD0C:						; layout record for DATA8_CFF3A2 entry 131; not traced further
	db $06,$10,$02,$20,$02,$13,$12,$23,$12,$06,$00,$00,$08,$00,$00,$08
	db $08,$08
DATA8_CFFD1E:						; layout record for DATA8_CFF3A2 entry 132; not traced further
	db $04,$00,$00,$00,$10,$10,$06,$00,$10,$16
DATA8_CFFD28:						; layout record for DATA8_CFF3A2 entry 133; not traced further
	db $04,$10,$00,$10,$10,$00,$06,$00,$08,$16
DATA8_CFFD32:						; layout record for DATA8_CFF3A2 entry 134; not traced further
	db $06,$00,$00,$00,$10,$10,$06,$10,$16,$08
DATA8_CFFD3C:						; layout record for DATA8_CFF3A2 entry 135; not traced further
	db $06,$10,$00,$10,$10,$00,$06,$00,$16,$08
DATA8_CFFD46:						; layout record for DATA8_CFF3A2 entry 136; not traced further
	db $06,$30,$14,$18,$17,$18,$07,$08,$00,$06,$28,$0C,$28,$14,$28,$1C
	db $00,$01
DATA8_CFFD58:						; layout record for DATA8_CFF3A2 entry 137; not traced further
	db $06,$00,$14,$18,$17,$18,$07,$28,$00,$06,$10,$0C,$10,$14,$10,$1C
	db $38,$01
DATA8_CFFD6A:						; layout record for DATA8_CFF3A2 entry 138; not traced further
	db $06,$40,$0A,$30,$0A,$20,$00,$20,$10,$06,$00,$07,$10,$07,$08,$07
	db $18,$07
DATA8_CFFD7C:						; layout record for DATA8_CFF3A2 entry 139; not traced further
	db $06,$00,$0A,$10,$0A,$20,$00,$20,$10,$06,$48,$07,$38,$07,$40,$07
	db $30,$07
DATA8_CFFD8E:						; layout record for DATA8_CFF3A2 entry 140; not traced further
	db $04,$10,$00,$10,$10,$00,$06,$08
DATA8_CFFD96:						; layout record for DATA8_CFF3A2 entry 141; not traced further
	db $04,$00,$00,$00,$10,$10,$06,$08
CODE_CFFD9E:						; reached by jmp (DATA8_CFF3A2,x) / (DATA8_CFF3A0,x): entries 142 and 143
	pei ($A3)
	ldx.w #$0002
	lda.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, if $0C >= 0 go to .3, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to .5
	pla
	bra .5
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.5:									; A = tmp2, A + $0002, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$0002
	pha
	ldx.w #$0002
	clc
	lda.w #$0010
	adc.b $0A
	bpl .6
	cmp.w #$FFF1
	bcc .7
	inx
	and.w #$00FF
.6:									; if A >= $0100 go to .7, tmp0 = A, if $0C >= 0 go to .8, ...
	cmp.w #$0100
	bcs .7
	sta.b tmp0
	lda.b $0C
	bpl .8
	cmp.w #$FFF1
	and.w #$00FF
	bcs .9
.7:									; pull A, go to .10
	pla
	bra .10
.8:									; if A >= $00E0 go to .7
	cmp.w #$00E0
	bcs .7
.9:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.10:								; A = tmp2, A + $0004, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$0004
	pha
	ldx.w #$0002
	lda.b $0A
	bpl .11
	cmp.w #$FFF1
	bcc .12
	inx
	and.w #$00FF
.11:								; if A >= $0100 go to .12, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .12
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .13
	cmp.w #$FFF1
	and.w #$00FF
	bcs .14
.12:								; pull A, go to .15
	pla
	bra .15
.13:								; if A >= $00E0 go to .12
	cmp.w #$00E0
	bcs .12
.14:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.15:								; A = tmp2, A + $0006, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$0006
	pha
	ldx.w #$0002
	clc
	lda.w #$0010
	adc.b $0A
	bpl .16
	cmp.w #$FFF1
	bcc .17
	inx
	and.w #$00FF
.16:								; if A >= $0100 go to .17, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .17
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .18
	cmp.w #$FFF1
	and.w #$00FF
	bcs .19
.17:								; pull A, go to .20
	pla
	bra .20
.18:								; if A >= $00E0 go to .17
	cmp.w #$00E0
	bcs .17
.19:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.20:								; A = tmp2, A + $4000, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$4000
	pha
	ldx.w #$0002
	clc
	lda.w #$002D
	adc.b $0A
	bpl .21
	cmp.w #$FFF1
	bcc .22
	inx
	and.w #$00FF
.21:								; if A >= $0100 go to .22, tmp0 = A, if $0C >= 0 go to .23, ...
	cmp.w #$0100
	bcs .22
	sta.b tmp0
	lda.b $0C
	bpl .23
	cmp.w #$FFF1
	and.w #$00FF
	bcs .24
.22:								; pull A, go to .25
	pla
	bra .25
.23:								; if A >= $00E0 go to .22
	cmp.w #$00E0
	bcs .22
.24:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.25:								; A = tmp2, A + $4002, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$4002
	pha
	ldx.w #$0002
	clc
	lda.w #$001D
	adc.b $0A
	bpl .26
	cmp.w #$FFF1
	bcc .27
	inx
	and.w #$00FF
.26:								; if A >= $0100 go to .27, tmp0 = A, if $0C >= 0 go to .28, ...
	cmp.w #$0100
	bcs .27
	sta.b tmp0
	lda.b $0C
	bpl .28
	cmp.w #$FFF1
	and.w #$00FF
	bcs .29
.27:								; pull A, go to .30
	pla
	bra .30
.28:								; if A >= $00E0 go to .27
	cmp.w #$00E0
	bcs .27
.29:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.30:								; A = tmp2, A + $4004, push A, X = $0002
	clc
	lda.b tmp2
	adc.w #$4004
	pha
	ldx.w #$0002
CODE_CFFF0F:						; called from other segments
	clc
	lda.w #$002D
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to .5
	pla
	bra .5
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.5:									; A = tmp2, A + $4006, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$4006
	pha
	ldx.w #$0002
	clc
	lda.w #$001D
	adc.b $0A
	bpl .6
	cmp.w #$FFF1
	bcc .7
	inx
	and.w #$00FF
.6:									; if A >= $0100 go to .7, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .7
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .8
	cmp.w #$FFF1
	and.w #$00FF
	bcs .9
.7:									; pull A, go to .10
	pla
	bra .10
.8:									; if A >= $00E0 go to .7
	cmp.w #$00E0
	bcs .7
.9:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.10:								; jump through $00A5
	jmp ($00A5)
CODE_CFFF88:						; reached by jmp (DATA8_CFF3A0,x): entries 144 and 145
	pei ($A1)
	ldx.w #$0000
	lda.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = puckz, A * 2, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.w puckz
	asl a
	adc.w puckz
	lsr a
	eor.w #$FFFF
	sec
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to .5
	pla
	bra .5
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.5:									; jump through $00A5
	jmp ($00A5)
	padbyte $00						; unused to the end of the ROM
	pad $D00000
