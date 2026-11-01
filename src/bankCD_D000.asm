; Segment bankCD_D000: PhotoPalettesFLA (the Florida photo colours; the photos follow).
org $CDDF5E
PhotoPalettesFLA:					; Florida player photos: 16 colours for each of its 6 photos, then the
									; photos (PlayerPhotosFLA); the team photo table points here
	incbin "../Extracted/segments/bankCD_D000.bin":$F5E..$1000
	incbin "../Extracted/segments/bankCD_E000.bin":$0..$1E
