; *** ANONYMIZED: the player names and team nicknames are placeholders. ***

; Players are P000 ... P686 (their PlayerList number) and nicknames N01 ... N26. The real ones are NHLPA /
; NHL licensed data and are not in this repository.

; Each PackedName line holds a placeholder that packs to as many bytes as the real text (the player and team
; records are found by address, so a length must not change). Ratings, lines and everything else are the
; game's own.

; This file does not assemble into the real game by itself and is not included directly: it needs the
; original ROM. tools/names95.py (run by tools/prebuild.py before every build) reads the names from the ROM
; into Extracted/PlayerNames.txt and Extracted/TeamNicknames.txt (one per line, in the order they appear
; below), then copies this file to output/names/teamdata95s.asm with each PackedName / PackedText line
; turned into the packed text bytes (the real name for a PackedName line). src/banks/bC3_tables_text.asm
; includes that copy.

; Keep each placeholder's packed length when editing a name or adding a player.

; Packed text: 5-bit symbols, low bit first, as UnpackText reads them: 0-25 a letter of the current case
; (upper to start), $1A the end, $1B a space, $1C swaps the case, $1D / $1E / $1F + 3 bits one of
; PackedTextSymbols (digits and punctuation; "=" stands for "." in a name). The last byte is padded with 0
; bits.

; The team database (bank $C3), after TeamList and PlayerList: first the player records in ROM order
; (PlayerList points to each), then the team records (TeamList points to each; team number = index, the two
; All Star teams last). A player record: the sweater number, 7 bytes of ratings (two nibbles each: weight
; and leg power, speed and offensive awareness, defensive awareness and shot power, checking and hand,
; stickhandling and accuracy, endurance and shot/pass decision, passing and aggressiveness), then the packed
; name. A team record: a word with the roster size in bits 11-15 and the PlayerList address of its first
; player in bits 0-10 (the roster is that many PlayerList entries in a row: goalies, forwards, defence), a
; word to the city string, four offsets (from the start of the record) to the lines from the second on, the
; bonus bytes, the goalie weights and the lines, then those four parts, then four packed strings: city,
; abbreviation, nickname and arena. Bonus bytes: byte 0 scoring odds of simulated games (high nibble offense
; row, low nibble defense row), byte 1 high nibble penalty kill deficit, low nibble power play bonus, byte 2
; high nibble home bonus, low nibble visitor bonus (UnpackTeamBonuses), byte 3 not read, byte 4 the overall
; byte 4 the overall rating (shown on the matchup screen). The goalie weights are two bytes, the starting
; goalie weights as 95G's .godds; GetGoalieCount counts the used nibbles of that word. A line is 8 bytes:
; the goalie, the two defence (in the other order than 95G), left wing, centre, right wing, the extra
; attacker and a 0; the lines are numbered by roster position, 1 = the team's first player.
Player619:							; player 619 of PlayerList, a goalie
	db 35,$75,$43,$44,$01,$00,$55,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P619XXXXXXXX"
Player620:							; player 620 of PlayerList, a goalie
	db 33,$66,$43,$55,$01,$00,$56,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P620XXXXXXXX"
Player621:							; player 621 of PlayerList, a goalie
	db 34,$54,$34,$53,$01,$00,$44,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P621XXXXXXXXXXX"
Player622:							; player 622 of PlayerList, a forward
	db 11,$95,$44,$33,$49,$93,$42,$53	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P622XXXXXXXX"
Player623:							; player 623 of PlayerList, a forward
	db 12,$75,$46,$53,$3A,$54,$50,$61	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P623XXXXXXX"
Player624:							; player 624 of PlayerList, a forward
	db 77,$94,$45,$34,$09,$95,$41,$40	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P624XXXXXXXXXXX"
Player625:							; player 625 of PlayerList, a forward
	db 19,$64,$35,$43,$29,$C5,$52,$62	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P625XXXXXXX"
Player626:							; player 626 of PlayerList, a forward
	db 19,$44,$44,$34,$2A,$64,$42,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P626XXXXXXXXXX"
Player627:							; player 627 of PlayerList, a forward
	db 19,$74,$44,$14,$1A,$C4,$32,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P627XXXXXXXXXX"
Player628:							; player 628 of PlayerList, a forward
	db 88,$C4,$34,$45,$56,$A6,$53,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P628XXXXXXXX"
Player629:							; player 629 of PlayerList, a forward
	db 7,$64,$34,$33,$3A,$65,$44,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P629XXXXXXX"
Player630:							; player 630 of PlayerList, a forward
	db 9,$94,$44,$33,$5D,$73,$45,$35	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P630XXXXXXXX"
Player631:							; player 631 of PlayerList, a forward
	db 8,$64,$54,$34,$2B,$64,$43,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P631XXXXXXXXXXX"
Player632:							; player 632 of PlayerList, a forward
	db 8,$65,$45,$34,$3D,$95,$43,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P632XXXXXXXX"
Player633:							; player 633 of PlayerList, a forward
	db 68,$A5,$45,$34,$4B,$C3,$61,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P633XXXXXXXX"
Player634:							; player 634 of PlayerList, a forward
	db 22,$92,$34,$34,$2C,$64,$34,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P634XXXXXXXX"
Player635:							; player 635 of PlayerList, a forward
	db 89,$76,$66,$34,$17,$94,$44,$51	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P635XXXXXXXXXXXXX"
Player636:							; player 636 of PlayerList, a defence
	db 2,$66,$35,$44,$2D,$C2,$52,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P636XXXXXXXX"
Player637:							; player 637 of PlayerList, a defence
	db 4,$B4,$44,$64,$5D,$73,$51,$45	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P637XXXXXXXXXX"
Player638:							; player 638 of PlayerList, a defence
	db 3,$73,$33,$42,$3B,$A1,$32,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P638XXXXXXXX"
Player639:							; player 639 of PlayerList, a defence
	db 77,$A5,$45,$55,$49,$C5,$64,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P639XXXXXXXX"
Player640:							; player 640 of PlayerList, a defence
	db 43,$B4,$44,$46,$49,$A2,$33,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P640XXXXXXX"
Player641:							; player 641 of PlayerList, a goalie
	db 32,$53,$44,$43,$01,$00,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P641XXXXXXXX"
Player642:							; player 642 of PlayerList, a goalie
	db 31,$65,$45,$64,$01,$00,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P642XXXXXXXXXX"
Player643:							; player 643 of PlayerList, a goalie
	db 29,$64,$46,$64,$01,$00,$54,$54	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P643XXXXXXXX"
Player644:							; player 644 of PlayerList, a forward
	db 93,$45,$45,$54,$4B,$C4,$60,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P644XXXXXXXX"
Player645:							; player 645 of PlayerList, a forward
	db 99,$46,$46,$43,$19,$C4,$61,$60	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P645XXXXXXXXXX"
Player646:							; player 646 of PlayerList, a forward
	db 25,$84,$35,$34,$37,$95,$43,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P646XXXXXXXXXXX"
Player647:							; player 647 of PlayerList, a forward
	db 27,$45,$55,$45,$3C,$D5,$52,$53	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P647XXXXXXXXXXX"
Player648:							; player 648 of PlayerList, a forward
	db 91,$76,$66,$54,$2B,$C5,$52,$53	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P648XXXXXXXXXXX"
Player649:							; player 649 of PlayerList, a forward
	db 9,$93,$33,$44,$47,$73,$43,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P649XXXXXXXXXX"
Player650:							; player 650 of PlayerList, a forward
	db 14,$B3,$25,$34,$3A,$95,$54,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P650XXXXXXXXXXX"
Player651:							; player 651 of PlayerList, a forward
	db 19,$A3,$35,$45,$3A,$A5,$42,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P651XXXXXXXXXXXXX"
Player652:							; player 652 of PlayerList, a forward
	db 10,$56,$66,$25,$29,$C5,$45,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P652XXXXXXX"
Player653:							; player 653 of PlayerList, a forward
	db 13,$65,$65,$24,$38,$C5,$54,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P653XXXXXXXXXX"
Player654:							; player 654 of PlayerList, a forward
	db 16,$94,$45,$36,$3A,$94,$44,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P654XXXXXXX"
Player655:							; player 655 of PlayerList, a forward
	db 26,$65,$64,$34,$2C,$93,$43,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P655XXXXXXXXXXX"
Player656:							; player 656 of PlayerList, a defence
	db 4,$A4,$44,$44,$4A,$A2,$43,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P656XXXXXXX"
Player657:							; player 657 of PlayerList, a defence
	db 2,$84,$44,$46,$38,$92,$53,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P657XXXXXXXXXX"
Player658:							; player 658 of PlayerList, a defence
	db 7,$A4,$32,$33,$37,$61,$31,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P658XXXXXXXXXXXXX"
Player659:							; player 659 of PlayerList, a defence
	db 6,$73,$44,$34,$2B,$94,$42,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P659XXXXXXXXXXX"
Player660:							; player 660 of PlayerList, a defence
	db 7,$74,$44,$65,$4A,$A2,$62,$45	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P660XXXXXXXXXX"
Player661:							; player 661 of PlayerList, a defence
	db 77,$96,$54,$34,$2B,$C2,$51,$63	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P661XXXXXXXX"
Player000:							; player 0 of PlayerList, a goalie
	db 31,$64,$33,$32,$01,$00,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P000XXXXXXX"
Player001:							; player 1 of PlayerList, a goalie
	db 35,$62,$22,$23,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P001XXXXXXXXXXXXXXX"
Player002:							; player 2 of PlayerList, a forward
	db 20,$A3,$33,$33,$38,$63,$35,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P002XXXXXXX"
Player003:							; player 3 of PlayerList, a forward
	db 47,$53,$34,$33,$26,$64,$42,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P003XXXXXXXXXXX"
Player004:							; player 4 of PlayerList, a forward
	db 19,$73,$43,$43,$27,$63,$40,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P004XXXXXXXXXXX"
Player005:							; player 5 of PlayerList, a forward
	db 22,$92,$22,$22,$3B,$62,$31,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P005XXXXXXXXXXXXX"
Player006:							; player 6 of PlayerList, a forward
	db 14,$83,$33,$23,$3B,$63,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P006XXXXXXX"
Player007:							; player 7 of PlayerList, a forward
	db 25,$63,$44,$23,$3A,$64,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P007XXXXXXX"
Player008:							; player 8 of PlayerList, a forward
	db 16,$83,$32,$33,$28,$32,$24,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P008XXXXXXXX"
Player009:							; player 9 of PlayerList, a forward
	db 36,$B1,$12,$12,$38,$52,$23,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P009XXXXXXX"
Player010:							; player 10 of PlayerList, a forward
	db 17,$72,$23,$22,$26,$63,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P010XXXXXXXX"
Player011:							; player 11 of PlayerList, a forward
	db 24,$A2,$32,$32,$49,$71,$32,$12	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P011XXXXXXX"
Player012:							; player 12 of PlayerList, a forward
	db 18,$72,$22,$33,$39,$73,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P012XXXXXXX"
Player013:							; player 13 of PlayerList, a forward
	db 32,$B1,$10,$21,$2B,$21,$25,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P013XXXXXXXX"
Player014:							; player 14 of PlayerList, a forward
	db 8,$73,$23,$33,$1B,$63,$34,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P014XXXXXXXX"
Player015:							; player 15 of PlayerList, a forward
	db 21,$72,$23,$22,$07,$62,$23,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P015XXXXXXXXXXX"
Player016:							; player 16 of PlayerList, a defence
	db 4,$82,$22,$22,$28,$32,$24,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P016XXXXXXXXXXX"
Player017:							; player 17 of PlayerList, a defence
	db 6,$83,$32,$22,$26,$62,$33,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P017XXXXXXX"
Player018:							; player 18 of PlayerList, a defence
	db 2,$A3,$22,$43,$39,$62,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P018XXXXXXXX"
Player019:							; player 19 of PlayerList, a defence
	db 39,$82,$12,$23,$27,$62,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P019XXXXXXXXXX"
Player020:							; player 20 of PlayerList, a defence
	db 23,$B1,$22,$23,$2B,$63,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P020XXXXXXXX"
Player021:							; player 21 of PlayerList, a defence
	db 3,$82,$12,$22,$27,$32,$23,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P021XXXXXXXX"
Player022:							; player 22 of PlayerList, a defence
	db 29,$B3,$21,$41,$39,$71,$45,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P022XXXXXXXXXXX"
Player023:							; player 23 of PlayerList, a goalie
	db 30,$24,$33,$43,$01,$00,$43,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P023XXXXXXX"
Player024:							; player 24 of PlayerList, a goalie
	db 37,$63,$32,$22,$01,$00,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P024XXXXXXXXXXXXX"
Player025:							; player 25 of PlayerList, a forward
	db 12,$75,$46,$53,$3A,$54,$50,$61	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P025XXXXXXX"
Player026:							; player 26 of PlayerList, a forward
	db 22,$52,$22,$22,$18,$63,$32,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P026XXXXXXXXXX"
Player027:							; player 27 of PlayerList, a forward
	db 45,$82,$22,$21,$18,$32,$23,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P027XXXXXXXXXXX"
Player028:							; player 28 of PlayerList, a forward
	db 20,$04,$44,$33,$2A,$93,$34,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P028XXXXXXXXXXX"
Player029:							; player 29 of PlayerList, a forward
	db 33,$73,$32,$13,$14,$63,$24,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P029XXXXXXX"
Player030:							; player 30 of PlayerList, a forward
	db 8,$A3,$35,$45,$40,$45,$54,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P030XXXXXXX"
Player031:							; player 31 of PlayerList, a forward
	db 27,$63,$23,$34,$34,$73,$44,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P031XXXXXXXXXX"
Player032:							; player 32 of PlayerList, a forward
	db 23,$63,$43,$33,$3A,$33,$34,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P032XXXXXXXXXXX"
Player033:							; player 33 of PlayerList, a forward
	db 44,$04,$33,$23,$2A,$64,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P033XXXXXXXX"
Player034:							; player 34 of PlayerList, a forward
	db 19,$73,$33,$22,$12,$62,$33,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P034XXXXXXXXXXXXXXX"
Player035:							; player 35 of PlayerList, a forward
	db 18,$63,$32,$32,$39,$72,$25,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P035XXXXXXXX"
Player036:							; player 36 of PlayerList, a forward
	db 10,$64,$44,$13,$17,$94,$42,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P036XXXXXXXXXXXXXXX"
Player037:							; player 37 of PlayerList, a forward
	db 21,$43,$43,$43,$2D,$33,$33,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P037XXXXXXX"
Player038:							; player 38 of PlayerList, a forward
	db 17,$93,$32,$33,$2B,$24,$42,$20	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P038XXXXXXX"
Player039:							; player 39 of PlayerList, a defence
	db 25,$83,$32,$34,$39,$21,$35,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P039XXXXXXXX"
Player040:							; player 40 of PlayerList, a defence
	db 77,$A5,$45,$55,$49,$C5,$64,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P040XXXXXXXX"
Player041:							; player 41 of PlayerList, a defence
	db 34,$92,$22,$42,$36,$72,$45,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P041XXXXXXX"
Player042:							; player 42 of PlayerList, a defence
	db 43,$B4,$44,$46,$49,$A2,$33,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P042XXXXXXX"
Player043:							; player 43 of PlayerList, a defence
	db 32,$44,$33,$43,$46,$A1,$41,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P043XXXXXXXX"
