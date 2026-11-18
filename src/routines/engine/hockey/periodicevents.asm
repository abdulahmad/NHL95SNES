periodicevents:						; from DoGameFrame and other segments
	jsl.l PenaltyManager
	jsl.l updatecrowdf
	jsl.l clockcont
	lda.w lldisp
	sec
	sbc.b d7
	sta.w lldisp
	bpl .rtl
	clc
	adc.w #$0018
	sta.w lldisp
	jsl.l ChkGoalies
	jsl.l RestoreBenchEnergy
	jsl.l CheckInjury
	jsl.l updatepwrplay
.rtl:								; return
	rtl
