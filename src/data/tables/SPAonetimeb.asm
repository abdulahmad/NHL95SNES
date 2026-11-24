SPAonetimeb:						; per direction (facedir & 7, * 2): the backhand one-timer
	dw .d0,.d1,.d2,.d3,.d4,.d5,.d6,.d7
	dw 0
.d0:								; direction 0
	dw SPFswingb+2,27,SPFswingb+1,4,SPFswingb,-20
.d1:								; direction 1
	dw SPFswingb+5,27,SPFswingb+4,4,SPFswingb+3,-20
.d2:								; direction 2
	dw SPFswingb+8,27,SPFswingb+7,4,SPFswingb+6,-20
.d3:								; direction 3
	dw SPFswingb+11,27,SPFswingb+10,4,SPFswingb+9,-20
.d4:								; direction 4
	dw SPFswingb+14,27,SPFswingb+13,4,SPFswingb+12,-20
.d5:								; direction 5
	dw SPFswingb+17,27,SPFswingb+16,4,SPFswingb+15,-20
.d6:								; direction 6
	dw SPFswingb+20,27,SPFswingb+19,4,SPFswingb+18,-20
.d7:								; direction 7
	dw SPFswingb+23,27,SPFswingb+22,4,SPFswingb+21,-20
