;;New "Ready" animation table
Ready_Frame_1:
;;¿ frame 1
db $01, $00, $D8, $FD, !IQFrame1

Ready_Frame_2:
;;¿ frame 2
db $02, $00, $D8, $FD, !IQFrame2
;;E frame 1
db 		$00, $E0, $FD, !EFrame1

Ready_Frame_3:
;;¿ frame full
db $02, $00, $D8, $FD, !IQFrame3
;;E frame 2
db 		$00, $E0, $FD, !EFrame2
;;s frame 1
db 		$00, $E7, $FD, !sFrame1

Ready_Frame_4:
;;¿ frame full
db $04, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame 2
db 		$00, $E7, $FD, !sFrame2
;;t frame 1
db 		$00, $ED, $FD, !tFrame1


Ready_Frame_5:
;;¿ frame full
db $06, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 2
db 		$00, $ED, $FD, !tFrame2
;;Tilde frame 1
db 		$00, $F5, $F5, !TildeFrame1
;;a frame 1
db 		$00, $F3, $FD, !aFrame1

Ready_Frame_6:
;;¿ frame full
db $07, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame full
db 		$00, $ED, $FD, !tFrame3
;;Tilde frame 2
db 		$00, $F5, $F5, !TildeFrame2
;;a frame 2
db 		$00, $F3, $FD, !aFrame2
;;s frame 1
db 		$00, $F9, $FD, !sFrame1

Ready_Frame_7:
;;¿ frame full
db $08, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 3
db 		$00, $ED, $FD, !tFrame3
;;Tilde full
db 		$00, $F5, $F5, !TildeFrame3
;;a frame full
db 		$00, $F3, $FD, !aFrame3
;;s frame 2
db 		$00, $F9, $FD, !sFrame2
;;l frame 1
db 		$00, $02, $FD, !lFrame1

Ready_Frame_8:
;;¿ frame full
db $09, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 3
db 		$00, $ED, $FD, !tFrame3
;;Tilde full
db 		$00, $F5, $F5, !TildeFrame3
;;a frame full
db 		$00, $F3, $FD, !aFrame3
;;s frame full
db 		$00, $F9, $FD, !sFrame3
;;l frame 2
db 		$00, $02, $FD, !lFrame2
;;i frame 1
db 		$00, $04, $FD, !iFrame1

Ready_Frame_9:
;;¿ frame full
db $0A, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 3
db 		$00, $ED, $FD, !tFrame3
;;Tilde full
db 		$00, $F5, $F5, !TildeFrame3
;;a frame full
db 		$00, $F3, $FD, !aFrame3
;;s frame full
db 		$00, $F9, $FD, !sFrame3
;;l frame full
db 		$00, $02, $FD, !lFrame3
;;i frame 2
db 		$00, $04, $FD, !iFrame2
;;s frame 1
db 		$00, $06, $FD, !sFrame1


Ready_Frame_10:
;;¿ frame full
db $0B, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 3
db 		$00, $ED, $FD, !tFrame3
;;Tilde full
db 		$00, $F5, $F5, !TildeFrame3
;;a frame full
db 		$00, $F3, $FD, !aFrame3
;;s frame full
db 		$00, $F9, $FD, !sFrame3
;;l frame full
db 		$00, $02, $FD, !lFrame3
;;i frame full
db 		$00, $04, $FD, !iFrame3
;;s frame 2
db 		$00, $06, $FD, !sFrame2
;;t frame 1
db 		$00, $0C, $FD, !tFrame1

Ready_Frame_11:
;;¿ frame full
db $0C, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 3
db 		$00, $ED, $FD, !tFrame3
;;Tilde full
db 		$00, $F5, $F5, !TildeFrame3
;;a frame full
db 		$00, $F3, $FD, !aFrame3
;;s frame full
db 		$00, $F9, $FD, !sFrame3
;;l frame full
db 		$00, $02, $FD, !lFrame3
;;i frame full
db 		$00, $04, $FD, !iFrame3
;;s frame full
db 		$00, $06, $FD, !sFrame3
;;t frame 2
db 		$00, $0C, $FD, !tFrame2
;;o frame 1
db 		$00, $12, $FD, !oFrame1


Ready_Frame_12:
;;¿ frame full
db $0D, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 3
db 		$00, $ED, $FD, !tFrame3
;;Tilde full
db 		$00, $F5, $F5, !TildeFrame3
;;a frame full
db 		$00, $F3, $FD, !aFrame3
;;s frame full
db 		$00, $F9, $FD, !sFrame3
;;l frame full
db 		$00, $02, $FD, !lFrame3
;;i frame full
db 		$00, $04, $FD, !iFrame3
;;s frame full
db 		$00, $06, $FD, !sFrame3
;;t frame full
db 		$00, $0C, $FD, !tFrame3
;;o frame 2
db 		$00, $12, $FD, !oFrame2
;;? frame 2
db 		$00, $18, $FD, !QFrame1

Ready_Frame_13:
;;¿ frame full
db $0E, $00, $D8, $FD, !IQFrame3
;;E frame full
db 		$00, $E0, $FD, !EFrame3
;;s frame full
db 		$00, $E7, $FD, !sFrame3
;;t frame 3
db 		$00, $ED, $FD, !tFrame3
;;Tilde full
db 		$00, $F5, $F5, !TildeFrame3
;;a frame full
db 		$00, $F3, $FD, !aFrame3
;;s frame full
db 		$00, $F9, $FD, !sFrame3
;;l frame full
db 		$00, $02, $FD, !lFrame3
;;i frame full
db 		$00, $04, $FD, !iFrame3
;;s frame full
db 		$00, $06, $FD, !sFrame3
;;t frame full
db 		$00, $0C, $FD, !tFrame3
;;o frame full
db 		$00, $12, $FD, !oFrame3
;;? frame full
db 		$00, $18, $FD, !QFrame3

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