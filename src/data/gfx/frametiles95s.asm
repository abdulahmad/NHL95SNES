; Player frame tiles: the raw tiles of every player frame (FrameTileSource / FrameBankLayout entries), one label each.
; They sit in banks $C6 to $CC with other graphics between the runs, so there is one macro per bank run, expanded by its bank file:
; %FrameTilesC6() puts the 43 frames of bank $C6 at the current address. The labels are defined where the macro is expanded.

macro FrameTilesC6()
FrameTiles002:						; the raw tiles of frame $002 (FrameTileSource / FrameBankLayout entry
									; $002); pose not traced
	incbin "../../../Extracted/segments/bankC6_2000.bin":$968..$BE8
FrameTiles003:						; the raw tiles of frame $003 (FrameTileSource / FrameBankLayout entry
									; $003); pose not traced
	incbin "../../../Extracted/segments/bankC6_2000.bin":$BE8..$E28
FrameTiles006:						; the raw tiles of frame $006 (FrameTileSource / FrameBankLayout entry
									; $006); pose not traced
	incbin "../../../Extracted/segments/bankC6_2000.bin":$E28..$1000
	incbin "../../../Extracted/segments/bankC6_3000.bin":$0..$A8
FrameTiles007:						; the raw tiles of frame $007 (FrameTileSource / FrameBankLayout entry
									; $007); pose not traced
	incbin "../../../Extracted/segments/bankC6_3000.bin":$A8..$308
FrameTiles008:						; the raw tiles of frame $008 (FrameTileSource / FrameBankLayout entry
									; $008); pose not traced
	incbin "../../../Extracted/segments/bankC6_3000.bin":$308..$508
FrameTiles00A:						; the raw tiles of frame $00A (FrameTileSource / FrameBankLayout entry
									; $00A); pose not traced
	incbin "../../../Extracted/segments/bankC6_3000.bin":$508..$788
FrameTiles00B:						; the raw tiles of frame $00B (FrameTileSource / FrameBankLayout entry
									; $00B); pose not traced
	incbin "../../../Extracted/segments/bankC6_3000.bin":$788..$9E8
FrameTiles00E:						; the raw tiles of frame $00E (FrameTileSource / FrameBankLayout entry
									; $00E); pose not traced
	incbin "../../../Extracted/segments/bankC6_3000.bin":$9E8..$C68
FrameTiles00F:						; the raw tiles of frame $00F (FrameTileSource / FrameBankLayout entry
									; $00F); pose not traced
	incbin "../../../Extracted/segments/bankC6_3000.bin":$C68..$EC8
FrameTiles010:						; the raw tiles of frame $010 (FrameTileSource / FrameBankLayout entry
									; $010); pose not traced
	incbin "../../../Extracted/segments/bankC6_3000.bin":$EC8..$1000
	incbin "../../../Extracted/segments/bankC6_4000.bin":$0..$128
FrameTiles012:						; the raw tiles of frame $012 (FrameTileSource / FrameBankLayout entry
									; $012); pose not traced
	incbin "../../../Extracted/segments/bankC6_4000.bin":$128..$388
FrameTiles013:						; the raw tiles of frame $013 (FrameTileSource / FrameBankLayout entry
									; $013); pose not traced
	incbin "../../../Extracted/segments/bankC6_4000.bin":$388..$588
FrameTiles016:						; the raw tiles of frame $016 (FrameTileSource / FrameBankLayout entry
									; $016); pose not traced
	incbin "../../../Extracted/segments/bankC6_4000.bin":$588..$808
FrameTiles017:						; the raw tiles of frame $017 (FrameTileSource / FrameBankLayout entry
									; $017); pose not traced
	incbin "../../../Extracted/segments/bankC6_4000.bin":$808..$A68
FrameTiles018:						; the raw tiles of frame $018 (FrameTileSource / FrameBankLayout entry
									; $018); pose not traced
	incbin "../../../Extracted/segments/bankC6_4000.bin":$A68..$C68
FrameTiles01A:						; the raw tiles of frame $01A (FrameTileSource / FrameBankLayout entry
									; $01A); pose not traced
	incbin "../../../Extracted/segments/bankC6_4000.bin":$C68..$EC8
FrameTiles01B:						; the raw tiles of frame $01B (FrameTileSource / FrameBankLayout entry
									; $01B); pose not traced
	incbin "../../../Extracted/segments/bankC6_4000.bin":$EC8..$1000
	incbin "../../../Extracted/segments/bankC6_5000.bin":$0..$C8
FrameTiles01E:						; the raw tiles of frame $01E (FrameTileSource / FrameBankLayout entry
									; $01E); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$C8..$328
FrameTiles01F:						; the raw tiles of frame $01F (FrameTileSource / FrameBankLayout entry
									; $01F); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$328..$528
FrameTiles020:						; the raw tiles of frame $020 (FrameTileSource / FrameBankLayout entry
									; $020); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$528..$728
FrameTiles022:						; the raw tiles of frame $022 (FrameTileSource / FrameBankLayout entry
									; $022); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$728..$988
FrameTiles023:						; the raw tiles of frame $023 (FrameTileSource / FrameBankLayout entry
									; $023); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$988..$B88
FrameTiles026:						; the raw tiles of frame $026 (FrameTileSource / FrameBankLayout entry
									; $026); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$B88..$D88
FrameTiles027:						; the raw tiles of frame $027 (FrameTileSource / FrameBankLayout entry
									; $027); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$D88..$F88
FrameTiles028:						; the raw tiles of frame $028 (FrameTileSource / FrameBankLayout entry
									; $028); pose not traced
	incbin "../../../Extracted/segments/bankC6_5000.bin":$F88..$1000
	incbin "../../../Extracted/segments/bankC6_6000.bin":$0..$188
FrameTiles02A:						; the raw tiles of frame $02A (FrameTileSource / FrameBankLayout entry
									; $02A); pose not traced
	incbin "../../../Extracted/segments/bankC6_6000.bin":$188..$3E8
FrameTiles02B:						; the raw tiles of frame $02B (FrameTileSource / FrameBankLayout entry
									; $02B); pose not traced
	incbin "../../../Extracted/segments/bankC6_6000.bin":$3E8..$5E8
FrameTiles02E:						; the raw tiles of frame $02E (FrameTileSource / FrameBankLayout entry
									; $02E); pose not traced
	incbin "../../../Extracted/segments/bankC6_6000.bin":$5E8..$848
FrameTiles02F:						; the raw tiles of frame $02F (FrameTileSource / FrameBankLayout entry
									; $02F); pose not traced
	incbin "../../../Extracted/segments/bankC6_6000.bin":$848..$AA8
FrameTiles030:						; the raw tiles of frame $030 (FrameTileSource / FrameBankLayout entry
									; $030); pose not traced
	incbin "../../../Extracted/segments/bankC6_6000.bin":$AA8..$CA8
FrameTiles032:						; the raw tiles of frame $032 (FrameTileSource / FrameBankLayout entry
									; $032); pose not traced
	incbin "../../../Extracted/segments/bankC6_6000.bin":$CA8..$F08
FrameTiles033:						; the raw tiles of frame $033 (FrameTileSource / FrameBankLayout entry
									; $033); pose not traced
	incbin "../../../Extracted/segments/bankC6_6000.bin":$F08..$1000
	incbin "../../../Extracted/segments/bankC6_7000.bin":$0..$168
FrameTiles036:						; the raw tiles of frame $036 (FrameTileSource / FrameBankLayout entry
									; $036); pose not traced
	incbin "../../../Extracted/segments/bankC6_7000.bin":$168..$368
FrameTiles037:						; the raw tiles of frame $037 (FrameTileSource / FrameBankLayout entry
									; $037); pose not traced
	incbin "../../../Extracted/segments/bankC6_7000.bin":$368..$5C8
FrameTiles038:						; the raw tiles of frame $038 (FrameTileSource / FrameBankLayout entry
									; $038); pose not traced
	incbin "../../../Extracted/segments/bankC6_7000.bin":$5C8..$828
FrameTiles03A:						; the raw tiles of frame $03A (FrameTileSource / FrameBankLayout entry
									; $03A); pose not traced
	incbin "../../../Extracted/segments/bankC6_7000.bin":$828..$AA8
FrameTiles03B:						; the raw tiles of frame $03B (FrameTileSource / FrameBankLayout entry
									; $03B); pose not traced
	incbin "../../../Extracted/segments/bankC6_7000.bin":$AA8..$D08
FrameTiles03E:						; the raw tiles of frame $03E (FrameTileSource / FrameBankLayout entry
									; $03E); pose not traced
	incbin "../../../Extracted/segments/bankC6_7000.bin":$D08..$F88
FrameTiles03F:						; the raw tiles of frame $03F (FrameTileSource / FrameBankLayout entry
									; $03F); pose not traced
	incbin "../../../Extracted/segments/bankC6_7000.bin":$F88..$1000
	incbin "../../../Extracted/segments/bankC6_8000.bin":$0..$1E8
FrameTiles040:						; the raw tiles of frame $040 (FrameTileSource / FrameBankLayout entry
									; $040); pose not traced
	incbin "../../../Extracted/segments/bankC6_8000.bin":$1E8..$448
FrameTiles041:						; the raw tiles of frame $041 (FrameTileSource / FrameBankLayout entry
									; $041); pose not traced
	incbin "../../../Extracted/segments/bankC6_8000.bin":$448..$6A8
FrameTiles042:						; the raw tiles of frame $042 (FrameTileSource / FrameBankLayout entry
									; $042); pose not traced
	incbin "../../../Extracted/segments/bankC6_8000.bin":$6A8..$8A8
FrameTiles043:						; the raw tiles of frame $043 (FrameTileSource / FrameBankLayout entry
									; $043); pose not traced
	incbin "../../../Extracted/segments/bankC6_8000.bin":$8A8..$A28
FrameTiles044:						; the raw tiles of frame $044 (FrameTileSource / FrameBankLayout entry
									; $044); pose not traced
	incbin "../../../Extracted/segments/bankC6_8000.bin":$A28..$C28
FrameTiles045:						; the raw tiles of frame $045 (FrameTileSource / FrameBankLayout entry
									; $045); pose not traced
	incbin "../../../Extracted/segments/bankC6_8000.bin":$C28..$E88
FrameTiles046:						; the raw tiles of frame $046 (FrameTileSource / FrameBankLayout entry
									; $046); pose not traced
	incbin "../../../Extracted/segments/bankC6_8000.bin":$E88..$1000
	incbin "../../../Extracted/segments/bankC6_9000.bin":$0..$88
FrameTiles047:						; the raw tiles of frame $047 (FrameTileSource / FrameBankLayout entry
									; $047); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$88..$288
FrameTiles048:						; the raw tiles of frame $048 (FrameTileSource / FrameBankLayout entry
									; $048); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$288..$488
FrameTiles049:						; the raw tiles of frame $049 (FrameTileSource / FrameBankLayout entry
									; $049); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$488..$688
FrameTiles04A:						; the raw tiles of frame $04A (FrameTileSource / FrameBankLayout entry
									; $04A); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$688..$888
FrameTiles04B:						; the raw tiles of frame $04B (FrameTileSource / FrameBankLayout entry
									; $04B); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$888..$A88
FrameTiles04C:						; the raw tiles of frame $04C (FrameTileSource / FrameBankLayout entry
									; $04C); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$A88..$CE8
FrameTiles04D:						; the raw tiles of frame $04D (FrameTileSource / FrameBankLayout entry
									; $04D); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$CE8..$F48
FrameTiles04E:						; the raw tiles of frame $04E (FrameTileSource / FrameBankLayout entry
									; $04E); pose not traced
	incbin "../../../Extracted/segments/bankC6_9000.bin":$F48..$1000
	incbin "../../../Extracted/segments/bankC6_A000.bin":$0..$1A8
FrameTiles04F:						; the raw tiles of frame $04F (FrameTileSource / FrameBankLayout entry
									; $04F); pose not traced
	incbin "../../../Extracted/segments/bankC6_A000.bin":$1A8..$408
FrameTiles050:						; the raw tiles of frame $050 (FrameTileSource / FrameBankLayout entry
									; $050); pose not traced
	incbin "../../../Extracted/segments/bankC6_A000.bin":$408..$688
FrameTiles051:						; the raw tiles of frame $051 (FrameTileSource / FrameBankLayout entry
									; $051); pose not traced
	incbin "../../../Extracted/segments/bankC6_A000.bin":$688..$888
FrameTiles052:						; the raw tiles of frame $052 (FrameTileSource / FrameBankLayout entry
									; $052); pose not traced
	incbin "../../../Extracted/segments/bankC6_A000.bin":$888..$A88
FrameTiles053:						; the raw tiles of frame $053 (FrameTileSource / FrameBankLayout entry
									; $053); pose not traced
	incbin "../../../Extracted/segments/bankC6_A000.bin":$A88..$CA8
FrameTiles054:						; the raw tiles of frame $054 (FrameTileSource / FrameBankLayout entry
									; $054); pose not traced
	incbin "../../../Extracted/segments/bankC6_A000.bin":$CA8..$EC8
FrameTiles055:						; the raw tiles of frame $055 (FrameTileSource / FrameBankLayout entry
									; $055); pose not traced
	incbin "../../../Extracted/segments/bankC6_A000.bin":$EC8..$1000
	incbin "../../../Extracted/segments/bankC6_B000.bin":$0..$108
FrameTiles056:						; the raw tiles of frame $056 (FrameTileSource / FrameBankLayout entry
									; $056); pose not traced
	incbin "../../../Extracted/segments/bankC6_B000.bin":$108..$348
FrameTiles057:						; the raw tiles of frame $057 (FrameTileSource / FrameBankLayout entry
									; $057); pose not traced
	incbin "../../../Extracted/segments/bankC6_B000.bin":$348..$5A8
FrameTiles058:						; the raw tiles of frame $058 (FrameTileSource / FrameBankLayout entry
									; $058); pose not traced
	incbin "../../../Extracted/segments/bankC6_B000.bin":$5A8..$808
FrameTiles06F:						; the raw tiles of frame $06F (FrameTileSource / FrameBankLayout entry
									; $06F); pose not traced
	incbin "../../../Extracted/segments/bankC6_B000.bin":$808..$A08
FrameTiles072:						; the raw tiles of frame $072 (FrameTileSource / FrameBankLayout entry
									; $072); pose not traced
	incbin "../../../Extracted/segments/bankC6_B000.bin":$A08..$C48
FrameTiles07B:						; the raw tiles of frame $07B (FrameTileSource / FrameBankLayout entry
									; $07B); pose not traced
	incbin "../../../Extracted/segments/bankC6_B000.bin":$C48..$EA8
FrameTiles07C:						; the raw tiles of frame $07C (FrameTileSource / FrameBankLayout entry
									; $07C); pose not traced
	incbin "../../../Extracted/segments/bankC6_B000.bin":$EA8..$1000
	incbin "../../../Extracted/segments/bankC6_C000.bin":$0..$A8
FrameTiles07D:						; the raw tiles of frame $07D (FrameTileSource / FrameBankLayout entry
									; $07D); pose not traced
	incbin "../../../Extracted/segments/bankC6_C000.bin":$A8..$2A8
FrameTiles07E:						; the raw tiles of frame $07E (FrameTileSource / FrameBankLayout entry
									; $07E); pose not traced
	incbin "../../../Extracted/segments/bankC6_C000.bin":$2A8..$508
FrameTiles07F:						; the raw tiles of frame $07F (FrameTileSource / FrameBankLayout entry
									; $07F); pose not traced
	incbin "../../../Extracted/segments/bankC6_C000.bin":$508..$708
FrameTiles080:						; the raw tiles of frame $080 (FrameTileSource / FrameBankLayout entry
									; $080); pose not traced
	incbin "../../../Extracted/segments/bankC6_C000.bin":$708..$968
FrameTiles081:						; the raw tiles of frame $081 (FrameTileSource / FrameBankLayout entry
									; $081); pose not traced
	incbin "../../../Extracted/segments/bankC6_C000.bin":$968..$BE8
FrameTiles082:						; the raw tiles of frame $082 (FrameTileSource / FrameBankLayout entry
									; $082); pose not traced
	incbin "../../../Extracted/segments/bankC6_C000.bin":$BE8..$E68
FrameTiles083:						; the raw tiles of frame $083 (FrameTileSource / FrameBankLayout entry
									; $083); pose not traced
	incbin "../../../Extracted/segments/bankC6_C000.bin":$E68..$1000
	incbin "../../../Extracted/segments/bankC6_D000.bin":$0..$E8
FrameTiles084:						; the raw tiles of frame $084 (FrameTileSource / FrameBankLayout entry
									; $084); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$E8..$368
FrameTiles085:						; the raw tiles of frame $085 (FrameTileSource / FrameBankLayout entry
									; $085); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$368..$568
FrameTiles086:						; the raw tiles of frame $086 (FrameTileSource / FrameBankLayout entry
									; $086); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$568..$768
FrameTiles087:						; the raw tiles of frame $087 (FrameTileSource / FrameBankLayout entry
									; $087); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$768..$968
FrameTiles088:						; the raw tiles of frame $088 (FrameTileSource / FrameBankLayout entry
									; $088); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$968..$B68
FrameTiles089:						; the raw tiles of frame $089 (FrameTileSource / FrameBankLayout entry
									; $089); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$B68..$D68
FrameTiles08A:						; the raw tiles of frame $08A (FrameTileSource / FrameBankLayout entry
									; $08A); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$D68..$F68
FrameTiles08B:						; the raw tiles of frame $08B (FrameTileSource / FrameBankLayout entry
									; $08B); pose not traced
	incbin "../../../Extracted/segments/bankC6_D000.bin":$F68..$1000
	incbin "../../../Extracted/segments/bankC6_E000.bin":$0..$1E8
FrameTiles08C:						; the raw tiles of frame $08C (FrameTileSource / FrameBankLayout entry
									; $08C); pose not traced
	incbin "../../../Extracted/segments/bankC6_E000.bin":$1E8..$468
FrameTiles08D:						; the raw tiles of frame $08D (FrameTileSource / FrameBankLayout entry
									; $08D); pose not traced
	incbin "../../../Extracted/segments/bankC6_E000.bin":$468..$6E8
FrameTiles08E:						; the raw tiles of frame $08E (FrameTileSource / FrameBankLayout entry
									; $08E); pose not traced
	incbin "../../../Extracted/segments/bankC6_E000.bin":$6E8..$968
FrameTiles08F:						; the raw tiles of frame $08F (FrameTileSource / FrameBankLayout entry
									; $08F); pose not traced
	incbin "../../../Extracted/segments/bankC6_E000.bin":$968..$BE8
FrameTiles090:						; the raw tiles of frame $090 (FrameTileSource / FrameBankLayout entry
									; $090); pose not traced
	incbin "../../../Extracted/segments/bankC6_E000.bin":$BE8..$E68
FrameTiles091:						; the raw tiles of frame $091 (FrameTileSource / FrameBankLayout entry
									; $091); pose not traced
	incbin "../../../Extracted/segments/bankC6_E000.bin":$E68..$1000
	incbin "../../../Extracted/segments/bankC6_F000.bin":$0..$68
FrameTiles092:						; the raw tiles of frame $092 (FrameTileSource / FrameBankLayout entry
									; $092); pose not traced
	incbin "../../../Extracted/segments/bankC6_F000.bin":$68..$2E8
FrameTiles093:						; the raw tiles of frame $093 (FrameTileSource / FrameBankLayout entry
									; $093); pose not traced
	incbin "../../../Extracted/segments/bankC6_F000.bin":$2E8..$4E8
FrameTiles094:						; the raw tiles of frame $094 (FrameTileSource / FrameBankLayout entry
									; $094); pose not traced
	incbin "../../../Extracted/segments/bankC6_F000.bin":$4E8..$6E8
FrameTiles095:						; the raw tiles of frame $095 (FrameTileSource / FrameBankLayout entry
									; $095); pose not traced
	incbin "../../../Extracted/segments/bankC6_F000.bin":$6E8..$968
FrameTiles096:						; the raw tiles of frame $096 (FrameTileSource / FrameBankLayout entry
									; $096); pose not traced
	incbin "../../../Extracted/segments/bankC6_F000.bin":$968..$B68
FrameTiles097:						; the raw tiles of frame $097 (FrameTileSource / FrameBankLayout entry
									; $097); pose not traced
	incbin "../../../Extracted/segments/bankC6_F000.bin":$B68..$DE8
endmacro

macro FrameTilesC7()
FrameTiles098:						; the raw tiles of frame $098 (FrameTileSource / FrameBankLayout entry
									; $098); pose not traced
	incbin "../../../Extracted/segments/bankC7_0000.bin":$53E..$7BE
