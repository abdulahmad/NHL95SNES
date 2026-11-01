; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9302B
DATA8_C9302B:						; raw frame tiles for transfer index $1E6; pose not traced
	incbin "../Extracted/segments/bankC9_3000.bin":$2B..$22B
DATA8_C9322B:						; raw frame tiles for transfer index $1E7; pose not traced
	incbin "../Extracted/segments/bankC9_3000.bin":$22B..$42B
DATA8_C9342B:						; raw frame tiles for transfer index $1E8; pose not traced
	incbin "../Extracted/segments/bankC9_3000.bin":$42B..$6AB
DATA8_C936AB:						; raw frame tiles for transfer index $1E9; pose not traced
	incbin "../Extracted/segments/bankC9_3000.bin":$6AB..$90B
DATA8_C9390B:						; raw frame tiles for transfer index $1EA; pose not traced
	incbin "../Extracted/segments/bankC9_3000.bin":$90B..$B8B
DATA8_C93B8B:						; raw frame tiles for transfer index $1EB; pose not traced
	incbin "../Extracted/segments/bankC9_3000.bin":$B8B..$DEB
DATA8_C93DEB:						; raw frame tiles for transfer index $1EC; pose not traced
	incbin "../Extracted/segments/bankC9_3000.bin":$DEB..$1000
	incbin "../Extracted/segments/bankC9_4000.bin":$0..$4B
