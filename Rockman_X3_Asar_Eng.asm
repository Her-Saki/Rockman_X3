;;#################################
;;VWF for Rockman X3 - By Her-Saki#
;;#################################

arch snes.cpu

;;###############
;; Variables    #
;;###############

	!TileMapAddress		= $6A	  ;;Original tilemap address
	!ColorByte			= $6E	  ;;Palette for this string
	!TextSpeed	    	= $6F	  ;;Text speed
	!Letter 		    = $68     ;;Letter byte
	!BigDMAQueueSize	= $A4	  ;;Big DMA queue size
	!SmallDMAQueueSize	= $A5	  ;;Small DMA queue size

	!Y_Backup 	   		= $FF00   ;;Backup for Y
	!A_Backup        	= $FF01   ;;Backup for A

	!Shift    	     	= $FF03   ;;Rows we shifted each time
	!Width            	= $FF04   ;;Width of the old tile
	!ShiftRight       	= $FF05   ;;Rows to shift right
	!ShiftLeft        	= $FF06   ;;Rows to shift left

	!TileMapPosition   	= $FF07   ;;Current position in the tilemap
	!TileMapSize       	= $FF0B   ;;Size of the tilemap
	!BufferPosition    	= $FF0F   ;;Position in the VROM space
	!TotalWidth	     	= $FF11	  ;;Total width per string

	;;Speed 0 heap variables
	!HeapPosition      	= $FF13
	!HeapInitPos	    = $FF15

	!NextLetter		 	= $FF17	  ;;Next letter
	
	!TildePosition		= $FF09	  ;;Tilde position
	!ShiftTildeRight	= $FF19	  ;;Tilde rows to shift right
	!ShiftTilde			= $FF1A	  ;;Tilde rows to shift for each letter
	!ShiftTildeLeft		= $FF1B	  ;;Tilde rows to shift left
	!TildeBufPosition	= $FF1C   ;;Tilde buffer position
	!TildeTiles			= $FF1E	  ;;Tiles until tilde position
	!TilPosArrayIndex	= $FF1F	  ;;Index for tilde position array
	!PointerIndex		= $FFBF   ;;Index for the text pointer table
	!TildePositionArray = $FFC0	  ;;Array for tilde positions
	!ProcessedTilde1	= $FFD0	  ;;Buffer for the processed tilde
	!ProcessedTilde2	= $FFE0	  ;;Buffer for the processed tilde
	
	!OldTile           = $FF20    ;;Buffer for the old tile
	!NewTile           = $FF30    ;;Buffer for the new tile
	!RawTile           = $FF40    ;;Buffer for the raw tile
	!TileMap           = $FF50    ;;Buffer for the tilemap

	!FontOffset	       = $3E8000	;;Font offset (0x1F0000 in ROM)
	!EndingFlag		   = $7E00D1	;;Ending flag
 
;;###############
;; Constants    #
;;###############

	!HeapLit  	       = #$EF00
	!TileMapLit        = #$FF50

	;;"Ready" string animation constants
	!ReadyXPos    	   = #$D8
	
	!IQFrame3		   = #$01
	!EFrame3		   = #$02
	!sFrame3		   = #$03
	!tFrame3		   = #$04
	!oFrame3		   = #$05
	!TildeFrame3	   = #$06
	!aFrame3		   = #$07
	!iFrame3		   = #$08
	!QFrame3		   = #$09
	!lFrame3		   = #$0A
	
	!IQFrame2		   = #$0B
	!EFrame2		   = #$0C
	!sFrame2		   = #$0D
	!tFrame2		   = #$0E
	!oFrame2		   = #$0F
	!TildeFrame2	   = #$10
	!aFrame2		   = #$11
	!iFrame2		   = #$12
	!QFrame2		   = #$13
	!lFrame2		   = #$14
	
	!IQFrame1		   = #$15
	!EFrame1		   = #$16
	!sFrame1		   = #$17
	!tFrame1		   = #$18
	!oFrame1		   = #$19
	!TildeFrame1	   = #$1A
	!aFrame1		   = #$1B
	!iFrame1		   = #$1C
	!QFrame1		   = #$1D
	!lFrame1		   = #$1E
	
;;=========================
;;Font
;;=========================
org $3E8000
incbin Font.bin
	
;;=========================
;;Arrow tile
;;=========================
org $E931
db $39
	
;;=========================
;;Text pointer table
;;=========================
org $39C1BC
Init:
;;Last stage 4
dw LastStage4, LastStage4Doppler
org $39C1C0 ;;0x1CC1C0
dw GetWeaponText, ParasiticBomb, FrostShield, BugHole
dw AcidRush, TriadThunder, SpinningBlade, TornadoFang
;;C1D0
dw RaySplasher, DrLight1, DrLight2, DrLight3
dw DrLight4, TwoBossesDefeated2, TwoBossesDefeated3, TwoBossesDefeated4
;;C1E0
dw CastRoll, ExploseHorneck, DrLightGoldArmor2, AllBossesDefeatedZero1
dw AllBossesDefeated2, AllBossesDefeatedZero2, LastStage3, IntroText2
;;C1F0
dw Vava1, VavaDefeated, VavaDrDopplerStage, DrDoppler1
dw DrDopplerDefeated, SigmaDefeated, LifeUp1, UnusableMessageNumber
;;C200
dw IntroText3, IntroText4, LifeUp1, LifeUp2
dw LifeUp3, LifeUp4, RArmor1, RArmor2
;;That second STank2 originally pointed to the unused "Counter-Hunter" string.
;;C210
dw STank1, STank2, STank2, ChoosingZero
dw ChoosingX, SwitchingToZero, OpeningStage1, OpeningStage3
;;C220
dw Sigma1, Sigma2, OpeningStage2, Mandarela1
dw MandarelaDefeated, MandarelaDestroyed, Vajurilla1, VajurillaDefeated
;;C230
dw VajurillaDestroyed, OpeningStage4, OpeningStage5, AllBossesDefeated
dw IntroText1, TwoBossesDefeated1, DrLightEnc1, DrLightEnc2
;;C240
dw DrLightEnc3, DrLightEnc4, DrLightWarning1, DrLightWarning2
dw DrLightGoldArmor1, DrLightWarning3, ZeroRescue1, ZeroRescue2
;;C250
dw VajurillaAvengesMandarela, MandarelaAvengesVajurilla, DrDopplerStage1Boss, ZeroSaber
dw LastStageNull, LastStage1, LastStage2, IntroText5
;;Originally "CastRollNull"
;;C260
dw Ending1, ZeroDefeated, LastStageNull, STank3
dw STank4, ChangeF1, ChangeF2, ChangeK1
;;C270
dw ChangeK2, ChangeH1, ChangeH2, Unk1
dw Unk2, Unk3, Unk4, FootP1
;;C280
dw FootP2, BodyP1, BodyP2, HeadP1
dw HeadP2, ArmP1, ArmP2, ExploseHorneck
;;C290
dw FrozenBuffalo, GravityBeetbood, AcidSeaforce, ElectroNamazuros
dw ScissorsShrimper, ScrewMasaider, ShiningTigerd, Vajurilla
;;C2A0
dw Mandarela, Godkarmachine, VavaMK2, DrDopplerBossRoll
dw SigmaBossRoll, SigmaVirus, RockmanAndZero, AndYou

;;=========================
;;Text
;;=========================
;;$7D = Clean VRAM (VERY important! Do it after each line)
;;$82 = End of block
;;$86 = Scroll (Number of lines) > 5 for two lines, 7 for three, etc.
;;$88 = Text speed (Speed)
;;$89 = Text position ((WORD)Position)
;;$CX = Text color
;;@@ = Jump
;;| = á
;;% = í
;;# = ú
;;{ = é
;;} = ó
table "tables\Text.tbl",rtl
org $39C2B0
;;Get weapon text
GetWeaponText:
db $89, $C2, $08, $C0, $88, $01, $7D
db "You got:"
db $80, $82
ParasiticBomb:
db $89, $02, $09, $C2, $88, $01
db "Parasitic Bomb@"
db $87, $1E, $82
FrostShield:
db $89, $02, $09, $C2, $88, $01
db "Frost Shield@"
db $87, $1E, $82
BugHole:
db $89, $02, $09, $C2, $88, $01
db "Bug Hole@"
db $87, $1E, $82
AcidRush:
db $89, $02, $09, $C2, $88, $01
db "Acid Rush@"
db $87, $1E, $82
TriadThunder:
db $89, $02, $09, $C2, $88, $01
db "Triad Thunder@"
db $87, $1E, $82
SpinningBlade:
db $89, $02, $09, $C2, $88, $01
db "Spinning Blade@"
db $87, $1E, $82
TornadoFang:
db $89, $02, $09, $C2, $88, $01
db "Tornado Fang@"
db $87, $1E, $82
RaySplasher:
db $89, $02, $09, $C2, $88, $01
db "Ray Splasher@"
db $87, $1E, $82