FrameTiles099:						; the raw tiles of frame $099 (FrameTileSource / FrameBankLayout entry
									; $099); pose not traced
	incbin "../../../Extracted/segments/bankC7_0000.bin":$7BE..$A3E
FrameTiles09A:						; the raw tiles of frame $09A (FrameTileSource / FrameBankLayout entry
									; $09A); pose not traced
	incbin "../../../Extracted/segments/bankC7_0000.bin":$A3E..$CBE
FrameTiles09B:						; the raw tiles of frame $09B (FrameTileSource / FrameBankLayout entry
									; $09B); pose not traced
	incbin "../../../Extracted/segments/bankC7_0000.bin":$CBE..$EBE
FrameTiles09C:						; the raw tiles of frame $09C (FrameTileSource / FrameBankLayout entry
									; $09C); pose not traced
	incbin "../../../Extracted/segments/bankC7_0000.bin":$EBE..$1000
	incbin "../../../Extracted/segments/bankC7_1000.bin":$0..$BE
FrameTiles09D:						; the raw tiles of frame $09D (FrameTileSource / FrameBankLayout entry
									; $09D); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$BE..$2BE
FrameTiles09E:						; the raw tiles of frame $09E (FrameTileSource / FrameBankLayout entry
									; $09E); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$2BE..$4BE
FrameTiles09F:						; the raw tiles of frame $09F (FrameTileSource / FrameBankLayout entry
									; $09F); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$4BE..$6BE
FrameTiles0A0:						; the raw tiles of frame $0A0 (FrameTileSource / FrameBankLayout entry
									; $0A0); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$6BE..$8BE
FrameTiles0A1:						; the raw tiles of frame $0A1 (FrameTileSource / FrameBankLayout entry
									; $0A1); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$8BE..$ABE
FrameTiles0A2:						; the raw tiles of frame $0A2 (FrameTileSource / FrameBankLayout entry
									; $0A2); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$ABE..$D1E
FrameTiles0A3:						; the raw tiles of frame $0A3 (FrameTileSource / FrameBankLayout entry
									; $0A3); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$D1E..$F1E
FrameTiles0A4:						; the raw tiles of frame $0A4 (FrameTileSource / FrameBankLayout entry
									; $0A4); pose not traced
	incbin "../../../Extracted/segments/bankC7_1000.bin":$F1E..$1000
	incbin "../../../Extracted/segments/bankC7_2000.bin":$0..$19E
FrameTiles0A5:						; the raw tiles of frame $0A5 (FrameTileSource / FrameBankLayout entry
									; $0A5); pose not traced
	incbin "../../../Extracted/segments/bankC7_2000.bin":$19E..$39E
FrameTiles0A6:						; the raw tiles of frame $0A6 (FrameTileSource / FrameBankLayout entry
									; $0A6); pose not traced
	incbin "../../../Extracted/segments/bankC7_2000.bin":$39E..$61E
FrameTiles0A7:						; the raw tiles of frame $0A7 (FrameTileSource / FrameBankLayout entry
									; $0A7); pose not traced
	incbin "../../../Extracted/segments/bankC7_2000.bin":$61E..$81E
FrameTiles0A8:						; the raw tiles of frame $0A8 (FrameTileSource / FrameBankLayout entry
									; $0A8); pose not traced
	incbin "../../../Extracted/segments/bankC7_2000.bin":$81E..$A7E
FrameTiles0A9:						; the raw tiles of frame $0A9 (FrameTileSource / FrameBankLayout entry
									; $0A9); pose not traced
	incbin "../../../Extracted/segments/bankC7_2000.bin":$A7E..$C7E
FrameTiles0AA:						; the raw tiles of frame $0AA (FrameTileSource / FrameBankLayout entry
									; $0AA); pose not traced
	incbin "../../../Extracted/segments/bankC7_2000.bin":$C7E..$EDE
FrameTiles0AB:						; the raw tiles of frame $0AB (FrameTileSource / FrameBankLayout entry
									; $0AB); pose not traced
	incbin "../../../Extracted/segments/bankC7_2000.bin":$EDE..$1000
	incbin "../../../Extracted/segments/bankC7_3000.bin":$0..$15E
FrameTiles0AC:						; the raw tiles of frame $0AC (FrameTileSource / FrameBankLayout entry
									; $0AC); pose not traced
	incbin "../../../Extracted/segments/bankC7_3000.bin":$15E..$3DE
FrameTiles0AD:						; the raw tiles of frame $0AD (FrameTileSource / FrameBankLayout entry
									; $0AD); pose not traced
	incbin "../../../Extracted/segments/bankC7_3000.bin":$3DE..$65E
FrameTiles0AE:						; the raw tiles of frame $0AE (FrameTileSource / FrameBankLayout entry
									; $0AE); pose not traced
	incbin "../../../Extracted/segments/bankC7_3000.bin":$65E..$8BE
FrameTiles0AF:						; the raw tiles of frame $0AF (FrameTileSource / FrameBankLayout entry
									; $0AF); pose not traced
	incbin "../../../Extracted/segments/bankC7_3000.bin":$8BE..$B3E
FrameTiles0B0:						; the raw tiles of frame $0B0 (FrameTileSource / FrameBankLayout entry
									; $0B0); pose not traced
	incbin "../../../Extracted/segments/bankC7_3000.bin":$B3E..$D7E
FrameTiles0B1:						; the raw tiles of frame $0B1 (FrameTileSource / FrameBankLayout entry
									; $0B1); pose not traced
	incbin "../../../Extracted/segments/bankC7_3000.bin":$D7E..$FDE
FrameTiles0B2:						; the raw tiles of frame $0B2 (FrameTileSource / FrameBankLayout entry
									; $0B2); pose not traced
	incbin "../../../Extracted/segments/bankC7_3000.bin":$FDE..$1000
	incbin "../../../Extracted/segments/bankC7_4000.bin":$0..$23E
FrameTiles0B3:						; the raw tiles of frame $0B3 (FrameTileSource / FrameBankLayout entry
									; $0B3); pose not traced
	incbin "../../../Extracted/segments/bankC7_4000.bin":$23E..$4BE
FrameTiles0B4:						; the raw tiles of frame $0B4 (FrameTileSource / FrameBankLayout entry
									; $0B4); pose not traced
	incbin "../../../Extracted/segments/bankC7_4000.bin":$4BE..$73E
FrameTiles0B5:						; the raw tiles of frame $0B5 (FrameTileSource / FrameBankLayout entry
									; $0B5); pose not traced
	incbin "../../../Extracted/segments/bankC7_4000.bin":$73E..$9BE
FrameTiles0B6:						; the raw tiles of frame $0B6 (FrameTileSource / FrameBankLayout entry
									; $0B6); pose not traced
	incbin "../../../Extracted/segments/bankC7_4000.bin":$9BE..$C3E
FrameTiles0B7:						; the raw tiles of frame $0B7 (FrameTileSource / FrameBankLayout entry
									; $0B7); pose not traced
	incbin "../../../Extracted/segments/bankC7_4000.bin":$C3E..$EBE
FrameTiles0B8:						; the raw tiles of frame $0B8 (FrameTileSource / FrameBankLayout entry
									; $0B8); pose not traced
	incbin "../../../Extracted/segments/bankC7_4000.bin":$EBE..$1000
	incbin "../../../Extracted/segments/bankC7_5000.bin":$0..$13E
FrameTiles0B9:						; the raw tiles of frame $0B9 (FrameTileSource / FrameBankLayout entry
									; $0B9); pose not traced
	incbin "../../../Extracted/segments/bankC7_5000.bin":$13E..$39E
FrameTiles0BA:						; the raw tiles of frame $0BA (FrameTileSource / FrameBankLayout entry
									; $0BA); pose not traced
	incbin "../../../Extracted/segments/bankC7_5000.bin":$39E..$61E
FrameTiles0BB:						; the raw tiles of frame $0BB (FrameTileSource / FrameBankLayout entry
									; $0BB); pose not traced
	incbin "../../../Extracted/segments/bankC7_5000.bin":$61E..$87E
FrameTiles0BC:						; the raw tiles of frame $0BC (FrameTileSource / FrameBankLayout entry
									; $0BC); pose not traced
	incbin "../../../Extracted/segments/bankC7_5000.bin":$87E..$AFE
FrameTiles0BD:						; the raw tiles of frame $0BD (FrameTileSource / FrameBankLayout entry
									; $0BD); pose not traced
	incbin "../../../Extracted/segments/bankC7_5000.bin":$AFE..$D7E
FrameTiles0BE:						; the raw tiles of frame $0BE (FrameTileSource / FrameBankLayout entry
									; $0BE); pose not traced
	incbin "../../../Extracted/segments/bankC7_5000.bin":$D7E..$F9E
FrameTiles0BF:						; the raw tiles of frame $0BF (FrameTileSource / FrameBankLayout entry
									; $0BF); pose not traced
	incbin "../../../Extracted/segments/bankC7_5000.bin":$F9E..$1000
	incbin "../../../Extracted/segments/bankC7_6000.bin":$0..$21E
FrameTiles0C0:						; the raw tiles of frame $0C0 (FrameTileSource / FrameBankLayout entry
									; $0C0); pose not traced
	incbin "../../../Extracted/segments/bankC7_6000.bin":$21E..$49E
FrameTiles0C1:						; the raw tiles of frame $0C1 (FrameTileSource / FrameBankLayout entry
									; $0C1); pose not traced
	incbin "../../../Extracted/segments/bankC7_6000.bin":$49E..$71E
FrameTiles0C2:						; the raw tiles of frame $0C2 (FrameTileSource / FrameBankLayout entry
									; $0C2); pose not traced
	incbin "../../../Extracted/segments/bankC7_6000.bin":$71E..$99E
FrameTiles0C3:						; the raw tiles of frame $0C3 (FrameTileSource / FrameBankLayout entry
									; $0C3); pose not traced
	incbin "../../../Extracted/segments/bankC7_6000.bin":$99E..$C1E
FrameTiles0C4:						; the raw tiles of frame $0C4 (FrameTileSource / FrameBankLayout entry
									; $0C4); pose not traced
	incbin "../../../Extracted/segments/bankC7_6000.bin":$C1E..$E9E
FrameTiles0C5:						; the raw tiles of frame $0C5 (FrameTileSource / FrameBankLayout entry
									; $0C5); pose not traced
	incbin "../../../Extracted/segments/bankC7_6000.bin":$E9E..$1000
	incbin "../../../Extracted/segments/bankC7_7000.bin":$0..$FE
FrameTiles0C6:						; the raw tiles of frame $0C6 (FrameTileSource / FrameBankLayout entry
									; $0C6); pose not traced
	incbin "../../../Extracted/segments/bankC7_7000.bin":$FE..$37E
FrameTiles0C7:						; the raw tiles of frame $0C7 (FrameTileSource / FrameBankLayout entry
									; $0C7); pose not traced
	incbin "../../../Extracted/segments/bankC7_7000.bin":$37E..$5FE
FrameTiles0C8:						; the raw tiles of frame $0C8 (FrameTileSource / FrameBankLayout entry
									; $0C8); pose not traced
	incbin "../../../Extracted/segments/bankC7_7000.bin":$5FE..$87E
FrameTiles0C9:						; the raw tiles of frame $0C9 (FrameTileSource / FrameBankLayout entry
									; $0C9); pose not traced
	incbin "../../../Extracted/segments/bankC7_7000.bin":$87E..$AFE
FrameTiles0CA:						; the raw tiles of frame $0CA (FrameTileSource / FrameBankLayout entry
									; $0CA); pose not traced
	incbin "../../../Extracted/segments/bankC7_7000.bin":$AFE..$D1E
FrameTiles0CB:						; the raw tiles of frame $0CB (FrameTileSource / FrameBankLayout entry
									; $0CB); pose not traced
	incbin "../../../Extracted/segments/bankC7_7000.bin":$D1E..$F1E
FrameTiles0CC:						; the raw tiles of frame $0CC (FrameTileSource / FrameBankLayout entry
									; $0CC); pose not traced
	incbin "../../../Extracted/segments/bankC7_7000.bin":$F1E..$1000
	incbin "../../../Extracted/segments/bankC7_8000.bin":$0..$11E
FrameTiles0CD:						; the raw tiles of frame $0CD (FrameTileSource / FrameBankLayout entry
									; $0CD); pose not traced
	incbin "../../../Extracted/segments/bankC7_8000.bin":$11E..$31E
FrameTiles0CE:						; the raw tiles of frame $0CE (FrameTileSource / FrameBankLayout entry
									; $0CE); pose not traced
	incbin "../../../Extracted/segments/bankC7_8000.bin":$31E..$59E
FrameTiles0CF:						; the raw tiles of frame $0CF (FrameTileSource / FrameBankLayout entry
									; $0CF); pose not traced
	incbin "../../../Extracted/segments/bankC7_8000.bin":$59E..$81E
FrameTiles0D0:						; the raw tiles of frame $0D0 (FrameTileSource / FrameBankLayout entry
									; $0D0); pose not traced
	incbin "../../../Extracted/segments/bankC7_8000.bin":$81E..$A7E
FrameTiles0D1:						; the raw tiles of frame $0D1 (FrameTileSource / FrameBankLayout entry
									; $0D1); pose not traced
	incbin "../../../Extracted/segments/bankC7_8000.bin":$A7E..$CFE
FrameTiles0D2:						; the raw tiles of frame $0D2 (FrameTileSource / FrameBankLayout entry
									; $0D2); pose not traced
	incbin "../../../Extracted/segments/bankC7_8000.bin":$CFE..$F7E
FrameTiles0D3:						; the raw tiles of frame $0D3 (FrameTileSource / FrameBankLayout entry
									; $0D3); pose not traced
	incbin "../../../Extracted/segments/bankC7_8000.bin":$F7E..$1000
	incbin "../../../Extracted/segments/bankC7_9000.bin":$0..$1FE
FrameTiles0D4:						; the raw tiles of frame $0D4 (FrameTileSource / FrameBankLayout entry
									; $0D4); pose not traced
	incbin "../../../Extracted/segments/bankC7_9000.bin":$1FE..$47E
FrameTiles0D5:						; the raw tiles of frame $0D5 (FrameTileSource / FrameBankLayout entry
									; $0D5); pose not traced
	incbin "../../../Extracted/segments/bankC7_9000.bin":$47E..$6FE
FrameTiles0D6:						; the raw tiles of frame $0D6 (FrameTileSource / FrameBankLayout entry
									; $0D6); pose not traced
	incbin "../../../Extracted/segments/bankC7_9000.bin":$6FE..$91E
FrameTiles0D7:						; the raw tiles of frame $0D7 (FrameTileSource / FrameBankLayout entry
									; $0D7); pose not traced
	incbin "../../../Extracted/segments/bankC7_9000.bin":$91E..$B9E
FrameTiles0D8:						; the raw tiles of frame $0D8 (FrameTileSource / FrameBankLayout entry
									; $0D8); pose not traced
	incbin "../../../Extracted/segments/bankC7_9000.bin":$B9E..$E1E
FrameTiles0D9:						; the raw tiles of frame $0D9 (FrameTileSource / FrameBankLayout entry
									; $0D9); pose not traced
	incbin "../../../Extracted/segments/bankC7_9000.bin":$E1E..$1000
	incbin "../../../Extracted/segments/bankC7_A000.bin":$0..$7E
FrameTiles0DA:						; the raw tiles of frame $0DA (FrameTileSource / FrameBankLayout entry
									; $0DA); pose not traced
	incbin "../../../Extracted/segments/bankC7_A000.bin":$7E..$2FE
FrameTiles0DB:						; the raw tiles of frame $0DB (FrameTileSource / FrameBankLayout entry
									; $0DB); pose not traced
	incbin "../../../Extracted/segments/bankC7_A000.bin":$2FE..$57E
FrameTiles0DC:						; the raw tiles of frame $0DC (FrameTileSource / FrameBankLayout entry
									; $0DC); pose not traced
	incbin "../../../Extracted/segments/bankC7_A000.bin":$57E..$7FE
FrameTiles0DD:						; the raw tiles of frame $0DD (FrameTileSource / FrameBankLayout entry
									; $0DD); pose not traced
	incbin "../../../Extracted/segments/bankC7_A000.bin":$7FE..$A7E
FrameTiles0DE:						; the raw tiles of frame $0DE (FrameTileSource / FrameBankLayout entry
									; $0DE); pose not traced
	incbin "../../../Extracted/segments/bankC7_A000.bin":$A7E..$CFE
FrameTiles0DF:						; the raw tiles of frame $0DF (FrameTileSource / FrameBankLayout entry
									; $0DF); pose not traced
	incbin "../../../Extracted/segments/bankC7_A000.bin":$CFE..$F7E
FrameTiles0E0:						; the raw tiles of frame $0E0 (FrameTileSource / FrameBankLayout entry
									; $0E0); pose not traced
	incbin "../../../Extracted/segments/bankC7_A000.bin":$F7E..$1000
	incbin "../../../Extracted/segments/bankC7_B000.bin":$0..$1FE
FrameTiles0E1:						; the raw tiles of frame $0E1 (FrameTileSource / FrameBankLayout entry
									; $0E1); pose not traced
	incbin "../../../Extracted/segments/bankC7_B000.bin":$1FE..$47E
FrameTiles0E2:						; the raw tiles of frame $0E2 (FrameTileSource / FrameBankLayout entry
									; $0E2); pose not traced
	incbin "../../../Extracted/segments/bankC7_B000.bin":$47E..$6FE
FrameTiles0E3:						; the raw tiles of frame $0E3 (FrameTileSource / FrameBankLayout entry
									; $0E3); pose not traced
	incbin "../../../Extracted/segments/bankC7_B000.bin":$6FE..$97E
FrameTiles0E4:						; the raw tiles of frame $0E4 (FrameTileSource / FrameBankLayout entry
									; $0E4); pose not traced
	incbin "../../../Extracted/segments/bankC7_B000.bin":$97E..$BFE
FrameTiles0E5:						; the raw tiles of frame $0E5 (FrameTileSource / FrameBankLayout entry
									; $0E5); pose not traced
	incbin "../../../Extracted/segments/bankC7_B000.bin":$BFE..$E7E
FrameTiles0E6:						; the raw tiles of frame $0E6 (FrameTileSource / FrameBankLayout entry
									; $0E6); pose not traced
	incbin "../../../Extracted/segments/bankC7_B000.bin":$E7E..$1000
	incbin "../../../Extracted/segments/bankC7_C000.bin":$0..$FE
FrameTiles0E7:						; the raw tiles of frame $0E7 (FrameTileSource / FrameBankLayout entry
									; $0E7); pose not traced
	incbin "../../../Extracted/segments/bankC7_C000.bin":$FE..$31E
FrameTiles0E8:						; the raw tiles of frame $0E8 (FrameTileSource / FrameBankLayout entry
									; $0E8); pose not traced
	incbin "../../../Extracted/segments/bankC7_C000.bin":$31E..$59E
FrameTiles0E9:						; the raw tiles of frame $0E9 (FrameTileSource / FrameBankLayout entry
									; $0E9); pose not traced
	incbin "../../../Extracted/segments/bankC7_C000.bin":$59E..$7FE
FrameTiles0EA:						; the raw tiles of frame $0EA (FrameTileSource / FrameBankLayout entry
									; $0EA); pose not traced
	incbin "../../../Extracted/segments/bankC7_C000.bin":$7FE..$A5E
FrameTiles0EB:						; the raw tiles of frame $0EB (FrameTileSource / FrameBankLayout entry
									; $0EB); pose not traced
	incbin "../../../Extracted/segments/bankC7_C000.bin":$A5E..$CDE
FrameTiles0EC:						; the raw tiles of frame $0EC (FrameTileSource / FrameBankLayout entry
									; $0EC); pose not traced
	incbin "../../../Extracted/segments/bankC7_C000.bin":$CDE..$F5E
FrameTiles0ED:						; the raw tiles of frame $0ED (FrameTileSource / FrameBankLayout entry
									; $0ED); pose not traced
	incbin "../../../Extracted/segments/bankC7_C000.bin":$F5E..$1000
	incbin "../../../Extracted/segments/bankC7_D000.bin":$0..$1DE
FrameTiles0EE:						; the raw tiles of frame $0EE (FrameTileSource / FrameBankLayout entry
									; $0EE); pose not traced
	incbin "../../../Extracted/segments/bankC7_D000.bin":$1DE..$45E
FrameTiles0EF:						; the raw tiles of frame $0EF (FrameTileSource / FrameBankLayout entry
									; $0EF); pose not traced
	incbin "../../../Extracted/segments/bankC7_D000.bin":$45E..$6BE
