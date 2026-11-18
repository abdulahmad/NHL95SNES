RandomIntermissionGoal:				; returns a random value below two while switching to the work RAM data
									; bank
	lda.w #$0002
	pea.w $7F7E
	plb
	jsl.l RandomBelowA
	plb
	rts