IntroText1:
;;Original text:
;;２１ＸＸ年。科学者レプリロイド「ドップラー博士」によりイレギュラーは一掃された。
;;そしてドップラー博士の作る平和都市「ドッペルタウン」に優秀なレプリロイド達が集められた。
;;それから数カ月後……
db $89, $A0, $0A, $C0, $88, $01, $7D
db "In 21XX, all the Irregulars were neutralized by Dr. Doppler,@@a Reploid scientist.@@@"
db $87, $F0, $87, $10, $86, $05, $7D
db "After this, the most able Reploids were gathered in a@@peaceful city Dr. Doppler built, Doppel Town.@@@"
db $87, $F0, $87, $40, $86, $05, $7D
db "Since then, some months have passed by...@@@"
db $87, $F0, $87, $10, $86, $03, $82
IntroText2:
;;Original text:
;;突然沈静化したはずのイレギュラー達が一斉に反乱を起こした。
;;ドップラ博士が主謀者だと言う事を突き止めたイレギュラーハンター本部はエックスとゼロにドップラー博士の捕獲とドップラ軍の壊滅を命じた。
db $89, $A0, $0A, $C0, $88, $01, $7D
db "But unexpectedly, those supposedly recovered Irregulars@@rebelled en masse.@@@"
db $87, $F0, $87, $10, $86, $05, $8B, $01
db "After finding out Dr. Doppler was their ringleader, the@@Hunter HQ sent X and Zero to capture him and eliminate@@his army.@@@"
db $87, $F0, $87, $10, $86, $07, $82
IntroText3:
;;Original text:
;;イレギュラーハンター
;;エックス＆ゼロ出動！
db $89, $A2, $0A, $C0, $88, $01, $7D
db "X and Zero, engage!@@@"
db $87, $F0, $87, $40, $86, $05, $82
IntroText4:
;;Original text:
;;数時間後、イレギュラーハンター本部より緊急連絡が入った。
db $89, $A2, $0A, $C0, $88, $01, $7D
db "Some hours later, an emergency call came from HQ.@@@"
db $87, $F0, $87, $10, $86, $05, $82
IntroText5:
;;Original text:
;;こちらはイレギュラーハンター本部！
;;ドップラ軍の攻撃を受け、応戦中！
;;本部周辺のイレギュラーハンターは直ちに帰還し、応戦に当たれ！
db $89, $A2, $0A, $C2, $88, $02, $7D
db "HQ here!@@@"
db $87, $F0, $87, $10, $86, $03, $7D
db "We're being asaulted by Doppler's army!@@@"
db $87, $F0, $87, $10, $86, $03, $7D
db "All the Hunters near HQ's perimeter must return@@immediately to aid our counter-attack!@@@"
db $87, $F0, $87, $10, $86, $05, $82
OpeningStage1:
;;Original text:
;;エックス、オレは本部の周辺から片付ける。
;;お前は、内部の敵を頼む。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "X, I'll wipe out the enemies@@around the perimeter.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $8B, $01, $7D
db "You take care of the@@interior.@@"
db $83, $06, $81, $80, $86, $05, $82
OpeningStage2:
;;Original text:
;;君は、行方不明になっていたマックじゃないか。
db $89, $A9, $08, $C0, $88, $02, $8B, $02, $7D
db "You're... that MIA Reploid,@@Mac!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
OpeningStage3:
;;Original text:
;;フッフッフッ、エックス、お前は甘いな。
;;オレはもうイレギュラーハンターではなくドップラー軍団の一員だ。
;;悪いがお前を捕獲する。
db $89, $A9, $08, $C1, $88, $02, $8B, $01, $7D
db "Hahaha! You're so naive,@@X!@@I'm not a Hunter anymore,@@but a soldier of Doppler's@@army.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "Sorry, but I must capture@@you now.@@"
db $83, $06, $81, $80, $86, $05, $82
OpeningStage4:
;;Original text:
;;大丈夫か、エックス？
;;あ、ありがとう、ゼロ。大丈夫だ。
;;オレはまた、本部周辺に回る。エックス、油断するなよ。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Are you okay, X?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $8B, $02, $C0, $7D
db "I-I'm fine, Zero. Thank you.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $8B, $01, $C2, $7D
db "I'm gonna check the@@perimeter again. Don't drop@@your guard.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
OpeningStage5:
;;Original text:
;;どうやら敵は片付いた様だ。
;;オレは暫く本部の修復作業に当たるが、必要な時は呼び出してくれ。
;;じゃ、頑張れよエックス。
db $89, $65, $08, $C2, $88, $02, $8B, $01, $7D
db "Looks like we wiped them all.@@"
db $83, $0B, $81, $80, $86, $03, $87, $1E, $8B, $01, $7D
db "I'm gonna go back to HQ for reparations,@@but you can call me anytime you need.@@"
db $83, $0B, $81, $80, $86, $05, $87, $1E, $8B, $01, $7D
db "Good luck, X.@@"
db $83, $0B, $81, $80, $86, $03, $87, $1E, $82
DrLight1:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは空中での機動力をパワーアップさせる事が出来るフットパーツを授けよう。
;;空中で上と左右の３方向にエアーダッシュする事が出来るようになるぞ
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I'll grant you an upgrade@@for your legs that will@@improve your mobility in@@mid-air.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Now you'll be able to dash@@in three directions: back,@@forth, and upwards.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrLight2:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは最新鋭の人工衛星から送られてくる情報をもとに、各地に隠されている色々なアイテムを発見する事が出来るヘッドパーツを授けよう。
;;人工衛星の地中探査機能を使ってアイテムの位置まで分かるはずじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I'll grant you an upgrade for@@your helmet that will allow@@you to find hidden items@@with information of the most@@advanced satellite.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "Now you'll be able to find@@their locations with its@@geo-tracking function.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrLight3:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは敵から受けるダメージを減らす事が出来るボディパーツを授けよう。
;;ダメージを受けると防御フィールドが発生して、敵から受けるダメージを少なくしてくれるはずじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I'll grant you an upgrade@@for your chest that will@@reduce the damage you take@@from enemies.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Every time you receive@@damage, a force field will@@surround you to lessen@@the impact.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLight4:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;チャージショットを更にパワーアップさせるアームパーツを授けよう。
;;チャージショットを二つ打てるようになり、更に二つのショットを重ねる事によって拡散ショットにパワーアップする事が出来るクロスチャージじゃ。
;;また、有らゆるショットをチャージさせる事でより強力な攻撃を繰り出す事も出来るのじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I'll grant you an upgrade@@that will increase the power@@of your charged shots.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "This cross-charge will allow@@you to fire two additional@@shots, and combining them@@into multiple blasts.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Don't forget you can also@@fire more powerful shots@@with your other weapons@@after charging them.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
Vava1:
;;Original text:
;;クックックック…
;;まんまとワナに引っ掛かたな！！
;;お前は、ヴァヴァ？！
;;いきていたのか！
;;この工場内には至る処に爆弾を仕掛けておいた。
;;暫くすると、お前ごとまとめて大爆発だ！
;;爆発までの少しの間オレ様が最後の相手をしてやるぞ。
;;死ねい！エックス！！
db $89, $A9, $08, $C1, $88, $02, $8B, $01, $7D
db "Hahaha...@@"
db $87, $3C
db "You fell right into my trap!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C0, $8B, $02, $7D
db "You're... "
db $87, $1E
db "Vava?@@"
db $87, $5A
db "You were alive?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C1, $8B, $01, $7D
db "I've set up bombs all over@@the factory.@@"
db $87, $3C
db "In some minutes you'll be@@blown to smithereens along@@with it!@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "In the meantime, I'll fight@@you for the last time.@@"
db $87, $3C
db "DIE, X!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
;;I feel bad for Vava. We all know he will never beat X.
VavaDefeated:
;;Original text:
;;これで勝ったと思うな…
;;オレは貴様はを倒す為になんどでも甦って…や…る…
db $89, $A9, $08, $C1, $88, $02, $7D
db "Don't even think you have@@won...@@"
db $87, $3C, $88, $04
db "I'll resurrect again and@@"
db $88, $07
db "again... until... I...@@"
db $88, $0C
db "defeat you...@@"
db $87, $B4, $82
VavaDrDopplerStage:
;;Original text:
;;やっと来たか、エックス…
;;待ち兼ねたぞ。
;;最新型ライドアーマー「ブラウンベア」で、今までの恨みをはらさせてもうらうぞ！！
db $8A, $89, $A9, $08, $C1, $88, $02, $7D
db "You're finally here, X...@@I was waiting for you...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "With this new Ride Armor,@@''Brown Bear'', I'll settle our@@score once and for all!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrDoppler1:
;;Original text:
;;待っていたよ、エックス君。私がドップラーだ。
;;君の活躍はじっくりと拝見させてもらったよ。
;;我側近を倒すとは大した物だ。
;;君のその力我らに貸す積もりはないかね。
;;そして我らとともに、シグマ様のもとで、レプリロイドが全世界を支配する。
;;理想郷を築こうではないか？
;;断る！！
;;貴様の、そしてシグマの計画もここで終りだ！
;;フン！愚かな！！
;;では、君に消えてもらうしかないな。
;;そして我シグマ様のボディパーツとなるが良い。
;;死ね！エックス！！
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "I was waiting for you, X.@@I'm the Dr. Doppler.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "I've been closely following@@your actions.@@I find quite impressive you@@managed to beat so many@@of us.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "Would you be interested in@@aiding our cause with your@@power?@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Together we can take over@@the world for the Reploid@@race, under the reigning@@of Master Sigma.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Don't you think it would@@be a perfect utopia?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C0, $8B, $02, $7D
db "I refuse!@@Your plans will end here@@and now!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C2, $8B, $01, $7D
db "Hmph! How foolish!@@You leave me no choice@@but to eliminate you.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "You'll now become a part@@of Sigma's body.@@DIE, X!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrDopplerDefeated:
;;Original text:
;;み…見事だ…
;;君なら、あのシグマを…倒す事が…出来る…か…も…
;;ドップラー、話せるのか？！
;;シグマの正体は…
;;悪性のプログラムウイルスだ…
;;私はヤツに洗脳されて…
;;…恐ろしいボディを作ってしまった…
;;そのボディはどこにあるんですか？
;;研究所の地下のハンガーに置いてある…
;;まだシグマの手にはわたっていないはずだ…
;;私の事は構わない…
;;一刻も早くそのボディを破壊してくれ。
;;もう、時間がない…
;;分かりました。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "I-Impressive...@@Perhaps you... can...@@defeat... Sigma...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C0, $8B, $02, $7D
db "What else do you know?!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C2, $8B, $01, $7D
db "His true form... is an evil@@virus program...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "He brainwashed me... to@@build that terrific body...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C0, $8B, $02, $7D
db "Where's that body now?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C2, $8B, $01, $7D
db "It's hidden in a hangar@@in the base of this lab...@@I'm sure Sigma hasn't still@@taken full control of it...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Don't worry about me...@@You must destroy that body@@as soon as possible...@@We don't have time to lose...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $C0, $8B, $02, $7D
db "Roger.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
LastStageNull:
db $82
LastStage1:
;;Original text:
;;オレはこのまま動力炉の破壊に向かう。
;;エックス、お前は上の階へ回ってシグマのボディを破壊してくれ。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "I'm gonna go destroy the@@reactor.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "You head upwards to@@destroy Sigma's body.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
LastStage2:
;;Original text:
;;？！　しまった！
;;行き止まりだ…
db $89, $65, $08, $C0, $88, $02, $8B, $02, $7D
db "Oh, damn! It's a dead end...!@@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
LastStage3:
;;Original text:
;;ハハハハ…
;;残念だったな、エックスよ。
;;今度はお前に取り付く世界を手に入れてやる！
db $89, $65, $08, $C1, $88, $02, $8B, $03, $7D
db "Hahahaha! Too bad for you...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Now I'll take over your body and the world@@will be mine!@@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
LastStage4:
;;グアアアアアアア！！
;;き、貴様は…
;;ゼ…ゼロ…
;;またしても…
;;お前か…
;;どうだい？シグマ。
;;ドップラーが残していた、
;;シグマウイルスようの抗体ウイルスを乗せたビームサーベル攻撃は！！
;;遅くなって悪かったな、エックス。
;;動力炉を破壊してこっちに来る途中で、コンピュタールームでこの抗体を発見したんだ。
;;これなら実体のないシグマも、ダメージをあたえる事が出来るのさ。
;;き…消える…
;;私の、プロ…
;;グラ…ム…が…
;;また…いつか…
db $89, $65, $08, $C1, $88, $02, $8B, $03, $7D
db "GAAAAAAAHHH! Y-You... Zero...?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "You... again...@@"
db $83, $0B, $81, $80, $86, $03, $C2, $88, $02, $8B, $01, $87, $1E, $7D
;;Literally "Hey, Sigma, how does my attack with my Beam Saber which contains Doppler's anti-Sigma antibody taste like?!@@""
db "Hey, Sigma, how does Doppler's antibody@@taste like?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Sorry for the hold up, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "While I was coming back from destroying@@the reactor I found this antibody in the@@computer room.@"
db $83, $06, $81, $80, $86, $06, $87, $1E, $7D
db "With it you can damage Sigma even if he@@doesn't have physical form.@@"
db $83, $0B, $81, $80, $86, $05, $C1, $88, $05, $8B, $03, $87, $1E, $7D
db "My... program... vanishes...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "But I'll be back...@@Someday...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
LastStage4Doppler:
;;グアアアアア…！！
;;き、貴様は…ド…ドップラー…
;;こ、これは！！いつのまに、貴様…
;;どうだ？！シグマ！！
;;この私が用意していた、シグマウイルス用の抗体ウイルスの味は！
;;エックス君、色々迷惑をかけたね…
;;他のレプリロイド達にももうしわけない事をした…
;;せめてもの罪滅ぼしにこのシグマウイルスとともに私も地獄に行こう。
;;き…消える…
;;私の、プロ…
;;グラ…ム…が…
;;それでは、エックス君…
;;さ…ら…ば…だ…
db $89, $65, $08, $C1, $88, $02, $8B, $03, $7D
db "GAAAAAAAHHH! Y-You... Doppler...?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "W-When did you...?@@"
db $83, $0B, $81, $80, $86, $03, $C2, $88, $02, $8B, $01, $87, $1E, $7D
db "How does my antibody taste like, Sigma?!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I'm sorry for causing you so much trouble,@@X...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "What I did to those Reploids was@@unforgivable...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "I'll at least take this virus to hell with me,@@as an apology.@@"
db $83, $0B, $81, $80, $86, $05, $C1, $88, $02, $8B, $03, $87, $1E, $7D
db "My... program... vanishes...@@"
db $83, $0B, $81, $80, $86, $03, $C2, $88, $02, $8B, $01, $87, $1E, $7D
db "Goodbye, X...@@Fare... well...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
Sigma1:
;;Original text:
;;また会えて嬉しいぞ。エックスよ…
;;ドップラを利用してここまで来たが…
;;また、貴様のお蔭で台無しにされたよ…
;;どうやら貴様とは闘う運命に有るらしいな…
;;行くぞ！！
db $89, $A9, $08, $C1, $88, $02, $7D
db "Glad to meet you again, X...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I've made it this far@@manipulating Doppler only@@for you to ruin it again...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "It looks like fighting is@@just our destiny...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "HERE I GO!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82
Sigma2:
;;さすがだな、エックス…
;;だが、これで終りだとおもうな！！
;;ドップラーに開発させた、究極の戦闘用ボディの力を、今、この場であじあわせてくれるわ！！
db $89, $A9, $08, $C1, $88, $02, $7D
db "I didn't expect less from@@you, X...@@But don't think this is the@@end yet!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Now you'll have a taste of@@the supreme power of the@@body that Doppler built for@@me!!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
SigmaDefeated:
;;Original text:
;;ま…まさか…こんなはずでは！！
;;このボディを以てしても貴様に勝てないとは…
;;こうなったら、エックス！
;;貴様のそのボディをいただく！
db $89, $A9, $08, $C1, $88, $02, $7D
db "N-No...@@This doesn't make any@@sense!!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "How come I can't beat you@@even using this body...?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "In that case...@@I'LL STEAL YOURS!!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
;;UNUSED TEXT
UnusableMessageNumber:
;;Original text:
;;このメッセージナンバーは使われておりません。
db $89, $89, $08, $C6, $88, $02, $7D
db "You can't use this message number.@@"
db $83, $06, $81, $80, $86, $05, $87, $78, $82
ChoosingZero:
;;Original text:
;;エックスか、今直ぐ行くぜ！
db $89, $E4, $09, $C2, $88, $02, $7D
db "   ==It's you, X?@@  I'm on my way!@"
db $82
ChoosingX:
;;Original text:
;;ゼロか、今直ぐ行くよ！
db $89, $E4, $09, $C2, $88, $02, $7D
db "=====It's you, Zero?@@  I'm on my way!@"
db $82
SwitchingToZero:
;;Original text:
;;ゼロ、ここから先はオレに任せてくれ！
db $89, $E4, $09, $C2, $88, $02, $7D
db "====Let me take the@@    lead, Zero!@"
db $82
ZeroDefeated:
;;Original text:
;;済まない、エックス…
;;しくじっちまった…
;;どうやら動力炉を、やられたみたいだ…
;;早くドップラーの計画を打ち砕いてくれ。
;;頼んだぞ、エックス…
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Sorry, X...@@I screwed it up...@@It looks like my reactor@@was... destroyed...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "You must terminate@@Doppler's plans as soon as@@possible...@@I'm counting on you, X...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82, $82
ZeroSaber:
;;Original text:
;;今の爆発音は…
;;ゼロ！！！
;;大丈夫か？！
;;すまない、エックス…
;;しくじっちまった…
;;どうやら動力炉をやられたみたいだ…
;;俺は修理のために、ケイン博士の所に戻らせてもらうぜ…
;;この先は、どんな強敵がいるか分からないから、このオレのビームサーベルを持っていきな…
;;早くドップラーとシグマの計画を打ち砕いてくれ。
;;頼んだぞ、エックス…
db $89, $A9, $08, $C0, $88, $02, $8B, $02, $7D
db "What was that explosion?@@Are you okay, Zero?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C2, $8B, $01, $7D
db "Sorry, X...@@I couldn't handle that@@sucker...@@It looks like my reactor@@has been destroyed...@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "I think I'll have to go@@back to Cain's base for@@reparations...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "You never know what kind@@of enemies may lie ahead,@@so here you have my Beam@@Saber...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "You must put an end to@@their plans as soon as@@possible.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "I'm counting on you, X...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82, $82
DrLightEnc1:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな回復能力を追加する「ヘッドチップ」を授けよう。
;;じっとして動かなければ少しずつライフエネルギーを回復する事が出来るじゃろう。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Here I'll grant you a new@@chip for your helmet that@@will improve your ability@@to heal.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Now you will be able to@@slowly recover energy@@while you're standing still.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLightEnc2:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな防御能力を追加する「ボディチップ」を授けよう。
;;防御シールドの性能がアップしてシールドの耐久力が上り、更にダメージを受けにくくなるぞ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Here I'll grant you a new@@chip for your body that@@will improve your defensive@@ability.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "The effectiveness and@@duration of your defensive@@shield will increase, and the@@damage you receive will@@decrease as well.@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
DrLightEnc3:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな攻撃能力を追加する「アームチップ」を授けよう。
;;これは敵から受けたダメージを、　エックスの武器エネルギーに変換して溜ておき、いっきに解放してチャージショットを連射する事が出来るはずじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Here I'll grant you a new@@chip for your Buster that@@will improve your attack@@ability.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "This will allow you to@@convert the damage you@@receive in energy, which@@you will be able to release@@in chain shots.@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
DrLightEnc4:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな移動能力を追加する「フットチップ」を授けよう。
;;これでエアーダッシュが二回まで連続して出来る様になり、空中での移動範囲が広くなるぞ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Here I'll grant you a new@@chip for your legs that@@will improve your mobility.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "With it you'll be able to dash@@in mid-air twice, thus@@furthering your reach.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrLightWarning1:
;;Original text:
;;但し、この強化チップは４種類のうち、一つしか付ける事が出来ないんじゃ。
;;良く考えてからこのカプセルの中に入りなさい。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "However, you can only@@choose one chip of the four@@I made.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Consider it carefully before@@entering the capsule.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
DrLightWarning2:
;;Original text:
;;おや、どうやらお前はこの強化チップを装着する為のパワーアープパーツをまだ集めてないな…
;;このままでは装着出来ないから早く探してきなさい…
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Oh, it looks like you don't@@have the upgrade to install@@this chip yet...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "We can't install it without@@the upgrade, so you'll have@@to come back once you@@find it...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLightWarning3:
;;Original text:
;;おや？…
;;すまんが、もう他の強化チップが装着されているので組み込めないみたいじゃ…
;;辛いじゃろうが、頑張ってくれ、エックス…
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Oh, my...@@It looks like you already@@have another chip installed,@@so you won't be able to@@install this one...@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "It'll be a tough fight, but@@you must give it your best,@@X...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrLightGoldArmor1:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは全ての強化能力を手に入れる事が出来るハイパーチップを授けよう。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Enter the capsule, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Here I'll grant you a hyper@@chip that will allow you to@@obtain all the other@@upgrades.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLightGoldArmor2:
;;Original text:
;;これで可也闘いが楽になるはずじゃ。
;;さあ頑張るのだぞ、エックス…
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "This will help you a lot in@@your battles.@@I wish you the best of@@luck, X...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
ZeroRescue1:
;;Original text:
;;エックス、助けに来たぜ！
;;吊り天井の方はオレに任せろ！！
;;お前はそのでくの坊を破壊するんだ！！
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "I came to lend you a hand,@@X!@@I'm gonna stop the ceiling!@@You take care of this guy!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
ZeroRescue2:
;;Original text:
;;エックス！
;;このドップラーの研究施設は手強いイレギュラー達がウヨウヨいるぞ！！
;;あいつらドップラーに戦闘用に改造されている。
;;気を付けて進めよ。
;;分かったよ。 ゼロ。 ありがとう。
;;じゃオレは先に行くぜ。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "This facility is infested@@with tough Irregulars!!@@It's to be expected, since@@Doppler militarized them.@@You better be careful.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $C0, $8B, $02, $7D
db "I will, Zero. Thank you.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C2, $8B, $01, $7D
db "Anyway, I'll see you ahead!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
;;Original text:
;;お前がエックスか。我名はマンダレーラだ。
;;我宿命により闘ってもうらう。イザ！
Mandarela1:
db $89, $A9, $08, $C2, $88, $02, $7D
db "You're X, right?@@My name is Mandarela.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "I have been commanded to@@fight with you.@@Engage!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
MandarelaDefeated:
;;Original text:
;;こ、これほどのものとは…
;;今回は不覚にも私の負けだが…
;;次に合う時はお前を砕いてみせる！
db $89, $A9, $08, $C2, $88, $02, $7D
db "I-I can't believe he was@@this strong...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "This time I lost to my@@carelessness... but the next@@time I'll make sure to@@demolish you!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
MandarelaDestroyed:
;;ぬおっっっ！！
;;こ、こいつのどこからこんなパワーが引き出せるというのだ！！
;;見事だ…エックス…
;;さらば！！
db $89, $A9, $08, $C2, $88, $02, $7D
db "GAAAAH...!!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "H-How can he release so@@much power?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "It was an excellent fight...@@X...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Farewell!!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82
Vajurilla1:
;;Original text:
;;フッフッフッ…
;;私の名はヴァジュリーラ。
;;ドップラー博士の右腕として、多くのレプリロイド達を葬ってきた。
;;博士の命令だ。消えてもらう。
db $89, $A9, $08, $C2, $88, $02, $7D
db "Hehehe...@@My name is Vajurilla.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "As the right hand of@@Dr. Doppler, I have taken@@down countless Reploids.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "He has ordered me to@@eliminate you.@@Prepare to be annihilated!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
VajurillaDefeated:
;;Original text:
;;こっ、これがエックスの持っているパワーか…
;;ここは一まず引き上げるが次に合う時にはこうはいかんぞ
;;ハハハハ…
db $89, $A9, $08, $C2, $88, $02, $7D
db "I-Is this your true power...?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I'll retire for now, but our@@next encounter won't be@@the same!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "HAHAHAHA...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82
VajurillaDestroyed:
;;Original text:
;;こっ、これは…
;;このレプリロイドの特殊能力か…
;;まさか…あの…
;;クワ………ッ！！
db $89, $A9, $08, $C2, $88, $02, $7D
db "I-Is this your special skill...?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Impossible! Then you...!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "GAH.....!!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82
TwoBossesDefeated1:
;;Original text
;;あの時、捕まえ損ねたイレギュラーハンターがこれほどの能力を持っていたとは…
;;いでよ、ヴァジュリーラ！マンダレーラ！
;;あのイレギュラーハンターを捕獲せよ。なるべく、生け捕りでな。
;;はっ、偉大になるドップラー博士のために！！
;;クックック…
;;まどろっこしいな。生け捕りとはね…
;;お前か…
;;パワーアップまでして再生してやったのに…
;;いい加減、私の指示通りに動いてくれないか…
;;再生してくれたのは感謝しているが、やつらには恨みがあるんでね…
;;オレはオレのやり方でやらせてもうらうぜ…
;;フン！まあ、よい…
;;しかし本当に、あのイレギュラーハンターが二度も、アノカタを倒したとは思えんが…
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "I can't believe that that@@elusive Hunter is so skilled...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Vajurilla, Mandarela!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82
TwoBossesDefeated2:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Seize that Hunter.@@Alive, if possible.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C0, $8B, $02, $7D
db "As you wish!@@For the future glory of@@Master Doppler!!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
TwoBossesDefeated3:
db $89, $A9, $08, $C1, $88, $02, $8B, $03, $7D
db "Hehehe...@@It'd really piss me off@@bringing him back ALIVE...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C2, $8B, $01, $7D
db "You again...?@@After all the improvements@@I made to you...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Can't you follow my orders@@for once...?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C1, $8B, $03, $7D
db "Thank you for resurrecting@@me, but I have scores to@@settle with them now.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "So, if you don't mind, I'll@@do this my way...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
TwoBossesDefeated4:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Hmph! Whatever...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Still, I can't believe that@@that Hunter defeated the@@Master twice...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
;;Cain was a romhacker before it was cool.
AllBossesDefeated:
;;Original text:
; お呼びですか、ケイン博士。
; うむ…
; 実は、ドップラに操られていたイレギュラー達の残骸から記憶チップを取り出して残っていたメモリーを解析してみたら、
; ドップラ達はレプリロイドが持っている特殊能力を集めて、最強の戦闘用レプリロイドボディを作り出そうとしているらしい。
; 戦闘用ボディ……を、ですか？
; うむ。
; ドップラーは元々科学者レプリロイドだから、戦闘能力がないので自分のために作っていると思っていたが、
; どうやらドップラーは誰かにそのボディ作らされているみたいなのじゃ。
; まさか…シグマが？！
;;;;;ZERO PART
; まだ生きていたのか？
;;;;;ZERO PART
; 登録されていない研究施設がＤポイントに発見された。
; どうやらそこがドップラーの秘密研究所らしい。
; ただちに向かってくれたまえ。
; 分かりました。
;;;;;ZERO PART
; 今度こそ、シグマの息の根を止めてやるぜ。
;;;;;ZERO PART
db $89, $A9, $08, $C0, $88, $02, $8B, $02, $7D
db "What do you need us for,@@Dr. Cain?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C1, $8B, $03, $7D
db "Hmm... After extracting and@@analyzing the memory chips@@of the remains of the@@Irregulars that Doppler@@controlled...@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "I found out that he's@@probably trying to build a@@perfect fighting body.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "A body featuring all the@@special skills of each@@Reploid.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C0, $8B, $02, $7D
db "A fighting... body?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C1, $8B, $03, $7D
db "Indeed. At first I thought he@@was building it for himself...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Since he was originally a@@scientist Reploid without@@militar applications.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "However, everything points@@that Doppler was ordered@@to build it by someone else.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C0, $8B, $02, $7D
db "Someone else...?@@Do you mean Sigma?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
AllBossesDefeatedZero1:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Is he still alive?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
AllBossesDefeated2:
db $89, $A9, $08, $C1, $88, $02, $8B, $03, $7D
db "An unregistered research@@facility was localized at@@D point.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "It looks like that's Doppler's@@hidden lab.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Head there immediately.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C0, $8B, $02, $7D
db "Roger.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82
AllBossesDefeatedZero2:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "This time we'll kill him for@@good!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
VajurillaAvengesMandarela:
;;Original text:
;;エックス！
;;マンダレーラを倒すとはさすがだな。
;;だが、ここまでだ！
;;マンダレーラのかたきは、一緒にと取らせてもらう！
db $89, $A9, $08, $C2, $88, $02, $7D
db "Only someone like you@@could be able to defeat@@Mandarela.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "However, this is as far@@as you go!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Now it's my turn to@@avenge him!@@Bring it on!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
MandarelaAvengesVajurilla:
;;Original text:
;;エックス、待ち兼ねたぞ。
;;お前がヴァジュリーラを倒すとはな…
;;ヴァジュリーラのかたきを取らせてもうら。
;;覚悟しろ！！
db $89, $A9, $08, $C2, $88, $02, $7D
db "I was waiting for you, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "I'm impressed that you@@managed to defeat@@Vajurilla...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Now it's my turn to@@avenge him.@@Say your prayers!!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrDopplerStage1Boss:
;;Original text:
;;待ち兼ねたぞ、エックス！！
;;ドップラ博士により我らは新たなる力を手に入れた。
;;今、その力を試させてもらう！！
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "We were eagerly waiting for@@you, X!@@"
db $83, $06, $81, $80, $8B, $FF, $86, $05, $87, $1E, $C1, $8B, $02, $7D
db "We acquired a new power@@thanks to Dr. Doppler.@@"
db $83, $06, $81, $80, $8B, $FF, $86, $05, $87, $1E, $C2, $8B, $01, $7D
db "And it's time for us to@@give it a try!@@"
db $83, $06, $81, $80, $8B, $FF, $86, $05, $87, $1E, $82
Ending1:
;;Original text:
;;度重なるシグマの計画を悉く打ち破ってきたエックス。
;;しかし、闘いの後に彼の心に残るのは空しさだけだった。
;;なぜ、人類とレプリロイド達が…
;;なぜ、プリロイド同士が闘わなくてはならないのか…
;;シグマに操られていた、ドップラの研究所を見つめるエックス…
;;その、明明と燃える炎を見つめながら息張のない悲しみと怒りによってエックスの冷たい体は震えていた…
;;そしていつか思い出されるであろう自分の記憶が、ゼロとの闘いを運命付けている事も今は知らずに…
;;そして彼らはこの先、何を見るのだろうか…
db $89, $62, $0B, $C0, $88, $00, $80, $80, $86, $02, $7D
db "Once again, X has utterly destroyed Sigma's plans.@@"
db $86, $02
db "However, after the battle is over, all that remains in@@"
db $86, $02
db "his heart is emptiness.@@@@"
db $86, $04
db "Why must humans and Reploids fight against each@@"
db $86, $02
db "other...?@@"
db $86, $02
db "Why must Reploids fight if we are all of the same@@"
db $86, $02
db "kind...?@@@@"
db $86, $04
db "Reflecting, X observes Doppler's laboratory...@@@@@@@@"
db $86, $08, $7D
db "Gazing at the flames burning brightly, his cold body@@"
db $86, $02
db "shivers with anger and unfathomable sorrow...@@@@"
db $86, $04
db "X still doesn't know that amidst his dormant memories@@"
db $86, $02
db "lies his predestined fight with Zero...@@@@@@@@"
db $86, $08, $7D
db "In the end, what will become of the two in the@@"
db $86, $02
db "future...?@@@@@@@@"
db $86, $08, $82
CastRoll:
db $8B, $00, $87, $78, $89, $6C, $08, $C2, $88, $01, $83, $08, $7D
db " ==Rockman X3@@@@"
db "     ==Cast@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $C0, $7D
db "Spycopter@"
db $89, $77, $08
db "Notor Banger@"
db $89, $82, $08
db "Caterkiller@"
db $89, $B7, $08
db "Hangertaker@"
db $89, $C2, $08
db "Earth Commander@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Head Gunner (customer)@"
db $89, $77, $08
db "Helit@"
db $89, $82, $08
db "Carry Arm@"
db $89, $B7, $08
db "Head Gunner@@(masspro)@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Ice De Voux@"
db $89, $77, $08
db "Snow Slider@"
db $89, $82, $08
db "Snow Rider@"
db $89, $B7, $08
db "Wall Cancer@"
db $89, $C2, $08
db "Blady@"
db $89, $F7, $08
db "Victoroid@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Mine Tortoise@"
db $89, $77, $08
db "Crablaster@"
db $89, $82, $08
db "Meta Capsule@"
db $89, $B7, $08
db "Hamma Hamma@"
db $89, $C2, $08
db "Walk Blaster@"
db $89, $F7, $08
db "Ganseki Carrier@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Drill Waying@"
db $89, $77, $08
db "Iwan De Voux@"
db $89, $82, $08
db "Drimole-W@"
db $89, $B7, $08
db "Tombort@"
db $89, $C2, $08
db "Wild Tank@"
db $89, $F7, $08
db "Atareeter@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Victoroid (customer)@"
db $89, $77, $08
db "Escanail@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Gigantic Mechaniroid@@(Maoh the Giant)@"
db $89, $B7, $08
db "Mac@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Genjibo and Shurikein@"
db $89, $77, $08
db "Hotareeca@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Hell Crusher@"
db $89, $77, $08
db "Worm Seeker-R@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Rex-2000@"
db $89, $77, $08
db "Mosquitus@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Volt Kurageil@"
db $89, $77, $08
db "Brown Bear@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Press Disposer@"
db $87, $FF, $8A, $87, $3C, $89, $42, $08, $7D
db "Ride Armor class DRA-00@@"
db $C1
db "(Kimera)@@(Cangaroo)@@(Hawk)@@(Frog)@"
db $87, $FF, $82
LifeUp1:
db $89, $42, $09, $C0, $88, $02, $7D, $7E
db "Life Up@"
db $82
LifeUp2:
db $89, $42, $09, $C1, $88, $02, $7D, $7E
db "Life Up@"
db $82
LifeUp3:
db $89, $56, $09, $C0, $88, $02, $7D, $7E
db "Life Up@"
db $82
LifeUp4:
db $89, $56, $09, $C1, $88, $02, $7D, $7E
db "Life Up@"
db $82
RArmor1:
db $89, $82, $09, $C0, $88, $02
db "R-Armor@"
db $82
RArmor2:
db $89, $82, $09, $C1, $88, $02
db "R-Armor@"
db $82
STank1:
db $89, $96, $09, $C0, $88, $02
db "Sub-Tank@"
db $82
STank2:
db $89, $96, $09, $C1, $88, $02
db "Sub-Tank@"
db $82
STank3:
db $89, $82, $09, $C0, $88, $02
db "Sub-Tank@"
db $82
STank4:
db $89, $82, $09, $C1, $88, $02
db "Sub-Tank@"
db $82
ChangeF1:
db $89, $82, $09, $C0, $88, $02
db "Change-F@"
db $82
ChangeF2:
db $89, $82, $09, $C1, $88, $02
db "Change-F@"
db $82
ChangeK1:
db $89, $96, $09, $C0, $88, $02
db "Change-K@"
db $82

