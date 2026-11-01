; Segment bankCE_4000: the New Jersey player photos (PhotoPalettesNJ, PlayerPhotosNJ).
org $CE4585
PhotoPalettesNJ:					; New Jersey player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosNJ); the team photo table points here
	incbin "../Extracted/segments/bankCE_4000.bin":$585..$645
PlayerPhotosNJ:						; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCE_4000.bin":$649..$1000
	incbin "../Extracted/segments/bankCE_5000.bin":$0..$7BF
