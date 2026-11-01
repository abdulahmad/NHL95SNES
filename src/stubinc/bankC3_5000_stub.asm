;	Segment build for bankC3_5000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC3_5000). The org is in the segment
;	file.
hirom

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
PhotoPalettesQUE = $CEB8A0			; the Quebec photo set
PhotoPalettesPIT = $CEA782			; the Pittsburgh photo set
PhotoPalettesPHI = $CE93D3			; the Philadelphia photo set
PhotoPalettesOTW = $CE8087			; the Ottawa photo set
PhotoPalettesNYR = $CE6D00			; the New York (NYR) photo set
PhotoPalettesNYI = $CE57BF			; the New York (NYI) photo set
PhotoPalettesNJ = $CE4585			; the New Jersey photo set
PhotoPalettesMTL = $CE31C2			; the Montreal photo set
PhotoPalettesLA = $CE1CC7			; the Los Angeles photo set
PhotoPalettesHFD = $CE09DA			; the Hartford photo set
PhotoPalettesFLA = $CDDF5E			; the Florida photo set
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