;;Pointers
;;Options tilemap pointer 
;;org $06F95E
;;dw Options_Tilemap
;;db #$2B
;;"Start" sprite string pointer
org $0D9D2B
dw Start_Sprite_Data
db #$2B
;;"Password" sprite string pointer
org $0D9D31
dw Password_Sprite_Data
db #$2B
;;"Ready" animation table pointer
org $0D8C4B
dw Ready_Frame_1
db #$2B
dw Ready_Frame_2
db #$2B
dw Ready_Frame_3
db #$2B
dw Ready_Frame_4
db #$2B
dw Ready_Frame_5
db #$2B
dw Ready_Frame_6
db #$2B
dw Ready_Frame_7
db #$2B
dw Ready_Frame_8
db #$2B
dw Ready_Frame_9
db #$2B
dw Ready_Frame_10
db #$2B
dw Ready_Frame_11
db #$2B
dw Ready_Frame_12
db #$2B
dw Ready_Frame_13
db #$2B
dw Ready_Frame_14
db #$2B

;;Secondary bank
;;Weapon menu GFX
org $2B8000
incbin "src_eng/Weapon_GFX_Eng.bin"
Menu_Data:
incbin "src_eng/Menu_GFX_Eng.bin"
Option_Data:
incbin "src_esp/Options_GFX_Esp.bin"
Options_Tilemap:
incbin "src_esp/Options_Tilemap_Esp.bin"
Start_Data:
incbin "src_eng/Start_GFX_Eng.bin"
Ready_GFX:
incbin "src_eng/Ready_GFX_Eng.bin"
;;Sprite data:
Start_Sprite_Data:
db $03
db $00, $37, $FC, $62
db $00, $2F, $FC, $61
db $00, $27, $FC, $60
Password_Sprite_Data:
db $08
db $00, $17, $FC, $6A
db $00, $0F, $FC, $69
db $00, $07, $FC, $68
db $00, $FF, $FC, $67
db $00, $F7, $FC, $66
db $00, $EF, $FC, $65
db $00, $E7, $FC, $64
db $00, $DF, $FC, $63

