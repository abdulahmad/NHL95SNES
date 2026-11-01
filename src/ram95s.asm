; NHL '95 SNES RAM names (CPU work RAM, the low 8 KB as the code reads it with data bank $80). Equates only,
; no bytes. Names follow the 94S RAM names (src/ram94s.asm there) where the job is the same.

; direct page
QueueBusy			=	$06			; negative while a routine pushes a record onto a transfer queue
r0					=	$2C			; math result (divides: the quotient)
r1					=	$30			; math operand (divides: the divisor, 4 bytes)
r2					=	$34			; math result (multiplies) and dividend (divides), 4 bytes
p0					=	$38			; long pointer; p0+2 is the bank
p1					=	$3C			; long pointer; p1+2 is the bank
r3					=	$40			; work word (the pad waits keep their button mask here)
NMISkip				=	$4A			; nonzero while the NMI runs: a nested NMI only restores and returns
DMAQueueHead		=	$4C			; WaitDMAQueue waits until it equals DMAQueueTail
DMAQueueTail		=	$4E			; see DMAQueueHead
crowdhold			=	$5B			; frames the crowd level holds before it fades (Goal 120, puckglue 20;
Vcount				=	$5D			; 32-bit frame counter, + 1 each NMI
a0					=	$63			; long pointer; a0+2 is the bank
a1					=	$67			; long pointer; a1+2 is the bank
a2					=	$6B			; team index, 0 = home
a3					=	$6F			; long pointer; a3+2 is the bank
a4					=	$73			; long pointer; a4+2 is the bank
d0					=	$7F			; as 94S d0
d1					=	$83			; d1+2 is the high word
d2					=	$87			; as 94S d2
d3					=	$8B			; as 94S d3
d4					=	$8F			; as 94S d4
d5					=	$93			; as 94S d5
d6					=	$97			; as 94S d6
d7					=	$9B			; frames elapsed, added into speeds
tmp0				=	$9F			; scratch word; tmp0+1 is the next byte
tmp1				=	$A1			; scratch word
tmp2				=	$A3			; scratch byte; tmp2+1 is the next byte
tmp4				=	$A7			; scratch word
curobj				=	$B7			; object index of the object being updated (updateplayers,
PadRaw1				=	$C1			; controller 1 buttons held
PadRaw2				=	$C3			; controller 2 buttons held

; low RAM
DMAEnShadow			=	$0490		; the NMI writes this word to MDMAEN and HDMAEN
brightness			=	$0492		; screen brightness 0-15 the fade sets; the NMI writes it to INIDISP
FrameCount			=	$0494		; + 1 each NMI unless FrameCountHold; WaitFrame waits for it to change
TransfersReady		=	$0496		; nonzero: the NMI runs the queued transfers (unless QueueBusy)
FrameHookNext		=	$0498		; SetFrameHook stores X:A here; the NMI moves it to FrameHook
NMIHookNext			=	$049B		; SetNMIHook stores X:A here; the NMI moves it to NMIHook
Multi5Sig			=	$049F		; Multi5ConnectCheck shifts bit 1 of JOYSER0 / JOYSER1 in here (port 1)
FrameCountHold		=	$04A5		; nonzero: the NMI does not count FrameCount
FrameHook			=	$04A7		; long pointer: the routine the NMI calls after the fade
NMIHook				=	$04AA		; long pointer: the routine the NMI calls first
IRQHook				=	$04AD		; long pointer: the routine IRQ_Fast calls
seed				=	$04B0		; RandomWord's two 16-bit generators (seed, seed+2)
IRQVTime			=	$04B8		; IRQ line; the NMI writes it to VTIMEL
IRQHTime			=	$04BA		; IRQ dot; the NMI writes it to HTIMEL
BG1HScroll			=	$04BC		; the NMI writes these six words to BG1HOFS..BG3VOFS
BG1VScroll			=	$04BE		; BG1 vertical scroll
BG2HScroll			=	$04C0		; BG2 horizontal scroll
BG2VScroll			=	$04C2		; BG2 vertical scroll
BG3HScroll			=	$04C4		; BG3 horizontal scroll
BG3VScroll			=	$04C6		; BG3 vertical scroll
irqline1			=	$04C9		; SetupScrollIRQ: the line of the first BG1 scroll split
irqline2			=	$04CB		; the line of the second split
irqline3			=	$04CD		; the line of the third split
irqvscroll1			=	$04CF		; BG1 vertical scroll from the first split
irqvscroll2			=	$04D1		; BG1 vertical scroll from the second split
irqvscroll3			=	$04D3		; BG1 vertical scroll from the third split
RemapOut			=	$04D5		; sixteen words: the tile RemapTiles is building
paddir				=	$056F		; 5 words: each pad's direction (PadDirection of the dpad bits)
padnew				=	$0583		; 5 words: each pad's buttons newly pressed at the last ReadPads
repeatdelayframes	=	$058F		; ProcessInputWithRepeat: frames to the next key repeat (dec, reload ...
fadestep			=	$059A		; fade: a delay counting down to a fade in, or $FFFF to fade out (NMI)
puckc				=	$05A0		; object index of the puck carrier, negative = loose
timestep			=	$05A2		; Gameloop/SaveRegsStartHL2/ReplayMode/PauseReplay store d7 (frames
PadControlObj		=	$05AE		; setpads stores SCnum of the player each marker slot follows (slot 0 puck
goalieflags			=	$05CC		; Per player (12): assgoalie/assgoalietopuck set bits 1,2 and clear bit 2
puckdir				=	$0624		; per object: direction to the puck (vtoa)
asscur				=	$0644		; Per object: the assignment number being run (the asslist entry at
dumpintarget		=	$066C		; assdumpin: the target index (DumpInTarget), a word offset into its x / y
passtargety			=	$0670		; dopass: pucky + the pass vector y; asspassrec: goal line y (+-$108) ...
onetimerreq			=	$0672		; Set when the pass receiver's pad presses shoot (asspassrec, doinput) or
goalieturnwait		=	$0694		; Per player: AdjustFacingDirection/goalieacc set 6 after turning a
replaydelay			=	$0772		; Goal / Stop4Pen set 30: updatereplay keeps recording until it ...
recsfx				=	$0776		; QueueSound: the sound queued this frame ($FFFF none) for the replay
recsfx2				=	$077C		; QueueSound moves recsfx here when a second sound comes in the same ...
collflag			=	$07A2		; a player collision happened: checkcoll restores the old position (set by
ThirdPBonus			=	$07AC		; setplayer: +2 when tied or trailing late in the 3rd period
HmAwBonus			=	$07B4		; setplayer: home bonus / visitor penalty
iflags				=	$07B6		; icing flags (if* masks)
lastplayer			=	$07B8		; the last player who touched the puck (doshot, puckstick)
lldisp				=	$07BC		; count down for the once-a-second screen / game updates (periodicevents)
passdir				=	$07C8		; direction for pass/shot 0-7 (8 = none)
passspeed			=	$07CA		; speed of pass/shot
passReceiverPlayerNum	=	$07CC	; the player the last pass was aimed at (negative = none)
PKBonus				=	$07CE		; setplayer: penalty kill bonus (negative)
PPBonus				=	$07D0		; setplayer: power play bonus
recbpr				=	$07E0		; long pointer to the next replay frame record
TickerNum			=	$07F2		; playoff game the score ticker shows next
wcradiusy			=	$07FC		; wall collision radius y
xc1					=	$080A		; scroll lock x
yc1					=	$080C		; scroll lock y
yleader				=	$080E		; lead distance on scrolling
Xpos				=	$0814		; x position (integer part) of each object
frame				=	$0856		; sprite frame number of each object (SPF groups); object 14 ($1C) is the
Ypos				=	$0896		; y position (integer part) of each object
pucky				=	$08B2		; puck y position
puckz				=	$08D8		; puck height (93S Zpos+puckscnum)
puckvz				=	$08DE		; puck height speed (93S Zvel+puckscnum)
attribute			=	$08E0		; frame attribute bits (attrxflip, attryflip)
Xvel				=	$09A0		; x speed (puckvx is Xvel+puckscnum)
puckvx				=	$09BC		; puck x speed
Yvel				=	$09C0		; y speed
puckvy				=	$09DC		; puck y speed
position			=	$0A20		; player's position
assnum				=	$0A40		; index of the current assignment (0-7)
temp1				=	$0AE0		; assignment scratch, per object
temp2				=	$0B00		; as 94S temp2
temp3				=	$0B20		; as 94S temp3
temp4				=	$0B40		; as 94S temp4
temp5				=	$0B60		; as 94S temp5
temp2b				=	$0B80		; as 94S temp2b
Wallcos				=	$0BE0		; per object: cos of the angle of the last wall collision
Wallsin				=	$0C00		; per object: sin of that angle
facedir				=	$0C40		; direction of facing, 0-7
SPA					=	$0C80		; current animation (offset into the animation data)
SPAnum				=	$0CA0		; index into animation (4 per frame)
SPAcnt				=	$0CC0		; count down to the next animation frame (-1 = restart)
nopuck				=	$0CE0		; no puck collision until zero
newpos				=	$0D20		; requested next position (negative = none)
newpnum				=	$0D40		; requested next roster player (negative = none)
pflags				=	$0D60		; pflags (bits 0-7) and pflags2 (bit n at bit n+10); some flags have their
pnum				=	$0DC0		; player's team location number (low byte)
aioff				=	$0E40		; as 94S aioff
aidef				=	$0E60		; as 94S aidef
shotacc				=	$0EA0		; as 94S shotacc
passacc				=	$0EC0		; passacc (goalies: glove save right)
rostnum				=	$0EE0		; as 94S rostnum
spodds				=	$0F00		; shot / pass odds
stickhand			=	$0F20		; as 94S stickhand
checking			=	$0FA0		; checking rating (check odds; 93 $75)
pfgoal				=	$0FE0		; nonzero: shoots at the top goal. pflags bit pfgoal
pfalock				=	$1000		; nonzero: locked until the animation is done
pfteam				=	$1020		; 0 = home, nonzero = visitors. pflags bit pfteam
pfrev				=	$1040		; nonzero: skating backwards. pflags bit pfrev
pf2aip				=	$1060		; nonzero: animation in progress. pflags2 bit pf2aip
pfnc				=	$1080		; nonzero: no collision mode. pflags bit pfnc
Ylist				=	$10A0		; y of each sort object
OOlistpos			=	$10C0		; position of each object in OOlist
OOlist				=	$10E0		; 16 bytes: object order list, bottom of the screen last
gmode				=	$10F1		; game mode flags (gm* masks)
gmclock				=	$10F3		; nonzero: game clock is stopped
sflags				=	$10F5		; sflags (low byte) and sflags2 (high byte) as one word (sf*/sf2* masks)
sflags3				=	$10F7		; sflags3 (sf3* masks)
PenCntDwn			=	$113B		; penalty/fight count down (negative = fight over)
Penaltytimer		=	$113D		; frames to the next penalty clock second (updatepentime)
PBnum				=	$113F		; players in the penalty boxes: home*16 + visitors
gsp					=	$114B		; game period
gameclock			=	$114D		; game clock seconds; gameclock+2 = jiffies
TempPlOffset		=	$1153		; pnum of the penalized player, high bit set for the visitors
IsBreakaway			=	$1155		; 1 while the puck carrier has a breakaway (CheckBreakaway)
PenShotActive		=	$1157		; 1 during a penalty shot (SetupPenaltyShot .. puckfaceoff2)
tmPPShots			=	$1277		; power play shots (ChkShotStat)
tmSHShots			=	$127B		; shorthanded shots (ChkShotStat; not on the stats screen)
tmsort				=	$1283		; first object index of the team
tmscore				=	$12AB		; score
tmline				=	$12B7		; current line
tmtouch1			=	$12BB		; pnum of the last touch
tmtouch2			=	$12BF		; second last touch
tmtouch3			=	$12C3		; third last touch
tmap				=	$12C7		; active players on ice
tmgoalie			=	$12CB		; home and away goalie (words): low byte = goalie 0/1, $FFxx = pulled
tmflags				=	$12FF		; team flags
tmpde				=	$130B		; energy of each roster player (word per player)
tmpdst				=	$1373		; bench/ice/box state of each roster player
tmboxlist			=	$13DB		; penalty box list of roster players (bytes, negative ends)
CwdExciteLvl		=	$14E3		; crowd excitement: raised by hits and goals, set per playoff stage at a
teampads			=	$14F5		; pads on the home / away team
playerpad			=	$14F9		; per player object: the controlling pad * 2, negative = none
c1playernum			=	$1511		; per pad (5 words): the player object it controls (93S c1playernum,
cont1team			=	$17B5		; Team on pad 1 (0 none, 1 home, 2 away); StartGame turns cont1team,x into
onetimer			=	$18AC		; A one-timer shot is under way: asspassrec sets 1 when the receiver ...
breakaway			=	$18AE		; Breakaway in progress (CheckBreakaway result IsBreakaway):
BA_Sktr_SCnum		=	$18B0		; Penalty shot / shootout shooter object (SCnum*2, $FFFF none): ...
BA_Team				=	$18B4		; Shooting team of the penalty shot / shootout turn (0 home, 2 visitors):
penshot				=	$18BE		; Penalty shot pending / under way: StartPenaltyShot sets 1, ...

; work RAM, long addresses
unpackbuf			=	$7E50DC		; Decompress output buffer (DecompressUnpackbuf)
