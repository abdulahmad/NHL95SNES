ReadPausePad:						; read the controller that owns the pause menu
	lda.w sfpj
	lsr a
	jmp.w ReadjoyA
