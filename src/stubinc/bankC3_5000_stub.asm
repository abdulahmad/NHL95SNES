;	Segment build for bankC3_5000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC3_5000). The org is in the segment
;	file.
hirom

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
PhotoPalettesEDM = $CDCC79			; the Edmonton photo set
PhotoPalettesDET = $CDBA13			; the Detroit photo set
PhotoPalettesDAL = $CDA5BB			; the Dallas photo set
PhotoPalettesCHI = $CD9411			; the Chicago photo set
PhotoPalettesCGY = $CD8229			; the Calgary photo set
PhotoPalettesBUF = $CD6FF6			; the Buffalo photo set
PhotoPalettesBOS = $CD5E35			; the Boston photo set
PhotoPalettesANH = $CD4A6D			; the Anaheim photo set
PhotoPalettesWPG = $CD3879			; the Winnipeg photo set
PhotoPalettesWSH = $CD25E0			; the Washington photo set
PhotoPalettesTB = $C04CE7
PhotoPalettesTOR = $C05DAC
PhotoPalettesVAN = $C06E6D

incsrc "../bankC3_5000.asm"
