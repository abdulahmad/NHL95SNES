; Segment bankCD_9000: the Chicago player photos (PhotoPalettesCHI, PlayerPhotosCHI).
org $CD9411
PhotoPalettesCHI:					; Chicago player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosCHI); the team photo table points here
	incbin "../Extracted/segments/bankCD_9000.bin":$411..$4D1
PlayerPhotosCHI:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankCD_9000.bin":$4D5..$1000
	incbin "../Extracted/segments/bankCD_A000.bin":$0..$5BB
