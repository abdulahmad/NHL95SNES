; Segment bankCE_1000: the Los Angeles player photos (PhotoPalettesLA, PlayerPhotosLA; the stream
; continues).
org $CE1CC7
PhotoPalettesLA:					; Los Angeles player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosLA); the team photo table points here
	incbin "../Extracted/segments/bankCE_1000.bin":$CC7..$D87
PlayerPhotosLA:						; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCE_1000.bin":$D8B..$1000
