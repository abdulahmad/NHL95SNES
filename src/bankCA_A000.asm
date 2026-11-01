; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CAA039
DATA8_CAA039:						; raw frame tiles for transfer index $284; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$39..$239
DATA8_CAA239:						; raw frame tiles for transfer index $285; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$239..$439
DATA8_CAA439:						; raw frame tiles for transfer index $286; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$439..$699
DATA8_CAA699:						; raw frame tiles for transfer index $288; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$699..$899
DATA8_CAA899:						; raw frame tiles for transfer index $289; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$899..$AF9
DATA8_CAAAF9:						; raw frame tiles for transfer index $28B; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$AF9..$D59
DATA8_CAAD59:						; raw frame tiles for transfer index $28C; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$D59..$FB9
DATA8_CAAFB9:						; raw frame tiles for transfer index $28E; pose not traced
	incbin "../Extracted/segments/bankCA_A000.bin":$FB9..$1000
	incbin "../Extracted/segments/bankCA_B000.bin":$0..$219
