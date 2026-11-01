; Segment bankCE_7000: the rest of the PlayerPhotosNYR stream.
org $CE7000
; The PlayerPhotosNYR stream continues from the previous segment.
	incbin "../Extracted/segments/bankCE_7000.bin":$0..$1000
	incbin "../Extracted/segments/bankCE_8000.bin":$0..$87
