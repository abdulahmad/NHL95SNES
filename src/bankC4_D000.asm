; Segment bankC4_D000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4CFF5
CODE_C4CFF5:						; called from other segments
	phb
	lda.w #$0000
	sta.l SeasonDay
	ldx.w #$6050
	ldy.w #$6052
	lda.w #$09C3
	mvn $30,$30
	ldx.w #$6E43
	ldy.w #$6E45
	lda.w #$0290
	stz.w $0000,x
	mvn $30,$30
	ldx.w #$72E8
	ldy.w #$72EA
	lda.w #$0622
	stz.w $0000,x
	mvn $30,$30
	lda.l $001902
	beq .1
	lda.w #$0183
	ldx.w #$7162
	ldy.w #$7164
	stz.w $0000,x
	mvn $30,$30
	lda.w #$03EA
	ldx.w #$6A56
	ldy.w #$6A58
	stz.w $0000,x
	mvn $30,$30
	jsr.w CODE_C4D05B
	jsr.w CODE_C4D0D5
.1:									; call CODE_C4CF7B, call CODE_C5E474, return
	jsl.l CODE_C4CF7B
	jsl.l CODE_C5E474
	plb
	rtl
CODE_C4D05B:						; from CODE_C4CFF5 and other segments
	ldx.w #$0032
.1:									; tmp0 = X, A = $C30000,x, X = A, A = $C30000,x, ...
	stx.b tmp0
	lda.l $C30000,x
	tax
	lda.l $C30000,x
	tay
	xba
	and.w #$00F8
	lsr a
	lsr a
	lsr a
	sta.b tmp1
	tya
	and.w #$07FF
	tax
.2:									; tmp2 = X, A = X, A - $0038, $A5 = A, ...
	stx.b tmp2
	txa
	sec
	sbc.w #$0038
	sta.b $A5
	asl a
	adc.b $A5
	lsr a
	lsr a
	tay
	lda.l $C30000,x
	and.w #$3FFF
	tax
	bcc .3
	lda.b tmp0
	asl a
	asl a
	asl a
	sta.b $A5
	lda.l $C2FFFF,x
	and.w #$7F00
	asl a
	tsb.b $A5
	lda.w $6A56,y
	and.w #$000F
	bra .4
.3:									; A = tmp0, A / 2, $A5 = A, A = $C2FFFF,x, ...
	lda.b tmp0
	lsr a
	sta.b $A5
	lda.l $C2FFFF,x
	and.w #$7F00
	lsr a
	lsr a
	lsr a
	tsb.b $A5
	lda.w $6A56,y
	and.w #$F000
.4:									; A or $A5, $6A56,y = A, X = tmp2, X + 1, ...
	ora.b $A5
	sta.w $6A56,y
	ldx.b tmp2
	inx
	inx
	dec.b tmp1
	bne .2
	ldx.b tmp0
	dex
	dex
	bpl .1
	rts
CODE_C4D0D5:						; from CODE_C4CFF5 and other segments
	ldy.w #$1CF8
	lda.w #$0013
	sta.b tmp0
	tya
.1:									; A / 2, A / 2, A / 2, X = A, ...
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	beq .2
	lda.w #$01F0
	bra .3
.2:									; A = $001F
	lda.w #$001F
.3:									; A or $6A56,x, $6A56,x = A, A = Y, A + $000C, ...
	ora.w $6A56,x
	sta.w $6A56,x
	tya
	clc
	adc.w #$000C
	tay
	dec.b tmp0
	bpl .1
	rts
DATA8_C4D101:						; not traced: data between routines
	db $4A,$01,$78,$22,$38,$22,$01,$33,$00
DATA8_C4D10A:						; not traced: a table read by TitleFadeTextOut, DrawTitleTextPage, ...
	db $03,$E4,$50,$F2,$50,$FE,$50,$03,$08,$51,$11,$51,$1B,$51,$03,$26
	db $51,$2D,$51,$34,$51,$03,$26,$51,$41,$51,$4A,$51,$03,$26,$51,$55
	db $51,$62,$51,$03,$26,$51,$6C,$51,$75,$51,$02,$26,$51,$80,$51,$03
	db $8B,$51,$99,$51,$A6,$51,$02,$B0,$51,$BC,$51,$02,$C7,$51,$D5,$51
	db $02,$DE,$51,$ED,$51,$02,$F6,$51,$FD,$51,$02,$07,$52,$15,$52,$03
	db $1E,$52,$27,$52,$31,$52,$03,$1E,$52,$3C,$52,$46,$52,$03,$50,$52
	db $5F,$52,$6A,$52,$02,$74,$52,$80,$52,$04,$89,$52,$97,$52,$A4,$52
	db $B2,$52,$02,$C0,$52,$CF,$52,$02,$DB,$52,$EA,$52,$03,$F3,$52,$FF
	db $52,$09,$53,$02,$F3,$52,$13,$53,$00
