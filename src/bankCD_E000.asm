; Segment bankCD_E000: PlayerPhotosFLA (the Florida player photos, packed).
org $CDE01E
PlayerPhotosFLA:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCD_E000.bin":$22..$1000
	incbin "../Extracted/segments/bankCD_F000.bin":$0..$32B