Player044:							; player 44 of PlayerList, a defence
	db 26,$85,$44,$44,$3B,$42,$44,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P044XXXXXXXX"
Player045:							; player 45 of PlayerList, a defence
	db 14,$73,$21,$31,$37,$23,$30,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P045XXXXXXXXXXX"
Player046:							; player 46 of PlayerList, a defence
	db 6,$B3,$31,$22,$47,$43,$23,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P046XXXXXXXXXXX"
Player048:							; player 48 of PlayerList, a goalie
	db 31,$75,$45,$55,$00,$00,$34,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P048XXXXXXX"
Player047:							; player 47 of PlayerList, a goalie
	db 39,$45,$35,$54,$01,$00,$56,$56	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P047XXXXXXXXXX"
Player049:							; player 49 of PlayerList, a forward
	db 14,$63,$22,$32,$2B,$63,$21,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P049XXXXXXXX"
Player050:							; player 50 of PlayerList, a forward
	db 16,$55,$46,$44,$24,$C4,$62,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P050XXXXXXXXXXXXX"
Player051:							; player 51 of PlayerList, a forward
	db 10,$66,$45,$44,$2B,$C3,$40,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P051XXXXXXXXXXX"
Player052:							; player 52 of PlayerList, a forward
	db 20,$93,$23,$53,$37,$34,$42,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P052XXXXXXXX"
Player053:							; player 53 of PlayerList, a forward
	db 32,$A3,$41,$21,$4B,$52,$15,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P053XXX"
Player054:							; player 54 of PlayerList, a forward
	db 19,$82,$53,$42,$3D,$33,$44,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P054XXXXXXX"
Player055:							; player 55 of PlayerList, a forward
	db 13,$74,$34,$44,$36,$94,$43,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P055XXXXXXXX"
Player056:							; player 56 of PlayerList, a forward
	db 27,$92,$23,$23,$4B,$43,$35,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P056XXXXX"
Player057:							; player 57 of PlayerList, a forward
	db 22,$83,$34,$34,$23,$64,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P057XXXXXXXXXX"
Player058:							; player 58 of PlayerList, a forward
	db 43,$83,$33,$23,$29,$64,$34,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P058XXXXXXX"
Player059:							; player 59 of PlayerList, a forward
	db 26,$44,$44,$33,$2B,$93,$32,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P059XXXXXXXX"
Player060:							; player 60 of PlayerList, a forward
	db 89,$76,$66,$34,$17,$94,$44,$51	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P060XXXXXXXXXXXXX"
Player061:							; player 61 of PlayerList, a forward
	db 18,$63,$33,$43,$36,$73,$34,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P061XXXXXXXXXX"
Player062:							; player 62 of PlayerList, a forward
	db 28,$53,$34,$34,$26,$64,$35,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P062XXXXXXXXXXX"
Player063:							; player 63 of PlayerList, a forward
	db 36,$72,$22,$12,$39,$52,$33,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P063XXXXXXXXXXX"
Player064:							; player 64 of PlayerList, a defence
	db 24,$A3,$22,$12,$38,$41,$11,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P064XXXXXXXX"
Player065:							; player 65 of PlayerList, a defence
	db 8,$A4,$33,$42,$29,$91,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P065XXXXXXXX"
Player066:							; player 66 of PlayerList, a defence
	db 41,$83,$22,$42,$19,$32,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P066XXXXXXX"
Player067:							; player 67 of PlayerList, a defence
	db 4,$73,$33,$23,$28,$92,$32,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P067XXXXXXXXXXXXX"
Player068:							; player 68 of PlayerList, a defence
	db 5,$92,$21,$52,$4B,$61,$42,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P068XXXXXXX"
Player069:							; player 69 of PlayerList, a defence
	db 7,$54,$42,$43,$39,$70,$40,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P069XXXXXXXX"
Player070:							; player 70 of PlayerList, a defence
	db 42,$A3,$23,$44,$3D,$63,$33,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P070XXXXXXXXXXX"
Player071:							; player 71 of PlayerList, a goalie
	db 30,$43,$44,$44,$01,$00,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P071XXXXXXXX"
Player072:							; player 72 of PlayerList, a goalie
	db 37,$33,$32,$22,$01,$00,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P072XXXXXXXX"
Player073:							; player 73 of PlayerList, a forward
	db 25,$84,$35,$34,$37,$95,$43,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P073XXXXXXXXXXX"
Player074:							; player 74 of PlayerList, a forward
	db 26,$64,$34,$35,$2D,$95,$33,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P074XXXXXXXXXXX"
Player075:							; player 75 of PlayerList, a forward
	db 29,$B3,$22,$53,$5A,$74,$42,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P075XXXXXXX"
Player076:							; player 76 of PlayerList, a forward
	db 92,$54,$44,$33,$27,$92,$31,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P076XXXXXXXXXXXXX"
Player077:							; player 77 of PlayerList, a forward
	db 11,$63,$23,$43,$42,$63,$41,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P077XXXXXXXX"
Player078:							; player 78 of PlayerList, a forward
	db 13,$73,$33,$33,$39,$64,$35,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P078XXXXXXXX"
Player079:							; player 79 of PlayerList, a forward
	db 10,$73,$45,$44,$49,$A5,$53,$45	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P079XXXXXXXX"
Player080:							; player 80 of PlayerList, a forward
	db 12,$92,$22,$22,$39,$52,$34,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P080XXXXXXX"
Player081:							; player 81 of PlayerList, a forward
	db 17,$62,$33,$32,$16,$63,$31,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P081XXXXX"
Player082:							; player 82 of PlayerList, a forward
	db 14,$35,$54,$44,$4C,$A4,$43,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P082XXXXXXXXXXX"
Player083:							; player 83 of PlayerList, a forward
	db 15,$71,$12,$22,$3A,$52,$34,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P083XXXXXXXXXXXXX"
Player084:							; player 84 of PlayerList, a forward
	db 22,$82,$22,$12,$38,$52,$23,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P084XXXXXXXX"
Player085:							; player 85 of PlayerList, a defence
	db 21,$72,$21,$22,$26,$31,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P085XXXXXXXXXX"
Player086:							; player 86 of PlayerList, a defence
	db 33,$A5,$44,$34,$37,$92,$53,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P086XXXXXXXXXXX"
Player087:							; player 87 of PlayerList, a defence
	db 6,$95,$43,$43,$36,$92,$32,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P087XXXXXXXXXX"
Player088:							; player 88 of PlayerList, a defence
	db 2,$84,$44,$46,$38,$92,$53,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P088XXXXXXXXXX"
Player089:							; player 89 of PlayerList, a defence
	db 39,$72,$21,$31,$27,$62,$25,$13	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P089XXXXXXXX"
Player090:							; player 90 of PlayerList, a defence
	db 18,$73,$32,$42,$27,$62,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P090XXXXXXXX"
Player091:							; player 91 of PlayerList, a defence
	db 3,$93,$41,$42,$39,$41,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P091XXXXXXXX"
Player092:							; player 92 of PlayerList, a defence
	db 7,$93,$32,$34,$46,$71,$32,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P092XXXXXXXX"
Player093:							; player 93 of PlayerList, a defence
	db 4,$73,$21,$41,$34,$61,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P093XXXXXXX"
Player094:							; player 94 of PlayerList, a defence
	db 5,$83,$21,$42,$39,$71,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P094XXXXXXXXXXX"
Player095:							; player 95 of PlayerList, a goalie
	db 30,$66,$46,$65,$01,$00,$66,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P095XXXXXXX"
Player096:							; player 96 of PlayerList, a goalie
	db 31,$52,$31,$12,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P096XXXXXXXX"
Player097:							; player 97 of PlayerList, a forward
	db 27,$45,$55,$45,$3C,$D5,$52,$53	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P097XXXXXXXXXXX"
Player098:							; player 98 of PlayerList, a forward
	db 22,$84,$43,$43,$47,$62,$42,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P098XXXXXXXXXXX"
Player099:							; player 99 of PlayerList, a forward
	db 12,$63,$23,$53,$47,$A3,$51,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P099XXXXXXXX"
Player100:							; player 100 of PlayerList, a forward
	db 11,$72,$33,$12,$26,$62,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P100XXXXXXXX"
Player101:							; player 101 of PlayerList, a forward
	db 32,$73,$32,$23,$19,$62,$32,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P101XXXXXXXXXXX"
Player102:							; player 102 of PlayerList, a forward
	db 14,$74,$43,$43,$29,$63,$33,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P102XXXXXXXXXX"
Player103:							; player 103 of PlayerList, a forward
	db 16,$84,$33,$32,$25,$64,$33,$12	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P103XXXXXXXXXX"
Player104:							; player 104 of PlayerList, a forward
	db 19,$62,$32,$33,$39,$72,$35,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P104XXXXXXXXXXXXX"
Player105:							; player 105 of PlayerList, a forward
	db 44,$A3,$33,$23,$39,$63,$52,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P105XXXXXXXXXXX"
Player106:							; player 106 of PlayerList, a forward
	db 20,$91,$12,$11,$36,$24,$13,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P106XXXXXXXX"
Player107:							; player 107 of PlayerList, a forward
	db 33,$84,$33,$53,$48,$72,$45,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P107XXXXXXXX"
Player108:							; player 108 of PlayerList, a forward
	db 10,$64,$54,$34,$1D,$63,$45,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P108XXXXXXXX"
Player109:							; player 109 of PlayerList, a forward
	db 15,$73,$32,$41,$2A,$42,$44,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P109XXXXXXXX"
Player110:							; player 110 of PlayerList, a forward
	db 17,$74,$54,$34,$3B,$73,$43,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P110XXXXXXX"
Player111:							; player 111 of PlayerList, a defence
	db 2,$A3,$43,$33,$39,$62,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P111XXXXXXXXXX"
Player112:							; player 112 of PlayerList, a defence
	db 7,$74,$44,$65,$4A,$A2,$62,$45	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P112XXXXXXXXXX"
Player113:							; player 113 of PlayerList, a defence
	db 5,$B4,$43,$43,$47,$72,$52,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P113XXXXXXXX"
Player114:							; player 114 of PlayerList, a defence
	db 23,$73,$31,$32,$38,$70,$44,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P114XXXXXXXXXXX"
Player115:							; player 115 of PlayerList, a defence
	db 4,$92,$32,$12,$39,$62,$14,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P115XXXXXXXX"
Player116:							; player 116 of PlayerList, a defence
	db 3,$A1,$11,$10,$16,$21,$14,$05	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P116XXXXXXX"
Player117:							; player 117 of PlayerList, a defence
	db 6,$75,$44,$44,$47,$A2,$52,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P117XXXXXXX"
Player118:							; player 118 of PlayerList, a defence
	db 8,$53,$31,$32,$39,$51,$35,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P118XXXXXXXX"
Player143:							; player 143 of PlayerList, a goalie
	db 35,$33,$44,$33,$01,$00,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P143XXXXXXXX"
Player144:							; player 144 of PlayerList, a goalie
	db 30,$34,$33,$43,$01,$00,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P144XXXXXXXX"
Player145:							; player 145 of PlayerList, a forward
	db 19,$66,$56,$44,$18,$C4,$61,$51	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P145XXXXXXXXXX"
Player146:							; player 146 of PlayerList, a forward
	db 91,$76,$66,$54,$2B,$C5,$52,$53	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P146XXXXXXXXXXX"
Player147:							; player 147 of PlayerList, a forward
	db 55,$B2,$24,$33,$39,$75,$32,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P147XXXXXXXXXX"
Player148:							; player 148 of PlayerList, a forward
	db 33,$73,$42,$42,$29,$62,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P148XXXXXXXX"
Player149:							; player 149 of PlayerList, a forward
	db 23,$63,$33,$22,$29,$62,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P149XXXXXXXX"
Player150:							; player 150 of PlayerList, a forward
	db 13,$54,$34,$23,$1B,$94,$35,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P150XXXXXXXXXXX"
Player151:							; player 151 of PlayerList, a forward
	db 11,$62,$22,$42,$37,$72,$31,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P151XXXXXXX"
Player152:							; player 152 of PlayerList, a forward
	db 24,$B4,$32,$23,$49,$52,$42,$36	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P152XXXXXXXX"
Player153:							; player 153 of PlayerList, a forward
	db 27,$72,$22,$22,$27,$63,$32,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P153XXXXXXXXXXX"
Player154:							; player 154 of PlayerList, a forward
	db 12,$73,$32,$22,$27,$62,$40,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P154XXXXXXXXXXX"
Player155:							; player 155 of PlayerList, a forward
	db 22,$55,$35,$25,$26,$75,$43,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P155XXXXXXXXXXX"
Player156:							; player 156 of PlayerList, a forward
	db 26,$62,$25,$13,$18,$65,$34,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P156XXXXXXXX"
Player157:							; player 157 of PlayerList, a forward
	db 25,$A2,$22,$32,$4A,$52,$43,$26	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P157XXXXXXXXXXXXX"
Player158:							; player 158 of PlayerList, a forward
	db 15,$43,$52,$22,$18,$33,$25,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P158XXXXXXXXXXX"
Player159:							; player 159 of PlayerList, a defence
	db 29,$73,$21,$33,$19,$31,$22,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P159XXXXXXXXXX"
Player160:							; player 160 of PlayerList, a defence
	db 77,$96,$54,$34,$2B,$C2,$51,$63	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P160XXXXXXXX"
Player161:							; player 161 of PlayerList, a defence
	db 3,$93,$34,$44,$3B,$72,$42,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P161XXXXXXXXXXX"
Player162:							; player 162 of PlayerList, a defence
	db 2,$A1,$21,$32,$37,$41,$30,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P162XXXXXXXXXX"
Player163:							; player 163 of PlayerList, a defence
	db 5,$54,$33,$44,$2B,$61,$42,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P163XXXXXXXXXXXXX"
Player164:							; player 164 of PlayerList, a defence
	db 4,$63,$23,$43,$23,$61,$30,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P164XXXXXXX"
Player165:							; player 165 of PlayerList, a defence
	db 16,$64,$42,$43,$4A,$71,$42,$35	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P165XXXXXXXXXXXXXXXX"
Player166:							; player 166 of PlayerList, a defence
	db 21,$91,$21,$22,$37,$42,$32,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P166XXXXXXXX"
Player167:							; player 167 of PlayerList, a goalie
	db 30,$45,$34,$35,$01,$00,$44,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P167XXXXXXXX"
Player168:							; player 168 of PlayerList, a goalie
	db 31,$52,$22,$22,$01,$00,$21,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P168XXXXXXXXXXX"
Player169:							; player 169 of PlayerList, a forward
	db 39,$63,$34,$33,$3D,$A3,$32,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P169XXXXXXXX"
Player170:							; player 170 of PlayerList, a forward
	db 36,$74,$42,$23,$02,$63,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P170XXXXXXXXXX"
Player171:							; player 171 of PlayerList, a forward
	db 7,$83,$34,$44,$3A,$A4,$33,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P171XXXXXXXX"
Player172:							; player 172 of PlayerList, a forward
	db 37,$73,$42,$43,$29,$62,$32,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P172XXXXXXXXXXX"
Player173:							; player 173 of PlayerList, a forward
	db 17,$93,$31,$32,$27,$42,$32,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P173XXXXXXXXXX"
