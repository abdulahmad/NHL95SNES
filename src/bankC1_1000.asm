; Segment bankC1_1000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C110B8
LogoCGYTiles:						; the CGY logo: 3 8x8 + 8 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_1000.bin":$B8..$42F
LogoCHITiles:						; the CHI logo: 4 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_1000.bin":$42F..$7A4
LogoDALTiles:						; the DAL logo: 10 8x8 + 5 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_1000.bin":$7A4..$AE8
LogoDETTiles:						; the DET logo: 11 8x8 + 4 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_1000.bin":$AE8..$D6B
LogoEDMTiles:						; the EDM logo: 0 8x8 + 9 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_1000.bin":$D6B..$1000
	incbin "../Extracted/segments/bankC1_2000.bin":$0..$11C