FrameTiles0F0:						; the raw tiles of frame $0F0 (FrameTileSource / FrameBankLayout entry
									; $0F0); pose not traced
	incbin "../../../Extracted/segments/bankC7_D000.bin":$6BE..$93E
FrameTiles0F1:						; the raw tiles of frame $0F1 (FrameTileSource / FrameBankLayout entry
									; $0F1); pose not traced
	incbin "../../../Extracted/segments/bankC7_D000.bin":$93E..$BBE
FrameTiles0F2:						; the raw tiles of frame $0F2 (FrameTileSource / FrameBankLayout entry
									; $0F2); pose not traced
	incbin "../../../Extracted/segments/bankC7_D000.bin":$BBE..$E3E
FrameTiles0F3:						; the raw tiles of frame $0F3 (FrameTileSource / FrameBankLayout entry
									; $0F3); pose not traced
	incbin "../../../Extracted/segments/bankC7_D000.bin":$E3E..$1000
	incbin "../../../Extracted/segments/bankC7_E000.bin":$0..$BE
FrameTiles0F4:						; the raw tiles of frame $0F4 (FrameTileSource / FrameBankLayout entry
									; $0F4); pose not traced
	incbin "../../../Extracted/segments/bankC7_E000.bin":$BE..$33E
FrameTiles0F5:						; the raw tiles of frame $0F5 (FrameTileSource / FrameBankLayout entry
									; $0F5); pose not traced
	incbin "../../../Extracted/segments/bankC7_E000.bin":$33E..$5BE
FrameTiles0F6:						; the raw tiles of frame $0F6 (FrameTileSource / FrameBankLayout entry
									; $0F6); pose not traced
	incbin "../../../Extracted/segments/bankC7_E000.bin":$5BE..$7DE
FrameTiles0F7:						; the raw tiles of frame $0F7 (FrameTileSource / FrameBankLayout entry
									; $0F7); pose not traced
	incbin "../../../Extracted/segments/bankC7_E000.bin":$7DE..$A3E
FrameTiles0F8:						; the raw tiles of frame $0F8 (FrameTileSource / FrameBankLayout entry
									; $0F8); pose not traced
	incbin "../../../Extracted/segments/bankC7_E000.bin":$A3E..$C3E
FrameTiles0F9:						; the raw tiles of frame $0F9 (FrameTileSource / FrameBankLayout entry
									; $0F9); pose not traced
	incbin "../../../Extracted/segments/bankC7_E000.bin":$C3E..$E9E
FrameTiles0FA:						; the raw tiles of frame $0FA (FrameTileSource / FrameBankLayout entry
									; $0FA); pose not traced
	incbin "../../../Extracted/segments/bankC7_E000.bin":$E9E..$1000
	incbin "../../../Extracted/segments/bankC7_F000.bin":$0..$9E
FrameTiles0FB:						; the raw tiles of frame $0FB (FrameTileSource / FrameBankLayout entry
									; $0FB); pose not traced
	incbin "../../../Extracted/segments/bankC7_F000.bin":$9E..$31E
FrameTiles0FC:						; the raw tiles of frame $0FC (FrameTileSource / FrameBankLayout entry
									; $0FC); pose not traced
	incbin "../../../Extracted/segments/bankC7_F000.bin":$31E..$57E
FrameTiles0FD:						; the raw tiles of frame $0FD (FrameTileSource / FrameBankLayout entry
									; $0FD); pose not traced
	incbin "../../../Extracted/segments/bankC7_F000.bin":$57E..$77E
FrameTiles0FE:						; the raw tiles of frame $0FE (FrameTileSource / FrameBankLayout entry
									; $0FE); pose not traced
	incbin "../../../Extracted/segments/bankC7_F000.bin":$77E..$9DE
FrameTiles0FF:						; the raw tiles of frame $0FF (FrameTileSource / FrameBankLayout entry
									; $0FF); pose not traced
	incbin "../../../Extracted/segments/bankC7_F000.bin":$9DE..$C5E
FrameTiles100:						; the raw tiles of frame $100 (FrameTileSource / FrameBankLayout entry
									; $100); pose not traced
	incbin "../../../Extracted/segments/bankC7_F000.bin":$C5E..$E7E
endmacro

macro FrameTilesC8()
FrameTiles101:						; the raw tiles of frame $101 (FrameTileSource / FrameBankLayout entry
									; $101); pose not traced
	incbin "../../../Extracted/segments/bankC8_0000.bin":$559..$7D9
FrameTiles102:						; the raw tiles of frame $102 (FrameTileSource / FrameBankLayout entry
									; $102); pose not traced
	incbin "../../../Extracted/segments/bankC8_0000.bin":$7D9..$A59
FrameTiles103:						; the raw tiles of frame $103 (FrameTileSource / FrameBankLayout entry
									; $103); pose not traced
	incbin "../../../Extracted/segments/bankC8_0000.bin":$A59..$CD9
FrameTiles104:						; the raw tiles of frame $104 (FrameTileSource / FrameBankLayout entry
									; $104); pose not traced
	incbin "../../../Extracted/segments/bankC8_0000.bin":$CD9..$F59
FrameTiles105:						; the raw tiles of frame $105 (FrameTileSource / FrameBankLayout entry
									; $105); pose not traced
	incbin "../../../Extracted/segments/bankC8_0000.bin":$F59..$1000
	incbin "../../../Extracted/segments/bankC8_1000.bin":$0..$1B9
FrameTiles106:						; the raw tiles of frame $106 (FrameTileSource / FrameBankLayout entry
									; $106); pose not traced
	incbin "../../../Extracted/segments/bankC8_1000.bin":$1B9..$439
FrameTiles107:						; the raw tiles of frame $107 (FrameTileSource / FrameBankLayout entry
									; $107); pose not traced
	incbin "../../../Extracted/segments/bankC8_1000.bin":$439..$6B9
FrameTiles108:						; the raw tiles of frame $108 (FrameTileSource / FrameBankLayout entry
									; $108); pose not traced
	incbin "../../../Extracted/segments/bankC8_1000.bin":$6B9..$939
FrameTiles109:						; the raw tiles of frame $109 (FrameTileSource / FrameBankLayout entry
									; $109); pose not traced
	incbin "../../../Extracted/segments/bankC8_1000.bin":$939..$BB9
FrameTiles10A:						; the raw tiles of frame $10A (FrameTileSource / FrameBankLayout entry
									; $10A); pose not traced
	incbin "../../../Extracted/segments/bankC8_1000.bin":$BB9..$DB9
FrameTiles10B:						; the raw tiles of frame $10B (FrameTileSource / FrameBankLayout entry
									; $10B); pose not traced
	incbin "../../../Extracted/segments/bankC8_1000.bin":$DB9..$FB9
FrameTiles10C:						; the raw tiles of frame $10C (FrameTileSource / FrameBankLayout entry
									; $10C); pose not traced
	incbin "../../../Extracted/segments/bankC8_1000.bin":$FB9..$1000
	incbin "../../../Extracted/segments/bankC8_2000.bin":$0..$239
FrameTiles10D:						; the raw tiles of frame $10D (FrameTileSource / FrameBankLayout entry
									; $10D); pose not traced
	incbin "../../../Extracted/segments/bankC8_2000.bin":$239..$499
FrameTiles10E:						; the raw tiles of frame $10E (FrameTileSource / FrameBankLayout entry
									; $10E); pose not traced
	incbin "../../../Extracted/segments/bankC8_2000.bin":$499..$699
FrameTiles113:						; the raw tiles of frame $113 (FrameTileSource / FrameBankLayout entry
									; $113); pose not traced
	incbin "../../../Extracted/segments/bankC8_2000.bin":$699..$919
FrameTiles114:						; the raw tiles of frame $114 (FrameTileSource / FrameBankLayout entry
									; $114); pose not traced
	incbin "../../../Extracted/segments/bankC8_2000.bin":$919..$B99
FrameTiles115:						; the raw tiles of frame $115 (FrameTileSource / FrameBankLayout entry
									; $115); pose not traced
	incbin "../../../Extracted/segments/bankC8_2000.bin":$B99..$E19
FrameTiles116:						; the raw tiles of frame $116 (FrameTileSource / FrameBankLayout entry
									; $116); pose not traced
	incbin "../../../Extracted/segments/bankC8_2000.bin":$E19..$1000
	incbin "../../../Extracted/segments/bankC8_3000.bin":$0..$19
FrameTiles11B:						; the raw tiles of frame $11B (FrameTileSource / FrameBankLayout entry
									; $11B); pose not traced
	incbin "../../../Extracted/segments/bankC8_3000.bin":$19..$299
FrameTiles11C:						; the raw tiles of frame $11C (FrameTileSource / FrameBankLayout entry
									; $11C); pose not traced
	incbin "../../../Extracted/segments/bankC8_3000.bin":$299..$519
FrameTiles11D:						; the raw tiles of frame $11D (FrameTileSource / FrameBankLayout entry
									; $11D); pose not traced
	incbin "../../../Extracted/segments/bankC8_3000.bin":$519..$799
FrameTiles11E:						; the raw tiles of frame $11E (FrameTileSource / FrameBankLayout entry
									; $11E); pose not traced
	incbin "../../../Extracted/segments/bankC8_3000.bin":$799..$A19
FrameTiles123:						; the raw tiles of frame $123 (FrameTileSource / FrameBankLayout entry
									; $123); pose not traced
	incbin "../../../Extracted/segments/bankC8_3000.bin":$A19..$C39
FrameTiles124:						; the raw tiles of frame $124 (FrameTileSource / FrameBankLayout entry
									; $124); pose not traced
	incbin "../../../Extracted/segments/bankC8_3000.bin":$C39..$E99
FrameTiles125:						; the raw tiles of frame $125 (FrameTileSource / FrameBankLayout entry
									; $125); pose not traced
	incbin "../../../Extracted/segments/bankC8_3000.bin":$E99..$1000
	incbin "../../../Extracted/segments/bankC8_4000.bin":$0..$F9
FrameTiles126:						; the raw tiles of frame $126 (FrameTileSource / FrameBankLayout entry
									; $126); pose not traced
	incbin "../../../Extracted/segments/bankC8_4000.bin":$F9..$319
FrameTiles12B:						; the raw tiles of frame $12B (FrameTileSource / FrameBankLayout entry
									; $12B); pose not traced
	incbin "../../../Extracted/segments/bankC8_4000.bin":$319..$579
FrameTiles12C:						; the raw tiles of frame $12C (FrameTileSource / FrameBankLayout entry
									; $12C); pose not traced
	incbin "../../../Extracted/segments/bankC8_4000.bin":$579..$7D9
FrameTiles12D:						; the raw tiles of frame $12D (FrameTileSource / FrameBankLayout entry
									; $12D); pose not traced
	incbin "../../../Extracted/segments/bankC8_4000.bin":$7D9..$A39
FrameTiles12E:						; the raw tiles of frame $12E (FrameTileSource / FrameBankLayout entry
									; $12E); pose not traced
	incbin "../../../Extracted/segments/bankC8_4000.bin":$A39..$C99
FrameTiles133:						; the raw tiles of frame $133 (FrameTileSource / FrameBankLayout entry
									; $133); pose not traced
	incbin "../../../Extracted/segments/bankC8_4000.bin":$C99..$EF9
FrameTiles134:						; the raw tiles of frame $134 (FrameTileSource / FrameBankLayout entry
									; $134); pose not traced
	incbin "../../../Extracted/segments/bankC8_4000.bin":$EF9..$1000
	incbin "../../../Extracted/segments/bankC8_5000.bin":$0..$179
FrameTiles135:						; the raw tiles of frame $135 (FrameTileSource / FrameBankLayout entry
									; $135); pose not traced
	incbin "../../../Extracted/segments/bankC8_5000.bin":$179..$3B9
FrameTiles136:						; the raw tiles of frame $136 (FrameTileSource / FrameBankLayout entry
									; $136); pose not traced
	incbin "../../../Extracted/segments/bankC8_5000.bin":$3B9..$5F9
FrameTiles13B:						; the raw tiles of frame $13B (FrameTileSource / FrameBankLayout entry
									; $13B); pose not traced
	incbin "../../../Extracted/segments/bankC8_5000.bin":$5F9..$839
FrameTiles13C:						; the raw tiles of frame $13C (FrameTileSource / FrameBankLayout entry
									; $13C); pose not traced
	incbin "../../../Extracted/segments/bankC8_5000.bin":$839..$A79
FrameTiles13D:						; the raw tiles of frame $13D (FrameTileSource / FrameBankLayout entry
									; $13D); pose not traced
	incbin "../../../Extracted/segments/bankC8_5000.bin":$A79..$CD9
FrameTiles13E:						; the raw tiles of frame $13E (FrameTileSource / FrameBankLayout entry
									; $13E); pose not traced
	incbin "../../../Extracted/segments/bankC8_5000.bin":$CD9..$F39
FrameTiles143:						; the raw tiles of frame $143 (FrameTileSource / FrameBankLayout entry
									; $143); pose not traced
	incbin "../../../Extracted/segments/bankC8_5000.bin":$F39..$1000
	incbin "../../../Extracted/segments/bankC8_6000.bin":$0..$1B9
FrameTiles144:						; the raw tiles of frame $144 (FrameTileSource / FrameBankLayout entry
									; $144); pose not traced
	incbin "../../../Extracted/segments/bankC8_6000.bin":$1B9..$439
FrameTiles145:						; the raw tiles of frame $145 (FrameTileSource / FrameBankLayout entry
									; $145); pose not traced
	incbin "../../../Extracted/segments/bankC8_6000.bin":$439..$6B9
FrameTiles146:						; the raw tiles of frame $146 (FrameTileSource / FrameBankLayout entry
									; $146); pose not traced
	incbin "../../../Extracted/segments/bankC8_6000.bin":$6B9..$8F9
FrameTiles14C:						; the raw tiles of frame $14C (FrameTileSource / FrameBankLayout entry
									; $14C); pose not traced
	incbin "../../../Extracted/segments/bankC8_6000.bin":$8F9..$B59
FrameTiles14D:						; the raw tiles of frame $14D (FrameTileSource / FrameBankLayout entry
									; $14D); pose not traced
	incbin "../../../Extracted/segments/bankC8_6000.bin":$B59..$DB9
FrameTiles150:						; the raw tiles of frame $150 (FrameTileSource / FrameBankLayout entry
									; $150); pose not traced
	incbin "../../../Extracted/segments/bankC8_6000.bin":$DB9..$1000
	incbin "../../../Extracted/segments/bankC8_7000.bin":$0..$19
FrameTiles151:						; the raw tiles of frame $151 (FrameTileSource / FrameBankLayout entry
									; $151); pose not traced
	incbin "../../../Extracted/segments/bankC8_7000.bin":$19..$279
FrameTiles152:						; the raw tiles of frame $152 (FrameTileSource / FrameBankLayout entry
									; $152); pose not traced
	incbin "../../../Extracted/segments/bankC8_7000.bin":$279..$4D9
FrameTiles154:						; the raw tiles of frame $154 (FrameTileSource / FrameBankLayout entry
									; $154); pose not traced
	incbin "../../../Extracted/segments/bankC8_7000.bin":$4D9..$719
FrameTiles155:						; the raw tiles of frame $155 (FrameTileSource / FrameBankLayout entry
									; $155); pose not traced
	incbin "../../../Extracted/segments/bankC8_7000.bin":$719..$959
FrameTiles158:						; the raw tiles of frame $158 (FrameTileSource / FrameBankLayout entry
									; $158); pose not traced
	incbin "../../../Extracted/segments/bankC8_7000.bin":$959..$BB9
FrameTiles159:						; the raw tiles of frame $159 (FrameTileSource / FrameBankLayout entry
									; $159); pose not traced
	incbin "../../../Extracted/segments/bankC8_7000.bin":$BB9..$E19
FrameTiles15A:						; the raw tiles of frame $15A (FrameTileSource / FrameBankLayout entry
									; $15A); pose not traced
	incbin "../../../Extracted/segments/bankC8_7000.bin":$E19..$1000
	incbin "../../../Extracted/segments/bankC8_8000.bin":$0..$19
FrameTiles15C:						; the raw tiles of frame $15C (FrameTileSource / FrameBankLayout entry
									; $15C); pose not traced
	incbin "../../../Extracted/segments/bankC8_8000.bin":$19..$299
FrameTiles15D:						; the raw tiles of frame $15D (FrameTileSource / FrameBankLayout entry
									; $15D); pose not traced
	incbin "../../../Extracted/segments/bankC8_8000.bin":$299..$4F9
FrameTiles160:						; the raw tiles of frame $160 (FrameTileSource / FrameBankLayout entry
									; $160); pose not traced
	incbin "../../../Extracted/segments/bankC8_8000.bin":$4F9..$739
FrameTiles161:						; the raw tiles of frame $161 (FrameTileSource / FrameBankLayout entry
									; $161); pose not traced
	incbin "../../../Extracted/segments/bankC8_8000.bin":$739..$979
FrameTiles162:						; the raw tiles of frame $162 (FrameTileSource / FrameBankLayout entry
									; $162); pose not traced
	incbin "../../../Extracted/segments/bankC8_8000.bin":$979..$BB9
FrameTiles164:						; the raw tiles of frame $164 (FrameTileSource / FrameBankLayout entry
									; $164); pose not traced
	incbin "../../../Extracted/segments/bankC8_8000.bin":$BB9..$E19
FrameTiles165:						; the raw tiles of frame $165 (FrameTileSource / FrameBankLayout entry
									; $165); pose not traced
	incbin "../../../Extracted/segments/bankC8_8000.bin":$E19..$1000
	incbin "../../../Extracted/segments/bankC8_9000.bin":$0..$79
FrameTiles168:						; the raw tiles of frame $168 (FrameTileSource / FrameBankLayout entry
									; $168); pose not traced
	incbin "../../../Extracted/segments/bankC8_9000.bin":$79..$2D9
FrameTiles169:						; the raw tiles of frame $169 (FrameTileSource / FrameBankLayout entry
									; $169); pose not traced
	incbin "../../../Extracted/segments/bankC8_9000.bin":$2D9..$539
FrameTiles16A:						; the raw tiles of frame $16A (FrameTileSource / FrameBankLayout entry
									; $16A); pose not traced
	incbin "../../../Extracted/segments/bankC8_9000.bin":$539..$779
FrameTiles16C:						; the raw tiles of frame $16C (FrameTileSource / FrameBankLayout entry
									; $16C); pose not traced
	incbin "../../../Extracted/segments/bankC8_9000.bin":$779..$9D9
FrameTiles16D:						; the raw tiles of frame $16D (FrameTileSource / FrameBankLayout entry
									; $16D); pose not traced
	incbin "../../../Extracted/segments/bankC8_9000.bin":$9D9..$C39
FrameTiles170:						; the raw tiles of frame $170 (FrameTileSource / FrameBankLayout entry
									; $170); pose not traced
	incbin "../../../Extracted/segments/bankC8_9000.bin":$C39..$E99
FrameTiles171:						; the raw tiles of frame $171 (FrameTileSource / FrameBankLayout entry
									; $171); pose not traced
	incbin "../../../Extracted/segments/bankC8_9000.bin":$E99..$1000
	incbin "../../../Extracted/segments/bankC8_A000.bin":$0..$F9
FrameTiles172:						; the raw tiles of frame $172 (FrameTileSource / FrameBankLayout entry
									; $172); pose not traced
	incbin "../../../Extracted/segments/bankC8_A000.bin":$F9..$359
FrameTiles174:						; the raw tiles of frame $174 (FrameTileSource / FrameBankLayout entry
									; $174); pose not traced
	incbin "../../../Extracted/segments/bankC8_A000.bin":$359..$5D9
FrameTiles175:						; the raw tiles of frame $175 (FrameTileSource / FrameBankLayout entry
									; $175); pose not traced
	incbin "../../../Extracted/segments/bankC8_A000.bin":$5D9..$859
FrameTiles178:						; the raw tiles of frame $178 (FrameTileSource / FrameBankLayout entry
									; $178); pose not traced
	incbin "../../../Extracted/segments/bankC8_A000.bin":$859..$AB9
FrameTiles179:						; the raw tiles of frame $179 (FrameTileSource / FrameBankLayout entry
									; $179); pose not traced
	incbin "../../../Extracted/segments/bankC8_A000.bin":$AB9..$D19
FrameTiles17A:						; the raw tiles of frame $17A (FrameTileSource / FrameBankLayout entry
									; $17A); pose not traced
	incbin "../../../Extracted/segments/bankC8_A000.bin":$D19..$F19
