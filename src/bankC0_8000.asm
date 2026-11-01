; Segment bankC0_8000: data, then the start of the engine: the NMI and IRQ with their hooks, the frame waits,
; the pad waits, RandomWord, the screen on / off routines and the 8 and 16 x 8 bit multiplies (as in 94S's
; engine bank). The data before the engine is not traced to a use, except TiledBackMap.
org $C08000
SpriteObjects:						; the sprite objects (docs/sprite_objects.md): the record list, then the
									; palettes; each record is one sprite, its frames point into bank $C1
	dw SpriteRecordList
	dl SpritePalettes
LogoANHFrame:						; 4 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 4,8							; the 8x8 and 16x16 sprite counts
	dw LogoANHPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoANHTiles					; its tiles
LogoANHSprite:						; the ANH logo
	dw LogoANHFrames,LogoANHFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$00				; into the $04E2 run (loaded, not used)
	db 4,8,12						; the most 8x8, 16x16 and both sprites in a frame
	dw -25,30,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 0							; palette number (SpritePalettes)
	dw (LogoANHFramesEnd-LogoANHFrames)/2	; number of frames
	db $03							; not traced
LogoANHFrames:						; its frames
	dw LogoANHFrame
LogoANHFramesEnd:					; the animation script
	dw OneFrameScript
OneFrameScript:						; animation script: frame numbers, and commands (bit 7 set)
	db $00,$80
LogoBOSFrame:						; 4 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 4,8							; the 8x8 and 16x16 sprite counts
	dw LogoBOSPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoBOSTiles					; its tiles
LogoBOSSprite:						; the BOS logo
	dw LogoBOSFrames,LogoBOSFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$03				; into the $04E2 run (loaded, not used)
	db 4,8,12						; the most 8x8, 16x16 and both sprites in a frame
	dw -22,25,-24,31				; x from, x to, y from, y to (a box: not traced)
	dw 1							; palette number (SpritePalettes)
	dw (LogoBOSFramesEnd-LogoBOSFrames)/2	; number of frames
	db $03							; not traced
LogoBOSFrames:						; its frames
	dw LogoBOSFrame
LogoBOSFramesEnd:					; the animation script
	dw OneFrameScript
LogoBUFFrame:						; 4 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 4,8							; the 8x8 and 16x16 sprite counts
	dw LogoBOSPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoBUFTiles					; its tiles
LogoBUFSprite:						; the BUF logo
	dw LogoBUFFrames,LogoBUFFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$05				; into the $04E2 run (loaded, not used)
	db 4,8,12						; the most 8x8, 16x16 and both sprites in a frame
	dw -22,25,-24,31				; x from, x to, y from, y to (a box: not traced)
	dw 2							; palette number (SpritePalettes)
	dw (LogoBUFFramesEnd-LogoBUFFrames)/2	; number of frames
	db $03							; not traced
LogoBUFFrames:						; its frames
	dw LogoBUFFrame
LogoBUFFramesEnd:					; the animation script
	dw OneFrameScript
LogoCGYFrame:						; 3 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 3,8							; the 8x8 and 16x16 sprite counts
	dw LogoCGYPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoCGYTiles					; its tiles
LogoCGYSprite:						; the CGY logo
	dw LogoCGYFrames,LogoCGYFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$07				; into the $04E2 run (loaded, not used)
	db 3,8,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 3							; palette number (SpritePalettes)
	dw (LogoCGYFramesEnd-LogoCGYFrames)/2	; number of frames
	db $03							; not traced
LogoCGYFrames:						; its frames
	dw LogoCGYFrame
LogoCGYFramesEnd:					; the animation script
	dw OneFrameScript
LogoCHIFrame:						; 4 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 4,7							; the 8x8 and 16x16 sprite counts
	dw LogoCHIPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoCHITiles					; its tiles
LogoCHISprite:						; the CHI logo
	dw LogoCHIFrames,LogoCHIFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$09				; into the $04E2 run (loaded, not used)
	db 4,7,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 4							; palette number (SpritePalettes)
	dw (LogoCHIFramesEnd-LogoCHIFrames)/2	; number of frames
	db $03							; not traced
LogoCHIFrames:						; its frames
	dw LogoCHIFrame
LogoCHIFramesEnd:					; the animation script
	dw OneFrameScript
LogoDALFrame:						; 10 8x8 and 5 16x16 sprites, packed tiles (flags 3)
	db 10,5							; the 8x8 and 16x16 sprite counts
	dw LogoDALPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoDALTiles					; its tiles
LogoDALSprite:						; the DAL logo
	dw LogoDALFrames,LogoDALFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$0B				; into the $04E2 run (loaded, not used)
	db 10,5,15						; the most 8x8, 16x16 and both sprites in a frame
	dw -23,32,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 5							; palette number (SpritePalettes)
	dw (LogoDALFramesEnd-LogoDALFrames)/2	; number of frames
	db $03							; not traced
LogoDALFrames:						; its frames
	dw LogoDALFrame
LogoDALFramesEnd:					; the animation script
	dw OneFrameScript
LogoDETFrame:						; 11 8x8 and 4 16x16 sprites, packed tiles (flags 3)
	db 11,4							; the 8x8 and 16x16 sprite counts
	dw LogoDETPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoDETTiles					; its tiles
LogoDETSprite:						; the DET logo
	dw LogoDETFrames,LogoDETFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$0D				; into the $04E2 run (loaded, not used)
	db 11,4,15						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 6							; palette number (SpritePalettes)
	dw (LogoDETFramesEnd-LogoDETFrames)/2	; number of frames
	db $03							; not traced
LogoDETFrames:						; its frames
	dw LogoDETFrame
LogoDETFramesEnd:					; the animation script
	dw OneFrameScript
LogoEDMFrame:						; 0 8x8 and 9 16x16 sprites, packed tiles (flags 2)
	db 0,9							; the 8x8 and 16x16 sprite counts
	dw LogoEDMPieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoEDMTiles					; its tiles
LogoEDMSprite:						; the EDM logo
	dw LogoEDMFrames,LogoEDMFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$0F				; into the $04E2 run (loaded, not used)
	db 0,9,9						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 7							; palette number (SpritePalettes)
	dw (LogoEDMFramesEnd-LogoEDMFrames)/2	; number of frames
	db $03							; not traced
LogoEDMFrames:						; its frames
	dw LogoEDMFrame
LogoEDMFramesEnd:					; the animation script
	dw OneFrameScript
LogoFLAFrame:						; 5 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 5,6							; the 8x8 and 16x16 sprite counts
	dw LogoFLAPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoFLATiles					; its tiles
LogoFLASprite:						; the FLA logo
	dw LogoFLAFrames,LogoFLAFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$11				; into the $04E2 run (loaded, not used)
	db 5,6,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 8							; palette number (SpritePalettes)
	dw (LogoFLAFramesEnd-LogoFLAFrames)/2	; number of frames
	db $03							; not traced
LogoFLAFrames:						; its frames
	dw LogoFLAFrame
LogoFLAFramesEnd:					; the animation script
	dw OneFrameScript
LogoHFDFrame:						; 0 8x8 and 9 16x16 sprites, packed tiles (flags 2)
	db 0,9							; the 8x8 and 16x16 sprite counts
	dw LogoHFDPieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoHFDTiles					; its tiles
