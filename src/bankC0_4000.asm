; Segment bankC0_4000: two packed tile sets, HDMA tables and the colour hooks of one screen, small tables,
; then the player photos of Tampa Bay (their palettes, then the photos packed). Items not traced to a use
; keep an auto name.
org $C04642
DigitFontTiles:						; 4bpp tiles, packed: the digits and the position letters D, L, C, R, X;
									; unpacked and sent to VRAM
	dw $01E0						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankC0_4000.bin":$646..$708
LinePieceTiles:						; 4bpp tiles, packed: straight and diagonal line pieces and corners;
									; unpacked to RAM before a screen is built from them
	dw $07E0						; unpacked size in bytes
	dw $0006						; format 6: a flag byte per 8 literal runs or copies, up to 11 bits back
	incbin "../Extracted/segments/bankC0_4000.bin":$70C..$8E2
BG3ScrollHDMA1:						; indirect HDMA table for BG3VOFS (line count, RAM address of the value),
									; copied to RAM for one screen
	db $70,$C6,$04					; 112 lines
	db $10,$C6,$04					; 16 lines
	db $10,$00,$01					; 16 lines
	db $10,$02,$01					; 16 lines
	db $10,$04,$01					; 16 lines
	db $0F,$06,$01					; 15 lines
	db $01,$08,$01					; 1 line
	db $10,$0A,$01					; 16 lines
	db $01,$C6,$04					; 1 line
	db $00							; end
BG3ScrollHDMA2:						; the same for another screen; the copy takes 28 bytes, so it ends
									; inside the short table after it
	db $40,$C6,$04					; 64 lines
	db $38,$00,$01					; 56 lines
	db $37,$02,$01					; 55 lines
	db $01,$04,$01					; 1 line
	db $08,$0A,$01					; 8 lines
	db $18,$08,$01					; 24 lines
	db $01,$06,$01					; 1 line
	db $00							; end
	db $40,$C2,$04					; the short table: 64 lines
	db $01,$C2,$04					; 1 line
DATA8_C0491A:						; not traced: a 0, then records of 5 bytes
	incbin "../Extracted/segments/bankC0_4000.bin":$91A..$A35
MainScreenHDMA:						; indirect HDMA table for TM (line count, address of the layers to show)
	db $40,$4E,$36					; 64 lines
	db $05,$50,$36					; 5 lines
	db $60,$52,$36					; 96 lines
	db $0B,$50,$36					; 11 lines
	db $01,$4E,$36					; 1 line
	db $00							; end
BlueColours:						; 8 blues that BlueColoursHook sends
	dw $7C00,$7400,$7000,$6C00,$7000,$6C00,$6800,$6000
DarkBlueColours:					; 8 darker blues that DarkBlueColoursHook sends
	dw $3C00,$3800,$3800,$3400,$3800,$3400,$3400,$3000
BlueColoursHook:					; NMI hook (SetNMIHook): BlueColours to CGRAM colours $11 on
	lda.w #DMA_CGRAM				; M 16, X 8 as the NMI calls hooks
	sta.w DMAP0
	lda.w #BlueColours
	sta.w A1T0L
	ldx.b #BlueColours>>16
	stx.w A1B0
	lda.w #DarkBlueColours-BlueColours
	sta.w DAS0L
	ldx.b #$11
	stx.w CGADD
	ldx.b #MDMAEN_CH0
	stx.w MDMAEN
	rtl
DarkBlueColoursHook:				; NMI hook: DarkBlueColours to CGRAM colours $11 on
	lda.w #DMA_CGRAM				; M 16, X 8 as the NMI calls hooks
	sta.w DMAP0
	lda.w #DarkBlueColours
	sta.w A1T0L
	ldx.b #DarkBlueColours>>16
	stx.w A1B0
	lda.w #BlueColoursHook-DarkBlueColours
	sta.w DAS0L
	ldx.b #$11
	stx.w CGADD
	ldx.b #MDMAEN_CH0
	stx.w MDMAEN
	rtl
