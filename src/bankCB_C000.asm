; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CBC035
DATA8_CBC035:						; raw frame tiles for transfer index $35D; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$35..$235
DATA8_CBC235:						; raw frame tiles for transfer index $35E; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$235..$435
DATA8_CBC435:						; raw frame tiles for transfer index $35F; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$435..$635
DATA8_CBC635:						; raw frame tiles for transfer index $360; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$635..$835
DATA8_CBC835:						; raw frame tiles for transfer index $361; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$835..$A35
DATA8_CBCA35:						; raw frame tiles for transfer index $362; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$A35..$C35
DATA8_CBCC35:						; raw frame tiles for transfer index $363; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$C35..$E35
DATA8_CBCE35:						; raw frame tiles for transfer index $364; pose not traced
	incbin "../Extracted/segments/bankCB_C000.bin":$E35..$1000
	incbin "../Extracted/segments/bankCB_D000.bin":$0..$35
