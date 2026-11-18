setpads:							; called from other segments
	txa
	lsr a
	ldy.b d4
	sta.w PadControlObj,y
	rtl
	rtl								; unreached: no code branches, falls or points here
	rtl
