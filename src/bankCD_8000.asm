; Segment bankCD_8000: the Calgary player photos (PhotoPalettesCGY, PlayerPhotosCGY).
org $CD8229
PhotoPalettesCGY:					; Calgary player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosCGY); the team photo table points here
	incbin "../Extracted/segments/bankCD_8000.bin":$229..$2E9
PlayerPhotosCGY:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankCD_8000.bin":$2ED..$1000
	incbin "../Extracted/segments/bankCD_9000.bin":$0..$411
