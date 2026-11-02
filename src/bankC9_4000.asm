; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9404B
DATA8_C9404B:						; raw frame tiles for transfer index $1ED; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$4B..$2AB
DATA8_C942AB:						; raw frame tiles for transfer index $1EE; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$2AB..$52B
DATA8_C9452B:						; raw frame tiles for transfer index $1EF; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$52B..$7AB
DATA8_C947AB:						; raw frame tiles for transfer index $1F0; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$7AB..$9AB
DATA8_C949AB:						; raw frame tiles for transfer index $1F1; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$9AB..$BAB
DATA8_C94BAB:						; raw frame tiles for transfer index $1F2; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$BAB..$DAB
DATA8_C94DAB:						; raw frame tiles for transfer index $1F3; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$DAB..$FAB
DATA8_C94FAB:						; raw frame tiles for transfer index $1F4; pose not traced
	incbin "../Extracted/segments/bankC9_4000.bin":$FAB..$1000
	incbin "../Extracted/segments/bankC9_5000.bin":$0..$1AB
