; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C8E139
DATA8_C8E139:						; raw frame tiles for transfer index $1C9; pose not traced
	incbin "../Extracted/segments/bankC8_E000.bin":$139..$3B9
DATA8_C8E3B9:						; raw frame tiles for transfer index $1CA; pose not traced
	incbin "../Extracted/segments/bankC8_E000.bin":$3B9..$639
DATA8_C8E639:						; raw frame tiles for transfer index $1CB; pose not traced
	incbin "../Extracted/segments/bankC8_E000.bin":$639..$8B9
DATA8_C8E8B9:						; raw frame tiles for transfer index $1CC; pose not traced
	incbin "../Extracted/segments/bankC8_E000.bin":$8B9..$B39
DATA8_C8EB39:						; raw frame tiles for transfer index $1CD; pose not traced
	incbin "../Extracted/segments/bankC8_E000.bin":$B39..$D59
DATA8_C8ED59:						; raw frame tiles for transfer index $1CE; pose not traced
	incbin "../Extracted/segments/bankC8_E000.bin":$D59..$F59
DATA8_C8EF59:						; raw frame tiles for transfer index $1CF; pose not traced
	incbin "../Extracted/segments/bankC8_E000.bin":$F59..$1000
	incbin "../Extracted/segments/bankC8_F000.bin":$0..$1B9
