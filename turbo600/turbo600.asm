    ICL '../sys_turbo/sistema.asm'
    ICL '../sys_turbo/macros.asm'
    ICL '../sys_turbo/romram.asm'
    ICL '../sys_turbo/pal.asm'
;************
;* TENIS 01 *
;************
TURBO = $B3
    ORG $D301
    .BYTE $FE
    ORG $BC20
    .BYTE 1
    .WORD NEWDL
VOLVERE
    ORG $BB00
NEWDL
    .BYTE $70,$70,$42  ;112,112,66
    .WORD LINE0
    .BYTE $30,$01   ;48,1
    .WORD VOLVERE
LINE0
    .SB +128,"  CON "
    .SB "S"
    .SB +128,"ubrutina    C-"
C?
    .SB +128,"000 SIN "
    .SB "R"
    .SB +128,"eset  "
MENSAJE.TV
    .SB +128,"    "
CON .SB +128,"CON"
SIN .SB +128,"SIN"
SECTOR  .BY "000",$9B
FACTOR  .BY "2.3",$9B

;****** 8000 ******
    ORG $8000
MENSAJE.NTSC
    .SB +128,"NTSC"
MENSAJE.PAL
    .SB +128,"PAL "
EORBYTE .BY $00
BYTEMULA .BY $00
CANTR .WORD $4000
CANTW .WORD $4000
LASTCANT .WORD $4000
DESDE = $0C
HASTA = $0E
FRO =   $D4
RAM =   $CB
ROM =   $CD
FEOR .BY 0
FEOF .BY 0
BANCO .BY 0
GUARDABANCO .BY 0
SUB
    JSR USERSUB+Z
SINRES
    JMP $0392
CONRES
    JMP ($FFFC)
SET =   PROGRAMA-RAMPROG
STRING
    .BY 'D1:'
NOMBRE
    .SB "                    "

PABONITO
    .SB "000  BLOQUES A GRABAR "
GRABAMULA
    LDX #$08
    LDY PALNTS
    BEQ GRABAMULA.1
    DEX
GRABAMULA.1
    JSR GRABAMULA.WAIT
    LDA #$8B
    STA $D20F
    LDX #$08
    LDY PALNTS
    BEQ GRABAMULA.2
    DEX
GRABAMULA.2
    JSR GRABAMULA.WAIT
    LDA #$0B
    STA $D20F
    LDX #$10
    LDY PALNTS
    BEQ GRABAMULA.3
    LDX #$0D
GRABAMULA.3
    JSR GRABAMULA.WAIT
    LDA #$8B
    STA $D20F
    LDX #$2F
    LDY PALNTS
    BEQ GRABAMULA.4
    LDX #$27
GRABAMULA.4
    JSR GRABAMULA.WAIT
    LDA #$0B
    STA $D20F
    RTS
GRABAMULA.WAIT
    JSR LINEA10?
    DEX
    BNE GRABAMULA.WAIT
    RTS
;
; ESPERA X BARRIDOS
;
;
LINEA10?
    LDA $D40B
    CMP #$0A
    BNE LINEA10?
    STA $D40A
    STA $D40A
    RTS
EOREO
    LDY #$00
    LDA (DESDE),Y
    EOR EORBYTE
    STA (DESDE),Y
    INC DESDE
    BNE NOINCDESDE1
    INC DESDE+1
NOINCDESDE1
    LDA DESDE+1
    CMP HASTA+1
    BNE EOREO
    LDA DESDE
    CMP HASTA
    BNE EOREO
    RTS
BANQUEO
    ORA #$08
    CLC
    ROL
    ROL
    PHA
    LDA #$C3
    AND $D301
    STA $D301
    PLA
    ORA $D301
    AND #$FE
    STA $D301
    RTS
SUBCLOSE
     CLOSE  1
    RTS
SUBOPEN
    LDX #$10
    LDA #$03
    STA ICCOM,X
    LDA #$04
    STA ICAUX1,X
    LDA #$80
    STA ICAUX2,X
    LDA #<STRING
    STA ICBADR,X
    LDA #>STRING
    STA ICBADR+1,X
    JSR CIO
    BPL OPENOK
    JSR SUBCLOSE
    JSR SUBDIRECTORIO
    JMP SUBOPEN
OPENOK
    RTS
SUBBGET
     BGET  1,$4000,CANTR
    RTS
SUBREAD
    JSR SUBOPEN
    LDA #$04
    STA BANCO
LOOPBANCOS
    DEC BANCO
    LDA BANCO
    JSR BANQUEO
    JSR SUBBGET
    LDA 856
    CMP CANTR
    BNE FINCARGA
    LDA 857
    CMP CANTR+1
    BEQ LOOPBANCOS
FINCARGA
    LDA BANCO
    STA GUARDABANCO
    LDA 856
    STA LASTCANT
    STA FRO
    LDA 857
    STA LASTCANT+1
    STA FRO+1
    LDX #$02
    LDA #$90    ;'0-32'
VUELVEA0
    STA PABONITO,X
    LDY FEOR
    BEQ NOEORFF
    EOR #$FF
NOEORFF
    STA TENMEBLK,X
    DEX
    BPL VUELVEA0
    LDX #$03
CALCULOASC
    CPX GUARDABANCO
    BEQ NOFINCALCULO
    CLC
    LDA FRO
    ADC CANTR
    STA FRO
    LDA FRO+1
    ADC CANTR+1
    STA FRO+1
    DEX
    BPL CALCULOASC
NOFINCALCULO
    LDY #$01
    LDA FRO
    AND #$7F
    BEQ FINCALCULO
    INY
FINCALCULO
    LDX #$06
LOOPFINCALCULO
    LSR FRO+1
    ROR FRO
    DEX
    BPL LOOPFINCALCULO
    CLC
    TYA
    ADC FRO
    STA FRO
    LDA FRO+1
    ADC #$00
    STA FRO+1
    JSR $D9AA
    JSR $D8E6
    LDY #$00
LOOPPOSITIVO
    LDA ($F3),Y
    BMI ESNEGATIVO
    INY
    BPL LOOPPOSITIVO
ESNEGATIVO
    SEC
    SBC #32
    STA PABONITO+2
    LDX FEOR
    BEQ NOEORFF1
    EOR #$FF
NOEORFF1
    STA TENMEBLK+2
    DEY
    BMI NOQUEDANMAS
    LDA ($F3),Y
    ORA #$80
    SEC
    SBC #32
    STA PABONITO+1
    LDX FEOR
    BEQ NOEORFF2
    EOR #$FF




;revisar desde acá
NOEORFF2
    STA TENMEBLK+1
    DEY
    BMI NOQUEDANMAS
    LDA ($F3),Y
    EOR #$80
    SEC
    SBC #32
    STA PABONITO
    LDX FEOR
    BEQ NOEORFF3
    EOR #$FF
NOEORFF3
    STA TENMEBLK
NOQUEDANMAS
    JMP SUBCLOSE
SUBDIRECTORIO
    LDA #$7D    ;'}'
    JSR PRINTBYTE
     ;OPEN  1,6,0,"D:*.*"
DIRECTORIO
     ;INPUT  1,NOMBRE
    BMI FINDIRECTORIO
     PRINT  0,NOMBRE
    JMP DIRECTORIO
FINDIRECTORIO
    JSR SUBCLOSE
    LDA #$9B
    JSR PRINTBYTE
    LDA #$9B
    JSR PRINTBYTE
     PRINT  0,"  ELIJA FILE A GRABAR!"
    LDA #$FF
    JSR BANQUEO
    LDX #19
    LDA #$00
SINNOMBRE
    STA NOMBRE,X
    DEX
    BPL SINNOMBRE
TOMEFILE
    LDA $58
    STA $00
    LDA $59
    STA $01
INVIERTA
    JSR INVERSO
QUEAPRETO?
    LDA #$FF
    STA 764
WTECLA
    LDA 764
    CMP #$FF
    BEQ WTECLA
    CMP #28
    BNE NOOTRO
    RTS