TitleScreen:						; the title screen: TitleLogoMap, TitleGoalieMap, TitlePlayersMap, run by
									; tasks
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	jsl.l ResetTransferQueues
	jsl.l ResetSprites
	lda.w #$FFFF
	sta.w BG1VScroll
	sta.w BG2VScroll
	ldy.w #$3800
	jsl.l QueueClearVRAM
	ldy.w #$3C00
	jsl.l QueueClearVRAM
	ldy.w #$5800
	jsl.l QueueClearVRAM
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	ldy.w #$3000
	jsl.l QueueClearVRAM
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $02C0
	pea.w $0000
	pea.w $5400
	pea.w $1808
	pea.w $00C4
	pea.w $D101
	pea.w $02C0
	pea.w $0080
	pea.w $5400
	pea.w $1908
	pea.w $00C4
	pea.w $D102
	pea.w $0180
	pea.w $0000
	pea.w $56C0
	pea.w $1809
	pea.w $00C5
	pea.w $8A63
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	jsl.l WaitTransfers
	lda.w #$5420
	sta.b tmp0
	lda.w #$214A
	sta.b tmp1
	ldx.w #TitleLogoMap>>16
	lda.w #TitleLogoMap&$FFFF
	ldy.w #$2A50
	jsl.l MapSetToVRAM
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0010
	ldx.w #TitleLogoMap>>16
	lda.w #TitleLogoMap&$FFFF
	jsr.w GetMapSetPalettePointer
	phx
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	lda.w #$5820
	sta.b tmp0
	lda.w #$0800
	sta.b tmp1
	ldx.w #TitleGoalieMap>>16
	lda.w #TitleGoalieMap&$FFFF
	ldy.w #$0000
	jsl.l MapSetToVRAM
	lda.w #$3820
	sta.b tmp0
	lda.w #$0800
	sta.b tmp1
	ldx.w #TitlePlayersMap>>16
	lda.w #TitlePlayersMap&$FFFF
	ldy.w #$4000
	jsl.l MapSetToVRAM
	sep #$20
	lda.b #$39
	sta.l BG1SC
	lda.b #$59
	sta.l BG2SC
	lda.b #$55
	sta.l BG3SC
	lda.b #$04
	sta.l BG12NBA
	lda.b #$09
	sta.l BGMODE
	lda.b #$17
	sta.l TM
	rep #$20
	ldx.w #$0070
	jsl.l SetupHDMA
	db $00,$0C,$03,$D1,$C4,$7E		; inline parameters
	lda.w #$8000
	sta.w DMAEnShadow
	jsl.l BlackBackdrop
	jsl.l InitTasks
	lda.w #$0010
	sta.b $7D
	lda.w #$007E
	sta.b $71
	lda.b $08
	sta.b d4
	sta.b a3
	clc
	adc.w #$0040
	sta.b d5
	adc.w #$0180
	sta.b $08
	jsl.l MarkWorkBuf
	lda.w #$0010
	sta.b d3
	lda.b d4
	ldy.w #$7FFF
	jsl.l FillWords7E
	ldx.w #TitlePlayersMap>>16
	lda.w #TitlePlayersMap&$FFFF
	jsr.w GetMapSetPalettePointer
	ldy.b d5
	jsl.l StartColourFade
	ldx.w #$007E
	lda.b d4
	ldy.w #$0020
	jsl.l QueueColours16
	lda.w #$0100
	sta.w BG1HScroll
	stz.w BG2HScroll
	ldx.w #TitleWaitForSlide>>16
	lda.w #TitleWaitForSlide
	ldy.w #$0001
	clc
	jsl.l StartTasks
	jsl.l WaitTransfers
	lda.w #$00A3
	jsl.l StartSound
	ldx.w #TitleStartMusicTask>>16
	lda.w #TitleStartMusicTask
	ldy.w #$FF00
	jsl.l AddTask
	inc.w $1EA7
	stz.w fadestep
.loop:								; loop: call RunTasks, call AnimateSprites, ...
	jsl.l RunTasks
	jsl.l AnimateSprites
	lda.w $2D9D
	beq .loop
	lda.w #$0058
	sta.l BG1SC
	lda.w #$0051
	sta.l BG2SC
	lda.w #$005C
	sta.l BG3SC
	lda.w #$005C
	sta.l BG4SC
	lda.w #$0002
	sta.l BG12NBA
	lda.w #$0043
	sta.l BG34NBA
	rtl
TitleWaitForSlide:					; waits for the task counter to reach 60 before starting the title fade
									; and slide
	lda.w $0008,x
	cmp.w #$003C
	bne CODE_C4D3AD
	stz.w $0008,x
	lda.w #TitleFadeAndSlide
	sta.w $0002,x
TitleFadeAndSlide:					; steps the title palette fade and continues into the background slide
	lda.w #$0020
	jsr.w QueueFadeStep
	bne TitleSlideBG2
	ldx.b d1
	lda.w #TitleSlideBG2
	sta.w $0002,x
TitleSlideBG2:						; advances BG2 horizontal scroll by two until the next title slide phase
	lda.w BG2HScroll
	inc a
	inc a
	sta.w BG2HScroll
	cmp.w #$0080
	bcc CODE_C4D3AD
	ldx.b d1
	lda.w #TitleSlideBothBGs
	sta.w $0002,x
CODE_C4D3AD:						; from TitleWaitForSlide, TitleSlideBG2, TitleSlideBothBGs
	rtl
TitleSlideBothBGs:					; scrolls BG1 and BG2 apart, then creates the first fading logo sprite
	lda.w BG1HScroll
	dec a
	dec a
	dec a
	dec a
	sta.w BG1HScroll
	lda.w BG2HScroll
	inc a
	inc a
	sta.w BG2HScroll
	cmp.w #$0100
	bcc CODE_C4D3AD
	lda.w #$00CB
	sta.b $18
	lda.w #$0093
	sta.b $1A
	lda.w #$0028
	jsr.w CreateTitleFadingSprite
	ldx.b d1
	lda.w #TitleFadeFirstLogo
	sta.w $0002,x
TitleFadeFirstLogo:					; fades the first title logo palette before creating the second logo
	ldx.b $91
	lda.w $0034,x
	and.w #$FF00
	xba
	clc
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	jsr.w QueueFadeStep
	bne CODE_C4D3FB
	ldx.b d1
	lda.w #TitleCreateSecondLogo
	sta.w $0002,x
