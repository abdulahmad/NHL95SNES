; NHL '95 SNES RAM names (CPU work RAM, the low 8 KB as the code reads it with data bank $80). Equates only,
; no bytes. Names follow the 94S RAM names (src/ram94s.asm there) where the job is the same.

; direct page
QueueBusy			=	$06			; negative while a routine pushes a record onto a transfer queue
r0					=	$2C			; math result (divides: the quotient)
r1					=	$30			; math operand (divides: the divisor, 4 bytes)
r2					=	$34			; math result (multiplies) and dividend (divides), 4 bytes
r3					=	$40			; work word (the pad waits keep their button mask here)
NMISkip				=	$4A			; nonzero while the NMI runs: a nested NMI only restores and returns
DMAQueueHead		=	$4C			; WaitDMAQueue waits until it equals DMAQueueTail
DMAQueueTail		=	$4E			; see DMAQueueHead
Vcount				=	$5D			; 32-bit frame counter, + 1 each NMI
PadRaw1				=	$C1			; controller 1 buttons held
PadRaw2				=	$C3			; controller 2 buttons held

; low RAM
DMAEnShadow			=	$0490		; the NMI writes this word to MDMAEN and HDMAEN
brightness			=	$0492		; screen brightness 0-15 the fade sets; the NMI writes it to INIDISP
FrameCount			=	$0494		; + 1 each NMI unless FrameCountHold; WaitFrame waits for it to change
TransfersReady		=	$0496		; nonzero: the NMI runs the queued transfers (unless QueueBusy)
FrameHookNext		=	$0498		; SetFrameHook stores X:A here; the NMI moves it to FrameHook
NMIHookNext			=	$049B		; SetNMIHook stores X:A here; the NMI moves it to NMIHook
FrameCountHold		=	$04A5		; nonzero: the NMI does not count FrameCount
FrameHook			=	$04A7		; long pointer: the routine the NMI calls after the fade
NMIHook				=	$04AA		; long pointer: the routine the NMI calls first
IRQHook				=	$04AD		; long pointer: the routine IRQ_Fast calls
seed				=	$04B0		; RandomWord's two 16-bit generators (seed, seed+2)
IRQVTime			=	$04B8		; IRQ line; the NMI writes it to VTIMEL
IRQHTime			=	$04BA		; IRQ dot; the NMI writes it to HTIMEL
irqline1			=	$04C9		; SetupScrollIRQ: the line of the first BG1 scroll split
irqline2			=	$04CB		; the line of the second split
irqline3			=	$04CD		; the line of the third split
irqvscroll1			=	$04CF		; BG1 vertical scroll from the first split
irqvscroll2			=	$04D1		; BG1 vertical scroll from the second split
irqvscroll3			=	$04D3		; BG1 vertical scroll from the third split
BG1HScroll			=	$04BC		; the NMI writes these six words to BG1HOFS..BG3VOFS
BG1VScroll			=	$04BE		; BG1 vertical scroll
BG2HScroll			=	$04C0		; BG2 horizontal scroll
BG2VScroll			=	$04C2		; BG2 vertical scroll
BG3HScroll			=	$04C4		; BG3 horizontal scroll
BG3VScroll			=	$04C6		; BG3 vertical scroll
fadestep			=	$059A		; fade: a delay counting down to a fade in, or $FFFF to fade out (NMI)

; work RAM, long addresses
unpackbuf			=	$7E50DC		; Decompress output buffer (DecompressUnpackbuf)
