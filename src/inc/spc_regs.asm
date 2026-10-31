; Sound CPU (SPC700) I/O and DSP register names, as NHL94SNES SoundDriver uses them. Equates only, no bytes.
; The programs the CPU sends to the sound CPU (arch spc700 blocks) write the DSP through SPC_DSPADDR /
; SPC_DSPDATA.

; SPC700 I/O registers
SPC_CONTROL = $F1					; timer enables, port clears, boot ROM enable
SPC_DSPADDR = $F2					; DSP register number
SPC_DSPDATA = $F3					; DSP register data
SPC_PORT0 = $F4						; port 0 to and from the CPU
SPC_PORT1 = $F5						; port 1
SPC_PORT2 = $F6						; port 2
SPC_PORT3 = $F7						; port 3
SPC_T0TARGET = $FA					; timer 0 divider
SPC_IPLROM = $FFC0					; boot ROM: receives the next upload from the CPU
; DSP registers
DSP_MVOLL = $0C						; main volume left
DSP_MVOLR = $1C						; main volume right
DSP_EVOLL = $2C						; echo volume left
DSP_EVOLR = $3C						; echo volume right
DSP_KON = $4C						; key on
DSP_KOF = $5C						; key off
DSP_FLG = $6C						; flags: reset, mute, echo write disable, noise clock
DSP_EFB = $0D						; echo feedback
DSP_PMON = $2D						; pitch modulation
DSP_NON = $3D						; noise on
DSP_EON = $4D						; echo on
DSP_DIR = $5D						; sample directory page
DSP_ESA = $6D						; echo buffer page
DSP_EDL = $7D						; echo delay
DSP_C0 = $0F						; echo filter coefficient 0
DSP_C1 = $1F						; echo filter coefficient 1
DSP_C2 = $2F						; echo filter coefficient 2
DSP_C3 = $3F						; echo filter coefficient 3
DSP_C4 = $4F						; echo filter coefficient 4
DSP_C5 = $5F						; echo filter coefficient 5
DSP_C6 = $6F						; echo filter coefficient 6
DSP_C7 = $7F						; echo filter coefficient 7
