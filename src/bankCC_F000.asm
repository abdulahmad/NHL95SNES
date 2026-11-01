; The tiles chunk of the rink map set (IceRinkMap ends bankCC_E000). Its LZSS stream runs on through
; bankCD_0000 and into bankCD_1000, which ends with IceRinkPalette.
org $CCFE36
IceRinkTiles:						; its tiles (520), LZSS; the stream continues in the next bank
	dw IceRinkPalette-IceRinkTiles-2	; tiles chunk length
	dw $0208						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $4100						; unpacked tile size
	incbin "../Extracted/segments/bankCC_F000.bin":$E40..$1000
