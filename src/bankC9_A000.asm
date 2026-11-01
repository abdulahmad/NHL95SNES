; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9A20B
DATA8_C9A20B:						; raw frame tiles for transfer index $21A; pose not traced
	incbin "../Extracted/segments/bankC9_A000.bin":$20B..$48B
DATA8_C9A48B:						; raw frame tiles for transfer index $21B; pose not traced
	incbin "../Extracted/segments/bankC9_A000.bin":$48B..$70B
DATA8_C9A70B:						; raw frame tiles for transfer index $21C; pose not traced
	incbin "../Extracted/segments/bankC9_A000.bin":$70B..$98B
DATA8_C9A98B:						; raw frame tiles for transfer index $21D; pose not traced
	incbin "../Extracted/segments/bankC9_A000.bin":$98B..$C0B
DATA8_C9AC0B:						; raw frame tiles for transfer index $21E; pose not traced
	incbin "../Extracted/segments/bankC9_A000.bin":$C0B..$E8B
DATA8_C9AE8B:						; raw frame tiles for transfer index $21F; pose not traced
	incbin "../Extracted/segments/bankC9_A000.bin":$E8B..$1000
	incbin "../Extracted/segments/bankC9_B000.bin":$0..$10B
