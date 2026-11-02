; Segment bankC1_9000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C19084
NHLShieldTiles:						; the NHL shield: 5 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_9000.bin":$84..$46B
NHLPATiles:							; the NHLPA logo: 10 8x8 + 4 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_9000.bin":$46B..$660
SpritePieces:						; per frame: x and y origin, then an x, y byte pair for each sprite
LogoANHPieces:						; 4 small, 8 large sprites
	dw -25,-24
	db $30,$00,$20,$10,$28,$10,$20,$18,$00,$00,$10,$00,$20,$00,$00,$10
	db $10,$10,$00,$20,$10,$20,$20,$20
LogoBOSPieces:						; 4 small, 8 large sprites
	dw -22,-24
	db $20,$00,$20,$28,$10,$30,$18,$30,$00,$00,$10,$00,$20,$08,$00,$10
	db $10,$10,$20,$18,$00,$20,$10,$20
LogoCGYPieces:						; 3 small, 8 large sprites
	dw -24,-24
	db $20,$20,$28,$20,$20,$28,$00,$00,$10,$00,$20,$00,$00,$10,$10,$10
	db $20,$10,$00,$20,$10,$20
LogoCHIPieces:						; 4 small, 7 large sprites
	dw -24,-24
	db $00,$08,$20,$20,$28,$20,$20,$28,$08,$00,$18,$00,$00,$10,$10,$10
	db $20,$10,$00,$20,$10,$20
LogoDALPieces:						; 10 small, 5 large sprites
	dw -23,-24
	db $30,$00,$30,$08,$00,$10,$28,$10,$08,$20,$10,$20,$18,$20,$00,$28
	db $08,$28,$18,$28,$00,$00,$10,$00,$20,$00,$08,$10,$18,$10
LogoDETPieces:						; 11 small, 4 large sprites
	dw -24,-24
	db $28,$00,$10,$08,$28,$08,$20,$10,$28,$10,$20,$18,$10,$20,$18,$20
	db $00,$28,$08,$28,$10,$28,$18,$00,$00,$08,$10,$10,$00,$18
LogoEDMPieces:						; 0 small, 9 large sprites
	dw -24,-24
	db $00,$00,$10,$00,$20,$00,$00,$10,$10,$10,$20,$10,$00,$20,$10,$20
	db $20,$20
LogoFLAPieces:						; 5 small, 6 large sprites
	dw -24,-24
	db $00,$08,$18,$20,$20,$20,$28,$20,$18,$28,$08,$00,$18,$00,$00,$10
	db $10,$10,$20,$10,$08,$20
LogoHFDPieces:						; 0 small, 9 large sprites
	dw -23,-24
	db $00,$00,$10,$00,$20,$00,$00,$10,$10,$10,$20,$10,$00,$20,$10,$20
	db $20,$20
LogoLAPieces:						; 3 small, 6 large sprites
	dw -25,-16
	db $00,$08,$10,$20,$18,$20,$08,$00,$18,$00,$28,$00,$00,$10,$10,$10
	db $20,$10
LogoMTLPieces:						; 4 small, 6 large sprites
	dw -24,-20
	db $08,$20,$10,$20,$18,$20,$20,$20,$00,$00,$10,$00,$20,$00,$00,$10
	db $10,$10,$20,$10
LogoNJPieces:						; 5 small, 7 large sprites
	dw -24,-24
	db $28,$00,$00,$08,$28,$08,$20,$20,$20,$28,$08,$00,$18,$00,$00,$10
	db $10,$10,$20,$10,$00,$20,$10,$20
LogoNYIPieces:						; 4 small, 8 large sprites
	dw -24,-28
	db $20,$00,$20,$28,$10,$30,$18,$30,$00,$00,$10,$00,$20,$08,$00,$10
	db $10,$10,$20,$18,$00,$20,$10,$20
LogoOTWPieces:						; 7 small, 6 large sprites
	dw -24,-24
	db $20,$00,$00,$18,$08,$18,$18,$20,$18,$28,$20,$28,$28,$28,$10,$00
	db $00,$08,$20,$08,$10,$10,$20,$18,$08,$20
LogoPHIPieces:						; 5 small, 6 large sprites
	dw -24,-20
	db $00,$20,$08,$20,$10,$20,$18,$20,$20,$20,$00,$00,$10,$00,$20,$00
	db $00,$10,$10,$10,$20,$10
LogoPITPieces:						; 6 small, 5 large sprites
	dw -24,-24
	db $00,$10,$18,$10,$08,$20,$10,$20,$10,$28,$18,$28,$00,$00,$10,$00
	db $20,$08,$08,$10,$18,$18
