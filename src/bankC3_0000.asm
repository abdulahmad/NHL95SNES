; Segment bankC3_0000: the team database tables (TeamList, PlayerList), then the first player records (labels
; and ROM cuts: the records hold licensed names).
org $C30000
TeamList:							; a word per team (team number = index) to its team record, as 94S
									; TeamList (which has long pointers)
	dw Anaheim,Boston,Buffalo,Calgary
	dw Chicago,Dallas,Detroit,Edmonton
	dw Florida,Hartford,LosAngeles,Montreal
	dw NewJersey,NewYorkI,NewYorkR,Ottawa
	dw Philadelphia,Pittsburgh,Quebec,SanJose
	dw StLouis,TampaBay,Toronto,Vancouver
	dw Washington,Winnipeg,AllStarsEast,AllStarsWest
PlayerList:							; a word per player to its record, plus flags in bits 14-15 (0, $4000,
									; $8000: they group like goalies, defence, forwards; not traced)
	dw Player000,Player001,Player002+$8000,Player003+$8000
	dw Player004+$8000,Player005+$8000,Player006+$8000,Player007+$8000
	dw Player008+$8000,Player009+$8000,Player010+$8000,Player011+$8000
	dw Player012+$8000,Player013+$8000,Player014+$8000,Player015+$8000
	dw Player016+$4000,Player017+$4000,Player018+$4000,Player019+$4000
	dw Player020+$4000,Player021+$4000,Player022+$4000,Player023
	dw Player024,Player025+$8000,Player026+$8000,Player027+$8000
	dw Player028+$8000,Player029+$8000,Player030+$8000,Player031+$8000
	dw Player032+$8000,Player033+$8000,Player034+$8000,Player035+$8000
	dw Player036+$8000,Player037+$8000,Player038+$8000,Player039+$4000
	dw Player040+$4000,Player041+$4000,Player042+$4000,Player043+$4000
	dw Player044+$4000,Player045+$4000,Player046+$4000,Player047
	dw Player048,Player049+$8000,Player050+$8000,Player051+$8000
	dw Player052+$8000,Player053+$8000,Player054+$8000,Player055+$8000
	dw Player056+$8000,Player057+$8000,Player058+$8000,Player059+$8000
	dw Player060+$8000,Player061+$8000,Player062+$8000,Player063+$8000
	dw Player064+$4000,Player065+$4000,Player066+$4000,Player067+$4000
	dw Player068+$4000,Player069+$4000,Player070+$4000,Player071
	dw Player072,Player073+$8000,Player074+$8000,Player075+$8000
	dw Player076+$8000,Player077+$8000,Player078+$8000,Player079+$8000
	dw Player080+$8000,Player081+$8000,Player082+$8000,Player083+$8000
	dw Player084+$8000,Player085+$4000,Player086+$4000,Player087+$4000
	dw Player088+$4000,Player089+$4000,Player090+$4000,Player091+$4000
	dw Player092+$4000,Player093+$4000,Player094+$4000,Player095
	dw Player096,Player097+$8000,Player098+$8000,Player099+$8000
	dw Player100+$8000,Player101+$8000,Player102+$8000,Player103+$8000
	dw Player104+$8000,Player105+$8000,Player106+$8000,Player107+$8000
	dw Player108+$8000,Player109+$8000,Player110+$8000,Player111+$4000
	dw Player112+$4000,Player113+$4000,Player114+$4000,Player115+$4000
	dw Player116+$4000,Player117+$4000,Player118+$4000,Player119
	dw Player120,Player121+$8000,Player122+$8000,Player123+$8000
	dw Player124+$8000,Player125+$8000,Player126+$8000,Player127+$8000
	dw Player128+$8000,Player129+$8000,Player130+$8000,Player131+$8000
	dw Player132+$8000,Player133+$8000,Player134+$8000,Player135+$8000
	dw Player136+$4000,Player137+$4000,Player138+$4000,Player139+$4000
	dw Player140+$4000,Player141+$4000,Player142+$4000,Player143
	dw Player144,Player145+$8000,Player146+$8000,Player147+$8000
	dw Player148+$8000,Player149+$8000,Player150+$8000,Player151+$8000
	dw Player152+$8000,Player153+$8000,Player154+$8000,Player155+$8000
	dw Player156+$8000,Player157+$8000,Player158+$8000,Player159+$4000
	dw Player160+$4000,Player161+$4000,Player162+$4000,Player163+$4000
	dw Player164+$4000,Player165+$4000,Player166+$4000,Player167
	dw Player168,Player169+$8000,Player170+$8000,Player171+$8000
	dw Player172+$8000,Player173+$8000,Player174+$8000,Player175+$8000
	dw Player176+$8000,Player177+$8000,Player178+$8000,Player179+$8000
	dw Player180+$8000,Player181+$8000,Player182+$8000,Player183+$8000
	dw Player184+$4000,Player185+$4000,Player186+$4000,Player187+$4000
	dw Player188+$4000,Player189+$4000,Player190+$4000,Player191
	dw Player192,Player193+$8000,Player194+$8000,Player195+$8000
	dw Player196+$8000,Player197+$8000,Player198+$8000,Player199+$8000
	dw Player200+$8000,Player201+$8000,Player202+$8000,Player203+$8000
	dw Player204+$8000,Player205+$8000,Player206+$8000,Player207+$4000
	dw Player208+$4000,Player209+$4000,Player210+$4000,Player211+$4000
	dw Player212+$4000,Player213+$4000,Player214+$4000,Player215
	dw Player216,Player217,Player218+$8000,Player219+$8000
	dw Player220+$8000,Player221+$8000,Player222+$8000,Player223+$8000
	dw Player224+$8000,Player225+$8000,Player226+$8000,Player227+$8000
	dw Player228+$8000,Player229+$8000,Player230+$8000,Player231+$8000
	dw Player232+$4000,Player233+$4000,Player234+$4000,Player235+$4000
	dw Player236+$4000,Player237+$4000,Player238+$4000,Player239
	dw Player240,Player241+$8000,Player242+$8000,Player243+$8000
	dw Player244+$8000,Player245+$8000,Player246+$8000,Player247+$8000
	dw Player248+$8000,Player249+$8000,Player250+$8000,Player251+$8000
	dw Player252+$8000,Player253+$8000,Player254+$4000,Player255+$4000
	dw Player256+$4000,Player257+$4000,Player258+$4000,Player259+$4000
	dw Player260+$4000,Player261+$4000,Player262,Player263
	dw Player264+$8000,Player265+$8000,Player266+$8000,Player267+$8000
	dw Player268+$8000,Player269+$8000,Player270+$8000,Player271+$8000
	dw Player272+$8000,Player273+$8000,Player274+$8000,Player275+$8000
	dw Player276+$8000,Player277+$8000,Player278+$4000,Player279+$4000
	dw Player280+$4000,Player281+$4000,Player282+$4000,Player283+$4000
	dw Player284+$4000,Player285+$4000,Player286,Player287
	dw Player288+$8000,Player289+$8000,Player290+$8000,Player291+$8000
	dw Player292+$8000,Player293+$8000,Player294+$8000,Player295+$8000
	dw Player296+$8000,Player297+$8000,Player298+$8000,Player299+$8000
	dw Player300+$8000,Player301+$8000,Player302+$8000,Player303+$4000
	dw Player304+$4000,Player305+$4000,Player306+$4000,Player307+$4000
	dw Player308+$4000,Player309+$4000,Player310,Player311
	dw Player312+$8000,Player313+$8000,Player314+$8000,Player315+$8000
	dw Player316+$8000,Player317+$8000,Player318+$8000,Player319+$8000
	dw Player320+$8000,Player321+$8000,Player322+$8000,Player323+$8000
	dw Player324+$8000,Player325+$8000,Player326+$8000,Player327+$4000
	dw Player328+$4000,Player329+$4000,Player330+$4000,Player331+$4000
	dw Player332+$4000,Player333+$4000,Player334,Player335
	dw Player336+$8000,Player337+$8000,Player338+$8000,Player339+$8000
	dw Player340+$8000,Player341+$8000,Player342+$8000,Player343+$8000
	dw Player344+$8000,Player345+$8000,Player346+$8000,Player347+$8000
	dw Player348+$8000,Player349+$8000,Player350+$8000,Player351+$4000
	dw Player352+$4000,Player353+$4000,Player354+$4000,Player355+$4000
	dw Player356+$4000,Player357+$4000,Player358,Player359
	dw Player360+$8000,Player361+$8000,Player362+$8000,Player363+$8000
	dw Player364+$8000,Player365+$8000,Player366+$8000,Player367+$8000
	dw Player368+$8000,Player369+$8000,Player370+$8000,Player371+$8000
	dw Player372+$8000,Player373+$8000,Player374+$4000,Player375+$4000
	dw Player376+$4000,Player377+$4000,Player378+$4000,Player379+$4000
	dw Player380+$4000,Player381+$4000,Player382,Player383
	dw Player384+$8000,Player385+$8000,Player386+$8000,Player387+$8000
	dw Player388+$8000,Player389+$8000,Player390+$8000,Player391+$8000
	dw Player392+$8000,Player393+$8000,Player394+$8000,Player395+$8000
	dw Player396+$8000,Player397+$4000,Player398+$4000,Player399+$4000
	dw Player400+$4000,Player401+$4000,Player402+$4000,Player403+$4000
	dw Player404+$4000,Player405+$4000,Player406,Player407
	dw Player408+$8000,Player409+$8000,Player410+$8000,Player411+$8000
	dw Player412+$8000,Player413+$8000,Player414+$8000,Player415+$8000
	dw Player416+$8000,Player417+$8000,Player418+$8000,Player419+$8000
	dw Player420+$8000,Player421+$4000,Player422+$4000,Player423+$4000
	dw Player424+$4000,Player425+$4000,Player426+$4000,Player427+$4000
	dw Player428+$4000,Player429+$4000,Player430,Player431
	dw Player432+$8000,Player433+$8000,Player434+$8000,Player435+$8000
	dw Player436+$8000,Player437+$8000,Player438+$8000,Player439+$8000
	dw Player440+$8000,Player441+$8000,Player442+$8000,Player443+$8000
	dw Player444+$8000,Player445+$8000,Player446+$8000,Player447+$4000
	dw Player448+$4000,Player449+$4000,Player450+$4000,Player451+$4000
	dw Player452+$4000,Player453+$4000,Player454,Player455
	dw Player456+$8000,Player457+$8000,Player458+$8000,Player459+$8000
	dw Player460+$8000,Player461+$8000,Player462+$8000,Player463+$8000
	dw Player464+$8000,Player465+$8000,Player466+$8000,Player467+$8000
	dw Player468+$8000,Player469+$8000,Player470+$4000,Player471+$4000
	dw Player472+$4000,Player473+$4000,Player474+$4000,Player475+$4000
	dw Player476+$4000,Player477,Player478,Player479+$8000
	dw Player480+$8000,Player481+$8000,Player482+$8000,Player483+$8000
	dw Player484+$8000,Player485+$8000,Player486+$8000,Player487+$8000
	dw Player488+$8000,Player489+$8000,Player490+$8000,Player491+$8000
	dw Player492+$8000,Player493+$8000,Player494+$4000,Player495+$4000
	dw Player496+$4000,Player497+$4000,Player498+$4000,Player499+$4000
	dw Player500+$4000,Player501,Player502,Player503+$8000
	dw Player504+$8000,Player505+$8000,Player506+$8000,Player507+$8000
	dw Player508+$8000,Player509+$8000,Player510+$8000,Player511+$8000
	dw Player512+$8000,Player513+$8000,Player514+$8000,Player515+$8000
	dw Player516+$4000,Player517+$4000,Player518+$4000,Player519+$4000
	dw Player520+$4000,Player521+$4000,Player522+$4000,Player523
	dw Player524,Player525+$8000,Player526+$8000,Player527+$8000
	dw Player528+$8000,Player529+$8000,Player530+$8000,Player531+$8000
	dw Player532+$8000,Player533+$8000,Player534+$8000,Player535+$8000
	dw Player536+$8000,Player537+$8000,Player538+$8000,Player539+$4000
	dw Player540+$4000,Player541+$4000,Player542+$4000,Player543+$4000
	dw Player544+$4000,Player545+$4000,Player546+$4000,Player547
	dw Player548,Player549+$8000,Player550+$8000,Player551+$8000
	dw Player552+$8000,Player553+$8000,Player554+$8000,Player555+$8000
	dw Player556+$8000,Player557+$8000,Player558+$8000,Player559+$8000
	dw Player560+$8000,Player561+$8000,Player562+$8000,Player563+$4000
	dw Player564+$4000,Player565+$4000,Player566+$4000,Player567+$4000
	dw Player568+$4000,Player569+$4000,Player570+$4000,Player571
	dw Player572,Player573,Player574+$8000,Player575+$8000
	dw Player576+$8000,Player577+$8000,Player578+$8000,Player579+$8000
	dw Player580+$8000,Player581+$8000,Player582+$8000,Player583+$8000
	dw Player584+$8000,Player585+$8000,Player586+$8000,Player587+$8000
	dw Player588+$4000,Player589+$4000,Player590+$4000,Player591+$4000
	dw Player592+$4000,Player593+$4000,Player594+$4000,Player595
	dw Player596,Player597+$8000,Player598+$8000,Player599+$8000
	dw Player600+$8000,Player601+$8000,Player602+$8000,Player603+$8000
	dw Player604+$8000,Player605+$8000,Player606+$8000,Player607+$8000
	dw Player608+$8000,Player609+$8000,Player610+$8000,Player611+$4000
	dw Player612+$4000,Player613+$4000,Player614+$4000,Player615+$4000
	dw Player616+$4000,Player617+$4000,Player618+$4000,Player619
	dw Player620,Player621,Player622+$8000,Player623+$8000
	dw Player624+$8000,Player625+$8000,Player626+$8000,Player627+$8000
	dw Player628+$8000,Player629+$8000,Player630+$8000,Player631+$8000
	dw Player632+$8000,Player633+$8000,Player634+$8000,Player635+$8000
	dw Player636+$4000,Player637+$4000,Player638+$4000,Player639+$4000
	dw Player640+$4000,Player641,Player642,Player643
	dw Player644+$8000,Player645+$8000,Player646+$8000,Player647+$8000
	dw Player648+$8000,Player649+$8000,Player650+$8000,Player651+$8000
	dw Player652+$8000,Player653+$8000,Player654+$8000,Player655+$8000
	dw Player656+$4000,Player657+$4000,Player658+$4000,Player659+$4000
	dw Player660+$4000,Player661+$4000,Player662,Player663
	dw Player664,Player665+$8000,Player666+$8000,Player667+$8000
	dw Player668+$8000,Player669+$8000,Player670+$8000,Player671+$8000
	dw Player672+$8000,Player673+$8000,Player674+$8000,Player675+$8000
	dw Player676+$8000,Player677+$8000,Player678+$8000,Player679+$4000
	dw Player680+$4000,Player681+$4000,Player682+$4000,Player683+$4000
	dw Player684+$4000,Player685+$4000,Player686+$4000
