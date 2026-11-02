; Segment bankC4_2000: data tables (not traced yet), then game code (routines keep their address as a name,
; with their callers).
org $C42030
DATA8_C42030:						; not traced: more of the data from bankC4_1000 (pointer tables, lists)
	db $42,$20,$4A,$20,$52,$20,$5A,$20,$62,$20,$6A,$20,$72,$20,$7A,$20
	db $00,$00,$2A,$03,$0A,$00,$2A,$03,$F8,$FF,$2B,$03,$0A,$00,$2B,$03
	db $F8,$FF,$2C,$03,$0A,$00,$2C,$03,$F8,$FF,$2D,$03,$0A,$00,$2D,$03
	db $F8,$FF,$2E,$03,$0A,$00,$2E,$03,$F8,$FF,$2F,$03,$0A,$00,$2F,$03
	db $F8,$FF,$30,$03,$0A,$00,$30,$03,$F8,$FF,$31,$03,$0A,$00,$31,$03
	db $F8,$FF,$94,$20,$A0,$20,$AC,$20,$B8,$20,$C4,$20,$D0,$20,$DC,$20
	db $E8,$20,$00,$00,$A4,$00,$04,$00,$A6,$00,$08,$00,$A4,$00,$FC,$FF
	db $A6,$00,$04,$00,$A8,$00,$08,$00,$A6,$00,$FC,$FF,$A8,$00,$04,$00
	db $AA,$00,$08,$00,$A8,$00,$FC,$FF,$AA,$00,$04,$00,$AC,$00,$08,$00
	db $AA,$00,$FC,$FF,$AC,$00,$04,$00,$AE,$00,$08,$00,$AC,$00,$FC,$FF
	db $AE,$00,$04,$00,$B0,$00,$08,$00,$AE,$00,$FC,$FF,$B0,$00,$04,$00
	db $B2,$00,$08,$00,$B0,$00,$FC,$FF,$B2,$00,$04,$00,$B4,$00,$08,$00
	db $B2,$00,$FC,$FF,$06,$21,$0A,$21,$0E,$21,$12,$21,$16,$21,$1A,$21
	db $1E,$21,$22,$21,$00,$00,$7B,$00,$E8,$FF,$7C,$00,$E8,$FF,$7D,$00
	db $E8,$FF,$7E,$00,$E8,$FF,$7F,$00,$E8,$FF,$80,$00,$E8,$FF,$81,$00
	db $E8,$FF,$82,$00,$E8,$FF,$38,$21,$3C,$21,$40,$21,$44,$21,$48,$21
	db $4C,$21,$50,$21,$54,$21,$00,$00,$83,$00,$E8,$FF,$84,$00,$E8,$FF
	db $85,$00,$E8,$FF,$86,$00,$E8,$FF,$87,$00,$E8,$FF,$88,$00,$E8,$FF
	db $89,$00,$E8,$FF,$8A,$00,$E8,$FF,$6A,$21,$6E,$21,$72,$21,$76,$21
	db $7A,$21,$7E,$21,$82,$21,$86,$21,$00,$00,$42,$03,$E8,$FF,$42,$03
	db $E8,$FF,$42,$03,$E8,$FF,$44,$03,$E8,$FF,$44,$03,$E8,$FF,$44,$03
	db $E8,$FF,$44,$03,$E8,$FF,$42,$03,$E8,$FF,$9C,$21,$A0,$21,$A4,$21
	db $A8,$21,$AC,$21,$B0,$21,$B4,$21,$B8,$21,$00,$00,$43,$03,$E8,$FF
	db $43,$03,$E8,$FF,$43,$03,$E8,$FF,$45,$03,$E8,$FF,$45,$03,$E8,$FF
	db $45,$03,$E8,$FF,$45,$03,$E8,$FF,$43,$03,$E8,$FF,$CE,$21,$DE,$21
	db $EE,$21,$FE,$21,$0E,$22,$1E,$22,$2E,$22,$3E,$22,$00,$00,$0B,$01
	db $06,$00,$0C,$01,$06,$00,$0D,$01,$06,$00,$0E,$01,$FA,$FF,$13,$01
	db $06,$00,$14,$01,$06,$00,$15,$01,$06,$00,$16,$01,$FA,$FF,$1B,$01
	db $06,$00,$1C,$01,$06,$00,$1D,$01,$06,$00,$1E,$01,$FA,$FF,$23,$01
	db $06,$00,$24,$01,$06,$00,$25,$01,$06,$00,$26,$01,$FA,$FF,$2B,$01
	db $06,$00,$2C,$01,$06,$00,$2D,$01,$06,$00,$2E,$01,$FA,$FF,$33,$01
	db $06,$00,$34,$01,$06,$00,$35,$01,$06,$00,$36,$01,$FA,$FF,$3B,$01
	db $06,$00,$3C,$01,$06,$00,$3D,$01,$06,$00,$3E,$01,$FA,$FF,$43,$01
	db $06,$00,$44,$01,$06,$00,$45,$01,$06,$00,$46,$01,$FA,$FF,$60,$22
	db $64,$22,$68,$22,$6C,$22,$70,$22,$74,$22,$78,$22,$7C,$22,$00,$00
	db $9B,$00,$E2,$FF,$9C,$00,$E2,$FF,$9D,$00,$E2,$FF,$9E,$00,$E2,$FF
	db $9F,$00,$E2,$FF,$A0,$00,$E2,$FF,$A1,$00,$E2,$FF,$A2,$00,$E2,$FF
	db $92,$22,$96,$22,$9A,$22,$9E,$22,$A2,$22,$A6,$22,$AA,$22,$AE,$22
	db $00,$00,$9B,$00,$DC,$FF,$9C,$00,$DC,$FF,$9D,$00,$DC,$FF,$9E,$00
	db $DC,$FF,$9F,$00,$DC,$FF,$A0,$00,$DC,$FF,$A1,$00,$DC,$FF,$A2,$00
	db $DC,$FF,$C4,$22,$D4,$22,$E4,$22,$F4,$22,$04,$23,$14,$23,$24,$23
	db $34,$23,$00,$00,$8B,$00,$04,$00,$8C,$00,$04,$00,$8B,$00,$04,$00
	db $8C,$00,$FC,$FF,$8D,$00,$04,$00,$8E,$00,$04,$00,$8D,$00,$04,$00
	db $8E,$00,$FC,$FF,$8F,$00,$04,$00,$90,$00,$04,$00,$8F,$00,$04,$00
	db $90,$00,$FC,$FF,$91,$00,$04,$00,$92,$00,$04,$00,$91,$00,$04,$00
	db $92,$00,$FC,$FF,$93,$00,$04,$00,$94,$00,$04,$00,$93,$00,$04,$00
	db $94,$00,$FC,$FF,$95,$00,$04,$00,$96,$00,$04,$00,$95,$00,$04,$00
	db $96,$00,$FC,$FF,$97,$00,$04,$00,$98,$00,$04,$00,$97,$00,$04,$00
	db $98,$00,$FC,$FF,$99,$00,$04,$00,$9A,$00,$04,$00,$99,$00,$04,$00
	db $9A,$00,$FC,$FF,$56,$23,$5A,$23,$5E,$23,$62,$23,$66,$23,$6A,$23
	db $6E,$23,$72,$23,$00,$00,$02,$00,$D3,$FF,$0A,$00,$D3,$FF,$12,$00
	db $D3,$FF,$1A,$00,$D3,$FF,$22,$00,$D3,$FF,$2A,$00,$D3,$FF,$32,$00
	db $D3,$FF,$3A,$00,$D3,$FF,$88,$23,$A0,$23,$B8,$23,$D0,$23,$E8,$23
	db $00,$24,$18,$24,$30,$24,$00,$00,$B3,$00,$06,$00,$B4,$00,$06,$00
	db $B5,$00,$06,$00,$B6,$00,$64,$00,$B7,$00,$08,$00,$B8,$00,$F8,$FF
	db $B9,$00,$06,$00,$BA,$00,$06,$00,$BB,$00,$06,$00,$BC,$00,$64,$00
	db $BD,$00,$08,$00,$BE,$00,$F8,$FF,$BF,$00,$06,$00,$C0,$00,$06,$00
	db $C1,$00,$06,$00,$C2,$00,$64,$00,$C3,$00,$08,$00,$C4,$00,$F8,$FF
	db $C5,$00,$06,$00,$C6,$00,$06,$00,$C7,$00,$06,$00,$C8,$00,$64,$00
	db $C9,$00,$08,$00,$CA,$00,$F8,$FF,$CB,$00,$06,$00,$CC,$00,$06,$00
	db $CD,$00,$06,$00,$CE,$00,$64,$00,$CF,$00,$08,$00,$D0,$00,$F8,$FF
	db $D1,$00,$06,$00,$D2,$00,$06,$00,$D3,$00,$06,$00,$D4,$00,$64,$00
	db $D5,$00,$08,$00,$D6,$00,$F8,$FF,$D7,$00,$06,$00,$D8,$00,$06,$00
	db $D9,$00,$06,$00,$DA,$00,$64,$00,$DB,$00,$08,$00,$DC,$00,$F8,$FF
	db $DD,$00,$06,$00,$DE,$00,$06,$00,$DF,$00,$06,$00,$E0,$00,$64,$00
	db $E1,$00,$08,$00,$E2,$00,$F8,$FF,$5A,$24,$6E,$24,$82,$24,$96,$24
	db $AA,$24,$BE,$24,$D2,$24,$E6,$24,$00,$00,$E3,$00,$06,$00,$E4,$00
	db $06,$00,$E5,$00,$06,$00,$E6,$00,$64,$00,$E7,$00,$F8,$FF,$E8,$00
	db $06,$00,$E9,$00,$06,$00,$EA,$00,$06,$00,$EB,$00,$64,$00,$EC,$00
	db $F8,$FF,$ED,$00,$06,$00,$EE,$00,$06,$00,$EF,$00,$06,$00,$F0,$00
	db $64,$00,$F1,$00,$F8,$FF,$F2,$00,$06,$00,$F3,$00,$06,$00,$F4,$00
	db $06,$00,$F5,$00,$64,$00,$F6,$00,$F8,$FF,$F7,$00,$06,$00,$F8,$00
	db $06,$00,$F9,$00,$06,$00,$FA,$00,$64,$00,$FB,$00,$F8,$FF,$FC,$00
	db $06,$00,$FD,$00,$06,$00,$FE,$00,$06,$00,$FF,$00,$64,$00,$00,$01
	db $F8,$FF,$01,$01,$06,$00,$02,$01,$06,$00,$03,$01,$06,$00,$04,$01
	db $64,$00,$05,$01,$F8,$FF,$06,$01,$06,$00,$07,$01,$06,$00,$08,$01
	db $06,$00,$09,$01,$64,$00,$0A,$01,$F8,$FF,$0C,$25,$18,$25,$18,$25
	db $18,$25,$18,$25,$18,$25,$18,$25,$18,$25,$00,$00,$A3,$00,$02,$00
	db $A4,$00,$0A,$00,$4D,$01,$FA,$FF,$AB,$00,$02,$00,$AC,$00,$0A,$00
	db $6D,$01,$FA,$FF,$36,$25,$3A,$25,$3A,$25,$3A,$25,$3A,$25,$3A,$25
	db $3A,$25,$3A,$25,$00,$00,$4D,$01,$FB,$FF,$6D,$01,$FB,$FF,$50,$25
	db $50,$25,$50,$25,$50,$25,$50,$25,$50,$25,$50,$25,$50,$25,$01,$00
	db $BD,$02,$03,$00,$BE,$02,$03,$00,$BF,$02,$03,$00,$C0,$02,$03,$00
	db $C1,$02,$03,$00,$C2,$02,$03,$00,$C3,$02,$03,$00,$C4,$02,$03,$00
	db $C5,$02,$03,$00,$C6,$02,$03,$00,$C7,$02,$03,$00,$C8,$02,$03,$00
	db $C9,$02,$03,$00,$CA,$02,$FD,$FF,$9A,$25,$9A,$25,$9A,$25,$9A,$25
	db $B6,$25,$B6,$25,$B6,$25,$B6,$25,$00,$00,$12,$03,$06,$00,$58,$02
	db $06,$00,$59,$02,$06,$00,$5A,$02,$06,$00,$E5,$00,$64,$00,$E6,$00
	db $08,$00,$E7,$00,$F8,$FF,$19,$03,$06,$00,$5B,$02,$06,$00,$5C,$02
	db $06,$00,$5D,$02,$06,$00,$F9,$00,$64,$00,$FA,$00,$08,$00,$FB,$00
	db $F8,$FF,$E4,$25,$F8,$25,$0C,$26,$20,$26,$34,$26,$48,$26,$5C,$26
	db $70,$26,$00,$00,$20,$02,$06,$00,$21,$02,$06,$00,$21,$02,$08,$00
	db $22,$02,$06,$00,$23,$02,$FA,$FF,$24,$02,$06,$00,$25,$02,$06,$00
	db $25,$02,$08,$00,$26,$02,$06,$00,$27,$02,$FA,$FF,$28,$02,$06,$00
	db $29,$02,$06,$00,$29,$02,$08,$00,$2A,$02,$06,$00,$2B,$02,$FA,$FF
	db $2C,$02,$06,$00,$2D,$02,$06,$00,$2D,$02,$08,$00,$2E,$02,$06,$00
	db $2F,$02,$FA,$FF,$30,$02,$06,$00,$31,$02,$06,$00,$31,$02,$08,$00
	db $32,$02,$06,$00,$33,$02,$FA,$FF,$34,$02,$06,$00,$35,$02,$06,$00
	db $35,$02,$08,$00,$36,$02,$06,$00,$37,$02,$FA,$FF,$38,$02,$06,$00
	db $39,$02,$06,$00,$39,$02,$08,$00,$3A,$02,$06,$00,$3B,$02,$FA,$FF
	db $3C,$02,$06,$00,$3D,$02,$06,$00,$3D,$02,$08,$00,$3E,$02,$06,$00
	db $3F,$02,$FA,$FF,$96,$26,$9A,$26,$9E,$26,$A2,$26,$A6,$26,$AA,$26
	db $AE,$26,$B2,$26,$00,$00,$8C,$00,$E2,$FF,$8E,$00,$E2,$FF,$8E,$00
	db $E2,$FF,$90,$00,$E2,$FF,$92,$00,$E2,$FF,$94,$00,$E2,$FF,$94,$00
	db $E2,$FF,$96,$00,$E2,$FF,$C8,$26,$D0,$26,$D8,$26,$E0,$26,$E8,$26
	db $F0,$26,$F8,$26,$00,$27,$00,$00,$32,$03,$06,$00,$33,$03,$FA,$FF
	db $34,$03,$06,$00,$35,$03,$FA,$FF,$36,$03,$06,$00,$37,$03,$FA,$FF
	db $38,$03,$06,$00,$39,$03,$FA,$FF,$3A,$03,$06,$00,$3B,$03,$FA,$FF
	db $3C,$03,$06,$00,$3D,$03,$FA,$FF,$3E,$03,$06,$00,$3F,$03,$FA,$FF
	db $40,$03,$06,$00,$41,$03,$FA,$FF,$1A,$27,$1A,$27,$1A,$27,$66,$27
	db $66,$27,$66,$27,$66,$27,$1A,$27,$00,$00,$B4,$03,$0A,$00,$B5,$03
	db $0A,$00,$B6,$03,$0A,$00,$B4,$03,$0A,$00,$B5,$03,$0A,$00,$B6,$03
	db $0A,$00,$B4,$03,$0A,$00,$B5,$03,$0A,$00,$B6,$03,$0A,$00,$B4,$03
	db $0A,$00,$B5,$03,$0A,$00,$B6,$03,$0A,$00,$B4,$03,$0A,$00,$B5,$03
	db $0A,$00,$B6,$03,$0A,$00,$B4,$03,$0A,$00,$B5,$03,$0A,$00,$B6,$03
	db $0A,$00,$B4,$03,$18,$FC,$B7,$03,$0A,$00,$B8,$03,$0A,$00,$B9,$03
	db $0A,$00,$B7,$03,$0A,$00,$B8,$03,$0A,$00,$B9,$03,$0A,$00,$B7,$03
	db $0A,$00,$B8,$03,$0A,$00,$B9,$03,$0A,$00,$B7,$03,$0A,$00,$B8,$03
	db $0A,$00,$B9,$03,$0A,$00,$B7,$03,$0A,$00,$B8,$03,$0A,$00,$B9,$03
	db $0A,$00,$B7,$03,$0A,$00,$B8,$03,$0A,$00,$B9,$03,$0A,$00,$B7,$03
	db $18,$FC,$C4,$27,$D0,$27,$DC,$27,$E8,$27,$F4,$27,$00,$28,$0C,$28
	db $18,$28,$00,$00,$ED,$03,$08,$00,$EC,$03,$08,$00,$ED,$03,$EE,$FF
	db $EF,$03,$08,$00,$EE,$03,$08,$00,$EF,$03,$EE,$FF,$F1,$03,$08,$00
	db $F0,$03,$08,$00,$F1,$03,$EE,$FF,$F3,$03,$08,$00,$F2,$03,$08,$00
	db $F3,$03,$EE,$FF,$F5,$03,$08,$00,$F4,$03,$08,$00,$F5,$03,$EE,$FF
	db $F7,$03,$08,$00,$F6,$03,$08,$00,$F7,$03,$EE,$FF,$F9,$03,$08,$00
	db $F8,$03,$08,$00,$F9,$03,$EE,$FF,$FB,$03,$08,$00,$FA,$03,$08,$00
	db $FB,$03,$EE,$FF,$36,$28,$4E,$28,$66,$28,$7E,$28,$96,$28,$AE,$28
	db $C6,$28,$DE,$28,$00,$00,$46,$03,$05,$00,$47,$03,$06,$00,$47,$03
	db $06,$00,$46,$03,$0C,$00,$47,$03,$28,$00,$47,$03,$F1,$FF,$48,$03
	db $05,$00,$49,$03,$06,$00,$49,$03,$06,$00,$48,$03,$0C,$00,$49,$03
	db $28,$00,$49,$03,$F1,$FF,$4A,$03,$05,$00,$4B,$03,$06,$00,$4B,$03
	db $06,$00,$4A,$03,$0C,$00,$4B,$03,$28,$00,$4B,$03,$F1,$FF,$4C,$03
	db $05,$00,$4D,$03,$06,$00,$4D,$03,$06,$00,$4C,$03,$0C,$00,$4D,$03
	db $28,$00,$4D,$03,$F1,$FF,$4E,$03,$05,$00,$4F,$03,$06,$00,$4F,$03
	db $06,$00,$4E,$03,$0C,$00,$4F,$03,$28,$00,$4F,$03,$F1,$FF,$50,$03
	db $05,$00,$51,$03,$06,$00,$51,$03,$06,$00,$50,$03,$0C,$00,$51,$03
	db $28,$00,$51,$03,$F1,$FF,$52,$03,$05,$00,$53,$03,$06,$00,$53,$03
	db $06,$00,$52,$03,$0C,$00,$53,$03,$28,$00,$53,$03,$F1,$FF,$54,$03
	db $05,$00,$55,$03,$06,$00,$55,$03,$06,$00,$54,$03,$0C,$00,$55,$03
	db $28,$00,$55,$03,$F1,$FF,$08,$29,$08,$29,$24,$29,$24,$29,$3C,$29
	db $3C,$29,$58,$29,$58,$29,$00,$00,$78,$03,$06,$00,$79,$03,$06,$00
	db $7A,$03,$06,$00,$7B,$03,$4B,$00,$E7,$00,$06,$00,$CF,$00,$06,$00
	db $D0,$00,$FA,$FF,$7C,$03,$06,$00,$7D,$03,$06,$00,$7E,$03,$06,$00
	db $7F,$03,$4B,$00,$C3,$00,$06,$00,$C4,$00,$FA,$FF,$80,$03,$06,$00
	db $81,$03,$06,$00,$82,$03,$06,$00,$83,$03,$4B,$00,$FB,$00,$06,$00
	db $B7,$00,$06,$00,$B8,$00,$FA,$FF,$84,$03,$06,$00,$85,$03,$06,$00
	db $86,$03,$06,$00,$87,$03,$4B,$00,$DB,$00,$06,$00,$DC,$00,$FA,$FF
	db $82,$29,$82,$29,$9E,$29,$9E,$29,$B6,$29,$B6,$29,$D2,$29,$D2,$29
	db $00,$00,$98,$03,$06,$00,$99,$03,$06,$00,$9A,$03,$06,$00,$7B,$03
	db $4B,$00,$E7,$00,$06,$00,$CF,$00,$06,$00,$D0,$00,$FA,$FF,$9B,$03
	db $06,$00,$9C,$03,$06,$00,$9D,$03,$06,$00,$9E,$03,$4B,$00,$C3,$00
	db $06,$00,$C4,$00,$FA,$FF,$9F,$03,$06,$00,$A0,$03,$06,$00,$A1,$03
	db $06,$00,$83,$03,$4B,$00,$FB,$00,$06,$00,$B7,$00,$06,$00,$B8,$00
	db $FA,$FF,$A2,$03,$06,$00,$A3,$03,$06,$00,$A4,$03,$06,$00,$A5,$03
	db $4B,$00,$DB,$00,$06,$00,$DC,$00,$FA,$FF,$FC,$29,$FC,$29,$14,$2A
	db $14,$2A,$30,$2A,$30,$2A,$48,$2A,$48,$2A,$00,$00,$88,$03,$06,$00
	db $89,$03,$06,$00,$8A,$03,$06,$00,$8B,$03,$4B,$00,$B7,$00,$06,$00
	db $B8,$00,$FA,$FF,$8C,$03,$06,$00,$8D,$03,$06,$00,$8E,$03,$06,$00
	db $8F,$03,$4B,$00,$F1,$00,$06,$00,$DB,$00,$06,$00,$DC,$00,$FA,$FF
	db $90,$03,$06,$00,$91,$03,$06,$00,$92,$03,$06,$00,$93,$03,$4B,$00
	db $CF,$00,$06,$00,$D0,$00,$FA,$FF,$94,$03,$06,$00,$95,$03,$06,$00
	db $96,$03,$06,$00,$97,$03,$4B,$00,$05,$01,$06,$00,$C3,$00,$06,$00
	db $C4,$00,$FA,$FF,$76,$2A,$76,$2A,$8E,$2A,$8E,$2A,$AA,$2A,$AA,$2A
	db $C2,$2A,$C2,$2A,$00,$00,$A6,$03,$06,$00,$A7,$03,$06,$00,$A8,$03
	db $06,$00,$A9,$03,$4B,$00,$B7,$00,$06,$00,$B8,$00,$FA,$FF,$AA,$03
	db $06,$00,$AB,$03,$06,$00,$AC,$03,$06,$00,$8F,$03,$4B,$00,$F1,$00
	db $06,$00,$DB,$00,$06,$00,$DC,$00,$FA,$FF,$AD,$03,$06,$00,$AE,$03
	db $06,$00,$AF,$03,$06,$00,$B0,$03,$4B,$00,$CF,$00,$06,$00,$D0,$00
	db $FA,$FF,$B1,$03,$06,$00,$B2,$03,$06,$00,$B3,$03,$06,$00,$97,$03
	db $4B,$00,$05,$01,$06,$00,$C3,$00,$06,$00,$C4,$00,$FA,$FF,$04,$2B
	db $04,$2B,$F0,$2A,$F0,$2A,$F0,$2A,$F0,$2A,$04,$2B,$04,$2B,$00,$00
	db $20,$04,$0A,$00,$21,$04,$0A,$00,$22,$04,$0A,$00,$23,$04,$5A,$00
	db $23,$04,$EC,$FF,$1F,$04,$0A,$00,$1B,$04,$0A,$00,$1C,$04,$0A,$00
	db $1D,$04,$5A,$00,$1E,$04,$EC,$FF