LogoHFDSprite:						; the HFD logo
	dw LogoHFDFrames,LogoHFDFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$13				; into the $04E2 run (loaded, not used)
	db 0,9,9						; the most 8x8, 16x16 and both sprites in a frame
	dw -23,24,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 9							; palette number (SpritePalettes)
	dw (LogoHFDFramesEnd-LogoHFDFrames)/2	; number of frames
	db $03							; not traced
LogoHFDFrames:						; its frames
	dw LogoHFDFrame
LogoHFDFramesEnd:					; the animation script
	dw OneFrameScript
LogoLAFrame:						; 3 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 3,6							; the 8x8 and 16x16 sprite counts
	dw LogoLAPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoLATiles					; its tiles
LogoLASprite:						; the LA logo
	dw LogoLAFrames,LogoLAFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$15				; into the $04E2 run (loaded, not used)
	db 3,6,9						; the most 8x8, 16x16 and both sprites in a frame
	dw -25,30,-16,23				; x from, x to, y from, y to (a box: not traced)
	dw 10							; palette number (SpritePalettes)
	dw (LogoLAFramesEnd-LogoLAFrames)/2	; number of frames
	db $03							; not traced
LogoLAFrames:						; its frames
	dw LogoLAFrame
LogoLAFramesEnd:					; the animation script
	dw OneFrameScript
LogoMTLFrame:						; 4 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 4,6							; the 8x8 and 16x16 sprite counts
	dw LogoMTLPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoMTLTiles					; its tiles
LogoMTLSprite:						; the MTL logo
	dw LogoMTLFrames,LogoMTLFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$17				; into the $04E2 run (loaded, not used)
	db 4,6,10						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-20,19				; x from, x to, y from, y to (a box: not traced)
	dw 11							; palette number (SpritePalettes)
	dw (LogoMTLFramesEnd-LogoMTLFrames)/2	; number of frames
	db $03							; not traced
LogoMTLFrames:						; its frames
	dw LogoMTLFrame
LogoMTLFramesEnd:					; the animation script
	dw OneFrameScript
LogoNJFrame:						; 5 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 5,7							; the 8x8 and 16x16 sprite counts
	dw LogoNJPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoNJTiles					; its tiles
LogoNJSprite:						; the NJ logo
	dw LogoNJFrames,LogoNJFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$19				; into the $04E2 run (loaded, not used)
	db 5,7,12						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 12							; palette number (SpritePalettes)
	dw (LogoNJFramesEnd-LogoNJFrames)/2	; number of frames
	db $03							; not traced
LogoNJFrames:						; its frames
	dw LogoNJFrame
LogoNJFramesEnd:					; the animation script
	dw OneFrameScript
LogoNYIFrame:						; 4 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 4,8							; the 8x8 and 16x16 sprite counts
	dw LogoNYIPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoNYITiles					; its tiles
LogoNYISprite:						; the NYI logo
	dw LogoNYIFrames,LogoNYIFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$1B				; into the $04E2 run (loaded, not used)
	db 4,8,12						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-28,27				; x from, x to, y from, y to (a box: not traced)
	dw 13							; palette number (SpritePalettes)
	dw (LogoNYIFramesEnd-LogoNYIFrames)/2	; number of frames
	db $03							; not traced
LogoNYIFrames:						; its frames
	dw LogoNYIFrame
LogoNYIFramesEnd:					; the animation script
	dw OneFrameScript
LogoNYRFrame:						; 0 8x8 and 9 16x16 sprites, packed tiles (flags 2)
	db 0,9							; the 8x8 and 16x16 sprite counts
	dw LogoEDMPieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoNYRTiles					; its tiles
LogoNYRSprite:						; the NYR logo
	dw LogoNYRFrames,LogoNYRFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$1D				; into the $04E2 run (loaded, not used)
	db 0,9,9						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 14							; palette number (SpritePalettes)
	dw (LogoNYRFramesEnd-LogoNYRFrames)/2	; number of frames
	db $03							; not traced
LogoNYRFrames:						; its frames
	dw LogoNYRFrame
LogoNYRFramesEnd:					; the animation script
	dw OneFrameScript
LogoOTWFrame:						; 7 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 7,6							; the 8x8 and 16x16 sprite counts
	dw LogoOTWPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoOTWTiles					; its tiles
LogoOTWSprite:						; the OTW logo
	dw LogoOTWFrames,LogoOTWFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$1F				; into the $04E2 run (loaded, not used)
	db 7,6,13						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 15							; palette number (SpritePalettes)
	dw (LogoOTWFramesEnd-LogoOTWFrames)/2	; number of frames
	db $03							; not traced
LogoOTWFrames:						; its frames
	dw LogoOTWFrame
LogoOTWFramesEnd:					; the animation script
	dw OneFrameScript
LogoPHIFrame:						; 5 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 5,6							; the 8x8 and 16x16 sprite counts
	dw LogoPHIPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoPHITiles					; its tiles
LogoPHISprite:						; the PHI logo
	dw LogoPHIFrames,LogoPHIFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$21				; into the $04E2 run (loaded, not used)
	db 5,6,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-20,19				; x from, x to, y from, y to (a box: not traced)
	dw 16							; palette number (SpritePalettes)
	dw (LogoPHIFramesEnd-LogoPHIFrames)/2	; number of frames
	db $03							; not traced
LogoPHIFrames:						; its frames
	dw LogoPHIFrame
LogoPHIFramesEnd:					; the animation script
	dw OneFrameScript
LogoPITFrame:						; 6 8x8 and 5 16x16 sprites, packed tiles (flags 3)
	db 6,5							; the 8x8 and 16x16 sprite counts
	dw LogoPITPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoPITTiles					; its tiles
LogoPITSprite:						; the PIT logo
	dw LogoPITFrames,LogoPITFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$23				; into the $04E2 run (loaded, not used)
	db 6,5,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 17							; palette number (SpritePalettes)
	dw (LogoPITFramesEnd-LogoPITFrames)/2	; number of frames
	db $03							; not traced
LogoPITFrames:						; its frames
	dw LogoPITFrame
LogoPITFramesEnd:					; the animation script
	dw OneFrameScript
LogoQUEFrame:						; 6 8x8 and 5 16x16 sprites, packed tiles (flags 3)
	db 6,5							; the 8x8 and 16x16 sprite counts
	dw LogoQUEPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoQUETiles					; its tiles
LogoQUESprite:						; the QUE logo
	dw LogoQUEFrames,LogoQUEFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$25				; into the $04E2 run (loaded, not used)
	db 6,5,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-20,19				; x from, x to, y from, y to (a box: not traced)
	dw 18							; palette number (SpritePalettes)
	dw (LogoQUEFramesEnd-LogoQUEFrames)/2	; number of frames
	db $03							; not traced
LogoQUEFrames:						; its frames
	dw LogoQUEFrame
LogoQUEFramesEnd:					; the animation script
	dw OneFrameScript
LogoSJFrame:						; 6 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 6,6							; the 8x8 and 16x16 sprite counts
	dw LogoSJPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoSJTiles					; its tiles
LogoSJSprite:						; the SJ logo
	dw LogoSJFrames,LogoSJFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$27				; into the $04E2 run (loaded, not used)
	db 6,6,12						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 19							; palette number (SpritePalettes)
	dw (LogoSJFramesEnd-LogoSJFrames)/2	; number of frames
	db $03							; not traced
LogoSJFrames:						; its frames
	dw LogoSJFrame
LogoSJFramesEnd:					; the animation script
	dw OneFrameScript