NOOTRO
    CMP #62
    BNE NOCSUB
    LDX #$00
    LDY #$02
    LDA LINE0,Y
    CMP #$A3    ;'C-32'
    BEQ PONSINSUB
PONCONSUB
    LDA CON,X
    STA LINE0,Y
    LDA SUB,X
    BIT FEOR
    BEQ NOEOR29A
    EOR #$29
NOEOR29A
    STA CONSUBRUTINA,X
    INY
    INX
    CPX #$03
    BNE PONCONSUB
    BEQ QUEAPRETO?
PONSINSUB
    LDA SIN,X
    STA LINE0,Y
    LDA #$EA
    BIT FEOR
    BEQ NOEOR29B
    EOR #$29
NOEOR29B
    STA CONSUBRUTINA,X
    INY
    INX
    CPX #$03
    BNE PONSINSUB
    BEQ QUEAPRETO?
NOCSUB
    CMP #40
    BNE NOCRES
    LDX #$00
    LDY #$19
    LDA LINE0,Y
    CMP #$A3    ;'C-32'
    BEQ PONSINRES
PONCONRES
    LDA CON,X
    STA LINE0,Y
    LDA CONRES,X
    BIT FEOR
    BEQ NOEOR29C
    EOR #$29
NOEOR29C
    STA SINRESET,X
    INY
    INX
    CPX #$03
    BNE PONCONRES
    JMP QUEAPRETO?
PONSINRES
    LDA SIN,X
    STA LINE0,Y
    LDA SINRES,X
    BIT FEOR
    BEQ NOEOR29D
    EOR #$29
NOEOR29D
    STA SINRESET,X
    INY
    INX
    CPX #$03
    BNE PONSINRES
    JMP QUEAPRETO?
NOCRES
    CMP #$0F    ;15
    BNE NOUPALE
    JSR INVERSO
    CLC
    LDA $00
    ADC #40
    STA $00
    LDA $01
    ADC #$00
    STA $01
    LDY #$03
    LDA ($00),Y
    BEQ NOTOMEFIL
    JMP TOMEFILE
NOTOMEFIL
    JMP INVIERTA
NOUPALE
    CMP #14
    BNE NOBAJALE
    JSR INVERSO
    LDA $00
    CMP $58
    BNE BAJE
    LDA $01
    CMP $59
    BNE BAJE
    JMP TOMEFILE
BAJE
    SEC
    LDA $00
    SBC #40
    STA $00
    LDA $01
    SBC #$00
    STA $01
    JMP INVIERTA
NOBAJALE
    CMP #12
    BEQ ELCOK
    JMP QUEAPRETO?
ELCOK
    JSR INVERSO
    LDY #$04
    LDX #$00
ESTAFILE
    LDA ($00),Y
    BEQ PUNTO
    CLC
    ADC #$20
    STA NOMBRE,X
    INX
    INY
    CPY #$0C
    BNE ESTAFILE
PUNTO
    LDY #$0C
    LDA #$2E    ;'.'
    STA NOMBRE,X
    INX
LOPUNTO
    LDA ($00),Y
    BEQ FINPUNTO
    CLC
    ADC #$20
    STA NOMBRE,X
    INX
    INY
    CPY #$0F
    BNE LOPUNTO
FINPUNTO
    RTS
INVERSO
    LDY #$0F
LOINVIERTO
    LDA ($00),Y
    EOR #$80
    STA ($00),Y
    DEY
    CPY #$03
    BNE LOINVIERTO
    LDY #$02
    LDA #$90 ;'0-32'
BORREC
    STA C?,Y
    DEY
    BPL BORREC
    LDY #$10
    LDX #$00
TOMENUM
    LDA ($00),Y
    CLC
    ADC #$20
    STA SECTOR,X
    INY
    INX
    CPX #$03
    BNE TOMENUM
    LDA # <FACTOR
    STA $F3
    LDA # >FACTOR
    STA $F4
    LDA #$00
    STA $F2
    JSR $D800
    BCC NOC1000
    JMP C1000?
NOC1000
    JSR $DDB6
    LDA # <SECTOR
    STA $F3
    LDA # >SECTOR
    STA $F4
    LDA #$00
    STA $F2
    JSR $D800
    BCS C1000?
    JSR $DADB
    BCS C1000?
    JSR $DDB6
    LDA #87
    STA $D4
    LDA #$00
    STA $D5
    JSR $D9AA
    JSR $DA66
    JSR $DDB6
    LDA #30
    STA $D4
    LDA #$00
    STA $D5
    JSR $D9AA
    LDY #$05
FR1FR0
    LDA $D4,Y
    PHA
    LDA $E0,Y
    STA $D4,Y
    PLA
    STA $E0,Y
    DEY
    BPL FR1FR0
    JSR $DB28
    BCS C1000?
    JSR $D9D2
    BCS C1000?
    INC $D4
    BNE NOINCD5
    INC $D5
NOINCD5
    JSR $D9AA
    JSR $D8E6
    LDY #$00
ESASC?
    LDA ($F3),Y
    BMI FINASC
    INY
    BNE ESASC?
FINASC
    LDA ($F3),Y
    SEC
    SBC #32
    STA C?+2
    DEY
    BMI C1000?
    LDA ($F3),Y
    SEC
    SBC #32
    ORA #$80
    STA C?+1
    DEY
    BMI C1000?
    LDA ($F3),Y
    SEC
    SBC #32
    ORA #$80
    STA C?
C1000?
    RTS
NO.IRG
    LDX #$04
    LDA #$EA    ;NOP
NO.IRG.LOOP
    STA $EBC6,X
    DEX
    BPL NO.IRG.LOOP
    RTS
SI.IRG
    LDX #$04
SI.IRG.LOOP
    LDA SI.IRG.TABLA,X
    STA $EBC6,X
    DEX
    BPL SI.IRG.LOOP
    RTS
SI.IRG.TABLA
    .BYTE $AD,$17,$03,$D0,$FB
IRG.100
    LDA #$06
    STA $EE11
    STA $EE15
    LDA #$05
    STA $EE12
    STA $EE16
    RTS
INICIOPROGRAMA
    LDA #$00
    STA FEOR
    LDA #$FE
    STA $D301
    STA $0244
    LDA #112
    STA 16
    STA 53774
    LDA #$03
    STA $FE8D
    LDA #$02
    STA $FE8E
    LDA #$0C
    STA $FE8F
    LDA #$8A
    STA $FE90
; QUEDAMOS CON IRG DE 14 SEGUNDOS
;   LDA #$EA
;   STA 64881
;   STA 64882
    JSR IRG.100
;
; IRG CORTO DE 100 MILISEGUNDOS
;
    LDA #$60
    STA 65020   ; NO BEEP BEEP!
    LDA #$34
    STA $FDD7   ; NO APAQUE MOTOR!
    LDA #$00
    STA 710
    LDA #1
    STA 752
    JSR DETECTA.PAL ;A DETECTAR PAL!
    LDX #$03
INICIOPROGRAMA.LOOP
    LDA MENSAJE.NTSC,X
    LDY PALNTS
    BEQ INICIOPROGRAMA.LOOP2
    LDA MENSAJE.PAL,X
INICIOPROGRAMA.LOOP2
    STA MENSAJE.TV,X
    DEX
    BPL INICIOPROGRAMA.LOOP
;   LDX #4
;   LDA #$EA
;LOOPIRG1
;   STA $EBC6,X
;   DEX
;   BPL LOOPIRG1
    JSR NO.IRG
    LDA #TURBO
    STA $CF
CAMBIADISCO
     PRINT  0,$7D + "  INGRESE DISCO CON FILE A GRABAR"
    LDA #$FF
    STA 764
    JSR GETBYTE
    JSR SUBDIRECTORIO
    JSR SUBREAD
OTRACOPIA
     PRINT  0,$7D + "   RETURN PARA COMENZAR GRABACION"
    LDY #130
    LDX #0