CODE_C4D3FB:						; from TitleFadeFirstLogo, TitleFadeSecondLogo, TitleStartWhiteFade
	rtl
TitleCreateSecondLogo:				; creates the second title logo sprite and starts its palette fade
	lda.w #$000A
	sta.b $18
	lda.w #$0090
	sta.b $1A
	lda.w #$0027
	jsr.w CreateTitleFadingSprite
	ldx.b d1
	lda.w #TitleFadeSecondLogo
	sta.w $0002,x
TitleFadeSecondLogo:				; fades the second title logo palette, then resets the task delay
	ldx.b $91
	lda.w $0034,x
	and.w #$FF00
	xba
	clc
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	jsr.w QueueFadeStep
	bne CODE_C4D3FB
	ldx.b d1
	stz.w $0008,x
	lda.w #TitleStartWhiteFade
	sta.w $0002,x
TitleStartWhiteFade:				; waits for the task delay, then starts a white fade for the title palette
	lda.w $0008,x
	cmp.w #$003C
	bne CODE_C4D3FB
	lda.w #$0010
	sta.b $7D
	sta.b d3
	lda.b d4
	ldy.w #$7FFF
	jsl.l FillWords7E
	ldx.w #$00C2
	stx.b $71
	lda.w #$0AB8
	sta.b a3
	clc
	adc.b [a3]
	bcc .1
	inx
	clc
.1:									; A + $0002, if carry clear go to .2, X + 1
	adc.w #$0002
	bcc .2
	inx
	clc
.2:									; a3 = A, A + [a3], if carry clear go to .3, X + 1, ...
	sta.b a3
	adc.b [a3]
	bcc .3
	inx
	clc
.3:									; A + $0009, if carry clear go to .4, X + 1
	adc.w #$0009
	bcc .4
	inx
.4:									; $71 = X, a3 = A, X = $007E, A = d4, ...
	stx.b $71
	sta.b a3
	ldx.w #$007E
	lda.b d4
	ldy.b d5
	jsl.l StartColourFade
	ldx.b d1
	lda.w #TitleFinishWhiteFade
	sta.w $0002,x
TitleFinishWhiteFade:				; completes the title palette fade and enables the start key task
	lda.w #$0020
	jsr.w QueueFadeStep
	bne CODE_C4D4A0
	stz.b $95
	jsl.l AddStartKeyTask
	ldx.b d1
	lda.w #TitleStartTextPage
	sta.w $0002,x
CODE_C4D4A0:						; from TitleFinishWhiteFade, TitleFadeTextIn
	rtl
TitleStartTextPage:					; draws the next title text page and starts its fade task
	jsr.w DrawTitleTextPage
	ldx.b d1
	lda.w #TitleFadeTextIn
	sta.w $0002,x
TitleFadeTextIn:					; fades in the title text palette and resets the page hold timer
	lda.w #$0000
	jsr.w QueueFadeStep
	bne CODE_C4D4A0
	ldx.b d1
	stz.w $0008,x
	lda.w #TitleHoldTextPage
	sta.w $0002,x
TitleHoldTextPage:					; holds the title text page, then starts its fade to black
	lda.w $0008,x
	cmp.w #$00F0
	bne CODE_C4D52A
	lda.w #$0010
	sta.b d3
	lsr a
	sta.b $7D
	lda.b d4
	ldy.w #$0000
	jsl.l FillWords7E
	lda.w #$00C4
	sta.b $71
	lda.w #$BAD6
	sta.b a3
	ldx.w #$007E
	lda.b d4
	ldy.b d5
	jsl.l StartColourFade
	ldx.b d1
	lda.w #TitleFadeTextOut
	sta.w $0002,x
TitleFadeTextOut:					; fades out the text and selects the next page or the final title delay
	lda.w #$0000
	jsr.w QueueFadeStep
	bne CODE_C4D52A
	ldx.b $95
	lda.l DATA8_C4D10A,x
	and.w #$00FF
	bne .1
	ldx.b d1
	stz.w $0008,x
	lda.w #TitleEndDelay
	sta.w $0002,x
	rtl
.1:									; X = d1, $0002,x = TitleStartTextPage, return
	ldx.b d1
	lda.w #TitleStartTextPage
	sta.w $0002,x
	rtl
TitleEndDelay:						; ends the title task sequence after the final delay
	lda.w $0008,x
	cmp.w #$01E0
	bne CODE_C4D52A
	lda.w #$8000
	trb.b $85
CODE_C4D52A:						; from TitleHoldTextPage, TitleFadeTextOut, TitleEndDelay
	rtl
CreateTitleFadingSprite:			; creates a title sprite with a black palette and starts its colour fade
	jsl.l CreateSprite
	stx.b $91
	lda.w #$0010
	sta.b d3
	lda.b d4
	ldy.w #$0000
	jsl.l FillWords7E
	lda.w #$007E
	sta.b $71
	lda.b d4
	sta.b a3
	lda.w #$0020
	sta.b $7D
	ldx.b $91
	ldy.w $0034,x
	lda.l $008004
	and.w #$00FF
	tax
	tya
	and.w #$00FF
	xba
	lsr a
	lsr a
	lsr a
	adc.l $008002
	ldy.b d5
	jsl.l StartColourFade
	ldx.b $91
	lda.w $0034,x
	and.w #$FF00
	xba
	clc
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	tay
	ldx.w #$007E
	lda.b d4
	jsl.l QueueColours16
	rts
QueueFadeStep:						; one step of a 16-colour fade: StepColourFade, PackFadeColours into d4,
									; QueueColours16 to CGRAM at Y; $7D - 1
	pha
	lda.w #$0010
	sta.b d3
	ldy.b d5
	jsl.l StepColourFade
	ldx.w #$007E
	lda.b d4
	ldy.b d5
	jsl.l PackFadeColours
	ldx.w #$007E
	lda.b d4
	ply
	jsl.l QueueColours16
	dec.b $7D
	rts