incsrc "src_eng/Ready_AnimTable_Eng.asm"

ChangeK2:
db $89, $96, $09, $C1, $88, $02
db "Change-K@"
db $82
ChangeH1:
db $89, $82, $09, $C0, $88, $02
db "Change-H@"
db $82
ChangeH2:
db $89, $82, $09, $C1, $88, $02
db "Change-H@"
db $82
Unk1:
db $89, $C2, $09, $C0, $88, $02
db "?????@"
db $82
Unk2:
db $89, $C2, $09, $C1, $88, $02
db "?????@"
db $82
Unk3:
db $89, $D6, $09, $C0, $88, $02
db "?????@"
db $82
Unk4:
db $89, $D6, $09, $C1, $88, $02
db "?????"
db $82
FootP1:
db $89, $D6, $09, $C0, $88, $02
db "Leg Part@"
db $82
FootP2:
db $89, $D6, $09, $C1, $88, $02
db "Leg Part@"
db $82
BodyP1:
db $89, $D6, $09, $C0, $88, $02
db "Body Part@"
db $82
BodyP2:
db $89, $D6, $09, $C1, $88, $02
db "Body Part@"
db $82
HeadP1:
db $89, $D6, $09, $C0, $88, $02
db "Head Part@"
db $82
HeadP2:
db $89, $D6, $09, $C1, $88, $02
db "Head Part@"
db $82
ArmP1:
db $89, $C2, $09, $C0, $88, $02
db "Arm Part@"
db $82
ArmP2:
db $89, $C2, $09, $C1, $88, $02
db "Arm Part@"
db $82
ExploseHorneck:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Explose Horneck@@"
db $C3
db "Power: 3400 RP@@Speed: 8600 RP@@"
db $82
FrozenBuffalo:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Frozen Buffalo@@"
db $C3
db "Power: 9200 RP@@Speed: 3200 RP@@"
db $82
GravityBeetbood:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Gravity Beetbood@@"
db $C3
db "Power: 6200 RP@@Speed: 3600 RP@@"
db $82
AcidSeaforce:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Acid Seaforce@@"
db $C3
db "Power: 5800 RP@@Speed: 4300 RP@@"
db $82
ElectroNamazuros:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Electro Namazuros@@"
db $C3
db "Power: 8200 RP@@Speed: 1600 RP@@"
db $82
ScissorsShrimper:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Scissors Shrimper@@"
db $C3
db "Power: 4000 RP@@Speed: 7600 RP@@"
db $82
ScrewMasaider:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Screw Masaider@@"
db $C3
db "Power: 4200 RP@@Speed: 8000 RP@@"
db $82
ShiningTigerd:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Shining Tigerd@@"
db $C3
db "Power: 3600 RP@@Speed: 9900 RP@@"
db $82
Vajurilla:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Vajurilla FF@@"
db $C3
db "Power: 9400 RP@@Speed: 18000 RP@@"
db $82
Mandarela:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Mandarela BB@@"
db $C3
db "Power: 18800 RP@@Speed: 8200 RP@@"
db $82
Godkarmachine:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Godkarmachine O Inary@@"
db $C3
db "Power: 22900 RP@@Speed: 7200 RP@@"
db $82
VavaMK2:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Vava MK-2@@"
db $C3
db "Power: 9200 RP@@Speed: 7200 RP@@"
db $82
DrDopplerBossRoll:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Dr. Doppler@@"
db $C3
db "Power: 17400 RP@@Speed: 18000 RP@@"
db $82
SigmaBossRoll:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Sigma@@"
db $C3
db "Power: 19000 RP@@Speed: 19000 RP@@@"
db $C0
db "Kaiser Sigma@@"
db $C3
db "Power: 32000 RP@@Speed: 20000 RP@@"
db $82
SigmaVirus:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Sigma Virus@@"
db $C3
db "Power: ????? RP@@Speed: ????? RP@@"
db $82
RockmanAndZero:
db $88, $01, $89, $62, $08, $C0, $7D
db "Rockman X@@"
db $89, $69, $08, $C3
db "Power: ???? RP@@Speed: ????? RP@@"
db $89, $E2, $08, $C0
db "Zero@@"
db $89, $E9, $08, $C3
db "Power: ????? RP@@Speed: ????? RP@@"
db $82
AndYou:
db $88, $01, $89, $6E, $08, $C2, $83, $0A, $7D
db "And you!@@@@@@@@"
db $87, $FF, $82
cleartable