GlideBack:							; starts animation $1F6C on player X (SetSPAFromA) unless pfalock is set
	lda.w pfalock,x
	bne .rtl
	lda.w #$1F6C
	jsl.l SetSPAFromA
.rtl:								; return
	rtl
assnearest:							; called from other segments
	lda.w pflags,x
	bit.w #$0002
	beq .1
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp3,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	stz.w temp1,x
.1:									; if position,x = 0 go to .2, if X is not puckc go to .3, d0 = $0011, ...
	lda.w position,x
	beq .2
	cpx.w puckc
	bne .3
	lda.w #$0011
	sta.b d0
	lda.w playerpad,x
	bpl .rtl
	jmp.w assinsert
.rtl:								; return
	rtl
.2:									; go to assgoalie
	jml.l assgoalie
.3:									; A = temp1,x, A - d7, temp1,x = A, if minus go to .4, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi .4
	jmp.w .16
.4:									; A + aioff,x, if the result >= 0 go to .5, A = $0000
	adc.w aioff,x
	bpl .5
	lda.w #$0000
.5:									; temp1,x = A, if puckc < 0 go to .6, if position,y = 0 go to .6, ...
	sta.w temp1,x
	ldy.w puckc
	bmi .6
	lda.w position,y
	beq .6
	sty.b a1
	lda.w pfteam,y
	eor.w pfteam,x
	bne .6
	jmp.w .7
