; Segment bankC1_2000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C1211C
LogoFLATiles:						; the FLA logo: 5 8x8 + 6 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_2000.bin":$11C..$45A
LogoHFDTiles:						; the HFD logo: 0 8x8 + 9 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_2000.bin":$45A..$79B
LogoLATiles:						; the LA logo: 3 8x8 + 6 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_2000.bin":$79B..$A79
LogoMTLTiles:						; the MTL logo: 4 8x8 + 6 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_2000.bin":$A79..$D44
LogoNJTiles:						; the NJ logo: 5 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_2000.bin":$D44..$1000
	incbin "../Extracted/segments/bankC1_3000.bin":$0..$D2