LogoSTLFrame:						; 3 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 3,6							; the 8x8 and 16x16 sprite counts
	dw LogoSTLPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoSTLTiles					; its tiles
LogoSTLSprite:						; the STL logo
	dw LogoSTLFrames,LogoSTLFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$29				; into the $04E2 run (loaded, not used)
	db 3,6,9						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 20							; palette number (SpritePalettes)
	dw (LogoSTLFramesEnd-LogoSTLFrames)/2	; number of frames
	db $03							; not traced
LogoSTLFrames:						; its frames
	dw LogoSTLFrame
LogoSTLFramesEnd:					; the animation script
	dw OneFrameScript
LogoTBFrame:						; 4 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 4,7							; the 8x8 and 16x16 sprite counts
	dw LogoTBPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoTBTiles					; its tiles
LogoTBSprite:						; the TB logo
	dw LogoTBFrames,LogoTBFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$2B				; into the $04E2 run (loaded, not used)
	db 4,7,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 21							; palette number (SpritePalettes)
	dw (LogoTBFramesEnd-LogoTBFrames)/2	; number of frames
	db $03							; not traced
LogoTBFrames:						; its frames
	dw LogoTBFrame
LogoTBFramesEnd:					; the animation script
	dw OneFrameScript
LogoTORFrame:						; 5 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 5,7							; the 8x8 and 16x16 sprite counts
	dw LogoTORPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoTORTiles					; its tiles
LogoTORSprite:						; the TOR logo
	dw LogoTORFrames,LogoTORFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$2D				; into the $04E2 run (loaded, not used)
	db 5,7,12						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 22							; palette number (SpritePalettes)
	dw (LogoTORFramesEnd-LogoTORFrames)/2	; number of frames
	db $03							; not traced
LogoTORFrames:						; its frames
	dw LogoTORFrame
LogoTORFramesEnd:					; the animation script
	dw OneFrameScript
LogoVANFrame:						; 6 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 6,7							; the 8x8 and 16x16 sprite counts
	dw LogoVANPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoVANTiles					; its tiles
LogoVANSprite:						; the VAN logo
	dw LogoVANFrames,LogoVANFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$2F				; into the $04E2 run (loaded, not used)
	db 6,7,13						; the most 8x8, 16x16 and both sprites in a frame
	dw -28,27,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 23							; palette number (SpritePalettes)
	dw (LogoVANFramesEnd-LogoVANFrames)/2	; number of frames
	db $03							; not traced
LogoVANFrames:						; its frames
	dw LogoVANFrame
LogoVANFramesEnd:					; the animation script
	dw OneFrameScript
LogoWSHFrame:						; 5 8x8 and 4 16x16 sprites, packed tiles (flags 3)
	db 5,4							; the 8x8 and 16x16 sprite counts
	dw LogoWSHPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoWSHTiles					; its tiles
LogoWSHSprite:						; the WSH logo
	dw LogoWSHFrames,LogoWSHFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$31				; into the $04E2 run (loaded, not used)
	db 5,4,9						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-20,19				; x from, x to, y from, y to (a box: not traced)
	dw 24							; palette number (SpritePalettes)
	dw (LogoWSHFramesEnd-LogoWSHFrames)/2	; number of frames
	db $03							; not traced
LogoWSHFrames:						; its frames
	dw LogoWSHFrame
LogoWSHFramesEnd:					; the animation script
	dw OneFrameScript
LogoWPGFrame:						; 4 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 4,7							; the 8x8 and 16x16 sprite counts
	dw LogoWPGPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoWPGTiles					; its tiles
LogoWPGSprite:						; the WPG logo
	dw LogoWPGFrames,LogoWPGFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$33				; into the $04E2 run (loaded, not used)
	db 4,7,11						; the most 8x8, 16x16 and both sprites in a frame
	dw -24,23,-24,23				; x from, x to, y from, y to (a box: not traced)
	dw 25							; palette number (SpritePalettes)
	dw (LogoWPGFramesEnd-LogoWPGFrames)/2	; number of frames
	db $03							; not traced
LogoWPGFrames:						; its frames
	dw LogoWPGFrame
LogoWPGFramesEnd:					; the animation script
	dw OneFrameScript
LogoASEFrame:						; 7 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 7,8							; the 8x8 and 16x16 sprite counts
	dw LogoASEPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoASETiles					; its tiles
LogoASESprite:						; the Eastern all-star logo
	dw LogoASEFrames,LogoASEFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$35				; into the $04E2 run (loaded, not used)
	db 7,8,15						; the most 8x8, 16x16 and both sprites in a frame
	dw -25,30,-20,27				; x from, x to, y from, y to (a box: not traced)
	dw 26							; palette number (SpritePalettes)
	dw (LogoASEFramesEnd-LogoASEFrames)/2	; number of frames
	db $03							; not traced
LogoASEFrames:						; its frames
	dw LogoASEFrame
LogoASEFramesEnd:					; the animation script
	dw OneFrameScript
LogoASWFrame:						; 7 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 7,8							; the 8x8 and 16x16 sprite counts
	dw LogoASEPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl LogoASWTiles					; its tiles
LogoASWSprite:						; the Western all-star logo
	dw LogoASWFrames,LogoASWFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$37				; into the $04E2 run (loaded, not used)
	db 7,8,15						; the most 8x8, 16x16 and both sprites in a frame
	dw -25,30,-20,27				; x from, x to, y from, y to (a box: not traced)
	dw 27							; palette number (SpritePalettes)
	dw (LogoASWFramesEnd-LogoASWFrames)/2	; number of frames
	db $03							; not traced
LogoASWFrames:						; its frames
	dw LogoASWFrame
LogoASWFramesEnd:					; the animation script
	dw OneFrameScript
Sprite28Frame00:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces00-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles00				; its tiles
Sprite28Frame01:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces01-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles01				; its tiles
Sprite28Frame02:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces02-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles02				; its tiles
Sprite28Frame03:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces02-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles03				; its tiles
Sprite28Frame04:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces02-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles04				; its tiles
Sprite28Frame05:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces05-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles05				; its tiles
Sprite28Frame06:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces05-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles06				; its tiles
Sprite28Frame07:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces07-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles07				; its tiles
Sprite28Frame08:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces08-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles08				; its tiles
Sprite28Frame09:					; 2 8x8 and 0 16x16 sprites, packed tiles
	db 2,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces09-SpritePieces	; its pieces
	db 1							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles09				; its tiles
Sprite28Frame10:					; 2 8x8 and 0 16x16 sprites, packed tiles
	db 2,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces10-SpritePieces	; its pieces
	db 1							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles10				; its tiles
Sprite28Frame11:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces07-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles11				; its tiles
Sprite28Frame12:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces05-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles12				; its tiles
Sprite28Frame13:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces02-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles13				; its tiles
Sprite28Frame14:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles14				; its tiles
Sprite28Frame15:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles15				; its tiles
Sprite28Frame16:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles16				; its tiles
Sprite28Frame17:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces17-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles17				; its tiles
Sprite28Frame18:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces17-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles18				; its tiles
Sprite28Frame19:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces19-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles19				; its tiles
Sprite28Frame20:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces20-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles20				; its tiles
Sprite28Frame21:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces19-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles21				; its tiles
Sprite28Frame22:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces17-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles22				; its tiles
Sprite28Frame23:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces17-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles23				; its tiles
Sprite28Frame24:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles24				; its tiles
Sprite28Frame25:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces17-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles25				; its tiles
Sprite28Frame26:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles26				; its tiles
Sprite28Frame27:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles27				; its tiles
Sprite28Frame28:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles28				; its tiles
Sprite28Frame29:					; 1 8x8 and 0 16x16 sprites, raw tiles
	db 1,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces14-SpritePieces	; its pieces
	db 0							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles29				; its tiles
