; Segment bankC1_0000: the start of the sprite objects' data (docs/sprite_objects.md): their palettes,
; a run of words the records point at, then the tiles of the first frames.
org $C10000
SpritePalettes:						; 39 palettes of 16 colours; a sprite record gives its palette number
	incbin "../Extracted/segments/bankC1_0000.bin":0..$4E0
DATA8_C104E0:						; the word $04E2 again and again; record field +4 points into it (the
									; code loads it and drops it)
	incbin "../Extracted/segments/bankC1_0000.bin":$4E0..$533
LogoANHTiles:						; the ANH logo: 4 8x8 + 8 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_0000.bin":$533..$94E
LogoBOSTiles:						; the BOS logo: 4 8x8 + 8 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_0000.bin":$94E..$CFD
LogoBUFTiles:						; the BUF logo: 4 8x8 + 8 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_0000.bin":$CFD..$1000
	incbin "../Extracted/segments/bankC1_1000.bin":$0..$B8
