;;New "Ready" animation table
Ready_Frame_1:
;;A frame 1
db $01, $00, $D8, $FD, $0A

Ready_Frame_2:
;;A frame 2
db $02, $00, $D8, $FD, $13
;;r frame 1
db		$00, $DF, $FD, $0B

Ready_Frame_3:
;;A full
db $03, $00, $D8, $FD, $01
;;r frame 2
db 		$00, $DF, $FD, $14
;;e frame 1
db 		$00, $E3, $FD, $0C

Ready_Frame_4:
;;A full
db $04, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e frame 2
db 		$00, $E3, $FD, $15
;;y frame 1
db 		$00, $EC, $FD, $0D

Ready_Frame_5:
;;A full
db $05, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y frame 2
db 		$00, $EC, $FD, $16
;;o frame 1
db 		$00, $F4, $FD, $0E

Ready_Frame_6:
;;A full
db $06, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o frame 2
db 		$00, $F4, $FD, $17
;;u frame 1
db 		$00, $FA, $FD, $0F

Ready_Frame_7:
;;A full
db $07, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o full
db 		$00, $F4, $FD, $05
;;u frame 2
db 		$00, $FA, $FD, $18
;;r frame 1
db 		$00, $03, $FD, $0B

Ready_Frame_8:
;;A full
db $08, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o full
db 		$00, $F4, $FD, $05
;;u full
db 		$00, $FA, $FD, $06
;;r frame 2
db 		$00, $03, $FD, $14
;;e frame 1
db 		$00, $07, $FD, $0C

Ready_Frame_9:
;;A full
db $09, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o full
db 		$00, $F4, $FD, $05
;;u full
db 		$00, $FA, $FD, $06
;;r full
db 		$00, $03, $FD, $02
;;e frame 2
db 		$00, $07, $FD, $15
;;a frame 1
db 		$00, $0D, $FD, $10

Ready_Frame_10:
;;A full
db $0A, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o full
db 		$00, $F4, $FD, $05
;;u full
db 		$00, $FA, $FD, $06
;;r full
db 		$00, $03, $FD, $02
;;e full
db 		$00, $07, $FD, $03
;;a frame 2
db 		$00, $0D, $FD, $19
;;d frame 1
db 		$00, $13, $FD, $11

Ready_Frame_11:
;;A full
db $0B, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o full
db 		$00, $F4, $FD, $05
;;u full
db 		$00, $FA, $FD, $06
;;r full
db 		$00, $03, $FD, $02
;;e full
db 		$00, $07, $FD, $03
;;a full
db 		$00, $0D, $FD, $07
;;d frame 2
db 		$00, $13, $FD, $08
;;y frame 1
db 		$00, $19, $FD, $0D

Ready_Frame_12:
;;A full
db $0C, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o full
db 		$00, $F4, $FD, $05
;;u full
db 		$00, $FA, $FD, $06
;;r full
db 		$00, $03, $FD, $02
;;e full
db 		$00, $07, $FD, $03
;;a full
db 		$00, $0D, $FD, $07
;;d full
db 		$00, $13, $FD, $08
;;y frame 2
db 		$00, $19, $FD, $16
;;? frame 1
db 		$00, $21, $FD, $12

Ready_Frame_13:
;;A full
db $0D, $00, $D8, $FD, $01
;;r full
db 		$00, $DF, $FD, $02
;;e full
db 		$00, $E3, $FD, $03
;;y full
db 		$00, $EC, $FD, $04
;;o full
db 		$00, $F4, $FD, $05
;;u full
db 		$00, $FA, $FD, $06
;;r full
db 		$00, $03, $FD, $02
;;e full
db 		$00, $07, $FD, $03
;;a full
db 		$00, $0D, $FD, $07
;;d full
db 		$00, $13, $FD, $08
;;y full
db 		$00, $19, $FD, $04
;;? frame 2
db 		$00, $21, $FD, $09

Ready_Frame_14:
;;? frame full
db $01, $00, $7F, $7F, $1C

;;Original "Ready" animation table
;;#01: 01 00 EC FD 08
;;#02: 01 00 EC FF 09
;;#03: 03 00 EC 00 0F
;;		  80 EC FB 13
;;		  00 F4 FD 08
;;#04: 03 00 F4 FF 0A
;;		  80 EC F9 13
;;		  00 EC 01 0F
;;#05: 05 00 FC FD 08
;;		  80 F4 FA 10
;;		  00 F4 FF 10
;;		  00 EC 00 01
;;		  00 EC F8 00
;;#06: 05 00 FC FF 0B
;;		  80 F4 FA 10
;;		  00 F4 01 10
;;		  00 EC 00 01
;;		  00 EC F8 00
;;#07: 07 00 03 FD 08
;;		  00 FC 00 12
;;		  00 FC F9 11
;;		  80 F4 01 02
;;		  00 F4 FA 02
;;		  00 EC F8 00
;;		  00 EC 00 01
;;#08: 07 00 03 FF 0C
;;		  00 FC 00 12
;;		  00 FC F8 11
;;		  80 F4 01 02
;;		  00 F4 FA 02
;;		  00 EC F8 00
;;		  00 EC 00 01
;;#09: 09 00 0B FD 08
;;		  80 03 FB 13
;;		  00 03 00 13
;;		  00 FB F8 03
;;		  00 FB 00 04
;;		  80 F4 01 02
;;		  00 F4 FA 02
;;		  00 EC F8 00
;;		  00 EC 00 01
;;#10: 0A 40 0B FF 0D
;;		  00 0A FF 0D
;;		  80 03 FA 13
;;		  00 03 01 13
;;		  00 FB F8 03
;;		  00 FB 00 04
;;		  80 F4 01 02
;;		  00 F4 FA 02
;;		  00 EC F8 00
;;		  00 EC 00 01
;;#11: 0B 00 0A FF 0E
;;		  00 0A F9 14
;;		  80 03 01 05
;;	 	  00 03 FA 05
;;		  00 FB F8 03
;;		  00 FB 00 04
;;		  80 F4 01 02
;;		  00 F4 FA 02
;;		  00 EC F8 00
;;		  00 EC 00 01
;;		  40 0B F9 14
;;#12: 0B 40 0B F8 14
;;		  00 0A 00 0E
;;		  00 0A F8 14
;;		  80 03 01 05
;;		  00 03 FA 05
;;		  00 FB F8 03
;;		  00 FB 00 04
;;		  80 F4 01 02
;;		  00 F4 FA 02
;;		  00 EC F8 00
;;		  00 EC 00 01
;;#13: 0B 40 0B F8 06
;;		  00 0A F8 06
;;		  00 0A 00 07
;;		  80 03 01 05
;;		  00 FB F8 03
;;		  00 FB 00 04
;;		  80 F4 01 02
;;		  00 F4 FA 02
;;		  00 EC F8 00
;;		  00 EC 00 01
;;		  00 03 FA 05
;;#14: 01 00 FC FC 15