LOOPBONITO
    LDA PABONITO,X
    STA ($58),Y
    INY
    INX
    CPX #21
    BNE LOOPBONITO
    LDY #216
    LDX #$00
BELLO
    LDA NOMBRE,X
    SEC
    SBC #$20
    BMI FINBELISIMO
    STA ($58),Y
    INY
    INX
    BNE BELLO
FINBELISIMO
    LDA #$FF
    STA 764
    JSR GETBYTE
    CMP #$1B    ;'?'
    BNE NOCAMBIADISCO
    JMP CAMBIADISCO
NOCAMBIADISCO
    LDA #$7D    ;'}'
    JSR $F2B0
    LDY #215
    LDX #$00
NUMEROSCREEN
    LDA PABONITO,X
    STA ($58),Y
    INY
    INX
    CPX #$03
    BNE NUMEROSCREEN
    INY
NOMBRESCREEN
    LDA STRING,X
    SEC
    SBC #$20
    BMI ENDNAME
    STA ($58),Y
    INX
    INY
    BNE NOMBRESCREEN
ENDNAME
    LDX #$08
NUEVEBLKS
    LDY #217
NUEVEBLKS1
    LDA ($58),Y
    CLC
    ADC #$01
    CMP #$9A    ;'9-31'
    BEQ NUEVE9
    STA ($58),Y
    DEX
    BPL NUEVEBLKS
    BMI FINNUEVE
NUEVE9
    LDA #$90    ;'0-32'
    STA ($58),Y
    DEY
    CPY #214
    BNE NUEVEBLKS1
FINNUEVE
    LDA #$FF
    JSR BANQUEO
    LDA #$D0
    STA $FD71
    LDA #$F7
    STA $FD72   ; HABILITA LEAD
    JSR GRABABLKUNO
    LDA #$EA
    STA $FD71
    STA $FD72   ; DESHABILITA LEAD
    LDA #$2E    ;$00-210
    LDX PALNTS
    BEQ BLKUNO.NTSC
    LDA #$51    ;$00-175
BLKUNO.NTSC
    STA 20
BLKUNO.LOOP
    LDA 20
    BNE BLKUNO.LOOP
    LDA #$00
    STA 20
    STA $0480
    STA $0481
    STA FEOF
    LDA # <(FIN-GAMEA)
    STA CANTW
    LDA # >(FIN-GAMEA)
    STA CANTW+1
    JSR WRITETOCASSETTE
    LDA #$64    ;$00-156
    LDX PALNTS
    BEQ BLK2.NTSC
    LDA #$7E    ;$00-130
BLK2.NTSC
    STA 20
W1SEG
    LDA 20
    BNE W1SEG
    LDA #$10
    STA 20
    LDA #1
    STA FEOF
    LDA CANTR
    STA CANTW
    LDA CANTR+1
    STA CANTW+1
    LDA #$04
    STA BANCO
    JSR WRITETOCASSETTE
    LDA #$CC    ;$00-52
    LDY PALNTS
    BEQ LOPLEAD1.NTSC
    LDA #$D5    ;$00-43
LOPLEAD1.NTSC
    STA 20
LOPLEAD1
    LDA 20
    BNE LOPLEAD1
    LDY #$02
SAVEC0LENTO
    TYA
    PHA
    LDA #$C0
    JSR GRABAMULA
    PLA
    TAY
    DEY
    BPL SAVEC0LENTO
    LDA #10
    STA 20
FINAL.LOOP
    LDA 20
    BNE FINAL.LOOP
; LE DAMOS TIEMPO PARA QUE CIERRE EL ARCHIVO.
;
    LDA #$3C
    STA $D302
    JMP OTRACOPIA
WRITETOCASSETTE
    JSR $FD34
LEADERTIME
    LDA 20
    CMP #$20
    BCC LEADERTIME
    LDA FEOF
    BEQ NOLASTBANCO
GRABANDOP02
    DEC BANCO
    LDA BANCO
    PHA
    JSR BANQUEO
    PLA
    CMP GUARDABANCO
    BNE NOLASTBANCO
    LDA LASTCANT
    STA CANTW
    LDA LASTCANT+1
    STA CANTW+1
    LDA #$FF
    STA FEOF
NOLASTBANCO
    LDA # <$4000
    STA $00
    LDA # >$4000
    STA $01
    LDA #$00
    STA $02
    STA $03
WRITECASSETTE
    LDA $D01F
    CMP #$03
    BNE SIGAGRBANDO
    JMP $FDD6
SIGAGRBANDO
    JSR SI.IRG
    LDY #$00
    LDA ($00),Y
    JSR $FDB4
    BNE NONUEVOBLK
    JSR NO.IRG
    LDY #135
BUFSCREEN
    LDA $03FF,Y
    STA ($58),Y
    DEY
    BNE BUFSCREEN
    LDY #217
    LDX #$02
DECBELLO
    LDA ($58),Y
    SEC
    SBC #$01
    CMP #$8F    ;'0-33'
    BEQ NINEBELLO
    STA ($58),Y
    BNE FINBELLO
NINEBELLO
    LDA #$99    ;'9-32'
    STA ($58),Y
    DEY
    DEX
    BPL DECBELLO
FINBELLO
    INC $0480
    BNE NONUEVOBLK
    INC $0481
NONUEVOBLK
    INC $00
    BNE NOINCHIBIS
    INC $01
NOINCHIBIS
    INC $02
    BNE NOINCHIS
    INC $03
NOINCHIS
    LDA $03
    CMP CANTW+1
    BNE WRITECASSETTE
    LDA $02
    CMP CANTW
    BNE WRITECASSETTE
    LDA FEOF
    BEQ FINP01
    BMI FINP01
    JMP GRABANDOP02
FINP01
    LDX $3D
    BEQ TERMINOWRITE
    LDY #$7F
POKEANDOESPERO
    STY $D40A
    DEY
    BNE POKEANDOESPERO
    STX $047F
    LDA #$FA
    JSR $FE7C
TERMINOWRITE
    INC $0480
    BNE NOINC481
    INC $0481
NOINC481
    LDA FEOF
    BNE SIEOF
    JMP $FDD6
SIEOF
    LDX #$7F
    LDA #$00
FILLBUFFER
    STA $0400,X
    STA $D40A
    DEX
    BPL FILLBUFFER
    LDA #$FE
    JSR $FE7C
    JMP $FDD6
    RUN INICIOPROGRAMA
EORLEN = FINFIRST-AEOREAR+1
ADR =   $0380-3
RESTABYTE = $03FF
DIF =   $A000-ADR
    ORG  ADR+DIF
AGRABAR
    .BYTE $55,$55
    .BYTE $FA
BLKUNO
    .BYTE $00
    .BYTE $01
    .WORD $0380 ;.WORD *-2-DIF
    .WORD $E456
    LDX #EORLEN
    TXS
EORLOOP
    SEC
    LDA AEOREAR-DIF,X
    TAY
    SBC RESTABYTE
    STY RESTABYTE
    PHA
    DEX
    BPL EORLOOP
    RTS
AEOREAR
    .BYTE $01
    .BYTE $01
    LDX #$01
    STX $0244
    DEX
    STX $022F
    STX $D400
    STX $41
RELOS
    LDX #$EC    ;$00-20
    STX 20
ESPERASINCRO
    LDA $D20F
    AND #$10
    BNE RELOS
    LDX 20
    BNE ESPERASINCRO
TERMINA0
    LDA $D20F
    AND #$10
    BEQ TERMINA0
    LDX #$0B
TRANSFER
    LDA DATIX1-DIF,X
    STA $0300,X
    DEX
    BPL TRANSFER
    JSR $E459
    LDX #$FF
    TXS
    JMP ($0304)
FINFIRST
    PLA
    RTI
DATIX1
    .BYTE $60
    .BYTE $00
    .BYTE $52
    .BYTE $40
    .WORD BLKFALSO
    .BYTE $23
    .BYTE $00
    .WORD FINBLKFALSO-BLKFALSO
    .BYTE $00
    .BYTE $80

    ORG  $03EA+DIF
    .BYTE $00

    ORG  AGRABAR+$84