DrawTitleTextPage:					; draws the next centred title text page and starts its palette fade
	lda.w #$0020
	sta.b $7D
	lsr a
	sta.b d3
	lda.w #$007E
	sta.b $71
	lda.b d4
	sta.b a3
	ldy.w #$0000
	jsl.l FillWords7E
	ldx.w #TextPalettes>>16
	lda.w #TextPalettes&$FFFF
	ldy.b d5
	jsl.l StartColourFade
	lda.b $D3
	ldy.w #$0700
	jsl.l ClearRAM7E
	ldx.b $95
	lda.l DATA8_C4D10A,x
	and.w #$00FF
	sta.b $99
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	stz.b d6
	lda.w #$2400
	sta.b $D5
	inx
.loop:								; loop: $95 = X, A = DATA8_C4D10A,x, X = A, Y = d6, ...
	stx.b $95
	lda.l DATA8_C4D10A,x
	tax
	ldy.b d6
	jsl.l PrintBoldCentred
	ldx.b $95
	lda.w #$2000
	cmp.b $D5
	beq .1
	sta.b $D5
	inc.b d6
.1:									; d6 + 1, X + 1, X + 1, $99 - 1, ...
	inc.b d6
	inx
	inx
	dec.b $99
	bne .loop
	stx.b $95
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0180
	pea.w $56C0
	pea.w $007E
	pei ($D3)
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rts
GetMapSetPalettePointer:			; returns the map set palette data pointer in X:A
	stx.b tmp1
	sta.b tmp0
	clc
	adc.b [tmp0]
	bcc .1
	inx
	clc
.1:									; A + $0002, if carry clear go to .2, X + 1
	adc.w #$0002
	bcc .2
	inx
	clc
.2:									; tmp0 = A, A + [tmp0], if carry clear go to .3, X + 1, ...
	sta.b tmp0
	adc.b [tmp0]
	bcc .3
	inx
	clc
.3:									; A + $0009, if carry clear go to .rts, X + 1
	adc.w #$0009
	bcc .rts
	inx
.rts:								; return
	rts
CopyrightScreen:					; the copyright and licence page at start, with logo sprites: a sound at
									; frame 60; from frame 195 a key pressed leaves, else frame 1200 does
	jsl.l ResetTransferQueues
	jsl.l ResetWorkBuf
	stz.w DMAEnShadow
	wai
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #$FFFF
	stz.w BG1HScroll
	stz.w BG2HScroll
	stz.w BG3HScroll
	sta.w BG1VScroll
	sta.w BG3VScroll
	lda.w #$0400
	sta.b tmp1
	lda.w #$5800
	sta.b tmp0
	lda.w #TiledBackMap&$FFFF
	ldx.w #TiledBackMap>>16
	ldy.w #$2000
	jsl.l MapSetToVRAM
	sep #$20
	pea.w $7E80
	plb
	lda.b #$17
	sta.w TM
	lda.b #$09
	sta.w BGMODE
	lda.b #$03
	sta.w OBSEL
	plb
	rep #$20
	lda.w #BlueColoursHook
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	jsl.l ResetSprites
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	lda.w #$007C
	sta.b $18
	lda.w #$000F
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	lda.w #$0005
	jsl.l SetSpriteAnim
	lda.w #$0018
	sta.b $1A
	lda.w #$0039
	sta.b $18
	lda.w #$001C
	jsl.l CreateSprite
	lda.w #$0004
	jsl.l SetSpriteAnim
	lda.w #$00A8
	sta.b $1A
	lda.w #$00B1
	sta.b $18
	lda.w #$001C
	jsl.l CreateSprite
	lda.w #$0004
	jsl.l SetSpriteAnim
	jsl.l InitTextMap
	lda.w #$0004
	sta.w $18DE
	lda.w #$54F9
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	lda.w #$8000
	sta.w DMAEnShadow
	stz.w fadestep
	stz.b $26
	stz.b a0
.loop:								; loop: call UpdateMenuSpritesTwice, call ReadMenuPads, ...
									; $FFF0, ...
	jsl.l UpdateMenuSpritesTwice
	jsl.l ReadMenuPads
	lda.w padchangeany
	and.w #$FFF0
	tsb.b a0
	lda.b $26
	cmp.w #$003C
	bne .1
	lda.w #DATA8_CF05D4&$FFFF
	ldx.w #DATA8_CF05D4>>16
	jsl.l LoadSounds
	bra .loop
.1:									; if A < $00C3 go to .loop, if a0 is not 0 go to .2, ...
	cmp.w #$00C3
	bcc .loop
	ldx.b a0
	bne .2
	cmp.w #$04B0
	bcc .loop
.2:									; call FadeOutWait, go to ClearNMIHook
	jsl.l FadeOutWait
	jml.l ClearNMIHook
