
;**************** TENIS1.MAC *************
                0190     .INCLUDE #D:TENIS1.MAC
                0100 ;SAVE#D:TENIS1.MAC
    =00B3       0110 TURBO = $B3
0624            0120     *=  $D301
D301 FE         0130     .BYTE $FE
D302            0140     *=  $BC20
BC20 01         0150     .BYTE 1
BC21 00BB       0160     .WORD NEWDL
BC23            0170 VOLVERE
BC23            0180     *=  $BB00
BB00            0190 NEWDL
BB00 707042     0200     .BYTE 112,112,66
BB03 09BB       0210     .WORD LINE0
BB05 3001       0220     .BYTE 48,1
BB07 23BC       0230     .WORD VOLVERE
BB09            0240 LINE0
BB09 8080A3AF   0250     .SBYTE "  CON Subrutina    C-"
BB0D AE8033F5
BB11 E2F2F5F4
BB15 E9EEE180
BB19 808080A3
BB1D 8D
BB1E            0260 C?
BB1E 90909080   0270     .SBYTE "000 SIN Reset  "
BB22 B3A9AE80
BB26 32E5F3E5
BB2A F48080
BB2D            0275 MENSAJE.TV
BB2D 80808080   0276     .SBYTE "    "
BB31 A3AFAE     0280 CON .SBYTE "CON"
BB34 B3A9AE     0290 SIN .SBYTE "SIN"
BB37 3030309B   0300 SECTOR .BYTE "000",$9B
BB3B 322E339B   0310 FACTOR .BYTE "2.3",$9B
BB3F            0320     *=  $8000
8000            0321 MENSAJE.NTSC
8000 AEB4B3A3   0322     .SBYTE "NTSC"
8004            0323 MENSAJE.PAL
8004 B0A1AC80   0324     .SBYTE "PAL "
8008 00         0330 EORBYTE .BYTE $00
8009 00         0340 BYTEMULA .BYTE $00
800A 0040       0350 CANTR .WORD $4000
800C 0040       0360 CANTW .WORD $4000
800E 0040       0370 LASTCANT .WORD $4000
    =000C       0380 DESDE = $0C
    =000E       0390 HASTA = $0E
    =00D4       0400 FRO =   $D4
    =00CB       0410 RAM =   $CB
    =00CD       0420 ROM =   $CD
8010 00         0430 FEOR .BYTE 0
8011 00         0440 FEOF .BYTE 0
8012 00         0450 BANCO .BYTE 0
8013 00         0460 GUARDABANCO .BYTE 0
8014            0470 SUB
8014 20E7DC     0480     JSR USERSUB+Z
8017            0490 SINRES
8017 4C9203     0500     JMP $0392
801A            0510 CONRES
801A 6CFCFF     0520     JMP ($FFFC)
    =9B04       0530 SET =   PROGRAMA-RAMPROG
801D            0540 STRING
801D 44313A     0550     .BYTE "D1:"
8020            0560 NOMBRE
8020            0570     *=  *+20
8034            0580 PABONITO
8034 10101000   0590     .SBYTE "000  BLOQUES A GRABAR "
8038 00222C2F
803C 31352533
8040 00210027
8044 32212221
8048 3200
804A            0600 GRABAMULA
804A A208       0601     LDX #$08
804C A462       0602     LDY PALNTS
804E F001       0603     BEQ GRABAMULA.1
8050 CA         0604     DEX
8051            0605 GRABAMULA.1
8051 208980     0606     JSR GRABAMULA.WAIT
8054 A98B       0607     LDA #139
8056 8D0FD2     0608     STA $D20F
8059 A208       0609     LDX #8
                0610 ;   STA BYTEMULA
805B A462       0611     LDY PALNTS
805D F001       0612     BEQ GRABAMULA.2
805F CA         0613     DEX
8060            0614 GRABAMULA.2
8060 208980     0615     JSR GRABAMULA.WAIT
8063 A90B       0616     LDA #11
8065 8D0FD2     0617     STA $D20F
8068 A210       0618     LDX #16
806A A462       0619     LDY PALNTS
                0620 ;   JSR LINEA10?
806C F002       0621     BEQ GRABAMULA.3
806E A20D       0622     LDX #13
8070            0623 GRABAMULA.3
8070 208980     0624     JSR GRABAMULA.WAIT
8073 A98B       0625     LDA #139
8075 8D0FD2     0626     STA $D20F
8078 A22F       0627     LDX #47
807A A462       0628     LDY PALNTS
807C F002       0629     BEQ GRABAMULA.4
                0630 ;   LDA #163
807E A227       0631     LDX #39
8080            0632 GRABAMULA.4
8080 208980     0633     JSR GRABAMULA.WAIT
8083 A90B       0634     LDA #11
8085 8D0FD2     0635     STA $D20F
8088 60         0636     RTS
                0637 ;
                0638 ;
                0639 ;
                0640 ;   STA $D20F
                0650 ;   JSR LINEA10?
                0660 ;   LDX #$07
8089            0670 LOOPMULA
                0680 ;   LDA #163
                0690 ;   ASL BYTEMULA
                0700 ;   BCC MULA0
                0710 ;   LDA #35
8089            0720 MULA0
                0730 ;   STA $D20F
                0740 ;   JSR LINEA10?
                0750 ;   DEX
                0760 ;   BPL LOOPMULA
                0770 ;   LDA #35
                0780 ;   STA $D20F
                0790 ;   RTS
8089            0791 GRABAMULA.WAIT
8089 209080     0792     JSR LINEA10?
808C CA         0793     DEX
808D D0FA       0794     BNE GRABAMULA.WAIT
808F 60         0795     RTS
                0796 ;
                0797 ; ESPERA X BARRIDOS
                0798 ;
                0799 ;
8090            0800 LINEA10?
8090 AD0BD4     0810     LDA $D40B
8093 C90A       0820     CMP #10
8095 D0F9       0830     BNE LINEA10?
8097 8D0AD4     0840     STA $D40A
809A 8D0AD4     0850     STA $D40A
809D 60         0860     RTS
809E            0870 EOREO
809E A000       0880     LDY #$00
80A0 B10C       0890     LDA (DESDE),Y
80A2 4D0880     0900     EOR EORBYTE
80A5 910C       0910     STA (DESDE),Y
80A7 E60C       0920     INC DESDE
80A9 D002       0930     BNE NOINCDESDE1
80AB E60D       0940     INC DESDE+1
80AD            0950 NOINCDESDE1
80AD A50D       0960     LDA DESDE+1
80AF C50F       0970     CMP HASTA+1
80B1 D0EB       0980     BNE EOREO
80B3 A50C       0990     LDA DESDE
80B5 C50E       1000     CMP HASTA
80B7 D0E5       1010     BNE EOREO
80B9 60         1020     RTS
80BA            1030 BANQUEO
80BA 0908       1040     ORA #$08
80BC 18         1050     CLC
80BD 2A         1060     ROL A
80BE 2A         1070     ROL A
80BF 48         1080     PHA
80C0 A9C3       1090     LDA #$C3
80C2 2D01D3     1100     AND $D301
80C5 8D01D3     1110     STA $D301
80C8 68         1120     PLA
80C9 0D01D3     1130     ORA $D301
80CC 29FE       1140     AND #$FE
80CE 8D01D3     1150     STA $D301
80D1 60         1160     RTS
80D2            1170 SUBCLOSE
                1180      CLOSE  1
    =0000      M         .IF %0<>1
               M           .ERROR "CLOSE: wrong number of parameters"
               M           .ELSE
               M            @CH  %1
    =0000      M           .IF %1>7
               M             LDA %1
               M             ASL A
               M             ASL A
               M             ASL A
               M             ASL A
               M             TAX
               M             .ELSE
80D2 A210      M             LDX #%1*16
               M             .ENDIF
               M           .ENDM
80D4 A90C      M           LDA #CCLOSE
80D6 9D4203    M           STA ICCOM,X
80D9 2056E4    M           JSR CIO
               M           .ENDIF
               M         .ENDM
80DC 60         1190     RTS
80DD            1200 SUBOPEN
                1210      OPEN  1,4,128,STRING
    =0000      M         .IF %0<>4
               M           .ERROR "OPEN: wrong number of arguments"
               M           .ELSE
    =0000      M           .IF %4<256
               M              XIO  COPN,%1,%2,%3,%$4
               M             .ELSE
               M              XIO  COPN,%1,%2,%3,%4
    =0000      M             .IF %0<2 .OR %0>5
               M               .ERROR "XIO: wrong number of arguments"
               M               .ELSE
               M                @CH  %2
    =0000      M               .IF %1>7
               M                 LDA %1
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 TAX
               M                 .ELSE
80DD A210      M                 LDX #%1*16
               M                 .ENDIF
               M               .ENDM
               M                @CV  %1
    =0001      M               .IF %1<256
80DF A903      M                 LDA #%1
               M                 .ELSE
               M                 LDA %1
               M                 .ENDIF
               M               .ENDM
80E1 9D4203    M               STA ICCOM,X ; COMMAND
    =0001      M               .IF %0>=4
               M                  @CV  %3
    =0001      M                 .IF %1<256
80E4 A904      M                   LDA #%1
               M                   .ELSE
               M                   LDA %1
               M                   .ENDIF
               M                 .ENDM
80E6 9D4A03    M                 STA ICAUX1,X
               M                  @CV  %4
    =0001      M                 .IF %1<256
80E9 A980      M                   LDA #%1
               M                   .ELSE
               M                   LDA %1
               M                   .ENDIF
               M                 .ENDM
80EB 9D4B03    M                 STA ICAUX2,X
               M                 .ELSE
               M                 LDA #0
               M                 STA ICAUX1,X
               M                 STA ICAUX2,X
               M                 .ENDIF
    =0000      M               .IF %0=2.OR %0=4
               M                  @FL  "S:"
               M                 .ELSE
    =0005      M     @@IO        .=  %0
               M                  @FL  %$(@@IO)
    =0000      M                 .IF %1<256
               M                   JMP *+%1+4
               M     @F            .BYTE %$1,0
               M                   LDA # <@F
               M                   STA ICBADR,X
               M                   LDA # >@F
               M                   STA ICBADR+1,X
               M                   .ELSE
80EE A91D      M                   LDA # <%1
80F0 9D4403    M                   STA ICBADR,X
80F3 A980      M                   LDA # >%1
80F5 9D4503    M                   STA ICBADR+1,X
               M                   .ENDIF
               M                 .ENDM
               M                 .ENDIF
80F8 2056E4    M               JSR CIO
               M               .ENDIF
               M             .ENDM
               M             .ENDIF
               M           .ENDIF
               M         .ENDM
80FB 1009       1220     BPL OPENOK
80FD 20D280     1230     JSR SUBCLOSE
8100 20FD81     1240     JSR SUBDIRECTORIO
8103 4CDD80     1250     JMP SUBOPEN
8106            1260 OPENOK
8106 60         1270     RTS
8107            1280 SUBBGET
                1290      BGET  1,$4000,CANTR
    =0000      M         .IF %0<>3
               M           .ERROR "BGET: wrong number of parameters"
               M           .ELSE
8107 A210      M           LDX #%1*16
8109 A907      M           LDA #$07
810B 9D4203    M           STA ICCOM,X
810E A900      M           LDA # <%2
8110 9D4403    M           STA ICBADR,X
8113 A940      M           LDA # >%2
8115 9D4503    M           STA ICBADR+1,X
8118 AD0A80    M           LDA %3
811B 9D4803    M           STA ICBLEN,X
811E AD0B80    M           LDA %3+1
8121 9D4903    M           STA ICBLEN+1,X
8124 2056E4    M           JSR CIO
               M           .ENDIF
               M         .ENDM
8127 60         1300     RTS
8128            1310 SUBREAD
8128 20DD80     1320     JSR SUBOPEN
812B A904       1330     LDA #$04
812D 8D1280     1340     STA BANCO
8130            1350 LOOPBANCOS
8130 CE1280     1360     DEC BANCO
8133 AD1280     1370     LDA BANCO
8136 20BA80     1380     JSR BANQUEO
8139 200781     1390     JSR SUBBGET
813C AD5803     1400     LDA 856
813F CD0A80     1410     CMP CANTR
8142 D008       1420     BNE FINCARGA
8144 AD5903     1430     LDA 857
8147 CD0B80     1440     CMP CANTR+1
814A F0E4       1450     BEQ LOOPBANCOS
814C            1460 FINCARGA
814C AD1280     1470     LDA BANCO
814F 8D1380     1480     STA GUARDABANCO
8152 AD5803     1490     LDA 856
8155 8D0E80     1500     STA LASTCANT
8158 85D4       1510     STA FRO
815A AD5903     1520     LDA 857
815D 8D0F80     1530     STA LASTCANT+1
8160 85D5       1540     STA FRO+1
8162 A202       1550     LDX #$02
8164 A990       1560     LDA #'0-32
8166            1570 VUELVEA0
8166 9D3480     1580     STA PABONITO,X
8169 AC1080     1590     LDY FEOR
816C F002       1600     BEQ NOEORFF
816E 49FF       1610     EOR #$FF
8170            1620 NOEORFF
8170 9D3132     1630     STA TENMEBLK,X
8173 CA         1640     DEX
8174 10F0       1650     BPL VUELVEA0
8176 A203       1660     LDX #$03
8178            1670 CALCULOASC
8178 EC1380     1680     CPX GUARDABANCO
817B F012       1690     BEQ NOFINCALCULO
817D 18         1700     CLC
817E A5D4       1710     LDA FRO
8180 6D0A80     1720     ADC CANTR
8183 85D4       1730     STA FRO
8185 A5D5       1740     LDA FRO+1
8187 6D0B80     1750     ADC CANTR+1
818A 85D5       1760     STA FRO+1
818C CA         1770     DEX
818D 10E9       1780     BPL CALCULOASC
818F            1790 NOFINCALCULO
818F A001       1800     LDY #$01
8191 A5D4       1810     LDA FRO
8193 297F       1820     AND #$7F
8195 F001       1830     BEQ FINCALCULO
8197 C8         1840     INY
8198            1850 FINCALCULO
8198 A206       1860     LDX #$06
819A            1870 LOOPFINCALCULO
819A 46D5       1880     LSR FRO+1
819C 66D4       1890     ROR FRO
819E CA         1900     DEX
819F 10F9       1910     BPL LOOPFINCALCULO
81A1 18         1920     CLC
81A2 98         1930     TYA
81A3 65D4       1940     ADC FRO
81A5 85D4       1950     STA FRO
81A7 A5D5       1960     LDA FRO+1
81A9 6900       1970     ADC #$00
81AB 85D5       1980     STA FRO+1
81AD 20AAD9     1990     JSR $D9AA
81B0 20E6D8     2000     JSR $D8E6
81B3 A000       2010     LDY #$00
81B5            2020 LOOPPOSITIVO
81B5 B1F3       2030     LDA ($F3),Y
81B7 3003       2040     BMI ESNEGATIVO
81B9 C8         2050     INY
81BA 10F9       2060     BPL LOOPPOSITIVO
81BC            2070 ESNEGATIVO
81BC 38         2080     SEC
81BD E920       2090     SBC #32
81BF 8D3680     2100     STA PABONITO+2
81C2 AE1080     2110     LDX FEOR
81C5 F002       2120     BEQ NOEORFF1
81C7 49FF       2130     EOR #$FF
81C9            2140 NOEORFF1
81C9 8D3332     2150     STA TENMEBLK+2
81CC 88         2160     DEY
81CD 302B       2170     BMI NOQUEDANMAS
81CF B1F3       2180     LDA ($F3),Y
81D1 0980       2190     ORA #$80
81D3 38         2200     SEC
81D4 E920       2210     SBC #32
81D6 8D3580     2220     STA PABONITO+1
81D9 AE1080     2230     LDX FEOR
81DC F002       2240     BEQ NOEORFF2
81DE 49FF       2250     EOR #$FF
81E0            2260 NOEORFF2
81E0 8D3232     2270     STA TENMEBLK+1
81E3 88         2280     DEY
81E4 3014       2290     BMI NOQUEDANMAS
81E6 B1F3       2300     LDA ($F3),Y
81E8 4980       2310     EOR #$80
81EA 38         2320     SEC
81EB E920       2330     SBC #32
81ED 8D3480     2340     STA PABONITO
81F0 AE1080     2350     LDX FEOR
81F3 F002       2360     BEQ NOEORFF3
81F5 49FF       2370     EOR #$FF
81F7            2380 NOEORFF3
81F7 8D3132     2390     STA TENMEBLK
81FA            2400 NOQUEDANMAS
81FA 4CD280     2410     JMP SUBCLOSE
81FD            2420 SUBDIRECTORIO
81FD A97D       2430     LDA #'}
81FF 20B0F2     2440     JSR PRINTBYTE
                2450      OPEN  1,6,0,"D:*.*"
    =0000      M         .IF %0<>4
               M           .ERROR "OPEN: wrong number of arguments"
               M           .ELSE
    =0001      M           .IF %4<256
               M              XIO  COPN,%1,%2,%3,%$4
    =0000      M             .IF %0<2 .OR %0>5
               M               .ERROR "XIO: wrong number of arguments"
               M               .ELSE
               M                @CH  %2
    =0000      M               .IF %1>7
               M                 LDA %1
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 TAX
               M                 .ELSE
