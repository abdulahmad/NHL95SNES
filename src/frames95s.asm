; NHL '95 SNES player frame groups (SPF): equates only, no bytes. A frame number indexes
; FrameTileSource / FrameBankLayout (1060 frames, tiles in banks $C6-$CC); the SPA lists and the code write
; frames as SPFgroup+n. Names are 94S's for the frames of the same job, else 95 Genesis's. The order follows
; 95 Genesis's frame sheet up to $29D, then some groups move. Frame slots not in a group are empty, except
; $312 and $319, the first frames of SPAflip, which sit alone in an empty run.

SPFskate			=	$001		; 64 frames: skating: 8 slots a direction, 5 of them drawn (SPAskate)
SPFglide			=	$041		; 8 frames: gliding, one a direction (SPAglide)
SPFstop				=	$049		; 16 frames: stopping, 2 a direction (SPAstop)
SPFpad				=	$06F		; 1 frame: the controller stars (setupice, RestoreGameScreen)
SPFreplay			=	$072		; 1 frame: the replay camera cursor, four corner marks (RestoreGameScreen;
									; TagReplayMarker draws it)
SPFshoulderl		=	$07B		; 8 frames: shoulder check left, one a direction (SPAshoulderchkl)
SPFshoulderr		=	$083		; 8 frames: shoulder check right, one a direction (SPAshoulderchkr)
SPFhook				=	$08B		; 16 frames: hooking (SPAhook, SPAhook2)
SPFHold				=	$09B		; 8 frames: holding, one a direction (SPAHold, SPAHold2)
SPFsweep			=	$0A3		; 16 frames: sweep check (SPAsweepchk); SPAfaceoff uses +0, +1, +8 and +9
SPFfallfwd			=	$0B3		; 48 frames: falling forward (SPAfallfwd; the board checks use some)
SPFfallback			=	$0E3		; 40 frames: falling back (SPAfallback; SPAflip and the board checks use
									; some)
SPFburst			=	$10B		; 64 frames: a speed burst: 8 slots a direction, 4 of them drawn
									; (SPAburst)
SPFskatewp			=	$14B		; 64 frames: skating with the puck: 8 slots a direction, 5 of them drawn
									; (SPAskatewp); SPAfaceoff uses +2 and +34
SPFpuck				=	$1B3		; 11 frames: +0 the puck shadow, +1 to +10 the flipping puck (SPApflip;
									; drawn by layout code)
SPFgoal				=	$1BE		; 2 frames: the two nets (setupice, RestoreGameScreen)
SPFswing			=	$1C0		; 48 frames: shot and pass swings, 6 a direction (SPAshotf, SPApassf,
									; SPAonetimef, SPAshotb)
SPFskateb			=	$1F0		; 48 frames: skating backwards, 6 a direction (SPAskateback, SPAglideback)
SPFstumble			=	$220		; 32 frames: stumbling, 4 a direction (SPAstumble)
SPFswingb			=	$240		; 24 frames: the backhand pass and shot, 3 a direction (SPApassb,
									; SPAshotb, SPAonetimeb)
SPFflip				=	$258		; 6 frames: flipping over (SPAflip)
SPFGoalie			=	$25E		; 40 frames: the goalie, 5 runs of 8 (one a direction): +0 SPAgready2, +8
									; SPAgglovel, +16 SPAgglover, +24 SPAgstickl, +32 SPAgstickr
SPFgdive			=	$286		; 24 frames: the goalie diving: 3 slots a direction, 2 of them drawn
									; (SPAgdive, SPAgpoke, SPAgcover; puckgoalie)
SPFPen				=	$29E		; 7 frames: a player jumping over the boards into the box or onto the
									; bench and sitting (+6), forward in SPAwallin, back in SPAwallout;
									; assdopen seats a player on +6
SPFSiren			=	$2BD		; 14 frames: the goal light (SPAsiren)
SPFgstack			=	$2CB		; 40 frames: the goalie: +0 stacking left, +12 stacking right, +24 the
									; stick swing (SPAgstackl, SPAgstackr, SPAgswing)
SPFcrosscheck		=	$32A		; 8 frames: cross check, one a direction (SPAcrosscheck)
SPFcatch			=	$332		; 16 frames: catching a pass, 2 a direction (SPAcatch)
SPFhip				=	$342		; 4 frames: hip checks: +0 / +2 left (SPAhipchkl), +1 / +3 right
									; (SPAhipchkr)
SPFcelebrate		=	$346		; 16 frames: celebrating a goal, 2 a direction (SPAcelebrate)
SPFgskate			=	$356		; 32 frames: the goalie skating, 4 a direction (SPAgskate; SPAgpoke,
									; SPAgbutterfly and SPAgsprawlr use some)
SPFgbutterfly		=	$376		; 2 frames: the goalie's butterfly (SPAgbutterfly, SPAgcover)
SPFboardfront		=	$378		; 16 frames: checked into the boards, from the front (SPAboardfront)
SPFboardright		=	$388		; 16 frames: checked into the boards, from the right (SPAboardright)
SPFboardback		=	$398		; 14 frames: checked into the boards, from behind (SPAboardback)
SPFboardleft		=	$3A6		; 14 frames: checked into the boards, from the left (SPAboardleft)
SPFinjury1			=	$3B4		; 6 frames: lying injured, 3 for each of two sides (SPAinjury1)
SPFgready			=	$3BA		; 18 frames: the goalie ready (SPAgready)
SPFpump2			=	$3EC		; 16 frames: a stick pump, 2 a direction (SPApump2)
SPFbenchcheck		=	$41B		; 9 frames: checked into the bench (SPAbenchcheckr)