InitAwardScreen:					; prepares the shared awards background, sprites, text map and colour hook
	jsl.l ResetTransferQueues
	jsl.l ResetSprites
	jsl.l ResetWorkBuf
	lda.w #$007F
	sta.b $2E
	lda.w #$D80A
	sta.b r0
	lda.w #TeamPalettes&$FFFF
	ldx.w #TeamPalettes>>16
	jsl.l Decompress
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	jsl.l ClearNMIHook
	wai
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #$0400
	sta.b tmp1
	lda.w #$5800
	sta.b tmp0
	lda.w #TiledBackMap&$FFFF
	ldx.w #TiledBackMap>>16
	ldy.w #$2000
	jsl.l MapSetToVRAM
	ldy.w #$5000
	jsl.l QueueClearVRAM
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	jsl.l InitTextMap
	jsl.l WaitTransfers
	lda.w #$8000
	sta.w DMAEnShadow
	sep #$20
	lda.b #$09
	sta.l BGMODE
	lda.b #$1F
	sta.l TM
	lda.b #$03
	sta.l OBSEL
	rep #$20
	stz.w BG2HScroll
	jsl.l RefreshSpritesLong
	lda.w #BlueColoursHook
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	rts
SeasonAwards:						; the end of season awards: the awards music, then award a0 (from 0) with
									; DrawAward, FindAwardWinner and its winner; pad left / right steps
									; through the 8 awards, start returns
	jsl.l SoundVolumeDown
	lda.w #(DATA8_CF05D4+$7)&$FFFF
	ldx.w #(DATA8_CF05D4+$7)>>16
	ldy.w #$FF00
	jsl.l LoadSounds
	lda.w #$00A7
	jsl.l StartSound
	jsl.l SoundVolumeUp
	jsr.w InitAwardScreen
	lda.w #$003D
	sta.b $1A
	lda.w #$0030
	sta.b $18
	lda.w #$0026
	jsl.l CreateSprite
	stx.b a4
	lda.w #$2000
	sta.b $36,x
	lda.w #$FFFF
	sta.b $75
	lda.w #$0240
	jsl.l AllocWorkBuf
	sta.b r0
	sta.b r2
	lda.w #$007E
	sta.b $2E
	ldx.w #GradientBarTiles>>16
	lda.w #GradientBarTiles&$FFFF
	jsl.l Decompress
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0240
	pea.w $0640
	pea.w $007E
	pei ($34)
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l WaitTransfers
	ldy.w #$2864
	ldx.w #$5245
	jsl.l MapTileBlock
	ldy.w #$3076
	ldx.w #$5106
	jsr.w MapPhotoTiles
	lda.w #$0240
	jsl.l FreeWorkBuf
	lda.w #$0002
	sta.w BG2VScroll
	lda.w #$5419
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	jsl.l SendTextMap
	stz.w fadestep
	stz.b a0
	jsl.l WaitTransfers
	jsr.w DrawAward
	jsr.w FindAwardWinner
	jsr.w DrawAwardWinner
.loop:								; loop: TransfersReady + 1, call ReadMenuPads, $26 + 1, ...
	inc.w TransfersReady
	wai
	jsl.l ReadMenuPads
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$0100
	beq .1
	lda.b a0
	inc a
	cmp.w #$0008
	bcc .2
	lda.w #$0000
	bra .2
.1:									; if $0200 bits clear go to .4, A = a0, A - 1, ...
	bit.w #$0200
	beq .4
	lda.b a0
	dec a
	bpl .2
	lda.w #$0007
.2:									; a0 = A, A = $D3, A + $0140, Y = $0480, ...
	sta.b a0
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0480
	jsl.l ClearRAM7E
	jsr.w DrawAward
	jsr.w FindAwardWinner
	ldx.b a0
	cpx.w #$0007
	bne .3
	jsr.w DrawPresidentsWinner
	bra .loop
.3:									; call DrawAwardWinner, go to .loop
	jsr.w DrawAwardWinner
	bra .loop
.4:									; if $1000 bits clear go to .loop, return
	bit.w #$1000
	beq .loop
	rtl
DrawAward:							; award a0: prints its name (AwardNames) and description (AwardDescs) and
									; unpacks its picture (AwardPictures)
	lda.w #$0005
	sta.w $18DE
	ldy.w #$5000
	jsl.l ClearVRAM
	jsl.l SendTextMap
	jsl.l WaitTransfers
	ldx.b $75
	bmi .1
	jsl.l DeleteSprite
	lda.w #$FFFF
	sta.b $75
.1:									; X = a4, A = $22,x, A and $FFFE, $22,x = A, ...
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	jsl.l RefreshSpritesLong
	lda.w #$0088
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b a0
	asl a
	pha
	asl a
	tax
	phx
	lda.l AwardNames,x
	tax
	ldy.w #$0012
	jsl.l PrintBoldCentred
	plx
	lda.l AwardNames+2,x
	beq .2
	tax
	ldy.w #$0013
	jsl.l PrintBoldCentred
.2:									; $CF = 0, $D1 = $0100, pull X, A = AwardDescs,x, ...
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	plx
	lda.l AwardDescs,x
	tax
	ldy.w #$0015
	jsl.l PrintBoldCentred
	jsl.l WaitTransfers
	lda.b a0
	asl a
	asl a
	tax
	lda.b $08
	sta.b r1
	lda.w #$007E
	sta.b $32
	lda.l AwardPictures+2,x
	tay
	lda.l AwardPictures,x
	tyx
	jsl.l MapSetToWRAM
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	ldx.b a0
	lda.l DATA8_C4DA75,x
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	pha
	sta.b tmp0
	pea.w $0000
	pea.w $007E
	lda.b $08
	clc
	adc.w #$00EA
	pha
	adc.b tmp0
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0030
	pea.w $007E
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l WaitTransfers
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	ldx.w #$50B3
	ldy.b $08
.loop:								; loop: push X, push Y, A = Y, A + $0012, ...
	pea.w $0012
	phx
	pea.w $007E
	phy
	tya
	clc
	adc.w #$0012
	tay
	txa
	clc
	adc.w #$0020
	tax
	cmp.w #$5253
	bne .loop
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$0009
	sta.w $18DE
	rts