LogoQUEPieces:						; 6 small, 5 large sprites
	dw -24,-20
	db $00,$20,$08,$20,$10,$20,$18,$20,$20,$20,$28,$20,$00,$00,$10,$00
	db $00,$10,$10,$10,$20,$10
LogoSJPieces:						; 6 small, 6 large sprites
	dw -24,-24
	db $20,$00,$20,$18,$28,$18,$00,$20,$18,$20,$20,$20,$00,$00,$10,$00
	db $20,$08,$00,$10,$10,$10,$08,$20
LogoSTLPieces:						; 3 small, 6 large sprites
	dw -24,-24
	db $20,$10,$10,$20,$10,$28,$00,$00,$10,$00,$20,$00,$00,$10,$10,$10
	db $00,$20
LogoTBPieces:						; 4 small, 7 large sprites
	dw -24,-24
	db $20,$00,$20,$08,$20,$10,$20,$18,$00,$00,$10,$00,$00,$10,$10,$10
	db $00,$20,$10,$20,$20,$20
LogoTORPieces:						; 5 small, 7 large sprites
	dw -24,-24
	db $00,$08,$28,$08,$20,$20,$28,$20,$20,$28,$08,$00,$18,$00,$00,$10
	db $10,$10,$20,$10,$00,$20,$10,$20
LogoVANPieces:						; 6 small, 7 large sprites
	dw -28,-24
	db $20,$00,$30,$10,$20,$18,$28,$18,$20,$20,$20,$28,$00,$00,$10,$00
	db $20,$08,$00,$10,$10,$10,$00,$20,$10,$20
LogoWSHPieces:						; 5 small, 4 large sprites
	dw -24,-20
	db $08,$18,$20,$18,$28,$18,$18,$20,$20,$20,$10,$00,$00,$08,$20,$08
	db $10,$10
LogoWPGPieces:						; 4 small, 7 large sprites
	dw -24,-24
	db $00,$08,$28,$08,$00,$20,$28,$20,$08,$00,$18,$00,$00,$10,$10,$10
	db $20,$10,$08,$20,$18,$20
LogoASEPieces:						; 7 small, 8 large sprites
	dw -25,-20
	db $30,$00,$30,$08,$30,$10,$30,$18,$00,$20,$28,$20,$30,$20,$00,$00
	db $10,$00,$20,$00,$00,$10,$10,$10,$20,$10,$08,$20,$18,$20
Sprite28Pieces00:					; 0 small, 1 large sprites
	dw -7,-12
	db $00,$00
Sprite28Pieces01:					; 0 small, 1 large sprites
	dw -7,0
	db $00,$00
Sprite28Pieces02:					; 0 small, 1 large sprites
	dw -7,-14
	db $00,$00
Sprite28Pieces05:					; 0 small, 1 large sprites
	dw -6,-14
	db $00,$00
Sprite28Pieces07:					; 0 small, 1 large sprites
	dw -5,-14
	db $00,$00
Sprite28Pieces08:					; 0 small, 1 large sprites
	dw -5,-15
	db $00,$00
Sprite28Pieces09:					; 2 small, 0 large sprites
	dw -2,-14
	db $00,$00,$00,$08
Sprite28Pieces10:					; 2 small, 0 large sprites
	dw -3,-14
	db $00,$00,$00,$08
Sprite28Pieces14:					; 1 small, 0 large sprites
	dw -3,-6
	db $00,$00
Sprite28Pieces17:					; 1 small, 0 large sprites
	dw -2,-6
	db $00,$00
Sprite28Pieces19:					; 1 small, 0 large sprites
	dw -1,-6
	db $00,$00
Sprite28Pieces20:					; 1 small, 0 large sprites
	dw -2,-7
	db $00,$00
Sprite28Pieces30:					; 2 small, 0 large sprites
	dw 0,0
	db $00,$00,$00,$08
PadNumbersPieces00:					; 0 small, 2 large sprites
	dw -15,-7
	db $00,$00,$10,$00
PadNumbersPieces01:					; 3 small, 0 large sprites
	dw -4,-11
	db $00,$00,$00,$08,$00,$10
PadNumbersPieces02:					; 1 small, 1 large sprites
	dw -6,-10
	db $00,$10,$00,$00
PadNumbersPieces03:					; 2 small, 1 large sprites
	dw -6,-11
	db $00,$10,$08,$10,$00,$00
PadNumbersPieces04:					; 0 small, 1 large sprites
	dw -6,-9
	db $00,$00
