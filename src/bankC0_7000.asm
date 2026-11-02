; Segment bankC0_7000: the songs of each team and the default songs, from which the sound code builds a
; list of songs to load, then a list of sounds one screen loads, then fill to the end of the bank's lower
; half.
org $C07ECB
TeamSongs:							; song numbers, six per team in team order (Anaheim first), $FF for
									; none: read with the home team; each $FF becomes a DefaultSongs pick
	db $80,$8B,$95,$8C,$92,$A0
	db $9D,$8E,$8C,$FF,$92,$9D
	db $81,$80,$80,$81,$92,$FF
	db $82,$83,$82,$83,$95,$95
	db $84,$87,$85,$84,$92,$9A
	db $9D,$8E,$8E,$FF,$92,$FF
	db $86,$8B,$87,$FF,$92,$8B
	db $88,$9D,$9D,$FF,$92,$FF
	db $80,$91,$A1,$94,$92,$A1
	db $89,$8A,$91,$8A,$92,$89
	db $8B,$8B,$87,$83,$92,$8C
	db $8B,$A1,$8B,$90,$92,$8F
	db $80,$85,$80,$FF,$92,$86
	db $80,$8E,$80,$8D,$92,$8D
	db $9D,$8E,$80,$FF,$92,$FF
	db $80,$8B,$A1,$FF,$92,$FF
	db $91,$85,$91,$81,$92,$81
	db $82,$91,$82,$93,$92,$93
	db $94,$95,$94,$FF,$92,$95
	db $96,$9B,$97,$98,$99,$9A
	db $9C,$8E,$8E,$9C,$92,$8F
	db $9D,$9E,$9E,$FF,$92,$FF
	db $82,$82,$9F,$FF,$92,$FF
	db $8F,$8E,$A0,$FF,$92,$FF
	db $8B,$80,$8B,$FF,$92,$96
	db $80,$8B,$A1,$FF,$92,$FF
	db $96,$9B,$97,$98,$99,$9A
	db $96,$9B,$97,$98,$99,$9A
DefaultSongs:						; song numbers, one picked at random for each $FF in a team's six
	db $81,$89,$8A,$8D,$93,$9A,$9B
	db $FF							; after them, not picked
DATA8_C07F7B:						; a list of sound numbers ($FF ends it) that one screen has the sound
									; code load; the screen is not traced
	db $13,$14,$15,$16,$11,$10,$09,$FF
	padbyte $CD						; unused to the end of the lower half
	pad $C08000
