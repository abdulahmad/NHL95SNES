; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C791FE
DATA8_C791FE:						; raw frame tiles for transfer index $0D4; pose not traced
	incbin "../Extracted/segments/bankC7_9000.bin":$1FE..$47E
DATA8_C7947E:						; raw frame tiles for transfer index $0D5; pose not traced
	incbin "../Extracted/segments/bankC7_9000.bin":$47E..$6FE
DATA8_C796FE:						; raw frame tiles for transfer index $0D6; pose not traced
	incbin "../Extracted/segments/bankC7_9000.bin":$6FE..$91E
DATA8_C7991E:						; raw frame tiles for transfer index $0D7; pose not traced
	incbin "../Extracted/segments/bankC7_9000.bin":$91E..$B9E
DATA8_C79B9E:						; raw frame tiles for transfer index $0D8; pose not traced
	incbin "../Extracted/segments/bankC7_9000.bin":$B9E..$E1E
DATA8_C79E1E:						; raw frame tiles for transfer index $0D9; pose not traced
	incbin "../Extracted/segments/bankC7_9000.bin":$E1E..$1000
	incbin "../Extracted/segments/bankC7_A000.bin":$0..$7E
