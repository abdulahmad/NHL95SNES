CopyrightScreen:					; the copyright and licence page at start, with logo sprites: a sound at
									; frame 60; from frame 195 a key pressed leaves, else frame 1200 does
	jsl.l ResetTransferQueues
	jsl.l ResetWorkBuf
	stz.w DMAEnShadow
	wai
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21						; inline parameters: DMAP and BBAD
	dl MenuGradientHDMA				; the HDMA table
	db $00							; the indirect bank
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
	lda.w #MenuBackMap&$FFFF
	ldx.w #MenuBackMap>>16
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
	sta.w TextSpaceWidth
	lda.w #CopyrightPage&$FFFF
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	lda.w #$8000
	sta.w DMAEnShadow
	stz.w fadein
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
	lda.w #SongLists&$FFFF
	ldx.w #SongLists>>16
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
