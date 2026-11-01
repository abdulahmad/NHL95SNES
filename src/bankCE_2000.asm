; Segment bankCE_2000: the rest of the PlayerPhotosLA stream.
org $CE2000
; The PlayerPhotosLA stream continues from the previous segment.
	incbin "../Extracted/segments/bankCE_2000.bin":$0..$1000
	incbin "../Extracted/segments/bankCE_3000.bin":$0..$1C2