8202 A210      M                 LDX #%1*16
               M                 .ENDIF
               M               .ENDM
               M                @CV  %1
    =0001      M               .IF %1<256
8204 A903      M                 LDA #%1
               M                 .ELSE
               M                 LDA %1
               M                 .ENDIF
               M               .ENDM
8206 9D4203    M               STA ICCOM,X ; COMMAND
    =0001      M               .IF %0>=4
               M                  @CV  %3
    =0001      M                 .IF %1<256
8209 A906      M                   LDA #%1
               M                   .ELSE
               M                   LDA %1
               M                   .ENDIF
               M                 .ENDM
820B 9D4A03    M                 STA ICAUX1,X
               M                  @CV  %4
    =0001      M                 .IF %1<256
820E A900      M                   LDA #%1
               M                   .ELSE
               M                   LDA %1
               M                   .ENDIF
               M                 .ENDM
8210 9D4B03    M                 STA ICAUX2,X
               M                 .ELSE
               M                 LDA #0
               M                 STA ICAUX1,X
               M                 STA ICAUX2,X
               M                 .ENDIF
    =0000      M               .IF %0=2.OR %0=4
               M                  @FL  "S:"
               M                 .ELSE
    =0005      M     @@IO        .=  %0
               M                  @FL  %$(@@IO)
    =0001      M                 .IF %1<256
8213 4C1C82    M                   JMP *+%1+4
8216 443A2A2E  M     @F            .BYTE %$1,0
821A 2A00
821C A916      M                   LDA # <@F
821E 9D4403    M                   STA ICBADR,X
8221 A982      M                   LDA # >@F
8223 9D4503    M                   STA ICBADR+1,X
               M                   .ELSE
               M                   LDA # <%1
               M                   STA ICBADR,X
               M                   LDA # >%1
               M                   STA ICBADR+1,X
               M                   .ENDIF
               M                 .ENDM
               M                 .ENDIF
8226 2056E4    M               JSR CIO
               M               .ENDIF
               M             .ENDM
               M             .ELSE
               M              XIO  COPN,%1,%2,%3,%4
               M             .ENDIF
               M           .ENDIF
               M         .ENDM
8229            2460 DIRECTORIO
                2470      INPUT  1,NOMBRE
    =0000      M         .IF %0<2 .OR %0>3
               M           .ERROR "INPUT: wrong number of parameters"
               M           .ELSE
    =0001      M           .IF %0=2
               M              @GP  %1,%2,255,CGTXTR
               M              @CH  %1
    =0000      M             .IF %1>7
               M               LDA %1
               M               ASL A
               M               ASL A
               M               ASL A
               M               ASL A
               M               TAX
               M               .ELSE
8229 A210      M               LDX #%1*16
               M               .ENDIF
               M             .ENDM
822B A905      M             LDA #%4
822D 9D4203    M             STA ICCOM,X
8230 A920      M             LDA # <%2
8232 9D4403    M             STA ICBADR,X
8235 A980      M             LDA # >%2
8237 9D4503    M             STA ICBADR+1,X
823A A9FF      M             LDA # <%3
823C 9D4803    M             STA ICBLEN,X
823F A900      M             LDA # >%3
8241 9D4903    M             STA ICBLEN+1,X
8244 2056E4    M             JSR CIO
               M             .ENDM
               M             .ELSE
               M              @GP  %1,%2,%3,CGTXTR
               M             .ENDIF
               M           .ENDIF
               M         .ENDM
8247 3021       2480     BMI FINDIRECTORIO
                2490      PRINT  0,NOMBRE
    =0000      M         .IF %0<1 .OR %0>3
               M           .ERROR "PRINT: wrong number of parameters"
               M           .ELSE
    =0001      M           .IF %0>1
    =0000      M             .IF %2<128
               M               JMP *+4+%2
               M     @IO       .BYTE %$2,$9B
               M                @GP  %1,@IO,%2+1,CPTXTR
               M               .ELSE
    =0001      M               .IF %0=2
               M                  @GP  %1,%2,255,CPTXTR
               M                  @CH  %1
    =0000      M                 .IF %1>7
               M                   LDA %1
               M                   ASL A
               M                   ASL A
               M                   ASL A
               M                   ASL A
               M                   TAX
               M                   .ELSE
8249 A200      M                   LDX #%1*16
               M                   .ENDIF
               M                 .ENDM
824B A909      M                 LDA #%4
824D 9D4203    M                 STA ICCOM,X
8250 A920      M                 LDA # <%2
8252 9D4403    M                 STA ICBADR,X
8255 A980      M                 LDA # >%2
8257 9D4503    M                 STA ICBADR+1,X
825A A9FF      M                 LDA # <%3
825C 9D4803    M                 STA ICBLEN,X
825F A900      M                 LDA # >%3
8261 9D4903    M                 STA ICBLEN+1,X
8264 2056E4    M                 JSR CIO
               M                 .ENDM
               M                 .ELSE
               M                  @GP  %1,%2,%3,CPTXTR
               M                 .ENDIF
               M               .ENDIF
               M             .ELSE
               M             JMP *+4
               M     @IO     .BYTE $9B
               M              @GP  %1,@IO,1,CPTXTR
               M             .ENDIF
               M           .ENDIF
               M         .ENDM
8267 4C2982     2500     JMP DIRECTORIO
826A            2510 FINDIRECTORIO
826A 20D280     2520     JSR SUBCLOSE
826D A99B       2530     LDA #$9B
826F 20B0F2     2540     JSR PRINTBYTE
8272 A99B       2550     LDA #$9B
8274 20B0F2     2560     JSR PRINTBYTE
                2570      PRINT  0,"  ELIJA FILE A GRABAR!"
    =0000      M         .IF %0<1 .OR %0>3
               M           .ERROR "PRINT: wrong number of parameters"
               M           .ELSE
    =0001      M           .IF %0>1
    =0001      M             .IF %2<128
8277 4C9182    M               JMP *+4+%2
827A 2020454C  M     @IO       .BYTE %$2,$9B
827E 494A4120
8282 46494C45
8286 20412047
828A 52414241
828E 52219B
               M                @GP  %1,@IO,%2+1,CPTXTR
               M                @CH  %1
    =0000      M               .IF %1>7
               M                 LDA %1
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 TAX
               M                 .ELSE
8291 A200      M                 LDX #%1*16
               M                 .ENDIF
               M               .ENDM
8293 A909      M               LDA #%4
8295 9D4203    M               STA ICCOM,X
8298 A97A      M               LDA # <%2
829A 9D4403    M               STA ICBADR,X
829D A982      M               LDA # >%2
829F 9D4503    M               STA ICBADR+1,X
82A2 A917      M               LDA # <%3
82A4 9D4803    M               STA ICBLEN,X
82A7 A900      M               LDA # >%3
82A9 9D4903    M               STA ICBLEN+1,X
82AC 2056E4    M               JSR CIO
               M               .ENDM
               M               .ELSE
               M               .IF %0=2
               M                  @GP  %1,%2,255,CPTXTR
               M                 .ELSE
               M                  @GP  %1,%2,%3,CPTXTR
               M                 .ENDIF
               M               .ENDIF
               M             .ELSE
               M             JMP *+4
               M     @IO     .BYTE $9B
               M              @GP  %1,@IO,1,CPTXTR
               M             .ENDIF
               M           .ENDIF
               M         .ENDM
82AF A9FF       2580     LDA #$FF
82B1 20BA80     2590     JSR BANQUEO
82B4 A213       2600     LDX #19
82B6 A900       2610     LDA #$00
82B8            2620 SINNOMBRE
82B8 9D2080     2630     STA NOMBRE,X
82BB CA         2640     DEX
82BC 10FA       2650     BPL SINNOMBRE
82BE            2660 TOMEFILE
82BE A558       2670     LDA $58
82C0 8500       2680     STA $00
82C2 A559       2690     LDA $59
82C4 8501       2700     STA $01
82C6            2710 INVIERTA
82C6 20E283     2720     JSR INVERSO
82C9            2730 QUEAPRETO?
82C9 A9FF       2740     LDA #$FF
82CB 8DFC02     2750     STA 764
82CE            2760 WTECLA
82CE ADFC02     2770     LDA 764
82D1 C9FF       2780     CMP #$FF
82D3 F0F9       2790     BEQ WTECLA
82D5 C91C       2800     CMP #28
82D7 D001       2810     BNE NOOTRO
82D9 60         2820     RTS
82DA            2830 NOOTRO
82DA C93E       2840     CMP #62
82DC D040       2850     BNE NOCSUB
82DE A200       2860     LDX #$00
82E0 A002       2870     LDY #$02
82E2 B909BB     2880     LDA LINE0,Y
82E5 C9A3       2890     CMP #'C-32
82E7 F01B       2900     BEQ PONSINSUB
82E9            2910 PONCONSUB
82E9 BD31BB     2920     LDA CON,X
82EC 9909BB     2930     STA LINE0,Y
82EF BD1480     2940     LDA SUB,X
82F2 2C1080     2950     BIT FEOR
82F5 F002       2960     BEQ NOEOR29A
82F7 4929       2970     EOR #$29
82F9            2980 NOEOR29A
82F9 9DD944     2990     STA CONSUBRUTINA,X
82FC C8         3000     INY
82FD E8         3010     INX
82FE E003       3020     CPX #$03
8300 D0E7       3030     BNE PONCONSUB
8302 F0C5       3040     BEQ QUEAPRETO?
8304            3050 PONSINSUB
8304 BD34BB     3060     LDA SIN,X
8307 9909BB     3070     STA LINE0,Y
830A A9EA       3080     LDA #$EA
830C 2C1080     3090     BIT FEOR
830F F002       3100     BEQ NOEOR29B
8311 4929       3110     EOR #$29
8313            3120 NOEOR29B
8313 9DD944     3130     STA CONSUBRUTINA,X
8316 C8         3140     INY
8317 E8         3150     INX
8318 E003       3160     CPX #$03
831A D0E8       3170     BNE PONSINSUB
831C F0AB       3180     BEQ QUEAPRETO?
831E            3190 NOCSUB
831E C928       3200     CMP #40
8320 D043       3210     BNE NOCRES
8322 A200       3220     LDX #$00
                3230 ;   LDY #28
8324 A019       3231     LDY #25
8326 B909BB     3240     LDA LINE0,Y
8329 C9A3       3250     CMP #'C-32
832B F01C       3260     BEQ PONSINRES
832D            3270 PONCONRES
832D BD31BB     3280     LDA CON,X
8330 9909BB     3290     STA LINE0,Y
8333 BD1A80     3300     LDA CONRES,X
8336 2C1080     3310     BIT FEOR
8339 F002       3320     BEQ NOEOR29C
833B 4929       3330     EOR #$29
833D            3340 NOEOR29C
833D 9D8B45     3350     STA SINRESET,X
8340 C8         3360     INY
8341 E8         3370     INX
8342 E003       3380     CPX #$03
8344 D0E7       3390     BNE PONCONRES
8346 4CC982     3400     JMP QUEAPRETO?
8349            3410 PONSINRES
8349 BD34BB     3420     LDA SIN,X
834C 9909BB     3430     STA LINE0,Y
834F BD1780     3440     LDA SINRES,X
8352 2C1080     3450     BIT FEOR
8355 F002       3460     BEQ NOEOR29D
8357 4929       3470     EOR #$29
8359            3480 NOEOR29D
8359 9D8B45     3490     STA SINRESET,X
835C C8         3500     INY
835D E8         3510     INX
835E E003       3520     CPX #$03
8360 D0E7       3530     BNE PONSINRES
8362 4CC982     3540     JMP QUEAPRETO?
8365            3550 NOCRES
8365 C90F       3560     CMP #15
8367 D01C       3570     BNE NOUPALE
8369 20E283     3580     JSR INVERSO
836C 18         3590     CLC
836D A500       3600     LDA $00
836F 6928       3610     ADC #40
8371 8500       3620     STA $00
8373 A501       3630     LDA $01
8375 6900       3640     ADC #$00
8377 8501       3650     STA $01
8379 A003       3660     LDY #$03
837B B100       3670     LDA ($00),Y
837D F003       3680     BEQ NOTOMEFIL
837F 4CBE82     3690     JMP TOMEFILE
8382            3700 NOTOMEFIL
8382 4CC682     3710     JMP INVIERTA
8385            3720 NOUPALE
8385 C90E       3730     CMP #14
8387 D022       3740     BNE NOBAJALE
8389 20E283     3750     JSR INVERSO
838C A500       3760     LDA $00
838E C558       3770     CMP $58
8390 D009       3780     BNE BAJE
8392 A501       3790     LDA $01
8394 C559       3800     CMP $59
8396 D003       3810     BNE BAJE
8398 4CBE82     3820     JMP TOMEFILE
839B            3830 BAJE
839B 38         3840     SEC
839C A500       3850     LDA $00
839E E928       3860     SBC #40
83A0 8500       3870     STA $00
83A2 A501       3880     LDA $01
83A4 E900       3890     SBC #$00
83A6 8501       3900     STA $01
83A8 4CC682     3910     JMP INVIERTA
83AB            3920 NOBAJALE
83AB C90C       3930     CMP #12
83AD F003       3940     BEQ ELCOK
83AF 4CC982     3950     JMP QUEAPRETO?
83B2            3960 ELCOK
83B2 20E283     3970     JSR INVERSO
83B5 A004       3980     LDY #$04
83B7 A200       3990     LDX #$00
83B9            4000 ESTAFILE
83B9 B100       4010     LDA ($00),Y
83BB F00C       4020     BEQ PUNTO
83BD 18         4030     CLC
83BE 6920       4040     ADC #$20
83C0 9D2080     4050     STA NOMBRE,X
83C3 E8         4060     INX
83C4 C8         4070     INY
83C5 C00C       4080     CPY #$0C
83C7 D0F0       4090     BNE ESTAFILE
83C9            4100 PUNTO
83C9 A00C       4110     LDY #$0C
83CB A92E       4120     LDA #'.
83CD 9D2080     4130     STA NOMBRE,X
83D0 E8         4140     INX
83D1            4150 LOPUNTO
83D1 B100       4160     LDA ($00),Y
83D3 F00C       4170     BEQ FINPUNTO
83D5 18         4180     CLC
83D6 6920       4190     ADC #$20
83D8 9D2080     4200     STA NOMBRE,X
83DB E8         4210     INX
83DC C8         4220     INY
83DD C00F       4230     CPY #$0F
83DF D0F0       4240     BNE LOPUNTO
83E1            4250 FINPUNTO
83E1 60         4260     RTS
83E2            4270 INVERSO
83E2 A00F       4280     LDY #$0F
83E4            4290 LOINVIERTO
83E4 B100       4300     LDA ($00),Y
83E6 4980       4310     EOR #$80
83E8 9100       4320     STA ($00),Y
83EA 88         4330     DEY
83EB C003       4340     CPY #$03
83ED D0F5       4350     BNE LOINVIERTO
83EF A002       4360     LDY #$02
83F1 A990       4370     LDA #'0-32
83F3            4380 BORREC
83F3 991EBB     4390     STA C?,Y
83F6 88         4400     DEY
83F7 10FA       4410     BPL BORREC
83F9 A010       4420     LDY #$10
83FB A200       4430     LDX #$00
83FD            4440 TOMENUM
83FD B100       4450     LDA ($00),Y
83FF 18         4460     CLC
8400 6920       4470     ADC #$20
8402 9D37BB     4480     STA SECTOR,X
8405 C8         4490     INY
8406 E8         4500     INX
8407 E003       4510     CPX #$03
8409 D0F2       4520     BNE TOMENUM
840B A93B       4530     LDA # <FACTOR
840D 85F3       4540     STA $F3
840F A9BB       4550     LDA # >FACTOR
8411 85F4       4560     STA $F4
8413 A900       4570     LDA #$00
8415 85F2       4580     STA $F2
8417 2000D8     4590     JSR $D800
841A 9003       4600     BCC NOC1000
841C 4CAB84     4610     JMP C1000?
841F            4620 NOC1000
841F 20B6DD     4630     JSR $DDB6
8422 A937       4640     LDA # <SECTOR
8424 85F3       4650     STA $F3
8426 A9BB       4660     LDA # >SECTOR
8428 85F4       4670     STA $F4
842A A900       4680     LDA #$00
842C 85F2       4690     STA $F2
842E 2000D8     4700     JSR $D800
8431 B078       4710     BCS C1000?
8433 20DBDA     4720     JSR $DADB
8436 B073       4730     BCS C1000?
8438 20B6DD     4740     JSR $DDB6
843B A957       4750     LDA #87
843D 85D4       4760     STA $D4
843F A900       4770     LDA #$00
8441 85D5       4780     STA $D5
8443 20AAD9     4790     JSR $D9AA
8446 2066DA     4800     JSR $DA66
8449 20B6DD     4810     JSR $DDB6
844C A91E       4820     LDA #30
844E 85D4       4830     STA $D4
8450 A900       4840     LDA #$00
8452 85D5       4850     STA $D5
8454 20AAD9     4860     JSR $D9AA
8457 A005       4870     LDY #$05
8459            4880 FR1FR0
8459 B9D400     4890     LDA $D4,Y
845C 48         4900     PHA
845D B9E000     4910     LDA $E0,Y
8460 99D400     4920     STA $D4,Y
8463 68         4930     PLA
8464 99E000     4940     STA $E0,Y
8467 88         4950     DEY
8468 10EF       4960     BPL FR1FR0
846A 2028DB     4970     JSR $DB28
846D B03C       4980     BCS C1000?
846F 20D2D9     4990     JSR $D9D2
8472 B037       5000     BCS C1000?
8474 E6D4       5010     INC $D4
8476 D002       5020     BNE NOINCD5
8478 E6D5       5030     INC $D5
847A            5040 NOINCD5
847A 20AAD9     5050     JSR $D9AA
847D 20E6D8     5060     JSR $D8E6
8480 A000       5070     LDY #$00
8482            5080 ESASC?
8482 B1F3       5090     LDA ($F3),Y
8484 3003       5100     BMI FINASC
8486 C8         5110     INY
8487 D0F9       5120     BNE ESASC?
8489            5130 FINASC
8489 B1F3       5140     LDA ($F3),Y
848B 38         5150     SEC
848C E920       5160     SBC #32
848E 8D20BB     5170     STA C?+2
8491 88         5180     DEY
8492 3017       5190     BMI C1000?
8494 B1F3       5200     LDA ($F3),Y
8496 38         5210     SEC
8497 E920       5220     SBC #32
8499 0980       5230     ORA #$80
849B 8D1FBB     5240     STA C?+1
849E 88         5250     DEY
849F 300A       5260     BMI C1000?
84A1 B1F3       5270     LDA ($F3),Y
84A3 38         5280     SEC
84A4 E920       5290     SBC #32
84A6 0980       5300     ORA #$80
84A8 8D1EBB     5310     STA C?
84AB            5320 C1000?
84AB 60         5321     RTS
84AC            5322 NO.IRG
84AC A204       5323     LDX #$04
84AE A9EA       5324     LDA #$EA    ;NOP
84B0            5325 NO.IRG.LOOP
84B0 9DC6EB     5326     STA $EBC6,X
84B3 CA         5327     DEX
84B4 10FA       5328     BPL NO.IRG.LOOP
84B6 60         5329     RTS
84B7            5330 SI.IRG
84B7 A204       5331     LDX #$04
84B9            5332 SI.IRG.LOOP
84B9 BDC384     5333     LDA SI.IRG.TABLA,X
84BC 9DC6EB     5334     STA $EBC6,X
84BF CA         5335     DEX
84C0 10F7       5336     BPL SI.IRG.LOOP
84C2 60         5337     RTS
84C3            5338 SI.IRG.TABLA
84C3 AD1703D0   5339     .BYTE $AD,$17,$03,$D0,$FB
84C7 FB
84C8            5340 IRG.100
84C8 A906       5341     LDA #$06
84CA 8D11EE     5342     STA $EE11
84CD 8D15EE     5343     STA $EE15
84D0 A905       5344     LDA #$05
84D2 8D12EE     5345     STA $EE12
84D5 8D16EE     5346     STA $EE16
84D8 60         5347     RTS
84D9            5349 INICIOPROGRAMA
84D9 A900       5350     LDA #$00
84DB 8D1080     5360     STA FEOR
84DE A9FE       5370     LDA #$FE
84E0 8D01D3     5380     STA $D301
84E3 8D4402     5390     STA $0244
84E6 A970       5400     LDA #112
84E8 8510       5410     STA 16
84EA 8D0ED2     5420     STA 53774
84ED A903       5421     LDA #$03
84EF 8D8DFE     5422     STA $FE8D
84F2 A902       5423     LDA #$02
84F4 8D8EFE     5424     STA $FE8E
84F7 A90C       5425     LDA #$0C
84F9 8D8FFE     5426     STA $FE8F
84FC A98A       5427     LDA #$8A
84FE 8D90FE     5428     STA $FE90
                5429 ; QUEDAMOS CON IRGDE 14 SEGUNDOS
                5430 ;   LDA #$EA
                5440 ;   STA 64881
                5450 ;   STA 64882