FrameTiles17C:						; the raw tiles of frame $17C (FrameTileSource / FrameBankLayout entry
									; $17C); pose not traced
	incbin "../../../Extracted/segments/bankC8_A000.bin":$F19..$1000
	incbin "../../../Extracted/segments/bankC8_B000.bin":$0..$199
FrameTiles17D:						; the raw tiles of frame $17D (FrameTileSource / FrameBankLayout entry
									; $17D); pose not traced
	incbin "../../../Extracted/segments/bankC8_B000.bin":$199..$419
FrameTiles180:						; the raw tiles of frame $180 (FrameTileSource / FrameBankLayout entry
									; $180); pose not traced
	incbin "../../../Extracted/segments/bankC8_B000.bin":$419..$679
FrameTiles181:						; the raw tiles of frame $181 (FrameTileSource / FrameBankLayout entry
									; $181); pose not traced
	incbin "../../../Extracted/segments/bankC8_B000.bin":$679..$8F9
FrameTiles182:						; the raw tiles of frame $182 (FrameTileSource / FrameBankLayout entry
									; $182); pose not traced
	incbin "../../../Extracted/segments/bankC8_B000.bin":$8F9..$B79
FrameTiles184:						; the raw tiles of frame $184 (FrameTileSource / FrameBankLayout entry
									; $184); pose not traced
	incbin "../../../Extracted/segments/bankC8_B000.bin":$B79..$DF9
FrameTiles185:						; the raw tiles of frame $185 (FrameTileSource / FrameBankLayout entry
									; $185); pose not traced
	incbin "../../../Extracted/segments/bankC8_B000.bin":$DF9..$1000
	incbin "../../../Extracted/segments/bankC8_C000.bin":$0..$59
FrameTiles188:						; the raw tiles of frame $188 (FrameTileSource / FrameBankLayout entry
									; $188); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$59..$2D9
FrameTiles189:						; the raw tiles of frame $189 (FrameTileSource / FrameBankLayout entry
									; $189); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$2D9..$559
FrameTiles18A:						; the raw tiles of frame $18A (FrameTileSource / FrameBankLayout entry
									; $18A); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$559..$759
FrameTiles1B3:						; the raw tiles of frame $1B3 (FrameTileSource / FrameBankLayout entry
									; $1B3); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$759..$779
FrameTiles1B4:						; the raw tiles of frame $1B4 (FrameTileSource / FrameBankLayout entry
									; $1B4); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$779..$799
FrameTiles1B5:						; the raw tiles of frame $1B5 (FrameTileSource / FrameBankLayout entry
									; $1B5); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$799..$7B9
FrameTiles1B6:						; the raw tiles of frame $1B6 (FrameTileSource / FrameBankLayout entry
									; $1B6); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$7B9..$7D9
FrameTiles1B7:						; the raw tiles of frame $1B7 (FrameTileSource / FrameBankLayout entry
									; $1B7); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$7D9..$7F9
FrameTiles1B8:						; the raw tiles of frame $1B8 (FrameTileSource / FrameBankLayout entry
									; $1B8); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$7F9..$819
FrameTiles1B9:						; the raw tiles of frame $1B9 (FrameTileSource / FrameBankLayout entry
									; $1B9); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$819..$839
FrameTiles1BA:						; the raw tiles of frame $1BA (FrameTileSource / FrameBankLayout entry
									; $1BA); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$839..$859
FrameTiles1BB:						; the raw tiles of frame $1BB (FrameTileSource / FrameBankLayout entry
									; $1BB); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$859..$879
FrameTiles1BC:						; the raw tiles of frame $1BC (FrameTileSource / FrameBankLayout entry
									; $1BC); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$879..$899
FrameTiles1BD:						; the raw tiles of frame $1BD (FrameTileSource / FrameBankLayout entry
									; $1BD); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$899..$8B9
FrameTiles1BE:						; the raw tiles of frame $1BE (FrameTileSource / FrameBankLayout entry
									; $1BE); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$8B9..$B19
FrameTiles1BF:						; the raw tiles of frame $1BF (FrameTileSource / FrameBankLayout entry
									; $1BF); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$B19..$D19
FrameTiles1C0:						; the raw tiles of frame $1C0 (FrameTileSource / FrameBankLayout entry
									; $1C0); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$D19..$F19
FrameTiles1C1:						; the raw tiles of frame $1C1 (FrameTileSource / FrameBankLayout entry
									; $1C1); pose not traced
	incbin "../../../Extracted/segments/bankC8_C000.bin":$F19..$1000
	incbin "../../../Extracted/segments/bankC8_D000.bin":$0..$199
FrameTiles1C2:						; the raw tiles of frame $1C2 (FrameTileSource / FrameBankLayout entry
									; $1C2); pose not traced
	incbin "../../../Extracted/segments/bankC8_D000.bin":$199..$419
FrameTiles1C3:						; the raw tiles of frame $1C3 (FrameTileSource / FrameBankLayout entry
									; $1C3); pose not traced
	incbin "../../../Extracted/segments/bankC8_D000.bin":$419..$699
FrameTiles1C4:						; the raw tiles of frame $1C4 (FrameTileSource / FrameBankLayout entry
									; $1C4); pose not traced
	incbin "../../../Extracted/segments/bankC8_D000.bin":$699..$8B9
FrameTiles1C5:						; the raw tiles of frame $1C5 (FrameTileSource / FrameBankLayout entry
									; $1C5); pose not traced
	incbin "../../../Extracted/segments/bankC8_D000.bin":$8B9..$AD9
FrameTiles1C6:						; the raw tiles of frame $1C6 (FrameTileSource / FrameBankLayout entry
									; $1C6); pose not traced
	incbin "../../../Extracted/segments/bankC8_D000.bin":$AD9..$CD9
FrameTiles1C7:						; the raw tiles of frame $1C7 (FrameTileSource / FrameBankLayout entry
									; $1C7); pose not traced
	incbin "../../../Extracted/segments/bankC8_D000.bin":$CD9..$ED9
FrameTiles1C8:						; the raw tiles of frame $1C8 (FrameTileSource / FrameBankLayout entry
									; $1C8); pose not traced
	incbin "../../../Extracted/segments/bankC8_D000.bin":$ED9..$1000
	incbin "../../../Extracted/segments/bankC8_E000.bin":$0..$139
FrameTiles1C9:						; the raw tiles of frame $1C9 (FrameTileSource / FrameBankLayout entry
									; $1C9); pose not traced
	incbin "../../../Extracted/segments/bankC8_E000.bin":$139..$3B9
FrameTiles1CA:						; the raw tiles of frame $1CA (FrameTileSource / FrameBankLayout entry
									; $1CA); pose not traced
	incbin "../../../Extracted/segments/bankC8_E000.bin":$3B9..$639
FrameTiles1CB:						; the raw tiles of frame $1CB (FrameTileSource / FrameBankLayout entry
									; $1CB); pose not traced
	incbin "../../../Extracted/segments/bankC8_E000.bin":$639..$8B9
FrameTiles1CC:						; the raw tiles of frame $1CC (FrameTileSource / FrameBankLayout entry
									; $1CC); pose not traced
	incbin "../../../Extracted/segments/bankC8_E000.bin":$8B9..$B39
FrameTiles1CD:						; the raw tiles of frame $1CD (FrameTileSource / FrameBankLayout entry
									; $1CD); pose not traced
	incbin "../../../Extracted/segments/bankC8_E000.bin":$B39..$D59
FrameTiles1CE:						; the raw tiles of frame $1CE (FrameTileSource / FrameBankLayout entry
									; $1CE); pose not traced
	incbin "../../../Extracted/segments/bankC8_E000.bin":$D59..$F59
FrameTiles1CF:						; the raw tiles of frame $1CF (FrameTileSource / FrameBankLayout entry
									; $1CF); pose not traced
	incbin "../../../Extracted/segments/bankC8_E000.bin":$F59..$1000
	incbin "../../../Extracted/segments/bankC8_F000.bin":$0..$1B9
FrameTiles1D0:						; the raw tiles of frame $1D0 (FrameTileSource / FrameBankLayout entry
									; $1D0); pose not traced
	incbin "../../../Extracted/segments/bankC8_F000.bin":$1B9..$439
FrameTiles1D1:						; the raw tiles of frame $1D1 (FrameTileSource / FrameBankLayout entry
									; $1D1); pose not traced
	incbin "../../../Extracted/segments/bankC8_F000.bin":$439..$6B9
FrameTiles1D2:						; the raw tiles of frame $1D2 (FrameTileSource / FrameBankLayout entry
									; $1D2); pose not traced
	incbin "../../../Extracted/segments/bankC8_F000.bin":$6B9..$939
FrameTiles1D3:						; the raw tiles of frame $1D3 (FrameTileSource / FrameBankLayout entry
									; $1D3); pose not traced
	incbin "../../../Extracted/segments/bankC8_F000.bin":$939..$BB9
FrameTiles1D4:						; the raw tiles of frame $1D4 (FrameTileSource / FrameBankLayout entry
									; $1D4); pose not traced
	incbin "../../../Extracted/segments/bankC8_F000.bin":$BB9..$E39
endmacro

macro FrameTilesC9()
FrameTiles1D5:						; the raw tiles of frame $1D5 (FrameTileSource / FrameBankLayout entry
									; $1D5); pose not traced
	incbin "../../../Extracted/segments/bankC9_0000.bin":$76B..$96B
FrameTiles1D6:						; the raw tiles of frame $1D6 (FrameTileSource / FrameBankLayout entry
									; $1D6); pose not traced
	incbin "../../../Extracted/segments/bankC9_0000.bin":$96B..$BCB
FrameTiles1D7:						; the raw tiles of frame $1D7 (FrameTileSource / FrameBankLayout entry
									; $1D7); pose not traced
	incbin "../../../Extracted/segments/bankC9_0000.bin":$BCB..$E4B
FrameTiles1D8:						; the raw tiles of frame $1D8 (FrameTileSource / FrameBankLayout entry
									; $1D8); pose not traced
	incbin "../../../Extracted/segments/bankC9_0000.bin":$E4B..$1000
	incbin "../../../Extracted/segments/bankC9_1000.bin":$0..$CB
FrameTiles1D9:						; the raw tiles of frame $1D9 (FrameTileSource / FrameBankLayout entry
									; $1D9); pose not traced
	incbin "../../../Extracted/segments/bankC9_1000.bin":$CB..$34B
FrameTiles1DA:						; the raw tiles of frame $1DA (FrameTileSource / FrameBankLayout entry
									; $1DA); pose not traced
	incbin "../../../Extracted/segments/bankC9_1000.bin":$34B..$5AB
FrameTiles1DB:						; the raw tiles of frame $1DB (FrameTileSource / FrameBankLayout entry
									; $1DB); pose not traced
	incbin "../../../Extracted/segments/bankC9_1000.bin":$5AB..$7AB
FrameTiles1DC:						; the raw tiles of frame $1DC (FrameTileSource / FrameBankLayout entry
									; $1DC); pose not traced
	incbin "../../../Extracted/segments/bankC9_1000.bin":$7AB..$A0B
FrameTiles1DD:						; the raw tiles of frame $1DD (FrameTileSource / FrameBankLayout entry
									; $1DD); pose not traced
	incbin "../../../Extracted/segments/bankC9_1000.bin":$A0B..$C6B
FrameTiles1DE:						; the raw tiles of frame $1DE (FrameTileSource / FrameBankLayout entry
									; $1DE); pose not traced
	incbin "../../../Extracted/segments/bankC9_1000.bin":$C6B..$EEB
FrameTiles1DF:						; the raw tiles of frame $1DF (FrameTileSource / FrameBankLayout entry
									; $1DF); pose not traced
	incbin "../../../Extracted/segments/bankC9_1000.bin":$EEB..$1000
	incbin "../../../Extracted/segments/bankC9_2000.bin":$0..$16B
FrameTiles1E0:						; the raw tiles of frame $1E0 (FrameTileSource / FrameBankLayout entry
									; $1E0); pose not traced
	incbin "../../../Extracted/segments/bankC9_2000.bin":$16B..$3CB
FrameTiles1E1:						; the raw tiles of frame $1E1 (FrameTileSource / FrameBankLayout entry
									; $1E1); pose not traced
	incbin "../../../Extracted/segments/bankC9_2000.bin":$3CB..$62B
FrameTiles1E2:						; the raw tiles of frame $1E2 (FrameTileSource / FrameBankLayout entry
									; $1E2); pose not traced
	incbin "../../../Extracted/segments/bankC9_2000.bin":$62B..$8AB
FrameTiles1E3:						; the raw tiles of frame $1E3 (FrameTileSource / FrameBankLayout entry
									; $1E3); pose not traced
	incbin "../../../Extracted/segments/bankC9_2000.bin":$8AB..$B2B
FrameTiles1E4:						; the raw tiles of frame $1E4 (FrameTileSource / FrameBankLayout entry
									; $1E4); pose not traced
	incbin "../../../Extracted/segments/bankC9_2000.bin":$B2B..$DAB
FrameTiles1E5:						; the raw tiles of frame $1E5 (FrameTileSource / FrameBankLayout entry
									; $1E5); pose not traced
	incbin "../../../Extracted/segments/bankC9_2000.bin":$DAB..$1000
	incbin "../../../Extracted/segments/bankC9_3000.bin":$0..$2B
FrameTiles1E6:						; the raw tiles of frame $1E6 (FrameTileSource / FrameBankLayout entry
									; $1E6); pose not traced
	incbin "../../../Extracted/segments/bankC9_3000.bin":$2B..$22B
FrameTiles1E7:						; the raw tiles of frame $1E7 (FrameTileSource / FrameBankLayout entry
									; $1E7); pose not traced
	incbin "../../../Extracted/segments/bankC9_3000.bin":$22B..$42B
FrameTiles1E8:						; the raw tiles of frame $1E8 (FrameTileSource / FrameBankLayout entry
									; $1E8); pose not traced
	incbin "../../../Extracted/segments/bankC9_3000.bin":$42B..$6AB
FrameTiles1E9:						; the raw tiles of frame $1E9 (FrameTileSource / FrameBankLayout entry
									; $1E9); pose not traced
	incbin "../../../Extracted/segments/bankC9_3000.bin":$6AB..$90B
FrameTiles1EA:						; the raw tiles of frame $1EA (FrameTileSource / FrameBankLayout entry
									; $1EA); pose not traced
	incbin "../../../Extracted/segments/bankC9_3000.bin":$90B..$B8B
FrameTiles1EB:						; the raw tiles of frame $1EB (FrameTileSource / FrameBankLayout entry
									; $1EB); pose not traced
	incbin "../../../Extracted/segments/bankC9_3000.bin":$B8B..$DEB
FrameTiles1EC:						; the raw tiles of frame $1EC (FrameTileSource / FrameBankLayout entry
									; $1EC); pose not traced
	incbin "../../../Extracted/segments/bankC9_3000.bin":$DEB..$1000
	incbin "../../../Extracted/segments/bankC9_4000.bin":$0..$4B
FrameTiles1ED:						; the raw tiles of frame $1ED (FrameTileSource / FrameBankLayout entry
									; $1ED); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$4B..$2AB
FrameTiles1EE:						; the raw tiles of frame $1EE (FrameTileSource / FrameBankLayout entry
									; $1EE); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$2AB..$52B
FrameTiles1EF:						; the raw tiles of frame $1EF (FrameTileSource / FrameBankLayout entry
									; $1EF); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$52B..$7AB
FrameTiles1F0:						; the raw tiles of frame $1F0 (FrameTileSource / FrameBankLayout entry
									; $1F0); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$7AB..$9AB
FrameTiles1F1:						; the raw tiles of frame $1F1 (FrameTileSource / FrameBankLayout entry
									; $1F1); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$9AB..$BAB
FrameTiles1F2:						; the raw tiles of frame $1F2 (FrameTileSource / FrameBankLayout entry
									; $1F2); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$BAB..$DAB
FrameTiles1F3:						; the raw tiles of frame $1F3 (FrameTileSource / FrameBankLayout entry
									; $1F3); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$DAB..$FAB
FrameTiles1F4:						; the raw tiles of frame $1F4 (FrameTileSource / FrameBankLayout entry
									; $1F4); pose not traced
	incbin "../../../Extracted/segments/bankC9_4000.bin":$FAB..$1000
	incbin "../../../Extracted/segments/bankC9_5000.bin":$0..$1AB
FrameTiles1F5:						; the raw tiles of frame $1F5 (FrameTileSource / FrameBankLayout entry
									; $1F5); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$1AB..$3AB
FrameTiles1F6:						; the raw tiles of frame $1F6 (FrameTileSource / FrameBankLayout entry
									; $1F6); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$3AB..$5AB
FrameTiles1F7:						; the raw tiles of frame $1F7 (FrameTileSource / FrameBankLayout entry
									; $1F7); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$5AB..$7AB
FrameTiles1F8:						; the raw tiles of frame $1F8 (FrameTileSource / FrameBankLayout entry
									; $1F8); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$7AB..$9AB
FrameTiles1F9:						; the raw tiles of frame $1F9 (FrameTileSource / FrameBankLayout entry
									; $1F9); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$9AB..$BAB
FrameTiles1FA:						; the raw tiles of frame $1FA (FrameTileSource / FrameBankLayout entry
									; $1FA); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$BAB..$DAB
FrameTiles1FB:						; the raw tiles of frame $1FB (FrameTileSource / FrameBankLayout entry
									; $1FB); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$DAB..$FAB
FrameTiles1FC:						; the raw tiles of frame $1FC (FrameTileSource / FrameBankLayout entry
									; $1FC); pose not traced
	incbin "../../../Extracted/segments/bankC9_5000.bin":$FAB..$1000
	incbin "../../../Extracted/segments/bankC9_6000.bin":$0..$20B
FrameTiles1FD:						; the raw tiles of frame $1FD (FrameTileSource / FrameBankLayout entry
									; $1FD); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$20B..$38B
FrameTiles1FE:						; the raw tiles of frame $1FE (FrameTileSource / FrameBankLayout entry
									; $1FE); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$38B..$50B
FrameTiles1FF:						; the raw tiles of frame $1FF (FrameTileSource / FrameBankLayout entry
									; $1FF); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$50B..$68B
FrameTiles200:						; the raw tiles of frame $200 (FrameTileSource / FrameBankLayout entry
									; $200); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$68B..$80B
FrameTiles201:						; the raw tiles of frame $201 (FrameTileSource / FrameBankLayout entry
									; $201); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$80B..$98B
FrameTiles202:						; the raw tiles of frame $202 (FrameTileSource / FrameBankLayout entry
									; $202); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$98B..$B8B
FrameTiles203:						; the raw tiles of frame $203 (FrameTileSource / FrameBankLayout entry
									; $203); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$B8B..$D8B
FrameTiles204:						; the raw tiles of frame $204 (FrameTileSource / FrameBankLayout entry
									; $204); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$D8B..$F8B
FrameTiles205:						; the raw tiles of frame $205 (FrameTileSource / FrameBankLayout entry
									; $205); pose not traced
	incbin "../../../Extracted/segments/bankC9_6000.bin":$F8B..$1000
	incbin "../../../Extracted/segments/bankC9_7000.bin":$0..$18B
FrameTiles206:						; the raw tiles of frame $206 (FrameTileSource / FrameBankLayout entry
									; $206); pose not traced
	incbin "../../../Extracted/segments/bankC9_7000.bin":$18B..$40B
FrameTiles207:						; the raw tiles of frame $207 (FrameTileSource / FrameBankLayout entry
									; $207); pose not traced
	incbin "../../../Extracted/segments/bankC9_7000.bin":$40B..$68B
FrameTiles208:						; the raw tiles of frame $208 (FrameTileSource / FrameBankLayout entry
									; $208); pose not traced
	incbin "../../../Extracted/segments/bankC9_7000.bin":$68B..$8EB
FrameTiles209:						; the raw tiles of frame $209 (FrameTileSource / FrameBankLayout entry
									; $209); pose not traced
	incbin "../../../Extracted/segments/bankC9_7000.bin":$8EB..$B4B
FrameTiles20A:						; the raw tiles of frame $20A (FrameTileSource / FrameBankLayout entry
									; $20A); pose not traced
	incbin "../../../Extracted/segments/bankC9_7000.bin":$B4B..$DAB
FrameTiles20B:						; the raw tiles of frame $20B (FrameTileSource / FrameBankLayout entry
									; $20B); pose not traced
	incbin "../../../Extracted/segments/bankC9_7000.bin":$DAB..$1000
	incbin "../../../Extracted/segments/bankC9_8000.bin":$0..$B
