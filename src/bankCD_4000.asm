; Segment bankCD_4000: the Anaheim player photos (PhotoPalettesANH, PlayerPhotosANH).
org $CD4A6D
PhotoPalettesANH:					; Anaheim player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosANH); the team photo table points here
	incbin "../Extracted/segments/bankCD_4000.bin":$A6D..$B2D
PlayerPhotosANH:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCD_4000.bin":$B31..$1000
	incbin "../Extracted/segments/bankCD_5000.bin":$0..$E35