GRABABLKUNO
    LDA FEOR
    BEQ EORNOLISTO
    JMP EORLISTO
EORNOLISTO
    LDA # <EORBLOCK
    STA DESDE
    LDA # >EORBLOCK
    STA DESDE+1
    LDA # <FINBLKFALSO
    STA HASTA
    LDA # >FINBLKFALSO
    STA HASTA+1
    LDA #$46
    STA EORBYTE
    JSR EOREO
    LDA # <EORBLOCK1
    STA DESDE
    LDA # >EORBLOCK1
    STA DESDE+1
    LDA # <FINBLKDOS
    STA HASTA
    LDA # >FINBLKDOS
    STA HASTA+1
    LDA #$FF
    STA EORBYTE
    JSR EOREO
    LDA # <GAME1A
    STA DESDE
    LDA # >GAME1A
    STA DESDE+1
    LDA # <FIN
    STA HASTA
    LDA # >FIN
    STA HASTA+1
    LDA #$29
    STA EORBYTE
    JSR EOREO
    LDX #EORLEN
    STX FEOR
EORLOOP1
    CLC
    LDA AEOREAR,X
    ADC SUMABYTE
    STA SUMABYTE
    STA AEOREAR,X
    DEX
    BPL EORLOOP1
    LDA #0
    STA CHKSUM
    LDX #$82
    LDA #$01
    STA AGRABAR,X
ADCHKSUM
    LDA AGRABAR,X
    CLC
    ADC CHKSUM
    ADC #0
    STA CHKSUM
    DEX
    CMP #$FF
    BNE ADCHKSUM
    LDX #$83
    STA BLKUNO,X
EORLISTO
    JSR $FD34   ; GRABA LEADER
    CLC
    LDA #100
    LDX PALNTS
    BEQ LEADER.NTSC
    LDA #83
LEADER.NTSC
    ADC 20
WLEADERTIME
    CMP 20
    BNE WLEADERTIME
    LDX #$0B
?LOOP
    LDA DATA1,X
    STA $0300,X
    DEX
    BPL ?LOOP
    JSR $E459   ; GRABA PRIMER BLOQUE
    CLC
    LDA #$0F    ; 0.25 SEC NTSC
    LDX PALNTS
    BEQ PRIMERBLOQUE.NTSC
    LDA #$0C    ; 0.25 SEC PAL
PRIMERBLOQUE.NTSC
    ADC 20
ESPERIX
    CMP 20
    BNE ESPERIX
    JSR GRABATRAMPA
    CLC
    LDA 20
    ADC #$0F
WFALSO
    CMP 20
    BNE WFALSO
    LDX #$0B
SAVEFALSO
    LDA DATAFALSA,X
    STA $0300,X
    DEX
    BPL SAVEFALSO
    JSR $E459
    CLC
    LDA #40
    LDX PALNTS
    BEQ WFORIRGTIME.NTSC
    LDA #33
WFORIRGTIME.NTSC
    ADC 20
WFORIRGTIME
    CMP 20
    BNE WFORIRGTIME
    LDX #$0B
?LOOP1
    LDA DATA2,X
    STA $0300,X
    DEX
    BPL ?LOOP1
    JSR $E459
    LDA #$34
    STA 54018
    RTS
CHKSUM
    .BYTE 0
DATA1
    .BYTE $60,0,$57,$80
    .WORD AGRABAR
    .BYTE $23,0
    .WORD $83
    .BYTE 0,$80
DATA2
    .BYTE $60,0,$57,$80
    .WORD BLKDOS
    .BYTE $23,0
    .WORD FINBLKDOS-BLKDOS
    .BYTE 0
    .BYTE $80
DATAFALSA
    .BYTE $60,0,$57,$80
    .WORD BLKFALSO
    .BYTE $23,0
    .WORD FINBLKFALSO-BLKFALSO
    .BYTE 0,$80
SUMABYTE
    .BYTE $FA
    ORG  $7000-4
TRAMPA
    .BYTE $55,$55,$FC
    .BYTE $01
    .WORD $7000
    .WORD $E456
    LDA #$00
    LDY #$02
    STA ($58),Y
    STA 710
    STA $41
    LDX #$10
    LDA #$03
    STA $02EC,X
    STA $0342,X
    LDA #$04
    STA $034A,X
    LDA #$80
    STA $034B,X
    LDA # <$C431
    STA $0344,X
    LDA # >$C431
    STA $0345,X
    JSR $E456
    LDA #$00
    STA $0344,X
    STA $0348,X
    LDA #$07
    STA $0345,X
    LDA #$06
    STA $0349,X
    LDA #$07
    STA $0342,X
    JSR $E456
    DEY
LOOPTRAMPA
    LDA $0700,Y
    EOR $0800,Y
    STA $0700,X
    DEY
    BNE LOOPTRAMPA
    LDA # <DLTRAMPA+2
    STA 560
    LDA # >DLTRAMPA+2
    STA 561
    JMP $0700
DLTRAMPA
    .BYTE 112,112,112,64+6
    .WORD TEXTOTRAMPA+2
    .BYTE 65
TEXTOTRAMPA
    .SB "    turbo SOFTWARE    "
    ORG  $707F
CHEQUEO
    .BYTE 0
FCHK
    .BYTE 0
GRABATRAMPA
    LDA FCHK
    BNE CHEQUEOK
    INC FCHK
    LDA #$00
    STA CHEQUEO
    LDX #$82
CHKTRAMPA
    LDA TRAMPA,X
    CLC
    ADC #$00
    ADC CHEQUEO
    STA CHEQUEO
    DEX
    CPX #$FF
    BNE CHKTRAMPA
    LDX #$83
    STA TRAMPA,X
CHEQUEOK
    LDX #$0B
LOOPTRAMPIX
    LDA DATATRAMPA,X
    STA $0300,X
    DEX
    BPL LOOPTRAMPIX
    JSR $E459
    CLC
    LDA #$0F
    LDX PALNTS
    BEQ TRAMPA.NTSC
    LDA #$0C
TRAMPA.NTSC
    ADC 20
ESPERATRAMPA
    CMP 20
    BNE ESPERATRAMPA
    LDA #$83
    STA $FE48   ; BLOQUE DE 131 BYTES (ESTANDAR ATARI)
    JSR $FDEA   ; GRABA EOF
    LDA #133
    STA $FE48   ; AGREGA 2 BYTES BLOQUE (PARA AGREGAR CONTADOR)
    LDA #139
    STA $D20F
    LDX #$28    ; VALOR ORIGINAL: 4
    LDY PALNTS
    BEQ LOOPLINEA.NTSC
    LDX #$21
LOOPLINEA.NTSC
    LDY $D40B
LOOPLINEA
    CPY $D40B
    BEQ LOOPLINEA
WLINE
    CPY $D40B
    BNE WLINE
    DEX
    BPL LOOPLINEA.NTSC
    LDA #11
    STA $D20F
    RTS
DATATRAMPA
    .BYTE $60,$00,$57,$80
    .WORD TRAMPA
    .BYTE $23,$00
    .WORD $83
    .BYTE $00,$80


    ORG  $2000
BLKFALSO
    .BYTE $55,$55
    TYA
    BPL BLOCKOK
    LDA #34
    STA 559
    JSR $EDC7
    JMP $C8FC
BLOCKOK
    LDA EORBLOCK
    EOR #$46
    STA EORBLOCK
    INC BLOCKOK+6
    INC BLOCKOK+1
    BNE NOINCBLOCK2
    INC BLOCKOK+7
    INC BLOCKOK+2
NOINCBLOCK2
    LDA BLOCKOK+2
    CMP # >FINBLKFALSO
    BNE BLOCKOK
    LDA BLOCKOK+1
    CMP # <FINBLKFALSO
    BNE BLOCKOK
EORBLOCK
    LDA #$00
    STA 710
    LDA #$FF
    STA $D301
    JSR ROMARAM
    LDA #34
    STA 559
    STA $D400
    LDA # <DL
    STA 560
    LDA # >DL
    STA 561