Sprite28Frame30:					; 2 8x8 and 0 16x16 sprites, packed tiles
	db 2,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces30-SpritePieces	; its pieces
	db 1							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles30				; its tiles
Sprite28Frame31:					; 2 8x8 and 0 16x16 sprites, packed tiles
	db 2,0							; the 8x8 and 16x16 sprite counts
	dw Sprite28Pieces30-SpritePieces	; its pieces
	db 1							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl Sprite28Tiles31				; its tiles
Sprite28Sprite:						; sprite 28 (an arrow, then a spinning disc)
	dw Sprite28Frames,Sprite28FramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$39				; into the $04E2 run (loaded, not used)
	db 2,1,2						; the most 8x8, 16x16 and both sprites in a frame
	dw -7,10,-15,15					; x from, x to, y from, y to (a box: not traced)
	dw 28							; palette number (SpritePalettes)
	dw (Sprite28FramesEnd-Sprite28Frames)/2	; number of frames
	db $03							; not traced
Sprite28Frames:						; its frames
	dw Sprite28Frame00,Sprite28Frame01,Sprite28Frame02,Sprite28Frame03
	dw Sprite28Frame04,Sprite28Frame05,Sprite28Frame06,Sprite28Frame07
	dw Sprite28Frame08,Sprite28Frame09,Sprite28Frame10,Sprite28Frame11
	dw Sprite28Frame12,Sprite28Frame13,Sprite28Frame14,Sprite28Frame15
	dw Sprite28Frame16,Sprite28Frame17,Sprite28Frame18,Sprite28Frame19
	dw Sprite28Frame20,Sprite28Frame21,Sprite28Frame22,Sprite28Frame23
	dw Sprite28Frame24,Sprite28Frame25,Sprite28Frame26,Sprite28Frame27
	dw Sprite28Frame28,Sprite28Frame29,Sprite28Frame30,Sprite28Frame31
Sprite28FramesEnd:					; the animation script
	dw SpriteScript_C0853E
	dw OneFrameScript,SpriteScript_C08551,SpriteScript_C08553,SpriteScript_C08563,SpriteScript_C08565	; more script pointers (not traced)
SpriteScript_C0853E:				; animation script: frame numbers, and commands (bit 7 set)
	db $02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$8B,$05,$04,$03,$02,$8B,$0D,$81
SpriteScript_C08551:				; animation script: frame numbers, and commands (bit 7 set)
	db $01,$80
SpriteScript_C08553:				; animation script: frame numbers, and commands (bit 7 set)
	db $0E,$0F,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1C,$1D,$81
SpriteScript_C08563:				; animation script: frame numbers, and commands (bit 7 set)
	db $1E,$80
SpriteScript_C08565:				; animation script: frame numbers, and commands (bit 7 set)
	db $1F,$80
PadNumbersFrame00:					; 0 8x8 and 2 16x16 sprites, packed tiles (flags 2)
	db 0,2							; the 8x8 and 16x16 sprite counts
	dw PadNumbersPieces00-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl PadNumbersTiles00			; its tiles
PadNumbersFrame01:					; 3 8x8 and 0 16x16 sprites, packed tiles
	db 3,0							; the 8x8 and 16x16 sprite counts
	dw PadNumbersPieces01-SpritePieces	; its pieces
	db 1							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl PadNumbersTiles01			; its tiles
PadNumbersFrame02:					; 1 8x8 and 1 16x16 sprites, packed tiles (flags 3)
	db 1,1							; the 8x8 and 16x16 sprite counts
	dw PadNumbersPieces02-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl PadNumbersTiles02			; its tiles
PadNumbersFrame03:					; 2 8x8 and 1 16x16 sprites, packed tiles (flags 3)
	db 2,1							; the 8x8 and 16x16 sprite counts
	dw PadNumbersPieces03-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl PadNumbersTiles03			; its tiles
PadNumbersFrame04:					; 0 8x8 and 1 16x16 sprites, packed tiles (flags 2)
	db 0,1							; the 8x8 and 16x16 sprite counts
	dw PadNumbersPieces04-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl PadNumbersTiles04			; its tiles
PadNumbersFrame05:					; 1 8x8 and 1 16x16 sprites, packed tiles (flags 3)
	db 1,1							; the 8x8 and 16x16 sprite counts
	dw PadNumbersPieces02-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl PadNumbersTiles05			; its tiles
PadNumbersSprite:					; a controller, then the numbers 1 to 5
	dw PadNumbersFrames,PadNumbersFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$3B				; into the $04E2 run (loaded, not used)
	db 3,2,3						; the most 8x8, 16x16 and both sprites in a frame
	dw -15,16,-11,13				; x from, x to, y from, y to (a box: not traced)
	dw 29							; palette number (SpritePalettes)
	dw (PadNumbersFramesEnd-PadNumbersFrames)/2	; number of frames
	db $03							; not traced
PadNumbersFrames:					; its frames
	dw PadNumbersFrame00,PadNumbersFrame01,PadNumbersFrame02,PadNumbersFrame03
	dw PadNumbersFrame04,PadNumbersFrame05
PadNumbersFramesEnd:				; the animation script
	dw SpriteScript_C085C4
	dw SpriteScript_C085C9,SpriteScript_C085CE,SpriteScript_C085D3,SpriteScript_C085D8	; more script pointers (not traced)
SpriteScript_C085C4:				; animation script: frame numbers, and commands (bit 7 set)
	db $87,$02,$00,$01,$80
SpriteScript_C085C9:				; animation script: frame numbers, and commands (bit 7 set)
	db $87,$02,$00,$02,$80
SpriteScript_C085CE:				; animation script: frame numbers, and commands (bit 7 set)
	db $87,$02,$00,$03,$80
SpriteScript_C085D3:				; animation script: frame numbers, and commands (bit 7 set)
	db $87,$02,$00,$04,$80
SpriteScript_C085D8:				; animation script: frame numbers, and commands (bit 7 set)
	db $87,$02,$00,$05,$80
SkaterFrame00:						; 7 8x8 and 6 16x16 sprites, packed tiles (flags 3)
	db 7,6							; the 8x8 and 16x16 sprite counts
	dw SkaterPieces00-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl SkaterTiles00				; its tiles
SkaterFrame01:						; 6 8x8 and 8 16x16 sprites, packed tiles (flags 3)
	db 6,8							; the 8x8 and 16x16 sprite counts
	dw SkaterPieces01-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl SkaterTiles01				; its tiles
SkaterFrame02:						; 10 8x8 and 5 16x16 sprites, packed tiles (flags 3)
	db 10,5							; the 8x8 and 16x16 sprite counts
	dw SkaterPieces02-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl SkaterTiles02				; its tiles
SkaterFrame03:						; 11 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 11,7							; the 8x8 and 16x16 sprite counts
	dw SkaterPieces03-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl SkaterTiles03				; its tiles
SkaterFrame04:						; 6 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 6,7							; the 8x8 and 16x16 sprite counts
	dw SkaterPieces04-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl SkaterTiles04				; its tiles
