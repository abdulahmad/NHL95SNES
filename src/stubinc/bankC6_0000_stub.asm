;	Segment build for bankC6_0000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC6_0000). The org is in the segment
;	file.
hirom

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
DATA8_C62968 = $C62968				; frame source in another segment
DATA8_C62BE8 = $C62BE8				; frame source in another segment
DATA8_C62E28 = $C62E28				; frame source in another segment
DATA8_C630A8 = $C630A8				; frame source in another segment
DATA8_C63308 = $C63308				; frame source in another segment
DATA8_C63508 = $C63508				; frame source in another segment
DATA8_C63788 = $C63788				; frame source in another segment
DATA8_C639E8 = $C639E8				; frame source in another segment
DATA8_C63C68 = $C63C68				; frame source in another segment
DATA8_C63EC8 = $C63EC8				; frame source in another segment
DATA8_C64128 = $C64128				; frame source in another segment
DATA8_C64388 = $C64388				; frame source in another segment
DATA8_C64588 = $C64588				; frame source in another segment
DATA8_C64808 = $C64808				; frame source in another segment
DATA8_C64A68 = $C64A68				; frame source in another segment
DATA8_C64C68 = $C64C68				; frame source in another segment
DATA8_C64EC8 = $C64EC8				; frame source in another segment
DATA8_C650C8 = $C650C8				; frame source in another segment
DATA8_C65328 = $C65328				; frame source in another segment
DATA8_C65528 = $C65528				; frame source in another segment
DATA8_C65728 = $C65728				; frame source in another segment
DATA8_C65988 = $C65988				; frame source in another segment
DATA8_C65B88 = $C65B88				; frame source in another segment
DATA8_C65D88 = $C65D88				; frame source in another segment
DATA8_C65F88 = $C65F88				; frame source in another segment

incsrc "../bankC6_0000.asm"