AwardPictures:						; the picture (map set) of each award, a long pointer; read by DrawAward
	dw VezinaPicMap&$FFFF,VezinaPicMap>>16	; 0: Vezina Trophy
	dw SelkePicMap&$FFFF,SelkePicMap>>16	; 1: Frank J. Selke Trophy
	dw ConnSmythePicMap&$FFFF,ConnSmythePicMap>>16	; 2: Conn Smythe Trophy
	dw JenningsPicMap&$FFFF,JenningsPicMap>>16	; 3: William M. Jennings Trophy
	dw HartPicMap&$FFFF,HartPicMap>>16	; 4: Hart Memorial Trophy
	dw ArtRossPicMap&$FFFF,ArtRossPicMap>>16	; 5: Art Ross Trophy
	dw NorrisPicMap&$FFFF,NorrisPicMap>>16	; 6: James Norris Memorial Trophy
	dw PresidentsPicMap&$FFFF,PresidentsPicMap>>16	; 7: Presidents Trophy
DATA8_C4DA75:						; not traced: a table read by DrawAward
	db $3B,$2F,$4C,$5F,$31,$52,$42,$22
AwardNames:							; per award: the name text, then a second line or 0; DrawAward
	dw $4FC2,$0000					; 0: Vezina Trophy
	dw $4FD9,$4FAC					; 1: Frank J. Selke Trophy
	dw $4FF7,$4FAC					; 2: Conn Smythe Trophy
	dw $501A,$5039					; 3: William M. Jennings Trophy
	dw $5045,$4FAC					; 4: Hart Memorial Trophy
	dw $5061,$0000					; 5: Art Ross Trophy
	dw $5079,$4FB1					; 6: James Norris Memorial Trophy
	dw $508F,$4FAC					; 7: Presidents Trophy
AwardDescs:							; per award: the description text; read by DrawAward
	dw $4FCD						; 0: Vezina Trophy
	dw $4FE5						; 1: Frank J. Selke Trophy
	dw $5001						; 2: Conn Smythe Trophy
	dw $5023						; 3: William M. Jennings Trophy
	dw $5050						; 4: Hart Memorial Trophy
	dw $506F						; 5: Art Ross Trophy
	dw $5083						; 6: James Norris Memorial Trophy
	dw $5097						; 7: Presidents Trophy
DrawAwardWinner:					; winner A of award a0: his team's name, his photo (the team's logo sprite
									; when he has none) and his name
	pha
	jsl.l PlayerNumberTeamLong
	and.w #$00FF
	sta.w HomeTeam
	asl a
	tax
	lda.w #$0028
	sta.b $CF
	lda.w #$0070
	sta.b $D1
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0012
	jsl.l PrintThinCentred
	jsl.l LoadGameRostersLong
	ldy.w #$FFFE
	pla
.loop:								; loop: Y + 1, Y + 1, if A is not $2E03,y go to .loop, $65 = Y, ...
	iny
	iny
	cmp.w $2E03,y
	bne .loop
	sty.b $65
	lda.w $2EA7,y
	sta.b a1
	and.w #$00FF
	sta.b $71
	tax
	cmp.w #$00FF
	beq .1
	lda.w $2E75,y
	sta.b a3
	clc
	adc.w #$00C0
	phy
	ldy.b $68
	jsr.w UnpackPlayerPhoto
	ply
	sta.b a2
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0760
	pea.w $007E
	pei ($6B)
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0040
	pei ($71)
	lda.b a1
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b a3
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ldx.b a4
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsl.l WaitTransfers
	bra .2
.1:									; X = a4, A = $22,x, A and $FFFE, $22,x = A, ...
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	lda.w #$0058
	sta.b $1A
	lda.w #$004C
	sta.b $18
	lda.w HomeTeam
	jsl.l CreateSprite
	stx.b $75
	stz.w $364E
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$047D
	mvn $7E,$7E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0760
	pea.w $007E
	pea.w $364E
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
.2:									; $CF = $0010, $D1 = $0080, A = $65, A * 2, ...
	lda.w #$0010
	sta.b $CF
	lda.w #$0080
	sta.b $D1
	lda.b $65
	asl a
	asl a
	asl a
	asl a
	adc.w #$2EE1
	tax
	ldy.w #$000F
	jsl.l PrintBoldCentredStr
	jsl.l CODE_C5A4B5
	jsl.l SendTextMap
	jsl.l WaitTransfers
	ldy.w #$2864
	ldx.w #$5245
	jsl.l MapTileBlock
	ldy.w #$3076
	ldx.w #$5106
	jsr.w MapPhotoTiles
	rts
DrawPresidentsWinner:				; winner A of the Presidents Trophy: the team's name and its logo sprite
	sta.w HomeTeam
	asl a
	tax
	lda.w #$0028
	sta.b $CF
	lda.w #$0070
	sta.b $D1
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0012
	jsl.l PrintThinCentred
	stz.w $364E
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$047D
	mvn $7E,$7E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0760
	pea.w $007E
	pea.w $364E
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	lda.w #$0058
	sta.b $1A
	lda.w #$004C
	sta.b $18
	lda.w HomeTeam
	jsl.l CreateSprite
	stx.b $75
	jsl.l CODE_C5A4B5
	jsl.l SendTextMap
	jsl.l WaitTransfers
	ldy.w #$2864
	ldx.w #$5245
	jsl.l MapTileBlock
	rts
FindAwardWinner:					; A = the winner of award a0, from its routine in AwardScanTbl
	lda.w #$0030
	sta.b $69
	lda.b a0
	asl a
	tax
	jmp (AwardScanTbl,x)
AwardScanTbl:						; the routine that finds the winner of each award, in award order
									; (FindAwardWinner)
	dw ScanVezina,ScanSelke,ScanConnSmythe,ScanJennings
	dw ScanHart,ScanArtRoss,ScanNorris,ScanPresidents
