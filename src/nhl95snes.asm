; NHL '95 for the SNES. The whole cartridge (HiROM, 1 MB), one bank file per 64 KB bank (src/banks/), each
; listing its routine (src/routines/) and data (src/data/) files in ROM order; the build checks every byte
; against the retail ROM.

hirom

incsrc "inc/snes_regs.asm"
incsrc "inc/spc_regs.asm"
incsrc "ram95s.asm"
incsrc "frames95s.asm"
incsrc "data/gfx/frametiles95s.asm"

incsrc "banks/bC0_gfx_sound.asm"
incsrc "banks/bC1_gfx.asm"
incsrc "banks/bC2_gfx_sound.asm"
incsrc "banks/bC3_tables_text.asm"
incsrc "banks/bC4_logic_collide.asm"
incsrc "banks/bC5_create_hockey.asm"
incsrc "banks/bC6_gfx.asm"
incsrc "banks/bC7_gfx.asm"
incsrc "banks/bC8_gfx.asm"
incsrc "banks/bC9_gfx.asm"
incsrc "banks/bCA_gfx.asm"
incsrc "banks/bCB_gfx.asm"
incsrc "banks/bCC_gfx.asm"
incsrc "banks/bCD_gfx.asm"
incsrc "banks/bCE_gfx.asm"
incsrc "banks/bCF_gfx_display.asm"
