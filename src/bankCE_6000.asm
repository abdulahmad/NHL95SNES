; Segment bankCE_6000: the New York (NYR) player photos (PhotoPalettesNYR, PlayerPhotosNYR; the stream
; continues).
org $CE6D00
PhotoPalettesNYR:					; New York (NYR) player photos: 16 colours for each of its 6 photos, then
									; the photos (PlayerPhotosNYR); the team photo table points here
	incbin "../Extracted/segments/bankCE_6000.bin":$D00..$DC0
PlayerPhotosNYR:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCE_6000.bin":$DC4..$1000
