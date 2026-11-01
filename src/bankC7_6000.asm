; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7621E
DATA8_C7621E:						; raw frame tiles for transfer index $0C0; pose not traced
	incbin "../Extracted/segments/bankC7_6000.bin":$21E..$49E
DATA8_C7649E:						; raw frame tiles for transfer index $0C1; pose not traced
	incbin "../Extracted/segments/bankC7_6000.bin":$49E..$71E
DATA8_C7671E:						; raw frame tiles for transfer index $0C2; pose not traced
	incbin "../Extracted/segments/bankC7_6000.bin":$71E..$99E
DATA8_C7699E:						; raw frame tiles for transfer index $0C3; pose not traced
	incbin "../Extracted/segments/bankC7_6000.bin":$99E..$C1E
DATA8_C76C1E:						; raw frame tiles for transfer index $0C4; pose not traced
	incbin "../Extracted/segments/bankC7_6000.bin":$C1E..$E9E
DATA8_C76E9E:						; raw frame tiles for transfer index $0C5; pose not traced
	incbin "../Extracted/segments/bankC7_6000.bin":$E9E..$1000
	incbin "../Extracted/segments/bankC7_7000.bin":$0..$FE
