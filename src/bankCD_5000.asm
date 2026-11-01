; Segment bankCD_5000: the Boston player photos (PhotoPalettesBOS, PlayerPhotosBOS).
org $CD5E35
PhotoPalettesBOS:					; Boston player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosBOS); the team photo table points here
	incbin "../Extracted/segments/bankCD_5000.bin":$E35..$EF5
PlayerPhotosBOS:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankCD_5000.bin":$EF9..$1000
	incbin "../Extracted/segments/bankCD_6000.bin":$0..$FF6