.6:									; Y = a2, d2 = tmnear,y, a1 = tmnearpl,y, if d2 < 0 go to .8
	ldy.b a2
	lda.w tmnear,y
	sta.b d2
	lda.w tmnearpl,y
	sta.b a1
	lda.b d2
	bmi .8
.7:									; if X = a1 go to .8, if gmclock is not 0 go to .8, Y = a1, ...
	cpx.b a1
	beq .8
	lda.w gmclock
	bne .8
	ldy.b a1
	lda.w pflags,y
	bit.w #$1000
	bne .8
	lda.w position,y
	beq .8
	lda.w asscur,y
	cmp.w #$0015
	beq .8
	ldx.b a1
	lda.w pflags,x
	and.w #$FFFE
	sta.w pflags,x
	lda.w #$0012
	sta.b d0
	jsl.l assinsert
	ldx.b curobj
	jmp.w assexit
.8:									; d1 = $0002, if d2 >= $00E2 go to .9, d1 = 0, if position,x = 0 go to .16
	lda.w #$0002
	sta.b d1
	lda.b d2
	cmp.w #$00E2
	bcs .9
	stz.b d1
	lda.w position,x
	beq .16
.9:									; A = sflags, if $2000 bits clear go to .10, d1 - 1, d1 - 1, ...
	lda.w sflags
	bit.w #$2000
	beq .10
	dec.b d1
	dec.b d1
	jsl.l chkpk2
	bne .10
	inc.b d1
	inc.b d1
	inc.b d1
	inc.b d1
