; Segment bankCE_C000: the San Jose player photos (PhotoPalettesSJ, PlayerPhotosSJ).
org $CECBDA
PhotoPalettesSJ:					; San Jose player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosSJ); the team photo table points here
	incbin "../Extracted/segments/bankCE_C000.bin":$BDA..$C9A
PlayerPhotosSJ:						; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCE_C000.bin":$C9E..$1000
	incbin "../Extracted/segments/bankCE_D000.bin":$0..$DCB
