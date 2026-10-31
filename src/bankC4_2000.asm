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
CODE_C42B18:						; from CODE_C42DC6, CODE_C42C47 and other segments
	lda.w $1000,x
	bne CODE_C42B24
	lda.w #$1F6C
	jsl.l CODE_C457B5
CODE_C42B24:						; from CODE_C42B18
	rtl
CODE_C42B25:						; called from other segments
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C42B42
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0B20,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
	stz.w $0AE0,x
CODE_C42B42:						; from CODE_C42B25
	lda.w $0A20,x
	beq CODE_C42B5A
	cpx.w $05A0
	bne CODE_C42B5E
	lda.w #$0011
	sta.b $7F
	lda.w $14F9,x
	bpl CODE_C42B59
	jmp.w CODE_C43734
CODE_C42B59:						; from CODE_C42B42
	rtl
CODE_C42B5A:						; from CODE_C42B42
	jml.l $C48A71
CODE_C42B5E:						; from CODE_C42B42
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bmi CODE_C42B6C
	jmp.w CODE_C42C66
CODE_C42B6C:						; from CODE_C42B5E
	adc.w $0E40,x
	bpl CODE_C42B74
	lda.w #$0000
CODE_C42B74:						; from CODE_C42B6C
	sta.w $0AE0,x
	ldy.w $05A0
	bmi CODE_C42B8E
	lda.w $0A20,y
	beq CODE_C42B8E
	sty.b $67
	lda.w $1020,y
	eor.w $1020,x
	bne CODE_C42B8E
	jmp.w CODE_C42B9E
CODE_C42B8E:						; from CODE_C42B74
	ldy.b $6B
	lda.w $12CF,y
	sta.b $87
	lda.w $12D3,y
	sta.b $67
	lda.b $87
	bmi CODE_C42BD7
CODE_C42B9E:						; from CODE_C42B74
	cpx.b $67
	beq CODE_C42BD7
	lda.w $10F3
	bne CODE_C42BD7
	ldy.b $67
	lda.w $0D60,y
	bit.w #$1000
	bne CODE_C42BD7
	lda.w $0A20,y
	beq CODE_C42BD7
	lda.w $0644,y
	cmp.w #$0015
	beq CODE_C42BD7
	ldx.b $67
	lda.w $0D60,x
	and.w #$FFFE
	sta.w $0D60,x
	lda.w #$0012
	sta.b $7F
	jsl.l CODE_C43734
	ldx.b $B7
	jmp.w CODE_C4370C
CODE_C42BD7:						; from CODE_C42B8E, CODE_C42B9E
	lda.w #$0002
	sta.b $83
	lda.b $87
	cmp.w #$00E2
	bcs CODE_C42BEA
	stz.b $83
	lda.w $0A20,x
	beq CODE_C42C66
CODE_C42BEA:						; from CODE_C42BD7
	lda.w $10F5
	bit.w #$2000
	beq CODE_C42C04
	dec.b $83
	dec.b $83
	jsl.l CODE_C42DA2
	bne CODE_C42C04
	inc.b $83
	inc.b $83
	inc.b $83
	inc.b $83
CODE_C42C04:						; from CODE_C42BEA
	lda.w #$0014
	sec
	sbc.w $0FA0,x
	sta.b $7F
	lda.b $83
	sta.b $9F
CODE_C42C11:						; from CODE_C42C11
	dec.b $9F
	bmi CODE_C42C55
	asl.b $7F
	bra CODE_C42C11
CODE_C42C19:						; from CODE_C42C66
	rtl
CODE_C42C1A:						; from CODE_C42C66
	ldy.w $05A0
	bmi CODE_C42C4E
	lda.w $0A20,y
	bne CODE_C42C4E
	lda.w $0830
	sta.b $7F
	lda.w #$005C
	ldy.w $0FE0,x
	bne CODE_C42C34
	lda.w #$FFA4
CODE_C42C34:						; from CODE_C42C1A
	sta.b $83
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b $63
	jsl.l CODE_C45950
	jmp.w CODE_C45529
CODE_C42C47:						; from CODE_C42C66
	jsl.l CODE_C42B18
	jmp.w CODE_C436FD
CODE_C42C4E:						; from CODE_C42C1A
	jsl.l $C4702E
	jmp.w CODE_C45529
CODE_C42C55:						; from CODE_C42C11
	jsl.l $C37EBF
	lda.b $7F
	cmp.w #$0002
	bcs CODE_C42C66
	lda.w #$00F0
	sta.w $0B20,x