8501 20C884     5451     JSR IRG.100
                5457 ;
                5458 ; IRG CORTO DE 100MILISEGUNDOS
                5459 ;
8504 A960       5460     LDA #$60
8506 8DFCFD     5470     STA 65020   ; NO BEEP BEEP!
8509 A934       5471     LDA #$34
850B 8DD7FD     5472     STA $FDD7   ; NO APAQUE MOTOR!
850E A900       5480     LDA #$00
8510 8DC602     5490     STA 710
8513 A901       5500     LDA #1
8515 8DF002     5510     STA 752
8518 200006     5511     JSR DETECTA.PAL ;A DETECTAR PAL!
851B A203       5512     LDX #$03
851D            5513 INICIOPROGRAMA.LOOP
851D BD0080     5514     LDA MENSAJE.NTSC,X
8520 A462       5515     LDY PALNTS
8522 F003       5516     BEQ INICIOPROGRAMA.LOOP2
8524 BD0480     5517     LDA MENSAJE.PAL,X
8527            5518 INICIOPROGRAMA.LOOP2
8527 9D2DBB     5519     STA MENSAJE.TV,X
852A CA         5520     DEX
852B 10F0       5521     BPL INICIOPROGRAMA.LOOP
                5529 ;   LDX #4
                5530 ;   LDA #$EA
                5540 ;LOOPIRG1
                5550 ;   STA $EBC6,X
                5560 ;   DEX
                5570 ;   BPL LOOPIRG1
852D 20AC84     5575     JSR NO.IRG
8530 A9B3       5580     LDA #TURBO
8532 85CF       5590     STA $CF
8534            5600 CAMBIADISCO
                5610      PRINT  0,"}  INGRESE DISCO CON FILE A GRABAR"
    =0000      M         .IF %0<1 .OR %0>3
               M           .ERROR "PRINT: wrong number of parameters"
               M           .ELSE
    =0001      M           .IF %0>1
    =0001      M             .IF %2<128
8534 4C5A85    M               JMP *+4+%2
8537 7D202049  M     @IO       .BYTE %$2,$9B
853B 4E475245
853F 53452044
8543 4953434F
8547 20434F4E
854B 2046494C
854F 45204120
8553 47524142
8557 41529B
               M                @GP  %1,@IO,%2+1,CPTXTR
               M                @CH  %1
    =0000      M               .IF %1>7
               M                 LDA %1
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 TAX
               M                 .ELSE
855A A200      M                 LDX #%1*16
               M                 .ENDIF
               M               .ENDM
855C A909      M               LDA #%4
855E 9D4203    M               STA ICCOM,X
8561 A937      M               LDA # <%2
8563 9D4403    M               STA ICBADR,X
8566 A985      M               LDA # >%2
8568 9D4503    M               STA ICBADR+1,X
856B A923      M               LDA # <%3
856D 9D4803    M               STA ICBLEN,X
8570 A900      M               LDA # >%3
8572 9D4903    M               STA ICBLEN+1,X
8575 2056E4    M               JSR CIO
               M               .ENDM
               M               .ELSE
               M               .IF %0=2
               M                  @GP  %1,%2,255,CPTXTR
               M                 .ELSE
               M                  @GP  %1,%2,%3,CPTXTR
               M                 .ENDIF
               M               .ENDIF
               M             .ELSE
               M             JMP *+4
               M     @IO     .BYTE $9B
               M              @GP  %1,@IO,1,CPTXTR
               M             .ENDIF
               M           .ENDIF
               M         .ENDM
8578 A9FF       5620     LDA #$FF
857A 8DFC02     5630     STA 764
857D 20F8F2     5640     JSR GETBYTE
8580 20FD81     5650     JSR SUBDIRECTORIO
8583 202881     5660     JSR SUBREAD
8586            5670 OTRACOPIA
                5680      PRINT  0,"} RETURN PARA COMENZAR GRABACION"
    =0000      M         .IF %0<1 .OR %0>3
               M           .ERROR "PRINT: wrong number of parameters"
               M           .ELSE
    =0001      M           .IF %0>1
    =0001      M             .IF %2<128
8586 4CAC85    M               JMP *+4+%2
8589 7D202020  M     @IO       .BYTE %$2,$9B
858D 52455455
8591 524E2050
8595 41524120
8599 434F4D45
859D 4E5A4152
85A1 20475241
85A5 42414349
85A9 4F4E9B
               M                @GP  %1,@IO,%2+1,CPTXTR
               M                @CH  %1
    =0000      M               .IF %1>7
               M                 LDA %1
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 ASL A
               M                 TAX
               M                 .ELSE
85AC A200      M                 LDX #%1*16
               M                 .ENDIF
               M               .ENDM
85AE A909      M               LDA #%4
85B0 9D4203    M               STA ICCOM,X
85B3 A989      M               LDA # <%2
85B5 9D4403    M               STA ICBADR,X
85B8 A985      M               LDA # >%2
85BA 9D4503    M               STA ICBADR+1,X
85BD A923      M               LDA # <%3
85BF 9D4803    M               STA ICBLEN,X
85C2 A900      M               LDA # >%3
85C4 9D4903    M               STA ICBLEN+1,X
85C7 2056E4    M               JSR CIO
               M               .ENDM
               M               .ELSE
               M               .IF %0=2
               M                  @GP  %1,%2,255,CPTXTR
               M                 .ELSE
               M                  @GP  %1,%2,%3,CPTXTR
               M                 .ENDIF
               M               .ENDIF
               M             .ELSE
               M             JMP *+4
               M     @IO     .BYTE $9B
               M              @GP  %1,@IO,1,CPTXTR
               M             .ENDIF
               M           .ENDIF
               M         .ENDM
85CA A082       5690     LDY #130
85CC A200       5700     LDX #0
85CE            5710 LOOPBONITO
85CE BD3480     5720     LDA PABONITO,X
85D1 9158       5730     STA ($58),Y
85D3 C8         5740     INY
85D4 E8         5750     INX
85D5 E015       5760     CPX #21
85D7 D0F5       5770     BNE LOOPBONITO
85D9 A0D8       5780     LDY #216
85DB A200       5790     LDX #$00
85DD            5800 BELLO
85DD BD2080     5810     LDA NOMBRE,X
85E0 38         5820     SEC
85E1 E920       5830     SBC #$20
85E3 3006       5840     BMI FINBELISIMO
85E5 9158       5850     STA ($58),Y
85E7 C8         5860     INY
85E8 E8         5870     INX
85E9 D0F2       5880     BNE BELLO
85EB            5890 FINBELISIMO
85EB A9FF       5900     LDA #$FF
85ED 8DFC02     5910     STA 764
85F0 20F8F2     5920     JSR GETBYTE
85F3 C91B       5930     CMP #'?
85F5 D003       5940     BNE NOCAMBIADISCO
85F7 4C3485     5950     JMP CAMBIADISCO
85FA            5960 NOCAMBIADISCO
85FA A97D       5970     LDA #'}
85FC 20B0F2     5980     JSR $F2B0
85FF A0D7       5990     LDY #215
8601 A200       6000     LDX #$00
8603            6010 NUMEROSCREEN
8603 BD3480     6020     LDA PABONITO,X
8606 9158       6030     STA ($58),Y
8608 C8         6040     INY
8609 E8         6050     INX
860A E003       6060     CPX #$03
860C D0F5       6070     BNE NUMEROSCREEN
860E C8         6080     INY
860F            6090 NOMBRESCREEN
860F BD1D80     6100     LDA STRING,X
8612 38         6110     SEC
8613 E920       6120     SBC #$20
8615 3006       6130     BMI ENDNAME
8617 9158       6140     STA ($58),Y
8619 E8         6150     INX
861A C8         6160     INY
861B D0F2       6170     BNE NOMBRESCREEN
861D            6180 ENDNAME
861D A208       6190     LDX #$08
861F            6200 NUEVEBLKS
861F A0D9       6210     LDY #217
8621            6220 NUEVEBLKS1
8621 B158       6230     LDA ($58),Y
8623 18         6240     CLC
8624 6901       6250     ADC #$01
8626 C99A       6260     CMP #'9-31
8628 F007       6270     BEQ NUEVE9
862A 9158       6280     STA ($58),Y
862C CA         6290     DEX
862D 10F0       6300     BPL NUEVEBLKS
862F 3009       6310     BMI FINNUEVE
8631            6320 NUEVE9
8631 A990       6330     LDA #'0-32
8633 9158       6340     STA ($58),Y
8635 88         6350     DEY
8636 C0D6       6360     CPY #214
8638 D0E7       6370     BNE NUEVEBLKS1
863A            6380 FINNUEVE
863A A9FF       6390     LDA #$FF
863C 20BA80     6400     JSR BANQUEO
863F A9D0       6401     LDA #$D0
8641 8D71FD     6402     STA $FD71
8644 A9F7       6403     LDA #$F7
8646 8D72FD     6404     STA $FD72   ; HABILITA LEAD
8649 2084A0     6410     JSR GRABABLKUNO
864C A9EA       6411     LDA #$EA
864E 8D71FD     6412     STA $FD71
8651 8D72FD     6413     STA $FD72   ; DESHABILITA LEAD
8654 A92E       6414     LDA #$00-210
8656 A662       6415     LDX PALNTS
8658 F002       6416     BEQ BLKUNO.NTSC
865A A951       6417     LDA #$00-175
865C            6418 BLKUNO.NTSC
865C 8514       6419     STA 20
865E            6420 BLKUNO.LOOP
865E A514       6421     LDA 20
8660 D0FC       6422     BNE BLKUNO.LOOP
8662 A900       6429     LDA #$00
8664 8514       6430     STA 20
8666 8D8004     6440     STA $0480
8669 8D8104     6450     STA $0481
866C 8D1180     6460     STA FEOF
866F A9FC       6470     LDA # <FIN-GAMEA
8671 8D0C80     6480     STA CANTW
8674 A905       6490     LDA # >FIN-GAMEA
8676 8D0D80     6500     STA CANTW+1
8679 20D386     6510     JSR WRITETOCASSETTE
                6520 ;   LDA #$00-8
867C A964       6521     LDA #$00-156
867E A662       6522     LDX PALNTS
8680 F002       6523     BEQ BLK2.NTSC
8682 A97E       6524     LDA #$00-130
8684            6525 BLK2.NTSC
8684 8514       6530     STA 20
8686            6540 W1SEG
8686 A514       6550     LDA 20
8688 D0FC       6560     BNE W1SEG
868A A910       6570     LDA #$10
868C 8514       6580     STA 20
868E A901       6590     LDA #1
8690 8D1180     6600     STA FEOF
8693 AD0A80     6610     LDA CANTR
8696 8D0C80     6620     STA CANTW
8699 AD0B80     6630     LDA CANTR+1
869C 8D0D80     6640     STA CANTW+1
869F A904       6650     LDA #$04
86A1 8D1280     6660     STA BANCO
86A4 20D386     6670     JSR WRITETOCASSETTE
                6680 ;   LDA #$00-8
86A7 A9CC       6681     LDA #$00-52
86A9 A462       6682     LDY PALNTS
86AB F002       6683     BEQ LOPLEAD1.NTSC
86AD A9D5       6684     LDA #$00-43
86AF            6685 LOPLEAD1.NTSC
86AF 8514       6690     STA 20
86B1            6700 LOPLEAD1
86B1 A514       6710     LDA 20
86B3 D0FC       6720     BNE LOPLEAD1
86B5 A002       6730     LDY #$02
86B7            6740 SAVEC0LENTO
86B7 98         6741     TYA
86B8 48         6742     PHA
86B9 A9C0       6750     LDA #$C0
86BB 204A80     6760     JSR GRABAMULA
86BE 68         6761     PLA
86BF A8         6762     TAY
86C0 88         6770     DEY
86C1 10F4       6780     BPL SAVEC0LENTO
86C3 A90A       6781     LDA #10
86C5 8514       6782     STA 20
86C7            6783 FINAL.LOOP
86C7 A514       6784     LDA 20
86C9 D0FC       6785     BNE FINAL.LOOP
                6786 ; LE DAMOS TIEMPO PARA QUE CIERRE EL ARCHIVO.
                6787 ;
