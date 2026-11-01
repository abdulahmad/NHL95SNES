; Segment bankCE_5000: the New York (NYI) player photos (PhotoPalettesNYI, PlayerPhotosNYI).
org $CE57BF
PhotoPalettesNYI:					; New York (NYI) player photos: 16 colours for each of its 6 photos, then
									; the photos (PlayerPhotosNYI); the team photo table points here
	incbin "../Extracted/segments/bankCE_5000.bin":$7BF..$87F
PlayerPhotosNYI:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCE_5000.bin":$883..$1000
	incbin "../Extracted/segments/bankCE_6000.bin":$0..$D00