Player174:							; player 174 of PlayerList, a forward
	db 25,$63,$32,$22,$2A,$62,$25,$30	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P174XXXXXXXXXXX"
Player175:							; player 175 of PlayerList, a forward
	db 34,$93,$42,$23,$39,$74,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P175XXXXXXXX"
Player176:							; player 176 of PlayerList, a forward
	db 9,$93,$33,$44,$47,$73,$43,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P176XXXXXXXXXX"
Player177:							; player 177 of PlayerList, a forward
	db 29,$C1,$12,$12,$37,$53,$15,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P177XXXXXXXXXXX"
Player178:							; player 178 of PlayerList, a forward
	db 33,$93,$31,$22,$35,$42,$31,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P178XXXXXXXXXX"
Player179:							; player 179 of PlayerList, a forward
	db 8,$73,$33,$34,$2D,$64,$32,$30	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P179XXXXXXXX"
Player180:							; player 180 of PlayerList, a forward
	db 12,$B2,$23,$22,$27,$42,$22,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P180XXXXXXXX"
Player181:							; player 181 of PlayerList, a forward
	db 26,$92,$23,$22,$27,$34,$25,$12	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P181XXXXXXXX"
Player182:							; player 182 of PlayerList, a forward
	db 18,$73,$22,$32,$38,$72,$43,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P182XXXXXXXX"
Player183:							; player 183 of PlayerList, a forward
	db 16,$A3,$32,$32,$4C,$72,$32,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P183XXXXXXXXXXXXX"
Player184:							; player 184 of PlayerList, a defence
	db 10,$73,$23,$22,$07,$63,$22,$40	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P184XXXXXXXX"
Player185:							; player 185 of PlayerList, a defence
	db 21,$95,$33,$44,$3B,$92,$43,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P185XXXXXXXXXX"
Player186:							; player 186 of PlayerList, a defence
	db 15,$94,$34,$34,$18,$92,$31,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P186XXXXXXXXXXXXX"
Player187:							; player 187 of PlayerList, a defence
	db 35,$92,$21,$21,$26,$40,$13,$12	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P187XXXXXXXX"
Player188:							; player 188 of PlayerList, a defence
	db 2,$93,$32,$33,$3A,$72,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P188XXXXXXX"
Player189:							; player 189 of PlayerList, a defence
	db 22,$B3,$31,$32,$49,$70,$24,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P189XXXXXXXXXXX"
Player190:							; player 190 of PlayerList, a defence
	db 20,$64,$32,$23,$38,$71,$23,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P190XXXXXXXXXX"
Player191:							; player 191 of PlayerList, a goalie
	db 34,$54,$34,$53,$01,$00,$44,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P191XXXXXXXXXXX"
Player192:							; player 192 of PlayerList, a goalie
	db 30,$73,$42,$23,$01,$00,$34,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P192XXXXXXXXXXX"
Player193:							; player 193 of PlayerList, a forward
	db 20,$84,$32,$52,$49,$73,$43,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P193XXXXXXXXXXX"
Player194:							; player 194 of PlayerList, a forward
	db 14,$52,$34,$33,$28,$93,$34,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P194XXXXXXX"
Player195:							; player 195 of PlayerList, a forward
	db 44,$94,$52,$23,$37,$73,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P195XXXXXXXXXXX"
Player196:							; player 196 of PlayerList, a forward
	db 26,$53,$44,$33,$28,$94,$32,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P196XXXXXXXXXXX"
Player197:							; player 197 of PlayerList, a forward
	db 21,$82,$32,$33,$3A,$63,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P197XXXXXXXXXXX"
Player198:							; player 198 of PlayerList, a forward
	db 18,$73,$22,$33,$39,$72,$32,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P198XXXXXXX"
Player199:							; player 199 of PlayerList, a forward
	db 10,$82,$33,$32,$3B,$72,$34,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P199XXXXXXX"
Player200:							; player 200 of PlayerList, a forward
	db 19,$74,$33,$33,$19,$93,$32,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P200XXXXXXXXXXX"
Player201:							; player 201 of PlayerList, a forward
	db 11,$61,$22,$32,$2D,$41,$23,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P201XXXXXXXX"
Player202:							; player 202 of PlayerList, a forward
	db 23,$92,$21,$22,$29,$33,$24,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P202XXXXXXXX"
Player203:							; player 203 of PlayerList, a forward
	db 12,$92,$22,$32,$34,$32,$33,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P203XXXXXXX"
Player204:							; player 204 of PlayerList, a forward
	db 27,$91,$13,$33,$4A,$74,$33,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P204XXXXXXXXXXX"
Player205:							; player 205 of PlayerList, a forward
	db 22,$92,$34,$34,$2C,$64,$34,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P205XXXXXXXX"
Player206:							; player 206 of PlayerList, a forward
	db 17,$82,$22,$32,$42,$43,$34,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P206XXXXXXXX"
Player207:							; player 207 of PlayerList, a defence
	db 7,$83,$23,$23,$27,$62,$42,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P207XXXXXXXXXX"
Player208:							; player 208 of PlayerList, a defence
	db 25,$94,$31,$31,$24,$91,$32,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P208XXXXXXXX"
Player209:							; player 209 of PlayerList, a defence
	db 24,$A2,$21,$33,$47,$52,$33,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P209XXXXXXXXXX"
Player210:							; player 210 of PlayerList, a defence
	db 5,$85,$43,$34,$3C,$62,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P210XXXXXXXX"
Player211:							; player 211 of PlayerList, a defence
	db 2,$A2,$21,$33,$36,$42,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P211XXXXXXXX"
Player212:							; player 212 of PlayerList, a defence
	db 3,$93,$20,$22,$46,$21,$33,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P212XXXXXXX"
Player213:							; player 213 of PlayerList, a defence
	db 4,$72,$22,$32,$34,$41,$34,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P213XXXXXXXX"
Player214:							; player 214 of PlayerList, a defence
	db 6,$93,$33,$22,$29,$92,$33,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P214XXXXXXXXXXX"
Player215:							; player 215 of PlayerList, a goalie
	db 1,$A4,$32,$23,$01,$00,$33,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P215XXXXXXX"
Player216:							; player 216 of PlayerList, a goalie
	db 35,$42,$33,$22,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P216XXXXXXX"
Player217:							; player 217 of PlayerList, a goalie
	db 40,$63,$31,$13,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P217XXXXXXXXXXXXX"
Player218:							; player 218 of PlayerList, a forward
	db 21,$73,$34,$42,$2B,$33,$41,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P218XXXXXXXXXXX"
Player219:							; player 219 of PlayerList, a forward
	db 22,$B3,$22,$43,$4D,$73,$41,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P219XXXXXXXXXX"
Player220:							; player 220 of PlayerList, a forward
	db 17,$74,$42,$32,$35,$92,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P220XXXXXXX"
Player221:							; player 221 of PlayerList, a forward
	db 32,$53,$43,$23,$17,$63,$32,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P221XXXXXXXXXX"
Player222:							; player 222 of PlayerList, a forward
	db 89,$64,$44,$34,$27,$92,$43,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P222XXXXXXXXXXX"
Player223:							; player 223 of PlayerList, a forward
	db 8,$64,$54,$34,$2B,$64,$43,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P223XXXXXXXXXXX"
Player224:							; player 224 of PlayerList, a forward
	db 26,$83,$32,$33,$35,$32,$25,$30	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P224XXXXXXXX"
Player225:							; player 225 of PlayerList, a forward
	db 20,$B3,$32,$32,$39,$33,$42,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P225XXXXXXXX"
Player226:							; player 226 of PlayerList, a forward
	db 24,$93,$32,$32,$39,$72,$43,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P226XXXXXXX"
Player227:							; player 227 of PlayerList, a forward
	db 23,$94,$43,$34,$3B,$72,$33,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P227XXXXXXXXXXX"
Player228:							; player 228 of PlayerList, a forward
	db 14,$84,$53,$33,$1A,$62,$34,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P228XXXXXXXX"
Player229:							; player 229 of PlayerList, a forward
	db 16,$73,$44,$34,$3C,$A4,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P229XXXXXXXX"
Player230:							; player 230 of PlayerList, a forward
	db 41,$B1,$22,$33,$24,$42,$33,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P230XXXXXXXX"
Player231:							; player 231 of PlayerList, a forward
	db 18,$53,$43,$42,$29,$93,$33,$30	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P231XXXXXXXX"
Player232:							; player 232 of PlayerList, a defence
	db 27,$83,$32,$42,$47,$41,$32,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P232XXXXXXXXXXX"
Player233:							; player 233 of PlayerList, a defence
	db 5,$A2,$32,$32,$39,$72,$35,$12	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P233XXXXXXXXXXXXXXX"
Player234:							; player 234 of PlayerList, a defence
	db 6,$74,$32,$34,$47,$71,$43,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P234XXXXXXX"
Player235:							; player 235 of PlayerList, a defence
	db 10,$83,$21,$42,$44,$30,$31,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P235XXXXXXXXXXXXX"
Player236:							; player 236 of PlayerList, a defence
	db 4,$93,$32,$43,$29,$61,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P236XXXXXXXXXXX"
Player237:							; player 237 of PlayerList, a defence
	db 44,$73,$33,$32,$3B,$A2,$33,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P237XXXXXXXXXX"
Player238:							; player 238 of PlayerList, a defence
	db 33,$73,$32,$32,$28,$72,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P238XXXXXXXX"
Player239:							; player 239 of PlayerList, a goalie
	db 32,$63,$33,$43,$01,$00,$22,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P239XXXXXXXX"
Player240:							; player 240 of PlayerList, a goalie
	db 35,$62,$34,$43,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P240XXXXXXXX"
Player241:							; player 241 of PlayerList, a forward
	db 99,$46,$46,$43,$19,$C4,$61,$60	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P241XXXXXXXXXX"
Player242:							; player 242 of PlayerList, a forward
	db 13,$63,$33,$22,$16,$64,$32,$40	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P242XXXXXXXX"
Player243:							; player 243 of PlayerList, a forward
	db 14,$52,$33,$33,$27,$42,$33,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P243XXXXXXX"
Player244:							; player 244 of PlayerList, a forward
	db 26,$83,$31,$32,$3B,$33,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P244XXXXXXXXXXXXXXX"
Player245:							; player 245 of PlayerList, a forward
	db 15,$72,$22,$32,$29,$63,$24,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P245XXXXXXXX"
Player246:							; player 246 of PlayerList, a forward
	db 20,$74,$45,$35,$2B,$96,$54,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P246XXXXXXXXXXX"
Player247:							; player 247 of PlayerList, a forward
	db 10,$73,$22,$11,$3B,$52,$14,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P247XXXXXXXXXX"
Player248:							; player 248 of PlayerList, a forward
	db 11,$64,$43,$32,$3B,$63,$43,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P248XXXXXXXXXX"
Player249:							; player 249 of PlayerList, a forward
	db 17,$84,$34,$44,$2B,$94,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P249XXXXXXX"
Player250:							; player 250 of PlayerList, a forward
	db 21,$64,$54,$43,$36,$A4,$33,$35	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P250XXXXXXXX"
Player251:							; player 251 of PlayerList, a forward
	db 9,$93,$33,$33,$38,$64,$31,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P251XXXXXXX"
Player252:							; player 252 of PlayerList, a forward
	db 14,$62,$22,$11,$26,$32,$13,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P252XXXXXXXX"
Player253:							; player 253 of PlayerList, a forward
	db 19,$92,$23,$42,$36,$33,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P253XXXXXXX"
Player254:							; player 254 of PlayerList, a defence
	db 4,$A4,$44,$44,$4A,$A2,$43,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P254XXXXXXX"
Player255:							; player 255 of PlayerList, a defence
	db 33,$C2,$22,$43,$47,$82,$54,$36	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P255XXXXXXXXXXXXX"
Player256:							; player 256 of PlayerList, a defence
	db 2,$65,$43,$33,$3B,$92,$41,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P256XXXXXXXX"
Player257:							; player 257 of PlayerList, a defence
	db 25,$94,$33,$23,$3D,$A1,$33,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P257XXXXXXXX"
Player258:							; player 258 of PlayerList, a defence
	db 22,$A3,$22,$43,$39,$72,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P258XXXXXXXXXX"
Player259:							; player 259 of PlayerList, a defence
	db 7,$82,$31,$22,$27,$31,$31,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P259XXXXX"
Player260:							; player 260 of PlayerList, a defence
	db 6,$72,$21,$22,$36,$31,$24,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P260XXXXXXX"
Player261:							; player 261 of PlayerList, a defence
	db 5,$62,$21,$21,$25,$10,$21,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P261XXXXXXXX"
Player119:							; player 119 of PlayerList, a goalie
	db 35,$43,$31,$23,$01,$00,$32,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P119XXXXXXX"
Player120:							; player 120 of PlayerList, a goalie
	db 34,$63,$33,$34,$01,$00,$33,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P120XXXXXXXXXX"
Player121:							; player 121 of PlayerList, a forward
	db 9,$75,$56,$45,$29,$C4,$53,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P121XXXXXXXX"
Player122:							; player 122 of PlayerList, a forward
	db 15,$64,$44,$33,$29,$94,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P122XXXXXXXX"
Player123:							; player 123 of PlayerList, a forward
	db 7,$43,$43,$53,$29,$62,$42,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P123XXXXXXXX"
Player124:							; player 124 of PlayerList, a forward
	db 10,$82,$21,$32,$34,$72,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P124XXXXXXX"
Player125:							; player 125 of PlayerList, a forward
	db 16,$62,$22,$32,$2A,$73,$31,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P125XXXXXXXX"
Player126:							; player 126 of PlayerList, a forward
	db 29,$93,$33,$22,$18,$63,$33,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P126XXXXXXXX"
Player127:							; player 127 of PlayerList, a forward
	db 6,$55,$34,$33,$25,$93,$40,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P127XXXXXXXX"
Player128:							; player 128 of PlayerList, a forward
	db 41,$64,$33,$23,$39,$73,$25,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P128XXXXXXXXXXX"
Player129:							; player 129 of PlayerList, a forward
	db 17,$94,$33,$43,$4B,$73,$44,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P129XXXXXXXXXX"
Player130:							; player 130 of PlayerList, a forward
	db 23,$93,$22,$33,$38,$51,$34,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P130XXXXX"
Player131:							; player 131 of PlayerList, a forward
	db 27,$92,$22,$21,$48,$52,$21,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P131XXXXXXXX"
Player132:							; player 132 of PlayerList, a forward
	db 20,$63,$33,$23,$36,$73,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P132XXXXXXX"
Player133:							; player 133 of PlayerList, a forward
	db 30,$62,$22,$22,$28,$43,$24,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P133XXXXXXXX"
Player134:							; player 134 of PlayerList, a forward
	db 26,$65,$64,$34,$2C,$93,$43,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P134XXXXXXXXXXX"
Player135:							; player 135 of PlayerList, a forward
	db 21,$72,$22,$41,$26,$62,$33,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P135XXXXXXXX"
Player136:							; player 136 of PlayerList, a defence
	db 5,$84,$32,$32,$35,$71,$32,$35	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P136XXXXXXXX"
Player137:							; player 137 of PlayerList, a defence
	db 24,$93,$33,$44,$57,$73,$43,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P137XXXXXXXX"
Player138:							; player 138 of PlayerList, a defence
	db 2,$93,$22,$42,$4B,$72,$42,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P138XXXXXXXXXXX"