FrameTiles20C:						; the raw tiles of frame $20C (FrameTileSource / FrameBankLayout entry
									; $20C); pose not traced
	incbin "../../../Extracted/segments/bankC9_8000.bin":$B..$26B
FrameTiles20D:						; the raw tiles of frame $20D (FrameTileSource / FrameBankLayout entry
									; $20D); pose not traced
	incbin "../../../Extracted/segments/bankC9_8000.bin":$26B..$4CB
FrameTiles20E:						; the raw tiles of frame $20E (FrameTileSource / FrameBankLayout entry
									; $20E); pose not traced
	incbin "../../../Extracted/segments/bankC9_8000.bin":$4CB..$72B
FrameTiles20F:						; the raw tiles of frame $20F (FrameTileSource / FrameBankLayout entry
									; $20F); pose not traced
	incbin "../../../Extracted/segments/bankC9_8000.bin":$72B..$98B
FrameTiles210:						; the raw tiles of frame $210 (FrameTileSource / FrameBankLayout entry
									; $210); pose not traced
	incbin "../../../Extracted/segments/bankC9_8000.bin":$98B..$BEB
FrameTiles211:						; the raw tiles of frame $211 (FrameTileSource / FrameBankLayout entry
									; $211); pose not traced
	incbin "../../../Extracted/segments/bankC9_8000.bin":$BEB..$E4B
FrameTiles212:						; the raw tiles of frame $212 (FrameTileSource / FrameBankLayout entry
									; $212); pose not traced
	incbin "../../../Extracted/segments/bankC9_8000.bin":$E4B..$1000
	incbin "../../../Extracted/segments/bankC9_9000.bin":$0..$AB
FrameTiles213:						; the raw tiles of frame $213 (FrameTileSource / FrameBankLayout entry
									; $213); pose not traced
	incbin "../../../Extracted/segments/bankC9_9000.bin":$AB..$30B
FrameTiles214:						; the raw tiles of frame $214 (FrameTileSource / FrameBankLayout entry
									; $214); pose not traced
	incbin "../../../Extracted/segments/bankC9_9000.bin":$30B..$58B
FrameTiles215:						; the raw tiles of frame $215 (FrameTileSource / FrameBankLayout entry
									; $215); pose not traced
	incbin "../../../Extracted/segments/bankC9_9000.bin":$58B..$80B
FrameTiles216:						; the raw tiles of frame $216 (FrameTileSource / FrameBankLayout entry
									; $216); pose not traced
	incbin "../../../Extracted/segments/bankC9_9000.bin":$80B..$A8B
FrameTiles217:						; the raw tiles of frame $217 (FrameTileSource / FrameBankLayout entry
									; $217); pose not traced
	incbin "../../../Extracted/segments/bankC9_9000.bin":$A8B..$D0B
FrameTiles218:						; the raw tiles of frame $218 (FrameTileSource / FrameBankLayout entry
									; $218); pose not traced
	incbin "../../../Extracted/segments/bankC9_9000.bin":$D0B..$F8B
FrameTiles219:						; the raw tiles of frame $219 (FrameTileSource / FrameBankLayout entry
									; $219); pose not traced
	incbin "../../../Extracted/segments/bankC9_9000.bin":$F8B..$1000
	incbin "../../../Extracted/segments/bankC9_A000.bin":$0..$20B
FrameTiles21A:						; the raw tiles of frame $21A (FrameTileSource / FrameBankLayout entry
									; $21A); pose not traced
	incbin "../../../Extracted/segments/bankC9_A000.bin":$20B..$48B
FrameTiles21B:						; the raw tiles of frame $21B (FrameTileSource / FrameBankLayout entry
									; $21B); pose not traced
	incbin "../../../Extracted/segments/bankC9_A000.bin":$48B..$70B
FrameTiles21C:						; the raw tiles of frame $21C (FrameTileSource / FrameBankLayout entry
									; $21C); pose not traced
	incbin "../../../Extracted/segments/bankC9_A000.bin":$70B..$98B
FrameTiles21D:						; the raw tiles of frame $21D (FrameTileSource / FrameBankLayout entry
									; $21D); pose not traced
	incbin "../../../Extracted/segments/bankC9_A000.bin":$98B..$C0B
FrameTiles21E:						; the raw tiles of frame $21E (FrameTileSource / FrameBankLayout entry
									; $21E); pose not traced
	incbin "../../../Extracted/segments/bankC9_A000.bin":$C0B..$E8B
FrameTiles21F:						; the raw tiles of frame $21F (FrameTileSource / FrameBankLayout entry
									; $21F); pose not traced
	incbin "../../../Extracted/segments/bankC9_A000.bin":$E8B..$1000
	incbin "../../../Extracted/segments/bankC9_B000.bin":$0..$10B
FrameTiles220:						; the raw tiles of frame $220 (FrameTileSource / FrameBankLayout entry
									; $220); pose not traced
	incbin "../../../Extracted/segments/bankC9_B000.bin":$10B..$38B
FrameTiles221:						; the raw tiles of frame $221 (FrameTileSource / FrameBankLayout entry
									; $221); pose not traced
	incbin "../../../Extracted/segments/bankC9_B000.bin":$38B..$5EB
FrameTiles222:						; the raw tiles of frame $222 (FrameTileSource / FrameBankLayout entry
									; $222); pose not traced
	incbin "../../../Extracted/segments/bankC9_B000.bin":$5EB..$84B
FrameTiles223:						; the raw tiles of frame $223 (FrameTileSource / FrameBankLayout entry
									; $223); pose not traced
	incbin "../../../Extracted/segments/bankC9_B000.bin":$84B..$AAB
FrameTiles224:						; the raw tiles of frame $224 (FrameTileSource / FrameBankLayout entry
									; $224); pose not traced
	incbin "../../../Extracted/segments/bankC9_B000.bin":$AAB..$D2B
FrameTiles225:						; the raw tiles of frame $225 (FrameTileSource / FrameBankLayout entry
									; $225); pose not traced
	incbin "../../../Extracted/segments/bankC9_B000.bin":$D2B..$F8B
FrameTiles226:						; the raw tiles of frame $226 (FrameTileSource / FrameBankLayout entry
									; $226); pose not traced
	incbin "../../../Extracted/segments/bankC9_B000.bin":$F8B..$1000
	incbin "../../../Extracted/segments/bankC9_C000.bin":$0..$18B
FrameTiles227:						; the raw tiles of frame $227 (FrameTileSource / FrameBankLayout entry
									; $227); pose not traced
	incbin "../../../Extracted/segments/bankC9_C000.bin":$18B..$3EB
FrameTiles228:						; the raw tiles of frame $228 (FrameTileSource / FrameBankLayout entry
									; $228); pose not traced
	incbin "../../../Extracted/segments/bankC9_C000.bin":$3EB..$66B
FrameTiles229:						; the raw tiles of frame $229 (FrameTileSource / FrameBankLayout entry
									; $229); pose not traced
	incbin "../../../Extracted/segments/bankC9_C000.bin":$66B..$8EB
FrameTiles22A:						; the raw tiles of frame $22A (FrameTileSource / FrameBankLayout entry
									; $22A); pose not traced
	incbin "../../../Extracted/segments/bankC9_C000.bin":$8EB..$AEB
FrameTiles22B:						; the raw tiles of frame $22B (FrameTileSource / FrameBankLayout entry
									; $22B); pose not traced
	incbin "../../../Extracted/segments/bankC9_C000.bin":$AEB..$D6B
FrameTiles22C:						; the raw tiles of frame $22C (FrameTileSource / FrameBankLayout entry
									; $22C); pose not traced
	incbin "../../../Extracted/segments/bankC9_C000.bin":$D6B..$F8B
FrameTiles22D:						; the raw tiles of frame $22D (FrameTileSource / FrameBankLayout entry
									; $22D); pose not traced
	incbin "../../../Extracted/segments/bankC9_C000.bin":$F8B..$1000
	incbin "../../../Extracted/segments/bankC9_D000.bin":$0..$20B
FrameTiles22E:						; the raw tiles of frame $22E (FrameTileSource / FrameBankLayout entry
									; $22E); pose not traced
	incbin "../../../Extracted/segments/bankC9_D000.bin":$20B..$48B
FrameTiles22F:						; the raw tiles of frame $22F (FrameTileSource / FrameBankLayout entry
									; $22F); pose not traced
	incbin "../../../Extracted/segments/bankC9_D000.bin":$48B..$6AB
FrameTiles230:						; the raw tiles of frame $230 (FrameTileSource / FrameBankLayout entry
									; $230); pose not traced
	incbin "../../../Extracted/segments/bankC9_D000.bin":$6AB..$92B
FrameTiles231:						; the raw tiles of frame $231 (FrameTileSource / FrameBankLayout entry
									; $231); pose not traced
	incbin "../../../Extracted/segments/bankC9_D000.bin":$92B..$B8B
FrameTiles232:						; the raw tiles of frame $232 (FrameTileSource / FrameBankLayout entry
									; $232); pose not traced
	incbin "../../../Extracted/segments/bankC9_D000.bin":$B8B..$DEB
FrameTiles233:						; the raw tiles of frame $233 (FrameTileSource / FrameBankLayout entry
									; $233); pose not traced
	incbin "../../../Extracted/segments/bankC9_D000.bin":$DEB..$1000
	incbin "../../../Extracted/segments/bankC9_E000.bin":$0..$4B
FrameTiles234:						; the raw tiles of frame $234 (FrameTileSource / FrameBankLayout entry
									; $234); pose not traced
	incbin "../../../Extracted/segments/bankC9_E000.bin":$4B..$2CB
FrameTiles235:						; the raw tiles of frame $235 (FrameTileSource / FrameBankLayout entry
									; $235); pose not traced
	incbin "../../../Extracted/segments/bankC9_E000.bin":$2CB..$52B
FrameTiles236:						; the raw tiles of frame $236 (FrameTileSource / FrameBankLayout entry
									; $236); pose not traced
	incbin "../../../Extracted/segments/bankC9_E000.bin":$52B..$78B
FrameTiles237:						; the raw tiles of frame $237 (FrameTileSource / FrameBankLayout entry
									; $237); pose not traced
	incbin "../../../Extracted/segments/bankC9_E000.bin":$78B..$A0B
FrameTiles238:						; the raw tiles of frame $238 (FrameTileSource / FrameBankLayout entry
									; $238); pose not traced
	incbin "../../../Extracted/segments/bankC9_E000.bin":$A0B..$C8B
FrameTiles239:						; the raw tiles of frame $239 (FrameTileSource / FrameBankLayout entry
									; $239); pose not traced
	incbin "../../../Extracted/segments/bankC9_E000.bin":$C8B..$EEB
FrameTiles23A:						; the raw tiles of frame $23A (FrameTileSource / FrameBankLayout entry
									; $23A); pose not traced
	incbin "../../../Extracted/segments/bankC9_E000.bin":$EEB..$1000
	incbin "../../../Extracted/segments/bankC9_F000.bin":$0..$14B
FrameTiles23B:						; the raw tiles of frame $23B (FrameTileSource / FrameBankLayout entry
									; $23B); pose not traced
	incbin "../../../Extracted/segments/bankC9_F000.bin":$14B..$3CB
FrameTiles23C:						; the raw tiles of frame $23C (FrameTileSource / FrameBankLayout entry
									; $23C); pose not traced
	incbin "../../../Extracted/segments/bankC9_F000.bin":$3CB..$62B
FrameTiles23D:						; the raw tiles of frame $23D (FrameTileSource / FrameBankLayout entry
									; $23D); pose not traced
	incbin "../../../Extracted/segments/bankC9_F000.bin":$62B..$8AB
FrameTiles23E:						; the raw tiles of frame $23E (FrameTileSource / FrameBankLayout entry
									; $23E); pose not traced
	incbin "../../../Extracted/segments/bankC9_F000.bin":$8AB..$B2B
FrameTiles23F:						; the raw tiles of frame $23F (FrameTileSource / FrameBankLayout entry
									; $23F); pose not traced
	incbin "../../../Extracted/segments/bankC9_F000.bin":$B2B..$D8B
FrameTiles240:						; the raw tiles of frame $240 (FrameTileSource / FrameBankLayout entry
									; $240); pose not traced
	incbin "../../../Extracted/segments/bankC9_F000.bin":$D8B..$FEB
endmacro

macro FrameTilesCA()
FrameTiles241:						; the raw tiles of frame $241 (FrameTileSource / FrameBankLayout entry
									; $241); pose not traced
	incbin "../../../Extracted/segments/bankCA_0000.bin":$9D9..$C39
FrameTiles242:						; the raw tiles of frame $242 (FrameTileSource / FrameBankLayout entry
									; $242); pose not traced
	incbin "../../../Extracted/segments/bankCA_0000.bin":$C39..$E99
FrameTiles243:						; the raw tiles of frame $243 (FrameTileSource / FrameBankLayout entry
									; $243); pose not traced
	incbin "../../../Extracted/segments/bankCA_0000.bin":$E99..$1000
	incbin "../../../Extracted/segments/bankCA_1000.bin":$0..$99
FrameTiles244:						; the raw tiles of frame $244 (FrameTileSource / FrameBankLayout entry
									; $244); pose not traced
	incbin "../../../Extracted/segments/bankCA_1000.bin":$99..$2F9
FrameTiles245:						; the raw tiles of frame $245 (FrameTileSource / FrameBankLayout entry
									; $245); pose not traced
	incbin "../../../Extracted/segments/bankCA_1000.bin":$2F9..$579
FrameTiles246:						; the raw tiles of frame $246 (FrameTileSource / FrameBankLayout entry
									; $246); pose not traced
	incbin "../../../Extracted/segments/bankCA_1000.bin":$579..$7F9
FrameTiles247:						; the raw tiles of frame $247 (FrameTileSource / FrameBankLayout entry
									; $247); pose not traced
	incbin "../../../Extracted/segments/bankCA_1000.bin":$7F9..$A79
FrameTiles248:						; the raw tiles of frame $248 (FrameTileSource / FrameBankLayout entry
									; $248); pose not traced
	incbin "../../../Extracted/segments/bankCA_1000.bin":$A79..$C79
FrameTiles249:						; the raw tiles of frame $249 (FrameTileSource / FrameBankLayout entry
									; $249); pose not traced
	incbin "../../../Extracted/segments/bankCA_1000.bin":$C79..$EF9
FrameTiles24A:						; the raw tiles of frame $24A (FrameTileSource / FrameBankLayout entry
									; $24A); pose not traced
	incbin "../../../Extracted/segments/bankCA_1000.bin":$EF9..$1000
	incbin "../../../Extracted/segments/bankCA_2000.bin":$0..$159
FrameTiles24B:						; the raw tiles of frame $24B (FrameTileSource / FrameBankLayout entry
									; $24B); pose not traced
	incbin "../../../Extracted/segments/bankCA_2000.bin":$159..$3D9
FrameTiles24C:						; the raw tiles of frame $24C (FrameTileSource / FrameBankLayout entry
									; $24C); pose not traced
	incbin "../../../Extracted/segments/bankCA_2000.bin":$3D9..$639
FrameTiles24D:						; the raw tiles of frame $24D (FrameTileSource / FrameBankLayout entry
									; $24D); pose not traced
	incbin "../../../Extracted/segments/bankCA_2000.bin":$639..$839
FrameTiles24E:						; the raw tiles of frame $24E (FrameTileSource / FrameBankLayout entry
									; $24E); pose not traced
	incbin "../../../Extracted/segments/bankCA_2000.bin":$839..$AB9
FrameTiles24F:						; the raw tiles of frame $24F (FrameTileSource / FrameBankLayout entry
									; $24F); pose not traced
	incbin "../../../Extracted/segments/bankCA_2000.bin":$AB9..$D19
FrameTiles250:						; the raw tiles of frame $250 (FrameTileSource / FrameBankLayout entry
									; $250); pose not traced
	incbin "../../../Extracted/segments/bankCA_2000.bin":$D19..$F99
FrameTiles251:						; the raw tiles of frame $251 (FrameTileSource / FrameBankLayout entry
									; $251); pose not traced
	incbin "../../../Extracted/segments/bankCA_2000.bin":$F99..$1000
	incbin "../../../Extracted/segments/bankCA_3000.bin":$0..$219
FrameTiles252:						; the raw tiles of frame $252 (FrameTileSource / FrameBankLayout entry
									; $252); pose not traced
	incbin "../../../Extracted/segments/bankCA_3000.bin":$219..$439
FrameTiles253:						; the raw tiles of frame $253 (FrameTileSource / FrameBankLayout entry
									; $253); pose not traced
	incbin "../../../Extracted/segments/bankCA_3000.bin":$439..$6B9
FrameTiles254:						; the raw tiles of frame $254 (FrameTileSource / FrameBankLayout entry
									; $254); pose not traced
	incbin "../../../Extracted/segments/bankCA_3000.bin":$6B9..$939
FrameTiles255:						; the raw tiles of frame $255 (FrameTileSource / FrameBankLayout entry
									; $255); pose not traced
	incbin "../../../Extracted/segments/bankCA_3000.bin":$939..$B99
FrameTiles256:						; the raw tiles of frame $256 (FrameTileSource / FrameBankLayout entry
									; $256); pose not traced
	incbin "../../../Extracted/segments/bankCA_3000.bin":$B99..$DF9
FrameTiles257:						; the raw tiles of frame $257 (FrameTileSource / FrameBankLayout entry
									; $257); pose not traced
	incbin "../../../Extracted/segments/bankCA_3000.bin":$DF9..$1000
	incbin "../../../Extracted/segments/bankCA_4000.bin":$0..$79
FrameTiles258:						; the raw tiles of frame $258 (FrameTileSource / FrameBankLayout entry
									; $258); pose not traced
	incbin "../../../Extracted/segments/bankCA_4000.bin":$79..$2D9
FrameTiles259:						; the raw tiles of frame $259 (FrameTileSource / FrameBankLayout entry
									; $259); pose not traced
	incbin "../../../Extracted/segments/bankCA_4000.bin":$2D9..$559
FrameTiles25A:						; the raw tiles of frame $25A (FrameTileSource / FrameBankLayout entry
									; $25A); pose not traced
	incbin "../../../Extracted/segments/bankCA_4000.bin":$559..$7D9
FrameTiles25B:						; the raw tiles of frame $25B (FrameTileSource / FrameBankLayout entry
									; $25B); pose not traced
	incbin "../../../Extracted/segments/bankCA_4000.bin":$7D9..$A39
FrameTiles25C:						; the raw tiles of frame $25C (FrameTileSource / FrameBankLayout entry
									; $25C); pose not traced
	incbin "../../../Extracted/segments/bankCA_4000.bin":$A39..$CB9
FrameTiles25D:						; the raw tiles of frame $25D (FrameTileSource / FrameBankLayout entry
									; $25D); pose not traced
	incbin "../../../Extracted/segments/bankCA_4000.bin":$CB9..$F39
FrameTiles25E:						; the raw tiles of frame $25E (FrameTileSource / FrameBankLayout entry
									; $25E); pose not traced
	incbin "../../../Extracted/segments/bankCA_4000.bin":$F39..$1000
	incbin "../../../Extracted/segments/bankCA_5000.bin":$0..$139
FrameTiles25F:						; the raw tiles of frame $25F (FrameTileSource / FrameBankLayout entry
									; $25F); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$139..$339
FrameTiles260:						; the raw tiles of frame $260 (FrameTileSource / FrameBankLayout entry
									; $260); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$339..$539
FrameTiles261:						; the raw tiles of frame $261 (FrameTileSource / FrameBankLayout entry
									; $261); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$539..$739
FrameTiles262:						; the raw tiles of frame $262 (FrameTileSource / FrameBankLayout entry
									; $262); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$739..$939
FrameTiles263:						; the raw tiles of frame $263 (FrameTileSource / FrameBankLayout entry
									; $263); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$939..$B39
FrameTiles264:						; the raw tiles of frame $264 (FrameTileSource / FrameBankLayout entry
									; $264); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$B39..$D39
FrameTiles265:						; the raw tiles of frame $265 (FrameTileSource / FrameBankLayout entry
									; $265); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$D39..$F39
FrameTiles266:						; the raw tiles of frame $266 (FrameTileSource / FrameBankLayout entry
									; $266); pose not traced
	incbin "../../../Extracted/segments/bankCA_5000.bin":$F39..$1000
	incbin "../../../Extracted/segments/bankCA_6000.bin":$0..$139
FrameTiles267:						; the raw tiles of frame $267 (FrameTileSource / FrameBankLayout entry
									; $267); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$139..$339