SkaterFrame05:						; 5 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 5,7							; the 8x8 and 16x16 sprite counts
	dw SkaterPieces05-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl SkaterTiles05				; its tiles
SkaterSprite:						; a skating player
	dw SkaterFrames,SkaterFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$3D				; into the $04E2 run (loaded, not used)
	db 11,8,18						; the most 8x8, 16x16 and both sprites in a frame
	dw 0,63,-61,7					; x from, x to, y from, y to (a box: not traced)
	dw 30							; palette number (SpritePalettes)
	dw (SkaterFramesEnd-SkaterFrames)/2	; number of frames
	db $03							; not traced
SkaterFrames:						; its frames
	dw SkaterFrame00,SkaterFrame01,SkaterFrame02,SkaterFrame03
	dw SkaterFrame04,SkaterFrame05
SkaterFramesEnd:					; the animation script
	dw SpriteScript_C08634
	dw SpriteScript_C0863B			; more script pointers (not traced)
SpriteScript_C08634:				; animation script: frame numbers, and commands (bit 7 set)
	db $86,$60,$00,$00,$01,$02,$80
SpriteScript_C0863B:				; animation script: frame numbers, and commands (bit 7 set)
	db $86,$60,$00,$03,$04,$05,$80
RedDotFrame:						; 2 8x8 and 0 16x16 sprites, packed tiles
	db 2,0							; the 8x8 and 16x16 sprite counts
	dw RedDotPieces-SpritePieces	; its pieces
	db 1							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl RedDotTiles					; its tiles
RedDotSprite:						; a small red dot
	dw RedDotFrames,RedDotFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$3F				; into the $04E2 run (loaded, not used)
	db 2,0,2						; the most 8x8, 16x16 and both sprites in a frame
	dw -2,13,0,7					; x from, x to, y from, y to (a box: not traced)
	dw 31							; palette number (SpritePalettes)
	dw (RedDotFramesEnd-RedDotFrames)/2	; number of frames
	db $03							; not traced
RedDotFrames:						; its frames
	dw RedDotFrame
RedDotFramesEnd:					; the animation script
	dw OneFrameScript
EASportsFrame:						; 4 8x8 and 2 16x16 sprites, packed tiles (flags 3)
	db 4,2							; the 8x8 and 16x16 sprite counts
	dw EASportsPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl EASportsTiles				; its tiles
EASportsSprite:						; the EA SPORTS logo
	dw EASportsFrames,EASportsFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$41				; into the $04E2 run (loaded, not used)
	db 4,2,6						; the most 8x8, 16x16 and both sprites in a frame
	dw -15,16,-11,12				; x from, x to, y from, y to (a box: not traced)
	dw 32							; palette number (SpritePalettes)
	dw (EASportsFramesEnd-EASportsFrames)/2	; number of frames
	db $03							; not traced
EASportsFrames:						; its frames
	dw EASportsFrame
EASportsFramesEnd:					; the animation script
	dw OneFrameScript
EALogoEFrame:						; 0 8x8 and 24 16x16 sprites, packed tiles (flags 2)
	db 0,24							; the 8x8 and 16x16 sprite counts
	dw EALogoEPieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl EALogoETiles					; its tiles
EALogoESprite:						; the big E of the EA logo
	dw EALogoEFrames,EALogoEFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$43				; into the $04E2 run (loaded, not used)
	db 0,24,24						; the most 8x8, 16x16 and both sprites in a frame
	dw -44,51,-38,41				; x from, x to, y from, y to (a box: not traced)
	dw 33							; palette number (SpritePalettes)
	dw (EALogoEFramesEnd-EALogoEFrames)/2	; number of frames
	db $02							; not traced
EALogoEFrames:						; its frames
	dw EALogoEFrame
EALogoEFramesEnd:					; the animation script
	dw OneFrameScript
EALogoAFrame:						; 0 8x8 and 19 16x16 sprites, packed tiles (flags 2)
	db 0,19							; the 8x8 and 16x16 sprite counts
	dw EALogoAPieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl EALogoATiles					; its tiles
EALogoASprite:						; the big A of the EA logo
	dw EALogoAFrames,EALogoAFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$45				; into the $04E2 run (loaded, not used)
	db 0,19,19						; the most 8x8, 16x16 and both sprites in a frame
	dw -40,47,-38,41				; x from, x to, y from, y to (a box: not traced)
	dw 33							; palette number (SpritePalettes)
	dw (EALogoAFramesEnd-EALogoAFrames)/2	; number of frames
	db $02							; not traced
EALogoAFrames:						; its frames
	dw EALogoAFrame
EALogoAFramesEnd:					; the animation script
	dw OneFrameScript
SportsWordFrame:					; 0 8x8 and 19 16x16 sprites, packed tiles (flags 2)
	db 0,19							; the 8x8 and 16x16 sprite counts
	dw SportsWordPieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl SportsWordTiles				; its tiles
SportsWordSprite:					; part of the word SPORTS
	dw SportsWordFrames,SportsWordFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$47				; into the $04E2 run (loaded, not used)
	db 0,19,19						; the most 8x8, 16x16 and both sprites in a frame
	dw -75,84,-13,18				; x from, x to, y from, y to (a box: not traced)
	dw 34							; palette number (SpritePalettes)
	dw (SportsWordFramesEnd-SportsWordFrames)/2	; number of frames
	db $02							; not traced
SportsWordFrames:					; its frames
	dw SportsWordFrame
SportsWordFramesEnd:				; the animation script
	dw OneFrameScript
ElectronicWordFrame:				; 0 8x8 and 9 16x16 sprites, packed tiles (flags 2)
	db 0,9							; the 8x8 and 16x16 sprite counts
	dw ElectronicWordPieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl ElectronicWordTiles			; its tiles
ElectronicWordSprite:				; part of the words ELECTRONIC ARTS
	dw ElectronicWordFrames,ElectronicWordFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$49				; into the $04E2 run (loaded, not used)
	db 0,9,9						; the most 8x8, 16x16 and both sprites in a frame
	dw -72,71,-5,10					; x from, x to, y from, y to (a box: not traced)
	dw 34							; palette number (SpritePalettes)
	dw (ElectronicWordFramesEnd-ElectronicWordFrames)/2	; number of frames
	db $02							; not traced
ElectronicWordFrames:				; its frames
	dw ElectronicWordFrame
ElectronicWordFramesEnd:			; the animation script
	dw OneFrameScript
ItsInTheFrame:						; 0 8x8 and 7 16x16 sprites, packed tiles (flags 2)
	db 0,7							; the 8x8 and 16x16 sprite counts
	dw ItsInThePieces-SpritePieces	; its pieces
	db 2							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl ItsInTheTiles				; its tiles
ItsInTheSprite:						; the words It's in the
	dw ItsInTheFrames,ItsInTheFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$4B				; into the $04E2 run (loaded, not used)
	db 0,7,7						; the most 8x8, 16x16 and both sprites in a frame
	dw -52,59,-8,7					; x from, x to, y from, y to (a box: not traced)
	dw 35							; palette number (SpritePalettes)
	dw (ItsInTheFramesEnd-ItsInTheFrames)/2	; number of frames
	db $03							; not traced
ItsInTheFrames:						; its frames
	dw ItsInTheFrame
ItsInTheFramesEnd:					; the animation script
	dw OneFrameScript
