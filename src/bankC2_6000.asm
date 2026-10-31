; Segment bankC2_6000: the middle of TitleGoalieTiles' LZSS stream (bankC2_3000), which ends in bankC2_7000;
; nothing else starts here.
org $C26000
	incbin "../Extracted/segments/bankC2_6000.bin"	; TitleGoalieTiles' stream, continued