Player139:							; player 139 of PlayerList, a defence
	db 3,$C2,$21,$42,$3B,$40,$33,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P139XXXXXXXX"
Player140:							; player 140 of PlayerList, a defence
	db 4,$73,$31,$33,$39,$31,$35,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P140XXXXXXXXXXXXXXX"
Player141:							; player 141 of PlayerList, a defence
	db 12,$94,$33,$31,$39,$60,$22,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P141XXXXXXXXXX"
Player142:							; player 142 of PlayerList, a defence
	db 14,$A3,$32,$43,$39,$62,$35,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P142XXXXXXXXXXX"
Player262:							; player 262 of PlayerList, a goalie
	db 33,$66,$43,$55,$01,$00,$56,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P262XXXXXXXX"
Player263:							; player 263 of PlayerList, a goalie
	db 1,$22,$32,$31,$01,$00,$11,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P263XXXXXXXX"
Player264:							; player 264 of PlayerList, a forward
	db 11,$94,$44,$44,$4B,$A3,$41,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P264XXXXXXXX"
Player265:							; player 265 of PlayerList, a forward
	db 17,$B3,$43,$35,$39,$62,$31,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P265XXXXXXXX"
Player266:							; player 266 of PlayerList, a forward
	db 21,$64,$32,$52,$48,$61,$42,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P266XXXXXXXXXXX"
Player267:							; player 267 of PlayerList, a forward
	db 15,$63,$33,$23,$28,$62,$32,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P267XXXXXXXXXXX"
Player268:							; player 268 of PlayerList, a forward
	db 8,$63,$22,$41,$27,$32,$42,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P268XXXXXXX"
Player269:							; player 269 of PlayerList, a forward
	db 45,$83,$24,$22,$39,$94,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P269XXXXXXXXXXX"
Player270:							; player 270 of PlayerList, a forward
	db 25,$64,$45,$24,$1D,$C5,$42,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P270XXXXXXXXXXXXXXX"
Player271:							; player 271 of PlayerList, a forward
	db 22,$62,$23,$22,$23,$23,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P271XXXXXXXXXX"
Player272:							; player 272 of PlayerList, a forward
	db 32,$61,$11,$12,$37,$42,$13,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P272XXXXXXXXXX"
Player273:							; player 273 of PlayerList, a forward
	db 20,$72,$22,$12,$17,$72,$12,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P273XXXXXXXXXXX"
Player274:							; player 274 of PlayerList, a forward
	db 12,$53,$43,$42,$4A,$62,$40,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P274XXXXXXX"
Player275:							; player 275 of PlayerList, a forward
	db 23,$84,$44,$24,$29,$94,$43,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P275XXXXXXXXXX"
Player276:							; player 276 of PlayerList, a forward
	db 6,$43,$23,$32,$17,$62,$33,$30	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P276XXXXXXXX"
Player277:							; player 277 of PlayerList, a forward
	db 31,$82,$22,$12,$32,$22,$14,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P277XXXXX"
Player278:							; player 278 of PlayerList, a defence
	db 28,$94,$33,$54,$4C,$72,$43,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P278XXXXXXXXXXX"
Player279:							; player 279 of PlayerList, a defence
	db 27,$74,$44,$44,$27,$62,$43,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P279XXXXXXXXXXX"
Player280:							; player 280 of PlayerList, a defence
	db 43,$53,$23,$33,$26,$63,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P280XXXXXXXXXXXXXXX"
Player281:							; player 281 of PlayerList, a defence
	db 14,$63,$22,$32,$27,$72,$45,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P281XXXXXXXX"
Player282:							; player 282 of PlayerList, a defence
	db 44,$81,$12,$11,$27,$60,$10,$11	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P282XXXXXXXXXX"
Player283:							; player 283 of PlayerList, a defence
	db 48,$64,$32,$33,$17,$62,$42,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P283XXXXXXXXXXX"
Player284:							; player 284 of PlayerList, a defence
	db 24,$93,$22,$43,$4B,$52,$34,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P284XXXXXXXX"
Player285:							; player 285 of PlayerList, a defence
	db 34,$A2,$21,$23,$36,$61,$22,$11	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P285XXXXXXXXXX"
Player286:							; player 286 of PlayerList, a goalie
	db 31,$24,$44,$43,$01,$00,$44,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P286XXXXXXXXXX"
Player287:							; player 287 of PlayerList, a goalie
	db 30,$75,$33,$44,$01,$00,$55,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P287XXXXXXXXXXX"
Player288:							; player 288 of PlayerList, a forward
	db 20,$63,$23,$33,$26,$93,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P288XXXXXXXXXXX"
Player289:							; player 289 of PlayerList, a forward
	db 9,$63,$24,$43,$28,$93,$41,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P289XXXXXXXXXXX"
Player290:							; player 290 of PlayerList, a forward
	db 10,$43,$54,$22,$14,$94,$32,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P290XXXXXXXX"
Player291:							; player 291 of PlayerList, a forward
	db 19,$73,$22,$42,$29,$31,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P291XXXXXXXXXX"
Player292:							; player 292 of PlayerList, a forward
	db 11,$73,$43,$22,$18,$62,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P292XXXXX"
Player293:							; player 293 of PlayerList, a forward
	db 25,$64,$44,$43,$1B,$94,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P293XXXXXXXXXXXXX"
Player294:							; player 294 of PlayerList, a forward
	db 16,$A2,$32,$24,$38,$62,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P294XXXXXXXX"
Player295:							; player 295 of PlayerList, a forward
	db 21,$63,$22,$33,$4A,$83,$34,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P295XXXXXXXXXX"
Player296:							; player 296 of PlayerList, a forward
	db 17,$94,$43,$32,$3A,$63,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P296XXXXXXXX"
Player297:							; player 297 of PlayerList, a forward
	db 8,$91,$22,$22,$49,$21,$44,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P297XXXXXXXX"
Player298:							; player 298 of PlayerList, a forward
	db 22,$B4,$43,$34,$48,$72,$43,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P298XXXXXXXXXXX"
Player299:							; player 299 of PlayerList, a forward
	db 12,$94,$33,$35,$4A,$74,$35,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P299XXXXXXXX"
Player300:							; player 300 of PlayerList, a forward
	db 15,$93,$25,$44,$38,$73,$45,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P300XXXXXXXXXXX"
Player301:							; player 301 of PlayerList, a forward
	db 44,$94,$44,$35,$2A,$C4,$44,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P301XXXXXXXXXXX"
Player302:							; player 302 of PlayerList, a forward
	db 26,$83,$31,$32,$38,$71,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P302XXXXXXXX"
Player303:							; player 303 of PlayerList, a defence
	db 4,$B4,$44,$64,$5D,$73,$51,$45	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P303XXXXXXXXXX"
Player304:							; player 304 of PlayerList, a defence
	db 2,$B4,$21,$32,$29,$31,$31,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P304XXXXXXXXXXXXX"
Player305:							; player 305 of PlayerList, a defence
	db 23,$64,$33,$42,$3B,$62,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P305XXXXXXXX"
Player306:							; player 306 of PlayerList, a defence
	db 27,$93,$33,$33,$39,$92,$31,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P306XXXXXXXXXXXXX"
Player307:							; player 307 of PlayerList, a defence
	db 3,$A3,$21,$51,$5D,$40,$44,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P307XXXXXXXX"
Player308:							; player 308 of PlayerList, a defence
	db 6,$73,$22,$32,$29,$60,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P308XXXXXXXXXX"
Player309:							; player 309 of PlayerList, a defence
	db 5,$83,$31,$32,$29,$61,$32,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P309XXXXXXXXXXX"
Player310:							; player 310 of PlayerList, a goalie
	db 72,$73,$44,$43,$01,$00,$22,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P310XXXXXXXX"
Player311:							; player 311 of PlayerList, a goalie
	db 29,$73,$32,$22,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P311XXXXXXXXXXXXX"
Player312:							; player 312 of PlayerList, a forward
	db 77,$94,$45,$34,$09,$95,$41,$40	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P312XXXXXXXXXXX"
Player313:							; player 313 of PlayerList, a forward
	db 20,$63,$33,$34,$29,$93,$44,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P313XXXXXXXX"
Player314:							; player 314 of PlayerList, a forward
	db 24,$42,$22,$43,$39,$72,$42,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P314XXXXXXXX"
Player315:							; player 315 of PlayerList, a forward
	db 39,$83,$23,$24,$3A,$62,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P315XXXXXXXX"
Player316:							; player 316 of PlayerList, a forward
	db 10,$83,$22,$11,$33,$63,$15,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P316XXXXXXXXXXX"
Player317:							; player 317 of PlayerList, a forward
	db 33,$74,$54,$33,$19,$64,$41,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P317XXXXXXXX"
Player318:							; player 318 of PlayerList, a forward
	db 18,$43,$33,$42,$2A,$64,$30,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P318XXXXXXXXXXX"
Player319:							; player 319 of PlayerList, a forward
	db 27,$93,$24,$14,$09,$65,$44,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P319XXXXXXX"
Player320:							; player 320 of PlayerList, a forward
	db 8,$81,$11,$12,$37,$50,$14,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P320XXXXXXXX"
Player321:							; player 321 of PlayerList, a forward
	db 25,$64,$43,$22,$12,$62,$45,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P321XXXXXXX"
Player322:							; player 322 of PlayerList, a forward
	db 32,$64,$44,$34,$49,$74,$42,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P322XXXXXXXX"
Player323:							; player 323 of PlayerList, a forward
	db 15,$B2,$22,$31,$36,$64,$21,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P323XXXXXXXXXX"
Player324:							; player 324 of PlayerList, a forward
	db 26,$83,$23,$42,$42,$42,$41,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P324XXXXXXXXXXX"
Player325:							; player 325 of PlayerList, a forward
	db 12,$82,$20,$11,$3A,$51,$24,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P325XXXXXXXX"
Player326:							; player 326 of PlayerList, a forward
	db 17,$63,$22,$12,$15,$62,$24,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P326XXXXXXXX"
Player327:							; player 327 of PlayerList, a defence
	db 23,$A4,$34,$34,$29,$62,$43,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P327XXXXXXXXXXXXXXX"
Player328:							; player 328 of PlayerList, a defence
	db 11,$74,$32,$33,$49,$61,$22,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P328XXXXXXXXXXXXXXX"
Player329:							; player 329 of PlayerList, a defence
	db 4,$E3,$23,$34,$26,$62,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P329XXXXXXX"
Player330:							; player 330 of PlayerList, a defence
	db 28,$83,$34,$24,$29,$61,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P330XXXXXXXX"
Player331:							; player 331 of PlayerList, a defence
	db 7,$82,$22,$43,$39,$62,$41,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P331XXXXXXXXXXX"
Player332:							; player 332 of PlayerList, a defence
	db 37,$A1,$12,$12,$27,$41,$11,$13	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P332XXXXXXXX"
Player333:							; player 333 of PlayerList, a defence
	db 47,$94,$20,$23,$35,$71,$25,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P333XXXXXXXXXX"
Player334:							; player 334 of PlayerList, a goalie
	db 35,$75,$43,$44,$01,$00,$55,$55	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P334XXXXXXXX"
Player335:							; player 335 of PlayerList, a goalie
	db 30,$53,$44,$33,$01,$00,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P335XXXXXXXX"
Player336:							; player 336 of PlayerList, a forward
	db 11,$95,$44,$33,$49,$93,$42,$53	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P336XXXXXXXX"
Player337:							; player 337 of PlayerList, a forward
	db 13,$64,$33,$53,$4D,$64,$62,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P337XXXXXXXXXXXXX"
Player338:							; player 338 of PlayerList, a forward
	db 14,$84,$33,$52,$4B,$62,$52,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P338XXXXXXXXXXXXXXX"
Player339:							; player 339 of PlayerList, a forward
	db 27,$76,$54,$25,$2B,$C4,$34,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P339XXXXXXXXXXX"
Player340:							; player 340 of PlayerList, a forward
	db 12,$93,$33,$34,$2A,$63,$34,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P340XXXXXXX"
Player341:							; player 341 of PlayerList, a forward
	db 9,$94,$44,$33,$5D,$73,$45,$35	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P341XXXXXXXX"
Player342:							; player 342 of PlayerList, a forward
	db 19,$82,$22,$22,$3B,$54,$34,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P342XXXXXXXX"
Player343:							; player 343 of PlayerList, a forward
	db 10,$95,$43,$45,$4A,$92,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P343XXXXXXXX"
Player344:							; player 344 of PlayerList, a forward
	db 17,$72,$22,$42,$37,$63,$31,$12	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P344XXXXXXXX"
Player345:							; player 345 of PlayerList, a forward
	db 15,$73,$32,$33,$49,$72,$42,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P345XXXXXXXX"
Player346:							; player 346 of PlayerList, a forward
	db 36,$74,$44,$33,$2B,$63,$41,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P346XXXXXXXXXXX"
Player347:							; player 347 of PlayerList, a forward
	db 32,$83,$33,$42,$3B,$63,$32,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P347XXXXXXXXXXXXX"
Player348:							; player 348 of PlayerList, a forward
	db 28,$74,$44,$64,$4B,$64,$63,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P348XXXXXXXX"
Player349:							; player 349 of PlayerList, a forward
	db 26,$82,$21,$32,$38,$51,$24,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P349XXXXXXX"
Player350:							; player 350 of PlayerList, a forward
	db 16,$73,$34,$44,$3A,$64,$45,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P350XXXXXXXX"
Player351:							; player 351 of PlayerList, a defence
	db 2,$66,$35,$44,$2D,$C2,$52,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P351XXXXXXXX"
Player352:							; player 352 of PlayerList, a defence
	db 25,$63,$32,$32,$38,$62,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P352XXXXXXXXXXX"
Player353:							; player 353 of PlayerList, a defence
	db 21,$74,$45,$44,$3D,$92,$32,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P353XXXXXXXX"
Player354:							; player 354 of PlayerList, a defence
	db 23,$B2,$22,$42,$4A,$71,$30,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P354XXXXXXXXXXX"
Player355:							; player 355 of PlayerList, a defence
	db 4,$83,$32,$42,$39,$61,$31,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P355XXXXXXX"
Player356:							; player 356 of PlayerList, a defence
	db 6,$93,$32,$33,$3A,$61,$41,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P356XXXXXXXX"
Player357:							; player 357 of PlayerList, a defence
	db 24,$A2,$21,$32,$4B,$40,$21,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P357XXXXXXX"
Player358:							; player 358 of PlayerList, a goalie
	db 1,$43,$42,$21,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P358XXXXXXXXXXXXX"
Player359:							; player 359 of PlayerList, a goalie
	db 35,$82,$21,$21,$01,$00,$11,$11	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P359XXXXXXXXXXX"
Player360:							; player 360 of PlayerList, a forward
	db 91,$54,$43,$14,$2D,$A3,$32,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P360XXXXXXXXXXX"
Player361:							; player 361 of PlayerList, a forward
	db 19,$74,$44,$14,$1A,$C4,$32,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P361XXXXXXXXXX"
Player362:							; player 362 of PlayerList, a forward
	db 33,$84,$32,$42,$44,$71,$35,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P362XXXXXXXX"
Player363:							; player 363 of PlayerList, a forward
	db 61,$94,$44,$24,$05,$33,$35,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P363XXXXXXXXXXX"
