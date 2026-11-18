UnpackStream0:						; unpack a format 0 stream that has no header, into bank $7E
	sta.l A1T1L						; the stream address
	lda.w #DMAP0					; D = the DMA registers, used as scratch and as code
	tcd
	sty.b $14
	sty.b $22
	lda.l $000008
	sta.b $18
	tay
	lda.w #$7E54					; builds mvn (opcode $54) to bank $7E, from the stream bank
	sta.b $20
	lda.w #$004C					; then jmp (opcode $4C) back to the loop
	sta.b $23
	lda.w #UnpackStream0Next		; the copy built in the DMA registers ends with jmp here
	sta.b $24
	jml.l UnpackStream0Loop-$400000	; run the loop from the bank $85 mirror, so jmp DMAP2 reaches
									; the DMA registers
