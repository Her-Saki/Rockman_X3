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
db "Obtuviste el:"
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
db "En el a*o 21XX, todos los Irregulars fueron neutralizados@@por el Dr. Doppler, un cient%fico Reploid.@@@"
db $87, $F0, $87, $10, $86, $05, $7D
db "Luego de esto, los Reploids m|s aptos fueron reunidos@@en Doppel Town, una ciudad pac%fica que el Dr. Doppler@@construy}.@@@"
db $87, $F0, $87, $40, $86, $07, $7D
db "Desde entonces, algunos meses han transcurrido...@@@"
db $87, $F0, $87, $10, $86, $05, $82
IntroText2:
;;Original text:
;;突然沈静化したはずのイレギュラー達が一斉に反乱を起こした。
;;ドップラ博士が主謀者だと言う事を突き止めたイレギュラーハンター本部はエックスとゼロにドップラー博士の捕獲とドップラ軍の壊滅を命じた。
db $89, $A0, $0A, $C0, $88, $01, $7D
db "Pero en un inesperado giro, aquellos Irregulars@@supuestamente recuperados se rebelaron en masa.@@@"
db $87, $F0, $87, $10, $86, $05, $8B, $01
db "Tras concluir que el Dr. Doppler los estaba liderando,@@el Cuartel General envi} a X y Zero para capturarlo y@@acabar con su ej{rcito.@@@"
db $87, $F0, $87, $10, $86, $07, $82
IntroText3:
;;Original text:
;;イレギュラーハンター
;;エックス＆ゼロ出動！
db $89, $A2, $0A, $C0, $88, $01, $7D
db "+X y Zero, en marcha!@@@"
db $87, $F0, $87, $40, $86, $05, $82
IntroText4:
;;Original text:
;;数時間後、イレギュラーハンター本部より緊急連絡が入った。
db $89, $A2, $0A, $C0, $88, $01, $7D
db "Horas despu{s, una llamada de emergencia lleg}@@desde el Cuartel General.@@@"
db $87, $F0, $87, $10, $86, $05, $82
IntroText5:
;;Original text:
;;こちらはイレギュラーハンター本部！
;;ドップラ軍の攻撃を受け、応戦中！
;;本部周辺のイレギュラーハンターは直ちに帰還し、応戦に当たれ！
db $89, $A2, $0A, $C2, $88, $02, $7D
db "+Aqu% el Cuartel General!@@@"
db $87, $F0, $87, $10, $86, $03, $7D
db "+El ej{rcito de Doppler nos ataca!@@@"
db $87, $F0, $87, $10, $86, $03, $7D
db "+Todos los Hunters que se encuentren cerca del@@per%metro del cuartel deben regresar inmediatamente@@para asistir en el contraataque!@@@"
db $87, $F0, $87, $10, $86, $09, $82
OpeningStage1:
;;Original text:
;;エックス、オレは本部の周辺から片付ける。
;;お前は、内部の敵を頼む。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "X, yo me encargar{ de@@limpiar el per%metro del@@cuartel.@@@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $8B, $01, $7D
db "T# enc|rgate de los@@enemigos del interior.@@@@"
db $83, $06, $81, $80, $86, $07, $82
OpeningStage2:
;;Original text:
;;君は、行方不明になっていたマックじゃないか。
db $89, $A9, $08, $C0, $88, $02, $8B, $02, $7D
db "T# eres... +ese Hunter que@@fue declarado perdido, Mac!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
OpeningStage3:
;;Original text:
;;フッフッフッ、エックス、お前は甘いな。
;;オレはもうイレギュラーハンターではなくドップラー軍団の一員だ。
;;悪いがお前を捕獲する。
db $89, $A9, $08, $C1, $88, $02, $8B, $01, $7D
db "+Hahaha! +Qu{ ingenuo@@eres, X!@@Yo ya no soy un Hunter,@@sino un miembro de las@@fuerzas de Doppler.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "Lo siento, pero debo@@capturarte.@@"
db $83, $06, $81, $80, $86, $05, $82
OpeningStage4:
;;Original text:
;;大丈夫か、エックス？
;;あ、ありがとう、ゼロ。大丈夫だ。
;;オレはまた、本部周辺に回る。エックス、油断するなよ。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "`Te encuentras bien, X?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $8B, $02, $C0, $7D
db "E-Estoy bien. Gracias@@por rescatarme.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $8B, $01, $C2, $7D
db "Ir{ a revisar el per%metro@@una vez m|s.@@No bajes la guardia.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
OpeningStage5:
;;Original text:
;;どうやら敵は片付いた様だ。
;;オレは暫く本部の修復作業に当たるが、必要な時は呼び出してくれ。
;;じゃ、頑張れよエックス。
db $89, $65, $08, $C2, $88, $02, $8B, $01, $7D
db "Al parecer esos eran todos...@@"
db $83, $0B, $81, $80, $86, $03, $87, $1E, $8B, $01, $7D
db "Ir{ al cuartel a que me reparen, pero@@puedes llamarme si me necesitas.@@"
db $83, $0B, $81, $80, $86, $05, $87, $1E, $8B, $01, $7D
db "Buena suerte, X.@@"
db $83, $0B, $81, $80, $86, $03, $87, $1E, $82
DrLight1:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは空中での機動力をパワーアップさせる事が出来るフットパーツを授けよう。
;;空中で上と左右の３方向にエアーダッシュする事が出来るようになるぞ
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ una mejora@@para tus piernas que@@aumentar| tu capacidad@@para moverte en el aire.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Ahora podr|s impulsarte@@tanto hacia atr|s y@@adelante como hacia arriba.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLight2:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは最新鋭の人工衛星から送られてくる情報をもとに、各地に隠されている色々なアイテムを発見する事が出来るヘッドパーツを授けよう。
;;人工衛星の地中探査機能を使ってアイテムの位置まで分かるはずじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ una mejora@@para tu casco que te@@permitir| encontrar objetos@@ocultos usando informaci}n@@del m|s avanzado sat{lite.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "Ahora podr|s averiguar sus@@ubicaciones con la funci}n@@de geolocalizaci}n del@@sat{lite.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLight3:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは敵から受けるダメージを減らす事が出来るボディパーツを授けよう。
;;ダメージを受けると防御フィールドが発生して、敵から受けるダメージを少なくしてくれるはずじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ una mejora@@para tu torso que mitigar|@@el da*o que recibes de@@tus enemigos.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Cada vez que te da*en,@@un campo de fuerza te@@rodear| para reducir el@@impacto.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLight4:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;チャージショットを更にパワーアップさせるアームパーツを授けよう。
;;チャージショットを二つ打てるようになり、更に二つのショットを重ねる事によって拡散ショットにパワーアップする事が出来るクロスチャージじゃ。
;;また、有らゆるショットをチャージさせる事でより強力な攻撃を繰り出す事も出来るのじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ una mejora@@que aumentar| el poder@@de tus disparos cargados.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Esta carga cruzada te@@permitir| no s}lo lanzar@@dos disparos m|s, sino@@tambi{n convertirlos en@@m#ltiples r|fagas.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "Adem|s, podr|s realizar@@disparos m|s potentes con@@cualquiera de tus armas@@luego de cargarlas.@@"
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
db "+Ca%ste directo en mi@@trampa!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C0, $8B, $02, $7D
db "`Acaso eres... "
db $87, $1E
db "Vava?@@"
db $87, $5A
db "+`C}mo sobreviviste?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C1, $8B, $01, $7D
db "He colocado bombas en@@toda la f|brica.@@"
db $87, $3C
db "+En un par de minutos t#@@explotar|s junto a ella!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Mientras tanto, te@@enfrentar|s a m% como tu@@#ltimo oponente.@@"
db $87, $3C
db "+MUERE, X!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
;;I feel bad for Vava. We all know he will never beat X.
VavaDefeated:
;;Original text:
;;これで勝ったと思うな…
;;オレは貴様はを倒す為になんどでも甦って…や…る…
db $89, $A9, $08, $C1, $88, $02, $7D
db "No creas que me venciste...@@"
db $87, $3C, $88, $04
db "Revivir{ cuantas veces sea@@"
db $88, $07
db "necesario... hasta...@@"
db $88, $0C
db "derrotarte...@@"
db $87, $B4, $82
VavaDrDopplerStage:
;;Original text:
;;やっと来たか、エックス…
;;待ち兼ねたぞ。
;;最新型ライドアーマー「ブラウンベア」で、今までの恨みをはらさせてもうらうぞ！！
db $8A, $89, $A9, $08, $C1, $88, $02, $7D
db "Finalmente est|s aqu%, X...@@Estaba esper|ndote...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "+Con esta nueva Ride@@Armor, ''Brown Bear'', te@@har{ pagar por todas@@esas humillaciones!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
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
db "Estaba esper|ndote, X.@@Yo soy el Dr. Doppler.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "He estado observando tus@@acciones muy atentamente.@@S}lo alguien as% de fuerte@@podr%a derrotar a mis@@camaradas.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "Dime, `estar%as interesado@@en apoyarnos con tu@@poder?@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Juntos podemos lograr que@@los Reploids dominen el@@mundo bajo el mando@@del Maestro Sigma.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Ser%a una utop%a perfecta,@@`no crees?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C0, $8B, $02, $7D
db "+Jam|s!@@+Tus planes y los de Sigma@@se acabar|n aqu% y ahora!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C2, $8B, $01, $7D
db "+Hmph! +Qu{ estupidez!@@En ese caso no tendr{@@m|s remedio que eliminarte.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Te convertir{ en una parte@@del cuerpo de Sigma.@@+Es tu fin, X!@@"
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
db "I-Impresionante...@@Quiz|s t#... logres...@@derrotar a... Sigma...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C0, $8B, $02, $7D
db "+`Qu{ m|s sabes sobre {l?!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C2, $8B, $01, $7D
db "Su verdadera forma es...@@un virus inform|tico@@maligno...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "[l fue quien me lav}@@el cerebro... para que@@yo construyera ese@@terror%fico cuerpo...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $C0, $8B, $02, $7D
db "+`D}nde se encuentra@@ese cuerpo?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C2, $8B, $01, $7D
db "Est| oculto en un hangar@@en la base de este@@laboratorio...@@Estoy seguro de que Sigma@@a#n no lo ha pose%do...@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "No te preocupes por m%...@@Debes ir cuanto antes a@@destruir ese cuerpo...@@No queda mucho tiempo...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $C0, $8B, $02, $7D
db "Entendido.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
LastStageNull:
db $82
LastStage1:
;;Original text:
;;オレはこのまま動力炉の破壊に向かう。
;;エックス、お前は上の階へ回ってシグマのボディを破壊してくれ。
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Ir{ ahora mismo a destruir@@el reactor.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "T# enc|rgate de destruir@@el cuerpo de Sigma en@@el piso de arriba.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
Sigma1:
;;Original text:
;;また会えて嬉しいぞ。エックスよ…
;;ドップラを利用してここまで来たが…
;;また、貴様のお蔭で台無しにされたよ…
;;どうやら貴様とは闘う運命に有るらしいな…
;;行くぞ！！
db $89, $A9, $08, $C1, $88, $02, $7D
db "Encantado de verte de@@nuevo, X...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Llegu{ tan lejos usando@@a Doppler s}lo para que@@t# lo echaras a perder@@otra vez...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Al parecer el destino@@mismo quiere vernos pelear...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "+PREP;RATE!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
Sigma2:
;;さすがだな、エックス…
;;だが、これで終りだとおもうな！！
;;ドップラーに開発させた、究極の戦闘用ボディの力を、今、この場であじあわせてくれるわ！！
db $89, $A9, $08, $C1, $88, $02, $7D
db "Como esperaba de ti...@@+Pero no creas que@@esto acaba aqu%!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "++Ahora probar|s el poder@@supremo del cuerpo que le@@hice construir a Doppler!!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82

;;Original text:
;;また会えて嬉しいぞ。エックスよ…
;;ドップラを利用してここまで来たが…
;;また、貴様のお蔭で台無しにされたよ…
;;どうやら貴様とは闘う運命に有るらしいな…
;;行くぞ！！
db $89, $A9, $08, $C1, $88, $02, $7D
db "Encantado de verte de@@nuevo, X...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Llegu{ tan lejos usando@@a Doppler s}lo para que@@t# lo echaras a perder@@otra vez...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Al parecer el destino@@mismo quiere vernos pelear...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "+PREP;RATE!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
SigmaDefeated:
;;Original text:
;;ま…まさか…こんなはずでは！！
;;このボディを以てしても貴様に勝てないとは…
;;こうなったら、エックス！
;;貴様のそのボディをいただく！
db $89, $A9, $08, $C1, $88, $02, $7D
db "N-No...@@++Esto no tiene sentido!!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "`C}mo es posible que no@@pueda vencerte ni siquiera@@con este cuerpo...?@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "En ese caso... +me robar{@@el tuyo!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
;;UNUSED TEXT
UnusableMessageNumber:
;;Original text:
;;このメッセージナンバーは使われておりません。
db $89, $89, $08, $C6, $88, $02, $7D
db "No puedes usar este c}digo de mensaje.@@"
db $83, $06, $81, $80, $86, $05, $87, $78, $82
LastStage2:
;;Original text:
;;？！　しまった！
;;行き止まりだ…
db $89, $65, $08, $C0, $88, $02, $8B, $02, $7D
db "+Oh, demonios! +No hay salida...!@@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
LastStage3:
;;Original text:
;;ハハハハ…
;;残念だったな、エックスよ。
;;今度はお前に取り付く世界を手に入れてやる！
db $89, $65, $08, $C1, $88, $02, $8B, $03, $7D
db "+Hahahaha! Qu{ l|stima, `verdad, X?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "+Ahora me apoderar{ de tu cuerpo y el@@mundo ser| m%o!@@"
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
db "+GAAAAAAAHHH! `F-Fuiste t#... Zero...?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "T#... de nuevo...@@"
db $83, $0B, $81, $80, $86, $03, $C2, $88, $02, $8B, $01, $87, $1E, $7D
db "Dime, Sigma, +`a qu{ sabe el anticuerpo@@de Doppler que te inyect{ con mi sable?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Lamento la demora, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Mientras regresaba de destruir el reactor@@encontr{ este anticuerpo en la sala de@@m|quinas.@"
db $83, $06, $81, $80, $86, $06, $87, $1E, $7D
db "Con {l puedes da*ar a Sigma a#n si no@@tiene forma f%sica.@@"
db $83, $0B, $81, $80, $86, $05, $C1, $88, $02, $8B, $03, $87, $1E, $7D
db "Mi... programa... se... desvanece...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Pero volver{...@@Alg#n d%a... volver{...@@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
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
db "+GAAAAAAAHHH! `E-Eres t#... Doppler...?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "+`E-En qu{ momento...?@@"
db $83, $0B, $81, $80, $86, $03, $C2, $88, $02, $8B, $01, $87, $1E, $7D
db "+`A qu{ sabe el anticuerpo que prepar{,@@Sigma?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Lamento haberte causado tantos problemas,@@X...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Lo que le hice a esos Reploids fue@@imperdonable...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "As% que d{jame al menos llevarme este@@virus al infierno, a modo de disculpa.@@"
db $83, $0B, $81, $80, $86, $05, $C1, $88, $02, $8B, $03, $87, $1E, $7D
db "Mi... programa... se... desvanece...@@"
db $83, $0B, $81, $80, $86, $03, $C2, $88, $02, $8B, $01, $87, $1E, $7D
db "Adi}s, X...@@Hasta... siempre...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82

ChoosingZero:
;;Original text:
;;エックスか、今直ぐ行くぜ！
db $89, $E4, $09, $C2, $88, $02, $7D
db "=======`Eres t#, X?@@==+Ir{ ahora mismo!@"
db $82
ChoosingX:
;;Original text:
;;ゼロか、今直ぐ行くよ！
db $89, $E4, $09, $C2, $88, $02, $7D
db "=`Eres t#, Zero?@@==+Ir{ ahora mismo!@"
db $82
SwitchingToZero:
;;Original text:
;;ゼロ、ここから先はオレに任せてくれ！
db $89, $E4, $09, $C2, $88, $02, $7D
db "=+Yo me encargar{@@===del resto, Zero!@"
db $82
ZeroDefeated:
;;Original text:
;;済まない、エックス…
;;しくじっちまった…
;;どうやら動力炉を、やられたみたいだ…
;;早くドップラーの計画を打ち砕いてくれ。
;;頼んだぞ、エックス…
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Lo siento, X...@@He fallado...@@Parece que mi reactor ha@@sido... destruido...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Debes acabar con el@@plan de Doppler cuanto@@antes...@@Conf%o en ti, X...@@"
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
db "+`Qu{ fue esa explosi}n?!@@+`Te encuentras bien,@@Zero?!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C2, $8B, $01, $7D
db "Lo siento, X...@@No pude contra esa cosa...@@Parece que mi reactor ha@@sido destruido...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Creo que tendr{ que@@regresar a la base del@@Dr. Cain para que me@@reparen...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Nunca se sabe qu{ enemigos@@puede haber m|s adelante,@@as% que aqu% tienes mi Beam@@Saber...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Debes acabar con los@@planes de Doppler y Sigma@@lo antes posible.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Cuento contigo, X...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82, $82

DrLightEnc1:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな回復能力を追加する「ヘッドチップ」を授けよう。
;;じっとして動かなければ少しずつライフエネルギーを回復する事が出来るじゃろう。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ un nuevo@@chip para tu casco@@que aumentar| tu capacidad@@para sanar.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Ahora podr|s recuperar@@energ%a poco a poco@@mientras no te mueves.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLightEnc2:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな防御能力を追加する「ボディチップ」を授けよう。
;;防御シールドの性能がアップしてシールドの耐久力が上り、更にダメージを受けにくくなるぞ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ un nuevo@@chip para tu cuerpo@@que aumentar| tu capacidad@@defensiva.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "La efectividad y duraci}n@@de tu escudo defensivo@@aumentar|n, y se reducir|@@a#n m|s el da*o que@@recibas.@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
DrLightEnc3:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな攻撃能力を追加する「アームチップ」を授けよう。
;;これは敵から受けたダメージを、　エックスの武器エネルギーに変換して溜ておき、いっきに解放してチャージショットを連射する事が出来るはずじゃ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ un nuevo@@chip para tu Buster@@que aumentar| tu capacidad@@ofensiva.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Esto te permitir|@@transformar el da*o que@@recibes en energ%a, la cual@@podr|s liberar en disparos@@en cadena.@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
DrLightEnc4:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは新たな移動能力を追加する「フットチップ」を授けよう。
;;これでエアーダッシュが二回まで連続して出来る様になり、空中での移動範囲が広くなるぞ。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ un nuevo@@chip para tus piernas,@@el cual mejorar| tus@@movimientos.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Con {l ser|s capaz de@@impulsarte en el aire hasta@@dos veces, aumentando as%@@la distancia que puedes@@cubrir.@"
db $83, $06, $81, $80, $86, $0B, $87, $1E, $82
DrLightWarning1:
;;Original text:
;;但し、この強化チップは４種類のうち、一つしか付ける事が出来ないんじゃ。
;;良く考えてからこのカプセルの中に入りなさい。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Sin embargo, s}lo puedes@@escoger un chip de los@@cuatro que existen.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Piensa detenidamente antes@@de entrar en la c|psula.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
DrLightWarning2:
;;Original text:
;;おや、どうやらお前はこの強化チップを装着する為のパワーアープパーツをまだ集めてないな…
;;このままでは装着出来ないから早く探してきなさい…
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Oh, al parecer a#n no tienes@@la mejora necesaria para@@instalar este chip...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "No podemos instalarlo sin@@la mejora, as% que mejor@@regresa cuando la hayas@@encontrado...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
DrLightWarning3:
;;Original text:
;;おや？…
;;すまんが、もう他の強化チップが装着されているので組み込めないみたいじゃ…
;;辛いじゃろうが、頑張ってくれ、エックス…
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Oh, vaya...@@Al parecer ya tienes otro@@chip instalado, por lo que@@no podr|s a*adir este...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Ser| una batalla dif%cil,@@pero debes dar lo mejor de@@ti, X...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrLightGoldArmor1:
;;Original text:
;;エックス、このカップセルに入るのじゃ。
;;ここでは全ての強化能力を手に入れる事が出来るハイパーチップを授けよう。
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Entra en la c|psula, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Te entregar{ un h%per@@chip que te permitir|@@obtener todas las mejoras.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
DrLightGoldArmor2:
;;Original text:
;;これで可也闘いが楽になるはずじゃ。
;;さあ頑張るのだぞ、エックス…
db $8A, $89, $A9, $08, $C0, $88, $02, $7D
db "Esto te ayudar|@@considerablemente en la@@batalla.@@Te deseo buena suerte, X...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
ZeroRescue1:
;;Original text:
;;エックス、助けに来たぜ！
;;吊り天井の方はオレに任せろ！！
;;お前はそのでくの坊を破壊するんだ！！
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "+Vine a darte una mano, X!@@+Yo me encargar{ del techo!@@+T# enc|rgate de este@@esbirro!@@"
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
db "+Esta instalaci}n est|@@infestada de Irregulars muy@@duros! Doppler los militariz},@@despu{s de todo...@@Avanza con cuidado.@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $C0, $8B, $02, $7D
db "Lo har{, Zero. Gracias.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C2, $8B, $01, $7D
db "En fin, +nos vemos m|s@@adelante!"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
;;Original text:
;;お前がエックスか。我名はマンダレーラだ。
;;我宿命により闘ってもうらう。イザ！
Mandarela1:
db $89, $A9, $08, $C2, $88, $02, $7D
db "T# eres X, `verdad?@@Mi nombre es Mandarela.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Tengo }rdenes de pelear@@contigo.@@+En guardia!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
MandarelaDefeated:
;;Original text:
;;こ、これほどのものとは…
;;今回は不覚にも私の負けだが…
;;次に合う時はお前を砕いてみせる！
db $89, $A9, $08, $C2, $88, $02, $7D
db "`C-C}mo es posible que@@exista semejante poder...?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Esta vez perd% debido@@a mi imprudencia... +pero@@la pr}xima me asegurar{@@de hacerte a*icos!@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
MandarelaDestroyed:
;;ぬおっっっ！！
;;こ、こいつのどこからこんなパワーが引き出せるというのだ！！
;;見事だ…エックス…
;;さらば！！
db $89, $A9, $08, $C2, $88, $02, $7D
db "++GAAAAH...!!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "+`C-C}mo es capaz de@@liberar tanto poder?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Fue un gran combate... X...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "++Hasta nunca!!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82

Vajurilla1:
;;Original text:
;;フッフッフッ…
;;私の名はヴァジュリーラ。
;;ドップラー博士の右腕として、多くのレプリロイド達を葬ってきた。
;;博士の命令だ。消えてもらう。
db $89, $A9, $08, $C2, $88, $02, $7D
db "Hehehe...@@Mi nombre es Vajurilla.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Como mano derecha del@@Doctor, he acabado con un@@sinf%n de Reploids.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "[l me ha encomendado@@eliminarte.@@Prep|rate para desaparecer.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
VajurillaDefeated:
;;Original text:
;;こっ、これがエックスの持っているパワーか…
;;ここは一まず引き上げるが次に合う時にはこうはいかんぞ
;;ハハハハ…
db $89, $A9, $08, $C2, $88, $02, $7D
db "`E-Es este tu verdadero@@poder...?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Me retirar{ por ahora, +pero@@nuestro pr}ximo encuentro@@ser| muy diferente!@@"
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
db "`E-Es esta tu habilidad@@especial...?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "+Imposible! +Entonces t#...!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "++GAH.....!!@@"
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
db "Es incre%ble que ese Hunter@@que no pude atrapar posea@@tanta habilidad...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "+Vajurilla, Mandarela!@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $82
TwoBossesDefeated2:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "Capturen a ese Hunter.@@De ser posible, con vida.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C0, $8B, $02, $7D
db "+Entendido!@@++Por la futura gloria del@@Dr. Doppler!!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
TwoBossesDefeated3:
db $89, $A9, $08, $C1, $88, $02, $8B, $03, $7D
db "Hehehe...@@No sabes cu|nto odiar%a@@tener que traerlo CON VIDA...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C2, $8B, $01, $7D
db "`T# de nuevo...?@@Despu{s de todas las@@mejoras que te hice tras@@revivirte...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "`No puedes seguir mis@@}rdenes siquiera esta@@vez...?@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C1, $8B, $03, $7D
db "Gracias por resucitarme,@@pero ahora tengo que saldar@@cuentas con ellos.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "As% que si no te importa,@@har{ las cosas a mi manera...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
TwoBossesDefeated4:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "+Hmph! Haz lo que quieras...@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Sin embargo, sigo sin poder@@creer que ese Hunter@@derrot} al Maestro dos@@veces...@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $82
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
db "`En qu{ podemos ayudarle,@@Dr. Cain?@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C1, $8B, $03, $7D
db "Hmm, ver|n...@@Luego de extraer y analizar@@los chips de memoria de los@@restos de los Irregulars que@@Doppler controlaba...@"
db $83, $06, $81, $80, $86, $0A, $87, $1E, $7D
db "He descubierto que, al@@parecer, su objetivo es@@construir un cuerpo de@@combate perfecto.@@"
db $83, $06, $81, $80, $86, $09, $87, $1E, $7D
db "Un cuerpo el cual re#na@@las habilidades especiales@@de cada Reploid.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C0, $8B, $02, $7D
db "`Un cuerpo de... combate?@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $C1, $8B, $03, $7D
db "As% es. En un principio cre%@@que estaba construyendo@@ese cuerpo para s% mismo...@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Dado que anteriormente era@@un cient%fico sin capacidad@@militar.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Sin embargo, todo indica@@que en realidad alguien m|s@@encarg} su construcci}n.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $C0, $8B, $02, $7D
db "`Alguien m|s...?@@+`Se refiere a Sigma?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
AllBossesDefeatedZero1:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "+`Sigue vivo?!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
AllBossesDefeated2:
db $89, $A9, $08, $C1, $88, $02, $8B, $03, $7D
db "Una base de investigaciones@@sin registrar fue localizada@@en el punto D.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Al parecer se trata del@@laboratorio secreto de@@Doppler.@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $7D
db "Dir%janse hacia all%@@inmediatamente.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $C0, $8B, $02, $7D
db "Entendido.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
AllBossesDefeatedZero2:
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "+Esta vez lo eliminaremos@@para siempre!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
VajurillaAvengesMandarela:
;;Original text:
;;エックス！
;;マンダレーラを倒すとはさすがだな。
;;だが、ここまでだ！
;;マンダレーラのかたきは、一緒にと取らせてもらう！
db $89, $A9, $08, $C2, $88, $02, $7D
db "S}lo alguien como t# podr%a@@derrotar as% a Mandarela.@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Sin embargo, +tu final ha@@llegado!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "+Ahora es mi turno de@@vengar a Mandarela!@@+En guardia!@@"
db $83, $06, $81, $80, $86, $07, $87, $1E, $82
MandarelaAvengesVajurilla:
;;Original text:
;;エックス、待ち兼ねたぞ。
;;お前がヴァジュリーラを倒すとはな…
;;ヴァジュリーラのかたきを取らせてもうら。
;;覚悟しろ！！
db $89, $A9, $08, $C2, $88, $02, $7D
db "Estaba esper|ndote, X.@@"
db $83, $06, $81, $80, $86, $03, $87, $1E, $7D
db "Me impresiona que lograras@@derrotar a Vajurilla...@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $7D
db "Ahora me toca vengarlo.@@+Prep|rate!@@"
db $83, $06, $81, $80, $86, $05, $87, $1E, $82
DrDopplerStage1Boss:
;;Original text:
;;待ち兼ねたぞ、エックス！！
;;ドップラ博士により我らは新たなる力を手に入れた。
;;今、その力を試させてもらう！！
db $89, $A9, $08, $C2, $88, $02, $8B, $01, $7D
db "+Est|bamos esper|ndote, X!@@"
db $83, $06, $81, $80, $8B, $FF, $86, $03, $87, $1E, $C1, $8B, $02, $7D
db "Hemos obtenido un nuevo@@poder gracias al Dr. Doppler.@@"
db $83, $06, $81, $80, $8B, $FF, $86, $05, $87, $1E, $C2, $8B, $01, $7D
db "+Y ha llegado el momento@@de probarlo!@@"
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
db "Una vez m|s, X ha destruido por completo los planes@@"
db $86, $02
db "de Sigma.@@"
db $86, $02
db "Sin embargo, despu{s de la batalla, todo lo que queda@@"
db $86, $02
db "en su coraz}n es vac%o.@@@@"
db $86, $04
db "`Por qu{ humanos y Reploids deben pelear unos@@"
db $86, $02
db "contra otros...?@@"
db $86, $02
db "`Por qu{ debemos pelear entre Reploids si somos@@"
db $86, $02
db "camaradas...?@@@@"
db $86, $04
db "Pensando en ello, X observa el laboratorio de@@"
db $86, $02
db "Doppler...@@@@@@@@"
db $86, $08, $7D
db "Al contemplar las llamas ardiendo resplandecientemente,@@"
db $86, $02
db "su fr%o cuerpo tiembla de ira e insoslayable tristeza...@@@@"
db $86, $04
db "X a#n no sabe que entre sus recuerdos latentes se@@"
db $86, $02
db "encuentra su inevitable pelea contra Zero...@@@@@@@@"
db $86, $08, $7D
db "Despu{s de todo, `qu{ les deparar| el futuro@@"
db $86, $02
db "a los dos...?@@@@@@@@"
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
db "Genjibo y Shurikein@"
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
db "Ride Armor clase DRA-00@@"
db $C1
db "(Kimera)@@(Cangaroo)@@(Hawk)@@(Frog)@"
db $87, $FF, $82
LifeUp1:
db $89, $42, $09, $C0, $88, $02, $7D, $7E
db "Mejora de vida@"
db $82
LifeUp2:
db $89, $42, $09, $C1, $88, $02, $7D, $7E
db "Mejora de vida@"
db $82
LifeUp3:
db $89, $56, $09, $C0, $88, $02, $7D, $7E
db "Mejora de vida@"
db $82
LifeUp4:
db $89, $56, $09, $C1, $88, $02, $7D, $7E
db "Mejora de vida@"
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
org $06F95E
dw Options_Tilemap
db #$2B
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
incbin "src_esp/Weapon_GFX_Esp.bin"
Menu_Data:
incbin "src_esp/Menu_GFX_Esp.bin"
Option_Data:
incbin "src_esp/Options_GFX_Esp.bin"
Options_Tilemap:
incbin "src_esp/Options_Tilemap_Esp.bin"
Start_Data:
incbin "src_esp/Start_GFX_Esp.bin"
Ready_GFX:
incbin "src_esp/Ready_GFX_Esp.bin"
;;Sprite data:
Start_Sprite_Data:
db $06
db $00, $47, $FC, $65
db $00, $3F, $FC, $64
db $00, $37, $FC, $63
db $00, $2F, $FC, $62
db $00, $27, $FC, $61
db $00, $1F, $FC, $60
Password_Sprite_Data:
db $0E
db $00, $2F, $FC, $72
db $00, $27, $FC, $71
db $00, $1F, $FC, $70
db $00, $17, $FC, $6F
db $00, $0F, $FC, $6E
db $00, $07, $FC, $6D
db $00, $FF, $FC, $6C
db $00, $F7, $FC, $6B

;;Tilde
db $00, $F7, $F5, $73

db $00, $EF, $FC, $6A
db $00, $E7, $FC, $69
db $00, $DF, $FC, $68
db $00, $D7, $FC, $67
db $00, $CF, $FC, $66

incsrc "src_esp/Ready_AnimTable_Esp.asm"

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
db "Poder: 3400 RP@@Velocidad: 8600 RP@@"
db $82
FrozenBuffalo:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Frozen Buffalo@@"
db $C3
db "Poder: 9200 RP@@Velocidad: 3200 RP@@"
db $82
GravityBeetbood:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Gravity Beetbood@@"
db $C3
db "Poder: 6200 RP@@Velocidad: 3600 RP@@"
db $82
AcidSeaforce:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Acid Seaforce@@"
db $C3
db "Poder: 5800 RP@@Velocidad: 4300 RP@@"
db $82
ElectroNamazuros:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Electro Namazuros@@"
db $C3
db "Poder: 8200 RP@@Velocidad: 1600 RP@@"
db $82
ScissorsShrimper:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Scissors Shrimper@@"
db $C3
db "Poder: 4000 RP@@Velocidad: 7600 RP@@"
db $82
ScrewMasaider:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Screw Masaider@@"
db $C3
db "Poder: 4200 RP@@Velocidad: 8000 RP@@"
db $82
ShiningTigerd:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Shining Tigerd@@"
db $C3
db "Poder: 3600 RP@@Velocidad: 9900 RP@@"
db $82
Vajurilla:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Vajurilla FF@@"
db $C3
db "Poder: 9400 RP@@Velocidad: 18000 RP@@"
db $82
Mandarela:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Mandarela BB@@"
db $C3
db "Poder: 18800 RP@@Velocidad: 8200 RP@@"
db $82
Godkarmachine:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Godkarmachine O Inary@@"
db $C3
db "Poder: 22900 RP@@Velocidad: 7200 RP@@"
db $82
VavaMK2:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Vava MK-2@@"
db $C3
db "Poder: 9200 RP@@Velocidad: 7200 RP@@"
db $82
DrDopplerBossRoll:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Dr. Doppler@@"
db $C3
db "Poder: 17400 RP@@Velocidad: 18000 RP@@"
db $82
SigmaBossRoll:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Sigma@@"
db $C3
db "Poder: 19000 RP@@Velocidad: 19000 RP@@@"
db $C0
db "Kaiser Sigma@@"
db $C3
db "Poder: 32000 RP@@Velocidad: 20000 RP@@"
db $82
SigmaVirus:
db $88, $01, $89, $AE, $08, $C0, $7D
db "Sigma Virus@@"
db $C3
db "Poder: ????? RP@@Velocidad: ????? RP@@"
db $82
RockmanAndZero:
db $88, $01, $89, $62, $08, $C0, $7D
db "Rockman X@@"
db $89, $69, $08, $C3
db "Poder: ???? RP@@Velocidad: ????? RP@@"
db $89, $E2, $08, $C0
db "Zero@@"
db $89, $E9, $08, $C3
db "Poder: ????? RP@@Velocidad: ????? RP@@"
db $82
AndYou:
db $88, $01, $89, $6E, $08, $C2, $83, $0A, $7D
db "+Y t#!@@@@@@@@"
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
CMP #$238D
BEQ OptionsGFX 
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
;Copy weapon text CHR
;=====================
org $B74E
JSL CheckCopyCHR
NOP
;==========================
;Jump to regular letters DMA
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
;Write sprite strings for password
;context
;==================================
org $B47E
JSL WriteSpriteStrings
NOP
;==================================
;Write "Are you ready?" sprite
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

incsrc "src_esp/Menu_Strings_Esp.asm"

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