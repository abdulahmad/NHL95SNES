; Segment bankCF_B000: sound data: the rest of Sample31.
org $CFB000
; The rest of Sample31 (it starts in the previous segment).
	incbin "../Extracted/segments/bankCF_B000.bin":$0..$1000
	incbin "../Extracted/segments/bankCF_C000.bin":$0..$262
