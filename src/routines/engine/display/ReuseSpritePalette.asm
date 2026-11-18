ReuseSpritePalette:					; a sprite palette already loaded: its use count + 1 and its slot into
									; +$34 of the object
	inc a
	sta.w SpritePalUse,x
	and.w #$FF00
	tyx
	ora.b $34,x
	sta.b $34,x
	rtl
