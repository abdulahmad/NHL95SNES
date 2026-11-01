; Segment bankCE_E000: the rest of the PlayerPhotosSTL stream.
org $CEE000
; The PlayerPhotosSTL stream continues from the previous segment.
	incbin "../Extracted/segments/bankCE_E000.bin":$0..$1000
	incbin "../Extracted/segments/bankCE_F000.bin":$0..$AB