;;==========================
CleanVromBuffer:
;;==========================
SEP #$30           
LDA #$18           ;;VRAM gate register
STA $804311        
LDA #$09           ;;Word increment
STA $804310        
LDA #$80           ;;Video port
STA $802115        
REP #$20
LDA #$0000
STA $0000
LDA #$0200         ;;Start of text buffer
LSR                
STA $802116        
LDA #$0EFF         ;;Size
STA $804315
LDA #$0000         ;;RAM address
STA $804312        
SEP #$20           
LDA #$7E           ;;Bank   
STA $804314        
VBlankLoop4:
LDA $804212        ;;Wait for V-Blank
BPL VBlankLoop4
LDA #$02           
STA $80420B
RTL

; PHY
; PHX
; LDX $A4
; LDY #$00
; ;;Video port
; LDA #$80	
; STA $000500,x
; INX
; ;;Overwrite original font
; REP #$20
; LDA #$0200
; LSR
; STA $000500,x
; INX
; INX
; ;;Size
; LDA #$0EFF
; STA $000500,x
; INX
; INX
; ;;RAM address
; REP #$20
; LDA #$FFFF
; STA $000500,x
; INX
; INX
; ;;Bank
; SEP #$20
; LDA #$7F
; STA $000500,x
; INX
; ;;Add to queue
; STX $A4
; PLX
; PLY
;RTL