BlackBoxFrame:						; 1 8x8 and 15 16x16 sprites, packed tiles (flags 3)
	db 1,15							; the 8x8 and 16x16 sprite counts
	dw BlackBoxPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl BlackBoxTiles				; its tiles
BlackBoxSprite:						; a black box with a white frame
	dw BlackBoxFrames,BlackBoxFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$4D				; into the $04E2 run (loaded, not used)
	db 1,15,16						; the most 8x8, 16x16 and both sprites in a frame
	dw -3,60,-3,60					; x from, x to, y from, y to (a box: not traced)
	dw 36							; palette number (SpritePalettes)
	dw (BlackBoxFramesEnd-BlackBoxFrames)/2	; number of frames
	db $03							; not traced
BlackBoxFrames:						; its frames
	dw BlackBoxFrame
BlackBoxFramesEnd:					; the animation script
	dw OneFrameScript
NHLShieldFrame:						; 5 8x8 and 7 16x16 sprites, packed tiles (flags 3)
	db 5,7							; the 8x8 and 16x16 sprite counts
	dw NHLShieldPieces-SpritePieces	; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl NHLShieldTiles				; its tiles
NHLShieldSprite:					; the NHL shield
	dw NHLShieldFrames,NHLShieldFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$4F				; into the $04E2 run (loaded, not used)
	db 5,7,12						; the most 8x8, 16x16 and both sprites in a frame
	dw 0,47,0,47					; x from, x to, y from, y to (a box: not traced)
	dw 37							; palette number (SpritePalettes)
	dw (NHLShieldFramesEnd-NHLShieldFrames)/2	; number of frames
	db $03							; not traced
NHLShieldFrames:					; its frames
	dw NHLShieldFrame
NHLShieldFramesEnd:					; the animation script
	dw OneFrameScript
NHLPAFrame:							; 10 8x8 and 4 16x16 sprites, packed tiles (flags 3)
	db 10,4							; the 8x8 and 16x16 sprite counts
	dw NHLPAPieces-SpritePieces		; its pieces
	db 3							; flags: bit 0 packed, bit 1 the 16x16 part packed
	dl NHLPATiles					; its tiles
NHLPASprite:						; the NHLPA logo
	dw NHLPAFrames,NHLPAFramesEnd	; the frame list and its end (the script pointer)
	dl DATA8_C104E0+$51				; into the $04E2 run (loaded, not used)
	db 10,4,14						; the most 8x8, 16x16 and both sprites in a frame
	dw 0,39,0,55					; x from, x to, y from, y to (a box: not traced)
	dw 38							; palette number (SpritePalettes)
	dw (NHLPAFramesEnd-NHLPAFrames)/2	; number of frames
	db $03							; not traced
NHLPAFrames:						; its frames
	dw NHLPAFrame
NHLPAFramesEnd:						; the animation script
	dw OneFrameScript
SpriteRecordList:					; the records, by sprite number (the team logos first, by team)
	dw LogoANHSprite,LogoBOSSprite,LogoBUFSprite,LogoCGYSprite
	dw LogoCHISprite,LogoDALSprite,LogoDETSprite,LogoEDMSprite
	dw LogoFLASprite,LogoHFDSprite,LogoLASprite,LogoMTLSprite
	dw LogoNJSprite,LogoNYISprite,LogoNYRSprite,LogoOTWSprite
	dw LogoPHISprite,LogoPITSprite,LogoQUESprite,LogoSJSprite
	dw LogoSTLSprite,LogoTBSprite,LogoTORSprite,LogoVANSprite
	dw LogoWSHSprite,LogoWPGSprite,LogoASESprite,LogoASWSprite
	dw Sprite28Sprite,PadNumbersSprite,SkaterSprite,RedDotSprite
	dw EASportsSprite,EALogoESprite,EALogoASprite,SportsWordSprite
	dw ElectronicWordSprite,ItsInTheSprite,BlackBoxSprite,NHLShieldSprite
	dw NHLPASprite
TiledBackMap:						; tilemap of a 16 x 3 block of tiles repeated over the screen, LZSS
									; packed; screen set-ups have the map unpacker send it to VRAM
	dw .end-.width					; bytes after this word
.width:								; map width in tiles
	db $20
	db $1C							; height in tiles
	db $8C							; flags: bit 7 LZSS packed
	dw $0700						; unpacked size in bytes, then the LZSS stream
	incbin "../Extracted/segments/bankC0_8000.bin":$7F9..$939
.end:								; the end of the set
DATA8_C08939:						; not traced: a set with the same length word (another format), then
									; 7 bytes
	incbin "../Extracted/segments/bankC0_8000.bin":$939..$B17
DATA8_C08B17:						; not traced: 16 colours, magenta then blues
	dw $7C1F,$7C00,$7800,$7400,$6C00,$7400,$6C00,$6800
	dw $6400,$6800,$6400,$6000,$5800,$7C1F,$7C1F,$7C1F
InitHooks:							; initial FrameHook, NMIHook, IRQHook (long pointers into the bank $80
									; mirror) and the random seed
	dl $800000|(NullHook&$FFFF),$800000|(NullHook&$FFFF),$800000|(IRQHook_Off&$FFFF)
	dw $AFE5,$F527
NullHook:							; an empty hook
	rtl
NMI_Fast:							; NMI: save the registers; just return while NMISkip is set
	rep #$30
	phd
	phb
	pea.w $8080						; data bank $80 (pulled twice)
	plb
	plb
	pha
	lda.w #$0000
	tcd
	lda.w RDNMI
	lda.b NMISkip
	beq .run
	pla
	plb
	pld
	rti
.run:								; NMISkip clear: set it, then the NMI hook
	inc a
	sta.b NMISkip
	phx
	phy
	sep #$10
	ldx.w NMIHookNext+1
	beq .1
	lda.w NMIHookNext
	sta.w NMIHook
	stz.w NMIHookNext
	ldx.w NMIHookNext+2
	stx.w NMIHook+2
.1:									; call [NMIHook]; its rtl lands on NMI_HookReturn
	ldx.b #NMI_HookReturn>>16
	phx
	pea.w NMI_HookReturn-1
	jml.w [NMIHook]
NMI_HookReturn:						; NMI after the hook: IRQ timers, BG scroll, queued transfers, DMA enables
	rep #$30
	lda.w IRQVTime
	sta.l VTIMEL
	lda.w IRQHTime
	sta.l HTIMEL
	sep #$30
	lda.w BG1HScroll
	sta.w BG1HOFS
	lda.w BG1HScroll+1
	sta.w BG1HOFS
	lda.w BG1VScroll
	sta.w BG1VOFS
	lda.w BG1VScroll+1
	sta.w BG1VOFS
	lda.w BG2HScroll
	sta.w BG2HOFS
	lda.w BG2HScroll+1
	sta.w BG2HOFS
	lda.w BG2VScroll
	sta.w BG2VOFS
	lda.w BG2VScroll+1
	sta.w BG2VOFS
	lda.w BG3HScroll
	sta.w BG3HOFS
	lda.w BG3HScroll+1
	sta.w BG3HOFS
	lda.w BG3VScroll
	sta.w BG3VOFS
	lda.w BG3VScroll+1
	sta.w BG3VOFS
	lda.b #$80						; forced blank while the transfers run
	sta.w INIDISP
	rep #$30
	lda.w TransfersReady
	beq .1
	bit.b QueueBusy
	bmi .1
	stz.w MDMAEN
	jsl.l CODE_C4C58B
	stz.w TransfersReady
