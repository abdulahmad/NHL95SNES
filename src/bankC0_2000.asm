; Segment bankC0_2000: three fonts for the text routine, which draws strings glyph by glyph into a buffer.
; Glyph rows are 2bpp (two bytes: planes 0 and 1); the right half of a 16 pixel row is 16 bytes on. The glyph
; number is the character code minus '0'.
org $C01A39
BoldFontGlyphs:						; 16 x 8 glyphs, bold with a shadow: 0-9, punctuation, A-Z
	incbin "../Extracted/segments/bankC0_1000.bin":$A39..$FF9
ItalicFontGlyphs:					; 16 x 16 glyphs, italic and shaded: 0-9, punctuation, A-Z, then the same
									; again for the lowercase character codes; its last letters lie under
									; ThinFontGlyphs
	incbin "../Extracted/segments/bankC0_1000.bin":$FF9..$1000
	incbin "../Extracted/segments/bankC0_2000.bin"
	incbin "../Extracted/segments/bankC0_3000.bin":0..$239
ThinFontGlyphs:						; 16 x 16 glyphs, thin capitals: four punctuation marks, then A-Z from
									; the glyph for A; the glyphs before them are ItalicFontGlyphs' letters
	incbin "../Extracted/segments/bankC0_3000.bin":$239..$CF9