FrameTiles268:						; the raw tiles of frame $268 (FrameTileSource / FrameBankLayout entry
									; $268); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$339..$539
FrameTiles269:						; the raw tiles of frame $269 (FrameTileSource / FrameBankLayout entry
									; $269); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$539..$739
FrameTiles26A:						; the raw tiles of frame $26A (FrameTileSource / FrameBankLayout entry
									; $26A); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$739..$939
FrameTiles26B:						; the raw tiles of frame $26B (FrameTileSource / FrameBankLayout entry
									; $26B); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$939..$B39
FrameTiles26C:						; the raw tiles of frame $26C (FrameTileSource / FrameBankLayout entry
									; $26C); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$B39..$D39
FrameTiles26D:						; the raw tiles of frame $26D (FrameTileSource / FrameBankLayout entry
									; $26D); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$D39..$F39
FrameTiles26E:						; the raw tiles of frame $26E (FrameTileSource / FrameBankLayout entry
									; $26E); pose not traced
	incbin "../../../Extracted/segments/bankCA_6000.bin":$F39..$1000
	incbin "../../../Extracted/segments/bankCA_7000.bin":$0..$199
FrameTiles26F:						; the raw tiles of frame $26F (FrameTileSource / FrameBankLayout entry
									; $26F); pose not traced
	incbin "../../../Extracted/segments/bankCA_7000.bin":$199..$419
FrameTiles270:						; the raw tiles of frame $270 (FrameTileSource / FrameBankLayout entry
									; $270); pose not traced
	incbin "../../../Extracted/segments/bankCA_7000.bin":$419..$679
FrameTiles271:						; the raw tiles of frame $271 (FrameTileSource / FrameBankLayout entry
									; $271); pose not traced
	incbin "../../../Extracted/segments/bankCA_7000.bin":$679..$8D9
FrameTiles272:						; the raw tiles of frame $272 (FrameTileSource / FrameBankLayout entry
									; $272); pose not traced
	incbin "../../../Extracted/segments/bankCA_7000.bin":$8D9..$B39
FrameTiles273:						; the raw tiles of frame $273 (FrameTileSource / FrameBankLayout entry
									; $273); pose not traced
	incbin "../../../Extracted/segments/bankCA_7000.bin":$B39..$D99
FrameTiles274:						; the raw tiles of frame $274 (FrameTileSource / FrameBankLayout entry
									; $274); pose not traced
	incbin "../../../Extracted/segments/bankCA_7000.bin":$D99..$F99
FrameTiles275:						; the raw tiles of frame $275 (FrameTileSource / FrameBankLayout entry
									; $275); pose not traced
	incbin "../../../Extracted/segments/bankCA_7000.bin":$F99..$1000
	incbin "../../../Extracted/segments/bankCA_8000.bin":$0..$1F9
FrameTiles276:						; the raw tiles of frame $276 (FrameTileSource / FrameBankLayout entry
									; $276); pose not traced
	incbin "../../../Extracted/segments/bankCA_8000.bin":$1F9..$459
FrameTiles277:						; the raw tiles of frame $277 (FrameTileSource / FrameBankLayout entry
									; $277); pose not traced
	incbin "../../../Extracted/segments/bankCA_8000.bin":$459..$659
FrameTiles278:						; the raw tiles of frame $278 (FrameTileSource / FrameBankLayout entry
									; $278); pose not traced
	incbin "../../../Extracted/segments/bankCA_8000.bin":$659..$859
FrameTiles279:						; the raw tiles of frame $279 (FrameTileSource / FrameBankLayout entry
									; $279); pose not traced
	incbin "../../../Extracted/segments/bankCA_8000.bin":$859..$A59
FrameTiles27A:						; the raw tiles of frame $27A (FrameTileSource / FrameBankLayout entry
									; $27A); pose not traced
	incbin "../../../Extracted/segments/bankCA_8000.bin":$A59..$C59
FrameTiles27B:						; the raw tiles of frame $27B (FrameTileSource / FrameBankLayout entry
									; $27B); pose not traced
	incbin "../../../Extracted/segments/bankCA_8000.bin":$C59..$E59
FrameTiles27C:						; the raw tiles of frame $27C (FrameTileSource / FrameBankLayout entry
									; $27C); pose not traced
	incbin "../../../Extracted/segments/bankCA_8000.bin":$E59..$1000
	incbin "../../../Extracted/segments/bankCA_9000.bin":$0..$B9
FrameTiles27D:						; the raw tiles of frame $27D (FrameTileSource / FrameBankLayout entry
									; $27D); pose not traced
	incbin "../../../Extracted/segments/bankCA_9000.bin":$B9..$319
FrameTiles27E:						; the raw tiles of frame $27E (FrameTileSource / FrameBankLayout entry
									; $27E); pose not traced
	incbin "../../../Extracted/segments/bankCA_9000.bin":$319..$519
FrameTiles27F:						; the raw tiles of frame $27F (FrameTileSource / FrameBankLayout entry
									; $27F); pose not traced
	incbin "../../../Extracted/segments/bankCA_9000.bin":$519..$779
FrameTiles280:						; the raw tiles of frame $280 (FrameTileSource / FrameBankLayout entry
									; $280); pose not traced
	incbin "../../../Extracted/segments/bankCA_9000.bin":$779..$9D9
FrameTiles281:						; the raw tiles of frame $281 (FrameTileSource / FrameBankLayout entry
									; $281); pose not traced
	incbin "../../../Extracted/segments/bankCA_9000.bin":$9D9..$BD9
FrameTiles282:						; the raw tiles of frame $282 (FrameTileSource / FrameBankLayout entry
									; $282); pose not traced
	incbin "../../../Extracted/segments/bankCA_9000.bin":$BD9..$DD9
FrameTiles283:						; the raw tiles of frame $283 (FrameTileSource / FrameBankLayout entry
									; $283); pose not traced
	incbin "../../../Extracted/segments/bankCA_9000.bin":$DD9..$1000
	incbin "../../../Extracted/segments/bankCA_A000.bin":$0..$39
FrameTiles284:						; the raw tiles of frame $284 (FrameTileSource / FrameBankLayout entry
									; $284); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$39..$239
FrameTiles285:						; the raw tiles of frame $285 (FrameTileSource / FrameBankLayout entry
									; $285); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$239..$439
FrameTiles286:						; the raw tiles of frame $286 (FrameTileSource / FrameBankLayout entry
									; $286); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$439..$699
FrameTiles288:						; the raw tiles of frame $288 (FrameTileSource / FrameBankLayout entry
									; $288); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$699..$899
FrameTiles289:						; the raw tiles of frame $289 (FrameTileSource / FrameBankLayout entry
									; $289); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$899..$AF9
FrameTiles28B:						; the raw tiles of frame $28B (FrameTileSource / FrameBankLayout entry
									; $28B); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$AF9..$D59
FrameTiles28C:						; the raw tiles of frame $28C (FrameTileSource / FrameBankLayout entry
									; $28C); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$D59..$FB9
FrameTiles28E:						; the raw tiles of frame $28E (FrameTileSource / FrameBankLayout entry
									; $28E); pose not traced
	incbin "../../../Extracted/segments/bankCA_A000.bin":$FB9..$1000
	incbin "../../../Extracted/segments/bankCA_B000.bin":$0..$219
FrameTiles28F:						; the raw tiles of frame $28F (FrameTileSource / FrameBankLayout entry
									; $28F); pose not traced
	incbin "../../../Extracted/segments/bankCA_B000.bin":$219..$419
FrameTiles291:						; the raw tiles of frame $291 (FrameTileSource / FrameBankLayout entry
									; $291); pose not traced
	incbin "../../../Extracted/segments/bankCA_B000.bin":$419..$699
FrameTiles292:						; the raw tiles of frame $292 (FrameTileSource / FrameBankLayout entry
									; $292); pose not traced
	incbin "../../../Extracted/segments/bankCA_B000.bin":$699..$899
FrameTiles294:						; the raw tiles of frame $294 (FrameTileSource / FrameBankLayout entry
									; $294); pose not traced
	incbin "../../../Extracted/segments/bankCA_B000.bin":$899..$AF9
FrameTiles295:						; the raw tiles of frame $295 (FrameTileSource / FrameBankLayout entry
									; $295); pose not traced
	incbin "../../../Extracted/segments/bankCA_B000.bin":$AF9..$D59
FrameTiles297:						; the raw tiles of frame $297 (FrameTileSource / FrameBankLayout entry
									; $297); pose not traced
	incbin "../../../Extracted/segments/bankCA_B000.bin":$D59..$FB9
FrameTiles298:						; the raw tiles of frame $298 (FrameTileSource / FrameBankLayout entry
									; $298); pose not traced
	incbin "../../../Extracted/segments/bankCA_B000.bin":$FB9..$1000
	incbin "../../../Extracted/segments/bankCA_C000.bin":$0..$219
FrameTiles29A:						; the raw tiles of frame $29A (FrameTileSource / FrameBankLayout entry
									; $29A); pose not traced
	incbin "../../../Extracted/segments/bankCA_C000.bin":$219..$479
FrameTiles29B:						; the raw tiles of frame $29B (FrameTileSource / FrameBankLayout entry
									; $29B); pose not traced
	incbin "../../../Extracted/segments/bankCA_C000.bin":$479..$679
FrameTiles29D:						; the raw tiles of frame $29D (FrameTileSource / FrameBankLayout entry
									; $29D); pose not traced
	incbin "../../../Extracted/segments/bankCA_C000.bin":$679..$8D9
FrameTiles29E:						; the raw tiles of frame $29E (FrameTileSource / FrameBankLayout entry
									; $29E); pose not traced
	incbin "../../../Extracted/segments/bankCA_C000.bin":$8D9..$AD9
FrameTiles29F:						; the raw tiles of frame $29F (FrameTileSource / FrameBankLayout entry
									; $29F); pose not traced
	incbin "../../../Extracted/segments/bankCA_C000.bin":$AD9..$CD9
FrameTiles2A0:						; the raw tiles of frame $2A0 (FrameTileSource / FrameBankLayout entry
									; $2A0); pose not traced
	incbin "../../../Extracted/segments/bankCA_C000.bin":$CD9..$ED9
FrameTiles2A1:						; the raw tiles of frame $2A1 (FrameTileSource / FrameBankLayout entry
									; $2A1); pose not traced
	incbin "../../../Extracted/segments/bankCA_C000.bin":$ED9..$1000
	incbin "../../../Extracted/segments/bankCA_D000.bin":$0..$D9
FrameTiles2A2:						; the raw tiles of frame $2A2 (FrameTileSource / FrameBankLayout entry
									; $2A2); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$D9..$339
FrameTiles2A3:						; the raw tiles of frame $2A3 (FrameTileSource / FrameBankLayout entry
									; $2A3); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$339..$539
FrameTiles2A4:						; the raw tiles of frame $2A4 (FrameTileSource / FrameBankLayout entry
									; $2A4); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$539..$739
FrameTiles2BD:						; the raw tiles of frame $2BD (FrameTileSource / FrameBankLayout entry
									; $2BD); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$739..$7B9
FrameTiles2BE:						; the raw tiles of frame $2BE (FrameTileSource / FrameBankLayout entry
									; $2BE); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$7B9..$839
FrameTiles2BF:						; the raw tiles of frame $2BF (FrameTileSource / FrameBankLayout entry
									; $2BF); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$839..$8B9
FrameTiles2C0:						; the raw tiles of frame $2C0 (FrameTileSource / FrameBankLayout entry
									; $2C0); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$8B9..$A39
FrameTiles2C1:						; the raw tiles of frame $2C1 (FrameTileSource / FrameBankLayout entry
									; $2C1); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$A39..$AB9
FrameTiles2C2:						; the raw tiles of frame $2C2 (FrameTileSource / FrameBankLayout entry
									; $2C2); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$AB9..$B39
FrameTiles2C3:						; the raw tiles of frame $2C3 (FrameTileSource / FrameBankLayout entry
									; $2C3); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$B39..$BB9
FrameTiles2C4:						; the raw tiles of frame $2C4 (FrameTileSource / FrameBankLayout entry
									; $2C4); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$BB9..$CB9
FrameTiles2C5:						; the raw tiles of frame $2C5 (FrameTileSource / FrameBankLayout entry
									; $2C5); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$CB9..$E39
FrameTiles2C6:						; the raw tiles of frame $2C6 (FrameTileSource / FrameBankLayout entry
									; $2C6); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$E39..$FB9
FrameTiles2C7:						; the raw tiles of frame $2C7 (FrameTileSource / FrameBankLayout entry
									; $2C7); pose not traced
	incbin "../../../Extracted/segments/bankCA_D000.bin":$FB9..$1000
	incbin "../../../Extracted/segments/bankCA_E000.bin":$0..$139
FrameTiles2C8:						; the raw tiles of frame $2C8 (FrameTileSource / FrameBankLayout entry
									; $2C8); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$139..$2B9
FrameTiles2C9:						; the raw tiles of frame $2C9 (FrameTileSource / FrameBankLayout entry
									; $2C9); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$2B9..$3B9
FrameTiles2CA:						; the raw tiles of frame $2CA (FrameTileSource / FrameBankLayout entry
									; $2CA); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$3B9..$4B9
FrameTiles2CB:						; the raw tiles of frame $2CB (FrameTileSource / FrameBankLayout entry
									; $2CB); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$4B9..$6B9
FrameTiles2CC:						; the raw tiles of frame $2CC (FrameTileSource / FrameBankLayout entry
									; $2CC); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$6B9..$939
FrameTiles2CD:						; the raw tiles of frame $2CD (FrameTileSource / FrameBankLayout entry
									; $2CD); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$939..$BB9
FrameTiles2CE:						; the raw tiles of frame $2CE (FrameTileSource / FrameBankLayout entry
									; $2CE); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$BB9..$E39
FrameTiles2CF:						; the raw tiles of frame $2CF (FrameTileSource / FrameBankLayout entry
									; $2CF); pose not traced
	incbin "../../../Extracted/segments/bankCA_E000.bin":$E39..$1000
	incbin "../../../Extracted/segments/bankCA_F000.bin":$0..$39
FrameTiles2D0:						; the raw tiles of frame $2D0 (FrameTileSource / FrameBankLayout entry
									; $2D0); pose not traced
	incbin "../../../Extracted/segments/bankCA_F000.bin":$39..$299
FrameTiles2D1:						; the raw tiles of frame $2D1 (FrameTileSource / FrameBankLayout entry
									; $2D1); pose not traced
	incbin "../../../Extracted/segments/bankCA_F000.bin":$299..$4F9
FrameTiles2D2:						; the raw tiles of frame $2D2 (FrameTileSource / FrameBankLayout entry
									; $2D2); pose not traced
	incbin "../../../Extracted/segments/bankCA_F000.bin":$4F9..$779
FrameTiles2D3:						; the raw tiles of frame $2D3 (FrameTileSource / FrameBankLayout entry
									; $2D3); pose not traced
	incbin "../../../Extracted/segments/bankCA_F000.bin":$779..$979
FrameTiles2D4:						; the raw tiles of frame $2D4 (FrameTileSource / FrameBankLayout entry
									; $2D4); pose not traced
	incbin "../../../Extracted/segments/bankCA_F000.bin":$979..$BF9
FrameTiles2D5:						; the raw tiles of frame $2D5 (FrameTileSource / FrameBankLayout entry
									; $2D5); pose not traced
	incbin "../../../Extracted/segments/bankCA_F000.bin":$BF9..$DF9
endmacro

macro FrameTilesCB()
FrameTiles2D6:						; the raw tiles of frame $2D6 (FrameTileSource / FrameBankLayout entry
									; $2D6); pose not traced
	incbin "../../../Extracted/segments/bankCB_0000.bin":$8B5..$B15
FrameTiles2D7:						; the raw tiles of frame $2D7 (FrameTileSource / FrameBankLayout entry
									; $2D7); pose not traced
	incbin "../../../Extracted/segments/bankCB_0000.bin":$B15..$D15
FrameTiles2D8:						; the raw tiles of frame $2D8 (FrameTileSource / FrameBankLayout entry
									; $2D8); pose not traced
	incbin "../../../Extracted/segments/bankCB_0000.bin":$D15..$F75
FrameTiles2D9:						; the raw tiles of frame $2D9 (FrameTileSource / FrameBankLayout entry
									; $2D9); pose not traced
	incbin "../../../Extracted/segments/bankCB_0000.bin":$F75..$1000
	incbin "../../../Extracted/segments/bankCB_1000.bin":$0..$175
FrameTiles2DA:						; the raw tiles of frame $2DA (FrameTileSource / FrameBankLayout entry
									; $2DA); pose not traced
	incbin "../../../Extracted/segments/bankCB_1000.bin":$175..$3D5
FrameTiles2DB:						; the raw tiles of frame $2DB (FrameTileSource / FrameBankLayout entry
									; $2DB); pose not traced
	incbin "../../../Extracted/segments/bankCB_1000.bin":$3D5..$635
FrameTiles2DC:						; the raw tiles of frame $2DC (FrameTileSource / FrameBankLayout entry
									; $2DC); pose not traced
	incbin "../../../Extracted/segments/bankCB_1000.bin":$635..$895
FrameTiles2DD:						; the raw tiles of frame $2DD (FrameTileSource / FrameBankLayout entry
									; $2DD); pose not traced
	incbin "../../../Extracted/segments/bankCB_1000.bin":$895..$AF5
FrameTiles2DE:						; the raw tiles of frame $2DE (FrameTileSource / FrameBankLayout entry
									; $2DE); pose not traced
	incbin "../../../Extracted/segments/bankCB_1000.bin":$AF5..$D55
FrameTiles2DF:						; the raw tiles of frame $2DF (FrameTileSource / FrameBankLayout entry
									; $2DF); pose not traced
	incbin "../../../Extracted/segments/bankCB_1000.bin":$D55..$F55
FrameTiles2E0:						; the raw tiles of frame $2E0 (FrameTileSource / FrameBankLayout entry
									; $2E0); pose not traced
	incbin "../../../Extracted/segments/bankCB_1000.bin":$F55..$1000
	incbin "../../../Extracted/segments/bankCB_2000.bin":$0..$155
FrameTiles2E1:						; the raw tiles of frame $2E1 (FrameTileSource / FrameBankLayout entry
									; $2E1); pose not traced
	incbin "../../../Extracted/segments/bankCB_2000.bin":$155..$3B5
FrameTiles2E2:						; the raw tiles of frame $2E2 (FrameTileSource / FrameBankLayout entry
									; $2E2); pose not traced
	incbin "../../../Extracted/segments/bankCB_2000.bin":$3B5..$615
FrameTiles2E3:						; the raw tiles of frame $2E3 (FrameTileSource / FrameBankLayout entry
									; $2E3); pose not traced
	incbin "../../../Extracted/segments/bankCB_2000.bin":$615..$815
FrameTiles2E4:						; the raw tiles of frame $2E4 (FrameTileSource / FrameBankLayout entry
									; $2E4); pose not traced
	incbin "../../../Extracted/segments/bankCB_2000.bin":$815..$A75
FrameTiles2E5:						; the raw tiles of frame $2E5 (FrameTileSource / FrameBankLayout entry
									; $2E5); pose not traced
	incbin "../../../Extracted/segments/bankCB_2000.bin":$A75..$C75
FrameTiles2E6:						; the raw tiles of frame $2E6 (FrameTileSource / FrameBankLayout entry
									; $2E6); pose not traced
	incbin "../../../Extracted/segments/bankCB_2000.bin":$C75..$ED5
FrameTiles2E7:						; the raw tiles of frame $2E7 (FrameTileSource / FrameBankLayout entry
									; $2E7); pose not traced
	incbin "../../../Extracted/segments/bankCB_2000.bin":$ED5..$1000
	incbin "../../../Extracted/segments/bankCB_3000.bin":$0..$D5
FrameTiles2E8:						; the raw tiles of frame $2E8 (FrameTileSource / FrameBankLayout entry
									; $2E8); pose not traced
	incbin "../../../Extracted/segments/bankCB_3000.bin":$D5..$2D5
FrameTiles2E9:						; the raw tiles of frame $2E9 (FrameTileSource / FrameBankLayout entry
									; $2E9); pose not traced
	incbin "../../../Extracted/segments/bankCB_3000.bin":$2D5..$4D5
FrameTiles2EA:						; the raw tiles of frame $2EA (FrameTileSource / FrameBankLayout entry
									; $2EA); pose not traced
	incbin "../../../Extracted/segments/bankCB_3000.bin":$4D5..$735
FrameTiles2EB:						; the raw tiles of frame $2EB (FrameTileSource / FrameBankLayout entry
									; $2EB); pose not traced
	incbin "../../../Extracted/segments/bankCB_3000.bin":$735..$995