Player364:							; player 364 of PlayerList, a forward
	db 15,$73,$23,$33,$17,$63,$35,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P364XXXXXXXXXXX"
Player365:							; player 365 of PlayerList, a forward
	db 10,$62,$21,$22,$25,$31,$24,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P365XXXXXXXX"
Player366:							; player 366 of PlayerList, a forward
	db 18,$72,$22,$22,$29,$53,$24,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P366XXXXXXXXXX"
Player367:							; player 367 of PlayerList, a forward
	db 16,$82,$22,$12,$27,$62,$24,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P367XXXXXXX"
Player368:							; player 368 of PlayerList, a forward
	db 27,$83,$42,$32,$39,$72,$53,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P368XXXXXXXX"
Player369:							; player 369 of PlayerList, a forward
	db 17,$73,$23,$32,$36,$63,$35,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P369XXXXXXXXXXX"
Player370:							; player 370 of PlayerList, a forward
	db 20,$92,$23,$23,$24,$62,$21,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P370XXXXXXXXXXX"
Player371:							; player 371 of PlayerList, a forward
	db 11,$65,$43,$24,$18,$63,$35,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P371XXXXXXXXXXX"
Player372:							; player 372 of PlayerList, a forward
	db 26,$92,$22,$12,$26,$32,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P372XXXXXXXX"
Player373:							; player 373 of PlayerList, a forward
	db 24,$61,$12,$02,$02,$32,$22,$10	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P373XXXXXXXXXXX"
Player374:							; player 374 of PlayerList, a defence
	db 21,$92,$11,$32,$49,$51,$34,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P374XXXXXXXX"
Player375:							; player 375 of PlayerList, a defence
	db 24,$83,$22,$32,$45,$31,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P375XXXXXXXXXX"
Player376:							; player 376 of PlayerList, a defence
	db 22,$63,$34,$23,$27,$92,$41,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P376XXXXXXXX"
Player377:							; player 377 of PlayerList, a defence
	db 4,$73,$23,$23,$26,$61,$52,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P377XXXXXXX"
Player378:							; player 378 of PlayerList, a defence
	db 34,$91,$22,$12,$3B,$40,$34,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P378XXXXXXXXXX"
Player379:							; player 379 of PlayerList, a defence
	db 5,$93,$32,$23,$39,$61,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P379XXXXXXXXXX"
Player380:							; player 380 of PlayerList, a defence
	db 55,$93,$21,$22,$26,$61,$22,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P380XXXXXXXXXXXXX"
Player381:							; player 381 of PlayerList, a defence
	db 6,$81,$12,$21,$2A,$30,$25,$13	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P381XXXXXXXX"
Player382:							; player 382 of PlayerList, a goalie
	db 33,$63,$33,$33,$01,$00,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P382XXXXXXXXXXX"
Player383:							; player 383 of PlayerList, a goalie
	db 30,$33,$33,$42,$01,$00,$23,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P383XXXXXXXXXXXXX"
Player384:							; player 384 of PlayerList, a forward
	db 88,$C4,$34,$45,$56,$A6,$53,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P384XXXXXXXX"
Player385:							; player 385 of PlayerList, a forward
	db 17,$94,$34,$44,$3D,$94,$42,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P385XXXXXXXXXXXXX"
Player386:							; player 386 of PlayerList, a forward
	db 22,$64,$32,$42,$3D,$61,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P386XXXXXXX"
Player387:							; player 387 of PlayerList, a forward
	db 14,$62,$31,$32,$29,$32,$31,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P387XXXXXXXX"
Player388:							; player 388 of PlayerList, a forward
	db 20,$72,$32,$32,$36,$62,$42,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P388XXXXXXXX"
Player389:							; player 389 of PlayerList, a forward
	db 18,$83,$33,$33,$28,$63,$31,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P389XXXXXXXX"
Player390:							; player 390 of PlayerList, a forward
	db 19,$74,$35,$34,$3D,$95,$32,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P390XXXXXXXXXXX"
Player391:							; player 391 of PlayerList, a forward
	db 42,$63,$34,$33,$19,$94,$34,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P391XXXXXXXXXX"
Player392:							; player 392 of PlayerList, a forward
	db 36,$72,$22,$22,$29,$64,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P392XXXXXXXX"
Player393:							; player 393 of PlayerList, a forward
	db 8,$65,$45,$34,$3D,$95,$43,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P393XXXXXXXX"
Player394:							; player 394 of PlayerList, a forward
	db 11,$74,$43,$43,$28,$73,$45,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P394XXXXXXXX"
Player395:							; player 395 of PlayerList, a forward
	db 21,$91,$10,$31,$26,$50,$25,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P395XXXXXXX"
Player396:							; player 396 of PlayerList, a forward
	db 15,$52,$22,$32,$28,$62,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P396XXXXXXXX"
Player397:							; player 397 of PlayerList, a defence
	db 3,$73,$33,$42,$3B,$A1,$32,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P397XXXXXXXX"
Player398:							; player 398 of PlayerList, a defence
	db 2,$74,$43,$43,$39,$71,$53,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P398XXXXXXXXXXXXXXX"
Player399:							; player 399 of PlayerList, a defence
	db 28,$A3,$31,$33,$45,$72,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P399XXXXXXXX"
Player400:							; player 400 of PlayerList, a defence
	db 29,$64,$43,$34,$37,$62,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P400XXXXXXXX"
Player401:							; player 401 of PlayerList, a defence
	db 26,$73,$21,$22,$29,$41,$34,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P401XXXXXXXX"
Player402:							; player 402 of PlayerList, a defence
	db 25,$92,$21,$22,$27,$60,$24,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P402XXXXXXXX"
Player403:							; player 403 of PlayerList, a defence
	db 23,$52,$21,$21,$39,$60,$34,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P403XXXXXXXXXXXXX"
Player404:							; player 404 of PlayerList, a defence
	db 5,$92,$21,$33,$46,$41,$34,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P404XXXXXXX"
Player405:							; player 405 of PlayerList, a defence
	db 27,$82,$22,$32,$38,$41,$34,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P405XXXXXXXXXX"
Player406:							; player 406 of PlayerList, a goalie
	db 35,$A4,$45,$54,$00,$00,$43,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P406XXXXXXXX"
Player407:							; player 407 of PlayerList, a goalie
	db 31,$82,$33,$32,$01,$00,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P407XXXXXXXX"
Player408:							; player 408 of PlayerList, a forward
	db 66,$A5,$46,$35,$24,$C6,$61,$62	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P408XXXXXXXXXX"
Player409:							; player 409 of PlayerList, a forward
	db 10,$94,$35,$53,$4B,$93,$51,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P409XXXXXXXX"
Player410:							; player 410 of PlayerList, a forward
	db 15,$73,$43,$34,$1B,$63,$44,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P410XXXXXXXXXXXXXXX"
Player411:							; player 411 of PlayerList, a forward
	db 19,$83,$22,$22,$23,$62,$21,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P411XXXXXXXXXXX"
Player412:							; player 412 of PlayerList, a forward
	db 25,$B3,$35,$25,$3B,$75,$54,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P412XXXXXXXXXX"
Player413:							; player 413 of PlayerList, a forward
	db 7,$64,$34,$33,$3A,$65,$44,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P413XXXXXXX"
Player414:							; player 414 of PlayerList, a forward
	db 82,$53,$44,$33,$1D,$93,$32,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P414XXXXXXXXXX"
Player415:							; player 415 of PlayerList, a forward
	db 33,$A1,$11,$12,$39,$51,$33,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P415XXXXXXXX"
Player416:							; player 416 of PlayerList, a forward
	db 24,$63,$32,$42,$38,$63,$43,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P416XXXXXXX"
Player417:							; player 417 of PlayerList, a forward
	db 22,$92,$34,$34,$46,$74,$33,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P417XXXXXXXX"
Player418:							; player 418 of PlayerList, a forward
	db 68,$A5,$45,$34,$4B,$C3,$61,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P418XXXXXXXX"
Player419:							; player 419 of PlayerList, a forward
	db 17,$94,$45,$35,$27,$63,$44,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P419XXXXXXXXXXX"
Player420:							; player 420 of PlayerList, a forward
	db 29,$64,$32,$23,$29,$62,$22,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P420XXXXXXXXXXX"
Player421:							; player 421 of PlayerList, a defence
	db 2,$74,$32,$22,$39,$72,$23,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P421XXXXXXXX"
Player422:							; player 422 of PlayerList, a defence
	db 28,$E2,$21,$34,$46,$41,$45,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P422XXXXXXXXXXXXX"
Player423:							; player 423 of PlayerList, a defence
	db 5,$84,$42,$43,$5B,$70,$41,$36	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P423XXXXXXXXXXX"
Player424:							; player 424 of PlayerList, a defence
	db 55,$A4,$35,$54,$3C,$92,$51,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P424XXXXXXXX"
Player425:							; player 425 of PlayerList, a defence
	db 32,$91,$21,$33,$44,$40,$44,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P425XXXXXXXXXXXXX"
Player426:							; player 426 of PlayerList, a defence
	db 6,$83,$10,$32,$47,$41,$31,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P426XXXXXXXX"
Player427:							; player 427 of PlayerList, a defence
	db 34,$73,$33,$22,$28,$62,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P427XXXXXXX"
Player428:							; player 428 of PlayerList, a defence
	db 4,$73,$33,$23,$29,$62,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P428XXXXXXXX"
Player429:							; player 429 of PlayerList, a defence
	db 3,$92,$21,$32,$39,$70,$24,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P429XXXXXXXXXXX"
Player430:							; player 430 of PlayerList, a goalie
	db 35,$53,$33,$32,$01,$00,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P430XXXXXXXXXXX"
Player431:							; player 431 of PlayerList, a goalie
	db 41,$53,$32,$22,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P431XXXXXXXXXXXXX"
Player432:							; player 432 of PlayerList, a forward
	db 19,$64,$35,$43,$29,$C5,$52,$62	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P432XXXXXXX"
Player433:							; player 433 of PlayerList, a forward
	db 9,$74,$34,$33,$39,$75,$32,$45	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P433XXXXXXX"
Player434:							; player 434 of PlayerList, a forward
	db 13,$74,$45,$44,$1C,$95,$41,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P434XXXXXXXX"
Player435:							; player 435 of PlayerList, a forward
	db 22,$63,$33,$42,$44,$73,$42,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P435XXXXXXX"
Player436:							; player 436 of PlayerList, a forward
	db 47,$53,$43,$42,$3B,$62,$31,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P436XXXXXXXXXXX"
Player437:							; player 437 of PlayerList, a forward
	db 25,$53,$23,$23,$17,$63,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P437XXXXXXXXXXX"
Player438:							; player 438 of PlayerList, a forward
	db 31,$84,$44,$25,$26,$94,$41,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P438XXXXXXXXXXX"
Player439:							; player 439 of PlayerList, a forward
	db 12,$D2,$11,$21,$37,$51,$05,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P439XXXXXXXX"
Player440:							; player 440 of PlayerList, a forward
	db 15,$A1,$11,$01,$39,$20,$14,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P440XXXXXXX"
Player441:							; player 441 of PlayerList, a forward
	db 38,$73,$33,$33,$27,$63,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P441XXXXXXXX"
Player442:							; player 442 of PlayerList, a forward
	db 17,$73,$42,$32,$27,$33,$23,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P442XXXXXXXXXXX"
Player443:							; player 443 of PlayerList, a forward
	db 28,$44,$32,$22,$3B,$33,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P443XXXXXXX"
Player444:							; player 444 of PlayerList, a forward
	db 11,$83,$44,$25,$26,$25,$43,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P444XXXXXXX"
Player445:							; player 445 of PlayerList, a forward
	db 51,$33,$44,$33,$36,$94,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P445XXXXXXXXXXXXX"
Player446:							; player 446 of PlayerList, a forward
	db 48,$73,$53,$45,$18,$63,$34,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P446XXXXXXXX"
Player447:							; player 447 of PlayerList, a defence
	db 55,$92,$31,$42,$56,$81,$43,$35	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P447XXXXXXXXXX"
Player448:							; player 448 of PlayerList, a defence
	db 7,$93,$43,$42,$37,$64,$51,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P448XXXXXXXXXXXXXXX"
Player449:							; player 449 of PlayerList, a defence
	db 5,$63,$33,$33,$37,$63,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P449XXXXXXXXXXX"
Player450:							; player 450 of PlayerList, a defence
	db 27,$93,$33,$22,$19,$63,$25,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P450XXXXXXXX"
Player451:							; player 451 of PlayerList, a defence
	db 59,$82,$22,$32,$36,$42,$33,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P451XXXXXXX"
Player452:							; player 452 of PlayerList, a defence
	db 29,$82,$22,$33,$3B,$72,$34,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P452XXXXXXXX"
Player453:							; player 453 of PlayerList, a defence
	db 2,$64,$33,$24,$28,$92,$33,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P453XXXXXXXX"
Player454:							; player 454 of PlayerList, a goalie
	db 32,$53,$44,$43,$01,$00,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P454XXXXXXXX"
Player455:							; player 455 of PlayerList, a goalie
	db 29,$62,$32,$22,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P455XXXXXXX"
Player456:							; player 456 of PlayerList, a forward
	db 7,$45,$34,$33,$17,$95,$34,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P456XXXXXXXXXX"
Player457:							; player 457 of PlayerList, a forward
	db 27,$73,$43,$33,$29,$63,$32,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P457XXXXXXX"
Player458:							; player 458 of PlayerList, a forward
	db 13,$73,$33,$43,$39,$63,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P458XXXXXXXX"
Player459:							; player 459 of PlayerList, a forward
	db 33,$63,$32,$32,$39,$32,$32,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P459XXXXXXXXXXX"
Player460:							; player 460 of PlayerList, a forward
	db 9,$63,$23,$23,$29,$62,$21,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P460XXXXXXXXXXXXXXX"
Player461:							; player 461 of PlayerList, a forward
	db 12,$65,$42,$42,$47,$62,$45,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P461XXXXXXX"
Player462:							; player 462 of PlayerList, a forward
	db 11,$93,$42,$42,$3D,$63,$45,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P462XXXXXXXXXXX"
Player463:							; player 463 of PlayerList, a forward
	db 10,$63,$33,$32,$1B,$64,$32,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P463XXXXXXXXXXX"
Player464:							; player 464 of PlayerList, a forward
	db 14,$42,$23,$23,$18,$64,$32,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P464XXXXXXXX"
Player465:							; player 465 of PlayerList, a forward
	db 36,$91,$22,$22,$2A,$53,$34,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P465XXXXXXXX"
Player466:							; player 466 of PlayerList, a forward
	db 37,$63,$33,$32,$3C,$63,$44,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P466XXXXXXXX"
Player467:							; player 467 of PlayerList, a forward
	db 22,$84,$34,$34,$3B,$94,$53,$40	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P467XXXXXXX"
Player468:							; player 468 of PlayerList, a forward
	db 17,$74,$44,$23,$1A,$63,$45,$30	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P468XXXXXXXX"
Player469:							; player 469 of PlayerList, a forward
	db 24,$65,$44,$33,$1B,$95,$32,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P469XXXXXXXXXXX"
Player470:							; player 470 of PlayerList, a defence
	db 8,$85,$44,$32,$17,$62,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P470XXXXXXXX"
Player471:							; player 471 of PlayerList, a defence
	db 26,$63,$33,$22,$19,$62,$32,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P471XXXXXXXXXXX"
