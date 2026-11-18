setvideo:							; once per game frame: the sprite table built for the next vblank
									; (BuildSpriteOAM, PackOAMHigh, TransfersReady + 1), the scroll and the
									; rink rows
	jsl.l AnimateSprites
	jsl.l updatescroll
	jsl.l DrawPlayerTags
	jsl.l UpdateGameObjectSprites
	jsl.l DrawPadArrows
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	inc.w TransfersReady
	jsl.l showref
	jsl.l updatescroll_rows
	ldx.b a3
	rtl
