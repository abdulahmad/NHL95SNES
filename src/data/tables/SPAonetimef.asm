SPAonetimef:						; per direction (facedir & 7, * 2): the one-timer forehand animation:
									; (frame, time) pairs, the last time negative
	dw .d0,.d1,.d2,.d3,.d4,.d5,.d6,.d7
	dw 0
.d0:								; direction 0
	dw SPFswing+1,27,SPFswing+2,2,SPFswing+3,2,SPFswing+4,2,SPFswing+5,-20
.d1:								; direction 1
	dw SPFswing+7,27,SPFswing+8,2,SPFswing+9,2,SPFswing+10,2,SPFswing+11,-20
.d2:								; direction 2
	dw SPFswing+13,27,SPFswing+14,2,SPFswing+15,2,SPFswing+16,2,SPFswing+17,-20
.d3:								; direction 3
	dw SPFswing+19,27,SPFswing+20,2,SPFswing+21,2,SPFswing+22,2,SPFswing+23,-20
.d4:								; direction 4
	dw SPFswing+25,27,SPFswing+26,2,SPFswing+27,2,SPFswing+28,2,SPFswing+29,-20
.d5:								; direction 5
	dw SPFswing+31,27,SPFswing+32,2,SPFswing+33,2,SPFswing+34,2,SPFswing+35,-20
.d6:								; direction 6
	dw SPFswing+37,27,SPFswing+38,2,SPFswing+39,2,SPFswing+40,2,SPFswing+41,-20
.d7:								; direction 7
	dw SPFswing+43,27,SPFswing+44,2,SPFswing+45,2,SPFswing+46,2,SPFswing+47,-20