Player472:							; player 472 of PlayerList, a defence
	db 6,$73,$44,$34,$2B,$94,$42,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P472XXXXXXXXXXX"
Player473:							; player 473 of PlayerList, a defence
	db 41,$41,$23,$32,$28,$62,$23,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P473XXXXXXXX"
Player474:							; player 474 of PlayerList, a defence
	db 44,$A1,$10,$11,$27,$22,$15,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P474XXXXXXXX"
Player475:							; player 475 of PlayerList, a defence
	db 40,$83,$21,$32,$39,$71,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P475XXXXXXXX"
Player476:							; player 476 of PlayerList, a defence
	db 4,$73,$21,$33,$46,$42,$35,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P476XXXXX"
Player477:							; player 477 of PlayerList, a goalie
	db 31,$65,$45,$64,$01,$00,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P477XXXXXXXXXX"
Player478:							; player 478 of PlayerList, a goalie
	db 29,$62,$32,$22,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P478XXXXXXXX"
Player479:							; player 479 of PlayerList, a forward
	db 15,$74,$35,$43,$27,$C4,$40,$60	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P479XXXXXXXX"
Player480:							; player 480 of PlayerList, a forward
	db 26,$94,$34,$33,$37,$94,$32,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P480XXXXXXXXXX"
Player481:							; player 481 of PlayerList, a forward
	db 93,$53,$34,$33,$19,$C5,$43,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P481XXXXXXXX"
Player482:							; player 482 of PlayerList, a forward
	db 10,$73,$23,$22,$2A,$62,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P482XXXXXXXXXXX"
Player483:							; player 483 of PlayerList, a forward
	db 17,$92,$21,$22,$37,$51,$34,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P483XXXXXXXXXX"
Player484:							; player 484 of PlayerList, a forward
	db 19,$A3,$35,$45,$3A,$A5,$42,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P484XXXXXXXXXXXXX"
Player485:							; player 485 of PlayerList, a forward
	db 25,$73,$33,$12,$17,$63,$24,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P485XXXXXXXXXXXXX"
Player486:							; player 486 of PlayerList, a forward
	db 23,$92,$22,$23,$27,$32,$23,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P486XXXXXXXX"
Player487:							; player 487 of PlayerList, a forward
	db 16,$94,$45,$36,$3A,$94,$44,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P487XXXXXXX"
Player488:							; player 488 of PlayerList, a forward
	db 14,$74,$34,$43,$38,$63,$43,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P488XXXXXXXX"
Player489:							; player 489 of PlayerList, a forward
	db 36,$62,$22,$32,$19,$61,$25,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P489XXXXXXXXXXX"
Player490:							; player 490 of PlayerList, a forward
	db 12,$72,$22,$22,$27,$62,$33,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P490XXXXXXXXXXX"
Player491:							; player 491 of PlayerList, a forward
	db 38,$72,$22,$32,$29,$61,$30,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P491XXXXXXXX"
Player492:							; player 492 of PlayerList, a forward
	db 39,$81,$11,$11,$28,$51,$24,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P492XXXXXXXX"
Player493:							; player 493 of PlayerList, a forward
	db 9,$82,$22,$22,$29,$33,$24,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P493XXXXXXXXXX"
Player494:							; player 494 of PlayerList, a defence
	db 6,$66,$55,$33,$27,$C2,$40,$62	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P494XXXXXXXX"
Player495:							; player 495 of PlayerList, a defence
	db 32,$72,$23,$22,$27,$62,$40,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P495XXXXXXXXXX"
Player496:							; player 496 of PlayerList, a defence
	db 34,$A3,$31,$22,$29,$71,$25,$13	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P496XXXXXXXX"
Player497:							; player 497 of PlayerList, a defence
	db 4,$83,$31,$33,$38,$60,$40,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P497XXXXXXX"
Player498:							; player 498 of PlayerList, a defence
	db 28,$84,$44,$44,$1B,$92,$42,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P498XXXXXXXXXXX"
Player499:							; player 499 of PlayerList, a defence
	db 20,$72,$21,$21,$28,$32,$24,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P499XXXXXXX"
Player500:							; player 500 of PlayerList, a defence
	db 7,$A4,$32,$33,$37,$61,$31,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P500XXXXXXXXXXXXX"
Player502:							; player 502 of PlayerList, a goalie
	db 1,$63,$32,$23,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P502XXXXXXXXXX"
Player501:							; player 501 of PlayerList, a goalie
	db 93,$94,$44,$53,$00,$00,$33,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P501XXXXXXXX"
Player503:							; player 503 of PlayerList, a forward
	db 77,$92,$33,$24,$3D,$72,$33,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P503XXXXXXXXXX"
Player504:							; player 504 of PlayerList, a forward
	db 19,$44,$44,$34,$2A,$64,$42,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P504XXXXXXXXXX"
Player505:							; player 505 of PlayerList, a forward
	db 9,$55,$34,$33,$28,$C3,$30,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P505XXXXXXXX"
Player506:							; player 506 of PlayerList, a forward
	db 28,$72,$22,$32,$28,$62,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P506XXXXXXXX"
Player507:							; player 507 of PlayerList, a forward
	db 17,$62,$22,$32,$47,$42,$31,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P507XXXXXXXXXXX"
Player508:							; player 508 of PlayerList, a forward
	db 24,$73,$33,$33,$2A,$63,$44,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P508XXXXXXXX"
Player509:							; player 509 of PlayerList, a forward
	db 10,$A3,$23,$22,$29,$62,$34,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P509XXXXXXXXXXX"
Player510:							; player 510 of PlayerList, a forward
	db 34,$62,$42,$32,$29,$62,$45,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P510XXXXXXXXXXXXX"
Player511:							; player 511 of PlayerList, a forward
	db 7,$92,$22,$32,$37,$62,$43,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P511XXXXXXXX"
Player512:							; player 512 of PlayerList, a forward
	db 15,$62,$33,$13,$16,$65,$33,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P512XXXXXXXX"
Player513:							; player 513 of PlayerList, a forward
	db 14,$92,$33,$43,$36,$63,$42,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P513XXXXXXXX"
Player514:							; player 514 of PlayerList, a forward
	db 85,$75,$54,$14,$18,$95,$45,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P514XXXXXXX"
Player515:							; player 515 of PlayerList, a forward
	db 12,$91,$11,$11,$28,$21,$24,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P515XXXXXXXX"
Player516:							; player 516 of PlayerList, a defence
	db 23,$A3,$33,$13,$38,$72,$32,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P516XXXXXXXX"
Player517:							; player 517 of PlayerList, a defence
	db 44,$73,$22,$23,$37,$61,$34,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P517XXXXXXXXXX"
Player518:							; player 518 of PlayerList, a defence
	db 22,$92,$23,$32,$27,$62,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P518XXXXXXXXXXX"
Player519:							; player 519 of PlayerList, a defence
	db 25,$62,$32,$32,$1B,$60,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P519XXXXXXXXXX"
Player520:							; player 520 of PlayerList, a defence
	db 20,$A2,$21,$22,$38,$51,$33,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P520XXXXXXXXXX"
Player521:							; player 521 of PlayerList, a defence
	db 39,$92,$11,$21,$29,$21,$34,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P521XXXXXXXXXXX"
Player522:							; player 522 of PlayerList, a defence
	db 3,$82,$11,$21,$29,$11,$24,$14	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P522XXXXXXXX"
Player523:							; player 523 of PlayerList, a goalie
	db 29,$64,$46,$64,$01,$00,$54,$54	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P523XXXXXXXX"
Player524:							; player 524 of PlayerList, a goalie
	db 1,$52,$32,$23,$01,$00,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P524XXXXXXXXXX"
Player525:							; player 525 of PlayerList, a forward
	db 32,$73,$43,$32,$28,$62,$32,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P525XXXXXXXXXX"
Player526:							; player 526 of PlayerList, a forward
	db 93,$45,$45,$54,$4B,$C4,$60,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P526XXXXXXXX"
Player527:							; player 527 of PlayerList, a forward
	db 19,$74,$33,$33,$26,$64,$41,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P527XXXXXXXX"
Player528:							; player 528 of PlayerList, a forward
	db 26,$93,$33,$42,$37,$63,$43,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P528XXXXXXXXXXX"
Player529:							; player 529 of PlayerList, a forward
	db 25,$93,$32,$43,$47,$73,$41,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P529XXXXXXXX"
Player530:							; player 530 of PlayerList, a forward
	db 22,$92,$20,$22,$37,$21,$23,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P530XXXXXXXXXXX"
Player531:							; player 531 of PlayerList, a forward
	db 17,$83,$34,$36,$47,$74,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P531XXXXXXXX"
Player532:							; player 532 of PlayerList, a forward
	db 14,$B3,$25,$34,$3A,$95,$54,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P532XXXXXXXXXXX"
Player533:							; player 533 of PlayerList, a forward
	db 10,$73,$22,$32,$4B,$73,$44,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P533XXXXXXX"
Player534:							; player 534 of PlayerList, a forward
	db 18,$83,$32,$32,$29,$62,$33,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P534XXXXXXXXXXX"
Player535:							; player 535 of PlayerList, a forward
	db 21,$92,$22,$42,$39,$72,$44,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P535XXXXXXXX"
Player536:							; player 536 of PlayerList, a forward
	db 16,$64,$44,$23,$25,$94,$42,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P536XXXXXXXXXXXXXXX"
Player537:							; player 537 of PlayerList, a forward
	db 22,$75,$54,$25,$2C,$63,$55,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P537XXXXXXXX"
Player538:							; player 538 of PlayerList, a forward
	db 12,$62,$23,$33,$24,$73,$45,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P538XXXXXXXX"
Player539:							; player 539 of PlayerList, a defence
	db 23,$63,$33,$32,$35,$62,$41,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P539XXXXXXX"
Player540:							; player 540 of PlayerList, a defence
	db 4,$95,$43,$45,$39,$91,$42,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P540XXXXXXXX"
Player541:							; player 541 of PlayerList, a defence
	db 15,$73,$33,$33,$18,$62,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P541XXXXXXXXXXX"
Player542:							; player 542 of PlayerList, a defence
	db 55,$A2,$22,$32,$38,$42,$31,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P542XXXXXXXXXXXXX"
Player543:							; player 543 of PlayerList, a defence
	db 34,$83,$32,$44,$4B,$71,$44,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P543XXXXXXXX"
Player544:							; player 544 of PlayerList, a defence
	db 3,$A3,$31,$42,$48,$71,$44,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P544XXXXXXX"
Player545:							; player 545 of PlayerList, a defence
	db 2,$92,$21,$31,$3D,$70,$44,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P545XXXXXXXXXXXXX"
Player546:							; player 546 of PlayerList, a defence
	db 33,$72,$22,$22,$29,$62,$32,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P546XXXXXXXX"
Player547:							; player 547 of PlayerList, a goalie
	db 1,$64,$44,$44,$01,$00,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P547XXXXXXXXXX"
Player548:							; player 548 of PlayerList, a goalie
	db 35,$53,$34,$52,$01,$00,$23,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P548XXXXXXXX"
Player549:							; player 549 of PlayerList, a forward
	db 7,$55,$54,$32,$19,$C3,$51,$41	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P549XXXXXXXXXX"
Player550:							; player 550 of PlayerList, a forward
	db 17,$94,$44,$23,$19,$64,$43,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P550XXXXXXXX"
Player551:							; player 551 of PlayerList, a forward
	db 32,$63,$33,$33,$39,$64,$31,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P551XXXXXXXXXX"
Player552:							; player 552 of PlayerList, a forward
	db 15,$72,$21,$32,$37,$71,$42,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P552XXXXXXXXXXX"
Player553:							; player 553 of PlayerList, a forward
	db 14,$75,$54,$44,$1B,$62,$33,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P553XXXXXXXXXXX"
Player554:							; player 554 of PlayerList, a forward
	db 29,$A3,$22,$33,$49,$82,$33,$26	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P554XXXXXXXX"
Player555:							; player 555 of PlayerList, a forward
	db 8,$74,$44,$33,$35,$64,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P555XXXXXXX"
Player556:							; player 556 of PlayerList, a forward
	db 18,$C1,$11,$12,$39,$21,$23,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P556XXXXXXXXXX"
Player557:							; player 557 of PlayerList, a forward
	db 27,$A4,$33,$34,$57,$72,$44,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P557XXXXXXXXXXX"
Player558:							; player 558 of PlayerList, a forward
	db 26,$92,$21,$22,$36,$52,$23,$25	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P558XXXXXXX"
Player559:							; player 559 of PlayerList, a forward
	db 10,$56,$66,$25,$29,$C5,$45,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P559XXXXXXX"
Player560:							; player 560 of PlayerList, a forward
	db 16,$93,$34,$44,$3C,$A4,$43,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P560XXXXXXXXXX"
Player561:							; player 561 of PlayerList, a forward
	db 23,$83,$32,$23,$27,$63,$24,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P561XXXXXXXXXXX"
Player562:							; player 562 of PlayerList, a forward
	db 20,$82,$32,$23,$28,$74,$24,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P562XXXXXXXXXXX"
Player563:							; player 563 of PlayerList, a defence
	db 3,$82,$22,$22,$27,$60,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P563XXXXXXXX"
Player564:							; player 564 of PlayerList, a defence
	db 21,$74,$34,$43,$1B,$91,$41,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P564XXXXXXXX"
Player565:							; player 565 of PlayerList, a defence
	db 22,$94,$34,$45,$26,$93,$51,$52	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P565XXXXXXX"
Player566:							; player 566 of PlayerList, a defence
	db 6,$72,$22,$32,$37,$62,$31,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P566XXXXXXXXXXX"
Player567:							; player 567 of PlayerList, a defence
	db 24,$94,$43,$33,$29,$61,$41,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P567XXXXXXX"
Player568:							; player 568 of PlayerList, a defence
	db 44,$A2,$23,$43,$29,$60,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P568XXXXXXXX"
Player569:							; player 569 of PlayerList, a defence
	db 5,$92,$22,$34,$3B,$61,$44,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P569XXXXXXXX"
Player570:							; player 570 of PlayerList, a defence
	db 4,$94,$41,$32,$48,$71,$32,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P570XXXXXXXXXX"
Player595:							; player 595 of PlayerList, a goalie
	db 29,$63,$44,$43,$01,$00,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P595XXXXXXXXXX"
Player596:							; player 596 of PlayerList, a goalie
	db 1,$42,$22,$20,$10,$22,$12,$00	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P596XXXXXXXXXX"
Player597:							; player 597 of PlayerList, a forward
	db 10,$75,$34,$43,$27,$93,$41,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P597XXXXXXXXXXX"
Player598:							; player 598 of PlayerList, a forward
	db 25,$83,$33,$33,$37,$94,$30,$53	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P598XXXXXXXX"
Player599:							; player 599 of PlayerList, a forward
	db 18,$44,$43,$43,$29,$93,$41,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P599XXXXXXXX"
Player600:							; player 600 of PlayerList, a forward
	db 36,$73,$31,$42,$49,$62,$51,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P600XXXXXXXX"
Player601:							; player 601 of PlayerList, a forward
	db 15,$72,$21,$42,$37,$61,$44,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P601XXXXXXXX"
Player602:							; player 602 of PlayerList, a forward
	db 7,$93,$34,$44,$4D,$A4,$44,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P602XXXXXXXXXX"