86CB A93C       6788     LDA #$3C
86CD 8D02D3     6789     STA $D302
86D0 4C8685     6790     JMP OTRACOPIA
86D3            6800 WRITETOCASSETTE
86D3 2034FD     6810     JSR $FD34
86D6            6820 LEADERTIME
86D6 A514       6830     LDA 20
86D8 C920       6840     CMP #$20
86DA 90FA       6850     BCC LEADERTIME
86DC AD1180     6860     LDA FEOF
86DF F021       6870     BEQ NOLASTBANCO
86E1            6880 GRABANDOP02
86E1 CE1280     6890     DEC BANCO
86E4 AD1280     6900     LDA BANCO
86E7 48         6910     PHA
86E8 20BA80     6920     JSR BANQUEO
86EB 68         6930     PLA
86EC CD1380     6940     CMP GUARDABANCO
86EF D011       6950     BNE NOLASTBANCO
86F1 AD0E80     6960     LDA LASTCANT
86F4 8D0C80     6970     STA CANTW
86F7 AD0F80     6980     LDA LASTCANT+1
86FA 8D0D80     6990     STA CANTW+1
86FD A9FF       7000     LDA #$FF
86FF 8D1180     7010     STA FEOF
8702            7020 NOLASTBANCO
8702 A900       7030     LDA # <$4000
8704 8500       7040     STA $00
8706 A940       7050     LDA # >$4000
8708 8501       7060     STA $01
870A A900       7070     LDA #$00
870C 8502       7080     STA $02
870E 8503       7090     STA $03
8710            7100 WRITECASSETTE
8710 AD1FD0     7110     LDA $D01F
8713 C903       7120     CMP #$03
8715 D003       7130     BNE SIGAGRBANDO
8717 4CD6FD     7140     JMP $FDD6
871A            7150 SIGAGRBANDO
871A 20B784     7151     JSR SI.IRG
871D A000       7160     LDY #$00
871F B100       7170     LDA ($00),Y
8721 20B4FD     7180     JSR $FDB4
8724 D02E       7190     BNE NONUEVOBLK
8726 20AC84     7191     JSR NO.IRG
8729 A087       7200     LDY #135
872B            7210 BUFSCREEN
872B B9FF03     7220     LDA $03FF,Y
872E 9158       7230     STA ($58),Y
8730 88         7240     DEY
8731 D0F8       7250     BNE BUFSCREEN
8733 A0D9       7260     LDY #217
8735 A202       7270     LDX #$02
8737            7280 DECBELLO
8737 B158       7290     LDA ($58),Y
8739 38         7300     SEC
873A E901       7310     SBC #$01
873C C98F       7320     CMP #'0-33
873E F004       7330     BEQ NINEBELLO
8740 9158       7340     STA ($58),Y
8742 D008       7350     BNE FINBELLO
8744            7360 NINEBELLO
8744 A999       7370     LDA #'9-32
8746 9158       7380     STA ($58),Y
8748 88         7390     DEY
8749 CA         7400     DEX
874A 10EB       7410     BPL DECBELLO
874C            7420 FINBELLO
874C EE8004     7430     INC $0480
874F D003       7440     BNE NONUEVOBLK
8751 EE8104     7450     INC $0481
8754            7460 NONUEVOBLK
8754 E600       7470     INC $00
8756 D002       7480     BNE NOINCHIBIS
8758 E601       7490     INC $01
875A            7500 NOINCHIBIS
875A E602       7510     INC $02
875C D002       7520     BNE NOINCHIS
875E E603       7530     INC $03
8760            7540 NOINCHIS
8760 A503       7550     LDA $03
8762 CD0D80     7560     CMP CANTW+1
8765 D0A9       7570     BNE WRITECASSETTE
8767 A502       7580     LDA $02
8769 CD0C80     7590     CMP CANTW
876C D0A2       7600     BNE WRITECASSETTE
876E AD1180     7610     LDA FEOF
8771 F005       7620     BEQ FINP01
8773 3003       7630     BMI FINP01
8775 4CE186     7640     JMP GRABANDOP02
8778            7650 FINP01
8778 A63D       7660     LDX $3D
877A F010       7670     BEQ TERMINOWRITE
877C A07F       7680     LDY #$7F
877E            7690 POKEANDOESPERO
877E 8C0AD4     7700     STY $D40A
8781 88         7710     DEY
8782 D0FA       7720     BNE POKEANDOESPERO
8784 8E7F04     7730     STX $047F
8787 A9FA       7740     LDA #$FA
8789 207CFE     7750     JSR $FE7C
878C            7760 TERMINOWRITE
878C EE8004     7770     INC $0480
878F D003       7780     BNE NOINC481
8791 EE8104     7790     INC $0481
8794            7800 NOINC481
8794 AD1180     7810     LDA FEOF
8797 D003       7820     BNE SIEOF
8799 4CD6FD     7830     JMP $FDD6
879C            7840 SIEOF
879C A27F       7850     LDX #$7F
879E A900       7860     LDA #$00
87A0            7870 FILLBUFFER
87A0 9D0004     7880     STA $0400,X
87A3 8D0AD4     7890     STA $D40A
87A6 CA         7900     DEX
87A7 10F7       7910     BPL FILLBUFFER
87A9 A9FE       7920     LDA #$FE
87AB 207CFE     7930     JSR $FE7C
87AE 4CD6FD     7940     JMP $FDD6
87B1            7950     *=  $02E0
02E0 D984       7960     .WORD INICIOPRO
GRAMA
    =003B       7970 EORLEN = FINFIRST-AEOREAR+1
    =037D       7980 ADR =   $0380-3
    =03FF       7990 RESTABYTE = $03FF
    =9C83       8000 DIF =   $A000-ADR
02E2            8010     *=  ADR+DIF
A000            8020 AGRABAR
A000 5555       8030     .BYTE $55,$55
A002 FA         8040     .BYTE $FA
A003            8050 BLKUNO
A003 00         8060     .BYTE $00
A004 01         8070     .BYTE $01
A005 8003       8080     .WORD *-2-DIF
A007 56E4       8090     .WORD $E456
A009 A23B       8100     LDX #EORLEN
A00B 9A         8110     TXS
A00C            8120 EORLOOP
A00C 38         8130     SEC
A00D BD9903     8140     LDA AEOREAR-DIF,X
A010 A8         8150     TAY
A011 EDFF03     8160     SBC RESTABYTE
A014 8CFF03     8170     STY RESTABYTE
A017 48         8180     PHA
A018 CA         8190     DEX
A019 10F1       8200     BPL EORLOOP
A01B 60         8210     RTS
A01C            8220 AEOREAR
A01C 01         8230     .BYTE $01
A01D 01         8240     .BYTE $01
A01E A201       8250     LDX #$01
A020 8E4402     8260     STX $0244
A023 CA         8270     DEX
A024 8E2F02     8280     STX $022F
A027 8E00D4     8290     STX $D400
A02A 8641       8300     STX $41
A02C            8310 RELOS
A02C A2EC       8320     LDX #$00-20
A02E 8614       8330     STX 20
A030            8340 ESPERASINCRO
A030 AD0FD2     8350     LDA $D20F
A033 2910       8360     AND #$10
A035 D0F5       8370     BNE RELOS
A037 A614       8380     LDX 20
A039 D0F5       8390     BNE ESPERASINCRO
A03B            8400 TERMINA0
A03B AD0FD2     8410     LDA $D20F
A03E 2910       8420     AND #$10
A040 F0F9       8430     BEQ TERMINA0
A042 A20B       8440     LDX #$0B
A044            8450 TRANSFER
A044 BDD503     8460     LDA DATIX1-DIF,X
A047 9D0003     8470     STA $0300,X
A04A CA         8480     DEX
A04B 10F7       8490     BPL TRANSFER
A04D 2059E4     8500     JSR $E459
A050 A2FF       8510     LDX #$FF
A052 9A         8520     TXS
A053 6C0403     8530     JMP ($0304)
A056            8540 FINFIRST
A056 68         8550     PLA
A057 40         8560     RTI
A058            8570 DATIX1
A058 60         8580     .BYTE $60
A059 00         8590     .BYTE $00
A05A 52         8600     .BYTE $52
A05B 40         8610     .BYTE $40
A05C 0020       8620     .WORD BLKFALSO
A05E 23         8630     .BYTE $23
A05F 00         8640     .BYTE $00
A060 4B02       8650     .WORD FINBLKFALSO-BLKFALSO
A062 00         8660     .BYTE $00
A063 80         8670     .BYTE $80
A064            8680     *=  $03EA+DIF
A06D 00         8690     .BYTE $00
A06E            8700     *=  AGRABAR+$84
A084            8710 GRABABLKUNO
A084 AD1080     8720     LDA FEOR
A087 F003       8730     BEQ EORNOLISTO
A089 4C0BA1     8740     JMP EORLISTO
A08C            8750 EORNOLISTO
A08C A934       8760     LDA # <EORBLOCK
A08E 850C       8770     STA DESDE
A090 A920       8780     LDA # >EORBLOCK
A092 850D       8790     STA DESDE+1
A094 A94B       8800     LDA # <FINBLKFALSO
A096 850E       8810     STA HASTA
A098 A922       8820     LDA # >FINBLKFALSO
A09A 850F       8830     STA HASTA+1
A09C A946       8840     LDA #$46
A09E 8D0880     8850     STA EORBYTE
A0A1 209E80     8860     JSR EOREO
A0A4 A92F       8870     LDA # <EORBLOCK1
A0A6 850C       8880     STA DESDE
A0A8 A930       8890     LDA # >EORBLOCK1
A0AA 850D       8900     STA DESDE+1
A0AC A9FA       8910     LDA # <FINBLKDOS
A0AE 850E       8920     STA HASTA
A0B0 A933       8930     LDA # >FINBLKDOS
A0B2 850F       8940     STA HASTA+1
A0B4 A9FF       8950     LDA #$FF
A0B6 8D0880     8960     STA EORBYTE
A0B9 209E80     8970     JSR EOREO
A0BC A922       8980     LDA # <GAME1A
A0BE 850C       8990     STA DESDE
A0C0 A940       9000     LDA # >GAME1A
A0C2 850D       9010     STA DESDE+1
A0C4 A9FC       9020     LDA # <FIN
A0C6 850E       9030     STA HASTA
A0C8 A945       9040     LDA # >FIN
A0CA 850F       9050     STA HASTA+1
A0CC A929       9060     LDA #$29
A0CE 8D0880     9070     STA EORBYTE
A0D1 209E80     9080     JSR EOREO
A0D4 A23B       9090     LDX #EORLEN
A0D6 8E1080     9100     STX FEOR
A0D9            9110 EORLOOP1
A0D9 18         9120     CLC
A0DA BD1CA0     9130     LDA AEOREAR,X
A0DD 6D9CA1     9140     ADC SUMABYTE
A0E0 8D9CA1     9150     STA SUMABYTE
A0E3 9D1CA0     9160     STA AEOREAR,X
A0E6 CA         9170     DEX
A0E7 10F0       9180     BPL EORLOOP1
A0E9 A900       9190     LDA #0
A0EB 8D77A1     9200     STA CHKSUM
A0EE A282       9210     LDX #$82
A0F0 A901       9220     LDA #$01
A0F2 9D00A0     9230     STA AGRABAR,X
A0F5            9240 ADCHKSUM
A0F5 BD00A0     9250     LDA AGRABAR,X
A0F8 18         9260     CLC
A0F9 6D77A1     9270     ADC CHKSUM
A0FC 6900       9280     ADC #0
A0FE 8D77A1     9290     STA CHKSUM
A101 CA         9300     DEX
A102 C9FF       9310     CMP #$FF
A104 D0EF       9320     BNE ADCHKSUM
A106 A283       9330     LDX #$83
A108 9D03A0     9340     STA BLKUNO,X
A10B            9350 EORLISTO
A10B 2034FD     9360     JSR $FD34   ; GRABA LEADER
A10E 18         9370     CLC
A10F A964       9371     LDA #100
A111 A662       9372     LDX PALNTS
A113 F002       9373     BEQ LEADER.NTSC
A115 A953       9374     LDA #83
A117            9375 LEADER.NTSC
A117 6514       9376     ADC 20
                9380 ;   LDA 20
                9390 ;   ADC #100
A119            9400 WLEADERTIME
A119 C514       9410     CMP 20
A11B D0FC       9420     BNE WLEADERTIME
A11D A20B       9430     LDX #$0B
A11F            9440 ?LOOP
A11F BD78A1     9450     LDA DATA1,X
A122 9D0003     9460     STA $0300,X
A125 CA         9470     DEX
A126 10F7       9480     BPL ?LOOP
A128 2059E4     9490     JSR $E459   ; GRABA PRIMER BLOQUE
A12B 18         9500     CLC
A12C A90F       9501     LDA #$0F    ; 0.25 SEC NTSC
A12E A662       9502     LDX PALNTS
A130 F002       9503     BEQ PRIMERBLOQUE.NTSC
A132 A90C       9504     LDA #$0C    ; 0.25 SEC PAL
A134            9505 PRIMERBLOQUE.NTSC
A134 6514       9506     ADC 20
                9510 ;   LDA 20
                9520 ;   ADC #$0F
A136            9530 ESPERIX
A136 C514       9540     CMP 20
A138 D0FC       9550     BNE ESPERIX
A13A 208170     9560     JSR GRABATRAMPA
A13D 18         9570     CLC
A13E A514       9580     LDA 20
A140 690F       9590     ADC #$0F
A142            9600 WFALSO
A142 C514       9610     CMP 20
A144 D0FC       9620     BNE WFALSO
A146 A20B       9630     LDX #$0B
A148            9640 SAVEFALSO
A148 BD90A1     9650     LDA DATAFALSA,X
A14B 9D0003     9660     STA $0300,X
A14E CA         9670     DEX
A14F 10F7       9680     BPL SAVEFALSO
A151 2059E4     9690     JSR $E459
A154 18         9700     CLC
A155 A928       9701     LDA #40
A157 A662       9702     LDX PALNTS
A159 F002       9703     BEQ WFORIRGTIME.NTSC
A15B A921       9704     LDA #33
A15D            9705 WFORIRGTIME.NTSC
A15D 6514       9706     ADC 20
                9710 ;   LDA 20
                9720 ;   ADC #6
A15F            9730 WFORIRGTIME
A15F C514       9740     CMP 20
A161 D0FC       9750     BNE WFORIRGTIME
A163 A20B       9760     LDX #$0B
A165            9770 ?LOOP1
A165 BD84A1     9780     LDA DATA2,X
A168 9D0003     9790     STA $0300,X
A16B CA         9800     DEX
A16C 10F7       9810     BPL ?LOOP1
A16E 2059E4     9820     JSR $E459
                9830 ;   LDA #60
A171 A934       9831     LDA #$34
A173 8D02D3     9840     STA 54018
A176 60         9850     RTS
A177            9860 CHKSUM
A177 00         9870     .BYTE 0
A178            9880 DATA1
A178 60005780   9890     .BYTE $60,0,$57,$80
A17C 00A0       9900     .WORD AGRABAR
A17E 2300       9910     .BYTE $23,0
A180 8300       9920     .WORD $83
A182 0080       9930     .BYTE 0,$80
A184            9940 DATA2
A184 60005780   9950     .BYTE $60,0,$57,$80
A188 0030       9960     .WORD BLKDOS
A18A 2300       9970     .BYTE $23,0
A18C FA03       9980     .WORD FINBLKDOS-BLKDOS
A18E 00         9990     .BYTE 0
A18F 80         010000   .BYTE $80
A190            010010 DATAFALSA
A190 60005780   010020   .BYTE $60,0,$57,$80
A194 0020       010030   .WORD BLKFALSO
A196 2300       010040   .BYTE $23,0
A198 4B02       010050   .WORD FINBLKFALSO-BLKFALSO
A19A 0080       010060   .BYTE 0,$80
A19C            010070 SUMABYTE
A19C FA         010080   .BYTE $FA
A19D            010090   *=  $7000-4
6FFC            010100 TRAMPA
6FFC 5555FC     010110   .BYTE $55,$55,$FC
6FFF 01         010120   .BYTE $01
7000 0070       010130   .WORD $7000
7002 56E4       010140   .WORD $E456
7004 A900       010150   LDA #$00
7006 A002       010160   LDY #$02
7008 9158       010170   STA ($58),Y
700A 8DC602     010180   STA 710
700D 8541       010190   STA $41
700F A210       010200   LDX #$10
7011 A903       010210   LDA #$03
7013 9DEC02     010220   STA $02EC,X
7016 9D4203     010230   STA $0342,X
7019 A904       010240   LDA #$04
701B 9D4A03     010250   STA $034A,X
701E A980       010260   LDA #$80
7020 9D4B03     010270   STA $034B,X
7023 A931       010280   LDA # <$C431
7025 9D4403     010290   STA $0344,X
7028 A9C4       010300   LDA # >$C431
702A 9D4503     010310   STA $0345,X
702D 2056E4     010320   JSR $E456
7030 A900       010330   LDA #$00
7032 9D4403     010340   STA $0344,X
7035 9D4803     010350   STA $0348,X
7038 A907       010360   LDA #$07
703A 9D4503     010370   STA $0345,X
703D A906       010380   LDA #$06
703F 9D4903     010390   STA $0349,X
7042 A907       010400   LDA #$07
7044 9D4203     010410   STA $0342,X
7047 2056E4     010420   JSR $E456
704A 88         010430   DEY
704B            010440 LOOPTRAMPA
704B B90007     010450   LDA $0700,Y
704E 590008     010460   EOR $0800,Y
7051 9D0007     010470   STA $0700,X
7054 88         010480   DEY
7055 D0F4       010490   BNE LOOPTRAMPA
7057 A966       010500   LDA # <DLTRAMPA+2
7059 8D3002     010510   STA 560
705C A970       010520   LDA # >DLTRAMPA+2
705E 8D3102     010530   STA 561
7061 4C0007     010540   JMP $0700
7064            010550 DLTRAMPA
7064 70707046   010560   .BYTE 112,112,112,64+6
7068 6D70       010570   .WORD TEXTOTRAMPA+2
706A 41         010580   .BYTE 65
706B            010590 TEXTOTRAMPA
706B 00000000   010600   .SBYTE "    turbo SOFTWARE     "
706F 74757262
7073 6F00332F
7077 26343721
707B 32250000
707F 000000
7082            010610   *=  $707F
707F            010620 CHEQUEO
707F 00         010630   .BYTE 0
7080            010640 FCHK
7080 00         010650   .BYTE 0
7081            010660 GRABATRAMPA
7081 AD8070     010670   LDA FCHK
7084 D020       010680   BNE CHEQUEOK
7086 EE8070     010690   INC FCHK
7089 A900       010700   LDA #$00
708B 8D7F70     010710   STA CHEQUEO
708E A282       010720   LDX #$82
7090            010730 CHKTRAMPA
7090 BDFC6F     010740   LDA TRAMPA,X
7093 18         010750   CLC
7094 6900       010760   ADC #$00
7096 6D7F70     010770   ADC CHEQUEO
7099 8D7F70     010780   STA CHEQUEO
709C CA         010790   DEX
709D E0FF       010800   CPX #$FF
709F D0EF       010810   BNE CHKTRAMPA
70A1 A283       010820   LDX #$83
70A3 9DFC6F     010830   STA TRAMPA,X
70A6            010840 CHEQUEOK
70A6 A20B       010850   LDX #$0B
70A8            010860 LOOPTRAMPIX
70A8 BDF370     010870   LDA DATATRAMPA,X
70AB 9D0003     010880   STA $0300,X
70AE CA         010890   DEX
70AF 10F7       010900   BPL LOOPTRAMPIX
70B1 2059E4     010910   JSR $E459
70B4 18         010920   CLC
70B5 A90F       010921   LDA #$0F
70B7 A662       010922   LDX PALNTS
70B9 F002       010923   BEQ TRAMPA.NTSC
70BB A90C       010924   LDA #$0C
70BD            010925 TRAMPA.NTSC
70BD 6514       010926   ADC 20
                010930 ; LDA 20
                010940 ; ADC #$0F