ScanVezina:							; Vezina Trophy: of the goalies of the 26 teams, the one SeasonSavesLong
									; scores highest
	lda.w #$0000
	sta.b a2
.1:									; $6D = A, HomeTeam = A, call LoadSeasonHomeRoster
	sta.b $6D
	sta.w HomeTeam
	jsl.l LoadSeasonHomeRoster
.loop:								; loop: A = $2DCB, A - 1, if the result < 0 go to .2, $2DCB = A, ...
	lda.w $2DCB
	dec a
	bmi .2
	sta.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l SeasonSavesLong
	lda.b tmp0
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.2:									; A = $6D, A + 1, if A is not $001A go to .1, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .1
	lda.b $71
	rts
ScanSelke:							; Selke Trophy: from the team CODE_C4DF5B picks, the forward with the most
									; goals + assists
	stz.b a2
	jsr.w CODE_C4DF5B
	sta.w HomeTeam
	jsl.l LoadSeasonHomeRoster
	stz.b a2
.loop:								; loop: A = $2DCD, A - 1, if the result < 0 go to .1, ...
	lda.w $2DCD
	dec a
	bmi .1
	beq .1
	sta.w $2DCD
	clc
	adc.w $2DCB
	asl a
	tax
	lda.w $2E05,x
	sta.b a3
	jsl.l SeasonGoalsLong
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l SeasonAssistsLong
	lda.b tmp0
	clc
	adc.b tmp1
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.1:									; A = $71, return
	lda.b $71
	rts
ScanConnSmythe:						; Conn Smythe Trophy: of the skaters of the 16 playoff teams, the one with
									; the highest playoff goals + assists
	lda.w #$0000
	sta.b a2
.1:									; $6D = A, X = A, A = SRPOTeams,x, A and $00FF, ...
	sta.b $6D
	tax
	lda.l SRPOTeams,x
	and.w #$00FF
	sta.w HomeTeam
	jsl.l LoadSeasonHomeRoster
	lda.w $2DC9
	clc
	sbc.w $2DCB
	sta.w $2DC9
.loop:								; loop: A = $2DC9, A - 1, if the result < 0 go to .2, $2DC9 = A, ...
	lda.w $2DC9
	dec a
	bmi .2
	sta.w $2DC9
	ldx.b $6D
	sec
	adc.w $2DCB
	pha
	jsr.w ReadPlayoffPlayerGoals
	sta.b tmp2
	pla
	ldx.b $6D
	jsr.w ReadPlayoffPlayerAssists
	clc
	adc.b tmp2
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.w $2DC9
	sec
	adc.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b $71
	bra .loop
.2:									; A = $6D, A + 1, if A < $0010 go to .1, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$0010
	bcc .1
	lda.b $71
	rts
ScanJennings:						; Jennings Trophy: from the team CODE_C4DF5B picks, ...
									; scores highest
	stz.b a2
	jsr.w CODE_C4DF5B
	sta.w HomeTeam
	jsl.l LoadSeasonHomeRoster
	stz.b a2
.loop:								; loop: A = $2DCB, A - 1, if the result < 0 go to .1, $2DCB = A, ...
	lda.w $2DCB
	dec a
	bmi .1
	sta.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l SeasonGoalieGamesLong
	lda.b tmp0
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.1:									; A = $71, return
	lda.b $71
	rts
ScanHart:							; Hart Trophy: of the 8 teams with the highest standings word $0A, the
									; skater with the biggest share of his team's goals + assists
	stz.b a2
	stz.b $32
	ldx.w #$002E
.loop:								; loop: $364E,x = 0, X - 1, X - 1, if the result >= 0 go to .loop, ...
	stz.w $364E,x
	dex
	dex
	bpl .loop
	lda.w #$0000
.1:									; $6D = A, call BuildTeamSeasonRecordLong, X = $364E
	sta.b $6D
	jsl.l BuildTeamSeasonRecordLong
	ldx.w #$364E
.loop2:								; loop: if $000A,y >= $0000,x go to .2, A = X, A + $0006, X = A, ...
	lda.w $000A,y
	cmp.w $0000,x
	bcs .2
	txa
	clc
	adc.w #$0006
	tax
	cmp.w #$367E
	bne .loop2
	bra .4
.2:									; push Y, A = X, A xor $FFFF, A + 1, ...
	phy
	txa
	eor.w #$FFFF
	inc a
	clc
	ldy.w #$367D
	ldx.w #$3677
	adc.w #$3678
	beq .3
	dec a
	mvp $7E,$7E
.3:									; pull Y, X + 1, $0000,x = $000A,y, $0004,x = $6D
	ply
	inx
	lda.w $000A,y
	sta.w $0000,x
	lda.b $6D
	sta.w $0004,x
.4:									; A = $6D, A + 1, if A is not $001A go to .1, X = $0000
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .1
	ldx.w #$0000
.5:									; $6D = X, HomeTeam = $3652,x, call LoadSeasonHomeRoster, tmp2 = 0, ...
	stx.b $6D
	lda.w $3652,x
	sta.w HomeTeam
	jsl.l LoadSeasonHomeRoster
	stz.b tmp2
	stz.b r1
	lda.w $2DCF
	clc
	adc.w $2DCD
.loop3:								; loop: A - 1, if the result < 0 go to .loop4, $2DCD = A, A + $2DCB, ...
	dec a
	bmi .loop4
	sta.w $2DCD
	adc.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l SeasonGoalsLong
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l SeasonAssistsLong
	lda.b tmp0
	clc
	adc.b tmp1
	ldx.b tmp2
	sta.w $3680,x
	clc
	adc.b r1
	sta.b r1
	lda.b a3
	sta.w $367E,x
	inx
	inx
	inx
	inx
	stx.b tmp2
	lda.w $2DCD
	bra .loop3
