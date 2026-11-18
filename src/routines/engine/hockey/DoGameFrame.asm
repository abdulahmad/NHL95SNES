DoGameFrame:						; one frame of game logic: UpdateBenchCheer, periodicevents,
									; updateplayers, checkwindow, updatereplay, then setvideo once
									; TransfersReady is 0
	jsl.l UpdateBenchCheer
	jsl.l periodicevents
	jsl.l updateplayers
	jsl.l checkwindow
	jsl.l updatereplay
.loop:								; loop: if TransfersReady is not 0 go to .loop, $28 = OAMBuf+$1FF, ...
	lda.w TransfersReady
	bne .loop
	lda.w #OAMBuf+$1FF
	sta.b $28
	lda.w #OAMHighBytes
	sta.b $2A
	jml.l setvideo