CODE_C42C66:						; from CODE_C42B5E, CODE_C42BD7, CODE_C42C55
	lda.w $14F9,x
	bpl CODE_C42C19
	lda.w $10F3
	bne CODE_C42C47
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0002
	bne CODE_C42C90
	lda.w $05A0
	bmi CODE_C42C1A
	lda.w $0B20,x
	sec
	sbc.b $9B
	sta.w $0B20,x
	cmp.w #$0000
	bpl CODE_C42C1A
	stz.w $0B20,x
CODE_C42C90:						; from CODE_C42C66
	jsl.l $C495BB
	pei ($83)
	lda.b $7F
	pha
	eor.w #$FFFF
	inc a
	sta.b $7F
	lda.b $83
	eor.w #$FFFF
	inc a
	clc
	adc.w #$00FA
	sta.b $83
	lda.w $0FE0,x
	beq CODE_C42CB8
	lda.b $83
	sec
	sbc.w #$01F4
	sta.b $83
CODE_C42CB8:						; from CODE_C42C90
	lda.b $7F
	pha
	asl a
	pla
	ror a
	sta.b $7F
	lda.b $83
	pha
	asl a
	pla
	ror a
	sta.b $83
	pla
	clc
	adc.b $7F
	sta.b $7F
	pla
	clc
	adc.b $83
	sta.b $83
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0002
	beq CODE_C42CFF
	lda.w $0FE0,x
	beq CODE_C42CF2
	lda.b $83
	sec
	sbc.w #$0057
	bmi CODE_C42CFF
	lda.w #$0048
	sta.b $83
	bra CODE_C42CFF
CODE_C42CF2:						; from CODE_C42CB8
	lda.b $83
	sec
	sbc.w #$FFA9
	bpl CODE_C42CFF
	lda.w #$FFB8
	sta.b $83
CODE_C42CFF:						; from CODE_C42CB8, CODE_C42CF2
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b $63
	jsl.l CODE_C45950
	jmp.w CODE_C45529
CODE_C42D10:						; called from other segments
	lda.w $1000,x
	beq CODE_C42D16
	rtl
CODE_C42D16:						; from CODE_C42D10
	jsl.l CODE_C54A0E
	lda.w $186E
	beq CODE_C42D38
	lda.b $7F
	sec
	sbc.w #$00CC
	sta.b $7F
	jsl.l CODE_C54A2F
	lda.w $186E
	cmp.w #$0002
	bne CODE_C42D38
	lda.w #$1000
	sta.b $7F
CODE_C42D38:						; from CODE_C42D16
	stz.b $34
	stz.b $36
	lda.b $7F
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
	adc.b $34
	sta.b $34
	lda.b $2E
	adc.b $36
	sta.b $B1
	lda.w $0C40,x
	asl a
	asl a
	tay
	lda.w #$00C0
	sta.b $65
	lda.w #$9C04
	sta.b $63
	lda.b [$63],y
	iny
	iny
	tax
	lda.b $B1
	jsl.l Mul8XS
	ldx.b $6F
	clc
	adc.w $09A0,x
	sta.w $09A0,x
	lda.b [$63],y
	tax
	lda.b $B1
	jsl.l Mul8XS
	ldx.b $6F
	clc
	adc.w $09C0,x
	sta.w $09C0,x
	lda.w #$21BC
	sta.w $1000,x
	jml.l CODE_C457B5
CODE_C42D98:						; from CODE_C431E9 and other segments
	lda.w $10F5
	and.w #$2000
	bne CODE_C42DA2
	inc a
	rtl
CODE_C42DA2:						; from CODE_C42D98, CODE_C42BEA and other segments
	lda.w $1020,x
	bne CODE_C42DB1
	lda.w $10F5
	and.w #$4000
	eor.w #$4000
	rtl
CODE_C42DB1:						; from CODE_C42DA2
	lda.w $10F5
	and.w #$4000
	rtl
CODE_C42DB8:						; called from other segments
	cpx.w $05A0
	bne CODE_C42DC2
	lda.w $14F9,x
	bmi CODE_C42DCD
CODE_C42DC2:						; from CODE_C42DB8
	jmp.w CODE_C4370C
DATA8_C42DC5:						; an rtl no traced code reaches
	db $6B
CODE_C42DC6:						; from CODE_C42DCD
	jsl.l CODE_C42B18
	jmp.w CODE_C436FD
CODE_C42DCD:						; from CODE_C42DB8
	lda.w $10F3
	bne CODE_C42DC6
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C42DF5
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
	lda.w $04B0
	and.w #$0003
	sta.w $0B20,x
CODE_C42DF5:						; from CODE_C42DCD
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bpl CODE_C42E47
	adc.w $0E40,x
	bpl CODE_C42E08
	lda.w #$0000
