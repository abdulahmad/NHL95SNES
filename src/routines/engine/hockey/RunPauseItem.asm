RunPauseItem:						; runs item pauseitem of tab pausetab through its table: Info, Stats,
									; Options or the quit prompt (PracticeInfoJumps / PracticeOptionsJumps in
									; play mode 1)
	lda.w OptPlayMode
	cmp.w #$0001
	bne .4
	lda.w pauseitem
	asl a
	tax
	lda.w pausetab
	beq .3
	dec a
	beq .2
	dec a
	beq .1
	jmp (QuitPromptJumps,x)
.1:									; jump through PracticeOptionsJumps,x
	jmp (PracticeOptionsJumps,x)
.2:									; jump through PauseStatsJumps,x
	jmp (PauseStatsJumps,x)
.3:									; jump through PracticeInfoJumps,x
	jmp (PracticeInfoJumps,x)
.4:									; A = pauseitem, A * 2, X = A, if pausetab = 0 go to .7, ...
	lda.w pauseitem
	asl a
	tax
	lda.w pausetab
	beq .7
	dec a
	beq .6
	dec a
	beq .5
	jmp (QuitPromptJumps,x)
.5:									; jump through PauseOptionsJumps,x
	jmp (PauseOptionsJumps,x)
.6:									; jump through PauseStatsJumps,x
	jmp (PauseStatsJumps,x)
.7:									; jump through PauseInfoJumps,x
	jmp (PauseInfoJumps,x)
