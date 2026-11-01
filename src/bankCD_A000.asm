; Segment bankCD_A000: the Dallas player photos (PhotoPalettesDAL, PlayerPhotosDAL).
org $CDA5BB
PhotoPalettesDAL:					; Dallas player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosDAL); the team photo table points here
	incbin "../Extracted/segments/bankCD_A000.bin":$5BB..$67B
PlayerPhotosDAL:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCD_A000.bin":$67F..$1000
	incbin "../Extracted/segments/bankCD_B000.bin":$0..$A13
