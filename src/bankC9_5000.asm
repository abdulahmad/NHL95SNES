; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C951AB
DATA8_C951AB:						; raw frame tiles for transfer index $1F5; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$1AB..$3AB
DATA8_C953AB:						; raw frame tiles for transfer index $1F6; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$3AB..$5AB
DATA8_C955AB:						; raw frame tiles for transfer index $1F7; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$5AB..$7AB
DATA8_C957AB:						; raw frame tiles for transfer index $1F8; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$7AB..$9AB
DATA8_C959AB:						; raw frame tiles for transfer index $1F9; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$9AB..$BAB
DATA8_C95BAB:						; raw frame tiles for transfer index $1FA; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$BAB..$DAB
DATA8_C95DAB:						; raw frame tiles for transfer index $1FB; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$DAB..$FAB
DATA8_C95FAB:						; raw frame tiles for transfer index $1FC; pose not traced
	incbin "../Extracted/segments/bankC9_5000.bin":$FAB..$1000
	incbin "../Extracted/segments/bankC9_6000.bin":$0..$20B