LINEAPOSITIVA
    LDY $D40B
    BMI LINEAPOSITIVA
    LDA #$FF
    STA $50
    LDA # <MUS
    STA $0222
    LDA # >MUS
    STA $0223
    LDX #$0B
CARGALASTBLOCK
    LDA DATALAST,X
    STA $0300,X
    DEX
    BPL CARGALASTBLOCK
    LDA #$FF-2
    STA 20
WVBI
    LDA 20
    BNE WVBI
    LDY #19
CHECKTURBO
    CLC
    LDA DATA,Y
    ADC BITLOCO+1
    ADC #$00
    STA BITLOCO+1
    DEY
    BPL CHECKTURBO
BITLOCO
    LDA #$00
    SEC
    SBC #$9A
    BMI NODIO
    BEQ SIDIO
    BPL NODIO
SIDIO
    JSR $E459
NODIO
    JMP ($0304)
MUS
    LDA #$82
    STA $D203
    DEC SCUIS
    LDA SCUIS
    BNE NO0SCUIS
    LDA #120
    STA SCUIS
NO0SCUIS
    STA $D202
    DEC VOLUME
    LDA VOLUME
    STA $D201
    CMP #$A2
    BNE FINMUS
    LDA #$AA
    STA VOLUME
    INC QUENOTA
    LDX QUENOTA
    LDA TONOS,X
    CMP #$FF
    BNE NOFINMUS
    LDA #23
    STA QUENOTA
    JMP MUS
NOFINMUS
    STA $D200
FINMUS
    LDA PALNTS
    BEQ FINMUS.FIN
    DEC FINMUS.CONTADOR
    BNE FINMUS.FIN
    LDA #6
    STA FINMUS.CONTADOR
    BNE MUS
FINMUS.FIN
    JMP $E45F
FINMUS.CONTADOR
    .BYTE 6
VOLUME  .BYTE $AA
SCUIS   .BYTE 130
QUENOTA .BYTE 0
TONOS
    .BYTE 0,0,0,0,0,0,0,0,0,0,0,0
    .BYTE 0,0,0,0,0,0,0,0,0,0,0,0
    .BYTE 162,81,81,81,81,81,91,81,81,81,81,81
    .BYTE 102,81,81,81,81,81,108,81,81,81,81,81
    .BYTE 121,81,81,81,81,81,121,91,136,102,144,108
    .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
    .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
    .BYTE 204,144,217,162,243,204,243,182,217,162,204,217
    .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
    .BYTE 162,121,144,108,136,102,144,108,162,121,182,136
    .BYTE 108,0,108,108,0,121,0,0,0,0,0,0
    .BYTE 136,0,136,136,0,144,0,0,0,0,0,0
    .BYTE 162,0,162,0,162,0,144,0,144,0,144,0
    .BYTE 136,0,136,0,144,0,162,0,0,0,0,0
    .BYTE 108,0,108,108,0,121,0,0,0,0,0,0
    .BYTE 136,0,136,136,0,144,0,0,0,0,0,0
    .BYTE 162,0,162,0,0,162,144,0,144,0,0,144
    .BYTE 136,0,136,144,0,162,0,0,0,0,0,0,$FF
DATALAST
    .BYTE $60
    .BYTE $00
    .BYTE $52
    .BYTE $40
    .WORD BLKDOS
    .BYTE $23
    .BYTE $00
    .WORD FINBLKDOS-BLKDOS
    .BYTE $00
    .BYTE $80
DL
    .BYTE 112,112,112,64+6
CAMBIO1
    .WORD DATA
    .BYTE 112,112,112,112,112,112,112,112,112,112
    .BYTE 65
    .WORD DL
DATA
    .SB "   turbo SOFTWARE   "
ROMARAM
    LDA #$40
    PHA
    TAX
    LDA #$00
    PHA
    TAY
    STY ROM
    STY RAM
REENTRE
    STX RAM+1
    LDX #$C0
LOOPCITO
    STX ROM+1
LOOP1
    LDA (ROM),Y
    STA (RAM),Y
    DEY
    BNE LOOP1
    INC RAM+1
    INC ROM+1
    INX
    BEQ ROMOFF
    CPX #$D0
    BNE LOOP1
    LDX #$D8
    BNE LOOPCITO
ROMOFF
    SEI
    PLA
    STA $D40E
RETURN
    LDA $D301
    AND #$FE
    STA $D301
    LDA #RAM
    STA LOOP1+1
    LDA #ROM
    STA LOOP1+3
    LDA #$60
    STA ROMOFF+5
    LDA #$58
    STA ROMOFF
    LDX #$40
    JMP REENTRE
FINBLKFALSO

;************
;* TENIS 02 *
;************

    ORG  $3000
BLKDOS
    .BYTE $55,$55
ORIGEN = $3000
PROGRAMA = $CC00
    TYA
    BPL BLKOK
    JSR $EDC7
    JMP $C8FC
BLKOK
    LDA EORBLOCK1
    EOR #$FF
    STA EORBLOCK1
    INC BLKOK+6
    INC BLKOK+1
    BNE NOICRHI
    INC BLKOK+7
    INC BLKOK+2
NOICRHI
    LDA BLKOK+2
    CMP # >FINBLKDOS
    BNE BLKOK
    LDA BLKOK+1
    CMP # <FINBLKDOS
    BNE BLKOK
EORBLOCK1
    LDA $E45A
    STA SALTO
    LDA $E45B
    STA SALTO+1
    LDA # <(RAMPROG+SET)
    STA $E45A
    STA ROM
    LDA # >(RAMPROG+SET)
    STA $E45B
    STA ROM+1
    LDA # <RAMPROG
    STA RAM
    LDA # >RAMPROG
    STA RAM+1
    LDY #0
    LDX #3
ARRIBAROM
    LDA (RAM),Y
    STA (ROM),Y
    INY
    BNE ARRIBAROM
    INC RAM+1
    INC ROM+1
    DEX
    BPL ARRIBAROM
    LDX #$02
LOOPINTERRUPCION
    LDA JSRINTERRUPCION,X
    STA $EB59,X
    LDA ERRORYA,X
    STA $EB1D,X
    DEX
    BPL LOOPINTERRUPCION
    STX $02DB
    STX $03F8
    STX $FE0D
    LDX $62
    LDA #$00
    STA $0480
    STA $0481
    STA $FE91,X
    LDA #$32
    STA $FE93,X
    LDA #$EA
    STA $EBF3
    STA $EBF4
    LDA #$C0
    STA $6A
    LDA #133
    STA $FE48
    LDA #12
    STA 764
    LDX #$40
    LDA #$0C
    STA $0342,X
    JSR $E456
    LDX #$40
    LDA #$03
    STA $0342,X
    LDA #$04
    STA $034A,X
    LDA #$80
    STA $034B,X
    LDA # <C
    STA $0344,X
    LDA # >C
    STA $0345,X
    JSR $E456
    LDX #$40
    LDA # <(GAMEA+Z)
    STA $0344,X
    LDA # >(GAMEA+Z)
    STA $0345,X
    LDA # <(FIN-GAMEA)
    STA $0348,X
    LDA # >(FIN-GAMEA)
    STA $0349,X
    LDA #$07
    STA $0342,X
    LDA #$F0
    STA QUEBLK+SET+1
    JSR $E456
    JMP GAMEA+Z
C
    .BYTE "C:",$9B
JSRINTERRUPCION
    JSR INTERRUPCION+SET
ERRORYA
    JSR ERROR?+SET
RAMPROG
    LDA $0300
    CMP #$60
    BNE READBLOCK
NEXT
    JSR READBLOCK+SET
    BMI ERROR
VUELTABLK1
    LDA $0480
    STA QUEBLK+SET
    LDA $0481
    STA QUEBLK+SET+1
    LDX #$02