;;=========================
;;Cancel Dakuten DMA
;;transfer
;;=========================
org $E829
NOP
NOP

;;=========================
;;Jump to jump to main
;;routine
;;=========================
org $E67B	   ;;Targeting a STA $0604
JMP MainJump

;;==========================
org $FE5D
MainJump:
;;==========================
JML BackupValues
;;==========================
TwentyFourBitPointers:
;;==========================
;;Pointer index
LDA $7FFFBF
CMP #$B4
BCC Skip24BitPointers
PEA $392B
PLB
LDA ($68),y
PLB
INY
JMP Exit24BitPointers
Skip24BitPointers:
LDA ($68),y
INY
Exit24BitPointers:
RTS
;;==========================
SavePointerIndex:
;;==========================
PEA $067F
PLB
STX !PointerIndex
PLB
LDA $39C1BC,x
RTS

;;==============================
;;Binaries
;;==============================
org $CF3E8
Shift_Data:
incbin WidthTable.bin
Tilde_Shift_Data:
incbin TildeShiftTable.bin
;;==========================
BackupValues:
;;==========================
SEP #$30          
PHB                ;;Save bank
PHA                ;;Save tilemap byte
LDA #$7F           ;;Load bank
PHA                ;;Save bank
PLB                ;;Restore bank
PLA                ;;Restore tilemap byte
STY !Y_Backup     ;;Save original Y
STA !A_Backup     ;;Save original A

LDA $7FFFBF
CMP #$B4
BCC SaveNextLetter
PEA $7F2B
PLB
LDA ($68),y
PLB
JMP StoreNextLetter

SaveNextLetter:
PEA $7F39		   ;;Save next letter
PLB
LDA ($68),y
PLB
StoreNextLetter:
STA !NextLetter

;;=========================
FreeSpace:
;;=========================
LDA $FFF7            		 ;;Load random byte from the space we want to free
BEQ CheckCleanBufferFlag	 ;;If zero, skip cleaning
LDX #$00
LoopFreeSpace:
STZ $FF05,x
INX
CPX #$FB
BNE LoopFreeSpace

;;=========================
;;Upon detect #$7D, flush buffer
;;and start anew
CheckCleanBufferFlag:
;;=========================
SEP #$20
LDA !A_Backup  
CMP #$7D           
BNE CheckCleanTilemapFlag

;;==========================
CleanFlags:
;;==========================
STZ !TileMapPosition
STZ !ShiftRight
STZ !ShiftLeft
STZ !Shift
STZ !Width
STZ !TileMapSize
;;Total Width
STZ $FF11
STZ $FF12
;;Buffer position          
STZ $FF0F          
STZ $FF10
;;Heap Position
STZ $FF13
STZ $FF14
;;HeapInitPos
STZ $FF15
STZ $FF16
;;TildeBufPosition
LDA #$01
STA $FF1C
STZ $FF1D
;;Tilde array index
STZ !TilPosArrayIndex
;;==========================
;;Doing queued DMA here causes
;;overflow (and it's rather
;;unnecessary)
CleanBuffer:
;;==========================
SEP #$30           
LDA #$18           ;;VRAM gate register
STA $804311        
LDA #$09           ;;Word increment
STA $804310        
LDA #$80           ;;Video port
STA $802115        
REP #$20           
LDA #$0400         ;;Buffer position
LSR                
STA $802116        
LDA #$0C00         ;;Size
STA $804315        
LDA #$FFFF         ;;RAM address
STA $804312        
SEP #$20           
LDA #$7F           ;;Bank   
STA $804314        
VBlankLoop:
LDA $804212        ;;Wait for V-Blank
BPL VBlankLoop          
LDA #$02           
STA $80420B        
PLB                ;;Restore original bank
JML $00E6AA        ;;Return

;;=========================
;;#$7E means that this is
;;the stage select screen
;;and we must clean up the
;;tilemap
CheckCleanTilemapFlag:
;;=========================
SEP #$20
LDA !A_Backup  
CMP #$7E
BEQ CleanBufferAgain
JMP CheckLineFlag

;;==========================
CleanBufferAgain:
;;==========================
;;JSL CleanVromBuffer

;;==========================
CleanTilemap:
;;==========================
SEP #$30           
LDA #$18           ;;VRAM gate register
STA $804311        
LDA #$09           ;;Word increment
STA $804310        
LDA #$80           ;;Video port
STA $802115        
REP #$20           
LDA #$1280         ;;Vram address
LSR                
STA $802116        
LDA #$0140         ;;Size
STA $804315        
LDA #$FFFF         ;;RAM address
STA $804312        
SEP #$20           
LDA #$7F           ;;Bank   
STA $804314        
VBlankLoop1:
LDA $804212        ;;Wait for V-Blank
BPL VBlankLoop1
LDA #$02
STA $80420B        
PLB                ;;Restore original bank
JML $00E6AA        ;;Return

;;==========================
CheckLineFlag:
;;==========================
SEP #$10
LDA !TileMapSize
BEQ GetTotalWidth
JMP Start

;;==========================
GetTotalWidth:
;;==========================
DEY 				   ;;Start from the first letter
REP #$20			   ;;Clean accumulator
LDA #$0000
SEP #$20
GetWidthLoop:

LDA $7FFFBF
CMP #$B4
BCC SaveNextLetter2
PEA $7F2B
PLB
LDA ($68),y
PLB
JMP StoreNextLetter2

SaveNextLetter2:
PEA $7F39		   ;;Save next letter
PLB
LDA ($68),y
PLB
StoreNextLetter2:

CMP #$87
BEQ .SkipNextByte
CMP #$83
BNE .CheckNewLine
.SkipNextByte:
INY
.CheckNewLine:
CMP #$80
BEQ GetStringLenght
TAX

;;Check tilde character
CPX #$4B
BCC SkipGetTildePosition
CPX #$56
BCS SkipGetTildePosition
;;Get tilde position
REP #$20
PHX
LDX !TilPosArrayIndex
LDA !TotalWidth
STA !TildePositionArray,x
INC !TilPosArrayIndex
PLX
SEP #$20
SkipGetTildePosition:

LDA.L Shift_Data,x
REP #$20
CLC
ADC !TotalWidth
STA !TotalWidth
SEP #$20
INY
JMP GetWidthLoop

;;==========================
GetStringLenght:
;;==========================

STZ !TilPosArrayIndex

REP #$20
LDA !TotalWidth
STA $004204
SEP #$20
LDA #$08
STA $004206
NOP
NOP
NOP
NOP
NOP
NOP
NOP
LDA $004216
TAX
LDA $004214
CPX #$00
BEQ SkipINA
INC
SkipINA:
ASL
STA !TileMapSize
;;Reset total width
STZ $FF11
STZ $FF12

;;==========================
InitializeTilemapPosition:
;;==========================
LDA !TileMapPosition
BNE WriteTilemap       ;;Skip if it was already initialized
LDA #$40               ;;Set #$40 as initial position
STA !TileMapPosition

;;==========================
WriteTilemap:
;;==========================
LDX #$00
LoopWriteTilemap:
INC !TileMapPosition
LDA !TileMapPosition
STA !TileMap,x    			;;Tilemap byte
INX
LDA $6E           			;;Palette byte
STA !TileMap,x
INX
CPX !TileMapSize
BNE LoopWriteTilemap