.loop4:								; loop: X - 1, X - 1, X - 1, X - 1, ...
	dex
	dex
	dex
	dex
	bmi .6
	stx.b tmp2
	stz.b r2
	stz.b $36
	lda.w $3680,x
	asl a
	sta.b $35
	pei ($30)
	pei ($32)
	jsl.l Div32x32U
	pla
	sta.b $32
	pla
	sta.b r1
	ldx.b tmp2
	lda.b r0
	cmp.b a2
	bcc .loop4
	sta.b a2
	lda.w $367E,x
	sta.b $71
	bra .loop4
.6:									; A = $6D, A + $0006, X = A, if A >= $0030 go to .7, ...
	lda.b $6D
	clc
	adc.w #$0006
	tax
	cmp.w #$0030
	bcs .7
	jmp.w .5
.7:									; A = $71, return
	lda.b $71
	rts
ScanArtRoss:						; Art Ross Trophy: of all players, goalies skipped, the one with the most
									; goals + assists
	lda.w #$FFFF
	sta.w HomeTeam
	inc a
	sta.b a2
.loop:								; loop: a3 = A, A * 2, A + a3, A / 2, ...
	sta.b a3
	asl a
	adc.b a3
	lsr a
	tax
	lda.l SRPlayerTeams,x
	bcc .1
	lsr a
	lsr a
	lsr a
	lsr a
.1:									; A and $001F, if A >= $001A go to .3, if A = HomeTeam go to .2, ...
	and.w #$001F
	cmp.w #$001A
	bcs .3
	cmp.w HomeTeam
	beq .2
	sta.w HomeTeam
	pei ($6F)
	pei ($71)
	jsl.l LoadSeasonHomeRoster
	pla
	sta.b $71
	pla
	sta.b a3
.2:									; A = $2DCB, A - 1, A * 2, X = A, ...
	lda.w $2DCB
	dec a
	asl a
	tax
	lda.b a3
.loop2:								; loop: if A = $2E03,x go to .3, X - 1, X - 1, ...
	cmp.w $2E03,x
	beq .3
	dex
	dex
	bpl .loop2
	jsl.l SeasonGoalsLong
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l SeasonAssistsLong
	lda.b tmp0
	clc
	adc.b tmp1
	cmp.b a2
	bcc .3
	sta.b a2
	lda.b a3
	sta.b $71
.3:									; A = a3, A + 1, if A < $027E go to .loop, A = $71, ...
	lda.b a3
	inc a
	cmp.w #$027E
	bcc .loop
	lda.b $71
	rts
ScanNorris:							; Norris Trophy: from the team CODE_C4DF5B picks, the defenceman with the
									; most goals + assists
	stz.b a2
	jsr.w CODE_C4DF5B
	sta.w HomeTeam
	jsl.l LoadSeasonHomeRoster
	stz.b a2
.loop:								; loop: A = $2DCF, A - 1, if the result = 0 go to .1, $2DCF = A, ...
	lda.w $2DCF
	dec a
	beq .1
	sta.w $2DCF
	clc
	adc.w $2DCB
	adc.w $2DCD
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l SeasonGoalsLong
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l SeasonAssistsLong
	lda.b tmp0
	clc
	adc.b tmp1
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.1:									; A = $71, return
	lda.b $71
	rts
ScanPresidents:						; Presidents Trophy: the team with the most standings points ($0004 of its
									; record), the lower $0006 on a tie
	lda.w #$FFFF
	sta.b a3
	lda.w #$0000
	sta.b a2
.loop:								; loop: $6D = A, call BuildTeamSeasonRecordLong, ...
	sta.b $6D
	jsl.l BuildTeamSeasonRecordLong
	lda.w $0004,x
	cmp.b a2
	bcc .2
	bne .1
	lda.w $0006,x
	cmp.b a3
	bcs .2
	sta.b a3
	lda.w $0004,x
.1:									; a2 = A, a3 = $0006,x, $71 = $6D
	sta.b a2
	lda.w $0006,x
	sta.b a3
	lda.b $6D
	sta.b $71
.2:									; A = $6D, A + 1, if A is not $001A go to .loop, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .loop
	lda.b $71
	rts
CODE_C4DF5B:						; from ScanSelke, ScanJennings, ScanNorris
	lda.w #$0000
	sta.b a2
	sta.b $71
	dec.b a2
.loop:								; loop: $6D = A, call BuildTeamSeasonRecordLong, ...
	sta.b $6D
	jsl.l BuildTeamSeasonRecordLong
	lda.w $002A,x
	cmp.b a2
	bcs .1
	sta.b a2
	lda.b $6D
	sta.b $71
.1:									; A = $6D, A + 1, if A is not $001A go to .loop, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .loop
	lda.b $71
	rts
ReadPlayoffPlayerGoals:				; returns the seven-bit playoff goals total for player A on playoff team X
	sta.b tmp0
	asl a
	asl a
	asl a
	sec
	sbc.b tmp0
	sta.b tmp0
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	adc.b tmp0
	tay
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	tay
	lda.l SRPOGoals,x
.loop:								; loop: A / 2, Y - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dey
	bpl .loop
	rol a
	and.w #$007F
	rts
ReadPlayoffPlayerAssists:			; returns the seven-bit playoff assists total for player A on playoff team
									; X
	sta.b tmp0
	asl a
	asl a
	asl a
	sec
	sbc.b tmp0
	sta.b tmp0
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	adc.b tmp0
	tay
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	tay
	lda.l SRPOAssists,x
.loop:								; loop: A / 2, Y - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dey
	bpl .loop
	rol a
	and.w #$007F
	rts