COUNTBLOCK
    DEC BLK+SET,X
    LDA BLK+SET,X
    CMP #$8F    ;'0-33'
    BNE FINCOUNT
    LDA #$99    ;'9-32'
    STA BLK+SET,X
    DEX
    BPL COUNTBLOCK
FINCOUNT
    LDY #$01
    RTS
READBLOCK
    JMP (SALTO+SET)
ERROR?
    BEQ ERRORAZO
    LDY $30
    BMI ERRORAZO
    LDA $0317
    BEQ ERRORAZO
    RTS
ERRORAZO
    PLA
    PLA
ERROR
    JSR $EDC7
    CPY #136
    BNE NOESEOF
    TYA
    RTS
NOESEOF
    LDX #$0A
LOOPCORRIGIENDO
    LDA CORRECCION+SET,X
    STA LEYENDO+SET,X
    DEX
    BPL LOOPCORRIGIENDO
    CLC
    LDA 560
    STA $00
    LDA 561
    STA $01
    LDY #$0A
SAVEVIEJO
    LDA ($00),Y
    PHA
    INY
    CPY #$0D
    BNE SAVEVIEJO
JUSTO
    LDA $D40B
    BMI JUSTO
    LDY #$0A
    LDA #$01
    STA ($00),Y
    LDA 561
    CMP # >(DISPLIST+SET)
    BNE NOTENNIS
    LDA # <(DL1+SET)
    LDX # >(DL1+SET)
    BNE SITENNIS
NOTENNIS
    LDA # <(DL2+SET)
    LDX # >(DL2+SET)
SITENNIS
    INY
    STA ($00),Y
    TXA
    INY
    STA ($00),Y
    JSR $F2F8
JUSTO1
    LDA $D40B
    BMI JUSTO1
    LDY #$0C
RESTAURA
    PLA
    STA ($00),Y
    DEY
    CPY #$09
    BNE RESTAURA
    LDA #$34
    STA $D302
    LDA $14
    CLC
    ADC #50
WMOTOR
    CMP $14
    BNE WMOTOR
ESPERE
    LDY $D40B
    LDX #$05
ESPERE1
    STX $D40A
ESIRG
    LDA $D20F
    AND #$10
    BEQ ESPERE
    CPY $D40B
    BNE ESIRG
    DEX
    BNE ESPERE1
NOESIGUAL
    LDA #$40
    STA $0303
    JSR READBLOCK+SET
    BPL NOERRORFALSO
    JSR $EDC7
    LDA #$34
    STA $D302
    BNE ESPERE
NOERRORFALSO
    LDA QUEBLK+SET+1
    BPL NOBLK1
    LDA $0480
    ORA $0481
    BNE VALLAERROR
    JSR CHANGEMSG+SET
CHANGEMSG
    JMP VUELTABLK1+SET
    LDX #$0A
LOOPLECTURA
    LDA LECTURA+SET,X
    STA LEYENDO+SET,X
    DEX
    BPL LOOPLECTURA
    LDY #$01
    RTS
NOBLK1
    LDX #$01
LOOPLUGAR
    LDA $0480,X
    CMP QUEBLK+SET,X
    BCC NOESIGUAL
    BNE VALLAERROR
    DEX
    BPL LOOPLUGAR
    JSR CHANGEMSG+SET
    JMP NEXT+SET
VALLAERROR
    JMP ERROR+SET
INTERRUPCION
    LDA LEYENDO+SET
    AND #$7F
    BEQ BYTESLOOP
    BNE NOES9I
BYTESLOOP
    LDX #$04
BYTESLOOP1
    INC BYTES+SET,X
    LDA BYTES+SET,X
    CMP #$9A    ;'9-31'
    BNE NOES9I
    LDA #$90    ;'0-32'
    STA BYTES+SET,X
    DEX
    BPL BYTESLOOP1
NOES9I
    LDA $D20D
    RTS
SALTO .DBYTE 0
QUEBLK .DBYTE 0
TENMEBLK
    .BYTE "000"
MENSAJEERROR
    .SB "   REBOBINE SU CASSETTE 3 VUELTAS DE    "
    .SB "   CONTADOR, PRESIONE ?PLAY?Y?RETURN?   "
PANTALLA
    .BYTE "********************"
PERS .SB "  "
NUMERO1 .SB "000"
    .SB "     * 1 JUGADOR-FRONTON *    "
NUMERO2 .SB "000  "
MENSAJE
    .SB "  MPM    * CARGANDO  PROGRAMA *    MPM  "
    .SB "  "
LEYENDO
    .SB " (R)-1988   BYTES:"
BYTES
    .SB "00000  BLOQUE:"
BLK
    .SB "000   "
    .BYTE "********************"
PER2
    .SB "  000     * 2 JUGADORES-TENIS *    000  "
PER1
    .SB "  000     * 1 JUGADOR-FRONTON *    000  "
CORRECCION
    .SB "CORRECCION"
LECTURA
    .SB " (R)-1988 "
CARGADO
    .SB "    PROGRAMA CARGADO, PRESIONE START    "
DL2
    .BYTE 64+2
    .WORD MENSAJEERROR+SET
    .BYTE 2,65
    .WORD $BC20
DL1
    .BYTE 64+2
    .WORD MENSAJEERROR+SET
    .BYTE 2,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112
    .BYTE 64+2
    .WORD MENSAJE+SET
    .BYTE 2,8,8
    .BYTE 65
    .WORD DISPLIST+SET
DISPLIST
    .BYTE 64+8
    .WORD PANTALLA+SET
    .BYTE 8,2,112,112,112,112,112,112,112
AQUIJUMP
    .BYTE 112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,0
    .BYTE 64+2
CUALPANTALLA
    .WORD MENSAJE+SET
    .BYTE 2,8,8
    .BYTE 65
    .WORD DISPLIST+SET
BUFFER
FINBLKDOS
    ORG  $4000
GAMEA
Z   =   $D800-*
    LDA # <(GAME1A+Z)
    STA $CB
    LDA # >(GAME1A+Z)
    STA $CC
    LDY #$00
EOR29LOOP
    LDA ($CB),Y
    EOR #$29
    STA ($CB),Y
    INC $CB
    BNE BCC
    INC $CC
BCC
    LDA $CC
    CMP # >(FIN+Z)
    BNE EOR29LOOP
    LDA $CB
    CMP # <(FIN+Z)
    BNE EOR29LOOP
GAME1A
    JMP COMIENZOLOAD+Z
SETCANT
    LDX #$10
    STA $0348,X
    TYA
    STA $0349,X
    RTS
READ2
    LDA #$02
    LDY #$00
    JSR SETCANT+Z
READ3
    LDA # <(FIN+Z)
    LDY # >(FIN+Z)
SETPOS
    STA $0344,X
    TYA
    STA $0345,X
    LDA #$07
    STA $0342,X
    JSR $E456
    BPL NOEOF
    JMP INICIOBOOT+Z
NOEOF
    LDX #$10
    RTS
BYTELENTO .BYTE $00
LEEMULA
    LDA #$01
    STA BYTELENTO+Z
LEEMULA1
    LDA $D20F
    AND #$10
    BEQ LEEMULA1
FINSTART
    LDA $D20F
    AND #$10
    BNE FINSTART
    LDA #$F6    ;$00-10
    STA 20
ESPERO12
    LDA 20
    BNE ESPERO12
LEOBIT
    CLC
    LDA $D20F
    AND #$10
    BEQ LEICERO
    SEC
LEICERO
    ROL BYTELENTO+Z
    BCS FINBYTELENTO
;   LDA #$00-8
    LDA #$00-7
    STA 20
    BNE ESPERO12
FINBYTELENTO
    LDA BYTELENTO+Z
    RTS
COMIENZOLOAD
    LDY $D40B
    BMI COMIENZOLOAD
    LDA # <$E45F
    STA $0222
    LDA # >$E45F
    STA $0223
    LDA #$00
    STA $D200
    STA $D201
    STA $D202
BORRAMEM
    LDA #$04
    STA $01
    LDA #$00
    STA $00
    TAY