FrameTiles2EC:						; the raw tiles of frame $2EC (FrameTileSource / FrameBankLayout entry
									; $2EC); pose not traced
	incbin "../../../Extracted/segments/bankCB_3000.bin":$995..$BF5
FrameTiles2ED:						; the raw tiles of frame $2ED (FrameTileSource / FrameBankLayout entry
									; $2ED); pose not traced
	incbin "../../../Extracted/segments/bankCB_3000.bin":$BF5..$DF5
FrameTiles2EE:						; the raw tiles of frame $2EE (FrameTileSource / FrameBankLayout entry
									; $2EE); pose not traced
	incbin "../../../Extracted/segments/bankCB_3000.bin":$DF5..$1000
	incbin "../../../Extracted/segments/bankCB_4000.bin":$0..$75
FrameTiles2EF:						; the raw tiles of frame $2EF (FrameTileSource / FrameBankLayout entry
									; $2EF); pose not traced
	incbin "../../../Extracted/segments/bankCB_4000.bin":$75..$275
FrameTiles2F0:						; the raw tiles of frame $2F0 (FrameTileSource / FrameBankLayout entry
									; $2F0); pose not traced
	incbin "../../../Extracted/segments/bankCB_4000.bin":$275..$4D5
FrameTiles2F1:						; the raw tiles of frame $2F1 (FrameTileSource / FrameBankLayout entry
									; $2F1); pose not traced
	incbin "../../../Extracted/segments/bankCB_4000.bin":$4D5..$6D5
FrameTiles2F2:						; the raw tiles of frame $2F2 (FrameTileSource / FrameBankLayout entry
									; $2F2); pose not traced
	incbin "../../../Extracted/segments/bankCB_4000.bin":$6D5..$935
FrameTiles312:						; the raw tiles of frame $312 (FrameTileSource / FrameBankLayout entry
									; $312); pose not traced
	incbin "../../../Extracted/segments/bankCB_4000.bin":$935..$BB5
FrameTiles319:						; the raw tiles of frame $319 (FrameTileSource / FrameBankLayout entry
									; $319); pose not traced
	incbin "../../../Extracted/segments/bankCB_4000.bin":$BB5..$DB5
FrameTiles32A:						; the raw tiles of frame $32A (FrameTileSource / FrameBankLayout entry
									; $32A); pose not traced
	incbin "../../../Extracted/segments/bankCB_4000.bin":$DB5..$1000
	incbin "../../../Extracted/segments/bankCB_5000.bin":$0..$15
FrameTiles32B:						; the raw tiles of frame $32B (FrameTileSource / FrameBankLayout entry
									; $32B); pose not traced
	incbin "../../../Extracted/segments/bankCB_5000.bin":$15..$295
FrameTiles32C:						; the raw tiles of frame $32C (FrameTileSource / FrameBankLayout entry
									; $32C); pose not traced
	incbin "../../../Extracted/segments/bankCB_5000.bin":$295..$515
FrameTiles32D:						; the raw tiles of frame $32D (FrameTileSource / FrameBankLayout entry
									; $32D); pose not traced
	incbin "../../../Extracted/segments/bankCB_5000.bin":$515..$715
FrameTiles32E:						; the raw tiles of frame $32E (FrameTileSource / FrameBankLayout entry
									; $32E); pose not traced
	incbin "../../../Extracted/segments/bankCB_5000.bin":$715..$975
FrameTiles32F:						; the raw tiles of frame $32F (FrameTileSource / FrameBankLayout entry
									; $32F); pose not traced
	incbin "../../../Extracted/segments/bankCB_5000.bin":$975..$BF5
FrameTiles330:						; the raw tiles of frame $330 (FrameTileSource / FrameBankLayout entry
									; $330); pose not traced
	incbin "../../../Extracted/segments/bankCB_5000.bin":$BF5..$E75
FrameTiles331:						; the raw tiles of frame $331 (FrameTileSource / FrameBankLayout entry
									; $331); pose not traced
	incbin "../../../Extracted/segments/bankCB_5000.bin":$E75..$1000
	incbin "../../../Extracted/segments/bankCB_6000.bin":$0..$D5
FrameTiles332:						; the raw tiles of frame $332 (FrameTileSource / FrameBankLayout entry
									; $332); pose not traced
	incbin "../../../Extracted/segments/bankCB_6000.bin":$D5..$335
FrameTiles333:						; the raw tiles of frame $333 (FrameTileSource / FrameBankLayout entry
									; $333); pose not traced
	incbin "../../../Extracted/segments/bankCB_6000.bin":$335..$535
FrameTiles334:						; the raw tiles of frame $334 (FrameTileSource / FrameBankLayout entry
									; $334); pose not traced
	incbin "../../../Extracted/segments/bankCB_6000.bin":$535..$795
FrameTiles335:						; the raw tiles of frame $335 (FrameTileSource / FrameBankLayout entry
									; $335); pose not traced
	incbin "../../../Extracted/segments/bankCB_6000.bin":$795..$9F5
FrameTiles336:						; the raw tiles of frame $336 (FrameTileSource / FrameBankLayout entry
									; $336); pose not traced
	incbin "../../../Extracted/segments/bankCB_6000.bin":$9F5..$C55
FrameTiles337:						; the raw tiles of frame $337 (FrameTileSource / FrameBankLayout entry
									; $337); pose not traced
	incbin "../../../Extracted/segments/bankCB_6000.bin":$C55..$E55
FrameTiles338:						; the raw tiles of frame $338 (FrameTileSource / FrameBankLayout entry
									; $338); pose not traced
	incbin "../../../Extracted/segments/bankCB_6000.bin":$E55..$1000
	incbin "../../../Extracted/segments/bankCB_7000.bin":$0..$D5
FrameTiles339:						; the raw tiles of frame $339 (FrameTileSource / FrameBankLayout entry
									; $339); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$D5..$2D5
FrameTiles33A:						; the raw tiles of frame $33A (FrameTileSource / FrameBankLayout entry
									; $33A); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$2D5..$4D5
FrameTiles33B:						; the raw tiles of frame $33B (FrameTileSource / FrameBankLayout entry
									; $33B); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$4D5..$6D5
FrameTiles33C:						; the raw tiles of frame $33C (FrameTileSource / FrameBankLayout entry
									; $33C); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$6D5..$935
FrameTiles33D:						; the raw tiles of frame $33D (FrameTileSource / FrameBankLayout entry
									; $33D); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$935..$B35
FrameTiles33E:						; the raw tiles of frame $33E (FrameTileSource / FrameBankLayout entry
									; $33E); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$B35..$D95
FrameTiles33F:						; the raw tiles of frame $33F (FrameTileSource / FrameBankLayout entry
									; $33F); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$D95..$F95
FrameTiles340:						; the raw tiles of frame $340 (FrameTileSource / FrameBankLayout entry
									; $340); pose not traced
	incbin "../../../Extracted/segments/bankCB_7000.bin":$F95..$1000
	incbin "../../../Extracted/segments/bankCB_8000.bin":$0..$1F5
FrameTiles341:						; the raw tiles of frame $341 (FrameTileSource / FrameBankLayout entry
									; $341); pose not traced
	incbin "../../../Extracted/segments/bankCB_8000.bin":$1F5..$3F5
FrameTiles342:						; the raw tiles of frame $342 (FrameTileSource / FrameBankLayout entry
									; $342); pose not traced
	incbin "../../../Extracted/segments/bankCB_8000.bin":$3F5..$5F5
FrameTiles343:						; the raw tiles of frame $343 (FrameTileSource / FrameBankLayout entry
									; $343); pose not traced
	incbin "../../../Extracted/segments/bankCB_8000.bin":$5F5..$7F5
FrameTiles344:						; the raw tiles of frame $344 (FrameTileSource / FrameBankLayout entry
									; $344); pose not traced
	incbin "../../../Extracted/segments/bankCB_8000.bin":$7F5..$9F5
FrameTiles345:						; the raw tiles of frame $345 (FrameTileSource / FrameBankLayout entry
									; $345); pose not traced
	incbin "../../../Extracted/segments/bankCB_8000.bin":$9F5..$BF5
FrameTiles346:						; the raw tiles of frame $346 (FrameTileSource / FrameBankLayout entry
									; $346); pose not traced
	incbin "../../../Extracted/segments/bankCB_8000.bin":$BF5..$E55
FrameTiles347:						; the raw tiles of frame $347 (FrameTileSource / FrameBankLayout entry
									; $347); pose not traced
	incbin "../../../Extracted/segments/bankCB_8000.bin":$E55..$1000
	incbin "../../../Extracted/segments/bankCB_9000.bin":$0..$D5
FrameTiles348:						; the raw tiles of frame $348 (FrameTileSource / FrameBankLayout entry
									; $348); pose not traced
	incbin "../../../Extracted/segments/bankCB_9000.bin":$D5..$335
FrameTiles349:						; the raw tiles of frame $349 (FrameTileSource / FrameBankLayout entry
									; $349); pose not traced
	incbin "../../../Extracted/segments/bankCB_9000.bin":$335..$5B5
FrameTiles34A:						; the raw tiles of frame $34A (FrameTileSource / FrameBankLayout entry
									; $34A); pose not traced
	incbin "../../../Extracted/segments/bankCB_9000.bin":$5B5..$815
FrameTiles34B:						; the raw tiles of frame $34B (FrameTileSource / FrameBankLayout entry
									; $34B); pose not traced
	incbin "../../../Extracted/segments/bankCB_9000.bin":$815..$A95
FrameTiles34C:						; the raw tiles of frame $34C (FrameTileSource / FrameBankLayout entry
									; $34C); pose not traced
	incbin "../../../Extracted/segments/bankCB_9000.bin":$A95..$C95
FrameTiles34D:						; the raw tiles of frame $34D (FrameTileSource / FrameBankLayout entry
									; $34D); pose not traced
	incbin "../../../Extracted/segments/bankCB_9000.bin":$C95..$F15
FrameTiles34E:						; the raw tiles of frame $34E (FrameTileSource / FrameBankLayout entry
									; $34E); pose not traced
	incbin "../../../Extracted/segments/bankCB_9000.bin":$F15..$1000
	incbin "../../../Extracted/segments/bankCB_A000.bin":$0..$115
FrameTiles34F:						; the raw tiles of frame $34F (FrameTileSource / FrameBankLayout entry
									; $34F); pose not traced
	incbin "../../../Extracted/segments/bankCB_A000.bin":$115..$375
FrameTiles350:						; the raw tiles of frame $350 (FrameTileSource / FrameBankLayout entry
									; $350); pose not traced
	incbin "../../../Extracted/segments/bankCB_A000.bin":$375..$5D5
FrameTiles351:						; the raw tiles of frame $351 (FrameTileSource / FrameBankLayout entry
									; $351); pose not traced
	incbin "../../../Extracted/segments/bankCB_A000.bin":$5D5..$835
FrameTiles352:						; the raw tiles of frame $352 (FrameTileSource / FrameBankLayout entry
									; $352); pose not traced
	incbin "../../../Extracted/segments/bankCB_A000.bin":$835..$AB5
FrameTiles353:						; the raw tiles of frame $353 (FrameTileSource / FrameBankLayout entry
									; $353); pose not traced
	incbin "../../../Extracted/segments/bankCB_A000.bin":$AB5..$D35
FrameTiles354:						; the raw tiles of frame $354 (FrameTileSource / FrameBankLayout entry
									; $354); pose not traced
	incbin "../../../Extracted/segments/bankCB_A000.bin":$D35..$FB5
FrameTiles355:						; the raw tiles of frame $355 (FrameTileSource / FrameBankLayout entry
									; $355); pose not traced
	incbin "../../../Extracted/segments/bankCB_A000.bin":$FB5..$1000
	incbin "../../../Extracted/segments/bankCB_B000.bin":$0..$235
FrameTiles356:						; the raw tiles of frame $356 (FrameTileSource / FrameBankLayout entry
									; $356); pose not traced
	incbin "../../../Extracted/segments/bankCB_B000.bin":$235..$435
FrameTiles357:						; the raw tiles of frame $357 (FrameTileSource / FrameBankLayout entry
									; $357); pose not traced
	incbin "../../../Extracted/segments/bankCB_B000.bin":$435..$635
FrameTiles358:						; the raw tiles of frame $358 (FrameTileSource / FrameBankLayout entry
									; $358); pose not traced
	incbin "../../../Extracted/segments/bankCB_B000.bin":$635..$835
FrameTiles359:						; the raw tiles of frame $359 (FrameTileSource / FrameBankLayout entry
									; $359); pose not traced
	incbin "../../../Extracted/segments/bankCB_B000.bin":$835..$A35
FrameTiles35A:						; the raw tiles of frame $35A (FrameTileSource / FrameBankLayout entry
									; $35A); pose not traced
	incbin "../../../Extracted/segments/bankCB_B000.bin":$A35..$C35
FrameTiles35B:						; the raw tiles of frame $35B (FrameTileSource / FrameBankLayout entry
									; $35B); pose not traced
	incbin "../../../Extracted/segments/bankCB_B000.bin":$C35..$E35
FrameTiles35C:						; the raw tiles of frame $35C (FrameTileSource / FrameBankLayout entry
									; $35C); pose not traced
	incbin "../../../Extracted/segments/bankCB_B000.bin":$E35..$1000
	incbin "../../../Extracted/segments/bankCB_C000.bin":$0..$35
FrameTiles35D:						; the raw tiles of frame $35D (FrameTileSource / FrameBankLayout entry
									; $35D); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$35..$235
FrameTiles35E:						; the raw tiles of frame $35E (FrameTileSource / FrameBankLayout entry
									; $35E); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$235..$435
FrameTiles35F:						; the raw tiles of frame $35F (FrameTileSource / FrameBankLayout entry
									; $35F); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$435..$635
FrameTiles360:						; the raw tiles of frame $360 (FrameTileSource / FrameBankLayout entry
									; $360); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$635..$835
FrameTiles361:						; the raw tiles of frame $361 (FrameTileSource / FrameBankLayout entry
									; $361); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$835..$A35
FrameTiles362:						; the raw tiles of frame $362 (FrameTileSource / FrameBankLayout entry
									; $362); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$A35..$C35
FrameTiles363:						; the raw tiles of frame $363 (FrameTileSource / FrameBankLayout entry
									; $363); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$C35..$E35
FrameTiles364:						; the raw tiles of frame $364 (FrameTileSource / FrameBankLayout entry
									; $364); pose not traced
	incbin "../../../Extracted/segments/bankCB_C000.bin":$E35..$1000
	incbin "../../../Extracted/segments/bankCB_D000.bin":$0..$35
FrameTiles365:						; the raw tiles of frame $365 (FrameTileSource / FrameBankLayout entry
									; $365); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$35..$235
FrameTiles366:						; the raw tiles of frame $366 (FrameTileSource / FrameBankLayout entry
									; $366); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$235..$435
FrameTiles367:						; the raw tiles of frame $367 (FrameTileSource / FrameBankLayout entry
									; $367); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$435..$635
FrameTiles368:						; the raw tiles of frame $368 (FrameTileSource / FrameBankLayout entry
									; $368); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$635..$835
FrameTiles369:						; the raw tiles of frame $369 (FrameTileSource / FrameBankLayout entry
									; $369); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$835..$A35
FrameTiles36A:						; the raw tiles of frame $36A (FrameTileSource / FrameBankLayout entry
									; $36A); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$A35..$C35
FrameTiles36B:						; the raw tiles of frame $36B (FrameTileSource / FrameBankLayout entry
									; $36B); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$C35..$E35
FrameTiles36C:						; the raw tiles of frame $36C (FrameTileSource / FrameBankLayout entry
									; $36C); pose not traced
	incbin "../../../Extracted/segments/bankCB_D000.bin":$E35..$1000
	incbin "../../../Extracted/segments/bankCB_E000.bin":$0..$35
FrameTiles36D:						; the raw tiles of frame $36D (FrameTileSource / FrameBankLayout entry
									; $36D); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$35..$235
FrameTiles36E:						; the raw tiles of frame $36E (FrameTileSource / FrameBankLayout entry
									; $36E); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$235..$435
FrameTiles36F:						; the raw tiles of frame $36F (FrameTileSource / FrameBankLayout entry
									; $36F); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$435..$695
FrameTiles370:						; the raw tiles of frame $370 (FrameTileSource / FrameBankLayout entry
									; $370); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$695..$895
FrameTiles371:						; the raw tiles of frame $371 (FrameTileSource / FrameBankLayout entry
									; $371); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$895..$AF5
FrameTiles372:						; the raw tiles of frame $372 (FrameTileSource / FrameBankLayout entry
									; $372); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$AF5..$CF5
FrameTiles373:						; the raw tiles of frame $373 (FrameTileSource / FrameBankLayout entry
									; $373); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$CF5..$F75
FrameTiles374:						; the raw tiles of frame $374 (FrameTileSource / FrameBankLayout entry
									; $374); pose not traced
	incbin "../../../Extracted/segments/bankCB_E000.bin":$F75..$1000
	incbin "../../../Extracted/segments/bankCB_F000.bin":$0..$175
FrameTiles375:						; the raw tiles of frame $375 (FrameTileSource / FrameBankLayout entry
									; $375); pose not traced
	incbin "../../../Extracted/segments/bankCB_F000.bin":$175..$3D5
FrameTiles376:						; the raw tiles of frame $376 (FrameTileSource / FrameBankLayout entry
									; $376); pose not traced
	incbin "../../../Extracted/segments/bankCB_F000.bin":$3D5..$5D5
FrameTiles377:						; the raw tiles of frame $377 (FrameTileSource / FrameBankLayout entry
									; $377); pose not traced
	incbin "../../../Extracted/segments/bankCB_F000.bin":$5D5..$7D5
FrameTiles378:						; the raw tiles of frame $378 (FrameTileSource / FrameBankLayout entry
									; $378); pose not traced
	incbin "../../../Extracted/segments/bankCB_F000.bin":$7D5..$9D5
FrameTiles379:						; the raw tiles of frame $379 (FrameTileSource / FrameBankLayout entry
									; $379); pose not traced
	incbin "../../../Extracted/segments/bankCB_F000.bin":$9D5..$BD5
FrameTiles37A:						; the raw tiles of frame $37A (FrameTileSource / FrameBankLayout entry
									; $37A); pose not traced
	incbin "../../../Extracted/segments/bankCB_F000.bin":$BD5..$DD5
endmacro

macro FrameTilesCC()
FrameTiles37B:						; the raw tiles of frame $37B (FrameTileSource / FrameBankLayout entry
									; $37B); pose not traced
	incbin "../../../Extracted/segments/bankCC_0000.bin":$5E5..$845
FrameTiles37C:						; the raw tiles of frame $37C (FrameTileSource / FrameBankLayout entry
									; $37C); pose not traced
	incbin "../../../Extracted/segments/bankCC_0000.bin":$845..$A45
FrameTiles37D:						; the raw tiles of frame $37D (FrameTileSource / FrameBankLayout entry
									; $37D); pose not traced
	incbin "../../../Extracted/segments/bankCC_0000.bin":$A45..$CA5
FrameTiles37E:						; the raw tiles of frame $37E (FrameTileSource / FrameBankLayout entry
									; $37E); pose not traced
	incbin "../../../Extracted/segments/bankCC_0000.bin":$CA5..$F25
FrameTiles37F:						; the raw tiles of frame $37F (FrameTileSource / FrameBankLayout entry
									; $37F); pose not traced
	incbin "../../../Extracted/segments/bankCC_0000.bin":$F25..$1000
	incbin "../../../Extracted/segments/bankCC_1000.bin":$0..$1A5
FrameTiles380:						; the raw tiles of frame $380 (FrameTileSource / FrameBankLayout entry
									; $380); pose not traced
	incbin "../../../Extracted/segments/bankCC_1000.bin":$1A5..$405
FrameTiles381:						; the raw tiles of frame $381 (FrameTileSource / FrameBankLayout entry
									; $381); pose not traced
	incbin "../../../Extracted/segments/bankCC_1000.bin":$405..$685
FrameTiles382:						; the raw tiles of frame $382 (FrameTileSource / FrameBankLayout entry
									; $382); pose not traced
	incbin "../../../Extracted/segments/bankCC_1000.bin":$685..$8E5
FrameTiles383:						; the raw tiles of frame $383 (FrameTileSource / FrameBankLayout entry
									; $383); pose not traced
	incbin "../../../Extracted/segments/bankCC_1000.bin":$8E5..$B45
