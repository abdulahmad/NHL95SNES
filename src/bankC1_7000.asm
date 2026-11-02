; Segment bankC1_7000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C17138
SkaterTiles02:						; a skating player, frame 2: 10 8x8 + 5 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_7000.bin":$138..$47A
SkaterTiles03:						; a skating player, frame 3: 11 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_7000.bin":$47A..$7F8
SkaterTiles04:						; a skating player, frame 4: 6 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_7000.bin":$7F8..$B65
SkaterTiles05:						; a skating player, frame 5: 5 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_7000.bin":$B65..$E9F
RedDotTiles:						; a small red dot: 2 8x8 + 0 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_7000.bin":$E9F..$ED1
EASportsTiles:						; the EA SPORTS logo: 4 8x8 + 2 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_7000.bin":$ED1..$1000
	incbin "../Extracted/segments/bankC1_8000.bin":$0..$34
