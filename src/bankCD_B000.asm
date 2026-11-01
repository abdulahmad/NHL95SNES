; Segment bankCD_B000: the Detroit player photos (PhotoPalettesDET, PlayerPhotosDET).
org $CDBA13
PhotoPalettesDET:					; Detroit player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosDET); the team photo table points here
	incbin "../Extracted/segments/bankCD_B000.bin":$A13..$AD3
PlayerPhotosDET:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCD_B000.bin":$AD7..$1000
	incbin "../Extracted/segments/bankCD_C000.bin":$0..$C79