;;==========================
;;Using $0500 buffer
TilemapToVRAM:
;;==========================
LDX !BigDMAQueueSize
LDY #$00
;;Video port
LDA #$80	
STA $000500,x
INX
;;Load the tilemap address originally assigned to THIS line
REP #$20
LDA !TileMapAddress
STA $000500,x
INX
INX
;;Size
SEP #$20
LDA !TileMapSize
STA $000500,x
INX
LDA #$00
STA $000500,x
INX
;;RAM address
REP #$20
LDA !TileMapLit
STA $000500,x
INX
INX
;;Bank
SEP #$20
LDA #$7F
STA $000500,x
INX
;;Add to queue
STX !BigDMAQueueSize

;;==========================
Start:
;;==========================
REP #$30
LDA !BufferPosition  ;;Advance a space
CLC
ADC.W #$10
STA !BufferPosition

;;==========================
GetIndex:
;;==========================
LDA !A_Backup

;Tilde code
;Write tilde if character is in 0x4B+ range
AND.W #$FF
CMP #$0056
BCS JumpSkipTildeCode
CMP #$004B
BCS TildeCode
JumpSkipTildeCode:
JMP SkipTildeCode
TildeCode:

;;Write tilemap
;;Prepare indexes
SEP #$30
LDX !SmallDMAQueueSize
LDY #$00
;;Video port
LDA #$80
STA $000600,x
INX
;;VRAM address (TileMapAddress + TildePosition - 0x20)
LDY !TilPosArrayIndex
LDA !TildePositionArray,y
INC !TilPosArrayIndex
STA $004204
SEP #$20
LDA #$08
STA $004206
NOP
NOP
NOP
NOP
NOP
NOP
NOP
LDA $004214
STA !TildeTiles

;;Save X
PHX
;;Get shift data index
LDA !A_Backup
SEC
SBC #$4B
TAX
;;The leftovers of the division mark the beginning of the letter
;;Get shift tilde right
LDA $004216
CLC
ADC.L Tilde_Shift_Data,x
STA !ShiftTildeRight
;;Get shift tilde left
LDA #$08
SEC
SBC !ShiftTildeRight

;;If shift tilde left is negative...
CMP #$FF
BNE SkipInitialization
LDA !ShiftTildeRight
SEC
SBC #$08
STA !ShiftTildeRight
LDA #$FF
STA !ShiftTildeLeft
INC !TildeTiles
JMP CopyTilde
SkipInitialization:
STA !ShiftTildeLeft

;;Copy tilde
CopyTilde:
LDX #$00

;;Change tile if ñ
LDA !A_Backup
CMP #$55
BNE KeepCopying
KeepCopying2:
LDA $3E8560,x
STA !ProcessedTilde1,x
STA !ProcessedTilde2,x
INX
CPX #$10
BNE KeepCopying2
JMP ShiftProcTilde1

;;Copy tilde tile
KeepCopying:
LDA $3E83A0,x
STA !ProcessedTilde1,x
STA !ProcessedTilde2,x
INX
CPX #$10
BNE KeepCopying

;;Shifting processed tilde 1 right
ShiftProcTilde1:
LDY #$00
LDX #$00
;;Skip if there's nothing to shift
LDA !ShiftTildeRight
BEQ ShiftProcTilde2
LoopLSRTilde:
LSR !ProcessedTilde1,x
INY
CPY !ShiftTildeRight
BNE LoopLSRTilde
LDY #$00
INX
CPX #$10
BNE LoopLSRTilde

ShiftProcTilde2:
;;Shifting processed tilde 2 left
LDY #$00
LDX #$00
;;Skip if there's nothing to shift
LDA !ShiftTildeLeft
BEQ ContinueTilemapDMA
LoopASLTilde:
LDA !ProcessedTilde2,x
ASL
STA !ProcessedTilde2,x
INY
CPY !ShiftTildeLeft
BNE LoopASLTilde
LDY #$00
INX
CPX #$10
BNE LoopASLTilde
LDY #$00
;;Restore X
ContinueTilemapDMA:
PLX

;;Tilemap address = (TilemapAddress + (TildeTiles & 0xFF)) - 0x20
REP #$20
LDA !TildeTiles
AND #$00FF
CLC
ADC !TileMapAddress
SEC
SBC #$0020
STA $000600,x
INX
INX
SEP #$20
;;Size
LDA #$04
STA $000600,x
INX
;;Bytes
LDA !TildeBufPosition
STA $000600,x
INC !TildeBufPosition
INX
LDA !ColorByte
STA $000600,x
INX
LDA !TildeBufPosition
STA $000600,x
INX
LDA !ColorByte
STA $000600,x
INX
;;Add to queue
STX !SmallDMAQueueSize

;;Write processed tilde
;;Video port
LDA #$80
STA $000600,x
INX
;;VRAM address (Current TildeBufPosition - 1 * 10)
REP #$20
LDA !TildeBufPosition
DEC
ASL
ASL
ASL
ASL
LSR
STA $000600,x
INC !TildeBufPosition
INX
INX
SEP #$20
;;Size
LDA #$20
STA $000600,x
INX
;;Bytes
LoopLol:
LDA !ProcessedTilde1,y
STA $000600,x
INY
INX
CPY #$20
BNE LoopLol
;;Add to queue
STX !SmallDMAQueueSize
;;Load backup again
REP #$30
LDA !A_Backup
SkipTildeCode:
;;Get font offset index
AND.W #$FF
ASL
ASL
ASL
ASL
TAX

;;==========================
GetLetter:
;;==========================
SEP #$20
LDY.W #$00
LoopGetLetter:
LDA !FontOffset,x
STA !NewTile,y
STA !RawTile,y
INY
INX
CPY.W #$10
BNE LoopGetLetter

;;==========================
CheckLetterPosition:
;;==========================
SEP #$10
LDA !Width
BNE ShiftOperations
JMP WriteNewTile

;;==========================
ShiftOperations:
;;==========================
LDX #$00
LDY #$00
;;Shifting right
LoopShiftRight:
LSR !NewTile,x
INY
CPY !ShiftRight
BNE LoopShiftRight
LDY #$00
;;Oring
LDA !OldTile,x
ORA !NewTile,x
STA !OldTile,x
;;Shifting left
LDA !RawTile,x
LoopShiftLeft:
ASL
INY
CPY !ShiftLeft
BNE LoopShiftLeft
STA !NewTile,x
LDY #$00
;;Loop base
INX            
CPX #$10
BNE LoopShiftRight

;;This must happen ALWAYS inside shift operations
LDA !ShiftLeft
STA !Shift

;;==========================
WriteOldTile:
;;==========================
LDA !TextSpeed
BNE OldTileRegular
LDA !EndingFlag
CMP #$06
BNE OldTileRegular

;;Check if this is the first transfer
REP #$30
LDA !HeapInitPos
BNE CopyOldTile
;;Set initial position
REP #$20
LDA #$0400
CLC
ADC.W !BufferPosition
STA !HeapInitPos
LDA !BufferPosition
STA !HeapPosition
;;Old tile to heap buffer
CopyOldTile:
LDY #$0000
LDA !BufferPosition
SEC
SBC #$0010
TAX
LDA #$0000
SEP #$20
LoopHeap:
LDA !OldTile,y
STA $7FEF00,x
INY
INX
CPY #$0010
BNE LoopHeap
SEP #$30
JMP NewTileToHeap

OldTileRegular:
LDX !SmallDMAQueueSize
CPX #$80
BCC RegularDMA1
;;If the queue overflows, force blank to write tiles
LDA #$00
STA $0609CE
LoopOverflow:
LDA $804212        ;;Wait for
BPL LoopOverflow   ;;V-Blank
LDX !SmallDMAQueueSize

RegularDMA1:
LDX !SmallDMAQueueSize
LDY #$00
;;Video port
LDA #$80
STA $000600,x
INX
;;VRAM address
REP #$20
LDA #$03F0
CLC
ADC.W !BufferPosition
LSR
STA $000600,x
INX
INX
;;Size
SEP #$20
LDA #$10
STA $000600,x
INX
;;Bytes
LoopThru2:
LDA !OldTile,y
STA $000600,x
INY
INX
CPY #$10
BNE LoopThru2
;;Add to queue
STX !SmallDMAQueueSize

;;==========================
WriteNewTile:
;;==========================
LDA !TextSpeed	   ;;Use heap queue only at maximum speed
BNE NewTileRegular ;;AND IF ending flag is set
LDA !EndingFlag
CMP #$06
BNE NewTileRegular

;;Check if this is the first transfer
NewTileToHeap:
REP #$30
LDA !HeapInitPos
BNE CopyNewTile
;;Initial position = BufferPosition + #$0400
REP #$20
LDA #$0400
CLC
ADC.W !BufferPosition
STA !HeapInitPos
;;Heap position = BufferPosition
LDA !BufferPosition
STA !HeapPosition
;;Old tile to heap buffer
CopyNewTile:
SEP #$20
LDY #$0000
LDX !BufferPosition
LoopHeap1:
LDA !NewTile,y
STA $7FEF00,x
INY
INX
CPY #$0010
BNE LoopHeap1
SEP #$30
JMP HeapQueue

NewTileRegular:
LDX !SmallDMAQueueSize
CPX #$80
BCC RegularDMA
;;If the queue overflows, force blank to write tiles
LDA #$00
STA $0609CE
LoopOverflow2:
LDA $804212        ;;Wait for
BPL LoopOverflow2  ;;V-Blank
LDX !SmallDMAQueueSize

RegularDMA:
LDX !SmallDMAQueueSize
LDY #$00
;;Video port
LDA #$80
STA $000600,x
INX
;;VRAM address
REP #$20
LDA #$0400
CLC
ADC.W !BufferPosition
LSR
STA $000600,x
INX
INX
SEP #$20
;;Size
LDA #$10
STA $000600,x
INX
;;Bytes
LoopThru:
LDA !NewTile,y
STA $000600,x
INY
INX
CPY #$10
BNE LoopThru
;;Add to queue
STX !SmallDMAQueueSize
JMP CheckWidth

;;==========================
HeapQueue:
;;==========================
;;Check if the line is complete
LDA !NextLetter
CMP #$80
BNE CheckWidth