70BF            010950 ESPERATRAMPA
70BF C514       010960   CMP 20
70C1 D0FC       010970   BNE ESPERATRAMPA
70C3 A983       010980   LDA #$83
70C5 8D48FE     010990   STA $FE48   ; BLOQUE DE 131 BYTES (ESTANDAR ATARI)
70C8 20EAFD     011000   JSR $FDEA   ; GRABA EOF
70CB A985       011010   LDA #133
70CD 8D48FE     011020   STA $FE48   ; AGREGA 2 BYTES BLOQUE (PARA AGREGAR CONTADOR)
                011030 ; LDA #163
70D0 A98B       011031   LDA #139
70D2 8D0FD2     011040   STA $D20F
70D5 A228       011050   LDX #$28    ; VALOR ORIGINAL: 4
70D7 A462       011051   LDY PALNTS
70D9 F002       011052   BEQ LOOPLINEA.NTSC
70DB A221       011053   LDX #$21
70DD            011054 LOOPLINEA.NTSC
70DD AC0BD4     011060   LDY $D40B
70E0            011070 LOOPLINEA
70E0 CC0BD4     011080   CPY $D40B
70E3 F0FB       011090   BEQ LOOPLINEA
70E5            011100 WLINE
70E5 CC0BD4     011110   CPY $D40B
70E8 D0FB       011120   BNE WLINE
70EA CA         011130   DEX
70EB 10F0       011140   BPL LOOPLINEA.NTSC
                011150 ; LDA #35
70ED A90B       011151   LDA #11
70EF 8D0FD2     011160   STA $D20F
70F2 60         011170   RTS
70F3            011180 DATATRAMPA
70F3 60005780   011190   .BYTE $60,$00,$57,$80
70F7 FC6F       011200   .WORD TRAMPA
70F9 2300       011210   .BYTE $23,$00
70FB 8300       011220   .WORD $83
70FD 0080       011230   .BYTE $00,$80
70FF            011240   *=  $2000
2000            011250 BLKFALSO
2000 5555       011260   .BYTE $55,$55
2002 98         011270   TYA
2003 100B       011280   BPL BLOCKOK
2005 A922       011290   LDA #34
2007 8D2F02     011300   STA 559
200A 20C7ED     011310   JSR $EDC7
200D 4CFCC8     011320   JMP $C8FC
2010            011330 BLOCKOK
2010 AD3420     011340   LDA EORBLOCK
2013 4946       011350   EOR #$46
2015 8D3420     011360   STA EORBLOCK
2018 EE1620     011370   INC BLOCKOK+6
201B EE1120     011380   INC BLOCKOK+1
201E D006       011390   BNE NOINCBLOCK2
2020 EE1720     011400   INC BLOCKOK+7
2023 EE1220     011410   INC BLOCKOK+2
2026            011420 NOINCBLOCK2
2026 AD1220     011430   LDA BLOCKOK+2
2029 C922       011440   CMP # >FINBLKFALSO
202B D0E3       011450   BNE BLOCKOK
202D AD1120     011460   LDA BLOCKOK+1
2030 C94B       011470   CMP # <FINBLKFALSO
2032 D0DC       011480   BNE BLOCKOK
2034            011490 EORBLOCK
2034 A900       011500   LDA #$00
2036 8DC602     011510   STA 710
2039 A9FF       011520   LDA #$FF
203B 8D01D3     011530   STA $D301
203E 20FD21     011540   JSR ROMARAM
2041 A922       011550   LDA #34
2043 8D2F02     011560   STA 559
2046 8D00D4     011570   STA $D400
2049 A9D6       011580   LDA # <DL
204B 8D3002     011590   STA 560
204E A921       011600   LDA # >DL
2050 8D3102     011610   STA 561
2053            011620 LINEAPOSITIVA
2053 AC0BD4     011630   LDY $D40B
2056 30FB       011640   BMI LINEAPOSITIVA
2058 A9FF       011650   LDA #$FF
205A 8550       011660   STA $50
205C A99B       011670   LDA # <MUS
205E 8D2202     011680   STA $0222
2061 A920       011690   LDA # >MUS
2063 8D2302     011700   STA $0223
2066 A20B       011710   LDX #$0B
2068            011720 CARGALASTBLOCK
2068 BDCA21     011730   LDA DATALAST,X
206B 9D0003     011740   STA $0300,X
206E CA         011750   DEX
206F 10F7       011760   BPL CARGALASTBLOCK
2071 A9FD       011770   LDA #$FF-2
2073 8514       011780   STA 20
2075            011790 WVBI
2075 A514       011800   LDA 20
2077 D0FC       011810   BNE WVBI
2079 A013       011820   LDY #19
207B            011830 CHECKTURBO
207B 18         011840   CLC
207C B9E921     011850   LDA DATA,Y
207F 6D8B20     011860   ADC BITLOCO+1
2082 6900       011870   ADC #$00
2084 8D8B20     011880   STA BITLOCO+1
2087 88         011890   DEY
2088 10F1       011900   BPL CHECKTURBO
208A            011910 BITLOCO
208A A900       011920   LDA #$00
208C 38         011930   SEC
208D E99A       011940   SBC #$9A
208F 3007       011950   BMI NODIO
2091 F002       011960   BEQ SIDIO
2093 1003       011970   BPL NODIO
2095            011980 SIDIO
2095 2059E4     011990   JSR $E459
2098            012000 NODIO
2098 6C0403     012010   JMP ($0304)
209B            012020 MUS
209B A982       012030   LDA #$82
209D 8D03D2     012040   STA $D203
20A0 CEEF20     012050   DEC SCUIS
20A3 ADEF20     012060   LDA SCUIS
20A6 D005       012070   BNE NO0SCUIS
20A8 A978       012080   LDA #120
20AA 8DEF20     012090   STA SCUIS
20AD            012100 NO0SCUIS
20AD 8D02D2     012110   STA $D202
20B0 CEEE20     012120   DEC VOLUME
20B3 ADEE20     012130   LDA VOLUME
20B6 8D01D2     012140   STA $D201
20B9 C9A2       012150   CMP #$A2
20BB D01D       012160   BNE FINMUS
20BD A9AA       012170   LDA #$AA
20BF 8DEE20     012180   STA VOLUME
20C2 EEF020     012190   INC QUENOTA
20C5 AEF020     012200   LDX QUENOTA
20C8 BDF120     012210   LDA TONOS,X
20CB C9FF       012220   CMP #$FF
20CD D008       012230   BNE NOFINMUS
20CF A917       012240   LDA #23
20D1 8DF020     012250   STA QUENOTA
20D4 4C9B20     012260   JMP MUS
20D7            012270 NOFINMUS
20D7 8D00D2     012280   STA $D200
20DA            012290 FINMUS
20DA A562       012291   LDA PALNTS
20DC F00C       012292   BEQ FINMUS.FIN
20DE CEED20     012293   DEC FINMUS.CONTADOR
20E1 D007       012294   BNE FINMUS.FIN
20E3 A906       012295   LDA #6
20E5 8DED20     012296   STA FINMUS.CONTADOR
20E8 D0B1       012297   BNE MUS
20EA            012298 FINMUS.FIN
20EA 4C5FE4     012300   JMP $E45F
20ED            012301 FINMUS.CONTADOR
20ED 06         012302   .BYTE 6
20EE AA         012310 VOLUME .BYTE $AA
20EF 82         012320 SCUIS .BYTE 130
20F0 00         012330 QUENOTA .BYTE 0
20F1            012340 TONOS
20F1 00000000   012350   .BYTE 0,0,0,0,0,0,0,0,0,0,0,0
20F5 00000000
20F9 00000000
20FD 00000000   012360   .BYTE 0,0,0,0,0,0,0,0,0,0,0,0
2101 00000000
2105 00000000
2109 A2515151   012370   .BYTE 162,81,81,81,81,81,91,81,81,81,81,81
210D 51515B51
2111 51515151
2115 66515151   012380   .BYTE 102,81,81,81,81,81,108,81,81,81,81,81
2119 51516C51
211D 51515151
2121 79515151   012390   .BYTE 121,81,81,81,81,81,121,91,136,102,144,108
2125 5151795B
2129 8866906C
212D A279906C   012400   .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
2131 8866906C
2135 A279B688
2139 A279906C   012410   .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
213D 8866906C
2141 A279B688
2145 CC90D9A2   012420   .BYTE 204,144,217,162,243,204,243,182,217,162,204,217
2149 F3CCF3B6
214D D9A2CCD9
2151 A279906C   012430   .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
2155 8866906C
2159 A279B688
215D A279906C   012440   .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
2161 8866906C
2165 A279B688
2169 6C006C6C   012450   .BYTE 108,0,108,108,0,121,0,0,0,0,0,0
216D 00790000
2171 00000000
2175 88008888   012460   .BYTE 136,0,136,136,0,144,0,0,0,0,0,0
2179 00900000
217D 00000000
2181 A200A200   012470   .BYTE 162,0,162,0,162,0,144,0,144,0,144,0
2185 A2009000
2189 90009000
218D 88008800   012480   .BYTE 136,0,136,0,144,0,162,0,0,0,0,0
2191 9000A200
2195 00000000
2199 6C006C6C   012490   .BYTE 108,0,108,108,0,121,0,0,0,0,0,0
219D 00790000
21A1 00000000
21A5 88008888   012500   .BYTE 136,0,136,136,0,144,0,0,0,0,0,0
21A9 00900000
21AD 00000000
21B1 A200A200   012510   .BYTE 162,0,162,0,0,162,144,0,144,0,0,144
21B5 00A29000
21B9 90000090
21BD 88008890   012520   .BYTE 136,0,136,144,0,162,0,0,0,0,0,0,$FF
21C1 00A20000
21C5 00000000
21C9 FF
21CA            012530 DATALAST
21CA 60         012540   .BYTE $60
21CB 00         012550   .BYTE $00
21CC 52         012560   .BYTE $52
21CD 40         012570   .BYTE $40
21CE 0030       012580   .WORD BLKDOS
21D0 23         012590   .BYTE $23
21D1 00         012600   .BYTE $00
21D2 FA03       012610   .WORD FINBLKDOS-BLKDOS
21D4 00         012620   .BYTE $00
21D5 80         012630   .BYTE $80
21D6            012640 DL
21D6 70707046   012650   .BYTE 112,112,112,64+6
21DA            012660 CAMBIO1
21DA E921       012670   .WORD DATA
21DC 70707070   012680   .BYTE 112,112,112,112,112,112,112,112,112,112
21E0 70707070
21E4 7070
21E6 41         012690   .BYTE 65
21E7 D621       012700   .WORD DL
21E9            012710 DATA
21E9 00000074   012720   .SBYTE "   turbo SOFTWARE   "
21ED 7572626F
21F1 00332F26
21F5 34372132
21F9 25000000
21FD            012730 ROMARAM
21FD A940       012740   LDA #$40
21FF 48         012750   PHA
2200 AA         012760   TAX
2201 A900       012770   LDA #$00
2203 48         012780   PHA
2204 A8         012790   TAY
2205 84CD       012800   STY ROM
2207 84CB       012810   STY RAM
2209            012820 REENTRE
2209 86CC       012830   STX RAM+1
220B A2C0       012840   LDX #$C0
220D            012850 LOOPCITO
220D 86CE       012860   STX ROM+1
220F            012870 LOOP1
220F B1CD       012880   LDA (ROM),Y
2211 91CB       012890   STA (RAM),Y
2213 88         012900   DEY
2214 D0F9       012910   BNE LOOP1
2216 E6CC       012920   INC RAM+1
2218 E6CE       012930   INC ROM+1
221A E8         012940   INX
221B F008       012950   BEQ ROMOFF
221D E0D0       012960   CPX #$D0
221F D0EE       012970   BNE LOOP1
2221 A2D8       012980   LDX #$D8
2223 D0E8       012990   BNE LOOPCITO
2225            013000 ROMOFF
2225 78         013010   SEI
2226 68         013020   PLA
2227 8D0ED4     013030   STA $D40E
222A AD01D3     013040   LDA $D301
222D 29FE       013050   AND #$FE
222F 8D01D3     013060   STA $D301
2232            013070 RETURN
2232 A9CB       013080   LDA #RAM
2234 8D1022     013090   STA LOOP1+1
2237 A9CD       013100   LDA #ROM
2239 8D1222     013110   STA LOOP1+3
223C A960       013120   LDA #$60
223E 8D2A22     013130   STA ROMOFF+5
2241 A958       013140   LDA #$58
2243 8D2522     013150   STA ROMOFF
2246 A240       013160   LDX #$40
2248 4C0922     013170   JMP REENTRE
224B            013180 FINBLKFALSO


;********** TENIS2.MAC ***************
                0200     .INCLUDE #D:TENIS2.MAC
                0100 ; SAVE#D:TENIS2.MAC

224B            0110     *=  $3000
3000            0120 BLKDOS
3000 5555       0130     .BYTE $55,$55
    =3000       0140 ORIGEN = $3000
    =CC00       0150 PROGRAMA = $CC00
