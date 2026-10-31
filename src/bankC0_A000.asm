; Segment bankC0_A000: game tables (the assignment routines, asspuckc's positions, tables read by banks
; $C4 and $C5), then the first sound samples of bank $C0: a 12 byte header, then BRR blocks of 9 bytes up to
; the one with the end flag; the sample list in bank $CF points at each.
org $C09A24
asstab:								; the assignment routines, by assignment number (as 94S asstab; the
									; first is an rtl); the code calls one through a long call patched in RAM
	dd rtss,CODE_C4332A,CODE_C4313E,CODE_C4348E
	dd CODE_C43590,CODE_C43099,CODE_C42F62,CODE_C48A71
	dd CODE_C47122,CODE_C45A47,CODE_C5474A,CODE_C47B3F
	dd CODE_C545C7,CODE_C47D2E,CODE_C47F4C,CODE_C488BB
	dd CODE_C49B59,CODE_C42DB8,CODE_C42B25,CODE_C498A1
	dd $C4A4B3,CODE_C49DFB,CODE_C4375B,CODE_C4376F
	dd CODE_C493CA,$C4A65D,CODE_C49595,CODE_C51CC1
	dd CODE_C43826
asspuckc_postab:					; 10 positions (x, y) as 94S asspuckc_postab
	dw -100,-20
	dw 100,-20
	dw -120,40
	dw 20,40
	dw 120,40
	dw -20,40
	dw -40,246
	dw 0,226
	dw 20,236
	dw 30,236
DATA8_C09AC0:						; not traced: read by a routine in bank $C5 (seven words, then rows of 7
									; bytes)
	db $0E,$00,$0E,$00,$1C,$00,$2A,$00,$54,$00,$3F,$00,$54,$00,$01,$09
	db $11,$19,$21,$29,$31,$02,$0A,$12,$1A,$22,$2A,$32,$02,$0A,$12,$1A
	db $22,$2A,$32,$01,$09,$11,$19,$21,$29,$31,$03,$0B,$13,$1B,$23,$2B
	db $33,$05,$0D,$15,$1D,$25,$2D,$35,$04,$0C,$14,$1C,$24,$2C,$34,$05
	db $0D,$15,$1D,$25,$2D,$35,$03,$0B,$13,$1B,$23,$2B,$33,$04,$0C,$14
	db $1C,$24,$2C,$34,$04,$0C,$14,$1C,$24,$2C,$34,$03,$0B,$13,$1B,$23
	db $2B,$33,$05,$0D,$15,$1D,$25,$2D,$35,$FF
DATA8_C09B2A:						; not traced: the numbers 0 to 6 in an order
	db $00,$01,$02,$04,$03,$05,$06
DATA8_C09B31:						; not traced: the numbers 0 to 6 in an order
	db $00,$03,$01,$02,$04,$05,$06
DATA8_C09B38:						; not traced: the numbers 0 to 6 in an order
	db $00,$04,$05,$03,$02,$01,$06
DATA8_C09B3F:						; not traced: read as words by routines in banks $C4 and $C5
	db $D3,$E3,$B1,$D3,$E3,$B2,$C3,$E8,$EB,$D0,$D0,$B1,$D0,$D0,$B2,$D0
	db $CB,$B1,$D0,$CB,$B2
DATA8_C09B54:						; not traced: records read by routines in bank $C5
	dw $0000,$0000,$5DF9,$000A,$0000,$0002,$0008,$000A
	dw $0010,$000A,$0200,$0004,$0020,$000A,$0040,$000A
	dw $0080,$000A,$0800,$000A,$4000,$000A,$0400,$000A
	dw $0004,$0006,$1000,$000A,$8000,$000A,$0100,$000A
DATA8_C09B94:						; not traced: records of the same shape
	dw $0000,$0000,$F0C9,$000A,$0008,$000A,$0010,$000A
	dw $0200,$0004,$0040,$000A,$0080,$000A,$1000,$000A
	dw $2000,$000A,$4000,$000A,$8000,$000A,$0004,$0006
DATA8_C09BC4:						; not traced: 16 rising 32-bit values
	dd $0255F490,$02933EE9,$02D386A4,$0316CBC1
	dd $035D0E40,$03A64E21,$03F28B64,$0441C609
	dd $0493FE10,$04E93379,$05416644,$059C9671
	dd $05FAC400,$065BEEF1,$06C01744,$07273CF9
DATA8_C09C04:						; not traced: 8 (x, y) steps of length 250 around a circle
	dw 0,250,176,176,250,0,176,-176
	dw 0,-250,-176,-176,-250,0,-176,176
BitMaskTable2:						; single-bit masks, bit 0 up (the same words as BitMaskTable)
	dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080
	dw $0100,$0200,$0400,$0800,$1000,$2000,$4000,$8000
DATA8_C09C44:						; not traced: 16 bytes, one per d-pad bit pattern
	db $08,$00,$04,$08,$06,$07,$05,$08,$02,$01,$03,$08,$08,$08,$08,$08
Sample19:							; sound sample 19 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_9000.bin":$C54..$1000
	incbin "../Extracted/segments/bankC0_A000.bin":$0..$2AB
Sample20:							; sound sample 20 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_A000.bin":$2AB..$965
Sample21:							; sound sample 21 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_A000.bin":$965..$1000
	incbin "../Extracted/segments/bankC0_B000.bin":$0..$5BF