Player603:							; player 603 of PlayerList, a forward
	db 17,$A3,$32,$42,$4B,$92,$43,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P603XXXXXXX"
Player604:							; player 604 of PlayerList, a forward
	db 21,$63,$21,$22,$39,$63,$25,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P604XXXXXXXXXX"
Player605:							; player 605 of PlayerList, a forward
	db 34,$93,$23,$33,$3B,$73,$42,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P605XXXXXXXXXXX"
Player606:							; player 606 of PlayerList, a forward
	db 37,$72,$22,$13,$29,$63,$24,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P606XXXXXXXXXXX"
Player607:							; player 607 of PlayerList, a forward
	db 13,$65,$65,$24,$38,$C5,$54,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P607XXXXXXXXXX"
Player608:							; player 608 of PlayerList, a forward
	db 38,$43,$32,$32,$28,$63,$32,$31	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P608XXXXXXXXXXX"
Player609:							; player 609 of PlayerList, a forward
	db 19,$44,$44,$34,$2A,$94,$42,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P609XXXXXXXXXXX"
Player610:							; player 610 of PlayerList, a forward
	db 20,$93,$22,$33,$3A,$83,$41,$26	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P610XXXXX"
Player611:							; player 611 of PlayerList, a defence
	db 6,$72,$22,$13,$29,$31,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P611XXXXXXXXXXX"
Player612:							; player 612 of PlayerList, a defence
	db 24,$92,$10,$12,$39,$30,$33,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P612XXXXXXXXXXX"
Player613:							; player 613 of PlayerList, a defence
	db 27,$74,$33,$33,$36,$62,$41,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P613XXXXXXXXXXX"
Player614:							; player 614 of PlayerList, a defence
	db 4,$B2,$21,$32,$4A,$71,$44,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P614XXXXXXXXXXXXX"
Player615:							; player 615 of PlayerList, a defence
	db 3,$62,$22,$33,$37,$61,$42,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P615XXXXXXXXXX"
Player616:							; player 616 of PlayerList, a defence
	db 5,$93,$22,$42,$48,$60,$40,$24	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P616XXXXXXXX"
Player617:							; player 617 of PlayerList, a defence
	db 3,$94,$43,$25,$49,$81,$54,$34	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P617XXXXXXXX"
Player618:							; player 618 of PlayerList, a defence
	db 26,$92,$21,$32,$38,$40,$44,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P618XXXXXXXX"
Player571:							; player 571 of PlayerList, a goalie
	db 33,$43,$43,$33,$01,$00,$43,$43	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P571XXXXXXXX"
Player572:							; player 572 of PlayerList, a goalie
	db 31,$63,$31,$12,$01,$00,$33,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P572XXXXXXXXXXX"
Player573:							; player 573 of PlayerList, a goalie
	db 35,$42,$21,$02,$01,$00,$22,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P573XXXXXXXX"
Player574:							; player 574 of PlayerList, a forward
	db 17,$94,$44,$33,$2B,$95,$40,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P574XXXXXXXX"
Player575:							; player 575 of PlayerList, a forward
	db 90,$54,$55,$34,$28,$C3,$40,$51	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P575XXXXXXX"
Player576:							; player 576 of PlayerList, a forward
	db 32,$82,$24,$43,$49,$74,$41,$46	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P576XXXXXXXX"
Player577:							; player 577 of PlayerList, a forward
	db 20,$83,$44,$33,$37,$93,$30,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P577XXXXXXXXXXX"
Player578:							; player 578 of PlayerList, a forward
	db 9,$73,$22,$42,$37,$62,$31,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P578XXXXXXXX"
Player579:							; player 579 of PlayerList, a forward
	db 10,$84,$43,$33,$2D,$63,$41,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P579XXXXXXXX"
Player580:							; player 580 of PlayerList, a forward
	db 8,$73,$34,$33,$38,$96,$42,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P580XXXXXXXXXXXXXXX"
Player581:							; player 581 of PlayerList, a forward
	db 27,$92,$22,$12,$3B,$52,$24,$15	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P581XXXXXXXX"
Player582:							; player 582 of PlayerList, a forward
	db 18,$73,$23,$33,$39,$65,$33,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P582XXXXXXXXXXX"
Player583:							; player 583 of PlayerList, a forward
	db 12,$64,$64,$33,$17,$94,$44,$32	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P583XXXXXXXX"
Player584:							; player 584 of PlayerList, a forward
	db 22,$62,$22,$22,$39,$62,$23,$22	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P584XXXXXXXXXXXXX"
Player585:							; player 585 of PlayerList, a forward
	db 21,$62,$42,$32,$29,$42,$35,$12	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P585XXXXXXXX"
Player586:							; player 586 of PlayerList, a forward
	db 26,$72,$33,$32,$48,$73,$32,$35	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P586XXXXXXXX"
Player587:							; player 587 of PlayerList, a forward
	db 14,$84,$33,$23,$14,$63,$34,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P587XXXXXXX"
Player588:							; player 588 of PlayerList, a defence
	db 4,$B3,$34,$45,$58,$72,$44,$44	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P588XXXXXXXXXX"
Player589:							; player 589 of PlayerList, a defence
	db 29,$A3,$22,$32,$3D,$72,$33,$23	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P589XXXXXXX"
Player590:							; player 590 of PlayerList, a defence
	db 3,$63,$33,$43,$3C,$72,$43,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P590XXXXXXXX"
Player591:							; player 591 of PlayerList, a defence
	db 6,$94,$43,$43,$2D,$62,$41,$42	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P591XXXXXXXXXXX"
Player592:							; player 592 of PlayerList, a defence
	db 2,$73,$21,$43,$37,$72,$42,$33	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P592XXXXXXXX"
Player593:							; player 593 of PlayerList, a defence
	db 36,$92,$21,$22,$39,$61,$23,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P593XXXXXXXXXXX"
Player594:							; player 594 of PlayerList, a defence
	db 28,$73,$32,$23,$29,$63,$25,$21	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P594XXXXXXX"
Player662:							; player 662 of PlayerList, a goalie
	db 8,$16,$66,$66,$0C,$E0,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P662XXXXXXXXXXX"
Player663:							; player 663 of PlayerList, a goalie
	db 31,$16,$66,$66,$0C,$E0,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P663XXXXXXXXXX"
Player664:							; player 664 of PlayerList, a goalie
	db 32,$C6,$66,$66,$0C,$E0,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P664XXXXXXXX"
Player665:							; player 665 of PlayerList, a forward
	db 42,$96,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P665XXXXXXXX"
Player666:							; player 666 of PlayerList, a forward
	db 34,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P666XXXXXXX"
Player667:							; player 667 of PlayerList, a forward
	db 88,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P667XXXXXXXX"
Player668:							; player 668 of PlayerList, a forward
	db 43,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P668XXXXXXXXXX"
Player669:							; player 669 of PlayerList, a forward
	db 77,$36,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P669XXXXXXX"
Player670:							; player 670 of PlayerList, a forward
	db 74,$76,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P670XXXXXXXX"
Player671:							; player 671 of PlayerList, a forward
	db 10,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P671XXXXXXXXXXXXX"
Player672:							; player 672 of PlayerList, a forward
	db 11,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P672XXXXXXXXXXXXX"
Player673:							; player 673 of PlayerList, a forward
	db 19,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P673XXXXXXX"
Player674:							; player 674 of PlayerList, a forward
	db 98,$B6,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P674XXXXXXX"
Player675:							; player 675 of PlayerList, a forward
	db 93,$46,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P675XXXXXXX"
Player676:							; player 676 of PlayerList, a forward
	db 4,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P676XXXXXXXXXXXXXXX"
Player677:							; player 677 of PlayerList, a forward
	db 63,$D6,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P677XXXXXXXX"
Player678:							; player 678 of PlayerList, a forward
	db 44,$46,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P678XXXXXXX"
Player679:							; player 679 of PlayerList, a defence
	db 3,$A6,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P679XXXXXXX"
Player680:							; player 680 of PlayerList, a defence
	db 27,$36,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P680XXXXXXXX"
Player681:							; player 681 of PlayerList, a defence
	db 7,$56,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P681XXXXXXX"
Player682:							; player 682 of PlayerList, a defence
	db 99,$46,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P682XXXXXXXXXXX"
Player683:							; player 683 of PlayerList, a defence
	db 55,$16,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P683XXXXXXXXXXX"
Player684:							; player 684 of PlayerList, a defence
	db 91,$86,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P684XXXXXXXX"
Player685:							; player 685 of PlayerList, a defence
	db 17,$56,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P685XXXXXXX"
Player686:							; player 686 of PlayerList, a defence
	db 20,$46,$66,$66,$6C,$E6,$64,$66	; sweater number, then wl,so,dp,ch,ga,ey,tm
	PackedName "P686XXXXXXXX"
AllStarsEast:						; team record 26 (ASE): an All Star team
.0:	dw (22<<11)|(PlayerList+1238)	; 22 players, from PlayerList entry 619
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $77,$20,$00,$E5			; bonus bytes (.sr in 95G teamdata95.asm)
	db 88							; overall rating (shown on the matchup screen)
.godds:	db 204,176					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,21,18,7,4,17,6,0
	db 1,18,19,11,5,14,6,0
	db 1,20,21,12,6,15,7,0
	db 1,22,19,13,7,16,9,0
	db 1,22,19,13,8,17,9,0
	db 1,20,21,12,9,16,7,0
	db 1,20,21,12,10,15,6,0
	db 1,18,19,13,7,14,9,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "All Stars East"
	PackedText "ASE"
	PackedText ""
	PackedText "San Jose Arena"
AllStarsWest:						; team record 27 (ASW): an All Star team
.0:	dw (21<<11)|(PlayerList+1282)	; 21 players, from PlayerList entry 641
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $77,$20,$00,$C6			; bonus bytes (.sr in 95G teamdata95.asm)
	db 88							; overall rating (shown on the matchup screen)
.godds:	db 172,176					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,21,20,8,4,12,9,0
	db 1,16,17,9,4,12,8,0
	db 1,18,19,10,5,13,7,0
	db 1,21,22,11,6,14,8,0
	db 1,21,22,11,7,15,8,0
	db 1,18,19,9,8,14,7,0
	db 1,18,19,10,8,13,6,0
	db 1,16,17,11,6,12,4,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "All Stars West"
	PackedText "ASW"
	PackedText ""
	PackedText "San Jose Arena"
Anaheim:							; team record 0 (ANH)
.0:	dw (23<<11)|(PlayerList+0)		; 23 players, from PlayerList entry 0
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $05,$00,$01,$E7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 58							; overall rating (shown on the matchup screen)
.godds:	db 180,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,21,13,3,8,5,0
	db 1,21,18,13,3,8,5,0
	db 1,19,23,15,5,9,3,0
	db 1,17,22,12,4,11,3,0
	db 1,21,18,5,4,8,3,0
	db 1,19,23,13,3,9,8,0
	db 1,19,23,13,3,8,9,0
	db 1,21,18,15,6,9,3,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Anaheim"
	PackedText "ANH"
	PackedName "N01XXXXXXXXXXXXXXXXXXXXXXXX"
	PackedText "Arrowhead Pond of Anaheim"
Boston:								; team record 1 (BOS)
.0:	dw (24<<11)|(PlayerList+46)		; 24 players, from PlayerList entry 23
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $45,$20,$10,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 77							; overall rating (shown on the matchup screen)
.godds:	db 178,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,20,18,6,3,8,14,0
	db 1,18,21,14,3,8,6,0
	db 1,20,22,15,6,10,3,0
	db 1,19,23,16,7,12,3,0
	db 1,18,20,14,3,8,6,0
	db 1,19,22,15,6,10,3,0
	db 1,18,21,15,3,8,6,0
	db 1,19,23,16,6,10,3,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Boston"
	PackedText "BOS"
	PackedName "N02XX"
	PackedText "Boston Garden"
Buffalo:							; team record 2 (BUF)
.0:	dw (24<<11)|(PlayerList+94)		; 24 players, from PlayerList entry 47
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $53,$20,$10,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 78							; overall rating (shown on the matchup screen)
.godds:	db 91,0						; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,23,19,5,4,14,9,0
	db 1,19,24,9,4,14,5,0
	db 1,20,22,10,5,16,14,0
	db 1,18,23,13,8,15,4,0
	db 1,19,24,9,4,14,5,0
	db 1,21,23,10,5,16,14,0
	db 1,23,24,8,5,16,4,0
	db 1,20,22,9,3,15,5,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Buffalo"
	PackedText "BUF"
	PackedName "N03XX"
	PackedText "Memorial Auditorium"
Calgary:							; team record 3 (CGY)
.0:	dw (24<<11)|(PlayerList+142)	; 24 players, from PlayerList entry 71
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $65,$21,$21,$CA			; bonus bytes (.sr in 95G teamdata95.asm)
	db 77							; overall rating (shown on the matchup screen)
.godds:	db 196,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,16,18,9,3,12,14,0
	db 1,16,18,9,3,14,12,0
	db 1,17,21,8,4,12,3,0
	db 1,19,20,10,5,11,3,0
	db 1,16,18,9,3,12,14,0
	db 1,17,21,8,4,11,3,0
	db 1,16,18,8,12,4,3,0
	db 1,17,21,9,3,7,14,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Calgary"
	PackedText "CGY"
	PackedName "N04XX"
	PackedText "Olympic Saddledome"
Chicago:							; team record 4 (CHI)
.0:	dw (24<<11)|(PlayerList+190)	; 24 players, from PlayerList entry 95
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $23,$10,$11,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 83							; overall rating (shown on the matchup screen)
.godds:	db 196,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,18,9,3,16,14,0
	db 1,19,18,11,3,14,16,0
	db 1,24,23,8,4,16,3,0
	db 1,17,20,9,5,13,3,0
	db 1,18,23,14,3,16,8,0
	db 1,24,19,8,4,13,11,0
	db 1,19,18,4,3,14,11,0
	db 1,24,23,5,13,11,14,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Chicago"
	PackedText "CHI"
	PackedName "N05XXXXXXX"
	PackedText "United Center"
Dallas:								; team record 5 (DAL)
.0:	dw (24<<11)|(PlayerList+238)	; 24 players, from PlayerList entry 119
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $53,$10,$20,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 71							; overall rating (shown on the matchup screen)
.godds:	db 181,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,20,19,4,3,16,8,0
	db 1,19,23,8,3,16,4,0
	db 1,24,20,10,4,14,3,0
	db 1,21,18,11,5,17,3,0
	db 1,19,23,9,3,16,8,0
	db 1,24,20,10,4,14,3,0
	db 1,19,24,11,5,3,16,0
	db 1,21,20,17,7,3,16,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Dallas"
	PackedText "DAL"
	PackedName "N06XX"
	PackedText "Reunion Arena"
Detroit:							; team record 6 (DET)
.0:	dw (24<<11)|(PlayerList+286)	; 24 players, from PlayerList entry 143
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $76,$21,$20,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 79							; overall rating (shown on the matchup screen)
.godds:	db 138,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,19,4,3,13,14,0
	db 1,21,18,5,3,14,4,0
	db 1,19,23,8,4,13,3,0
	db 1,22,20,9,6,7,3,0
	db 1,21,18,5,3,14,4,0
	db 1,19,23,8,4,13,3,0
	db 1,19,23,9,4,3,14,0
	db 1,21,20,5,3,14,4,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Detroit"
	PackedText "DET"
	PackedName "N07XXXXXXXX"
	PackedText "Joe Louis Sports Arena"
