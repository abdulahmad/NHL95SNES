clearTeamStats:						; clears the team stats (keeping both goalies), the penalty box lists
									; $FFFF, then sets up the two teams' words
	lda.w tmgoalie
	pha
	lda.w tmgoalie+2
	pha
	ldx.w #$01AE
.loop:								; loop: tmPwrGoals,x = 0, X - 1, X - 1, ...
	stz.w tmPwrGoals,x
	dex
	dex
	bpl .loop
	pla
	sta.w tmgoalie+2
	pla
	sta.w tmgoalie
	lda.w #$FFFF
	sta.w tmboxlist
	sta.w tmboxlist+$1A
	stz.w tmsort
	lda.w #$000C
	sta.w tmsort+2
	lda.w HomeTeam
	sta.w tmteam
	asl a
	tax
	lda.l $C30000,x
	sta.w tmdata
	lda.w VisTeam
	sta.w tmteam+2
	asl a
	tax
	lda.l $C30000,x
	sta.w tmdata+2
	rtl