.10:								; A = $0014, A - checking,x, d0 = A, tmp0 = d1
	lda.w #$0014
	sec
	sbc.w checking,x
	sta.b d0
	lda.b d1
	sta.b tmp0
.loop:								; loop: tmp0 - 1, if the result < 0 go to .15, d0 * 2, go to .loop
	dec.b tmp0
	bmi .15
	asl.b d0
	bra .loop
.rtl2:								; return
	rtl
.11:								; if puckc < 0 go to .14, if position,y is not 0 go to .14, ...
	ldy.w puckc
	bmi .14
	lda.w position,y
	bne .14
	lda.w puckx
	sta.b d0
	lda.w #$005C
	ldy.w pfgoal,x
	bne .12
	lda.w #$FFA4
.12:								; d1 = A, $65 = $00C4, a0 = $883F, call skateto, ...
	sta.b d1
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	jsl.l skateto
	jmp.w check4check
.13:								; call GlideBack, go to donothing
	jsl.l GlideBack
	jmp.w donothing
.14:								; call skatetopuck, go to check4check
	jsl.l skatetopuck
	jmp.w check4check
.15:								; call randomd0, if d0 >= $0002 go to .16, temp3,x = $00F0
	jsl.l randomd0
	lda.b d0
	cmp.w #$0002
	bcs .16
	lda.w #$00F0
	sta.w temp3,x
