;	Segment build for bankC6_0000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC6_0000). The org is in the segment
;	file.
hirom

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
DATA8_C62968 = $C62968				; frame source in another segment
DATA8_C62BE8 = $C62BE8				; frame source in another segment
DATA8_C62E28 = $C62E28				; frame source in another segment

incsrc "../bankC6_0000.asm"