3002 98         0160     TYA
3003 1006       0170     BPL BLKOK
3005 20C7ED     0180     JSR $EDC7
3008 4CFCC8     0190     JMP $C8FC
300B            0200 BLKOK
300B AD2F30     0210     LDA EORBLOCK1
300E 49FF       0220     EOR #$FF
3010 8D2F30     0230     STA EORBLOCK1
3013 EE1130     0240     INC BLKOK+6
3016 EE0C30     0250     INC BLKOK+1
3019 D006       0260     BNE NOICRHI
301B EE1230     0270     INC BLKOK+7
301E EE0D30     0280     INC BLKOK+2
3021            0290 NOICRHI
3021 AD0D30     0300     LDA BLKOK+2
3024 C933       0310     CMP # >FINBLKDOS
3026 D0E3       0320     BNE BLKOK
3028 AD0C30     0330     LDA BLKOK+1
302B C9FA       0340     CMP # <FINBLKDOS
302D D0DC       0350     BNE BLKOK
302F            0360 EORBLOCK1
302F AD5AE4     0370     LDA $E45A
3032 8D2D32     0380     STA SALTO
3035 AD5BE4     0390     LDA $E45B
3038 8D2E32     0400     STA SALTO+1
303B A900       0410     LDA # <RAMPROG+SET
303D 8D5AE4     0420     STA $E45A
3040 85CD       0430     STA ROM
3042 A9CC       0440     LDA # >RAMPROG+SET
3044 8D5BE4     0450     STA $E45B
3047 85CE       0460     STA ROM+1
3049 A9FC       0470     LDA # <RAMPROG
304B 85CB       0480     STA RAM
304D A930       0490     LDA # >RAMPROG
304F 85CC       0500     STA RAM+1
3051 A000       0510     LDY #0
3053 A203       0520     LDX #3
3055            0530 ARRIBAROM
3055 B1CB       0540     LDA (RAM),Y
3057 91CD       0550     STA (ROM),Y
3059 C8         0560     INY
305A D0F9       0570     BNE ARRIBAROM
305C E6CC       0580     INC RAM+1
305E E6CE       0590     INC ROM+1
3060 CA         0600     DEX
3061 10F2       0610     BPL ARRIBAROM
3063 A202       0620     LDX #$02
3065            0630 LOOPINTERRUPCION
3065 BDF630     0640     LDA JSRINTERRUPCION,X
3068 9D59EB     0650     STA $EB59,X
306B BDF930     0660     LDA ERRORYA,X
306E 9D1DEB     0670     STA $EB1D,X
3071 CA         0680     DEX
3072 10F1       0690     BPL LOOPINTERRUPCION
3074 8EDB02     0700     STX $02DB
3077 8EF803     0710     STX $03F8
307A 8E0DFE     0720     STX $FE0D
307D A662       0730     LDX $62
307F A900       0740     LDA #$00
3081 8D8004     0750     STA $0480
3084 8D8104     0760     STA $0481
3087 9D91FE     0770     STA $FE91,X
308A A932       0780     LDA #$32
308C 9D93FE     0790     STA $FE93,X
308F A9EA       0800     LDA #$EA
3091 8DF3EB     0810     STA $EBF3
3094 8DF4EB     0820     STA $EBF4
3097 A9C0       0830     LDA #$C0
3099 856A       0840     STA $6A
309B A985       0850     LDA #133
309D 8D48FE     0860     STA $FE48
30A0 A90C       0870     LDA #12
30A2 8DFC02     0880     STA 764
30A5 A240       0890     LDX #$40
30A7 A90C       0900     LDA #$0C
30A9 9D4203     0910     STA $0342,X
30AC 2056E4     0920     JSR $E456
30AF A240       0930     LDX #$40
30B1 A903       0940     LDA #$03
30B3 9D4203     0950     STA $0342,X
30B6 A904       0960     LDA #$04
30B8 9D4A03     0970     STA $034A,X
30BB A980       0980     LDA #$80
30BD 9D4B03     0990     STA $034B,X
30C0 A9F3       1000     LDA # <C
30C2 9D4403     1010     STA $0344,X
30C5 A930       1020     LDA # >C
30C7 9D4503     1030     STA $0345,X
30CA 2056E4     1040     JSR $E456
30CD A240       1050     LDX #$40
30CF A900       1060     LDA # <GAMEA+Z
30D1 9D4403     1070     STA $0344,X
30D4 A9D8       1080     LDA # >GAMEA+Z
30D6 9D4503     1090     STA $0345,X
30D9 A9FC       1100     LDA # <FIN-GAMEA
30DB 9D4803     1110     STA $0348,X
30DE A905       1120     LDA # >FIN-GAMEA
30E0 9D4903     1130     STA $0349,X
30E3 A907       1140     LDA #$07
30E5 9D4203     1150     STA $0342,X
30E8 A9F0       1160     LDA #$F0
30EA 8D34CD     1170     STA QUEBLK+SET+1
30ED 2056E4     1180     JSR $E456
30F0 4C00D8     1190     JMP GAMEA+Z
30F3            1200 C
30F3 433A9B     1210     .BYTE "C:",$9B
30F6            1220 JSRINTERRUPCION
30F6 2010CD     1230     JSR INTERRUPCION+SET
30F9            1240 ERRORYA
30F9 2032CC     1250     JSR ERROR?+SET
30FC            1260 RAMPROG
30FC AD0003     1270     LDA $0300
30FF C960       1280     CMP #$60
3101 D028       1290     BNE READBLOCK
3103            1300 NEXT
3103 202FCC     1310     JSR READBLOCK+SET
3106 3034       1320     BMI ERROR
3108            1330 VUELTABLK1
3108 AD8004     1340     LDA $0480
310B 8D33CD     1350     STA QUEBLK+SET
310E AD8104     1360     LDA $0481
3111 8D34CD     1370     STA QUEBLK+SET+1
3114 A202       1380     LDX #$02
3116            1390 COUNTBLOCK
3116 DE0ECE     1400     DEC BLK+SET,X
3119 BD0ECE     1410     LDA BLK+SET,X
311C C98F       1420     CMP #'0-33
311E D008       1430     BNE FINCOUNT
3120 A999       1440     LDA #'9-32
3122 9D0ECE     1450     STA BLK+SET,X
3125 CA         1460     DEX
3126 10EE       1470     BPL COUNTBLOCK
3128            1480 FINCOUNT
3128 A001       1490     LDY #$01
312A 60         1500     RTS
312B            1510 READBLOCK
312B 6C31CD     1520     JMP (SALTO+SET)
312E            1530 ERROR?
312E F00A       1540     BEQ ERRORAZO
3130 A430       1550     LDY $30
3132 3006       1560     BMI ERRORAZO
3134 AD1703     1570     LDA $0317
3137 F001       1580     BEQ ERRORAZO
3139 60         1590     RTS
313A            1600 ERRORAZO
313A 68         1610     PLA
313B 68         1620     PLA
313C            1630 ERROR
313C 20C7ED     1640     JSR $EDC7
313F C088       1650     CPY #136
3141 D002       1660     BNE NOESEOF
3143 98         1670     TYA
3144 60         1680     RTS
3145            1690 NOESEOF
3145 A20A       1700     LDX #$0A
3147            1710 LOOPCORRIGIENDO
3147 BD78CE     1720     LDA CORRECCION+SET,X
314A 9DEECD     1730     STA LEYENDO+SET,X
314D CA         1740     DEX
314E 10F7       1750     BPL LOOPCORRIGIENDO
3150 18         1760     CLC
3151 AD3002     1770     LDA 560
3154 8500       1780     STA $00
3156 AD3102     1790     LDA 561
3159 8501       1800     STA $01
315B A00A       1810     LDY #$0A
315D            1820 SAVEVIEJO
315D B100       1830     LDA ($00),Y
315F 48         1840     PHA
3160 C8         1850     INY
3161 C00D       1860     CPY #$0D
3163 D0F8       1870     BNE SAVEVIEJO
3165            1880 JUSTO
3165 AD0BD4     1890     LDA $D40B
3168 30FB       1900     BMI JUSTO
316A A00A       1910     LDY #$0A
316C A901       1920     LDA #$01
316E 9100       1930     STA ($00),Y
3170 AD3102     1940     LDA 561
3173 C9CE       1950     CMP # >DISPLIST+SET
3175 D006       1960     BNE NOTENNIS
3177 A9BB       1970     LDA # <DL1+SET
3179 A2CE       1980     LDX # >DL1+SET
317B D004       1990     BNE SITENNIS
317D            2000 NOTENNIS
317D A9B4       2010     LDA # <DL2+SET
317F A2CE       2020     LDX # >DL2+SET
3181            2030 SITENNIS
3181 C8         2040     INY
3182 9100       2050     STA ($00),Y
3184 8A         2060     TXA
3185 C8         2070     INY
3186 9100       2080     STA ($00),Y
3188 20F8F2     2090     JSR $F2F8
318B            2100 JUSTO1
318B AD0BD4     2110     LDA $D40B
318E 30FB       2120     BMI JUSTO1
3190 A00C       2130     LDY #$0C
3192            2140 RESTAURA
3192 68         2150     PLA
3193 9100       2160     STA ($00),Y
3195 88         2170     DEY
3196 C009       2180     CPY #$09
3198 D0F8       2190     BNE RESTAURA
319A A934       2200     LDA #$34
319C 8D02D3     2210     STA $D302
319F A514       2220     LDA $14
31A1 18         2230     CLC
31A2 6932       2240     ADC #50
31A4            2250 WMOTOR
31A4 C514       2260     CMP $14
31A6 D0FC       2270     BNE WMOTOR
31A8            2280 ESPERE
31A8 AC0BD4     2290     LDY $D40B
31AB A205       2300     LDX #$05
31AD            2310 ESPERE1
31AD 8E0AD4     2320     STX $D40A
31B0            2330 ESIRG
31B0 AD0FD2     2340     LDA $D20F
31B3 2910       2350     AND #$10
31B5 F0F1       2360     BEQ ESPERE
31B7 CC0BD4     2370     CPY $D40B
31BA D0F4       2380     BNE ESIRG
31BC CA         2390     DEX
31BD D0EE       2400     BNE ESPERE1
31BF            2410 NOESIGUAL
31BF A940       2420     LDA #$40
31C1 8D0303     2430     STA $0303
31C4 202FCC     2440     JSR READBLOCK+SET
31C7 100A       2450     BPL NOERRORFALSO
31C9 20C7ED     2460     JSR $EDC7
31CC A934       2470     LDA #$34
31CE 8D02D3     2480     STA $D302
31D1 D0D5       2490     BNE ESPERE
31D3            2500 NOERRORFALSO
31D3 AD34CD     2510     LDA QUEBLK+SET+1
31D6 101C       2520     BPL NOBLK1
31D8 AD8004     2530     LDA $0480
31DB 0D8104     2540     ORA $0481
31DE D029       2550     BNE VALLAERROR
31E0 20EACC     2560     JSR CHANGEMSG+SET
31E3 4C0CCC     2570     JMP VUELTABLK1+SET
31E6            2580 CHANGEMSG
31E6 A20A       2590     LDX #$0A
31E8            2600 LOOPLECTURA
31E8 BD82CE     2610     LDA LECTURA+SET,X
31EB 9DEECD     2620     STA LEYENDO+SET,X
31EE CA         2630     DEX
31EF 10F7       2640     BPL LOOPLECTURA
31F1 A001       2650     LDY #$01
31F3 60         2660     RTS
31F4            2670 NOBLK1
31F4 A201       2680     LDX #$01
31F6            2690 LOOPLUGAR
31F6 BD8004     2700     LDA $0480,X
31F9 DD33CD     2710     CMP QUEBLK+SET,X
31FC 90C1       2720     BCC NOESIGUAL
31FE D009       2730     BNE VALLAERROR
3200 CA         2740     DEX
3201 10F3       2750     BPL LOOPLUGAR
3203 20EACC     2760     JSR CHANGEMSG+SET
3206 4C07CC     2770     JMP NEXT+SET
3209            2780 VALLAERROR
3209 4C40CC     2790     JMP ERROR+SET
320C            2800 INTERRUPCION
320C ADEECD     2810     LDA LEYENDO+SET
320F 297F       2820     AND #$7F
3211 F002       2830     BEQ BYTESLOOP
3213 D014       2840     BNE NOES9I
3215            2850 BYTESLOOP
3215 A204       2860     LDX #$04
3217            2870 BYTESLOOP1
3217 FE00CE     2880     INC BYTES+SET,X
321A BD00CE     2890     LDA BYTES+SET,X
321D C99A       2900     CMP #'9-31
321F D008       2910     BNE NOES9I
3221 A990       2920     LDA #'0-32
3223 9D00CE     2930     STA BYTES+SET,X
3226 CA         2940     DEX
3227 10EE       2950     BPL BYTESLOOP1
3229            2960 NOES9I
3229 AD0DD2     2970     LDA $D20D
322C 60         2980     RTS
322D 0000       2990 SALTO .DBYTE 0
322F 0000       3000 QUEBLK .DBYTE 0
3231            3010 TENMEBLK
3231 B0B0B0     3020     .BYTE "000"
3234            3030 MENSAJEERROR
3234 00000032   3040     .SBYTE "   REBOBINE SU CASSETTE 3 VUELTAS DE    "
3238 25222F22
323C 292E2500
3240 33350023
3244 21333325
3248 34342500
324C 13003635
3250 252C3421
3254 33002425
3258 00000000
325C 00000023   3050     .SBYTE "   CONTADOR, PRESIONE ?PLAY?Y?RETURN?   "
3260 2F2E3421
3264 242F320C
3268 00303225
326C 33292F2E
3270 2500D9B0
3274 ACA1B959
3278 39D9B2A5
327C B4B5B2AE
3280 59000000
3284            3060 PANTALLA
3284 AAAAAAAA   3070     .BYTE "********************"
3288 AAAAAAAA
328C AAAAAAAA
3290 AAAAAAAA
3294 AAAAAAAA
3298 8080       3080 PERS .SBYTE "  "
329A 909090     3090 NUMERO1 .SBYTE "000
"
329D 80808080   3100     .SBYTE "     * 1 JUGADOR-FRONTON *    "
32A1 808A8091
32A5 80AAB5A7
32A9 A1A4AFB2
32AD 8DA6B2AF
32B1 AEB4AFAE
32B5 808A8080
32B9 8080
32BB 90909080   3110 NUMERO2 .SBYTE "000  "
32BF 80
32C0            3120 MENSAJE
32C0 8080ADB0   3130     .SBYTE "  MPM    * CARGANDO  PROGRAMA *    MPM  "
32C4 AD808080
32C8 808A80A3
32CC A1B2A7A1
32D0 AEA4AF80
32D4 80B0B2AF
32D8 A7B2A1AD
32DC A1808A80
32E0 808080AD
32E4 B0AD8080
32E8 8080       3140     .SBYTE "  "
32EA            3150 LEYENDO
32EA 8088B289   3160     .SBYTE " (R)-1988   BYTES:"
32EE 8D919998
32F2 98808080
32F6 A2B9B4A5
32FA B39A
32FC            3170 BYTES
32FC 90909090   3180     .SBYTE "00000  BLOQUE:"
3300 908080A2
3304 ACAFB1B5
3308 A59A
330A            3190 BLK
330A 90909080   3200     .SBYTE "000   "

330E 8080
3310 AAAAAAAA   3210     .BYTE "********************"
3314 AAAAAAAA
3318 AAAAAAAA
331C AAAAAAAA
3320 AAAAAAAA
3324            3220 PER2
3324 80809090   3230     .SBYTE "  000     * 2 JUGADORES-TENIS *    000  "
3328 90808080
332C 80808A80
3330 9280AAB5
3334 A7A1A4AF
3338 B2A5B38D
333C B4A5AEA9
3340 B3808A80
3344 80808090
3348 90908080
334C            3240 PER1
334C 80809090   3250     .SBYTE "  000     * 1 JUGADOR-FRONTON *    000  "
3350 90808080
3354 80808A80
3358 9180AAB5
335C A7A1A4AF
3360 B28DA6B2
3364 AFAEB4AF
3368 AE808A80
336C 80808090
3370 90908080
3374            3260 CORRECCION
3374 A3AFB2B2   3270     .SBYTE "CORRECCION"
3378 A5A3A3A9
337C AFAE
337E            3280 LECTURA
337E 8088B289   3290     .SBYTE " (R)-1988 "
3382 8D919998
3386 9880
3388            3300 CARGADO
3388 80808080   3310     .SBYTE "    PROGRAMA CARGADO, PRESIONE START    "
338C B0B2AFA7
3390 B2A1ADA1
3394 80A3A1B2
3398 A7A1A4AF
339C 8C80B0B2
33A0 A5B3A9AF
33A4 AEA580B3
33A8 B4A1B2B4
33AC 80808080
33B0            3320 DL2
33B0 42         3330     .BYTE 64+2
33B1 38CD       3340     .WORD MENSAJEER
ROR+SET
33B3 0241       3350     .BYTE 2,65
33B5 20BC       3360     .WORD $BC20
33B7            3370 DL1
33B7 42         3380     .BYTE 64+2
33B8 38CD       3390     .WORD MENSAJEER
ROR+SET
33BA 02707070   3400     .BYTE 2,112,112,112,112,112,112,112,112,112,112,112,112,1
12,112,112,112
33BE 70707070
33C2 70707070
33C6 70707070
33CA 70
33CB 42         3410     .BYTE 64+2
33CC C4CD       3420     .WORD MENSAJE+SET
33CE 020808     3430     .BYTE 2,8,8
33D1 41         3440     .BYTE 65
33D2 D8CE       3450     .WORD DISPLIST+SET
33D4            3460 DISPLIST
33D4 48         3470     .BYTE 64+8
33D5 88CD       3480     .WORD PANTALLA+SET
33D7 08027070   3490     .BYTE 8,2,112,112,112,112,112,112,112
33DB 70707070
33DF 70
33E0            3500 AQUIJUMP
33E0 70707070   3510     .BYTE 112,112,112,112,112,112,112,112,112,112,112,112,112
,112,112,112,0
33E4 70707070
33E8 70707070
33EC 70707070
33F0 00
33F1 42         3520     .BYTE 64+2
33F2            3530 CUALPANTALLA
33F2 C4CD       3540     .WORD MENSAJE+SET
33F4 020808     3550     .BYTE 2,8,8
33F7 41         3560     .BYTE 65
33F8 D8CE       3570     .WORD DISPLIST+SET
33FA            3580 BUFFER
33FA            3590 FINBLKDOS
33FA            3600     *=  $4000
4000            3610 GAMEA
    =9800       3620 Z   =   $D800-*