.1:									; DMA and HDMA enables
	lda.w DMAEnShadow
	sta.w MDMAEN
NMI_Tick:							; Vcount + 1, the fade, FrameCount, then the frame hook
	clc
	lda.b Vcount
	adc.w #$0001
	sta.b Vcount
	bcc .1
	inc.b Vcount+2
.1:									; the fade
	lda.w fadestep
	bmi .fadeout
	dec a
	bmi .fadein
	sta.w fadestep
	sep #$20
	bra .write
.fadein:							; fadestep 0: brightness + 1 up to 15
	sep #$20
	lda.w brightness
	bpl .up
	lda.b #$FF
.up:								; up one step
	inc a
	cmp.b #$10
	bcs .write
	sta.w brightness
	bra .write
.fadeout:							; fadestep negative: brightness - 1 until negative
	sep #$20
	lda.w brightness
	bmi .write
	dec a
	sta.w brightness
.write:								; brightness to INIDISP
	lda.w brightness
	sta.w INIDISP
	rep #$20
	lda.w FrameCountHold
	bne .2
	inc.w FrameCount
.2:									; the frame hook: FrameHookNext to FrameHook
	sep #$10
	ldx.w FrameHookNext+1
	beq .3
	lda.w FrameHookNext
	sta.w FrameHook
	stz.w FrameHookNext
	ldx.w FrameHookNext+2
	stx.w FrameHook+2
.3:									; call [FrameHook]; its rtl lands on NMI_FrameHookReturn
	ldx.b #NMI_FrameHookReturn>>16
	phx
	pea.w NMI_FrameHookReturn-1
	jml.w [FrameHook]
NMI_FrameHookReturn:				; NMI after the frame hook: pads and sound, then restore and rti
	jsl.l $C36D3A
	rep #$30
	jsl.l $CF00FE
	stz.b NMISkip
	ply
	plx
	pla
	plb
	pld
	rti
BCDTable:							; 0 to 99 in BCD, by binary value
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09
	db $10,$11,$12,$13,$14,$15,$16,$17,$18,$19
	db $20,$21,$22,$23,$24,$25,$26,$27,$28,$29
	db $30,$31,$32,$33,$34,$35,$36,$37,$38,$39
	db $40,$41,$42,$43,$44,$45,$46,$47,$48,$49
	db $50,$51,$52,$53,$54,$55,$56,$57,$58,$59
	db $60,$61,$62,$63,$64,$65,$66,$67,$68,$69
	db $70,$71,$72,$73,$74,$75,$76,$77,$78,$79
	db $80,$81,$82,$83,$84,$85,$86,$87,$88,$89
	db $90,$91,$92,$93,$94,$95,$96,$97,$98,$99
IRQ:								; IRQ entry: jml IRQ_Fast (the IRQ vector points to RAM)
	jml.l IRQ_Fast
IRQ_Fast:							; IRQ: save the registers, acknowledge TIMEUP and run the IRQ hook
	rep #$30
	sei
	phb
	phk
	plb
	pha
	phx
	phy
	sep #$10
	ldx.w TIMEUP
	ldx.b #IRQ_HookReturn>>16
	phx
	pea.w IRQ_HookReturn-1
	jml.w [IRQHook]
IRQ_HookReturn:						; IRQ: restore the registers and rti (where the IRQ hooks return)
	rep #$30
	ply
	plx
	pla
	plb
	rti
IRQOff:								; turn the IRQ off, the NMI and pad reading on
	sei
	php
	pha
	sep #$20
	lda.b #$81
	sta.l NMITIMEN
	stz.w IRQHook+2
	rep #$20
	lda.w #IRQHook_Off
	sta.w IRQHook
	pla
	plp
	cli
	rtl
SetIRQ:								; turn on an IRQ at line Y with the routine at X:A
	php
	sei
	sep #$20
	pha
	lda.b #$81
	sta.l NMITIMEN
	pla
	rep #$20
	tya
	sty.w IRQVTime
	sta.l VTIMEL
	lda.w IRQHTime
	sta.l HTIMEL
	sep #$10
	stx.w IRQHook+2
	sta.w IRQHook
	jsl.l WaitFrame
	sep #$20
	lda.b #$B1
	sta.l NMITIMEN
	plp
	cli
IRQHook_Off:						; rtl; the IRQ hook when the raster IRQ is off
	rtl
ClearFrameHook:						; set the frame hook back to the empty routine
	pha
	phx
	ldx.w #NullHook>>16
	lda.w #NullHook
	jsl.l SetFrameHook
	plx
	pla
	rtl
SetFrameHook:						; run the routine at X:A as the frame hook from the next NMI
	sep #$10
	stx.w FrameHookNext+2
	sta.w FrameHookNext
	rep #$10
	rtl
ClearNMIHook:						; set the NMI hook back to the empty routine
	pha
	phx
	ldx.w #NullHook>>16
	lda.w #NullHook
	jsl.l SetNMIHook
	plx
	pla
	rtl
SetNMIHook:							; run the routine at X:A as the NMI hook from the next NMI
	sep #$10
	stx.w NMIHookNext+2
	sta.w NMIHookNext
	rep #$10
	rtl
WaitFrame:							; wait for the next frame (FrameCount changes)
	pha
	lda.w FrameCount
.loop:								; until FrameCount changes
	cmp.w FrameCount
	beq .loop
	pla
	rtl
WaitFrames_Inc:						; WaitFrames with Y + 1 first
	iny
WaitFrames:							; wait X frames, Y counting the rounds of 65536
	wai
	dex
	bne WaitFrames
	dey
	bne WaitFrames
	rtl
WaitDMAQueue:						; wait until the DMA queue is empty (DMAQueueHead = DMAQueueTail)
	pha
.loop:								; until the queue is empty
	lda.b DMAQueueHead
	cmp.b DMAQueueTail
	bne .loop
	pla
	rtl
.t1:								; wait up to X+Y*65536 frames for a button on pad 1
	iny
.1:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1x
	dey
	bne .t1x
	lda.w #$0000
	rtl
.t1x:								; a button held: return it
	lda.b PadRaw1
	beq .1
	rtl
.t2:								; the same for pad 2
	iny
.2:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1xx
	dey
	bne .t1xx
	lda.w #$0000
	rtl
.t1xx:								; a button held: return it
	lda.b PadRaw2
	beq .2
	rtl
.t2x:								; wait for one of the buttons in A on pad 1
	sta.b r3
	iny
.3:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1xxx
	dey
	bne .t1xxx
	lda.w #$0000
	rtl
.t1xxx:								; one of them held: return them
	lda.b PadRaw1
	and.b r3
	beq .3
	rtl
.t2xx:								; the same for pad 2
	sta.b r3
	iny
.4:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1xxxx
	dey
	bne .t1xxxx
	lda.w #$0000
	rtl
.t1xxxx:							; one of them held: return them
	lda.b PadRaw2
	and.b r3
	beq .4
	rtl
WaitNoButtons:						; wait until no button is held on pad 1
	pha
.loop:								; until no button (the d-pad bits ignored)
	lda.b PadRaw1
	and.w #$FFF0
	bne .loop
	pla
	rtl
.t1:								; the same for pad 2
	pha
.loopx:								; until no button
	lda.b PadRaw2
	and.w #$FFF0
	bne .loopx
	pla
	rtl
.t2:								; wait up to X frames for no button on pad 1
	pha
