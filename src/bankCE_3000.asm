; Segment bankCE_3000: the Montreal player photos (PhotoPalettesMTL, PlayerPhotosMTL).
org $CE31C2
PhotoPalettesMTL:					; Montreal player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosMTL); the team photo table points here
	incbin "../Extracted/segments/bankCE_3000.bin":$1C2..$282
PlayerPhotosMTL:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCE_3000.bin":$286..$1000
	incbin "../Extracted/segments/bankCE_4000.bin":$0..$585