CODE_C42E08:						; from CODE_C42DF5
	sta.w $0AE0,x
	jsl.l $C4837C
	lda.w $18AE
	beq CODE_C42E33
	lda.w $0896,x
	sta.b $7F
	bpl CODE_C42E23
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C42E23:						; from CODE_C42E08
	cmp.w #$0096
	bpl CODE_C42E33
	lda.w #$0010
	sta.b $7F
	jsl.l CODE_C4373E
	bra CODE_C42E99
CODE_C42E33:						; from CODE_C42E08, CODE_C42E23
	jsl.l CODE_C5492E
	jsl.l $C495E8
	lda.w $0644,x
	cmp.w #$0011
	bne CODE_C42E47
	jsl.l $C49FBD
CODE_C42E47:						; from CODE_C42DF5, CODE_C42E33
	lda.w #$0006
	clc
	adc.w $0B20,x
	sta.b $7F
	lda.w #$00C0
	sta.b $65
	lda.w #$9A98
	sta.b $63
	lda.w $10F5
	bit.w #$8000
	beq CODE_C42E67
	lda.w $0A20,x
	sta.b $7F
CODE_C42E67:						; from CODE_C42E47
	lda.b $7F
	asl a
	asl a
	tay
	lda.b [$63],y
	sta.b $7F
	iny
	iny
	lda.b [$63],y
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C42E8B
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C42E8B:						; from CODE_C42E67
	lda.w #CODE_C42E9A>>16
	sta.b $65
	lda.w #CODE_C42E9A
	sta.b $63
	jml.l CODE_C45950
CODE_C42E99:						; from CODE_C42E23
	rtl