SkaterPieces00:						; 7 small, 6 large sprites
	dw 0,-56
	db $00,$08,$10,$10,$10,$18,$20,$20,$28,$20,$20,$28,$10,$30,$08,$00
	db $18,$00,$00,$10,$00,$20,$10,$20,$00,$30
SkaterPieces01:						; 6 small, 8 large sprites
	dw 0,-56
	db $00,$08,$20,$18,$20,$20,$28,$20,$20,$28,$10,$30,$08,$00,$18,$00
	db $00,$10,$10,$10,$30,$18,$00,$20,$10,$20,$00,$30
SkaterPieces02:						; 10 small, 5 large sprites
	dw 0,-55
	db $00,$08,$20,$10,$28,$10,$20,$18,$10,$20,$18,$20,$10,$28,$00,$30
	db $08,$30,$10,$30,$08,$00,$18,$00,$00,$10,$10,$10,$00,$20
SkaterPieces03:						; 11 small, 7 large sprites
	dw 0,-57
	db $20,$00,$20,$08,$20,$10,$20,$18,$30,$28,$38,$28,$00,$30,$08,$30
	db $10,$30,$38,$30,$00,$38,$00,$00,$10,$00,$00,$10,$10,$10,$00,$20
	db $10,$20,$20,$20
SkaterPieces04:						; 6 small, 7 large sprites
	dw 0,-59
	db $00,$08,$20,$10,$00,$30,$08,$30,$10,$30,$00,$38,$08,$00,$18,$00
	db $00,$10,$10,$10,$00,$20,$10,$20,$18,$30
SkaterPieces05:						; 5 small, 7 large sprites
	dw 0,-61
	db $20,$00,$20,$08,$00,$30,$08,$30,$00,$38,$00,$00,$10,$00,$00,$10
	db $10,$10,$00,$20,$10,$20,$20,$28
RedDotPieces:						; 2 small, 0 large sprites
	dw -2,0
	db $00,$00,$08,$00
EASportsPieces:						; 4 small, 2 large sprites
	dw -15,-11
	db $00,$10,$08,$10,$10,$10,$18,$10,$00,$00,$10,$00
EALogoEPieces:						; 0 small, 24 large sprites
	dw -44,-38
	db $10,$00,$20,$00,$30,$00,$40,$00,$50,$00,$00,$10,$10,$10,$20,$10
	db $30,$10,$40,$10,$00,$20,$10,$20,$20,$20,$30,$20,$00,$30,$10,$30
	db $20,$30,$30,$30,$40,$30,$00,$40,$10,$40,$20,$40,$30,$40,$40,$40
EALogoAPieces:						; 0 small, 19 large sprites
	dw -40,-38
	db $20,$00,$30,$00,$00,$10,$10,$10,$20,$10,$30,$10,$00,$20,$10,$20
	db $20,$20,$30,$20,$40,$20,$08,$30,$18,$30,$30,$30,$40,$30,$00,$40
	db $10,$40,$38,$40,$48,$40
SportsWordPieces:					; 0 small, 19 large sprites
	dw -75,-13
	db $00,$00,$10,$00,$20,$00,$30,$00,$40,$00,$50,$00,$60,$00,$70,$00
	db $80,$00,$00,$10,$10,$10,$20,$10,$30,$10,$40,$10,$50,$10,$60,$10
	db $70,$10,$80,$10,$90,$10
ElectronicWordPieces:				; 0 small, 9 large sprites
	dw -72,-5
	db $00,$00,$10,$00,$20,$00,$30,$00,$40,$00,$50,$00,$60,$00,$70,$00
	db $80,$00
ItsInThePieces:						; 0 small, 7 large sprites
	dw -52,-8
	db $00,$00,$10,$00,$20,$00,$30,$00,$40,$00,$50,$00,$60,$00
BlackBoxPieces:						; 1 small, 15 large sprites
	dw -3,-3
	db $30,$30,$00,$00,$10,$00,$20,$00,$30,$00,$00,$10,$10,$10,$20,$10
	db $30,$10,$00,$20,$10,$20,$20,$20,$30,$20,$00,$30,$10,$30,$20,$30
NHLShieldPieces:					; 5 small, 7 large sprites
	dw 0,0
	db $20,$00,$00,$20,$18,$20,$18,$28,$20,$28,$00,$00,$10,$00,$20,$08
	db $00,$10,$10,$10,$20,$18,$08,$20
NHLPAPieces:						; 10 small, 4 large sprites
	dw 0,0
	db $10,$08,$20,$10,$08,$18,$20,$18,$20,$28,$00,$30,$08,$30,$10,$30
	db $18,$30,$20,$30,$18,$00,$10,$10,$00,$20,$10,$20
