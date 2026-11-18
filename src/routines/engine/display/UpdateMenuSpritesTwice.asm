UpdateMenuSpritesTwice:				; run the menu sprite update and transfer wait twice
	jsl.l UpdateMenuSprites
UpdateMenuSprites:					; animate menu sprites, build their OAM and wait for transfers
	jsl.l AnimateSprites
	lda.w #OAMBuf+$1FF
	sta.b $28
	lda.w #OAMHighBytes
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	inc.b $26
	jml.l WaitTransfers
