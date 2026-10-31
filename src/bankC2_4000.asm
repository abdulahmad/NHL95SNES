; Segment bankC2_4000: the middle of TitleGoalieTiles' LZSS stream (bankC2_3000), which ends in bankC2_7000;
; nothing else starts here.
org $C24000
	incbin "../Extracted/segments/bankC2_4000.bin"	; TitleGoalieTiles' stream, continued