.16:								; if playerpad,x >= 0 go to .rtl2, if gmclock is not 0 go to .13, ...
	lda.w playerpad,x
	bpl .rtl2
	lda.w gmclock
	bne .13
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0002
	bne .17
	lda.w puckc
	bmi .11
	lda.w temp3,x
	sec
	sbc.b d7
	sta.w temp3,x
	cmp.w #$0000
	bpl .11
	stz.w temp3,x
.17:								; call skatetopuckinit, A = d0, push A, A xor $FFFF, ...
	jsl.l skatetopuckinit
	pei ($83)
	lda.b d0
	pha
	eor.w #$FFFF
	inc a
	sta.b d0
	lda.b d1
	eor.w #$FFFF
	inc a
	clc
	adc.w #$00FA
	sta.b d1
	lda.w pfgoal,x
	beq .18
	lda.b d1
	sec
	sbc.w #$01F4
	sta.b d1
.18:								; A = d0, push A, A * 2, pull A, ...
	lda.b d0
	pha
	asl a
	pla
	ror a
	sta.b d0
	lda.b d1
	pha
	asl a
	pla
	ror a
	sta.b d1
	pla
	clc
	adc.b d0
	sta.b d0
	pla
	clc
	adc.b d1
	sta.b d1
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0002
	beq .20
	lda.w pfgoal,x
	beq .19
	lda.b d1
	sec
	sbc.w #$0057
	bmi .20
	lda.w #$0048
	sta.b d1
	bra .20
