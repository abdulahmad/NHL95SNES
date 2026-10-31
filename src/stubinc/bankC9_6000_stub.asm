;	Segment build for bankC9_6000.asm: sets the mapping and the outside labels it uses, then includes the file on its own for
;	checking against the ROM (tools/verify_segment.sh bankC9_6000). The org is in the segment file.
hirom

; External addresses outside, read from the ROM. Equates only (the full build has the labels).

incsrc "../bankC9_6000.asm"