.loopx2:							; next frame
	jsl.l WaitFrame
	lda.b PadRaw1
	and.w #$FFF0
	beq .1
	dex
	bne .loopx2
.1:									; return
	pla
	rtl
.t1x:								; the same for pad 2
	pha
.loopxx:							; next frame
	jsl.l WaitFrame
	lda.b PadRaw2
	and.w #$FFF0
	beq .1x
	dex
	bne .loopxx
.1x:								; return
	pla
	rtl
JoyDirIndex_Hi:						; JoyDirIndex of the high byte of A
	xba
JoyDirIndex:						; X = 2 * JoyDirTable[the d-pad bits A & $F]
	and.w #$000F
	tax
	lda.l JoyDirTable,x
	and.w #$00FF
	asl a
	tax
	rtl
JoyDirTable:						; direction index for each d-pad bit pattern (8 = none)
	db $08,$02,$06,$08,$04,$03,$05,$08,$00,$01,$07,$08,$08,$08,$08,$08
RandomWord:							; A = a random word: the sum of two 16-bit shift-register generators
	lda.w seed
	beq .3
	asl a
	bcc .1
	eor.w #$1D87
.1:									; the first generator
	sta.w seed
	lda.w seed+2
	beq .4
	asl a
	bcc .2
	eor.w #$1D87
.2:									; the second generator, then the sum
	sta.w seed+2
	clc
	adc.w seed
	rtl
.3:									; seed 0: start it
	lda.w #$A5A5
	bra .1
.4:									; seed+2 0: start it
	lda.w #$B4B4
	bra .2
.t1:								; rtl
	rtl
BlankScreen:						; wait a frame, the default hooks, IRQ off, fade out, HDMA off
	jsl.l WaitFrame
	jsl.l IRQOff
	jsl.l ClearFrameHook
	jsl.l ClearNMIHook
	lda.w #$FFFF
	sta.w fadestep
	stz.w DMAEnShadow
.loop:								; until the fade is out
	lda.w brightness-1
	bpl .loop
	rtl
forceblack:							; BlankScreen, then ResetPPURegs
	jsl.l BlankScreen
	bra ResetPPURegs
ScreenOn:							; fade the screen in (fadestep 0)
	stz.w fadestep
	rtl
ResetPPURegs:						; reset the scroll copies and the window and colour math registers
	pha
	stz.w BG1HScroll
	stz.w BG2HScroll
	stz.w BG3HScroll
	lda.w #$FFFF
	sta.w BG1VScroll
	sta.w BG2VScroll
	sta.w BG3VScroll
	phd
	lda.w #INIDISP					; direct page on the PPU registers
	tcd
	sep #$20
	stz.b CGADSUB&$FF
	stz.b CGWSEL&$FF
	stz.b TMW&$FF
	stz.b MOSAIC&$FF
	stz.b SETINI&$FF
	stz.b TS&$FF
	stz.b TSW&$FF
	stz.b W12SEL&$FF
	stz.b W34SEL&$FF
	stz.b WOBJSEL&$FF
	stz.b $C8						; no PPU register here (as the game has it)
	lda.b #$E0
	sta.b COLDATA&$FF
	rep #$20
	pld
	pla
	rtl
Mul8U:								; A * X, 8 by 8 bits, unsigned, into A
	sep #$20
	sta.l WRMPYA
	txa
	sta.l WRMPYB
	rep #$20
	nop
	lda.l RDMPYL
	rtl
Mul8XS:								; A * X, 8 by 8 bits, X signed, into A
	cpx.w #$0000
	bpl Mul8U
	sep #$21
	sta.l WRMPYA
	txa
	eor.b #$FF
	inc a
	sta.l WRMPYB
	rep #$20
	lda.w #$0000
	sbc.l RDMPYL
	rtl
Mul8S:								; A * X, 8 by 8 bits, both signed, into A
	phy
	tay
	bpl .xsigned
	txa
	bpl .neg
	eor.w #$FFFF
	inc a
	sta.l WRMPYA
	tya
	eor.w #$FFFF
	inc a
	sta.l WRMPYB
	nop
	nop
	lda.l RDMPYL
	ply
	rtl
.xsigned:							; A positive: X decides
	cpx.w #$0000
	bpl .pos
.neg:								; one operand negative: negate the product
	sep #$21
	sta.l WRMPYA
	tya
	eor.b #$FF
	inc a
	sta.l WRMPYB
	rep #$20
	lda.w #$0000
	sbc.l RDMPYL
	ply
	rtl
.pos:								; both positive
	sep #$20
	sta.l WRMPYA
	txa
	sta.l WRMPYB
	rep #$20
	nop
	lda.l RDMPYL
	ply
	rtl
Mul16x8U_Pre:						; Mul16x8U from its second step, with Y saved
	phy
	bra Mul16x8U_go
Mul16x8U:							; X (16 bits) * A (8 bits) into r2, unsigned
	phy
	tay
	beq Mul16x8_Zero
	txa
	beq Mul16x8_Zero
Mul16x8U_go:						; entry used by the routines after it
	stz.b r2+2
	sep #$20
	sta.l WRMPYA
	tya
	sta.l WRMPYB
	xba
	sta.l WRMPYA
	rep #$21
	lda.l RDMPYL
	sta.b r2
	tax
	tya
	sta.l WRMPYB
	lda.b r2+1
	adc.l RDMPYL
	sta.b r2+1
	ply
	rtl
Mul16x8_Zero:						; product 0 into r2
	stz.b r2
	stz.b r2+2
	ply
	rtl
Mul16x8XS:							; X (16 bits) * A (8 bits) into r2, X signed
	phy
	tay
	beq Mul16x8_Zero
Mul16x8XS_neg:						; entry used by the routines after it
	txa
	beq Mul16x8_Zero
	bpl Mul16x8U_go
	eor.w #$FFFF
	inc a
Mul16x8XS_mul:						; entry used by the routines after it
	jsl.l Mul16x8U_Pre
Mul16x8XS_negres:					; entry used by the routines after it
	lda.w #$0000
	sec
	sbc.b r2
	sta.b r2
	lda.w #$0000
	sbc.b r2+2
	sta.b r2+2
	ply
	rtl
Mul16x8S:							; X (16 bits) * A (8 bits) into r2, both signed
	phy
	tay
	beq Mul16x8_Zero
	bpl Mul16x8XS_neg
	eor.w #$FFFF
	inc a
	tay
	txa
	beq Mul16x8_Zero
	bpl Mul16x8XS_mul
	eor.w #$FFFF
	inc a
	jmp.w Mul16x8U_go
Mul16x8HiU_Pre:						; Mul16x8HiU from its second step, with Y saved
	phy
	bra Mul16x8HiU_Go
Mul16x8HiU:							; X * A (low byte) / 256 into r2+1, unsigned
	phy
	tay
	beq Mul16x8Hi_Zero
	txa
	beq Mul16x8Hi_Zero
Mul16x8HiU_Go:						; entry used by the routines after it
	sep #$20
	sta.l WRMPYA
	tya
	sta.l WRMPYB
	stz.b r2+2
	xba
	sta.l WRMPYA
	lda.l RDMPYH
	sta.b r2+1
	tya
	sta.l WRMPYB
	rep #$21
	lda.b r2+1
	adc.l RDMPYL
	sta.b r2+1
	ply
	rtl
Mul16x8Hi_Zero:						; the zero result of the Mul16x8Hi forms: r2+1 = 0, pull Y
	stz.b r2+1
	ply
	rtl