DATA8_C04AA9:						; 256 words: entry n is (n / 8) * $20 + (n & 7) * 2; read with an
									; index times 2
	dw $0000,$0002,$0004,$0006,$0008,$000A,$000C,$000E,$0020,$0022,$0024,$0026,$0028,$002A,$002C,$002E
	dw $0040,$0042,$0044,$0046,$0048,$004A,$004C,$004E,$0060,$0062,$0064,$0066,$0068,$006A,$006C,$006E
	dw $0080,$0082,$0084,$0086,$0088,$008A,$008C,$008E,$00A0,$00A2,$00A4,$00A6,$00A8,$00AA,$00AC,$00AE
	dw $00C0,$00C2,$00C4,$00C6,$00C8,$00CA,$00CC,$00CE,$00E0,$00E2,$00E4,$00E6,$00E8,$00EA,$00EC,$00EE
	dw $0100,$0102,$0104,$0106,$0108,$010A,$010C,$010E,$0120,$0122,$0124,$0126,$0128,$012A,$012C,$012E
	dw $0140,$0142,$0144,$0146,$0148,$014A,$014C,$014E,$0160,$0162,$0164,$0166,$0168,$016A,$016C,$016E
	dw $0180,$0182,$0184,$0186,$0188,$018A,$018C,$018E,$01A0,$01A2,$01A4,$01A6,$01A8,$01AA,$01AC,$01AE
	dw $01C0,$01C2,$01C4,$01C6,$01C8,$01CA,$01CC,$01CE,$01E0,$01E2,$01E4,$01E6,$01E8,$01EA,$01EC,$01EE
	dw $0200,$0202,$0204,$0206,$0208,$020A,$020C,$020E,$0220,$0222,$0224,$0226,$0228,$022A,$022C,$022E
	dw $0240,$0242,$0244,$0246,$0248,$024A,$024C,$024E,$0260,$0262,$0264,$0266,$0268,$026A,$026C,$026E
	dw $0280,$0282,$0284,$0286,$0288,$028A,$028C,$028E,$02A0,$02A2,$02A4,$02A6,$02A8,$02AA,$02AC,$02AE
	dw $02C0,$02C2,$02C4,$02C6,$02C8,$02CA,$02CC,$02CE,$02E0,$02E2,$02E4,$02E6,$02E8,$02EA,$02EC,$02EE
	dw $0300,$0302,$0304,$0306,$0308,$030A,$030C,$030E,$0320,$0322,$0324,$0326,$0328,$032A,$032C,$032E
	dw $0340,$0342,$0344,$0346,$0348,$034A,$034C,$034E,$0360,$0362,$0364,$0366,$0368,$036A,$036C,$036E
	dw $0380,$0382,$0384,$0386,$0388,$038A,$038C,$038E,$03A0,$03A2,$03A4,$03A6,$03A8,$03AA,$03AC,$03AE
	dw $03C0,$03C2,$03C4,$03C6,$03C8,$03CA,$03CC,$03CE,$03E0,$03E2,$03E4,$03E6,$03E8,$03EA,$03EC,$03EE
BackdropColour:						; 1 colour queued to CGRAM colour 0
	dw $7F98
DATA8_C04CAB:						; not traced
	dw $0009,$0009,$000B,$0012,$0012,$000A
DivisionNames:						; the packed text of the 4 division names: Western / Pacific, Western /
									; Central, Eastern / Atlantic, Eastern / Northeast
	dw $46E2,$46EF,$46FC,$4709
DATA8_C04CBF:						; 4 bytes picked by the same option
	db $06,$0A,$21,$11
DATA8_C04CC3:						; 4 more bytes picked by the same option
	db $06,$06,$07,$07
BitMaskTable:						; single-bit masks, bit 0 up
	dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080
	dw $0100,$0200,$0400,$0800,$1000,$2000,$4000,$8000
PhotoPalettesTB:					; Tampa Bay player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosTB); the team photo table points here
	incbin "../Extracted/segments/bankC0_4000.bin":$CE7..$DA7
PlayerPhotosTB:						; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankC0_4000.bin":$DAB..$1000
	incbin "../Extracted/segments/bankC0_5000.bin":0..$DAC
