; Segment bankC1_4000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C14077
LogoQUETiles:						; the QUE logo: 6 8x8 + 5 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_4000.bin":$77..$31E
LogoSJTiles:						; the SJ logo: 6 8x8 + 6 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_4000.bin":$31E..$5FA
LogoSTLTiles:						; the STL logo: 3 8x8 + 6 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_4000.bin":$5FA..$893
LogoTBTiles:						; the TB logo: 4 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_4000.bin":$893..$BEB
LogoTORTiles:						; the TOR logo: 5 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_4000.bin":$BEB..$E8B
LogoVANTiles:						; the VAN logo: 6 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_4000.bin":$E8B..$1000
	incbin "../Extracted/segments/bankC1_5000.bin":$0..$241
