; Segment bankCD_C000: the Edmonton player photos (PhotoPalettesEDM, PlayerPhotosEDM).
org $CDCC79
PhotoPalettesEDM:					; Edmonton player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosEDM); the team photo table points here
	incbin "../Extracted/segments/bankCD_C000.bin":$C79..$D39
PlayerPhotosEDM:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCD_C000.bin":$D3D..$1000
	incbin "../Extracted/segments/bankCD_D000.bin":$0..$F5E
