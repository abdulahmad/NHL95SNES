; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C87019
DATA8_C87019:						; raw frame tiles for transfer index $151; pose not traced
	incbin "../Extracted/segments/bankC8_7000.bin":$19..$279
DATA8_C87279:						; raw frame tiles for transfer index $152; pose not traced
	incbin "../Extracted/segments/bankC8_7000.bin":$279..$4D9
DATA8_C874D9:						; raw frame tiles for transfer index $154; pose not traced
	incbin "../Extracted/segments/bankC8_7000.bin":$4D9..$719
DATA8_C87719:						; raw frame tiles for transfer index $155; pose not traced
	incbin "../Extracted/segments/bankC8_7000.bin":$719..$959
DATA8_C87959:						; raw frame tiles for transfer index $158; pose not traced
	incbin "../Extracted/segments/bankC8_7000.bin":$959..$BB9
DATA8_C87BB9:						; raw frame tiles for transfer index $159; pose not traced
	incbin "../Extracted/segments/bankC8_7000.bin":$BB9..$E19
DATA8_C87E19:						; raw frame tiles for transfer index $15A; pose not traced
	incbin "../Extracted/segments/bankC8_7000.bin":$E19..$1000
	incbin "../Extracted/segments/bankC8_8000.bin":$0..$19