ERASERAM
    STA ($00),Y
    INY
    BNE ERASERAM
    INC $01
    LDX $01
PONERC0
    CPX #$C0
    BNE ERASERAM
    LDX #$02
ZLOOPCEROS
    LDA TENMEBLK+SET,X
    STA BLK+SET,X
    LDA #$90    ;'0-32'
    STA BYTES+2+SET,X
    DEX
    BPL ZLOOPCEROS
    STA BYTES+1+SET
    LDX #$03
    LDA #$00
NIRUNNISTART
    STA $02E0,X
    DEX
    BPL NIRUNNISTART
    STA FBOOT+Z
PMBASE = $DC
JOYST = $D300
BOTON1 = $D010
BOTON2 = $D011
COLORP0 = $02C0
HPOSP0 = $D000
HPOSP1 = $D001
HPOSP2 = $D002
DIVISION = $D007
CONSOL = $D01F
RANDOM = $D20A
BOLITA = PMBASE*$0100+768+16
P0  =   PMBASE*$0100+512+16
P1  =   PMBASE*$0100+640+16
INICIO
    LDY #17
    LDA #$EA
NOPDLIVBI
    STA $C137,Y
    DEY
    BPL NOPDLIVBI
    LDY #$02
NOSHADOWS
    STA $C16F,Y
    STA $C178,Y
    DEY
    BPL NOSHADOWS
    LDA #0
    STA START+Z
    LDX #$82
LOOPCLR
    STA BOLITA,X
    STA P0-2,X
    STA P1-2,X
    DEX
    CPX #$FF
    BNE LOOPCLR
    INX
LOOPCLR1
    STA $DE00,X
    STA $DF00,X
    DEX
    BNE LOOPCLR1
    LDA #191
    STA HPOSP0
    LDA #0
    STA HPOSP1
    LDA #191
    STA HPOSP2
    LDX #42
    STX $D004
    LDX #206
    STX $D005
    JSR SETPERS+Z
    LDA #63
    STA $D00C
    LDA #$03
    LDX YPOS0+Z
    LDY #$0C
DIBP1
    STA P0,X
    STA P1,X
    INX
    DEY
    BPL DIBP1
    LDA #1
    LDX YPOS2+Z
    STA BOLITA,X
WFORSET
    LDA $D40B
    BMI WFORSET
    LDA # <(VBI+Z)
    STA $0222
    LDA # >(VBI+Z)
    STA $0223
    JMP OPENB+Z
SETPERS
    LDA #2
    STA 623
    STA $D01D
    LDA #PMBASE
    STA $D407
    LDX #0
    STX DIVISION
    LDA #$7F
    STA $D011
    RTS
YPOS0 .BYTE 48
YPOS1 .BYTE 48
YPOS2 .BYTE 48
XPOS2 .BYTE 191
XPOS1 .BYTE 0
FX  .BYTE $FF
FY  .BYTE 0
START .BYTE 0
IMPULSO .BYTE 0
SELECT .BYTE 0
JUEGO .BYTE $FF
SAVEVBI .DBYTE 0
VBI
    LDA # >(DISPLIST+SET)
    STA $D403
    STA $0244
    STA 561
    LDA # <(DISPLIST+SET)
    STA $D402
    STA 560
    LDA #0
    STA 77
    STA $D018
    LDA #$E0
    STA $D409
    LDA #$0E
    STA $D012
    STA $D013
    STA $D014
    STA $D016
    STA $D017
    STA $D019
    LDA #212
    STA $D01A
    LDA #42
    STA $D400
    LDA #$A0
    STA $D201
    LDA #$00
    STA $D200
    LDA CONSOL
    CMP #$05
    BNE SELECT0
    LDA SELECT+Z
    BNE NOCAMBIO
    LDA #1
    STA SELECT+Z
    LDA #0
    STA START+Z
    LDY #39
    LDA JUEGO+Z
    EOR #$FF
    STA JUEGO+Z
    BMI ESUNO
CHANGE ;        2 PERS
    LDA PER2+SET,Y
    STA PERS+SET,Y
    DEY
    BPL CHANGE
    LDA #50
    STA HPOSP1
    STA XPOS1+Z
    LDA #127
    STA DIVISION
    BNE TERMINELO
ESUNO ;         1PER
    LDA PER1+SET,Y
    STA PERS+SET,Y
    DEY
    BPL ESUNO
    LDA #0
    STA HPOSP1
    STA XPOS1+Z
    STA DIVISION
TERMINELO
    JMP $E45F
SELECT0
    LDA #0
    STA SELECT+Z
NOCAMBIO
    LDA START+Z
    BNE STARTED
    LDA #0
    LDX YPOS2+Z
    STA BOLITA,X
    LDA CONSOL
    CMP #$06
    BNE NOSTART
    LDA #$FF
    STA START+Z
NOSTART
    LDA XPOS2+Z
    BPL BOTON2?
    LDA BOTON1
    BNE JOY
    LDA YPOS0+Z
    STA YPOS2+Z
    LDA #190
    STA XPOS2+Z
EMPIEZELO
    LDA #$FF
    STA START+Z
    BNE TERMINELO
BOTON2?
    LDA BOTON2
    BNE JOY
    LDA YPOS1+Z
    STA YPOS2+Z
    LDA #51
    STA XPOS2+Z
    BNE EMPIEZELO
JOY
    JMP JOYSTS+Z
STARTED
    LDA FX+Z
    BPL INCRX
    JSR DECREX+Z
    JMP UD+Z
INCRX
    JSR INCREX+Z
UD
    LDA #0
    LDX YPOS2+Z
    STA BOLITA,X
    LDA FY+Z
    BPL INCRY
    JSR DECREY+Z
    JMP JOYSTS+Z
INCRY
    JSR INCREY+Z
    JMP JOYSTS+Z
DECREX
    LDA $D00E
    AND #$02
    BEQ NOREBOTE
    LDA #$33
    STA $D200
    LDA #$AC
    STA $D201
    LDA JOYST
    LSR
    LSR
    LSR
    LSR
    CMP #$0F
    BEQ NOIMPULSE1
    LDA #$FF
NOIMPULSE1
    STA IMPULSO+Z
    LDX XPOS2+Z
    JMP CHANGEXF+Z
NOREBOTE
    DEC XPOS2+Z
    DEC XPOS2+Z
    LDX XPOS2+Z
    CPX #45
    BCS FINDECREX
    LDA XPOS1+Z
    CMP #40
    BCC OUT2
    LDA #0
    STA START+Z
OUT2
    LDA #$88
    STA $D200
    LDA #$AC
    STA $D201
    LDY #2
ZERO1
    LDA NUMERO1+SET,Y
    CMP #$99    ;'9-32+128'
    BEQ NINE1
    CLC
    ADC #1
    STA NUMERO1+SET,Y
    BNE CHANGEXF
NINE1
    LDA #$90    ;'0+128-32'
    STA NUMERO1+SET,Y
    DEY
    BPL ZERO1
CHANGEXF
    LDA FX+Z
    EOR #$FF
    STA FX+Z
FINDECREX
    STX XPOS2+Z
    STX HPOSP2
    RTS
INCREX
    LDA $D00E
    AND #$01
    BEQ NOREBOTE1
    LDA #$AC
    STA $D201
    LDA #$33
    STA $D200
    LDA JOYST
    AND #$0F
    CMP #$0F
    BEQ NOIMPULSE
    LDA #$FF
NOIMPULSE
    STA IMPULSO+Z
    LDX XPOS2+Z
    JMP CHANGEXF+Z
NOREBOTE1
    INC XPOS2+Z
    INC XPOS2+Z
    LDX XPOS2+Z
    CPX #205
    BCC FINDECREX
SELEFUE
    LDA #0
    STA START+Z
    LDA #$88
    STA $D200
    LDA #$AC
    STA $D201
    LDY #2
ZERO2
    LDA NUMERO2+SET,Y
    CMP #$99    ;'9-32+128'
    BEQ NINE2
    CLC
    ADC #1
    STA NUMERO2+SET,Y
    BNE CHANGEXF