4000 A922       3630     LDA # <GAME1A+Z
4002 85CB       3640     STA $CB
4004 A9D8       3650     LDA # >GAME1A+Z
4006 85CC       3660     STA $CC
4008 A000       3670     LDY #$00
400A            3680 EOR29LOOP
400A B1CB       3690     LDA ($CB),Y
400C 4929       3700     EOR #$29
400E 91CB       3710     STA ($CB),Y
4010 E6CB       3720     INC $CB
4012 D002       3730     BNE BCC
4014 E6CC       3740     INC $CC
4016            3750 BCC
4016 A5CC       3760     LDA $CC
4018 C9DD       3770     CMP # >FIN+Z
401A D0EE       3780     BNE EOR29LOOP
401C A5CB       3790     LDA $CB
401E C9FC       3800     CMP # <FIN+Z
4020 D0E8       3810     BNE EOR29LOOP
4022            3820 GAME1A
4022 4C85D8     3830     JMP COMIENZOLOAD+Z
4025            3840 SETCANT
4025 A210       3850     LDX #$10
4027 9D4803     3860     STA $0348,X
402A 98         3870     TYA
402B 9D4903     3880     STA $0349,X
402E 60         3890     RTS
402F            3900 READ2
402F A902       3910     LDA #$02
4031 A000       3920     LDY #$00
4033 2025D8     3930     JSR SETCANT+Z
4036            3940 READ3
4036 A9FC       3950     LDA # <FIN+Z
4038 A0DD       3960     LDY # >FIN+Z
403A            3970 SETPOS
403A 9D4403     3980     STA $0344,X
403D 98         3990     TYA
403E 9D4503     4000     STA $0345,X
4041 A907       4010     LDA #$07
4043 9D4203     4020     STA $0342,X
4046 2056E4     4030     JSR $E456
4049 1003       4040     BPL NOEOF
404B 4CF2DC     4050     JMP INICIOBOOT+Z
404E            4060 NOEOF
404E A210       4070     LDX #$10
4050 60         4080     RTS
4051 00         4090 BYTELENTO .BYTE $00
4052            4100 LEEMULA
4052 A901       4110     LDA #$01
4054 8D51D8     4120     STA BYTELENTO+Z
4057            4130 LEEMULA1
4057 AD0FD2     4140     LDA $D20F
405A 2910       4150     AND #$10
405C F0F9       4160     BEQ LEEMULA1
405E            4170 FINSTART
405E AD0FD2     4180     LDA $D20F
4061 2910       4190     AND #$10
4063 D0F9       4200     BNE FINSTART
                4210 ;   LDA #$00-12
4065 A9F6       4211     LDA #$00-10
4067 8514       4220     STA 20
4069            4230 ESPERO12
4069 A514       4240     LDA 20
406B D0FC       4250     BNE ESPERO12
406D            4260 LEOBIT
406D 18         4270     CLC
406E AD0FD2     4280     LDA $D20F
4071 2910       4290     AND #$10
4073 F001       4300     BEQ LEICERO
4075 38         4310     SEC
4076            4320 LEICERO
4076 2E51D8     4330     ROL BYTELENTO+Z
4079 B006       4340     BCS FINBYTELENTO
                4350 ;   LDA #$00-8
407B A9F9       4351     LDA #$00-7
407D 8514       4360     STA 20
407F D0E8       4370     BNE ESPERO12
4081            4380 FINBYTELENTO
4081 AD51D8     4390     LDA BYTELENTO+Z
4084 60         4400     RTS
4085            4410 COMIENZOLOAD
4085 AC0BD4     4420     LDY $D40B
4088 30FB       4430     BMI COMIENZOLOAD
408A A95F       4440     LDA # <$E45F
408C 8D2202     4450     STA $0222
408F A9E4       4460     LDA # >$E45F
4091 8D2302     4470     STA $0223
4094 A900       4480     LDA #$00
4096 8D00D2     4490     STA $D200
4099 8D01D2     4500     STA $D201
409C 8D02D2     4510     STA $D202
409F            4520 BORRAMEM
409F A904       4530     LDA #$04
40A1 8501       4540     STA $01
40A3 A900       4550     LDA #$00
40A5 8500       4560     STA $00
40A7 A8         4570     TAY
40A8            4580 ERASERAM
40A8 9100       4590     STA ($00),Y
40AA C8         4600     INY
40AB D0FB       4610     BNE ERASERAM
40AD E601       4620     INC $01
40AF A601       4630     LDX $01
40B1            4640 PONERC0
40B1 E0C0       4650     CPX #$C0
40B3 D0F3       4660     BNE ERASERAM
40B5 A202       4670     LDX #$02
40B7            4680 ZLOOPCEROS
40B7 BD35CD     4690     LDA TENMEBLK+SET,X
40BA 9D0ECE     4700     STA BLK+SET,X
40BD A990       4710     LDA #'0-32
40BF 9D02CE     4720     STA BYTES+2+SET,X
40C2 CA         4730     DEX
40C3 10F2       4740     BPL ZLOOPCEROS
40C5 8D01CE     4750     STA BYTES+1+SET
40C8 A203       4760     LDX #$03
40CA A900       4770     LDA #$00
40CC            4780 NIRUNNISTART
40CC 9DE002     4790     STA $02E0,X
40CF CA         4800     DEX
40D0 10FA       4810     BPL NIRUNNISTART
40D2 8DF8DD     4820     STA FBOOT+Z
    =00DC       4830 PMBASE = $DC
    =D300       4840 JOYST = $D300
    =D010       4850 BOTON1 = $D010
    =D011       4860 BOTON2 = $D011
    =02C0       4870 COLORP0 = $02C0
    =D000       4880 HPOSP0 = $D000
    =D001       4890 HPOSP1 = $D001
    =D002       4900 HPOSP2 = $D002
    =D007       4910 DIVISION = $D007
    =D01F       4920 CONSOL = $D01F
    =D20A       4930 RANDOM = $D20A
    =DF10       4940 BOLITA = PMBASE*$0100+768+16
    =DE10       4950 P0  =   PMBASE*$0100+512+16
    =DE90       4960 P1  =   PMBASE*$0100+640+16