.19:								; A = d1, A - $FFA9, if the result >= 0 go to .20, d1 = $FFB8
	lda.b d1
	sec
	sbc.w #$FFA9
	bpl .20
	lda.w #$FFB8
	sta.b d1
.20:								; $65 = $00C4, a0 = $883F, call skateto, go to check4check
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	jsl.l skateto
	jmp.w check4check
burst:								; check button: a speed burst in the facing direction that costs energy
									; (getpde / setpde), then SetSPAFromA
	lda.w pfalock,x
	beq .1
	rtl
.1:									; call getpde, if OptLine = 0 go to .2, A = d0, A - $00CC, ...
	jsl.l getpde
	lda.w OptLine
	beq .2
	lda.b d0
	sec
	sbc.w #$00CC
	sta.b d0
	jsl.l setpde
	lda.w OptLine
	cmp.w #$0002
	bne .2
	lda.w #$1000
	sta.b d0
.2:									; r2 = 0, $36 = 0, A = d0, A * 2, ...
	stz.b r2
	stz.b $36
	lda.b d0
	asl a
	sta.b $35
	stz.b $2E
	asl a
	asl a
	asl a
	rol.b $2E
	asl a
	rol.b $2E
	asl a
	rol.b $2E
	adc.b r2
	sta.b r2
	lda.b $2E
	adc.b $36
	sta.b $B1
	lda.w facedir,x
	asl a
	asl a
	tay
	lda.w #$00C0
	sta.b $65
	lda.w #$9C04
	sta.b a0
	lda.b [a0],y
	iny
	iny
	tax
	lda.b $B1
	jsl.l Mul8XS
	ldx.b a3
	clc
	adc.w Xvel,x
	sta.w Xvel,x
	lda.b [a0],y
	tax
	lda.b $B1
	jsl.l Mul8XS
	ldx.b a3
	clc
	adc.w Yvel,x
	sta.w Yvel,x
	lda.w #$21BC
	sta.w pfalock,x
	jml.l SetSPAFromA
chkpk:								; return zero if player X is killing a penalty
	lda.w sflags
	and.w #$2000
	bne chkpk2
	inc a
	rtl
