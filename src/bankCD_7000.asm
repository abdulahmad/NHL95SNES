; Segment bankCD_7000: PlayerPhotosBUF (the Buffalo player photos, packed).
org $CD70B6
PlayerPhotosBUF:					; the 6 photos, packed: 48 x 48 pixels each, linear 4bpp (two pixels a
									; byte, 24 bytes a row)
	dw $1B00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankCD_7000.bin":$BA..$1000
	incbin "../Extracted/segments/bankCD_8000.bin":$0..$229
