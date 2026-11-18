SetupMode1Screen:					; a mode 1 screen: the work buffer reset, the BG map registers
									; (SetBGMapRegs), BGMODE 1, TM, the BG scrolls
	jsl.l WaitTransfers
	jsl.l ResetWorkBuf
	jsl.l ResetSprites
	jsr.w SetBGMapRegs
	db $58,$51,$5C,$5C,$02,$43		; inline parameters
	pea.w $7E80
	plb
	sep #$20
	lda.b #$01
	sta.w BGMODE
	lda.b #$03
	sta.w TM
	stz.w $210D
	stz.w $210D
	stz.w $210F
	stz.w $210F
	lda.b #$FF
	sta.w $210E
	sta.w $210E
	sta.w $2110
	sta.w $2110
	rep #$20
	plb
	stz.w BG1HScroll
	stz.w BG2HScroll
	lda.w #$FFFF
	sta.w BG1VScroll
	sta.w BG2VScroll
	rtl
