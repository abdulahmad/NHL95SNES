; Segment bankCE_D000: the St. Louis player photos (PhotoPalettesSTL, PlayerPhotosSTL; the stream
; continues).
org $CEDDCB
PhotoPalettesSTL:					; St. Louis player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosSTL); the team photo table points here
	incbin "../Extracted/segments/bankCE_D000.bin":$DCB..$E8B
PlayerPhotosSTL:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCE_D000.bin":$E8F..$1000
