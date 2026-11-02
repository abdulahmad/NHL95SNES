; Segment bankCD_3000: the Winnipeg player photos (PhotoPalettesWPG, PlayerPhotosWPG).
org $CD3879
PhotoPalettesWPG:					; Winnipeg player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosWPG); the team photo table points here
	incbin "../Extracted/segments/bankCD_3000.bin":$879..$939
PlayerPhotosWPG:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankCD_3000.bin":$93D..$1000
	incbin "../Extracted/segments/bankCD_4000.bin":$0..$A6D