FrameTiles384:						; the raw tiles of frame $384 (FrameTileSource / FrameBankLayout entry
									; $384); pose not traced
	incbin "../../../Extracted/segments/bankCC_1000.bin":$B45..$D45
FrameTiles385:						; the raw tiles of frame $385 (FrameTileSource / FrameBankLayout entry
									; $385); pose not traced
	incbin "../../../Extracted/segments/bankCC_1000.bin":$D45..$FA5
FrameTiles386:						; the raw tiles of frame $386 (FrameTileSource / FrameBankLayout entry
									; $386); pose not traced
	incbin "../../../Extracted/segments/bankCC_1000.bin":$FA5..$1000
	incbin "../../../Extracted/segments/bankCC_2000.bin":$0..$225
FrameTiles387:						; the raw tiles of frame $387 (FrameTileSource / FrameBankLayout entry
									; $387); pose not traced
	incbin "../../../Extracted/segments/bankCC_2000.bin":$225..$4A5
FrameTiles388:						; the raw tiles of frame $388 (FrameTileSource / FrameBankLayout entry
									; $388); pose not traced
	incbin "../../../Extracted/segments/bankCC_2000.bin":$4A5..$6A5
FrameTiles389:						; the raw tiles of frame $389 (FrameTileSource / FrameBankLayout entry
									; $389); pose not traced
	incbin "../../../Extracted/segments/bankCC_2000.bin":$6A5..$905
FrameTiles38A:						; the raw tiles of frame $38A (FrameTileSource / FrameBankLayout entry
									; $38A); pose not traced
	incbin "../../../Extracted/segments/bankCC_2000.bin":$905..$B05
FrameTiles38B:						; the raw tiles of frame $38B (FrameTileSource / FrameBankLayout entry
									; $38B); pose not traced
	incbin "../../../Extracted/segments/bankCC_2000.bin":$B05..$D05
FrameTiles38C:						; the raw tiles of frame $38C (FrameTileSource / FrameBankLayout entry
									; $38C); pose not traced
	incbin "../../../Extracted/segments/bankCC_2000.bin":$D05..$F05
FrameTiles38D:						; the raw tiles of frame $38D (FrameTileSource / FrameBankLayout entry
									; $38D); pose not traced
	incbin "../../../Extracted/segments/bankCC_2000.bin":$F05..$1000
	incbin "../../../Extracted/segments/bankCC_3000.bin":$0..$85
FrameTiles38E:						; the raw tiles of frame $38E (FrameTileSource / FrameBankLayout entry
									; $38E); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$85..$285
FrameTiles38F:						; the raw tiles of frame $38F (FrameTileSource / FrameBankLayout entry
									; $38F); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$285..$485
FrameTiles390:						; the raw tiles of frame $390 (FrameTileSource / FrameBankLayout entry
									; $390); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$485..$685
FrameTiles391:						; the raw tiles of frame $391 (FrameTileSource / FrameBankLayout entry
									; $391); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$685..$8E5
FrameTiles392:						; the raw tiles of frame $392 (FrameTileSource / FrameBankLayout entry
									; $392); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$8E5..$B45
FrameTiles393:						; the raw tiles of frame $393 (FrameTileSource / FrameBankLayout entry
									; $393); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$B45..$DA5
FrameTiles394:						; the raw tiles of frame $394 (FrameTileSource / FrameBankLayout entry
									; $394); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$DA5..$FA5
FrameTiles395:						; the raw tiles of frame $395 (FrameTileSource / FrameBankLayout entry
									; $395); pose not traced
	incbin "../../../Extracted/segments/bankCC_3000.bin":$FA5..$1000
	incbin "../../../Extracted/segments/bankCC_4000.bin":$0..$205
FrameTiles396:						; the raw tiles of frame $396 (FrameTileSource / FrameBankLayout entry
									; $396); pose not traced
	incbin "../../../Extracted/segments/bankCC_4000.bin":$205..$465
FrameTiles397:						; the raw tiles of frame $397 (FrameTileSource / FrameBankLayout entry
									; $397); pose not traced
	incbin "../../../Extracted/segments/bankCC_4000.bin":$465..$6C5
FrameTiles398:						; the raw tiles of frame $398 (FrameTileSource / FrameBankLayout entry
									; $398); pose not traced
	incbin "../../../Extracted/segments/bankCC_4000.bin":$6C5..$8C5
FrameTiles399:						; the raw tiles of frame $399 (FrameTileSource / FrameBankLayout entry
									; $399); pose not traced
	incbin "../../../Extracted/segments/bankCC_4000.bin":$8C5..$B45
FrameTiles39A:						; the raw tiles of frame $39A (FrameTileSource / FrameBankLayout entry
									; $39A); pose not traced
	incbin "../../../Extracted/segments/bankCC_4000.bin":$B45..$DA5
FrameTiles39B:						; the raw tiles of frame $39B (FrameTileSource / FrameBankLayout entry
									; $39B); pose not traced
	incbin "../../../Extracted/segments/bankCC_4000.bin":$DA5..$FA5
FrameTiles39C:						; the raw tiles of frame $39C (FrameTileSource / FrameBankLayout entry
									; $39C); pose not traced
	incbin "../../../Extracted/segments/bankCC_4000.bin":$FA5..$1000
	incbin "../../../Extracted/segments/bankCC_5000.bin":$0..$1E5
FrameTiles39D:						; the raw tiles of frame $39D (FrameTileSource / FrameBankLayout entry
									; $39D); pose not traced
	incbin "../../../Extracted/segments/bankCC_5000.bin":$1E5..$445
FrameTiles39E:						; the raw tiles of frame $39E (FrameTileSource / FrameBankLayout entry
									; $39E); pose not traced
	incbin "../../../Extracted/segments/bankCC_5000.bin":$445..$6C5
FrameTiles39F:						; the raw tiles of frame $39F (FrameTileSource / FrameBankLayout entry
									; $39F); pose not traced
	incbin "../../../Extracted/segments/bankCC_5000.bin":$6C5..$8C5
FrameTiles3A0:						; the raw tiles of frame $3A0 (FrameTileSource / FrameBankLayout entry
									; $3A0); pose not traced
	incbin "../../../Extracted/segments/bankCC_5000.bin":$8C5..$AC5
FrameTiles3A1:						; the raw tiles of frame $3A1 (FrameTileSource / FrameBankLayout entry
									; $3A1); pose not traced
	incbin "../../../Extracted/segments/bankCC_5000.bin":$AC5..$CC5
FrameTiles3A2:						; the raw tiles of frame $3A2 (FrameTileSource / FrameBankLayout entry
									; $3A2); pose not traced
	incbin "../../../Extracted/segments/bankCC_5000.bin":$CC5..$F25
FrameTiles3A3:						; the raw tiles of frame $3A3 (FrameTileSource / FrameBankLayout entry
									; $3A3); pose not traced
	incbin "../../../Extracted/segments/bankCC_5000.bin":$F25..$1000
	incbin "../../../Extracted/segments/bankCC_6000.bin":$0..$1A5
FrameTiles3A4:						; the raw tiles of frame $3A4 (FrameTileSource / FrameBankLayout entry
									; $3A4); pose not traced
	incbin "../../../Extracted/segments/bankCC_6000.bin":$1A5..$425
FrameTiles3A5:						; the raw tiles of frame $3A5 (FrameTileSource / FrameBankLayout entry
									; $3A5); pose not traced
	incbin "../../../Extracted/segments/bankCC_6000.bin":$425..$6A5
FrameTiles3A6:						; the raw tiles of frame $3A6 (FrameTileSource / FrameBankLayout entry
									; $3A6); pose not traced
	incbin "../../../Extracted/segments/bankCC_6000.bin":$6A5..$8A5
FrameTiles3A7:						; the raw tiles of frame $3A7 (FrameTileSource / FrameBankLayout entry
									; $3A7); pose not traced
	incbin "../../../Extracted/segments/bankCC_6000.bin":$8A5..$B05
FrameTiles3A8:						; the raw tiles of frame $3A8 (FrameTileSource / FrameBankLayout entry
									; $3A8); pose not traced
	incbin "../../../Extracted/segments/bankCC_6000.bin":$B05..$D05
FrameTiles3A9:						; the raw tiles of frame $3A9 (FrameTileSource / FrameBankLayout entry
									; $3A9); pose not traced
	incbin "../../../Extracted/segments/bankCC_6000.bin":$D05..$F05
FrameTiles3AA:						; the raw tiles of frame $3AA (FrameTileSource / FrameBankLayout entry
									; $3AA); pose not traced
	incbin "../../../Extracted/segments/bankCC_6000.bin":$F05..$1000
	incbin "../../../Extracted/segments/bankCC_7000.bin":$0..$105
FrameTiles3AB:						; the raw tiles of frame $3AB (FrameTileSource / FrameBankLayout entry
									; $3AB); pose not traced
	incbin "../../../Extracted/segments/bankCC_7000.bin":$105..$305
FrameTiles3AC:						; the raw tiles of frame $3AC (FrameTileSource / FrameBankLayout entry
									; $3AC); pose not traced
	incbin "../../../Extracted/segments/bankCC_7000.bin":$305..$505
FrameTiles3AD:						; the raw tiles of frame $3AD (FrameTileSource / FrameBankLayout entry
									; $3AD); pose not traced
	incbin "../../../Extracted/segments/bankCC_7000.bin":$505..$705
FrameTiles3AE:						; the raw tiles of frame $3AE (FrameTileSource / FrameBankLayout entry
									; $3AE); pose not traced
	incbin "../../../Extracted/segments/bankCC_7000.bin":$705..$965
FrameTiles3AF:						; the raw tiles of frame $3AF (FrameTileSource / FrameBankLayout entry
									; $3AF); pose not traced
	incbin "../../../Extracted/segments/bankCC_7000.bin":$965..$BC5
FrameTiles3B0:						; the raw tiles of frame $3B0 (FrameTileSource / FrameBankLayout entry
									; $3B0); pose not traced
	incbin "../../../Extracted/segments/bankCC_7000.bin":$BC5..$E25
FrameTiles3B1:						; the raw tiles of frame $3B1 (FrameTileSource / FrameBankLayout entry
									; $3B1); pose not traced
	incbin "../../../Extracted/segments/bankCC_7000.bin":$E25..$1000
	incbin "../../../Extracted/segments/bankCC_8000.bin":$0..$25
FrameTiles3B2:						; the raw tiles of frame $3B2 (FrameTileSource / FrameBankLayout entry
									; $3B2); pose not traced
	incbin "../../../Extracted/segments/bankCC_8000.bin":$25..$225
FrameTiles3B3:						; the raw tiles of frame $3B3 (FrameTileSource / FrameBankLayout entry
									; $3B3); pose not traced
	incbin "../../../Extracted/segments/bankCC_8000.bin":$225..$425
FrameTiles3B4:						; the raw tiles of frame $3B4 (FrameTileSource / FrameBankLayout entry
									; $3B4); pose not traced
	incbin "../../../Extracted/segments/bankCC_8000.bin":$425..$6A5
FrameTiles3B5:						; the raw tiles of frame $3B5 (FrameTileSource / FrameBankLayout entry
									; $3B5); pose not traced
	incbin "../../../Extracted/segments/bankCC_8000.bin":$6A5..$925
FrameTiles3B6:						; the raw tiles of frame $3B6 (FrameTileSource / FrameBankLayout entry
									; $3B6); pose not traced
	incbin "../../../Extracted/segments/bankCC_8000.bin":$925..$BA5
FrameTiles3B7:						; the raw tiles of frame $3B7 (FrameTileSource / FrameBankLayout entry
									; $3B7); pose not traced
	incbin "../../../Extracted/segments/bankCC_8000.bin":$BA5..$E25
FrameTiles3B8:						; the raw tiles of frame $3B8 (FrameTileSource / FrameBankLayout entry
									; $3B8); pose not traced
	incbin "../../../Extracted/segments/bankCC_8000.bin":$E25..$1000
	incbin "../../../Extracted/segments/bankCC_9000.bin":$0..$A5
FrameTiles3B9:						; the raw tiles of frame $3B9 (FrameTileSource / FrameBankLayout entry
									; $3B9); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$A5..$325
FrameTiles3BA:						; the raw tiles of frame $3BA (FrameTileSource / FrameBankLayout entry
									; $3BA); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$325..$525
FrameTiles3BB:						; the raw tiles of frame $3BB (FrameTileSource / FrameBankLayout entry
									; $3BB); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$525..$725
FrameTiles3BC:						; the raw tiles of frame $3BC (FrameTileSource / FrameBankLayout entry
									; $3BC); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$725..$925
FrameTiles3BD:						; the raw tiles of frame $3BD (FrameTileSource / FrameBankLayout entry
									; $3BD); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$925..$B25
FrameTiles3BE:						; the raw tiles of frame $3BE (FrameTileSource / FrameBankLayout entry
									; $3BE); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$B25..$D25
FrameTiles3BF:						; the raw tiles of frame $3BF (FrameTileSource / FrameBankLayout entry
									; $3BF); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$D25..$F25
FrameTiles3C0:						; the raw tiles of frame $3C0 (FrameTileSource / FrameBankLayout entry
									; $3C0); pose not traced
	incbin "../../../Extracted/segments/bankCC_9000.bin":$F25..$1000
	incbin "../../../Extracted/segments/bankCC_A000.bin":$0..$125
FrameTiles3C1:						; the raw tiles of frame $3C1 (FrameTileSource / FrameBankLayout entry
									; $3C1); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$125..$325
FrameTiles3C2:						; the raw tiles of frame $3C2 (FrameTileSource / FrameBankLayout entry
									; $3C2); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$325..$525
FrameTiles3C3:						; the raw tiles of frame $3C3 (FrameTileSource / FrameBankLayout entry
									; $3C3); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$525..$725
FrameTiles3C4:						; the raw tiles of frame $3C4 (FrameTileSource / FrameBankLayout entry
									; $3C4); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$725..$925
FrameTiles3C5:						; the raw tiles of frame $3C5 (FrameTileSource / FrameBankLayout entry
									; $3C5); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$925..$B25
FrameTiles3C6:						; the raw tiles of frame $3C6 (FrameTileSource / FrameBankLayout entry
									; $3C6); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$B25..$D25
FrameTiles3C7:						; the raw tiles of frame $3C7 (FrameTileSource / FrameBankLayout entry
									; $3C7); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$D25..$F25
FrameTiles3C8:						; the raw tiles of frame $3C8 (FrameTileSource / FrameBankLayout entry
									; $3C8); pose not traced
	incbin "../../../Extracted/segments/bankCC_A000.bin":$F25..$1000
	incbin "../../../Extracted/segments/bankCC_B000.bin":$0..$125
FrameTiles3C9:						; the raw tiles of frame $3C9 (FrameTileSource / FrameBankLayout entry
									; $3C9); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$125..$325
FrameTiles3CA:						; the raw tiles of frame $3CA (FrameTileSource / FrameBankLayout entry
									; $3CA); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$325..$525
FrameTiles3CB:						; the raw tiles of frame $3CB (FrameTileSource / FrameBankLayout entry
									; $3CB); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$525..$725
FrameTiles3EC:						; the raw tiles of frame $3EC (FrameTileSource / FrameBankLayout entry
									; $3EC); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$725..$925
FrameTiles3ED:						; the raw tiles of frame $3ED (FrameTileSource / FrameBankLayout entry
									; $3ED); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$925..$B85
FrameTiles3EE:						; the raw tiles of frame $3EE (FrameTileSource / FrameBankLayout entry
									; $3EE); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$B85..$D85
FrameTiles3EF:						; the raw tiles of frame $3EF (FrameTileSource / FrameBankLayout entry
									; $3EF); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$D85..$FE5
FrameTiles3F0:						; the raw tiles of frame $3F0 (FrameTileSource / FrameBankLayout entry
									; $3F0); pose not traced
	incbin "../../../Extracted/segments/bankCC_B000.bin":$FE5..$1000
	incbin "../../../Extracted/segments/bankCC_C000.bin":$0..$1E5
FrameTiles3F1:						; the raw tiles of frame $3F1 (FrameTileSource / FrameBankLayout entry
									; $3F1); pose not traced
	incbin "../../../Extracted/segments/bankCC_C000.bin":$1E5..$445
FrameTiles3F2:						; the raw tiles of frame $3F2 (FrameTileSource / FrameBankLayout entry
									; $3F2); pose not traced
	incbin "../../../Extracted/segments/bankCC_C000.bin":$445..$6A5
FrameTiles3F3:						; the raw tiles of frame $3F3 (FrameTileSource / FrameBankLayout entry
									; $3F3); pose not traced
	incbin "../../../Extracted/segments/bankCC_C000.bin":$6A5..$905
FrameTiles3F4:						; the raw tiles of frame $3F4 (FrameTileSource / FrameBankLayout entry
									; $3F4); pose not traced
	incbin "../../../Extracted/segments/bankCC_C000.bin":$905..$B65
FrameTiles3F5:						; the raw tiles of frame $3F5 (FrameTileSource / FrameBankLayout entry
									; $3F5); pose not traced
	incbin "../../../Extracted/segments/bankCC_C000.bin":$B65..$DE5
FrameTiles3F6:						; the raw tiles of frame $3F6 (FrameTileSource / FrameBankLayout entry
									; $3F6); pose not traced
	incbin "../../../Extracted/segments/bankCC_C000.bin":$DE5..$FE5
FrameTiles3F7:						; the raw tiles of frame $3F7 (FrameTileSource / FrameBankLayout entry
									; $3F7); pose not traced
	incbin "../../../Extracted/segments/bankCC_C000.bin":$FE5..$1000
	incbin "../../../Extracted/segments/bankCC_D000.bin":$0..$265
FrameTiles3F8:						; the raw tiles of frame $3F8 (FrameTileSource / FrameBankLayout entry
									; $3F8); pose not traced
	incbin "../../../Extracted/segments/bankCC_D000.bin":$265..$465
FrameTiles3F9:						; the raw tiles of frame $3F9 (FrameTileSource / FrameBankLayout entry
									; $3F9); pose not traced
	incbin "../../../Extracted/segments/bankCC_D000.bin":$465..$6C5
FrameTiles3FA:						; the raw tiles of frame $3FA (FrameTileSource / FrameBankLayout entry
									; $3FA); pose not traced
	incbin "../../../Extracted/segments/bankCC_D000.bin":$6C5..$8C5
FrameTiles3FB:						; the raw tiles of frame $3FB (FrameTileSource / FrameBankLayout entry
									; $3FB); pose not traced
	incbin "../../../Extracted/segments/bankCC_D000.bin":$8C5..$B25
FrameTiles41B:						; the raw tiles of frame $41B (FrameTileSource / FrameBankLayout entry
									; $41B); pose not traced
	incbin "../../../Extracted/segments/bankCC_D000.bin":$B25..$D85
FrameTiles41C:						; the raw tiles of frame $41C (FrameTileSource / FrameBankLayout entry
									; $41C); pose not traced
	incbin "../../../Extracted/segments/bankCC_D000.bin":$D85..$FE5
FrameTiles41D:						; the raw tiles of frame $41D (FrameTileSource / FrameBankLayout entry
									; $41D); pose not traced
	incbin "../../../Extracted/segments/bankCC_D000.bin":$FE5..$1000
	incbin "../../../Extracted/segments/bankCC_E000.bin":$0..$1E5
FrameTiles41E:						; the raw tiles of frame $41E (FrameTileSource / FrameBankLayout entry
									; $41E); pose not traced
	incbin "../../../Extracted/segments/bankCC_E000.bin":$1E5..$3E5
FrameTiles41F:						; the raw tiles of frame $41F (FrameTileSource / FrameBankLayout entry
									; $41F); pose not traced
	incbin "../../../Extracted/segments/bankCC_E000.bin":$3E5..$5E5
FrameTiles420:						; the raw tiles of frame $420 (FrameTileSource / FrameBankLayout entry
									; $420); pose not traced
	incbin "../../../Extracted/segments/bankCC_E000.bin":$5E5..$7E5
FrameTiles421:						; the raw tiles of frame $421 (FrameTileSource / FrameBankLayout entry
									; $421); pose not traced
	incbin "../../../Extracted/segments/bankCC_E000.bin":$7E5..$A45
FrameTiles422:						; the raw tiles of frame $422 (FrameTileSource / FrameBankLayout entry
									; $422); pose not traced
	incbin "../../../Extracted/segments/bankCC_E000.bin":$A45..$CA5
FrameTiles423:						; the raw tiles of frame $423 (FrameTileSource / FrameBankLayout entry
									; $423); pose not traced
	incbin "../../../Extracted/segments/bankCC_E000.bin":$CA5..$EA5
endmacro