40D5            4970 INICIO
40D5 A011       4980     LDY #17
40D7 A9EA       4990     LDA #$EA
40D9            5000 NOPDLIVBI
40D9 9937C1     5010     STA $C137,Y
40DC 88         5020     DEY
40DD 10FA       5030     BPL NOPDLIVBI
40DF A002       5040     LDY #$02
40E1            5050 NOSHADOWS
40E1 996FC1     5060     STA $C16F,Y
40E4 9978C1     5070     STA $C178,Y
40E7 88         5080     DEY
40E8 10F7       5090     BPL NOSHADOWS
40EA A900       5100     LDA #0
40EC 8D74D9     5110     STA START+Z
40EF A282       5120     LDX #$82
40F1            5130 LOOPCLR
40F1 9D10DF     5140     STA BOLITA,X
40F4 9D0EDE     5150     STA P0-2,X
40F7 9D8EDE     5160     STA P1-2,X
40FA CA         5170     DEX
40FB E0FF       5180     CPX #$FF
40FD D0F2       5190     BNE LOOPCLR
40FF E8         5200     INX
4100            5210 LOOPCLR1
4100 9D00DE     5220     STA $DE00,X
4103 9D00DF     5230     STA $DF00,X
4106 CA         5240     DEX
4107 D0F7       5250     BNE LOOPCLR1
4109 A9BF       5260     LDA #191
410B 8D00D0     5270     STA HPOSP0
410E A900       5280     LDA #0
4110 8D01D0     5290     STA HPOSP1
4113 A9BF       5300     LDA #191
4115 8D02D0     5310     STA HPOSP2
4118 A22A       5320     LDX #42
411A 8E04D0     5330     STX $D004
411D A2CE       5340     LDX #206
411F 8E05D0     5350     STX $D005
4122 2055D9     5360     JSR SETPERS+Z
4125 A93F       5370     LDA #63
4127 8D0CD0     5380     STA $D00C
412A A903       5390     LDA #$03
412C AE6DD9     5400     LDX YPOS0+Z
412F A00C       5410     LDY #$0C
4131            5420 DIBP1
4131 9D10DE     5430     STA P0,X
4134 9D90DE     5440     STA P1,X
4137 E8         5450     INX
4138 88         5460     DEY
4139 10F6       5470     BPL DIBP1
413B A901       5480     LDA #1
413D AE6FD9     5490     LDX YPOS2+Z
4140 9D10DF     5500     STA BOLITA,X
4143            5510 WFORSET
4143 AD0BD4     5520     LDA $D40B
4146 30FB       5530     BMI WFORSET
4148 A97A       5540     LDA # <VBI+Z
414A 8D2202     5550     STA $0222
414D A9D9       5560     LDA # >VBI+Z
414F 8D2302     5570     STA $0223
4152 4C3EDC     5580     JMP OPEN+Z
4155            5590 SETPERS
4155 A902       5600     LDA #2
4157 8D6F02     5610     STA 623
415A 8D1DD0     5620     STA $D01D
415D A9DC       5630     LDA #PMBASE
415F 8D07D4     5640     STA $D407
4162 A200       5650     LDX #0
4164 8E07D0     5660     STX DIVISION
4167 A97F       5670     LDA #$7F
4169 8D11D0     5680     STA $D011
416C 60         5690     RTS
416D 30         5700 YPOS0 .BYTE 48
416E 30         5710 YPOS1 .BYTE 48
416F 30         5720 YPOS2 .BYTE 48
4170 BF         5730 XPOS2 .BYTE 191
4171 00         5740 XPOS1 .BYTE 0
4172 FF         5750 FX  .BYTE $FF
4173 00         5760 FY  .BYTE 0
4174 00         5770 START .BYTE 0
4175 00         5780 IMPULSO .BYTE 0
4176 00         5790 SELECT .BYTE 0
4177 FF         5800 JUEGO .BYTE $FF
4178 0000       5810 SAVEVBI .DBYTE 0
417A            5820 VBI
417A A9CE       5830     LDA # >DISPLIST+SET
417C 8D03D4     5840     STA $D403
417F 8D4402     5850     STA $0244
4182 8D3102     5860     STA 561
4185 A9D8       5870     LDA # <DISPLIST+SET
4187 8D02D4     5880     STA $D402
418A 8D3002     5890     STA 560
418D A900       5900     LDA #0
418F 854D       5910     STA 77
4191 8D18D0     5920     STA $D018
4194 A9E0       5930     LDA #$E0
4196 8D09D4     5940     STA $D409
4199 A90E       5950     LDA #$0E
419B 8D12D0     5960     STA $D012
419E 8D13D0     5970     STA $D013
41A1 8D14D0     5980     STA $D014
41A4 8D16D0     5990     STA $D016
41A7 8D17D0     6000     STA $D017
41AA 8D19D0     6010     STA $D019
41AD A9D4       6020     LDA #212
41AF 8D1AD0     6030     STA $D01A
41B2 A92A       6040     LDA #42
41B4 8D00D4     6050     STA $D400
41B7 A9A0       6060     LDA #$A0
41B9 8D01D2     6070     STA $D201
41BC A900       6080     LDA #$00
41BE 8D00D2     6090     STA $D200
41C1 AD1FD0     6100     LDA CONSOL
41C4 C905       6110     CMP #$05
41C6 D04A       6120     BNE SELECT0
41C8 AD76D9     6130     LDA SELECT+Z
41CB D04A       6140     BNE NOCAMBIO
41CD A901       6150     LDA #1
41CF 8D76D9     6160     STA SELECT+Z
41D2 A900       6170     LDA #0
41D4 8D74D9     6180     STA START+Z
41D7 A027       6190     LDY #39
41D9 AD77D9     6200     LDA JUEGO+Z
41DC 49FF       6210     EOR #$FF
41DE 8D77D9     6220     STA JUEGO+Z
41E1 3018       6230     BMI ESUNO
41E3            6240 CHANGE ;        2 PERS
41E3 B928CE     6250     LDA PER2+SET,Y
41E6 999CCD     6260     STA PERS+SET,Y
41E9 88         6270     DEY
41EA 10F7       6280     BPL CHANGE
41EC A932       6290     LDA #50
41EE 8D01D0     6300     STA HPOSP1
41F1 8D71D9     6310     STA XPOS1+Z
41F4 A97F       6320     LDA #127
41F6 8D07D0     6330     STA DIVISION
41F9 D014       6340     BNE TERMINELO
41FB            6350 ESUNO ;         1PER
41FB B950CE     6360     LDA PER1+SET,Y
41FE 999CCD     6370     STA PERS+SET,Y
4201 88         6380     DEY
4202 10F7       6390     BPL ESUNO
4204 A900       6400     LDA #0
4206 8D01D0     6410     STA HPOSP1
4209 8D71D9     6420     STA XPOS1+Z
420C 8D07D0     6430     STA DIVISION
420F            6440 TERMINELO
420F 4C5FE4     6450     JMP $E45F
4212            6460 SELECT0
4212 A900       6470     LDA #0
4214 8D76D9     6480     STA SELECT+Z
4217            6490 NOCAMBIO
4217 AD74D9     6500     LDA START+Z
421A D045       6510     BNE STARTED
421C A900       6520     LDA #0
421E AE6FD9     6530     LDX YPOS2+Z
4221 9D10DF     6540     STA BOLITA,X
4224 AD1FD0     6550     LDA CONSOL
4227 C906       6560     CMP #$06
4229 D005       6570     BNE NOSTART
422B A9FF       6580     LDA #$FF
422D 8D74D9     6590     STA START+Z
4230            6600 NOSTART
4230 AD70D9     6610     LDA XPOS2+Z
4233 1017       6620     BPL BOTON2?
4235 AD10D0     6630     LDA BOTON1
4238 D024       6640     BNE JOY
423A AD6DD9     6650     LDA YPOS0+Z
423D 8D6FD9     6660     STA YPOS2+Z
4240 A9BE       6670     LDA #190
4242 8D70D9     6680     STA XPOS2+Z
4245            6690 EMPIEZELO
4245 A9FF       6700     LDA #$FF
4247 8D74D9     6710     STA START+Z
424A D0C3       6720     BNE TERMINELO
424C            6730 BOTON2?
424C AD11D0     6740     LDA BOTON2
424F D00D       6750     BNE JOY
4251 AD6ED9     6760     LDA YPOS1+Z
4254 8D6FD9     6770     STA YPOS2+Z
4257 A933       6780     LDA #51
4259 8D70D9     6790     STA XPOS2+Z
425C D0E7       6800     BNE EMPIEZELO
425E            6810 JOY
425E 4C92DB     6820     JMP JOYSTS+Z
4261            6830 STARTED
4261 AD72D9     6840     LDA FX+Z
4264 1006       6850     BPL INCRX
4266 2088DA     6860     JSR DECREX+Z
4269 4C6FDA     6870     JMP UD+Z
426C            6880 INCRX
426C 20FADA     6890     JSR INCREX+Z
426F            6900 UD
426F A900       6910     LDA #0
4271 AE6FD9     6920     LDX YPOS2+Z
4274 9D10DF     6930     STA BOLITA,X
4277 AD73D9     6940     LDA FY+Z
427A 1006       6950     BPL INCRY
427C 2080DB     6960     JSR DECREY+Z
427F 4C92DB     6970     JMP JOYSTS+Z
4282            6980 INCRY
4282 2056DB     6990     JSR INCREY+Z
4285 4C92DB     7000     JMP JOYSTS+Z
4288            7010 DECREX
4288 AD0ED0     7020     LDA $D00E
428B 2902       7030     AND #$02
428D F020       7040     BEQ NOREBOTE
428F A933       7050     LDA #$33
4291 8D00D2     7060     STA $D200
4294 A9AC       7070     LDA #$AC
4296 8D01D2     7080     STA $D201
4299 AD00D3     7090     LDA JOYST
429C 4A         7100     LSR A
429D 4A         7110     LSR A
429E 4A         7120     LSR A
429F 4A         7130     LSR A
42A0 C90F       7140     CMP #$0F
42A2 F002       7150     BEQ NOIMPULSE1
42A4 A9FF       7160     LDA #$FF
42A6            7170 NOIMPULSE1
42A6 8D75D9     7180     STA IMPULSO+Z
42A9 AE70D9     7190     LDX XPOS2+Z
42AC 4CEBDA     7200     JMP CHANGEXF+Z
42AF            7210 NOREBOTE
42AF CE70D9     7220     DEC XPOS2+Z
42B2 CE70D9     7230     DEC XPOS2+Z
42B5 AE70D9     7240     LDX XPOS2+Z
42B8 E02D       7250     CPX #45
42BA B037       7260     BCS FINDECREX
42BC AD71D9     7270     LDA XPOS1+Z
42BF C928       7280     CMP #40
42C1 9005       7290     BCC OUT2
42C3 A900       7300     LDA #0
42C5 8D74D9     7310     STA START+Z
42C8            7320 OUT2
42C8 A988       7330     LDA #$88
42CA 8D00D2     7340     STA $D200
42CD A9AC       7350     LDA #$AC
42CF 8D01D2     7360     STA $D201
42D2 A002       7370     LDY #2
42D4            7380 ZERO1
42D4 B99ECD     7390     LDA NUMERO1+SET,Y
42D7 C999       7400     CMP #'9-32+128
42D9 F008       7410     BEQ NINE1
42DB 18         7420     CLC
42DC 6901       7430     ADC #1
42DE 999ECD     7440     STA NUMERO1+SET,Y
42E1 D008       7450     BNE CHANGEXF
42E3            7460 NINE1
42E3 A990       7470     LDA #'0+128-32
42E5 999ECD     7480     STA NUMERO1+SET,Y
42E8 88         7490     DEY
42E9 10E9       7500     BPL ZERO1
42EB            7510 CHANGEXF
42EB AD72D9     7520     LDA FX+Z
42EE 49FF       7530     EOR #$FF
42F0 8D72D9     7540     STA FX+Z
42F3            7550 FINDECREX
42F3 8E70D9     7560     STX XPOS2+Z
42F6 8E02D0     7570     STX HPOSP2
42F9 60         7580     RTS
42FA            7590 INCREX
42FA AD0ED0     7600     LDA $D00E
42FD 2901       7610     AND #$01
42FF F01E       7620     BEQ NOREBOTE1
4301 A9AC       7630     LDA #$AC
4303 8D01D2     7640     STA $D201
4306 A933       7650     LDA #$33
4308 8D00D2     7660     STA $D200
430B AD00D3     7670     LDA JOYST
430E 290F       7680     AND #$0F
4310 C90F       7690     CMP #$0F
4312 F002       7700     BEQ NOIMPULSE
4314 A9FF       7710     LDA #$FF
4316            7720 NOIMPULSE
4316 8D75D9     7730     STA IMPULSO+Z
4319 AE70D9     7740     LDX XPOS2+Z
431C 4CEBDA     7750     JMP CHANGEXF+Z
431F            7760 NOREBOTE1
431F EE70D9     7770     INC XPOS2+Z
4322 EE70D9     7780     INC XPOS2+Z
4325 AE70D9     7790     LDX XPOS2+Z
4328 E0CD       7800     CPX #205
432A 90C7       7810     BCC FINDECREX
432C            7820 SELEFUE
432C A900       7830     LDA #0
432E 8D74D9     7840     STA START+Z
4331 A988       7850     LDA #$88
4333 8D00D2     7860     STA $D200
4336 A9AC       7870     LDA #$AC
4338 8D01D2     7880     STA $D201
433B A002       7890     LDY #2
433D            7900 ZERO2
433D B9BFCD     7910     LDA NUMERO2+SET,Y
4340 C999       7920     CMP #'9-32+128
4342 F008       7930     BEQ NINE2
4344 18         7940     CLC
4345 6901       7950     ADC #1
4347 99BFCD     7960     STA NUMERO2+SET,Y
434A D09F       7970     BNE CHANGEXF
434C            7980 NINE2
434C A990       7990     LDA #'0+128-32
434E 99BFCD     8000     STA NUMERO2+SET,Y
4351 88         8010     DEY
4352 10E9       8020     BPL ZERO2
4354 3095       8030     BMI CHANGEXF
4356            8040 INCREY
4356 EE6FD9     8050     INC YPOS2+Z
4359 AD75D9     8060     LDA IMPULSO+Z
435C 1003       8070     BPL BOTAR1
435E EE6FD9     8080     INC YPOS2+Z
4361            8090 BOTAR1
4361 AE6FD9     8100     LDX YPOS2+Z
4364 E05C       8110     CPX #92
4366 9012       8120     BCC FININCRY
4368            8130 CHANGEFY
4368 AD73D9     8140     LDA FY+Z
436B 49FF       8150     EOR #$FF
436D 8D73D9     8160     STA FY+Z
4370 A950       8170     LDA #$50
4372 8D00D2     8180     STA $D200
4375 A9AC       8190     LDA #$AC
4377 8D01D2     8200     STA $D201
437A            8210 FININCRY
437A A901       8220     LDA #1
437C 9D10DF     8230     STA BOLITA,X
437F 60         8240     RTS
4380            8250 DECREY
4380 CE6FD9     8260     DEC YPOS2+Z
4383 AD75D9     8270     LDA IMPULSO+Z
4386 1003       8280     BPL BOTAR2
4388 CE6FD9     8290     DEC YPOS2+Z
438B            8300 BOTAR2
438B AE6FD9     8310     LDX YPOS2+Z
438E 30D8       8320     BMI CHANGEFY
4390 10E8       8330     BPL FININCRY
4392            8340 JOYSTS
4392 A900       8350     LDA #0
4394 8D1ED0     8360     STA $D01E
4397 AD00D3     8370     LDA JOYST
439A 290F       8380     AND #$0F
439C C90F       8390     CMP #15
439E F011       8400     BEQ JOY2
43A0 C90E       8410     CMP #14
43A2 D006       8420     BNE DWN1
43A4 20D0DB     8430     JSR J1UP+Z
43A7 4CB1DB     8440     JMP JOY2+Z
43AA            8450 DWN1
43AA C90D       8460     CMP #13
43AC D003       8470     BNE JOY2
43AE 2000DC     8480     JSR J1DWN+Z
43B1            8490 JOY2
43B1 AD00D3     8500     LDA JOYST
43B4 4A         8510     LSR A
43B5 4A         8520     LSR A
43B6 4A         8530     LSR A
43B7 4A         8540     LSR A
43B8 C90F       8550     CMP #15
43BA F011       8560     BEQ EXIT
43BC C90E       8570     CMP #14
43BE D006       8580     BNE DWN2
43C0 20E8DB     8590     JSR J2UP+Z
43C3 4C5FE4     8600     JMP $E45F
43C6            8610 DWN2
43C6 C90D       8620     CMP #13
43C8 D003       8630     BNE EXIT
43CA 201FDC     8640     JSR J2DWN+Z
43CD            8650 EXIT
43CD 4C5FE4     8660     JMP $E45F
43D0            8670 J1UP
43D0 AC6DD9     8680     LDY YPOS0+Z
43D3 F012       8690     BEQ FINJ1UP
43D5 A210       8700     LDX #16
43D7            8710 LOOPJ1UP
43D7 B910DE     8720     LDA P0,Y
43DA 990EDE     8730     STA P0-2,Y
43DD C8         8740     INY
43DE CA         8750     DEX
43DF 10F6       8760     BPL LOOPJ1UP
43E1 CE6DD9     8770     DEC YPOS0+Z
43E4 CE6DD9     8780     DEC YPOS0+Z
43E7            8790 FINJ1UP
43E7 60         8800     RTS
43E8            8810 J2UP
43E8 AC6ED9     8820     LDY YPOS1+Z
43EB F012       8830     BEQ FINJ2UP
43ED A210       8840     LDX #16
43EF            8850 LOOPJ2UP
43EF B990DE     8860     LDA P1,Y
43F2 998EDE     8870     STA P1-2,Y
43F5 C8         8880     INY
43F6 CA         8890     DEX
43F7 10F6       8900     BPL LOOPJ2UP
43F9 CE6ED9     8910     DEC YPOS1+Z
43FC CE6ED9     8920     DEC YPOS1+Z
43FF            8930 FINJ2UP
43FF 60         8940     RTS
4400            8950 J1DWN
4400 AC6DD9     8960     LDY YPOS0+Z
4403 C050       8970     CPY #80
4405 F017       8980     BEQ FINJ1DWN
4407 98         8990     TYA
4408 18         9000     CLC
4409 690E       9010     ADC #14
440B A8         9020     TAY
440C A210       9030     LDX #16
440E            9040 LOOPJ1DWN
440E B90EDE     9050     LDA P0-2,Y
4411 9910DE     9060     STA P0,Y
4414 88         9070     DEY
4415 CA         9080     DEX
4416 10F6       9090     BPL LOOPJ1DWN
4418 EE6DD9     9100     INC YPOS0+Z
441B EE6DD9     9110     INC YPOS0+Z
441E            9120 FINJ1DWN
441E 60         9130     RTS
441F            9140 J2DWN
441F AC6ED9     9150     LDY YPOS1+Z
4422 C050       9160     CPY #80
4424 F017       9170     BEQ FINJ2DWN
4426 98         9180     TYA
4427 18         9190     CLC
4428 690E       9200     ADC #14
442A A8         9210     TAY
442B A210       9220     LDX #16
442D            9230 LOOPJ2DWN
442D B98EDE     9240     LDA P1-2,Y
4430 9990DE     9250     STA P1,Y
4433 88         9260     DEY
4434 CA         9270     DEX
4435 10F6       9280     BPL LOOPJ2DWN
4437 EE6ED9     9290     INC YPOS1+Z
443A EE6ED9     9300     INC YPOS1+Z
443D            9310 FINJ2DWN
443D 60         9320     RTS
443E            9330 OPEN
443E A9FF       9340     LDA #$FF
4440 8D4003     9350     STA $0340
4443 A210       9360     LDX #$10
4445 A903       9370     LDA #$03
4447 9D4203     9380     STA $0342,X
444A A9F9       9390     LDA # <DEVICE+Z
444C 9D4403     9400     STA $0344,X
444F A9DD       9410     LDA # >DEVICE+Z
4451 9D4503     9420     STA $0345,X
4454 A904       9430     LDA #$04
4456 9D4A03     9440     STA $034A,X
4459 A980       9450     LDA #$80
445B 9D4B03     9460     STA $034B,X
445E A90C       9470     LDA #$0C
4460 8DFC02     9480     STA 764
4463 2056E4     9490     JSR $E456
4466            9500 ZREAD
4466 202FD8     9510     JSR READ2+Z
4469 ADFCDD     9520     LDA FIN+Z
446C 2DFDDD     9530     AND FIN+1+Z
446F C9FF       9540     CMP #$FF
4471 D00F       9550     BNE SERABOOT?
4473 A973       9560     LDA # <$E474-1
4475 850C       9570     STA $0C
4477 A9E4       9580     LDA # >$E474-1
4479 850D       9590     STA $0D
447B A901       9600     LDA #$01
447D 8DF8DD     9610     STA FBOOT+Z
4480 D0E4       9620     BNE ZREAD
4482            9630 SERABOOT?
4482 ADE002     9640     LDA $02E0
4485 0DE102     9650     ORA $02E1
4488 D00C       9660     BNE RUNOK
448A ADFCDD     9670     LDA FIN+Z
448D 8DE002     9680     STA $02E0
4490 ADFDDD     9690     LDA FIN+1+Z
4493 8DE102     9700     STA $02E1
4496            9710 RUNOK
4496 ADF8DD     9720     LDA FBOOT+Z
4499 D003       9730     BNE NOESBOOT
449B 4C8EDD     9740     JMP ESBOOT+Z
449E            9750 NOESBOOT
449E ADFCDD     9760     LDA FIN+Z
44A1 8D4002     9770     STA $0240
44A4 ADFDDD     9780     LDA FIN+1+Z
44A7 8D4102     9790     STA $0241
44AA 202FD8     9800     JSR READ2+Z
44AD 38         9810     SEC
44AE ADFCDD     9820     LDA FIN+Z
44B1 ED4002     9830     SBC $0240
44B4 9D4803     9840     STA $0348,X
44B7 ADFDDD     9850     LDA FIN+1+Z
44BA ED4102     9860     SBC $0241
44BD 9D4903     9870     STA $0349,X
44C0 FE4803     9880     INC $0348,X
44C3 D003       9890     BNE NOCARRYY
44C5 FE4903     9900     INC $0349,X
44C8            9910 NOCARRYY
44C8 AD4002     9920     LDA $0240
44CB AC4102     9930     LDY $0241
44CE 203AD8     9940     JSR SETPOS+Z
44D1 ADE202     9950     LDA $02E2
44D4 0DE302     9960     ORA $02E3
44D7 F00B       9970     BEQ NOSUBRUTIN
44D9            9980 CONSUBRUTINA
44D9 20E7DC     9990     JSR USERSUB+Z
44DC A900       010000   LDA #$00
44DE 8DE202     010010   STA $02E2
44E1 8DE302     010020   STA $02E3
44E4            010030 NOSUBRUTIN
44E4 4C66DC     010040   JMP ZREAD+Z
44E7            010050 USERSUB
44E7 6CE202     010060   JMP ($02E2)
44EA            010070 CORREPROGRAMA
44EA A9FF       010080   LDA #$FF
44EC 8D01D3     010090   STA $D301
44EF 6CE002     010100   JMP ($02E0)
44F2            010110 INICIOBOOT
44F2 A9E2       010120   LDA #$00-30
44F4 8514       010130   STA 20
44F6            010140 WRELOS
44F6 AD0FD2     010150   LDA $D20F
44F9 2910       010160   AND #$10
44FB F0F5       010170   BEQ INICIOBOOT
44FD A514       010180   LDA 20
44FF D0F5       010190   BNE WRELOS
4501 A002       010200   LDY #$02
4503            010210 LEOLENTO
4503 2052D8     010220   JSR LEEMULA+Z
4506 99E003     010230   STA $03E0,Y
4509 88         010240   DEY
450A 10F7       010250   BPL LEOLENTO
450C ADE003     010260   LDA $03E0
450F CDE203     010270   CMP $03E2
4512 F015       010280   BEQ JUSTOAHORA
4514 CDE103     010290   CMP $03E1
4517 F010       010300   BEQ JUSTOAHORA
4519 ADE203     010310   LDA $03E2
451C CDE103     010320   CMP $03E1
451F F008       010330   BEQ JUSTOAHORA
4521            010340 LEYODISTINTO
4521 A903       010350   LDA #$03
4523 8DB2D8     010360   STA PONERC0+Z+1
4526 4C9FD8     010370   JMP BORRAMEM+Z
4529            010380 JUSTOAHORA
4529 A93C       010390   LDA #$3C
452B 8D02D3     010400   STA $D302
452E A227       010410   LDX #39
4530            010420 PROGRAMAENMEMORIA
4530 BD8CCE     010430   LDA CARGADO+SET,X
4533 9DC4CD     010440   STA MENSAJE+SET,X
4536 CA         010450   DEX
4537 10F7       010460   BPL PROGRAMAENMEMORIA
4539            010470 PRESIONOCAMBIO?
4539 AD1FD0     010480   LDA CONSOL
453C C906       010490   CMP #$06
453E D0F9       010500   BNE PRESIONOCAMBIO?
4540            010501 PRESIONOCAMBIO?2
4540 AD1FD0     010502   LDA CONSOL
4543 C907       010503   CMP #$07
4545 D0F9       010504   BNE PRESIONOCAMBIO?2
                010505 ; SUELTA START ANTES DE EMPEZAR
                010506 ;
                010507 ;
                010508 ;
                010509 ;
4547 A207       010510   LDX #$07
4549            010520 LLEVARAM
4549 BDEADC     010530   LDA CORREPROGRAMA+Z,X
454C 9D9203     010540   STA $0392,X
454F CA         010550   DEX
4550 10F7       010560   BPL LLEVARAM
4552            010570 JUSTO2
4552 AD0BD4     010580   LDA $D40B
4555 30FB       010590   BMI JUSTO2
4557 A95F       010600   LDA # <$E45F
4559 8D2202     010610   STA $0222
455C A9E4       010620   LDA # >$E45F
455E 8D2302     010630   STA $0223
4561 A900       010640   LDA #$00
4563 8D6F02     010650   STA 623
4566 A21F       010660   LDX #$1F
4568            010670 PMARGEN
4568 9D00D0     010680   STA $D000,X
456B CA         010690   DEX
456C 10FA       010700   BPL PMARGEN
456E A900       010710   LDA #$00
4570 8D4402     010720   STA $0244
4573 A902       010730   LDA #$02
4575 8509       010740   STA $09
4577 ADE002     010750   LDA $02E0
457A 8502       010760   STA $02
457C 850A       010770   STA $0A
457E ADE102     010780   LDA $02E1
4581 8503       010790   STA $03
4583 850B       010800   STA $0B
4585 A50D       010810   LDA $0D
4587 48         010820   PHA
4588 A50C       010830   LDA $0C
458A 48         010840   PHA
458B            010850 SINRESET
458B 4C9203     010860   JMP $0392
458E            010870 ESBOOT
458E ADFCDD     010880   LDA FIN+Z
4591 8D4002     010890   STA $0240
4594 ADFDDD     010900   LDA FIN+1+Z
4597 8D4102     010910   STA $0241
459A 202FD8     010920   JSR READ2+Z
459D 18         010930   CLC
459E ADFCDD     010940   LDA FIN+Z
45A1 6906       010950   ADC #$06
45A3 8504       010960   STA $04
45A5 ADFDDD     010970   LDA FIN+1+Z
45A8 6900       010980   ADC #$00
45AA 8505       010990   STA $05
45AC 202FD8     011000   JSR READ2+Z
45AF ADFCDD     011010   LDA FIN+Z
45B2 850C       011020   STA $0C
45B4 ADFDDD     011030   LDA FIN+1+Z
45B7 850D       011040   STA $0D
45B9 A006       011050   LDY #$06
45BB            011060 MULTIPLICA
45BB 0E4102     011070   ASL $0241
45BE 2E4002     011080   ROL $0240
45C1 88         011090   DEY
45C2 10F7       011100   BPL MULTIPLICA
45C4 AD4002     011110   LDA $0240
45C7 9D4903     011120   STA $0349,X
45CA AD4102     011130   LDA $0241
45CD 9D4803     011140   STA $0348,X
45D0 A504       011150   LDA $04
45D2 9D4403     011160   STA $0344,X
45D5 8DE002     011170   STA $02E0
45D8 A505       011180   LDA $05
45DA 9D4503     011190   STA $0345,X
45DD 8DE102     011200   STA $02E1
45E0 A907       011210   LDA #$07
45E2 9D4203     011220   STA $0342,X
45E5 2056E4     011230   JSR $E456
45E8 38         011240   SEC
45E9 A50C       011250   LDA $0C
45EB E901       011260   SBC #$01
45ED 850C       011270   STA $0C
45EF A50D       011280   LDA $0D
45F1 E900       011290   SBC #$00
45F3 850D       011300   STA $0D
45F5 4CF2DC     011310   JMP INICIOBOOT+Z
45F8            011320 FBOOT
45F8 00         011330   .BYTE 0
45F9            011340 DEVICE
45F9 433A9B     011350   .BYTE "C:",$9B
45FC            011360 FIN
45FC            011370   .END