Player619:							; player 619 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$596..$5A8
Player620:							; player 620 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$5A8..$5BA
Player621:							; player 621 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$5BA..$5CE
Player622:							; player 622 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$5CE..$5E0
Player623:							; player 623 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$5E0..$5F1
Player624:							; player 624 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$5F1..$605
Player625:							; player 625 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$605..$616
Player626:							; player 626 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$616..$629
Player627:							; player 627 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$629..$63C
Player628:							; player 628 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$63C..$64E
Player629:							; player 629 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$64E..$65F
Player630:							; player 630 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$65F..$671
Player631:							; player 631 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$671..$685
Player632:							; player 632 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$685..$697
Player633:							; player 633 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$697..$6A9
Player634:							; player 634 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$6A9..$6BB
Player635:							; player 635 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$6BB..$6D0
Player636:							; player 636 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$6D0..$6E2
Player637:							; player 637 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$6E2..$6F5
Player638:							; player 638 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$6F5..$707
Player639:							; player 639 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$707..$719
Player640:							; player 640 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$719..$72A
Player641:							; player 641 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$72A..$73C
Player642:							; player 642 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$73C..$74F
Player643:							; player 643 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$74F..$761
Player644:							; player 644 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$761..$773
Player645:							; player 645 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$773..$786
Player646:							; player 646 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$786..$79A
Player647:							; player 647 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$79A..$7AE
Player648:							; player 648 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$7AE..$7C2
Player649:							; player 649 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$7C2..$7D5
Player650:							; player 650 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$7D5..$7E9
Player651:							; player 651 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$7E9..$7FE
Player652:							; player 652 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$7FE..$80F
Player653:							; player 653 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$80F..$822
Player654:							; player 654 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$822..$833
Player655:							; player 655 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$833..$847
Player656:							; player 656 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$847..$858
Player657:							; player 657 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$858..$86B
Player658:							; player 658 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$86B..$880
Player659:							; player 659 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$880..$894
Player660:							; player 660 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$894..$8A7
Player661:							; player 661 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$8A7..$8B9
Player000:							; player 0 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$8B9..$8CA
Player001:							; player 1 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$8CA..$8E0
Player002:							; player 2 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$8E0..$8F1
Player003:							; player 3 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$8F1..$905
Player004:							; player 4 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$905..$919
Player005:							; player 5 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$919..$92E
Player006:							; player 6 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$92E..$93F
Player007:							; player 7 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$93F..$950
Player008:							; player 8 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$950..$962
Player009:							; player 9 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$962..$973
Player010:							; player 10 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$973..$985
Player011:							; player 11 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$985..$996
Player012:							; player 12 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$996..$9A7
Player013:							; player 13 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$9A7..$9B9
Player014:							; player 14 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$9B9..$9CB
Player015:							; player 15 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$9CB..$9DF
Player016:							; player 16 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$9DF..$9F3
Player017:							; player 17 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$9F3..$A04
Player018:							; player 18 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A04..$A16
Player019:							; player 19 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A16..$A29
Player020:							; player 20 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A29..$A3B
Player021:							; player 21 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A3B..$A4D
Player022:							; player 22 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A4D..$A61
Player023:							; player 23 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A61..$A72
Player024:							; player 24 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A72..$A87
Player025:							; player 25 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A87..$A98
Player026:							; player 26 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$A98..$AAB
Player027:							; player 27 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$AAB..$ABF
Player028:							; player 28 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$ABF..$AD3
Player029:							; player 29 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$AD3..$AE4
Player030:							; player 30 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$AE4..$AF5
Player031:							; player 31 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$AF5..$B08
Player032:							; player 32 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B08..$B1C
Player033:							; player 33 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B1C..$B2E
Player034:							; player 34 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B2E..$B44
Player035:							; player 35 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B44..$B56
Player036:							; player 36 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B56..$B6C
Player037:							; player 37 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B6C..$B7D
Player038:							; player 38 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B7D..$B8E
Player039:							; player 39 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$B8E..$BA0
Player040:							; player 40 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$BA0..$BB2
Player041:							; player 41 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$BB2..$BC3
Player042:							; player 42 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$BC3..$BD4
Player043:							; player 43 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$BD4..$BE6
Player044:							; player 44 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$BE6..$BF8
Player045:							; player 45 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$BF8..$C0C
Player046:							; player 46 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C0C..$C20
Player048:							; player 48 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C20..$C31
Player047:							; player 47 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C31..$C44
Player049:							; player 49 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C44..$C56
Player050:							; player 50 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C56..$C6B
Player051:							; player 51 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C6B..$C7F
Player052:							; player 52 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C7F..$C91
Player053:							; player 53 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$C91..$CA0
Player054:							; player 54 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$CA0..$CB1
Player055:							; player 55 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$CB1..$CC3
Player056:							; player 56 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$CC3..$CD3
Player057:							; player 57 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$CD3..$CE6
Player058:							; player 58 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$CE6..$CF7
Player059:							; player 59 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$CF7..$D09
Player060:							; player 60 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D09..$D1E
Player061:							; player 61 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D1E..$D31
Player062:							; player 62 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D31..$D45
Player063:							; player 63 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D45..$D59
Player064:							; player 64 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D59..$D6B
Player065:							; player 65 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D6B..$D7D
Player066:							; player 66 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D7D..$D8E
Player067:							; player 67 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$D8E..$DA3
Player068:							; player 68 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$DA3..$DB4
Player069:							; player 69 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$DB4..$DC6
Player070:							; player 70 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$DC6..$DDA
Player071:							; player 71 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$DDA..$DEC
Player072:							; player 72 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$DEC..$DFE
Player073:							; player 73 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$DFE..$E12
Player074:							; player 74 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E12..$E26
Player075:							; player 75 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E26..$E37
Player076:							; player 76 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E37..$E4C
Player077:							; player 77 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E4C..$E5E
Player078:							; player 78 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E5E..$E70
Player079:							; player 79 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E70..$E82
Player080:							; player 80 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E82..$E93
Player081:							; player 81 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$E93..$EA3
Player082:							; player 82 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$EA3..$EB7
Player083:							; player 83 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$EB7..$ECC
Player084:							; player 84 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$ECC..$EDE
Player085:							; player 85 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$EDE..$EF1
Player086:							; player 86 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$EF1..$F05
Player087:							; player 87 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F05..$F18
Player088:							; player 88 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F18..$F2B
Player089:							; player 89 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F2B..$F3D
Player090:							; player 90 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F3D..$F4F
Player091:							; player 91 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F4F..$F61
Player092:							; player 92 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F61..$F73
Player093:							; player 93 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F73..$F84
Player094:							; player 94 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F84..$F98
Player095:							; player 95 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$F98..$FA9
Player096:							; player 96 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$FA9..$FBB
Player097:							; player 97 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$FBB..$FCF
Player098:							; player 98 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$FCF..$FE3
Player099:							; player 99 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$FE3..$FF5
Player100:							; player 100 of PlayerList: a packed name and the ratings
	incbin "../Extracted/segments/bankC3_0000.bin":$FF5..$1000
	incbin "../Extracted/segments/bankC3_1000.bin":$0..$7
