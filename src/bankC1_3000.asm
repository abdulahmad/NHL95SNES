; Segment bankC1_3000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C130D2
LogoNYITiles:						; the NYI logo: 4 8x8 + 8 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_3000.bin":$D2..$448
LogoNYRTiles:						; the NYR logo: 0 8x8 + 9 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_3000.bin":$448..$790
LogoOTWTiles:						; the OTW logo: 7 8x8 + 6 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_3000.bin":$790..$B1D
LogoPHITiles:						; the PHI logo: 5 8x8 + 6 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_3000.bin":$B1D..$DE8
LogoPITTiles:						; the PIT logo: 6 8x8 + 5 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_3000.bin":$DE8..$1000
	incbin "../Extracted/segments/bankC1_4000.bin":$0..$77