chkpk2:								; from chkpk, assnearest and other segments
	lda.w pfteam,x
	bne .1
	lda.w sflags
	and.w #$4000
	eor.w #$4000
	rtl
.1:									; A = sflags, A and $4000, return
	lda.w sflags
	and.w #$4000
	rtl
asspuckc:							; assignment (asstab entry 17): the puck carrier; others and pad players
									; leave through assexit
	cpx.w puckc
	bne .1
	lda.w playerpad,x
	bmi PuckCarrierThink
.1:									; go to assexit
	jmp.w assexit
DATA8_C42DC5:						; an rtl no traced code reaches
	db $6B
PuckCarrierGlideStopped:			; start backward glide and stand still while play is stopped
	jsl.l GlideBack
	jmp.w donothing
PuckCarrierThink:					; update the computer puck carrier decisions and skating target
	lda.w gmclock
	bne PuckCarrierGlideStopped
	lda.w pflags,x
	bit.w #$0002
	beq .1
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	lda.w seed
	and.w #$0003
	sta.w temp3,x
.1:									; A = temp1,x, A - d7, temp1,x = A, if plus go to .5, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl .5
	adc.w aioff,x
	bpl .2
	lda.w #$0000
.2:									; temp1,x = A, call checkob, if breakaway = 0 go to .4, d0 = Ypos,x, ...
	sta.w temp1,x
	jsl.l checkob
	lda.w breakaway
	beq .4
	lda.w Ypos,x
	sta.b d0
	bpl .3
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.3:									; if A - $0096 >= 0 go to .4, d0 = $0010, call assreplace, go to .rtl
	cmp.w #$0096
	bpl .4
	lda.w #$0010
	sta.b d0
	jsl.l assreplace
	bra .rtl
.4:									; call chk4lc, call chk4shot, if asscur,x is not $0011 go to .5, ...
	jsl.l chk4lc
	jsl.l chk4shot
	lda.w asscur,x
	cmp.w #$0011
	bne .5
	jsl.l chk4pass
.5:									; A = $0006, A + temp3,x, d0 = A, $65 = $00C0, ...
	lda.w #$0006
	clc
	adc.w temp3,x
	sta.b d0
	lda.w #$00C0
	sta.b $65
	lda.w #$9A98
	sta.b a0
	lda.w sflags
	bit.w #$8000
	beq .6
	lda.w position,x
	sta.b d0
.6:									; A = d0, A * 2, A * 2, Y = A, ...
	lda.b d0
	asl a
	asl a
	tay
	lda.b [a0],y
	sta.b d0
	iny
	iny
	lda.b [a0],y
	sta.b d1
	lda.w pfgoal,x
	bne .7
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.7:									; $65 = PuckCarrierAvoidThreats>>16, a0 = PuckCarrierAvoidThreats, go to
									; skateto
	lda.w #PuckCarrierAvoidThreats>>16
	sta.b $65
	lda.w #PuckCarrierAvoidThreats
	sta.b a0
	jml.l skateto
.rtl:								; return
	rtl
PuckCarrierAvoidThreats:			; count opponents near the predicted puck position and adjust skating
									; direction
	lda.b d0
	and.w #$00FF
	bit.w #$0080
	beq .1
	ora.w #$FF00
.1:									; d0 = A, A = Xvel+1,x, A and $00FF, if $0080 bits clear go to .2, ...
	sta.b d0
	lda.w Xvel+1,x
	and.w #$00FF
	bit.w #$0080
	beq .2
	ora.w #$FF00
.2:									; A + puckx, d2 = A, A = Yvel+1,x, A and $00FF, ...
	clc
	adc.w puckx
	sta.b d2
	lda.w Yvel+1,x
	and.w #$00FF
	bit.w #$0080
	beq .3
	ora.w #$FF00
.3:									; A + pucky, d3 = A, threat = 0, d4 = $0005, ...
	clc
	adc.w pucky
	sta.b d3
	stz.w threat
	lda.w #$0005
	sta.b d4
	stz.b a0
	cpx.w #$000C
	bcs .loop
	lda.w #$000C
	sta.b a0
.loop:								; loop: Y = a0, A = Xvel+1,y, A and $00FF, ...
	ldy.b a0
	lda.w Xvel+1,y
	and.w #$00FF
	bit.w #$0080
	beq .4
	ora.w #$FF00
.4:									; A + Xpos,y, A - d2, if A - $FFEB < 0 go to .6, ...
	clc
	adc.w Xpos,y
	sec
	sbc.b d2
	cmp.w #$FFEB
	bmi .6
	cmp.w #$0015
	bpl .6
	lda.w Yvel+1,y
	and.w #$00FF
	bit.w #$0080
	beq .5
	ora.w #$FF00
.5:									; A + Ypos,y, A - d3, if A - $FFEB < 0 go to .6, ...
	clc
	adc.w Ypos,y
	sec
	sbc.b d3
	cmp.w #$FFEB
	bmi .6
	cmp.w #$0015
	bpl .6
	inc.w threat
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	jsl.l vtoa
	lda.w facedir,x
	eor.w #$0004
	cmp.b d0
	bne .6
	lda.w $04B2
	and.w #$0001
	clc
	adc.b d0
	and.w #$0007
	sta.b d0
.6:									; a0 + 1, a0 + 1, d4 - 1, if the result < 0 go to .rtl, ...
	inc.b a0
	inc.b a0
	dec.b d4
	bmi .rtl
	jmp.w .loop
