; Segment bankC1_8000: sprite object frame tiles (docs/sprite_objects.md): each block is the tiles
; of one frame, packed as a format 0 stream without its header, or raw.
org $C18034
EALogoETiles:						; the big E of the EA logo: 0 8x8 + 24 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_8000.bin":$34..$359
EALogoATiles:						; the big A of the EA logo: 0 8x8 + 19 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_8000.bin":$359..$7B2
SportsWordTiles:					; part of the word SPORTS: 0 8x8 + 19 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_8000.bin":$7B2..$C05
ElectronicWordTiles:				; part of the words ELECTRONIC ARTS: 0 8x8 + 9 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_8000.bin":$C05..$E05
ItsInTheTiles:						; the words It's in the: 0 8x8 + 7 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_8000.bin":$E05..$FD3
BlackBoxTiles:						; a black box with a white frame: 1 8x8 + 15 16x16 sprites, packed
	incbin "../Extracted/segments/bankC1_8000.bin":$FD3..$1000
	incbin "../Extracted/segments/bankC1_9000.bin":$0..$84