Edmonton:							; team record 7 (EDM)
.0:	dw (24<<11)|(PlayerList+334)	; 24 players, from PlayerList entry 167
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $25,$11,$02,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 69							; overall rating (shown on the matchup screen)
.godds:	db 181,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,22,10,3,13,5,0
	db 1,19,24,10,3,14,5,0
	db 1,22,20,13,5,16,3,0
	db 1,23,21,12,7,17,3,0
	db 1,19,20,10,3,14,5,0
	db 1,22,18,13,5,16,3,0
	db 1,23,22,10,3,5,14,0
	db 1,19,24,17,5,3,14,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Edmonton"
	PackedText "EDM"
	PackedName "N08XX"
	PackedText "Northlands Coliseum"
Florida:							; team record 8 (FLA)
.0:	dw (24<<11)|(PlayerList+382)	; 24 players, from PlayerList entry 191
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $12,$00,$00,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 65							; overall rating (shown on the matchup screen)
.godds:	db 196,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,17,20,10,6,15,3,0
	db 1,17,20,10,6,15,3,0
	db 1,23,18,8,3,13,6,0
	db 1,24,21,9,4,14,6,0
	db 1,24,20,10,6,15,3,0
	db 1,17,21,9,4,14,6,0
	db 1,23,21,8,3,10,6,0
	db 1,17,18,13,4,6,3,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Florida"
	PackedText "FLA"
	PackedName "N09XXXXX"
	PackedText "Miami Arena"
Hartford:							; team record 9 (HFD)
.0:	dw (24<<11)|(PlayerList+430)	; 24 players, from PlayerList entry 215
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $11,$02,$02,$E7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 64							; overall rating (shown on the matchup screen)
.godds:	db 196,16					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,23,9,4,15,6,0
	db 1,20,18,9,4,15,6,0
	db 1,19,23,13,6,17,8,0
	db 1,22,24,12,8,14,4,0
	db 1,20,23,9,4,15,6,0
	db 1,22,18,8,6,17,4,0
	db 1,20,23,15,4,9,6,0
	db 1,22,18,10,5,9,6,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Hartford"
	PackedText "HFD"
	PackedName "N10XXX"
	PackedText "Hartford Civic Center"
LosAngeles:							; team record 10 (LA)
.0:	dw (23<<11)|(PlayerList+478)	; 23 players, from PlayerList entry 239
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $46,$21,$02,$D8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 73							; overall rating (shown on the matchup screen)
.godds:	db 168,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,17,16,8,3,11,4,0
	db 1,19,17,10,3,11,4,0
	db 1,18,23,8,4,15,3,0
	db 1,21,20,7,5,12,3,0
	db 1,19,17,8,3,11,4,0
	db 1,18,20,10,4,12,3,0
	db 1,20,17,7,11,3,8,0
	db 1,19,21,10,3,11,8,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Los Angeles"
	PackedText "LA"
	PackedName "N11XX"
	PackedText "Great Western Forum"
Montreal:							; team record 11 (MTL)
.0:	dw (24<<11)|(PlayerList+524)	; 24 players, from PlayerList entry 262
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $36,$20,$21,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 76							; overall rating (shown on the matchup screen)
.godds:	db 211,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,17,9,3,14,4,0
	db 1,24,17,9,3,14,4,0
	db 1,18,23,8,4,13,3,0
	db 1,21,19,10,5,15,3,0
	db 1,18,17,9,3,14,4,0
	db 1,21,19,8,6,13,3,0
	db 1,24,17,10,5,3,9,0
	db 1,18,23,4,3,9,14,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Montreal"
	PackedText "MTL"
	PackedName "N12XXXXX"
	PackedText "Montreal Forum"
NewJersey:							; team record 12 (NJ)
.0:	dw (24<<11)|(PlayerList+572)	; 24 players, from PlayerList entry 286
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $64,$11,$20,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 73							; overall rating (shown on the matchup screen)
.godds:	db 92,0						; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,21,16,5,15,4,0
	db 1,21,18,16,4,15,5,0
	db 1,20,22,8,5,14,4,0
	db 1,19,23,11,6,13,4,0
	db 1,21,18,16,4,15,5,0
	db 1,20,23,8,5,14,4,0
	db 1,21,18,16,4,15,5,0
	db 1,20,22,11,6,15,4,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "New Jersey"
	PackedText "NJ"
	PackedName "N13XX"
	PackedText "Brendan Byrne Arena"
NewYorkI:							; team record 13 (NYI)
.0:	dw (24<<11)|(PlayerList+620)	; 24 players, from PlayerList entry 310
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $52,$21,$12,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 66							; overall rating (shown on the matchup screen)
.godds:	db 181,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,18,8,3,13,10,0
	db 1,19,20,10,3,13,8,0
	db 1,18,24,8,4,14,3,0
	db 1,21,22,9,6,15,3,0
	db 1,18,20,10,3,13,8,0
	db 1,21,22,8,4,14,3,0
	db 1,19,20,8,3,10,13,0
	db 1,18,24,9,4,3,13,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "New York"
	PackedText "NYI"
	PackedName "N14XXXXX"
	PackedText "Nassau Coliseum"
NewYorkR:							; team record 14 (NYR)
.0:	dw (24<<11)|(PlayerList+668)	; 24 players, from PlayerList entry 334
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $56,$20,$20,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 79							; overall rating (shown on the matchup screen)
.godds:	db 196,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,20,8,3,15,13,0
	db 1,18,21,8,3,13,15,0
	db 1,22,20,14,6,15,3,0
	db 1,24,19,10,5,17,3,0
	db 1,18,20,8,3,13,15,0
	db 1,22,19,10,6,15,3,0
	db 1,18,21,8,3,15,13,0
	db 1,22,20,10,5,3,8,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "New York"
	PackedText "NYR"
	PackedName "N15XXX"
	PackedText "Madison Square Garden"
Ottawa:								; team record 15 (OTW)
.0:	dw (24<<11)|(PlayerList+716)	; 24 players, from PlayerList entry 358
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $00,$02,$02,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 58							; overall rating (shown on the matchup screen)
.godds:	db 197,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,20,6,4,3,12,0
	db 1,19,21,6,4,12,3,0
	db 1,23,20,7,3,14,4,0
	db 1,22,24,11,5,13,4,0
	db 1,19,23,6,4,3,12,0
	db 1,22,20,7,5,14,12,0
	db 1,19,21,11,5,4,12,0
	db 1,24,20,12,4,3,6,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Ottawa"
	PackedText "OTW"
	PackedName "N16XXXXX"
	PackedText "Ottawa Civic Centre"
Philadelphia:						; team record 16 (PHI)
.0:	dw (24<<11)|(PlayerList+764)	; 24 players, from PlayerList entry 382
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $61,$21,$01,$D9			; bonus bytes (.sr in 95G teamdata95.asm)
	db 71							; overall rating (shown on the matchup screen)
.godds:	db 90,0						; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,16,17,4,3,12,8,0
	db 1,16,17,8,3,12,4,0
	db 1,18,19,9,4,13,3,0
	db 1,20,22,10,5,14,3,0
	db 1,16,17,9,3,12,4,0
	db 1,20,19,10,4,13,3,0
	db 1,18,19,4,3,8,12,0
	db 1,16,17,5,6,3,4,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Philadelphia"
	PackedText "PHI"
	PackedName "N17XX"
	PackedText "The Spectrum"
Pittsburgh:							; team record 17 (PIT)
.0:	dw (24<<11)|(PlayerList+812)	; 24 players, from PlayerList entry 406
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $63,$11,$20,$D9			; bonus bytes (.sr in 95G teamdata95.asm)
	db 78							; overall rating (shown on the matchup screen)
.godds:	db 197,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,19,7,3,13,12,0
	db 1,18,17,7,3,12,13,0
	db 1,20,19,8,4,13,3,0
	db 1,21,22,9,5,14,3,0
	db 1,18,19,7,3,13,12,0
	db 1,20,17,14,4,12,13,0
	db 1,18,19,13,3,12,7,0
	db 1,20,17,7,4,3,12,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Pittsburgh"
	PackedText "PIT"
	PackedName "N18XXXXX"
	PackedText "Pittsburgh Civic Arena"
Quebec:								; team record 18 (QUE)
.0:	dw (24<<11)|(PlayerList+860)	; 24 players, from PlayerList entry 430
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $52,$02,$12,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 69							; overall rating (shown on the matchup screen)
.godds:	db 166,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,20,9,3,5,15,0
	db 1,20,18,9,5,15,3,0
	db 1,19,22,8,3,16,5,0
	db 1,23,24,12,4,17,5,0
	db 1,19,22,9,3,5,15,0
	db 1,20,24,8,4,15,3,0
	db 1,20,18,7,4,3,5,0
	db 1,19,22,6,5,3,9,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Quebec"
	PackedText "QUE"
	PackedName "N19XXXXX"
	PackedText "Colisee de Quebec"
SanJose:							; team record 19 (SJ)
.0:	dw (23<<11)|(PlayerList+908)	; 23 players, from PlayerList entry 454
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $24,$02,$12,$E7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 70							; overall rating (shown on the matchup screen)
.godds:	db 212,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,17,14,3,16,10,0
	db 1,17,19,10,3,16,14,0
	db 1,18,20,8,4,14,3,0
	db 1,21,23,9,5,15,3,0
	db 1,17,19,10,3,16,14,0
	db 1,18,20,14,4,15,3,0
	db 1,21,23,9,5,3,14,0
	db 1,18,19,8,3,16,10,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "San Jose"
	PackedText "SJ"
	PackedName "N20XX"
	PackedText "San Jose Arena"
StLouis:							; team record 20 (STL)
.0:	dw (24<<11)|(PlayerList+954)	; 24 players, from PlayerList entry 477
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $34,$21,$21,$F7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 79							; overall rating (shown on the matchup screen)
.godds:	db 212,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,22,8,3,11,5,0
	db 1,24,18,8,3,11,5,0
	db 1,22,21,9,5,12,11,0
	db 1,20,23,7,4,13,11,0
	db 1,22,18,8,3,11,5,0
	db 1,24,19,5,4,12,11,0
	db 1,24,18,8,12,11,3,0
	db 1,20,21,13,11,3,8,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "St= Louis"
	PackedText "STL"
	PackedName "N21XX"
	PackedText "St= Louis Arena"
TampaBay:							; team record 21 (TB)
.0:	dw (22<<11)|(PlayerList+1002)	; 22 players, from PlayerList entry 501
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $10,$00,$01,$D7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 64							; overall rating (shown on the matchup screen)
.godds:	db 196,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,17,14,4,3,10,0
	db 1,18,16,10,4,14,3,0
	db 1,17,19,8,3,13,4,0
	db 1,21,20,11,5,12,4,0
	db 1,17,16,3,4,14,10,0
	db 1,18,19,9,5,12,4,0
	db 1,18,19,8,5,4,10,0
	db 1,17,16,10,3,4,14,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Tampa Bay"
	PackedText "TB"
	PackedName "N22XXXXX"
	PackedText "Thunderdome"
Toronto:							; team record 22 (TOR)
.0:	dw (24<<11)|(PlayerList+1046)	; 24 players, from PlayerList entry 523
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $51,$11,$10,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 75							; overall rating (shown on the matchup screen)
.godds:	db 212,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,21,10,4,9,15,0
	db 1,17,18,9,4,15,10,0
	db 1,21,19,10,3,16,4,0
	db 1,23,22,11,7,14,4,0
	db 1,17,18,10,4,14,9,0
	db 1,21,19,9,3,15,4,0
	db 1,21,19,10,4,9,15,0
	db 1,17,18,15,7,4,9,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Toronto"
	PackedText "TOR"
	PackedName "N23XXXXXXXXXX"
	PackedText "Maple Leaf Gardens"
Vancouver:							; team record 23 (VAN)
.0:	dw (24<<11)|(PlayerList+1094)	; 24 players, from PlayerList entry 547
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $51,$11,$10,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 75							; overall rating (shown on the matchup screen)
.godds:	db 196,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,18,7,3,13,14,0
	db 1,24,19,7,3,13,14,0
	db 1,18,23,9,5,14,13,0
	db 1,21,22,8,4,11,13,0
	db 1,18,19,7,3,13,14,0
	db 1,17,23,9,4,14,13,0
	db 1,24,19,13,5,14,9,0
	db 1,18,22,14,6,9,7,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Vancouver"
	PackedText "VAN"
	PackedName "N24XXX"
	PackedText "General Motors Place"
Winnipeg:							; team record 25 (WPG)
.0:	dw (24<<11)|(PlayerList+1190)	; 24 players, from PlayerList entry 595
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $20,$12,$02,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 70							; overall rating (shown on the matchup screen)
.godds:	db 166,0					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,19,23,8,3,13,4,0
	db 1,23,19,8,3,13,4,0
	db 1,20,22,11,4,15,13,0
	db 1,17,24,9,5,16,13,0
	db 1,23,19,8,3,13,4,0
	db 1,20,22,5,4,15,13,0
	db 1,20,22,8,15,3,13,0
	db 1,23,19,9,5,3,13,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Winnipeg"
	PackedText "WPG"
	PackedName "N25"
	PackedText "Winnipeg Arena"
Washington:							; team record 24 (WSH)
.0:	dw (24<<11)|(PlayerList+1142)	; 24 players, from PlayerList entry 571
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $27,$11,$11,$E7			; bonus bytes (.sr in 95G teamdata95.asm)
	db 70							; overall rating (shown on the matchup screen)
.godds:	db 164,32					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,20,18,10,4,5,13,0
	db 1,21,18,10,5,13,4,0
	db 1,20,22,12,4,17,5,0
	db 1,23,19,9,6,7,5,0
	db 1,21,18,7,5,13,4,0
	db 1,20,22,10,4,6,5,0
	db 1,24,18,9,4,5,10,0
	db 1,21,20,12,6,5,10,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "Washington"
	PackedText "WSH"
	PackedName "N26XXXXX"
	PackedText "USAir Arena"
TeamRecordUnused:					; a team record TeamList does not point at (EA Sports Dream Team)
.0:	dw (25<<11)|(PlayerList+1324)	; 25 players, from PlayerList entry 662
	dw .tx							; the city string
	dw .ls+8-.0,.sr-.0,.godds-.0,.ls-.0	; offsets of the lines from the second on, the bonus bytes, the goalie weights, the lines
.sr:	db $77,$20,$20,$E8			; bonus bytes (.sr in 95G teamdata95.asm)
	db 100							; overall rating (shown on the matchup screen)
.godds:	db 237,144					; starting goalie weights
.ls:								; 8 lines of 8 player numbers (1 = the team's first player)
	db 1,18,23,4,9,8,6,0
	db 1,18,23,4,9,8,6,0
	db 1,24,21,7,14,13,4,0
	db 1,22,19,10,11,12,4,0
	db 1,18,23,4,9,8,6,0
	db 1,21,20,12,5,8,4,0
	db 1,22,23,10,11,12,16,0
	db 1,25,19,4,14,15,17,0
.tx:								; city, abbreviation, nickname, arena
	PackedText "EASports"
	PackedText "EAS"
	PackedText "Dream Team"
	PackedText "EA Sports Arena"