CODE_C42E9A:						; passed as a long pointer (lda #bank, lda #low) to CODE_C45950
	lda.b $7F
	and.w #$00FF
	bit.w #$0080
	beq CODE_C42EA7
	ora.w #$FF00
CODE_C42EA7:						; from CODE_C42E9A
	sta.b $7F
	lda.w $09A1,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C42EB7
	ora.w #$FF00
CODE_C42EB7:						; from CODE_C42EA7
	clc
	adc.w $0830
	sta.b $87
	lda.w $09C1,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C42ECB
	ora.w #$FF00
CODE_C42ECB:						; from CODE_C42EB7
	clc
	adc.w $08B2
	sta.b $8B
	stz.w $07EE
	lda.w #$0005
	sta.b $8F
	stz.b $63
	cpx.w #$000C
	bcs CODE_C42EE5
	lda.w #$000C
	sta.b $63
CODE_C42EE5:						; from CODE_C42ECB, CODE_C42F56
	ldy.b $63
	lda.w $09A1,y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C42EF5
	ora.w #$FF00
CODE_C42EF5:						; from CODE_C42EE5
	clc
	adc.w $0814,y
	sec
	sbc.b $87
	cmp.w #$FFEB
	bmi CODE_C42F56
	cmp.w #$0015
	bpl CODE_C42F56
	lda.w $09C1,y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C42F14
	ora.w #$FF00
CODE_C42F14:						; from CODE_C42EF5
	clc
	adc.w $0896,y
	sec
	sbc.b $8B
	cmp.w #$FFEB
	bmi CODE_C42F56
	cmp.w #$0015
	bpl CODE_C42F56
	inc.w $07EE
	lda.w $0814,x
	sec
	sbc.w $0814,y
	sta.b $7F
	lda.w $0896,x
	sec
	sbc.w $0896,y
	sta.b $83
	jsl.l $C37F6D
	lda.w $0C40,x
	eor.w #$0004
	cmp.b $7F
	bne CODE_C42F56
	lda.w $04B2
	and.w #$0001
	clc
	adc.b $7F
	and.w #$0007
	sta.b $7F
CODE_C42F56:						; from CODE_C42EF5, CODE_C42F14
	inc.b $63
	inc.b $63
	dec.b $8F
	bmi CODE_C42F61
	jmp.w CODE_C42EE5
CODE_C42F61:						; from CODE_C42F56
	rtl
CODE_C42F62:						; called from other segments
	cpx.w $05A0
	beq CODE_C42F80
	ldy.w $05A0
	bmi CODE_C42F88
	lda.w $1020,x
	cmp.w $1020,y
	beq CODE_C42F88
	lda.w #$0005
	sta.b $7F
	jmp.w CODE_C4373E
CODE_C42F7C:						; from CODE_C42F88
	rtl
CODE_C42F7D:						; from CODE_C42F88
	jmp.w CODE_C436FD
CODE_C42F80:						; from CODE_C42F62
	lda.w #$0011
	sta.b $7F
	jmp.w CODE_C43734
CODE_C42F88:						; from CODE_C42F62
	lda.w $10F3
	bne CODE_C42F7D
	jsl.l CODE_C549A8
	lda.w $14F9,x
	bpl CODE_C42F7C
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C42FB6
	and.w #$FFFD
	sta.w $0D60,x
	lda.w #$FFFF
	sta.w $0B60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
CODE_C42FB6:						; from CODE_C42F88
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bmi CODE_C42FC4
	jmp.w CODE_C43053
CODE_C42FC4:						; from CODE_C42FB6
	clc
	adc.w $0E60,x
	bpl CODE_C42FCD
	lda.w #$0000
CODE_C42FCD:						; from CODE_C42FC4
	sta.w $0AE0,x
	lda.w $08B2
	sta.b $7F
	lda.w $0FE0,x
	bne CODE_C42FE2
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C42FE2:						; from CODE_C42FCD
	stz.b $87
	lda.b $7F
	sec
	sbc.w #$FFA4
	bmi CODE_C43012
	lda.w #$0008
	sta.b $87
	lda.b $7F
	sec
	sbc.w #$005C
	bmi CODE_C43012
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0010
	bne CODE_C43012
	asl.b $87
	lda.b $7F
	sec
	sbc.w #$010E
	bmi CODE_C43012
	lda.w #$0018
	sta.b $87
CODE_C43012:						; from CODE_C42FE2
	lda.b $87
	cmp.w $0B60,x
	bne CODE_C43021
	lda.w $04B2
	cmp.w #$0200
	bcs CODE_C43053
CODE_C43021:						; from CODE_C43012
	lda.b $87
	sta.w $0B60,x
	tay
	lda.w #DATA8_C43079>>16
	sta.b $65
	lda.w #DATA8_C43079
	sta.b $63
	iny
	iny
	lda.b [$63],y
	dey
	dey
	jsl.l $C37EC8
	adc.b [$63],y
	sta.w $0B20,x
	tya
	clc
	adc.w #$0006
	tay
	lda.b [$63],y
	dey
	dey
	jsl.l $C37EC8
	adc.b [$63],y
	sta.w $0B40,x
CODE_C43053:						; from CODE_C42FB6, CODE_C43012
	lda.w $0B20,x
	sta.b $7F
	lda.w $0B40,x
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C4306A
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C4306A:						; from CODE_C43053
	lda.w #$00C4
	sta.b $65
	lda.w #$342A
	sta.b $63
	jml.l CODE_C45950
DATA8_C43078:						; an rtl no traced code reaches
	db $6B
DATA8_C43079:						; not traced: a table read by CODE_C43021
	db $00,$00,$3C,$00,$BA,$FF,$0A,$00,$00,$00,$3C,$00,$3C,$00,$0A,$00
	db $00,$00,$28,$00,$AA,$00,$1E,$00,$00,$00,$50,$00,$AA,$00,$14,$00
CODE_C43099:						; called from other segments
	ldy.w $05A0
	bmi CODE_C430B2
	lda.w $1020,x
	cmp.w $1020,y
	bne CODE_C430B2
	lda.w #$0006
	sta.b $7F
	jmp.w CODE_C4373E
CODE_C430AE:						; from CODE_C430B2
	rtl
CODE_C430AF:						; from CODE_C430B2
	jmp.w CODE_C436FD
CODE_C430B2:						; from CODE_C43099
	lda.w $10F3
	bne CODE_C430AF
	jsl.l CODE_C549A8
	lda.w $14F9,x
	bpl CODE_C430AE
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C430DA
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
CODE_C430DA:						; from CODE_C430B2
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bpl CODE_C430EB
	lda.w $0E60,x
	sta.w $0AE0,x
CODE_C430EB:						; from CODE_C430DA
	lda.w $0830
	pha
	asl a
	pla
	ror a
	sta.b $7F
	lda.w #$0084
	sta.b $83
	lda.w $0FE0,x
	beq CODE_C4311C
	lda.w #$FF7C
	sta.b $83
	lda.w #$FFA4
	sec
	sbc.w $08B2
	bpl CODE_C43131
	lda.w #$FF7C
	clc
	adc.w $08B2
	pha
	asl a
	pla
	ror a
	sta.b $83
	bra CODE_C43131
DATA8_C4311B:						; an rtl no traced code reaches
	db $6B
CODE_C4311C:						; from CODE_C430EB
	lda.w #$005C
	sec
	sbc.w $08B2
	bmi CODE_C43131
	lda.b $83
	clc
	adc.w $08B2
	pha
	asl a
	pla
	ror a
	sta.b $83
CODE_C43131:						; from CODE_C430EB, CODE_C4311C
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b $63
	jmp.w CODE_C45950
