; Segment bankC1_5000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C15241
LogoWSHTiles:						; the WSH logo: 5 8x8 + 4 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_5000.bin":$241..$43F
LogoWPGTiles:						; the WPG logo: 4 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_5000.bin":$43F..$753
LogoASETiles:						; the Eastern all-star logo: 7 8x8 + 8 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_5000.bin":$753..$B10
LogoASWTiles:						; the Western all-star logo: 7 8x8 + 8 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_5000.bin":$B10..$EF4
Sprite28Tiles00:					; sprite 28 (an arrow, then a spinning disc), frame 0: 0 8x8 + 1 16x16
									; sprites, packed
	incbin "../Extracted/segments/bankC1_5000.bin":$EF4..$F6E
Sprite28Tiles01:					; sprite 28 (an arrow, then a spinning disc), frame 1: 0 8x8 + 1 16x16
									; sprites, packed
	incbin "../Extracted/segments/bankC1_5000.bin":$F6E..$FE5
Sprite28Tiles02:					; sprite 28 (an arrow, then a spinning disc), frame 2: 0 8x8 + 1 16x16
									; sprites, packed
	incbin "../Extracted/segments/bankC1_5000.bin":$FE5..$1000
	incbin "../Extracted/segments/bankC1_6000.bin":$0..$64