LDX !BigDMAQueueSize
LDY #$00
;;Video port
LDA #$80	
STA $000500,x
INX
;;Load the initial position
REP #$20
LDA !HeapInitPos
LSR      
STA $000500,x
INX
INX
;;Size
LDA #$0000
SEP #$20
LDA !TileMapSize
REP #$20
ASL
ASL
ASL
STA $000500,x
INX
INX
;;RAM address
LDA !HeapLit
CLC
ADC !HeapPosition
STA $000500,x
INX
INX
;;Bank
SEP #$20
LDA #$7F
STA $000500,x
INX
;;Add to queue
STX !BigDMAQueueSize
;;Heap Position
STZ $FF13
STZ $FF14
;;HeapInitPos
STZ $FF15
STZ $FF16

;;==========================
CheckWidth:
;;==========================
LDX !A_Backup     ;;Load A backup as index
LDA.L Shift_Data,x  ;;Load tile width
SEC               ;;Substract shift
SBC !Shift
STA !Width        ;;Store as old width
BEQ Reset00       ;;If zero, reset shift and buffer position
BMI Reset08       ;;If less, reset everything 
BPL GetWidth      ;;If greater, continue normally
Reset00:
JSR ResetShift     ;;Redundancy save
JMP GetWidth
Reset08:              
JSR ResetShift     ;;Redundancy save
LDA #$00              
SEC
SBC !Width
STA !Width
STA !ShiftLeft    ;;Old width and shift left = 0 - Negative width     
LDA #$08
SEC
SBC !Width
STA !ShiftRight   ;;Shift right = 8 - Width
JMP LoadBackups

;;==========================
GetWidth:
;;==========================
LDA !Width
STA !ShiftRight   ;;Shift right = Width
LDA #$08            
SEC
SBC !Width
STA !ShiftLeft    ;;Shift left = 8 - Width

;;==========================
SaveOldTile:
;;==========================
LDX #$00
LoopSaveOldTile:
LDA !NewTile,x
STA !OldTile,x
INX
CPX #$10
BNE LoopSaveOldTile

;;==========================
LoadBackups:
;;==========================
LDY !Y_Backup
LDA !NextLetter
CMP #$80
BNE skip
;;Reset stuff
STZ !TileMapSize
STZ !Shift
STZ !Width
STZ !TilPosArrayIndex
skip:
PLB                ;;Restore bank
JML $00E6AA		   ;;Exit

;;=========================
ResetShift:
;;=========================
REP #$20
LDA !BufferPosition
SEC
SBC.W #$10
STA !BufferPosition
SEP #$20
STZ !Shift
RTS

;==========================
;Text font to VRAM
;==========================
TextFontToVRAM:
;;Check stage select context
LDA $D0
CMP #$02
BNE ContinueTextToVram
LDA $D1
BNE ContinueTextToVram
LDA $D2
CMP #$01
BNE ContinueTextToVram
JSL CleanVromBuffer
JMP SkipTextToVram
ContinueTextToVram:
;;;;;;;;;;;;;;;;;;;
LDX $A4
LDY #$00
;;Video port
LDA #$80	
STA $000500,x
INX
;;Overwrite original font
REP #$20
LDA #$0210
LSR
STA $000500,x
INX
INX
;;Size
LDA #$05F0
STA $000500,x
INX
INX
;;;;;;;;;;;;;;
;;RAM address
RamAddress:
REP #$20
LDA.W #Menu_Data
STA $000500,x
INX
INX
;;Bank
SEP #$20
LDA #$2B
STA $000500,x
INX
;;Add to queue
AddToQueue:
STX $A4
SkipTextToVram:
LDX $A5
LDY #$00
RTL

;==========================
;Check CHR address
;==========================
CheckCopyCHR:
REP #$20 				;;Bugfix 
LDA $F734,x
;;CMP #$238D
;;BEQ OptionsGFX 
CMP #$21DF
BNE ExitCheckCopyCHR
;==========================
;Copy CHR
;==========================
PHX
PHY
SEP #$30
LDX $A4
;;Video port
LDA #$80	
STA $000500,x
INX
;;Write after the original CHR
REP #$20
LDA #$4600
LSR
STA $000500,x
INX
INX
;;Size
LDA #$0A00
STA $000500,x
INX
INX
;;RAM address
REP #$20
LDA #$8000
STA $000500,x
INX
INX
;;Bank
SEP #$20
LDA #$2B
STA $000500,x
INX
;;Add to queue
STX $A4
;;LDA #$17
;;STA $C1
REP #$30
PLY
PLX
ExitCheckCopyCHR:
LDA $F734,x
STA $F7
RTL

OptionsGFX:
PHX
PHY
SEP #$30
LDX $A4
;;Video port
LDA #$80	
STA $000500,x
INX
;;Write after the original CHR
REP #$20
LDA #$4800
LSR
STA $000500,x
INX
INX
;;Size
LDA #$0400
STA $000500,x
INX
INX
;;RAM address
REP #$20
LDA #Option_Data
STA $000500,x
INX
INX
;;Bank
SEP #$20
LDA #$2B
STA $000500,x
INX
;;Add to queue
STX $A4
REP #$30
PLY
PLX
LDA $F734,x
STA $F7
RTL

;=====================
;Write password sprite
;strings
;=====================
WriteSpriteStrings:
;;Check GFX pointer
LDA $F3C4,y
CMP #$F5A2
BEQ ContinueSpriteStrings
CMP #$F51E
BEQ JumpReadyString
JMP SkipWriteStrings
JumpReadyString:
JMP ReadyStrings
ContinueSpriteStrings:
PHX
PHY
SEP #$30
LDX $A4
;;Video port
LDA #$80	
STA $000500,x
INX
;;Write after the original CHR
REP #$20
LDA #$CC00
LSR
STA $000500,x
INX
INX
;;Size
LDA #$0400
STA $000500,x
INX
INX
;;RAM address
REP #$20
LDA #Start_Data
STA $000500,x
INX
INX
;;Bank
SEP #$20
LDA #$2B
STA $000500,x
INX
;;Add to queue
STX $A4
REP #$20
PLY
PLX
LDA $F3C4,y
SkipWriteStrings:
STA $10
RTL

;=====================
;Write "Are you ready"
;font
;=====================
WriteReadyString:
;;Check GFX pointer
LDA $F3C4,y
CMP #$F721
; BEQ ContinueReadyStrings
; CMP #$F51E
; BNE SkipReadyString
; ContinueReadyStrings:
BNE SkipReadyString
ReadyStrings:
PHX
PHY
SEP #$30
LDX $A4
;;Video port
LDA #$80	
STA $000500,x
INX
;;Write after the original CHR
REP #$20
LDA $F3C4,y
CMP #$F51E
BNE SkipAddressChange
LDA #$C000
JMP LSREm
SkipAddressChange:
LDA #$CC00
LSREm:
LSR
STA $000500,x
INX
INX
;;Size
LDA #$0400
STA $000500,x
INX
INX
;;RAM address
REP #$20
LDA #Ready_GFX
STA $000500,x
INX
INX
;;Bank
SEP #$20
LDA #$2B
STA $000500,x
INX
;;Add to queue
STX $A4
REP #$20
PLY
PLX
LDA $F3C4,y
SkipReadyString:
STA $F3
RTL

;=====================
;Write weapon text
;=====================
org $B74E
JSL CheckCopyCHR
NOP
;==========================
;Write menu text
;==========================
org $86A3
JSL TextFontToVRAM
;==================================
;Change pointer for cast roll/stage
;select text
;==================================
org $E925
JSR TwentyFourBitPointers
;==================================
;Save pointer index
;==================================
org $E647
JSR SavePointerIndex
NOP
;==================================
;Write password text
;==================================
org $B47E
JSL WriteSpriteStrings
NOP
;==================================
;Write "Are you ready?" text
;==================================
org $B524
JSL WriteReadyString
NOP

;;Cancel normal letters transfer
org $6F722
dw $0010
;;Cancel normal letters transfer
org $6F51F
dw $0010

;###############
;Palettes	   #
;###############
;;Menu text shadows
org $CB2C6
db $C4, $40 
org $CB2CE
db $AE, $08

incsrc "src_eng/Menu_Strings_Eng.asm"

;;Weapon text pointers
org $6A010
dw AcidRushWeapon, ParasiticBombWeapon, TriadThunderWeapon, SpinningBladeWeapon
dw RaySplasherWeapon, BugHoleWeapon, FrostShieldWeapon, TornadoFangWeapon
dw HyperCannonWeapon, NullWeapon, XBusterWeapon, ExitWeapon

incsrc "src_esp/Weapon_Text_Esp.asm"

;;Sub-Tank text fix
org $D42A
LDA.B #$0C
org $D435
LDA.W SubTankWeapon,x

;;Sub Tank highlight palette 1
org $C7BA
db $31
;;Don't touch this X2
;;Shadow palette / bank 1
;org $C7FE
;db $3D
;;Shadow palette / bank 2
org $C803
db $3D
;;Don't touch this
;;Highlight palette / bank
;;org $C822
;;db $31
;;Weapon highlight palette - Return to choice
org $C827
db $31
;;Sub Tank shadow palette 1
org $C880
db $3D
;;Sub Tank highlight palette 2
org $C962
db $31
;;Exit highlight palette - When you select another option after highlighting it
org $C97B
db $3D
;;Exit highlight palette - When you select it
org $C98A
db $31
;;???
org $CC7D
db $3D
;;Don't touch this
;;org $D12B
;;db $3D
;;???
;;org $D14F
;;db $31
;;Don't touch this
;;org $D153
;;db $3D
;;Weapon highlight palette  - Entering the menu
org $D1F8
db $31
;;X-Buster shadow palette - When you enter the menu not using the X-Buster
org $D204
db $3D
;;Chosen weapon highlight palette - When you enter the menu with any weapon other than the X-Buster
org $D222
db $31
;;Shadow palette / bank 3
org $D22E
db $3D
;;Shadow palette / bank 4
org $D244
db $3D
;;More space for the stage select screen text
org $38595
db $20