NINE2
    LDA #$90    ;'0+128-32'
    STA NUMERO2+SET,Y
    DEY
    BPL ZERO2
    BMI CHANGEXF
INCREY
    INC YPOS2+Z
    LDA IMPULSO+Z
    BPL BOTAR1
    INC YPOS2+Z
BOTAR1
    LDX YPOS2+Z
    CPX #92
    BCC FININCRY
CHANGEFY
    LDA FY+Z
    EOR #$FF
    STA FY+Z
    LDA #$50
    STA $D200
    LDA #$AC
    STA $D201
FININCRY
    LDA #1
    STA BOLITA,X
    RTS
DECREY
    DEC YPOS2+Z
    LDA IMPULSO+Z
    BPL BOTAR2
    DEC YPOS2+Z
BOTAR2
    LDX YPOS2+Z
    BMI CHANGEFY
    BPL FININCRY
JOYSTS
    LDA #0
    STA $D01E
    LDA JOYST
    AND #$0F
    CMP #15
    BEQ JOY2
    CMP #14
    BNE DWN1
    JSR J1UP+Z
    JMP JOY2+Z
DWN1
    CMP #13
    BNE JOY2
    JSR J1DWN+Z
JOY2
    LDA JOYST
    LSR
    LSR
    LSR
    LSR
    CMP #15
    BEQ EXIT
    CMP #14
    BNE DWN2
    JSR J2UP+Z
    JMP $E45F
DWN2
    CMP #13
    BNE EXIT
    JSR J2DWN+Z
EXIT
    JMP $E45F
J1UP
    LDY YPOS0+Z
    BEQ FINJ1UP
    LDX #16
LOOPJ1UP
    LDA P0,Y
    STA P0-2,Y
    INY
    DEX
    BPL LOOPJ1UP
    DEC YPOS0+Z
    DEC YPOS0+Z
FINJ1UP
    RTS
J2UP
    LDY YPOS1+Z
    BEQ FINJ2UP
    LDX #16
LOOPJ2UP
    LDA P1,Y
    STA P1-2,Y
    INY
    DEX
    BPL LOOPJ2UP
    DEC YPOS1+Z
    DEC YPOS1+Z
FINJ2UP
    RTS
J1DWN
    LDY YPOS0+Z
    CPY #80
    BEQ FINJ1DWN
    TYA
    CLC
    ADC #14
    TAY
    LDX #16
LOOPJ1DWN
    LDA P0-2,Y
    STA P0,Y
    DEY
    DEX
    BPL LOOPJ1DWN
    INC YPOS0+Z
    INC YPOS0+Z
FINJ1DWN
    RTS
J2DWN
    LDY YPOS1+Z
    CPY #80
    BEQ FINJ2DWN
    TYA
    CLC
    ADC #14
    TAY
    LDX #16
LOOPJ2DWN
    LDA P1-2,Y
    STA P1,Y
    DEY
    DEX
    BPL LOOPJ2DWN
    INC YPOS1+Z
    INC YPOS1+Z
FINJ2DWN
    RTS
OPENB
    LDA #$FF
    STA $0340
    LDX #$10
    LDA #$03
    STA $0342,X
    LDA # <(DEVICE+Z)
    STA $0344,X
    LDA # >(DEVICE+Z)
    STA $0345,X
    LDA #$04
    STA $034A,X
    LDA #$80
    STA $034B,X
    LDA #$0C
    STA 764
    JSR $E456
ZREAD
    JSR READ2+Z
    LDA FIN+Z
    AND FIN+1+Z
    CMP #$FF
    BNE SERABOOT?
    LDA # <$E474-1
    STA $0C
    LDA # >$E474-1
    STA $0D
    LDA #$01
    STA FBOOT+Z
    BNE ZREAD
SERABOOT?
    LDA $02E0
    ORA $02E1
    BNE RUNOK
    LDA FIN+Z
    STA $02E0
    LDA FIN+1+Z
    STA $02E1
RUNOK
    LDA FBOOT+Z
    BNE NOESBOOT
    JMP ESBOOT+Z
NOESBOOT
    LDA FIN+Z
    STA $0240
    LDA FIN+1+Z
    STA $0241
    JSR READ2+Z
    SEC
    LDA FIN+Z
    SBC $0240
    STA $0348,X
    LDA FIN+1+Z
    SBC $0241
    STA $0349,X
    INC $0348,X
    BNE NOCARRYY
    INC $0349,X
NOCARRYY
    LDA $0240
    LDY $0241
    JSR SETPOS+Z
    LDA $02E2
    ORA $02E3
    BEQ NOSUBRUTIN
CONSUBRUTINA
    JSR USERSUB+Z
    LDA #$00
    STA $02E2
    STA $02E3
NOSUBRUTIN
    JMP ZREAD+Z
USERSUB
    JMP ($02E2)
CORREPROGRAMA
    LDA #$FF
    STA $D301
    JMP ($02E0)
INICIOBOOT
    LDA #$00-30
    STA 20
WRELOS
    LDA $D20F
    AND #$10
    BEQ INICIOBOOT
    LDA 20
    BNE WRELOS
    LDY #$02
LEOLENTO
    JSR LEEMULA+Z
    STA $03E0,Y
    DEY
    BPL LEOLENTO
    LDA $03E0
    CMP $03E2
    BEQ JUSTOAHORA
    CMP $03E1
    BEQ JUSTOAHORA
    LDA $03E2
    CMP $03E1
    BEQ JUSTOAHORA
LEYODISTINTO
    LDA #$03
    STA PONERC0+Z+1
    JMP BORRAMEM+Z
JUSTOAHORA
    LDA #$3C
    STA $D302
    LDX #39
PROGRAMAENMEMORIA
    LDA CARGADO+SET,X
    STA MENSAJE+SET,X
    DEX
    BPL PROGRAMAENMEMORIA
PRESIONOCAMBIO?
    LDA CONSOL
    CMP #$06
    BNE PRESIONOCAMBIO?
PRESIONOCAMBIO?2
    LDA CONSOL
    CMP #$07
    BNE PRESIONOCAMBIO?2
; SUELTA START ANTES DE EMPEZAR
;
;
;
;
    LDX #$07
LLEVARAM
    LDA CORREPROGRAMA+Z,X
    STA $0392,X
    DEX
    BPL LLEVARAM
JUSTO2
    LDA $D40B
    BMI JUSTO2
    LDA # <$E45F
    STA $0222
    LDA # >$E45F
    STA $0223
    LDA #$00
    STA 623
    LDX #$1F
PMARGEN
    STA $D000,X
    DEX
    BPL PMARGEN
    LDA #$00
    STA $0244
    LDA #$02
    STA $09
    LDA $02E0
    STA $02
    STA $0A
    LDA $02E1
    STA $03
    STA $0B
    LDA $0D
    PHA
    LDA $0C
    PHA
SINRESET
    JMP $0392
ESBOOT
    LDA FIN+Z
    STA $0240
    LDA FIN+1+Z
    STA $0241
    JSR READ2+Z
    CLC
    LDA FIN+Z
    ADC #$06
    STA $04
    LDA FIN+1+Z
    ADC #$00
    STA $05
    JSR READ2+Z
    LDA FIN+Z
    STA $0C
    LDA FIN+1+Z
    STA $0D
    LDY #$06
MULTIPLICA
    ASL $0241
    ROL $0240
    DEY
    BPL MULTIPLICA
    LDA $0240
    STA $0349,X
    LDA $0241
    STA $0348,X
    LDA $04
    STA $0344,X
    STA $02E0
    LDA $05
    STA $0345,X
    STA $02E1
    LDA #$07
    STA $0342,X
    JSR $E456
    SEC
    LDA $0C
    SBC #$01
    STA $0C
    LDA $0D
    SBC #$00
    STA $0D
    JMP INICIOBOOT+Z
FBOOT
    .BYTE 0
DEVICE
    .BYTE "C:",$9B
FIN