.rtl:								; return
	rtl
asscentero:							; called from other segments
	cpx.w puckc
	beq .2
	ldy.w puckc
	bmi .3
	lda.w pfteam,x
	cmp.w pfteam,y
	beq .3
	lda.w #$0005
	sta.b d0
	jmp.w assreplace
.rtl:								; return
	rtl
.1:									; go to donothing
	jmp.w donothing
.2:									; d0 = $0011, go to assinsert
	lda.w #$0011
	sta.b d0
	jmp.w assinsert
.3:									; if gmclock is not 0 go to .1, call check4bench, ...
	lda.w gmclock
	bne .1
	jsl.l check4bench
	lda.w playerpad,x
	bpl .rtl
	lda.w pflags,x
	bit.w #$0002
	beq .4
	and.w #$FFFD
	sta.w pflags,x
	lda.w #$FFFF
	sta.w temp5,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
.4:									; A = temp1,x, A - d7, temp1,x = A, if minus go to .5, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi .5
	jmp.w .10
.5:									; A + aidef,x, if the result >= 0 go to .6, A = $0000
	clc
	adc.w aidef,x
	bpl .6
	lda.w #$0000
.6:									; temp1,x = A, d0 = pucky, if pfgoal,x is not 0 go to .7, A = $0000, ...
	sta.w temp1,x
	lda.w pucky
	sta.b d0
	lda.w pfgoal,x
	bne .7
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.7:									; d2 = 0, A = d0, A - $FFA4, if the result < 0 go to .8, ...
	stz.b d2
	lda.b d0
	sec
	sbc.w #$FFA4
	bmi .8
	lda.w #$0008
	sta.b d2
	lda.b d0
	sec
	sbc.w #$005C
	bmi .8
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne .8
	asl.b d2
	lda.b d0
	sec
	sbc.w #$010E
	bmi .8
	lda.w #$0018
	sta.b d2
.8:									; if d2 is not temp5,x go to .9, if $04B2 >= $0200 go to .10
	lda.b d2
	cmp.w temp5,x
	bne .9
	lda.w $04B2
	cmp.w #$0200
	bcs .10
.9:									; temp5,x = d2, Y = A, $65 = DATA8_C43079>>16, a0 = DATA8_C43079, ...
	lda.b d2
	sta.w temp5,x
	tay
	lda.w #DATA8_C43079>>16
	sta.b $65
	lda.w #DATA8_C43079
	sta.b a0
	iny
	iny
	lda.b [a0],y
	dey
	dey
	jsl.l randomd0s
	adc.b [a0],y
	sta.w temp3,x
	tya
	clc
	adc.w #$0006
	tay
	lda.b [a0],y
	dey
	dey
	jsl.l randomd0s
	adc.b [a0],y
	sta.w temp4,x
.10:								; d0 = temp3,x, d1 = temp4,x, if pfgoal,x is not 0 go to .11, ...
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w pfgoal,x
	bne .11
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.11:								; $65 = $00C4, a0 = $342A, go to skateto
	lda.w #$00C4
	sta.b $65
	lda.w #$342A
	sta.b a0
	jml.l skateto
DATA8_C43078:						; an rtl no traced code reaches
	db $6B
DATA8_C43079:						; not traced: a table read by asscentero
	db $00,$00,$3C,$00,$BA,$FF,$0A,$00,$00,$00,$3C,$00,$3C,$00,$0A,$00
	db $00,$00,$28,$00,$AA,$00,$1E,$00,$00,$00,$50,$00,$AA,$00,$14,$00
asscenterd:							; called from other segments
	ldy.w puckc
	bmi .2
	lda.w pfteam,x
	cmp.w pfteam,y
	bne .2
	lda.w #$0006
	sta.b d0
	jmp.w assreplace
.rtl:								; return
	rtl
.1:									; go to donothing
	jmp.w donothing
.2:									; if gmclock is not 0 go to .1, call check4bench, ...
	lda.w gmclock
	bne .1
	jsl.l check4bench
	lda.w playerpad,x
	bpl .rtl
	lda.w pflags,x
	bit.w #$0002
	beq .3
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
.3:									; A = temp1,x, A - d7, temp1,x = A, if plus go to .4, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl .4
	lda.w aidef,x
	sta.w temp1,x
.4:									; A = puckx, push A, A * 2, pull A, ...
	lda.w puckx
	pha
	asl a
	pla
	ror a
	sta.b d0
	lda.w #$0084
	sta.b d1
	lda.w pfgoal,x
	beq CenterDefenceTopTarget
	lda.w #$FF7C
	sta.b d1
	lda.w #$FFA4
	sec
	sbc.w pucky
	bpl CenterDefenceSkate
	lda.w #$FF7C
	clc
	adc.w pucky
	pha
	asl a
	pla
	ror a
	sta.b d1
	bra CenterDefenceSkate
DATA8_C4311B:						; an rtl no traced code reaches
	db $6B
CenterDefenceTopTarget:				; adjust the defensive center target toward the puck at the top end
	lda.w #$005C
	sec
	sbc.w pucky
	bmi CenterDefenceSkate
	lda.b d1
	clc
	adc.w pucky
	pha
	asl a
	pla
	ror a
	sta.b d1
CenterDefenceSkate:					; skate the defensive center toward d0 and d1 with an empty callback
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	jmp.w skateto
