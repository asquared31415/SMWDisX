                      ORG $038000                         ;;                   ;
                                                          ;;                   ;
DATA_038000:          db $13,$14,$15,$16,$17,$18,$19      ;;8000|8000/8000\8000;
                                                          ;;                   ;
DATA_038007:          db $F0,$F8,$FC,$00,$04,$08,$10      ;;8007|8007/8007\8007;
                                                          ;;                   ;
DATA_03800E:          db $A0,$D0,$C0,$D0                  ;;800E|800E/800E\800E;
                                                          ;;                   ;
Football:             JSL GenericSprGfxRt2                ;;8012|8012/8012\8012;
                      LDA.B !SpriteLock                   ;;8016|8016/8016\8016;
                      BNE Return038086                    ;;8018|8018/8018\8018;
                      JSR SubOffscreen0Bnk3               ;;801A|801A/801A\801A;
                      JSL SprSpr_MarioSprRts              ;;801D|801D/801D\801D;
                      LDA.W !SpriteMisc1540,X             ;;8021|8021/8021\8021;
                      BEQ CODE_03802D                     ;;8024|8024/8024\8024;
                      DEC A                               ;;8026|8026/8026\8026;
                      BNE +                               ;;8027|8027/8027\8027;
                      JSL CODE_01AB6F                     ;;8029|8029/8029\8029;
CODE_03802D:          JSL UpdateSpritePos                 ;;802D|802D/802D\802D;
                    + LDA.W !SpriteBlockedDirs,X          ;;8031|8031/8031\8031; \ Branch if not touching object 
                      AND.B #$03                          ;;8034|8034/8034\8034;  | 
                      BEQ +                               ;;8036|8036/8036\8036; / 
                      LDA.B !SpriteXSpeed,X               ;;8038|8038/8038\8038;
                      EOR.B #$FF                          ;;803A|803A/803A\803A;
                      INC A                               ;;803C|803C/803C\803C;
                      STA.B !SpriteXSpeed,X               ;;803D|803D/803D\803D;
                    + LDA.W !SpriteBlockedDirs,X          ;;803F|803F/803F\803F;
                      AND.B #$08                          ;;8042|8042/8042\8042;
                      BEQ +                               ;;8044|8044/8044\8044;
                      STZ.B !SpriteYSpeed,X               ;;8046|8046/8046\8046; Sprite Y Speed = 0 
                    + LDA.W !SpriteBlockedDirs,X          ;;8048|8048/8048\8048; \ Branch if not on ground 
                      AND.B #$04                          ;;804B|804B/804B\804B;  | 
                      BEQ Return038086                    ;;804D|804D/804D\804D; / 
                      LDA.W !SpriteMisc1540,X             ;;804F|804F/804F\804F;
                      BNE Return038086                    ;;8052|8052/8052\8052;
                      LDA.W !SpriteOBJAttribute,X         ;;8054|8054/8054\8054;
                      EOR.B #$40                          ;;8057|8057/8057\8057;
                      STA.W !SpriteOBJAttribute,X         ;;8059|8059/8059\8059;
                      JSL GetRand                         ;;805C|805C/805C\805C;
                      AND.B #$03                          ;;8060|8060/8060\8060;
                      TAY                                 ;;8062|8062/8062\8062;
                      LDA.W DATA_03800E,Y                 ;;8063|8063/8063\8063;
                      STA.B !SpriteYSpeed,X               ;;8066|8066/8066\8066;
                      LDY.W !SpriteSlope,X                ;;8068|8068/8068\8068;
                      INY                                 ;;806B|806B/806B\806B;
                      INY                                 ;;806C|806C/806C\806C;
                      INY                                 ;;806D|806D/806D\806D;
                      LDA.W DATA_038007,Y                 ;;806E|806E/806E\806E;
                      CLC                                 ;;8071|8071/8071\8071;
                      ADC.B !SpriteXSpeed,X               ;;8072|8072/8072\8072;
                      BPL CODE_03807E                     ;;8074|8074/8074\8074;
                      CMP.B #$E0                          ;;8076|8076/8076\8076;
                      BCS +                               ;;8078|8078/8078\8078;
                      LDA.B #$E0                          ;;807A|807A/807A\807A;
                      BRA +                               ;;807C|807C/807C\807C;
                                                          ;;                   ;
CODE_03807E:          CMP.B #$20                          ;;807E|807E/807E\807E;
                      BCC +                               ;;8080|8080/8080\8080;
                      LDA.B #$20                          ;;8082|8082/8082\8082;
                    + STA.B !SpriteXSpeed,X               ;;8084|8084/8084\8084;
Return038086:         RTS                                 ;;8086|8086/8086\8086; Return 
                                                          ;;                   ;
BigBooBoss:           JSL CODE_038398                     ;;8087|8087/8087\8087;
                      JSL CODE_038239                     ;;808B|808B/808B\808B;
                      LDA.W !SpriteStatus,X               ;;808F|808F/808F\808F;
                      BNE +                               ;;8092|8092/8092\8092;
                      INC.W !CutsceneID                   ;;8094|8094/8094\8094;
                      LDA.B #$FF                          ;;8097|8097/8097\8097;
                      STA.W !EndLevelTimer                ;;8099|8099/8099\8099;
                      LDA.B #$0B                          ;;809C|809C/809C\809C;
                      STA.W !SPCIO2                       ;;809E|809E/809E\809E; / Change music 
                      RTS                                 ;;80A1|80A1/80A1\80A1; Return 
                                                          ;;                   ;
                    + CMP.B #$08                          ;;80A2|80A2/80A2\80A2;
                      BNE +                               ;;80A4|80A4/80A4\80A4;
                      LDA.B !SpriteLock                   ;;80A6|80A6/80A6\80A6;
                      BNE +                               ;;80A8|80A8/80A8\80A8;
                      LDA.B !SpriteTableC2,X              ;;80AA|80AA/80AA\80AA;
                      JSL ExecutePtr                      ;;80AC|80AC/80AC\80AC;
                                                          ;;                   ;
                      dw CODE_0380BE                      ;;80B0|80B0/80B0\80B0;
                      dw CODE_0380D5                      ;;80B2|80B2/80B2\80B2;
                      dw CODE_038119                      ;;80B4|80B4/80B4\80B4;
                      dw CODE_03818B                      ;;80B6|80B6/80B6\80B6;
                      dw CODE_0381BC                      ;;80B8|80B8/80B8\80B8;
                      dw CODE_038106                      ;;80BA|80BA/80BA\80BA;
                      dw CODE_0381D3                      ;;80BC|80BC/80BC\80BC;
                                                          ;;                   ;
CODE_0380BE:          LDA.B #$03                          ;;80BE|80BE/80BE\80BE;
                      STA.W !SpriteMisc1602,X             ;;80C0|80C0/80C0\80C0;
                      INC.W !SpriteMisc1570,X             ;;80C3|80C3/80C3\80C3;
                      LDA.W !SpriteMisc1570,X             ;;80C6|80C6/80C6\80C6;
                      CMP.B #$90                          ;;80C9|80C9/80C9\80C9;
                      BNE +                               ;;80CB|80CB/80CB\80CB;
                      LDA.B #$08                          ;;80CD|80CD/80CD\80CD;
                      STA.W !SpriteMisc1540,X             ;;80CF|80CF/80CF\80CF;
                      INC.B !SpriteTableC2,X              ;;80D2|80D2/80D2\80D2;
                    + RTS                                 ;;80D4|80D4/80D4\80D4; Return 
                                                          ;;                   ;
CODE_0380D5:          LDA.W !SpriteMisc1540,X             ;;80D5|80D5/80D5\80D5;
                      BNE Return0380F9                    ;;80D8|80D8/80D8\80D8;
                      LDA.B #$08                          ;;80DA|80DA/80DA\80DA;
                      STA.W !SpriteMisc1540,X             ;;80DC|80DC/80DC\80DC;
                      INC.W !BooTransparency              ;;80DF|80DF/80DF\80DF;
                      LDA.W !BooTransparency              ;;80E2|80E2/80E2\80E2;
                      CMP.B #$02                          ;;80E5|80E5/80E5\80E5;
                      BNE +                               ;;80E7|80E7/80E7\80E7;
                      LDY.B #$10                          ;;80E9|80E9/80E9\80E9; \ Play sound effect 
                      STY.W !SPCIO0                       ;;80EB|80EB/80EB\80EB; / 
                    + CMP.B #$07                          ;;80EE|80EE/80EE\80EE;
                      BNE Return0380F9                    ;;80F0|80F0/80F0\80F0;
                      INC.B !SpriteTableC2,X              ;;80F2|80F2/80F2\80F2;
                      LDA.B #$40                          ;;80F4|80F4/80F4\80F4;
                      STA.W !SpriteMisc1540,X             ;;80F6|80F6/80F6\80F6;
Return0380F9:         RTS                                 ;;80F9|80F9/80F9\80F9; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_0380FA:          db $FF,$01                          ;;80FA|80FA/80FA\80FA;
                                                          ;;                   ;
DATA_0380FC:          db $F0,$10                          ;;80FC|80FC/80FC\80FC;
                                                          ;;                   ;
DATA_0380FE:          db $0C,$F4                          ;;80FE|80FE/80FE\80FE;
                                                          ;;                   ;
DATA_038100:          db $01,$FF                          ;;8100|8100/8100\8100;
                                                          ;;                   ;
DATA_038102:          db $01,$02,$02,$01                  ;;8102|8102/8102\8102;
                                                          ;;                   ;
CODE_038106:          LDA.W !SpriteMisc1540,X             ;;8106|8106/8106\8106;
                      BNE +                               ;;8109|8109/8109\8109;
                      STZ.B !SpriteTableC2,X              ;;810B|810B/810B\810B;
                      LDA.B #$40                          ;;810D|810D/810D\810D;
                      STA.W !SpriteMisc1570,X             ;;810F|810F/810F\810F;
                    + LDA.B #$03                          ;;8112|8112/8112\8112;
                      STA.W !SpriteMisc1602,X             ;;8114|8114/8114\8114;
                      BRA +                               ;;8117|8117/8117\8117;
                                                          ;;                   ;
CODE_038119:          STZ.W !SpriteMisc1602,X             ;;8119|8119/8119\8119;
                      JSR CODE_0381E4                     ;;811C|811C/811C\811C;
                    + LDA.W !SpriteMisc15AC,X             ;;811F|811F/811F\811F;
                      BNE CODE_038132                     ;;8122|8122/8122\8122;
                      JSR SubHorzPosBnk3                  ;;8124|8124/8124\8124;
                      TYA                                 ;;8127|8127/8127\8127;
                      CMP.W !SpriteMisc157C,X             ;;8128|8128/8128\8128;
                      BEQ CODE_03814A                     ;;812B|812B/812B\812B;
                      LDA.B #$1F                          ;;812D|812D/812D\812D;
                      STA.W !SpriteMisc15AC,X             ;;812F|812F/812F\812F;
CODE_038132:          CMP.B #$10                          ;;8132|8132/8132\8132;
                      BNE +                               ;;8134|8134/8134\8134;
                      PHA                                 ;;8136|8136/8136\8136;
                      LDA.W !SpriteMisc157C,X             ;;8137|8137/8137\8137;
                      EOR.B #$01                          ;;813A|813A/813A\813A;
                      STA.W !SpriteMisc157C,X             ;;813C|813C/813C\813C;
                      PLA                                 ;;813F|813F/813F\813F;
                    + LSR A                               ;;8140|8140/8140\8140;
                      LSR A                               ;;8141|8141/8141\8141;
                      LSR A                               ;;8142|8142/8142\8142;
                      TAY                                 ;;8143|8143/8143\8143;
                      LDA.W DATA_038102,Y                 ;;8144|8144/8144\8144;
                      STA.W !SpriteMisc1602,X             ;;8147|8147/8147\8147;
CODE_03814A:          LDA.B !EffFrame                     ;;814A|814A/814A\814A;
                      AND.B #$07                          ;;814C|814C/814C\814C;
                      BNE +                               ;;814E|814E/814E\814E;
                      LDA.W !SpriteMisc151C,X             ;;8150|8150/8150\8150;
                      AND.B #$01                          ;;8153|8153/8153\8153;
                      TAY                                 ;;8155|8155/8155\8155;
                      LDA.B !SpriteXSpeed,X               ;;8156|8156/8156\8156;
                      CLC                                 ;;8158|8158/8158\8158;
                      ADC.W DATA_0380FA,Y                 ;;8159|8159/8159\8159;
                      STA.B !SpriteXSpeed,X               ;;815C|815C/815C\815C;
                      CMP.W DATA_0380FC,Y                 ;;815E|815E/815E\815E;
                      BNE +                               ;;8161|8161/8161\8161;
                      INC.W !SpriteMisc151C,X             ;;8163|8163/8163\8163;
                    + LDA.B !EffFrame                     ;;8166|8166/8166\8166;
                      AND.B #$07                          ;;8168|8168/8168\8168;
                      BNE +                               ;;816A|816A/816A\816A;
                      LDA.W !SpriteMisc1528,X             ;;816C|816C/816C\816C;
                      AND.B #$01                          ;;816F|816F/816F\816F;
                      TAY                                 ;;8171|8171/8171\8171;
                      LDA.B !SpriteYSpeed,X               ;;8172|8172/8172\8172;
                      CLC                                 ;;8174|8174/8174\8174;
                      ADC.W DATA_038100,Y                 ;;8175|8175/8175\8175;
                      STA.B !SpriteYSpeed,X               ;;8178|8178/8178\8178;
                      CMP.W DATA_0380FE,Y                 ;;817A|817A/817A\817A;
                      BNE +                               ;;817D|817D/817D\817D;
                      INC.W !SpriteMisc1528,X             ;;817F|817F/817F\817F;
                    + JSL UpdateXPosNoGvtyW               ;;8182|8182/8182\8182;
                      JSL UpdateYPosNoGvtyW               ;;8186|8186/8186\8186;
                      RTS                                 ;;818A|818A/818A\818A; Return 
                                                          ;;                   ;
CODE_03818B:          LDA.W !SpriteMisc1540,X             ;;818B|818B/818B\818B;
                      BNE CODE_0381AE                     ;;818E|818E/818E\818E;
                      INC.B !SpriteTableC2,X              ;;8190|8190/8190\8190;
                      LDA.B #$08                          ;;8192|8192/8192\8192;
                      STA.W !SpriteMisc1540,X             ;;8194|8194/8194\8194;
                      JSL LoadSpriteTables                ;;8197|8197/8197\8197;
                      INC.W !SpriteMisc1534,X             ;;819B|819B/819B\819B;
                      LDA.W !SpriteMisc1534,X             ;;819E|819E/819E\819E;
                      CMP.B #$03                          ;;81A1|81A1/81A1\81A1;
                      BNE +                               ;;81A3|81A3/81A3\81A3;
                      LDA.B #$06                          ;;81A5|81A5/81A5\81A5;
                      STA.B !SpriteTableC2,X              ;;81A7|81A7/81A7\81A7;
                      JSL KillMostSprites                 ;;81A9|81A9/81A9\81A9;
                    + RTS                                 ;;81AD|81AD/81AD\81AD; Return 
                                                          ;;                   ;
CODE_0381AE:          AND.B #$0E                          ;;81AE|81AE/81AE\81AE;
                      EOR.W !SpriteOBJAttribute,X         ;;81B0|81B0/81B0\81B0;
                      STA.W !SpriteOBJAttribute,X         ;;81B3|81B3/81B3\81B3;
                      LDA.B #$03                          ;;81B6|81B6/81B6\81B6;
                      STA.W !SpriteMisc1602,X             ;;81B8|81B8/81B8\81B8;
                      RTS                                 ;;81BB|81BB/81BB\81BB; Return 
                                                          ;;                   ;
CODE_0381BC:          LDA.W !SpriteMisc1540,X             ;;81BC|81BC/81BC\81BC;
                      BNE +                               ;;81BF|81BF/81BF\81BF;
                      LDA.B #$08                          ;;81C1|81C1/81C1\81C1;
                      STA.W !SpriteMisc1540,X             ;;81C3|81C3/81C3\81C3;
                      DEC.W !BooTransparency              ;;81C6|81C6/81C6\81C6;
                      BNE +                               ;;81C9|81C9/81C9\81C9;
                      INC.B !SpriteTableC2,X              ;;81CB|81CB/81CB\81CB;
                      LDA.B #$C0                          ;;81CD|81CD/81CD\81CD;
                      STA.W !SpriteMisc1540,X             ;;81CF|81CF/81CF\81CF;
                    + RTS                                 ;;81D2|81D2/81D2\81D2; Return 
                                                          ;;                   ;
CODE_0381D3:          LDA.B #$02                          ;;81D3|81D3/81D3\81D3; \ Sprite status = Killed 
                      STA.W !SpriteStatus,X               ;;81D5|81D5/81D5\81D5; / 
                      STZ.B !SpriteXSpeed,X               ;;81D8|81D8/81D8\81D8; Sprite X Speed = 0 
                      LDA.B #$D0                          ;;81DA|81DA/81DA\81DA;
                      STA.B !SpriteYSpeed,X               ;;81DC|81DC/81DC\81DC;
                      LDA.B #$23                          ;;81DE|81DE/81DE\81DE; \ Play sound effect 
                      STA.W !SPCIO0                       ;;81E0|81E0/81E0\81E0; / 
                      RTS                                 ;;81E3|81E3/81E3\81E3; Return 
                                                          ;;                   ;
CODE_0381E4:          LDY.B #$0B                          ;;81E4|81E4/81E4\81E4;
CODE_0381E6:          LDA.W !SpriteStatus,Y               ;;81E6|81E6/81E6\81E6;
                      CMP.B #$09                          ;;81E9|81E9/81E9\81E9;
                      BEQ CODE_0381F5                     ;;81EB|81EB/81EB\81EB;
                      CMP.B #$0A                          ;;81ED|81ED/81ED\81ED;
                      BEQ CODE_0381F5                     ;;81EF|81EF/81EF\81EF;
CODE_0381F1:          DEY                                 ;;81F1|81F1/81F1\81F1;
                      BPL CODE_0381E6                     ;;81F2|81F2/81F2\81F2;
                      RTS                                 ;;81F4|81F4/81F4\81F4; Return 
                                                          ;;                   ;
CODE_0381F5:          PHX                                 ;;81F5|81F5/81F5\81F5;
                      TYX                                 ;;81F6|81F6/81F6\81F6;
                      JSL GetSpriteClippingB              ;;81F7|81F7/81F7\81F7;
                      PLX                                 ;;81FB|81FB/81FB\81FB;
                      JSL GetSpriteClippingA              ;;81FC|81FC/81FC\81FC;
                      JSL CheckForContact                 ;;8200|8200/8200\8200;
                      BCC CODE_0381F1                     ;;8204|8204/8204\8204;
                      LDA.B #$03                          ;;8206|8206/8206\8206;
                      STA.B !SpriteTableC2,X              ;;8208|8208/8208\8208;
                      LDA.B #$40                          ;;820A|820A/820A\820A;
                      STA.W !SpriteMisc1540,X             ;;820C|820C/820C\820C;
                      PHX                                 ;;820F|820F/820F\820F;
                      TYX                                 ;;8210|8210/8210\8210;
                      STZ.W !SpriteStatus,X               ;;8211|8211/8211\8211;
                      LDA.B !SpriteXPosLow,X              ;;8214|8214/8214\8214;
                      STA.B !TouchBlockXPos               ;;8216|8216/8216\8216;
                      LDA.W !SpriteYPosHigh,X             ;;8218|8218/8218\8218;
                      STA.B !TouchBlockXPos+1             ;;821B|821B/821B\821B;
                      LDA.B !SpriteYPosLow,X              ;;821D|821D/821D\821D;
                      STA.B !TouchBlockYPos               ;;821F|821F/821F\821F;
                      LDA.W !SpriteXPosHigh,X             ;;8221|8221/8221\8221;
                      STA.B !TouchBlockYPos+1             ;;8224|8224/8224\8224;
                      PHB                                 ;;8226|8226/8226\8226;
                      LDA.B #$02                          ;;8227|8227/8227\8227;
                      PHA                                 ;;8229|8229/8229\8229;
                      PLB                                 ;;822A|822A/822A\822A;
                      LDA.B #$FF                          ;;822B|822B/822B\822B;
                      JSL ShatterBlock                    ;;822D|822D/822D\822D;
                      PLB                                 ;;8231|8231/8231\8231;
                      PLX                                 ;;8232|8232/8232\8232;
                      LDA.B #$28                          ;;8233|8233/8233\8233; \ Play sound effect 
                      STA.W !SPCIO3                       ;;8235|8235/8235\8235; / 
                      RTS                                 ;;8238|8238/8238\8238; Return 
                                                          ;;                   ;
CODE_038239:          LDY.B #$24                          ;;8239|8239/8239\8239;
                      STY.B !ColorSettings                ;;823B|823B/823B\823B;
                      LDA.W !BooTransparency              ;;823D|823D/823D\823D;
                      CMP.B #$08                          ;;8240|8240/8240\8240;
                      DEC A                               ;;8242|8242/8242\8242;
                      BCS +                               ;;8243|8243/8243\8243;
                      LDY.B #$34                          ;;8245|8245/8245\8245;
                      STY.B !ColorSettings                ;;8247|8247/8247\8247;
                      INC A                               ;;8249|8249/8249\8249;
                    + ASL A                               ;;824A|824A/824A\824A;
                      ASL A                               ;;824B|824B/824B\824B;
                      ASL A                               ;;824C|824C/824C\824C;
                      ASL A                               ;;824D|824D/824D\824D;
                      TAX                                 ;;824E|824E/824E\824E;
                      STZ.B !_0                           ;;824F|824F/824F\824F;
                      LDY.W !DynPaletteIndex              ;;8251|8251/8251\8251;
                    - LDA.L BooBossPals,X                 ;;8254|8254/8254\8254;
                      STA.W !DynPaletteTable+2,Y          ;;8258|8258/8258\8258;
                      INY                                 ;;825B|825B/825B\825B;
                      INX                                 ;;825C|825C/825C\825C;
                      INC.B !_0                           ;;825D|825D/825D\825D;
                      LDA.B !_0                           ;;825F|825F/825F\825F;
                      CMP.B #$10                          ;;8261|8261/8261\8261;
                      BNE -                               ;;8263|8263/8263\8263;
                      LDX.W !DynPaletteIndex              ;;8265|8265/8265\8265;
                      LDA.B #$10                          ;;8268|8268/8268\8268;
                      STA.W !DynPaletteTable,X            ;;826A|826A/826A\826A;
                      LDA.B #$F0                          ;;826D|826D/826D\826D;
                      STA.W !DynPaletteTable+1,X          ;;826F|826F/826F\826F;
                      STZ.W !DynPaletteTable+$12,X        ;;8272|8272/8272\8272;
                      TXA                                 ;;8275|8275/8275\8275;
                      CLC                                 ;;8276|8276/8276\8276;
                      ADC.B #$12                          ;;8277|8277/8277\8277;
                      STA.W !DynPaletteIndex              ;;8279|8279/8279\8279;
                      LDX.W !CurSpriteProcess             ;;827C|827C/827C\827C; X = Sprite index 
                      RTL                                 ;;827F|827F/827F\827F; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BigBooDispX:          db $08,$08,$20,$00,$00,$00,$00,$10  ;;8280|8280/8280\8280;
                      db $10,$10,$10,$20,$20,$20,$20,$30  ;;8288|8288/8288\8288;
                      db $30,$30,$30,$FD,$0C,$0C,$27,$00  ;;8290|8290/8290\8290;
                      db $00,$00,$00,$10,$10,$10,$10,$1F  ;;8298|8298/8298\8298;
                      db $20,$20,$1F,$2E,$2E,$2C,$2C,$FB  ;;82A0|82A0/82A0\82A0;
                      db $12,$12,$30,$00,$00,$00,$00,$10  ;;82A8|82A8/82A8\82A8;
                      db $10,$10,$10,$1F,$20,$20,$1F,$2E  ;;82B0|82B0/82B0\82B0;
                      db $2E,$2E,$2E,$F8,$11,$FF,$08,$08  ;;82B8|82B8/82B8\82B8;
                      db $00,$00,$00,$00,$10,$10,$10,$10  ;;82C0|82C0/82C0\82C0;
                      db $20,$20,$20,$20,$30,$30,$30,$30  ;;82C8|82C8/82C8\82C8;
BigBooDispY:          db $12,$22,$18,$00,$10,$20,$30,$00  ;;82D0|82D0/82D0\82D0;
                      db $10,$20,$30,$00,$10,$20,$30,$00  ;;82D8|82D8/82D8\82D8;
                      db $10,$20,$30,$18,$16,$16,$12,$22  ;;82E0|82E0/82E0\82E0;
                      db $00,$10,$20,$30,$00,$10,$20,$30  ;;82E8|82E8/82E8\82E8;
                      db $00,$10,$20,$30,$00,$10,$20,$30  ;;82F0|82F0/82F0\82F0;
BigBooTiles:          db $C0,$E0,$E8,$80,$A0,$A0,$80,$82  ;;82F8|82F8/82F8\82F8;
                      db $A2,$A2,$82,$84,$A4,$C4,$E4,$86  ;;8300|8300/8300\8300;
                      db $A6,$C6,$E6,$E8,$C0,$E0,$E8,$80  ;;8308|8308/8308\8308;
                      db $A0,$A0,$80,$82,$A2,$A2,$82,$84  ;;8310|8310/8310\8310;
                      db $A4,$C4,$E4,$86,$A6,$C6,$E6,$E8  ;;8318|8318/8318\8318;
                      db $C0,$E0,$E8,$80,$A0,$A0,$80,$82  ;;8320|8320/8320\8320;
                      db $A2,$A2,$82,$84,$A4,$A4,$84,$86  ;;8328|8328/8328\8328;
                      db $A6,$A6,$86,$E8,$E8,$E8,$C2,$E2  ;;8330|8330/8330\8330;
                      db $80,$A0,$A0,$80,$82,$A2,$A2,$82  ;;8338|8338/8338\8338;
                      db $84,$A4,$C4,$E4,$86,$A6,$C6,$E6  ;;8340|8340/8340\8340;
BigBooGfxProp:        db $00,$00,$40,$00,$00,$80,$80,$00  ;;8348|8348/8348\8348;
                      db $00,$80,$80,$00,$00,$00,$00,$00  ;;8350|8350/8350\8350;
                      db $00,$00,$00,$00,$00,$00,$40,$00  ;;8358|8358/8358\8358;
                      db $00,$80,$80,$00,$00,$80,$80,$00  ;;8360|8360/8360\8360;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;8368|8368/8368\8368;
                      db $00,$00,$40,$00,$00,$80,$80,$00  ;;8370|8370/8370\8370;
                      db $00,$80,$80,$00,$00,$80,$80,$00  ;;8378|8378/8378\8378;
                      db $00,$80,$80,$00,$00,$40,$00,$00  ;;8380|8380/8380\8380;
                      db $00,$00,$80,$80,$00,$00,$80,$80  ;;8388|8388/8388\8388;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;8390|8390/8390\8390;
                                                          ;;                   ;
CODE_038398:          PHB                                 ;;8398|8398/8398\8398; Wrapper 
                      PHK                                 ;;8399|8399/8399\8399;
                      PLB                                 ;;839A|839A/839A\839A;
                      JSR CODE_0383A0                     ;;839B|839B/839B\839B;
                      PLB                                 ;;839E|839E/839E\839E;
                      RTL                                 ;;839F|839F/839F\839F; Return 
                                                          ;;                   ;
CODE_0383A0:          LDA.B !SpriteNumber,X               ;;83A0|83A0/83A0\83A0;
                      CMP.B #$37                          ;;83A2|83A2/83A2\83A2;
                      BNE CODE_0383C2                     ;;83A4|83A4/83A4\83A4;
                      LDA.B #$00                          ;;83A6|83A6/83A6\83A6;
                      LDY.B !SpriteTableC2,X              ;;83A8|83A8/83A8\83A8;
                      BEQ +                               ;;83AA|83AA/83AA\83AA;
                      LDA.B #$06                          ;;83AC|83AC/83AC\83AC;
                      LDY.W !SpriteMisc1558,X             ;;83AE|83AE/83AE\83AE;
                      BEQ +                               ;;83B1|83B1/83B1\83B1;
                      TYA                                 ;;83B3|83B3/83B3\83B3;
                      AND.B #$04                          ;;83B4|83B4/83B4\83B4;
                      LSR A                               ;;83B6|83B6/83B6\83B6;
                      LSR A                               ;;83B7|83B7/83B7\83B7;
                      ADC.B #$02                          ;;83B8|83B8/83B8\83B8;
                    + STA.W !SpriteMisc1602,X             ;;83BA|83BA/83BA\83BA;
                      JSL GenericSprGfxRt2                ;;83BD|83BD/83BD\83BD;
                      RTS                                 ;;83C1|83C1/83C1\83C1; Return 
                                                          ;;                   ;
CODE_0383C2:          JSR GetDrawInfoBnk3                 ;;83C2|83C2/83C2\83C2;
                      LDA.W !SpriteMisc1602,X             ;;83C5|83C5/83C5\83C5;
                      STA.B !_6                           ;;83C8|83C8/83C8\83C8;
                      ASL A                               ;;83CA|83CA/83CA\83CA;
                      ASL A                               ;;83CB|83CB/83CB\83CB;
                      STA.B !_3                           ;;83CC|83CC/83CC\83CC;
                      ASL A                               ;;83CE|83CE/83CE\83CE;
                      ASL A                               ;;83CF|83CF/83CF\83CF;
                      ADC.B !_3                           ;;83D0|83D0/83D0\83D0;
                      STA.B !_2                           ;;83D2|83D2/83D2\83D2;
                      LDA.W !SpriteMisc157C,X             ;;83D4|83D4/83D4\83D4;
                      STA.B !_4                           ;;83D7|83D7/83D7\83D7;
                      LDA.W !SpriteOBJAttribute,X         ;;83D9|83D9/83D9\83D9;
                      STA.B !_5                           ;;83DC|83DC/83DC\83DC;
                      LDX.B #$00                          ;;83DE|83DE/83DE\83DE;
CODE_0383E0:          PHX                                 ;;83E0|83E0/83E0\83E0;
                      LDX.B !_2                           ;;83E1|83E1/83E1\83E1;
                      LDA.W BigBooTiles,X                 ;;83E3|83E3/83E3\83E3;
                      STA.W !OAMTileNo+$100,Y             ;;83E6|83E6/83E6\83E6;
                      LDA.B !_4                           ;;83E9|83E9/83E9\83E9;
                      LSR A                               ;;83EB|83EB/83EB\83EB;
                      LDA.W BigBooGfxProp,X               ;;83EC|83EC/83EC\83EC;
                      ORA.B !_5                           ;;83EF|83EF/83EF\83EF;
                      BCS +                               ;;83F1|83F1/83F1\83F1;
                      EOR.B #$40                          ;;83F3|83F3/83F3\83F3;
                    + ORA.B !SpriteProperties             ;;83F5|83F5/83F5\83F5;
                      STA.W !OAMTileAttr+$100,Y           ;;83F7|83F7/83F7\83F7;
                      LDA.W BigBooDispX,X                 ;;83FA|83FA/83FA\83FA;
                      BCS +                               ;;83FD|83FD/83FD\83FD;
                      EOR.B #$FF                          ;;83FF|83FF/83FF\83FF;
                      INC A                               ;;8401|8401/8401\8401;
                      CLC                                 ;;8402|8402/8402\8402;
                      ADC.B #$28                          ;;8403|8403/8403\8403;
                    + CLC                                 ;;8405|8405/8405\8405;
                      ADC.B !_0                           ;;8406|8406/8406\8406;
                      STA.W !OAMTileXPos+$100,Y           ;;8408|8408/8408\8408;
                      PLX                                 ;;840B|840B/840B\840B;
                      PHX                                 ;;840C|840C/840C\840C;
                      LDA.B !_6                           ;;840D|840D/840D\840D;
                      CMP.B #$03                          ;;840F|840F/840F\840F;
                      BCC +                               ;;8411|8411/8411\8411;
                      TXA                                 ;;8413|8413/8413\8413;
                      CLC                                 ;;8414|8414/8414\8414;
                      ADC.B #$14                          ;;8415|8415/8415\8415;
                      TAX                                 ;;8417|8417/8417\8417;
                    + LDA.B !_1                           ;;8418|8418/8418\8418;
                      CLC                                 ;;841A|841A/841A\841A;
                      ADC.W BigBooDispY,X                 ;;841B|841B/841B\841B;
                      STA.W !OAMTileYPos+$100,Y           ;;841E|841E/841E\841E;
                      PLX                                 ;;8421|8421/8421\8421;
                      INY                                 ;;8422|8422/8422\8422;
                      INY                                 ;;8423|8423/8423\8423;
                      INY                                 ;;8424|8424/8424\8424;
                      INY                                 ;;8425|8425/8425\8425;
                      INC.B !_2                           ;;8426|8426/8426\8426;
                      INX                                 ;;8428|8428/8428\8428;
                      CPX.B #$14                          ;;8429|8429/8429\8429;
                      BNE CODE_0383E0                     ;;842B|842B/842B\842B;
                      LDX.W !CurSpriteProcess             ;;842D|842D/842D\842D; X = Sprite index 
                      LDA.W !SpriteMisc1602,X             ;;8430|8430/8430\8430;
                      CMP.B #$03                          ;;8433|8433/8433\8433;
                      BNE +                               ;;8435|8435/8435\8435;
                      LDA.W !SpriteMisc1558,X             ;;8437|8437/8437\8437;
                      BEQ +                               ;;843A|843A/843A\843A;
                      LDY.W !SpriteOAMIndex,X             ;;843C|843C/843C\843C; Y = Index into sprite OAM 
                      LDA.W !OAMTileYPos+$100,Y           ;;843F|843F/843F\843F;
                      CLC                                 ;;8442|8442/8442\8442;
                      ADC.B #$05                          ;;8443|8443/8443\8443;
                      STA.W !OAMTileYPos+$100,Y           ;;8445|8445/8445\8445;
                      STA.W !OAMTileYPos+$104,Y           ;;8448|8448/8448\8448;
                    + LDA.B #$13                          ;;844B|844B/844B\844B;
                      LDY.B #$02                          ;;844D|844D/844D\844D;
                      JSL FinishOAMWrite                  ;;844F|844F/844F\844F;
                      RTS                                 ;;8453|8453/8453\8453; Return 
                                                          ;;                   ;
GreyFallingPlat:      JSR CODE_038492                     ;;8454|8454/8454\8454;
                      LDA.B !SpriteLock                   ;;8457|8457/8457\8457;
                      BNE Return038489                    ;;8459|8459/8459\8459;
                      JSR SubOffscreen0Bnk3               ;;845B|845B/845B\845B;
                      LDA.B !SpriteYSpeed,X               ;;845E|845E/845E\845E;
                      BEQ CODE_038476                     ;;8460|8460/8460\8460;
                      LDA.W !SpriteMisc1540,X             ;;8462|8462/8462\8462;
                      BNE +                               ;;8465|8465/8465\8465;
                      LDA.B !SpriteYSpeed,X               ;;8467|8467/8467\8467;
                      CMP.B #$40                          ;;8469|8469/8469\8469;
                      BPL +                               ;;846B|846B/846B\846B;
                      CLC                                 ;;846D|846D/846D\846D;
                      ADC.B #$02                          ;;846E|846E/846E\846E;
                      STA.B !SpriteYSpeed,X               ;;8470|8470/8470\8470;
                    + JSL UpdateYPosNoGvtyW               ;;8472|8472/8472\8472;
CODE_038476:          JSL InvisBlkMainRt                  ;;8476|8476/8476\8476;
                      BCC Return038489                    ;;847A|847A/847A\847A;
                      LDA.B !SpriteYSpeed,X               ;;847C|847C/847C\847C;
                      BNE Return038489                    ;;847E|847E/847E\847E;
                      LDA.B #$03                          ;;8480|8480/8480\8480;
                      STA.B !SpriteYSpeed,X               ;;8482|8482/8482\8482;
                      LDA.B #$18                          ;;8484|8484/8484\8484;
                      STA.W !SpriteMisc1540,X             ;;8486|8486/8486\8486;
Return038489:         RTS                                 ;;8489|8489/8489\8489; Return 
                                                          ;;                   ;
                                                          ;;                   ;
FallingPlatDispX:     db $00,$10,$20,$30                  ;;848A|848A/848A\848A;
                                                          ;;                   ;
FallingPlatTiles:     db $60,$61,$61,$62                  ;;848E|848E/848E\848E;
                                                          ;;                   ;
CODE_038492:          JSR GetDrawInfoBnk3                 ;;8492|8492/8492\8492;
                      PHX                                 ;;8495|8495/8495\8495;
                      LDX.B #$03                          ;;8496|8496/8496\8496;
                    - LDA.B !_0                           ;;8498|8498/8498\8498;
                      CLC                                 ;;849A|849A/849A\849A;
                      ADC.W FallingPlatDispX,X            ;;849B|849B/849B\849B;
                      STA.W !OAMTileXPos+$100,Y           ;;849E|849E/849E\849E;
                      LDA.B !_1                           ;;84A1|84A1/84A1\84A1;
                      STA.W !OAMTileYPos+$100,Y           ;;84A3|84A3/84A3\84A3;
                      LDA.W FallingPlatTiles,X            ;;84A6|84A6/84A6\84A6;
                      STA.W !OAMTileNo+$100,Y             ;;84A9|84A9/84A9\84A9;
                      LDA.B #$03                          ;;84AC|84AC/84AC\84AC;
                      ORA.B !SpriteProperties             ;;84AE|84AE/84AE\84AE;
                      STA.W !OAMTileAttr+$100,Y           ;;84B0|84B0/84B0\84B0;
                      INY                                 ;;84B3|84B3/84B3\84B3;
                      INY                                 ;;84B4|84B4/84B4\84B4;
                      INY                                 ;;84B5|84B5/84B5\84B5;
                      INY                                 ;;84B6|84B6/84B6\84B6;
                      DEX                                 ;;84B7|84B7/84B7\84B7;
                      BPL -                               ;;84B8|84B8/84B8\84B8;
                      PLX                                 ;;84BA|84BA/84BA\84BA;
                      LDY.B #$02                          ;;84BB|84BB/84BB\84BB;
                      LDA.B #$03                          ;;84BD|84BD/84BD\84BD;
                      JSL FinishOAMWrite                  ;;84BF|84BF/84BF\84BF;
                      RTS                                 ;;84C3|84C3/84C3\84C3; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BlurpMaxSpeedY:       db $04,$FC                          ;;84C4|84C4/84C4\84C4;
                                                          ;;                   ;
BlurpSpeedX:          db $08,$F8                          ;;84C6|84C6/84C6\84C6;
                                                          ;;                   ;
BlurpAccelY:          db $01,$FF                          ;;84C8|84C8/84C8\84C8;
                                                          ;;                   ;
Blurp:                JSL GenericSprGfxRt2                ;;84CA|84CA/84CA\84CA;
                      LDY.W !SpriteOAMIndex,X             ;;84CE|84CE/84CE\84CE; Y = Index into sprite OAM 
                      LDA.W !EffFrame                     ;;84D1|84D1/84D1\84D1;
                      LSR A                               ;;84D4|84D4/84D4\84D4;
                      LSR A                               ;;84D5|84D5/84D5\84D5;
                      LSR A                               ;;84D6|84D6/84D6\84D6;
                      CLC                                 ;;84D7|84D7/84D7\84D7;
                      ADC.W !CurSpriteProcess             ;;84D8|84D8/84D8\84D8;
                      LSR A                               ;;84DB|84DB/84DB\84DB;
                      LDA.B #$A2                          ;;84DC|84DC/84DC\84DC;
                      BCC +                               ;;84DE|84DE/84DE\84DE;
                      LDA.B #$EC                          ;;84E0|84E0/84E0\84E0;
                    + STA.W !OAMTileNo+$100,Y             ;;84E2|84E2/84E2\84E2;
                      LDA.W !SpriteStatus,X               ;;84E5|84E5/84E5\84E5;
                      CMP.B #$08                          ;;84E8|84E8/84E8\84E8;
                      BEQ +                               ;;84EA|84EA/84EA\84EA;
CODE_0384EC:          LDA.W !OAMTileAttr+$100,Y           ;;84EC|84EC/84EC\84EC;
                      ORA.B #$80                          ;;84EF|84EF/84EF\84EF;
                      STA.W !OAMTileAttr+$100,Y           ;;84F1|84F1/84F1\84F1;
                      RTS                                 ;;84F4|84F4/84F4\84F4; Return 
                                                          ;;                   ;
                    + LDA.B !SpriteLock                   ;;84F5|84F5/84F5\84F5;
                      BNE Return03852A                    ;;84F7|84F7/84F7\84F7;
                      JSR SubOffscreen0Bnk3               ;;84F9|84F9/84F9\84F9;
                      LDA.B !EffFrame                     ;;84FC|84FC/84FC\84FC;
                      AND.B #$03                          ;;84FE|84FE/84FE\84FE;
                      BNE +                               ;;8500|8500/8500\8500;
                      LDA.B !SpriteTableC2,X              ;;8502|8502/8502\8502;
                      AND.B #$01                          ;;8504|8504/8504\8504;
                      TAY                                 ;;8506|8506/8506\8506;
                      LDA.B !SpriteYSpeed,X               ;;8507|8507/8507\8507;
                      CLC                                 ;;8509|8509/8509\8509;
                      ADC.W BlurpAccelY,Y                 ;;850A|850A/850A\850A;
                      STA.B !SpriteYSpeed,X               ;;850D|850D/850D\850D;
                      CMP.W BlurpMaxSpeedY,Y              ;;850F|850F/850F\850F;
                      BNE +                               ;;8512|8512/8512\8512;
                      INC.B !SpriteTableC2,X              ;;8514|8514/8514\8514;
                    + LDY.W !SpriteMisc157C,X             ;;8516|8516/8516\8516;
                      LDA.W BlurpSpeedX,Y                 ;;8519|8519/8519\8519;
                      STA.B !SpriteXSpeed,X               ;;851C|851C/851C\851C;
                      JSL UpdateXPosNoGvtyW               ;;851E|851E/851E\851E;
                      JSL UpdateYPosNoGvtyW               ;;8522|8522/8522\8522;
                      JSL SprSpr_MarioSprRts              ;;8526|8526/8526\8526;
Return03852A:         RTS                                 ;;852A|852A/852A\852A; Return 
                                                          ;;                   ;
                                                          ;;                   ;
PorcuPuffAccel:       db $01,$FF                          ;;852B|852B/852B\852B;
                                                          ;;                   ;
PorcuPuffMaxSpeed:    db $10,$F0                          ;;852D|852D/852D\852D;
                                                          ;;                   ;
PorcuPuffer:          JSR CODE_0385A3                     ;;852F|852F/852F\852F;
                      LDA.B !SpriteLock                   ;;8532|8532/8532\8532;
                      BNE Return038586                    ;;8534|8534/8534\8534;
                      LDA.W !SpriteStatus,X               ;;8536|8536/8536\8536;
                      CMP.B #$08                          ;;8539|8539/8539\8539;
                      BNE Return038586                    ;;853B|853B/853B\853B;
                      JSR SubOffscreen0Bnk3               ;;853D|853D/853D\853D;
                      JSL SprSpr_MarioSprRts              ;;8540|8540/8540\8540;
                      JSR SubHorzPosBnk3                  ;;8544|8544/8544\8544;
                      TYA                                 ;;8547|8547/8547\8547;
                      STA.W !SpriteMisc157C,X             ;;8548|8548/8548\8548;
                      LDA.B !EffFrame                     ;;854B|854B/854B\854B;
                      AND.B #$03                          ;;854D|854D/854D\854D;
                      BNE +                               ;;854F|854F/854F\854F;
                      LDA.B !SpriteXSpeed,X               ;;8551|8551/8551\8551; \ Branch if at max speed 
                      CMP.W PorcuPuffMaxSpeed,Y           ;;8553|8553/8553\8553;  | 
                      BEQ +                               ;;8556|8556/8556\8556; / 
                      CLC                                 ;;8558|8558/8558\8558; \ Otherwise, accelerate 
                      ADC.W PorcuPuffAccel,Y              ;;8559|8559/8559\8559;  | 
                      STA.B !SpriteXSpeed,X               ;;855C|855C/855C\855C; / 
                    + LDA.B !SpriteXSpeed,X               ;;855E|855E/855E\855E;
                      PHA                                 ;;8560|8560/8560\8560;
                      LDA.W !Layer1DXPos                  ;;8561|8561/8561\8561;
                      ASL A                               ;;8564|8564/8564\8564;
                      ASL A                               ;;8565|8565/8565\8565;
                      ASL A                               ;;8566|8566/8566\8566;
                      CLC                                 ;;8567|8567/8567\8567;
                      ADC.B !SpriteXSpeed,X               ;;8568|8568/8568\8568;
                      STA.B !SpriteXSpeed,X               ;;856A|856A/856A\856A;
                      JSL UpdateXPosNoGvtyW               ;;856C|856C/856C\856C;
                      PLA                                 ;;8570|8570/8570\8570;
                      STA.B !SpriteXSpeed,X               ;;8571|8571/8571\8571;
                      JSL CODE_019138                     ;;8573|8573/8573\8573;
                      LDY.B #$04                          ;;8577|8577/8577\8577;
                      LDA.W !SpriteInLiquid,X             ;;8579|8579/8579\8579;
                      BEQ +                               ;;857C|857C/857C\857C;
                      LDY.B #$FC                          ;;857E|857E/857E\857E;
                    + STY.B !SpriteYSpeed,X               ;;8580|8580/8580\8580;
                      JSL UpdateYPosNoGvtyW               ;;8582|8582/8582\8582;
Return038586:         RTS                                 ;;8586|8586/8586\8586; Return 
                                                          ;;                   ;
                                                          ;;                   ;
PocruPufferDispX:     db $F8,$08,$F8,$08,$08,$F8,$08,$F8  ;;8587|8587/8587\8587;
PocruPufferDispY:     db $F8,$F8,$08,$08                  ;;858F|858F/858F\858F;
                                                          ;;                   ;
PocruPufferTiles:     db $86,$C0,$A6,$C2,$86,$C0,$A6,$8A  ;;8593|8593/8593\8593;
PocruPufferGfxProp:   db $0D,$0D,$0D,$0D,$4D,$4D,$4D,$4D  ;;859B|859B/859B\859B;
                                                          ;;                   ;
CODE_0385A3:          JSR GetDrawInfoBnk3                 ;;85A3|85A3/85A3\85A3;
                      LDA.B !EffFrame                     ;;85A6|85A6/85A6\85A6;
                      AND.B #$04                          ;;85A8|85A8/85A8\85A8;
                      STA.B !_3                           ;;85AA|85AA/85AA\85AA;
                      LDA.W !SpriteMisc157C,X             ;;85AC|85AC/85AC\85AC;
                      STA.B !_2                           ;;85AF|85AF/85AF\85AF;
                      PHX                                 ;;85B1|85B1/85B1\85B1;
                      LDX.B #$03                          ;;85B2|85B2/85B2\85B2;
CODE_0385B4:          LDA.B !_1                           ;;85B4|85B4/85B4\85B4;
                      CLC                                 ;;85B6|85B6/85B6\85B6;
                      ADC.W PocruPufferDispY,X            ;;85B7|85B7/85B7\85B7;
                      STA.W !OAMTileYPos+$100,Y           ;;85BA|85BA/85BA\85BA;
                      PHX                                 ;;85BD|85BD/85BD\85BD;
                      LDA.B !_2                           ;;85BE|85BE/85BE\85BE;
                      BNE +                               ;;85C0|85C0/85C0\85C0;
                      TXA                                 ;;85C2|85C2/85C2\85C2;
                      ORA.B #$04                          ;;85C3|85C3/85C3\85C3;
                      TAX                                 ;;85C5|85C5/85C5\85C5;
                    + LDA.B !_0                           ;;85C6|85C6/85C6\85C6;
                      CLC                                 ;;85C8|85C8/85C8\85C8;
                      ADC.W PocruPufferDispX,X            ;;85C9|85C9/85C9\85C9;
                      STA.W !OAMTileXPos+$100,Y           ;;85CC|85CC/85CC\85CC;
                      LDA.W PocruPufferGfxProp,X          ;;85CF|85CF/85CF\85CF;
                      ORA.B !SpriteProperties             ;;85D2|85D2/85D2\85D2;
                      STA.W !OAMTileAttr+$100,Y           ;;85D4|85D4/85D4\85D4;
                      PLA                                 ;;85D7|85D7/85D7\85D7;
                      PHA                                 ;;85D8|85D8/85D8\85D8;
                      ORA.B !_3                           ;;85D9|85D9/85D9\85D9;
                      TAX                                 ;;85DB|85DB/85DB\85DB;
                      LDA.W PocruPufferTiles,X            ;;85DC|85DC/85DC\85DC;
                      STA.W !OAMTileNo+$100,Y             ;;85DF|85DF/85DF\85DF;
                      PLX                                 ;;85E2|85E2/85E2\85E2;
                      INY                                 ;;85E3|85E3/85E3\85E3;
                      INY                                 ;;85E4|85E4/85E4\85E4;
                      INY                                 ;;85E5|85E5/85E5\85E5;
                      INY                                 ;;85E6|85E6/85E6\85E6;
                      DEX                                 ;;85E7|85E7/85E7\85E7;
                      BPL CODE_0385B4                     ;;85E8|85E8/85E8\85E8;
                      PLX                                 ;;85EA|85EA/85EA\85EA;
                      LDY.B #$02                          ;;85EB|85EB/85EB\85EB;
                      LDA.B #$03                          ;;85ED|85ED/85ED\85ED;
                      JSL FinishOAMWrite                  ;;85EF|85EF/85EF\85EF;
                      RTS                                 ;;85F3|85F3/85F3\85F3; Return 
                                                          ;;                   ;
                                                          ;;                   ;
FlyingBlockSpeedY:    db $08,$F8                          ;;85F4|85F4/85F4\85F4;
                                                          ;;                   ;
FlyingTurnBlocks:     JSR CODE_0386A8                     ;;85F6|85F6/85F6\85F6;
                      LDA.B !SpriteLock                   ;;85F9|85F9/85F9\85F9;
                      BNE Return038675                    ;;85FB|85FB/85FB\85FB;
                      LDA.W !BGFastScrollActive           ;;85FD|85FD/85FD\85FD;
                      BEQ CODE_038629                     ;;8600|8600/8600\8600;
                      LDA.W !SpriteMisc1534,X             ;;8602|8602/8602\8602;
                      INC.W !SpriteMisc1534,X             ;;8605|8605/8605\8605;
                      AND.B #$01                          ;;8608|8608/8608\8608;
                      BNE +                               ;;860A|860A/860A\860A;
                      DEC.W !SpriteMisc1602,X             ;;860C|860C/860C\860C;
                      LDA.W !SpriteMisc1602,X             ;;860F|860F/860F\860F;
                      CMP.B #$FF                          ;;8612|8612/8612\8612;
                      BNE +                               ;;8614|8614/8614\8614;
                      LDA.B #$FF                          ;;8616|8616/8616\8616;
                      STA.W !SpriteMisc1602,X             ;;8618|8618/8618\8618;
                      INC.W !SpriteMisc157C,X             ;;861B|861B/861B\861B;
                    + LDA.W !SpriteMisc157C,X             ;;861E|861E/861E\861E;
                      AND.B #$01                          ;;8621|8621/8621\8621;
                      TAY                                 ;;8623|8623/8623\8623;
                      LDA.W FlyingBlockSpeedY,Y           ;;8624|8624/8624\8624;
                      STA.B !SpriteYSpeed,X               ;;8627|8627/8627\8627;
CODE_038629:          LDA.B !SpriteYSpeed,X               ;;8629|8629/8629\8629;
                      PHA                                 ;;862B|862B/862B\862B;
                      LDY.W !SpriteMisc151C,X             ;;862C|862C/862C\862C;
                      BNE +                               ;;862F|862F/862F\862F;
                      EOR.B #$FF                          ;;8631|8631/8631\8631;
                      INC A                               ;;8633|8633/8633\8633;
                      STA.B !SpriteYSpeed,X               ;;8634|8634/8634\8634;
                    + JSL UpdateYPosNoGvtyW               ;;8636|8636/8636\8636;
                      PLA                                 ;;863A|863A/863A\863A;
                      STA.B !SpriteYSpeed,X               ;;863B|863B/863B\863B;
                      LDA.W !BGFastScrollActive           ;;863D|863D/863D\863D;
                      STA.B !SpriteXSpeed,X               ;;8640|8640/8640\8640;
                      JSL UpdateXPosNoGvtyW               ;;8642|8642/8642\8642;
                      STA.W !SpriteMisc1528,X             ;;8646|8646/8646\8646;
                      JSL InvisBlkMainRt                  ;;8649|8649/8649\8649;
                      BCC Return038675                    ;;864D|864D/864D\864D;
                      LDA.W !BGFastScrollActive           ;;864F|864F/864F\864F;
                      BNE Return038675                    ;;8652|8652/8652\8652;
                      LDA.B #$08                          ;;8654|8654/8654\8654;
                      STA.W !BGFastScrollActive           ;;8656|8656/8656\8656;
                      LDA.B #$7F                          ;;8659|8659/8659\8659;
                      STA.W !SpriteMisc1602,X             ;;865B|865B/865B\865B;
                      LDY.B #$09                          ;;865E|865E/865E\865E;
CODE_038660:          CPY.W !CurSpriteProcess             ;;8660|8660/8660\8660;
                      BEQ CODE_03866C                     ;;8663|8663/8663\8663;
                      LDA.W !SpriteNumber,Y               ;;8665|8665/8665\8665;
                      CMP.B #$C1                          ;;8668|8668/8668\8668;
                      BEQ CODE_038670                     ;;866A|866A/866A\866A;
CODE_03866C:          DEY                                 ;;866C|866C/866C\866C;
                      BPL CODE_038660                     ;;866D|866D/866D\866D;
                      INY                                 ;;866F|866F/866F\866F;
CODE_038670:          LDA.B #$7F                          ;;8670|8670/8670\8670;
                      STA.W !SpriteMisc1602,Y             ;;8672|8672/8672\8672;
Return038675:         RTS                                 ;;8675|8675/8675\8675; Return 
                                                          ;;                   ;
                                                          ;;                   ;
ForestPlatDispX:      db $00,$10,$20,$F2,$2E,$00,$10,$20  ;;8676|8676/8676\8676;
                      db $FA,$2E                          ;;867E|867E/867E\867E;
                                                          ;;                   ;
ForestPlatDispY:      db $00,$00,$00,$F6,$F6,$00,$00,$00  ;;8680|8680/8680\8680;
                      db $FE,$FE                          ;;8688|8688/8688\8688;
                                                          ;;                   ;
ForestPlatTiles:      db $40,$40,$40,$C6,$C6,$40,$40,$40  ;;868A|868A/868A\868A;
                      db $5D,$5D                          ;;8692|8692/8692\8692;
                                                          ;;                   ;
ForestPlatGfxProp:    db $32,$32,$32,$72,$32,$32,$32,$32  ;;8694|8694/8694\8694;
                      db $72,$32                          ;;869C|869C/869C\869C;
                                                          ;;                   ;
ForestPlatTileSize:   db $02,$02,$02,$02,$02,$02,$02,$02  ;;869E|869E/869E\869E;
                      db $00,$00                          ;;86A6|86A6/86A6\86A6;
                                                          ;;                   ;
CODE_0386A8:          JSR GetDrawInfoBnk3                 ;;86A8|86A8/86A8\86A8;
                      LDY.W !SpriteOAMIndex,X             ;;86AB|86AB/86AB\86AB; Y = Index into sprite OAM 
                      LDA.B !EffFrame                     ;;86AE|86AE/86AE\86AE;
                      LSR A                               ;;86B0|86B0/86B0\86B0;
                      AND.B #$04                          ;;86B1|86B1/86B1\86B1;
                      BEQ +                               ;;86B3|86B3/86B3\86B3;
                      INC A                               ;;86B5|86B5/86B5\86B5;
                    + STA.B !_2                           ;;86B6|86B6/86B6\86B6;
                      PHX                                 ;;86B8|86B8/86B8\86B8;
                      LDX.B #$04                          ;;86B9|86B9/86B9\86B9;
                    - STX.B !_6                           ;;86BB|86BB/86BB\86BB;
                      TXA                                 ;;86BD|86BD/86BD\86BD;
                      CLC                                 ;;86BE|86BE/86BE\86BE;
                      ADC.B !_2                           ;;86BF|86BF/86BF\86BF;
                      TAX                                 ;;86C1|86C1/86C1\86C1;
                      LDA.B !_0                           ;;86C2|86C2/86C2\86C2;
                      CLC                                 ;;86C4|86C4/86C4\86C4;
                      ADC.W ForestPlatDispX,X             ;;86C5|86C5/86C5\86C5;
                      STA.W !OAMTileXPos+$100,Y           ;;86C8|86C8/86C8\86C8;
                      LDA.B !_1                           ;;86CB|86CB/86CB\86CB;
                      CLC                                 ;;86CD|86CD/86CD\86CD;
                      ADC.W ForestPlatDispY,X             ;;86CE|86CE/86CE\86CE;
                      STA.W !OAMTileYPos+$100,Y           ;;86D1|86D1/86D1\86D1;
                      LDA.W ForestPlatTiles,X             ;;86D4|86D4/86D4\86D4;
                      STA.W !OAMTileNo+$100,Y             ;;86D7|86D7/86D7\86D7;
                      LDA.W ForestPlatGfxProp,X           ;;86DA|86DA/86DA\86DA;
                      STA.W !OAMTileAttr+$100,Y           ;;86DD|86DD/86DD\86DD;
                      PHY                                 ;;86E0|86E0/86E0\86E0;
                      TYA                                 ;;86E1|86E1/86E1\86E1;
                      LSR A                               ;;86E2|86E2/86E2\86E2;
                      LSR A                               ;;86E3|86E3/86E3\86E3;
                      TAY                                 ;;86E4|86E4/86E4\86E4;
                      LDA.W ForestPlatTileSize,X          ;;86E5|86E5/86E5\86E5;
                      STA.W !OAMTileSize+$40,Y            ;;86E8|86E8/86E8\86E8;
                      PLY                                 ;;86EB|86EB/86EB\86EB;
                      INY                                 ;;86EC|86EC/86EC\86EC;
                      INY                                 ;;86ED|86ED/86ED\86ED;
                      INY                                 ;;86EE|86EE/86EE\86EE;
                      INY                                 ;;86EF|86EF/86EF\86EF;
                      LDX.B !_6                           ;;86F0|86F0/86F0\86F0;
                      DEX                                 ;;86F2|86F2/86F2\86F2;
                      BPL -                               ;;86F3|86F3/86F3\86F3;
                      PLX                                 ;;86F5|86F5/86F5\86F5;
                      LDY.B #$FF                          ;;86F6|86F6/86F6\86F6;
                      LDA.B #$04                          ;;86F8|86F8/86F8\86F8;
                      JSL FinishOAMWrite                  ;;86FA|86FA/86FA\86FA;
                      RTS                                 ;;86FE|86FE/86FE\86FE; Return 
                                                          ;;                   ;
GrayLavaPlatform:     JSR CODE_03873A                     ;;86FF|86FF/86FF\86FF;
                      LDA.B !SpriteLock                   ;;8702|8702/8702\8702;
                      BNE Return038733                    ;;8704|8704/8704\8704;
                      JSR SubOffscreen0Bnk3               ;;8706|8706/8706\8706;
                      LDA.W !SpriteMisc1540,X             ;;8709|8709/8709\8709;
                      DEC A                               ;;870C|870C/870C\870C;
                      BNE +                               ;;870D|870D/870D\870D;
                      LDY.W !SpriteLoadIndex,X            ;;870F|870F/870F\870F; \ 
                      LDA.B #$00                          ;;8712|8712/8712\8712;  | Allow sprite to be reloaded by level loading routine 
                      STA.W !SpriteLoadStatus,Y           ;;8714|8714/8714\8714; / 
                      STZ.W !SpriteStatus,X               ;;8717|8717/8717\8717;
                      RTS                                 ;;871A|871A/871A\871A; Return 
                                                          ;;                   ;
                    + JSL UpdateYPosNoGvtyW               ;;871B|871B/871B\871B;
                      JSL InvisBlkMainRt                  ;;871F|871F/871F\871F;
                      BCC Return038733                    ;;8723|8723/8723\8723;
                      LDA.W !SpriteMisc1540,X             ;;8725|8725/8725\8725;
                      BNE Return038733                    ;;8728|8728/8728\8728;
                      LDA.B #$06                          ;;872A|872A/872A\872A;
                      STA.B !SpriteYSpeed,X               ;;872C|872C/872C\872C;
                      LDA.B #$40                          ;;872E|872E/872E\872E;
                      STA.W !SpriteMisc1540,X             ;;8730|8730/8730\8730;
Return038733:         RTS                                 ;;8733|8733/8733\8733; Return 
                                                          ;;                   ;
                                                          ;;                   ;
LavaPlatTiles:        db $85,$86,$85                      ;;8734|8734/8734\8734;
                                                          ;;                   ;
DATA_038737:          db $43,$03,$03                      ;;8737|8737/8737\8737;
                                                          ;;                   ;
CODE_03873A:          JSR GetDrawInfoBnk3                 ;;873A|873A/873A\873A;
                      PHX                                 ;;873D|873D/873D\873D;
                      LDX.B #$02                          ;;873E|873E/873E\873E;
                    - LDA.B !_0                           ;;8740|8740/8740\8740;
                      STA.W !OAMTileXPos+$100,Y           ;;8742|8742/8742\8742;
                      CLC                                 ;;8745|8745/8745\8745;
                      ADC.B #$10                          ;;8746|8746/8746\8746;
                      STA.B !_0                           ;;8748|8748/8748\8748;
                      LDA.B !_1                           ;;874A|874A/874A\874A;
                      STA.W !OAMTileYPos+$100,Y           ;;874C|874C/874C\874C;
                      LDA.W LavaPlatTiles,X               ;;874F|874F/874F\874F;
                      STA.W !OAMTileNo+$100,Y             ;;8752|8752/8752\8752;
                      LDA.W DATA_038737,X                 ;;8755|8755/8755\8755;
                      ORA.B !SpriteProperties             ;;8758|8758/8758\8758;
                      STA.W !OAMTileAttr+$100,Y           ;;875A|875A/875A\875A;
                      INY                                 ;;875D|875D/875D\875D;
                      INY                                 ;;875E|875E/875E\875E;
                      INY                                 ;;875F|875F/875F\875F;
                      INY                                 ;;8760|8760/8760\8760;
                      DEX                                 ;;8761|8761/8761\8761;
                      BPL -                               ;;8762|8762/8762\8762;
                      PLX                                 ;;8764|8764/8764\8764;
                      LDY.B #$02                          ;;8765|8765/8765\8765;
                      LDA.B #$02                          ;;8767|8767/8767\8767;
                      JSL FinishOAMWrite                  ;;8769|8769/8769\8769;
                      RTS                                 ;;876D|876D/876D\876D; Return 
                                                          ;;                   ;
                                                          ;;                   ;
MegaMoleSpeed:        db $10,$F0                          ;;876E|876E/876E\876E;
                                                          ;;                   ;
MegaMole:             JSR MegaMoleGfxRt                   ;;8770|8770/8770\8770; Graphics routine       
                      LDA.W !SpriteStatus,X               ;;8773|8773/8773\8773; \        
                      CMP.B #$08                          ;;8776|8776/8776\8776;  | If status != 8, return       
                      BNE Return038733                    ;;8778|8778/8778\8778; /       
                      JSR SubOffscreen3Bnk3               ;;877A|877A/877A\877A; Handle off screen situation      
                      LDY.W !SpriteMisc157C,X             ;;877D|877D/877D\877D; \ Set x speed based on direction 
                      LDA.W MegaMoleSpeed,Y               ;;8780|8780/8780\8780;  |       
                      STA.B !SpriteXSpeed,X               ;;8783|8783/8783\8783; /       
                      LDA.B !SpriteLock                   ;;8785|8785/8785\8785; \ If sprites locked, return      
                      BNE Return038733                    ;;8787|8787/8787\8787; /                                
                      LDA.W !SpriteBlockedDirs,X          ;;8789|8789/8789\8789;
                      AND.B #$04                          ;;878C|878C/878C\878C;
                      PHA                                 ;;878E|878E/878E\878E;
                      JSL UpdateSpritePos                 ;;878F|878F/878F\878F; Update position based on speed values 
                      JSL SprSprInteract                  ;;8793|8793/8793\8793; Interact with other sprites 
                      LDA.W !SpriteBlockedDirs,X          ;;8797|8797/8797\8797; \ Branch if not on ground 
                      AND.B #$04                          ;;879A|879A/879A\879A;  | 
                      BEQ MegaMoleInAir                   ;;879C|879C/879C\879C; / 
                      STZ.B !SpriteYSpeed,X               ;;879E|879E/879E\879E; Sprite Y Speed = 0 
                      PLA                                 ;;87A0|87A0/87A0\87A0;
                      BRA MegaMoleOnGround                ;;87A1|87A1/87A1\87A1;
                                                          ;;                   ;
MegaMoleInAir:        PLA                                 ;;87A3|87A3/87A3\87A3;
                      BEQ +                               ;;87A4|87A4/87A4\87A4;
                      LDA.B #$0A                          ;;87A6|87A6/87A6\87A6;
                      STA.W !SpriteMisc1540,X             ;;87A8|87A8/87A8\87A8;
                    + LDA.W !SpriteMisc1540,X             ;;87AB|87AB/87AB\87AB;
                      BEQ MegaMoleOnGround                ;;87AE|87AE/87AE\87AE;
                      STZ.B !SpriteYSpeed,X               ;;87B0|87B0/87B0\87B0; Sprite Y Speed = 0 
MegaMoleOnGround:     LDY.W !SpriteMisc15AC,X             ;;87B2|87B2/87B2\87B2; \   
                      LDA.W !SpriteBlockedDirs,X          ;;87B5|87B5/87B5\87B5; | If Mega Mole is in contact with an object...   
                      AND.B #$03                          ;;87B8|87B8/87B8\87B8; |   
                      BEQ CODE_0387CD                     ;;87BA|87BA/87BA\87BA; |   
                      CPY.B #$00                          ;;87BC|87BC/87BC\87BC; |    ... and timer hasn't been set (time until flip == 0)... 
                      BNE +                               ;;87BE|87BE/87BE\87BE; |   
                      LDA.B #$10                          ;;87C0|87C0/87C0\87C0; |    ... set time until flip   
                      STA.W !SpriteMisc15AC,X             ;;87C2|87C2/87C2\87C2; /   
                    + LDA.W !SpriteMisc157C,X             ;;87C5|87C5/87C5\87C5; \ Flip the temp direction status   
                      EOR.B #$01                          ;;87C8|87C8/87C8\87C8; |   
                      STA.W !SpriteMisc157C,X             ;;87CA|87CA/87CA\87CA; /   
CODE_0387CD:          CPY.B #$00                          ;;87CD|87CD/87CD\87CD; \ If time until flip == 0...   
                      BNE +                               ;;87CF|87CF/87CF\87CF; |   
                      LDA.W !SpriteMisc157C,X             ;;87D1|87D1/87D1\87D1; |    ...update the direction status used by the gfx routine  
                      STA.W !SpriteMisc151C,X             ;;87D4|87D4/87D4\87D4; /                                                            
                    + JSL MarioSprInteract                ;;87D7|87D7/87D7\87D7; Check for mario/Mega Mole contact 
                      BCC Return03882A                    ;;87DB|87DB/87DB\87DB; (Carry set = contact) 
                      JSR SubVertPosBnk3                  ;;87DD|87DD/87DD\87DD;
                      LDA.B !_E                           ;;87E0|87E0/87E0\87E0;
                      CMP.B #$D8                          ;;87E2|87E2/87E2\87E2;
                      BPL MegaMoleContact                 ;;87E4|87E4/87E4\87E4;
                      LDA.B !PlayerYSpeed                 ;;87E6|87E6/87E6\87E6;
                      BMI Return03882A                    ;;87E8|87E8/87E8\87E8;
                      LDA.B #$01                          ;;87EA|87EA/87EA\87EA; \ Set "on sprite" flag     
                      STA.W !StandOnSolidSprite           ;;87EC|87EC/87EC\87EC; /     
                      LDA.B #$06                          ;;87EF|87EF/87EF\87EF; \ Set riding Mega Mole     
                      STA.W !SpriteMisc154C,X             ;;87F1|87F1/87F1\87F1; /      
                      STZ.B !PlayerYSpeed                 ;;87F4|87F4/87F4\87F4; Y speed = 0     
                      LDA.B #$D6                          ;;87F6|87F6/87F6\87F6; \     
                      LDY.W !PlayerRidingYoshi            ;;87F8|87F8/87F8\87F8; | Mario's y position += C6 or D6 depending if on yoshi 
                      BEQ +                               ;;87FB|87FB/87FB\87FB; |     
                      LDA.B #$C6                          ;;87FD|87FD/87FD\87FD; |     
                    + CLC                                 ;;87FF|87FF/87FF\87FF; |     
                      ADC.B !SpriteYPosLow,X              ;;8800|8800/8800\8800; |     
                      STA.B !PlayerYPosNext               ;;8802|8802/8802\8802; |     
                      LDA.W !SpriteXPosHigh,X             ;;8804|8804/8804\8804; |     
                      ADC.B #$FF                          ;;8807|8807/8807\8807; |     
                      STA.B !PlayerYPosNext+1             ;;8809|8809/8809\8809; /     
                      LDY.B #$00                          ;;880B|880B/880B\880B; \      
                      LDA.W !SpriteXMovement              ;;880D|880D/880D\880D; | $1491 == 01 or FF, depending on direction     
                      BPL +                               ;;8810|8810/8810\8810; | Set mario's new x position     
                      DEY                                 ;;8812|8812/8812\8812; |     
                    + CLC                                 ;;8813|8813/8813\8813; |     
                      ADC.B !PlayerXPosNext               ;;8814|8814/8814\8814; |     
                      STA.B !PlayerXPosNext               ;;8816|8816/8816\8816; |     
                      TYA                                 ;;8818|8818/8818\8818; |     
                      ADC.B !PlayerXPosNext+1             ;;8819|8819/8819\8819; |     
                      STA.B !PlayerXPosNext+1             ;;881B|881B/881B\881B;  /   
                      RTS                                 ;;881D|881D/881D\881D; Return 
                                                          ;;                   ;
MegaMoleContact:      LDA.W !SpriteMisc154C,X             ;;881E|881E/881E\881E; \ If riding Mega Mole...     
                      ORA.W !SpriteOnYoshiTongue,X        ;;8821|8821/8821\8821; |   ...or Mega Mole being eaten...     
                      BNE Return03882A                    ;;8824|8824/8824\8824; /   ...return     
                      JSL HurtMario                       ;;8826|8826/8826\8826; Hurt mario     
Return03882A:         RTS                                 ;;882A|882A/882A\882A; Return 
                                                          ;;                   ;
                                                          ;;                   ;
MegaMoleTileDispX:    db $00,$10,$00,$10,$10,$00,$10,$00  ;;882B|882B/882B\882B;
MegaMoleTileDispY:    db $F0,$F0,$00,$00                  ;;8833|8833/8833\8833;
                                                          ;;                   ;
MegaMoleTiles:        db $C6,$C8,$E6,$E8,$CA,$CC,$EA,$EC  ;;8837|8837/8837\8837;
                                                          ;;                   ;
MegaMoleGfxRt:        JSR GetDrawInfoBnk3                 ;;883F|883F/883F\883F;
                      LDA.W !SpriteMisc151C,X             ;;8842|8842/8842\8842; \ $02 = direction      
                      STA.B !_2                           ;;8845|8845/8845\8845; /       
                      LDA.B !EffFrame                     ;;8847|8847/8847\8847; \       
                      LSR A                               ;;8849|8849/8849\8849; |      
                      LSR A                               ;;884A|884A/884A\884A; |      
                      NOP                                 ;;884B|884B/884B\884B; |      
                      CLC                                 ;;884C|884C/884C\884C; |      
                      ADC.W !CurSpriteProcess             ;;884D|884D/884D\884D; |      
                      AND.B #$01                          ;;8850|8850/8850\8850; |      
                      ASL A                               ;;8852|8852/8852\8852; |      
                      ASL A                               ;;8853|8853/8853\8853; |      
                      STA.B !_3                           ;;8854|8854/8854\8854; | $03 = index to frame start (0 or 4)      
                      PHX                                 ;;8856|8856/8856\8856; /      
                      LDX.B #$03                          ;;8857|8857/8857\8857; Run loop 4 times, cuz 4 tiles per frame      
MegaMoleGfxLoopSt:    PHX                                 ;;8859|8859/8859\8859; Push, current tile      
                      LDA.B !_2                           ;;885A|885A/885A\885A; \      
                      BNE +                               ;;885C|885C/885C\885C; | If facing right, index to frame end += 4      
                      INX                                 ;;885E|885E/885E\885E; |      
                      INX                                 ;;885F|885F/885F\885F; |      
                      INX                                 ;;8860|8860/8860\8860; |      
                      INX                                 ;;8861|8861/8861\8861; /      
                    + LDA.B !_0                           ;;8862|8862/8862\8862; \ Tile x position = sprite x location ($00) + tile displacement 
                      CLC                                 ;;8864|8864/8864\8864; |      
                      ADC.W MegaMoleTileDispX,X           ;;8865|8865/8865\8865; |      
                      STA.W !OAMTileXPos+$100,Y           ;;8868|8868/8868\8868; /      
                      PLX                                 ;;886B|886B/886B\886B; \ Pull, X = index to frame end      
                      LDA.B !_1                           ;;886C|886C/886C\886C; |      
                      CLC                                 ;;886E|886E/886E\886E; | Tile y position = sprite y location ($01) + tile displacement 
                      ADC.W MegaMoleTileDispY,X           ;;886F|886F/886F\886F; |    
                      STA.W !OAMTileYPos+$100,Y           ;;8872|8872/8872\8872; /    
                      PHX                                 ;;8875|8875/8875\8875; \ Set current tile    
                      TXA                                 ;;8876|8876/8876\8876; | X = index of frame start + current tile    
                      CLC                                 ;;8877|8877/8877\8877; |    
                      ADC.B !_3                           ;;8878|8878/8878\8878; |    
                      TAX                                 ;;887A|887A/887A\887A; |    
                      LDA.W MegaMoleTiles,X               ;;887B|887B/887B\887B; |    
                      STA.W !OAMTileNo+$100,Y             ;;887E|887E/887E\887E; /    
                      LDA.B #$01                          ;;8881|8881/8881\8881; Tile properties xyppccct, format    
                      LDX.B !_2                           ;;8883|8883/8883\8883; \ If direction == 0...    
                      BNE +                               ;;8885|8885/8885\8885; |    
                      ORA.B #$40                          ;;8887|8887/8887\8887; /    ...flip tile    
                    + ORA.B !SpriteProperties             ;;8889|8889/8889\8889; Add in tile priority of level    
                      STA.W !OAMTileAttr+$100,Y           ;;888B|888B/888B\888B; Store tile properties    
                      PLX                                 ;;888E|888E/888E\888E; \ Pull, current tile    
                      INY                                 ;;888F|888F/888F\888F; | Increase index to sprite tile map ($300)... 
                      INY                                 ;;8890|8890/8890\8890; |    ...we wrote 4 bytes    
                      INY                                 ;;8891|8891/8891\8891; |    ...so increment 4 times 
                      INY                                 ;;8892|8892/8892\8892; |     
                      DEX                                 ;;8893|8893/8893\8893; | Go to next tile of frame and loop    
                      BPL MegaMoleGfxLoopSt               ;;8894|8894/8894\8894; /                                             
                      PLX                                 ;;8896|8896/8896\8896; Pull, X = sprite index    
                      LDY.B #$02                          ;;8897|8897/8897\8897; \ Will write 02 to $0460 (all 16x16 tiles) 
                      LDA.B #$03                          ;;8899|8899/8899\8899; | A = number of tiles drawn - 1    
                      JSL FinishOAMWrite                  ;;889B|889B/889B\889B; / Don't draw if offscreen    
                      RTS                                 ;;889F|889F/889F\889F; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BatTiles:             db $AE,$C0,$E8                      ;;88A0|88A0/88A0\88A0;
                                                          ;;                   ;
Swooper:              JSL GenericSprGfxRt2                ;;88A3|88A3/88A3\88A3;
                      LDY.W !SpriteOAMIndex,X             ;;88A7|88A7/88A7\88A7; Y = Index into sprite OAM 
                      PHX                                 ;;88AA|88AA/88AA\88AA;
                      LDA.W !SpriteMisc1602,X             ;;88AB|88AB/88AB\88AB;
                      TAX                                 ;;88AE|88AE/88AE\88AE;
                      LDA.W BatTiles,X                    ;;88AF|88AF/88AF\88AF;
                      STA.W !OAMTileNo+$100,Y             ;;88B2|88B2/88B2\88B2;
                      PLX                                 ;;88B5|88B5/88B5\88B5;
                      LDA.W !SpriteStatus,X               ;;88B6|88B6/88B6\88B6;
                      CMP.B #$08                          ;;88B9|88B9/88B9\88B9;
                      BEQ +                               ;;88BB|88BB/88BB\88BB;
                      JMP CODE_0384EC                     ;;88BD|88BD/88BD\88BD;
                                                          ;;                   ;
                    + LDA.B !SpriteLock                   ;;88C0|88C0/88C0\88C0;
                      BNE +                               ;;88C2|88C2/88C2\88C2;
                      JSR SubOffscreen0Bnk3               ;;88C4|88C4/88C4\88C4;
                      JSL SprSpr_MarioSprRts              ;;88C7|88C7/88C7\88C7;
                      JSL UpdateXPosNoGvtyW               ;;88CB|88CB/88CB\88CB;
                      JSL UpdateYPosNoGvtyW               ;;88CF|88CF/88CF\88CF;
                      LDA.B !SpriteTableC2,X              ;;88D3|88D3/88D3\88D3;
                      JSL ExecutePtr                      ;;88D5|88D5/88D5\88D5;
                                                          ;;                   ;
                      dw CODE_0388E4                      ;;88D9|88D9/88D9\88D9;
                      dw CODE_038905                      ;;88DB|88DB/88DB\88DB;
                      dw CODE_038936                      ;;88DD|88DD/88DD\88DD;
                                                          ;;                   ;
                    + RTS                                 ;;88DF|88DF/88DF\88DF; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_0388E0:          db $10,$F0                          ;;88E0|88E0/88E0\88E0;
                                                          ;;                   ;
DATA_0388E2:          db $01,$FF                          ;;88E2|88E2/88E2\88E2;
                                                          ;;                   ;
CODE_0388E4:          LDA.W !SpriteOffscreenX,X           ;;88E4|88E4/88E4\88E4;
                      BNE +                               ;;88E7|88E7/88E7\88E7;
                      JSR SubHorzPosBnk3                  ;;88E9|88E9/88E9\88E9;
                      LDA.B !_F                           ;;88EC|88EC/88EC\88EC;
                      CLC                                 ;;88EE|88EE/88EE\88EE;
                      ADC.B #$50                          ;;88EF|88EF/88EF\88EF;
                      CMP.B #$A0                          ;;88F1|88F1/88F1\88F1;
                      BCS +                               ;;88F3|88F3/88F3\88F3;
                      INC.B !SpriteTableC2,X              ;;88F5|88F5/88F5\88F5;
                      TYA                                 ;;88F7|88F7/88F7\88F7;
                      STA.W !SpriteMisc157C,X             ;;88F8|88F8/88F8\88F8;
                      LDA.B #$20                          ;;88FB|88FB/88FB\88FB;
                      STA.B !SpriteYSpeed,X               ;;88FD|88FD/88FD\88FD;
                      LDA.B #$26                          ;;88FF|88FF/88FF\88FF; \ Play sound effect 
                      STA.W !SPCIO3                       ;;8901|8901/8901\8901; / 
                    + RTS                                 ;;8904|8904/8904\8904; Return 
                                                          ;;                   ;
CODE_038905:          LDA.B !TrueFrame                    ;;8905|8905/8905\8905;
                      AND.B #$03                          ;;8907|8907/8907\8907;
                      BNE CODE_038915                     ;;8909|8909/8909\8909;
                      LDA.B !SpriteYSpeed,X               ;;890B|890B/890B\890B;
                      BEQ CODE_038915                     ;;890D|890D/890D\890D;
                      DEC.B !SpriteYSpeed,X               ;;890F|890F/890F\890F;
                      BNE CODE_038915                     ;;8911|8911/8911\8911;
                      INC.B !SpriteTableC2,X              ;;8913|8913/8913\8913;
CODE_038915:          LDA.B !TrueFrame                    ;;8915|8915/8915\8915;
                      AND.B #$03                          ;;8917|8917/8917\8917;
                      BNE +                               ;;8919|8919/8919\8919;
                      LDY.W !SpriteMisc157C,X             ;;891B|891B/891B\891B;
                      LDA.B !SpriteXSpeed,X               ;;891E|891E/891E\891E;
                      CMP.W DATA_0388E0,Y                 ;;8920|8920/8920\8920;
                      BEQ +                               ;;8923|8923/8923\8923;
                      CLC                                 ;;8925|8925/8925\8925;
                      ADC.W DATA_0388E2,Y                 ;;8926|8926/8926\8926;
                      STA.B !SpriteXSpeed,X               ;;8929|8929/8929\8929;
                    + LDA.B !EffFrame                     ;;892B|892B/892B\892B;
                      AND.B #$04                          ;;892D|892D/892D\892D;
                      LSR A                               ;;892F|892F/892F\892F;
                      LSR A                               ;;8930|8930/8930\8930;
                      INC A                               ;;8931|8931/8931\8931;
                      STA.W !SpriteMisc1602,X             ;;8932|8932/8932\8932;
                      RTS                                 ;;8935|8935/8935\8935; Return 
                                                          ;;                   ;
CODE_038936:          LDA.B !TrueFrame                    ;;8936|8936/8936\8936;
                      AND.B #$01                          ;;8938|8938/8938\8938;
                      BNE +                               ;;893A|893A/893A\893A;
                      LDA.W !SpriteMisc151C,X             ;;893C|893C/893C\893C;
                      AND.B #$01                          ;;893F|893F/893F\893F;
                      TAY                                 ;;8941|8941/8941\8941;
                      LDA.B !SpriteYSpeed,X               ;;8942|8942/8942\8942;
                      CLC                                 ;;8944|8944/8944\8944;
                      ADC.W BlurpAccelY,Y                 ;;8945|8945/8945\8945;
                      STA.B !SpriteYSpeed,X               ;;8948|8948/8948\8948;
                      CMP.W BlurpMaxSpeedY,Y              ;;894A|894A/894A\894A;
                      BNE +                               ;;894D|894D/894D\894D;
                      INC.W !SpriteMisc151C,X             ;;894F|894F/894F\894F;
                    + BRA CODE_038915                     ;;8952|8952/8952\8952;
                                                          ;;                   ;
                                                          ;;                   ;
DATA_038954:          db $20,$E0                          ;;8954|8954/8954\8954;
                                                          ;;                   ;
DATA_038956:          db $02,$FE                          ;;8956|8956/8956\8956;
                                                          ;;                   ;
SlidingKoopa:         LDA.B #$00                          ;;8958|8958/8958\8958;
                      LDY.B !SpriteXSpeed,X               ;;895A|895A/895A\895A;
                      BEQ CODE_038964                     ;;895C|895C/895C\895C;
                      BPL +                               ;;895E|895E/895E\895E;
                      INC A                               ;;8960|8960/8960\8960;
                    + STA.W !SpriteMisc157C,X             ;;8961|8961/8961\8961;
CODE_038964:          JSL GenericSprGfxRt2                ;;8964|8964/8964\8964;
                      LDY.W !SpriteOAMIndex,X             ;;8968|8968/8968\8968; Y = Index into sprite OAM 
                      LDA.W !SpriteMisc1558,X             ;;896B|896B/896B\896B;
                      CMP.B #$01                          ;;896E|896E/896E\896E;
                      BNE +                               ;;8970|8970/8970\8970;
                      LDA.W !SpriteMisc157C,X             ;;8972|8972/8972\8972;
                      PHA                                 ;;8975|8975/8975\8975;
                      LDA.B #$02                          ;;8976|8976/8976\8976;
                      STA.B !SpriteNumber,X               ;;8978|8978/8978\8978;
                      JSL InitSpriteTables                ;;897A|897A/897A\897A;
                      PLA                                 ;;897E|897E/897E\897E;
                      STA.W !SpriteMisc157C,X             ;;897F|897F/897F\897F;
                      SEC                                 ;;8982|8982/8982\8982;
                    + LDA.B #$86                          ;;8983|8983/8983\8983;
                      BCC +                               ;;8985|8985/8985\8985;
                      LDA.B #$E0                          ;;8987|8987/8987\8987;
                    + STA.W !OAMTileNo+$100,Y             ;;8989|8989/8989\8989;
                      LDA.W !SpriteStatus,X               ;;898C|898C/898C\898C;
                      CMP.B #$08                          ;;898F|898F/898F\898F;
                      BNE Return0389FE                    ;;8991|8991/8991\8991;
                      JSR SubOffscreen0Bnk3               ;;8993|8993/8993\8993;
                      JSL SprSpr_MarioSprRts              ;;8996|8996/8996\8996;
                      LDA.B !SpriteLock                   ;;899A|899A/899A\899A;
                      ORA.W !SpriteMisc1540,X             ;;899C|899C/899C\899C;
                      ORA.W !SpriteMisc1558,X             ;;899F|899F/899F\899F;
                      BNE Return0389FE                    ;;89A2|89A2/89A2\89A2;
                      JSL UpdateSpritePos                 ;;89A4|89A4/89A4\89A4;
                      LDA.W !SpriteBlockedDirs,X          ;;89A8|89A8/89A8\89A8; \ Branch if not on ground 
                      AND.B #$04                          ;;89AB|89AB/89AB\89AB;  | 
                      BEQ Return0389FE                    ;;89AD|89AD/89AD\89AD; / 
                      JSR CODE_0389FF                     ;;89AF|89AF/89AF\89AF;
                      LDY.B #$00                          ;;89B2|89B2/89B2\89B2;
                      LDA.B !SpriteXSpeed,X               ;;89B4|89B4/89B4\89B4;
                      BEQ CODE_0389CC                     ;;89B6|89B6/89B6\89B6;
                      BPL +                               ;;89B8|89B8/89B8\89B8;
                      EOR.B #$FF                          ;;89BA|89BA/89BA\89BA;
                      INC A                               ;;89BC|89BC/89BC\89BC;
                    + STA.B !_0                           ;;89BD|89BD/89BD\89BD;
                      LDA.W !SpriteSlope,X                ;;89BF|89BF/89BF\89BF;
                      BEQ CODE_0389CC                     ;;89C2|89C2/89C2\89C2;
                      LDY.B !_0                           ;;89C4|89C4/89C4\89C4;
                      EOR.B !SpriteXSpeed,X               ;;89C6|89C6/89C6\89C6;
                      BPL CODE_0389CC                     ;;89C8|89C8/89C8\89C8;
                      LDY.B #$D0                          ;;89CA|89CA/89CA\89CA;
CODE_0389CC:          STY.B !SpriteYSpeed,X               ;;89CC|89CC/89CC\89CC;
                      LDA.B !TrueFrame                    ;;89CE|89CE/89CE\89CE;
                      AND.B #$01                          ;;89D0|89D0/89D0\89D0;
                      BNE Return0389FE                    ;;89D2|89D2/89D2\89D2;
                      LDA.W !SpriteSlope,X                ;;89D4|89D4/89D4\89D4;
                      BNE CODE_0389EC                     ;;89D7|89D7/89D7\89D7;
                      LDA.B !SpriteXSpeed,X               ;;89D9|89D9/89D9\89D9;
                      BNE +                               ;;89DB|89DB/89DB\89DB;
                      LDA.B #$20                          ;;89DD|89DD/89DD\89DD;
                      STA.W !SpriteMisc1558,X             ;;89DF|89DF/89DF\89DF;
                      RTS                                 ;;89E2|89E2/89E2\89E2; Return 
                                                          ;;                   ;
                    + BPL +                               ;;89E3|89E3/89E3\89E3;
                      INC.B !SpriteXSpeed,X               ;;89E5|89E5/89E5\89E5;
                      INC.B !SpriteXSpeed,X               ;;89E7|89E7/89E7\89E7;
                    + DEC.B !SpriteXSpeed,X               ;;89E9|89E9/89E9\89E9;
                      RTS                                 ;;89EB|89EB/89EB\89EB; Return 
                                                          ;;                   ;
CODE_0389EC:          ASL A                               ;;89EC|89EC/89EC\89EC;
                      ROL A                               ;;89ED|89ED/89ED\89ED;
                      AND.B #$01                          ;;89EE|89EE/89EE\89EE;
                      TAY                                 ;;89F0|89F0/89F0\89F0;
                      LDA.B !SpriteXSpeed,X               ;;89F1|89F1/89F1\89F1;
                      CMP.W DATA_038954,Y                 ;;89F3|89F3/89F3\89F3;
                      BEQ Return0389FE                    ;;89F6|89F6/89F6\89F6;
                      CLC                                 ;;89F8|89F8/89F8\89F8;
                      ADC.W DATA_038956,Y                 ;;89F9|89F9/89F9\89F9;
                      STA.B !SpriteXSpeed,X               ;;89FC|89FC/89FC\89FC;
Return0389FE:         RTS                                 ;;89FE|89FE/89FE\89FE; Return 
                                                          ;;                   ;
CODE_0389FF:          LDA.B !SpriteXSpeed,X               ;;89FF|89FF/89FF\89FF;
                      BEQ Return038A20                    ;;8A01|8A01/8A01\8A01;
                      LDA.B !TrueFrame                    ;;8A03|8A03/8A03\8A03;
                      AND.B #$03                          ;;8A05|8A05/8A05\8A05;
                      BNE Return038A20                    ;;8A07|8A07/8A07\8A07;
                      LDA.B #$04                          ;;8A09|8A09/8A09\8A09;
                      STA.B !_0                           ;;8A0B|8A0B/8A0B\8A0B;
                      LDA.B #$0A                          ;;8A0D|8A0D/8A0D\8A0D;
                      STA.B !_1                           ;;8A0F|8A0F/8A0F\8A0F;
                      JSR IsSprOffScreenBnk3              ;;8A11|8A11/8A11\8A11;
                      BNE Return038A20                    ;;8A14|8A14/8A14\8A14;
                      LDY.B #$03                          ;;8A16|8A16/8A16\8A16;
CODE_038A18:          LDA.W !SmokeSpriteNumber,Y          ;;8A18|8A18/8A18\8A18;
                      BEQ CODE_038A21                     ;;8A1B|8A1B/8A1B\8A1B;
                      DEY                                 ;;8A1D|8A1D/8A1D\8A1D;
                      BPL CODE_038A18                     ;;8A1E|8A1E/8A1E\8A1E;
Return038A20:         RTS                                 ;;8A20|8A20/8A20\8A20; Return 
                                                          ;;                   ;
CODE_038A21:          LDA.B #$03                          ;;8A21|8A21/8A21\8A21;
                      STA.W !SmokeSpriteNumber,Y          ;;8A23|8A23/8A23\8A23;
                      LDA.B !SpriteXPosLow,X              ;;8A26|8A26/8A26\8A26;
                      CLC                                 ;;8A28|8A28/8A28\8A28;
                      ADC.B !_0                           ;;8A29|8A29/8A29\8A29;
                      STA.W !SmokeSpriteXPos,Y            ;;8A2B|8A2B/8A2B\8A2B;
                      LDA.B !SpriteYPosLow,X              ;;8A2E|8A2E/8A2E\8A2E;
                      CLC                                 ;;8A30|8A30/8A30\8A30;
                      ADC.B !_1                           ;;8A31|8A31/8A31\8A31;
                      STA.W !SmokeSpriteYPos,Y            ;;8A33|8A33/8A33\8A33;
                      LDA.B #$13                          ;;8A36|8A36/8A36\8A36;
                      STA.W !SmokeSpriteTimer,Y           ;;8A38|8A38/8A38\8A38;
                      RTS                                 ;;8A3B|8A3B/8A3B\8A3B; Return 
                                                          ;;                   ;
BowserStatue:         JSR BowserStatueGfx                 ;;8A3C|8A3C/8A3C\8A3C;
                      LDA.B !SpriteLock                   ;;8A3F|8A3F/8A3F\8A3F;
                      BNE +                               ;;8A41|8A41/8A41\8A41;
                      JSR SubOffscreen0Bnk3               ;;8A43|8A43/8A43\8A43;
                      LDA.B !SpriteTableC2,X              ;;8A46|8A46/8A46\8A46;
                      JSL ExecutePtr                      ;;8A48|8A48/8A48\8A48;
                                                          ;;                   ;
                      dw CODE_038A57                      ;;8A4C|8A4C/8A4C\8A4C;
                      dw CODE_038A54                      ;;8A4E|8A4E/8A4E\8A4E;
                      dw CODE_038A69                      ;;8A50|8A50/8A50\8A50;
                      dw CODE_038A54                      ;;8A52|8A52/8A52\8A52;
                                                          ;;                   ;
CODE_038A54:          JSR CODE_038ACB                     ;;8A54|8A54/8A54\8A54;
CODE_038A57:          JSL InvisBlkMainRt                  ;;8A57|8A57/8A57\8A57;
                      JSL UpdateSpritePos                 ;;8A5B|8A5B/8A5B\8A5B;
                      LDA.W !SpriteBlockedDirs,X          ;;8A5F|8A5F/8A5F\8A5F; \ Branch if not on ground 
                      AND.B #$04                          ;;8A62|8A62/8A62\8A62;  | 
                      BEQ +                               ;;8A64|8A64/8A64\8A64; / 
                      STZ.B !SpriteYSpeed,X               ;;8A66|8A66/8A66\8A66; Sprite Y Speed = 0 
                    + RTS                                 ;;8A68|8A68/8A68\8A68; Return 
                                                          ;;                   ;
CODE_038A69:          ASL.W !SpriteTweakerD,X             ;;8A69|8A69/8A69\8A69;
                      LSR.W !SpriteTweakerD,X             ;;8A6C|8A6C/8A6C\8A6C;
                      JSL MarioSprInteract                ;;8A6F|8A6F/8A6F\8A6F;
                      STZ.W !SpriteMisc1602,X             ;;8A73|8A73/8A73\8A73;
                      LDA.B !SpriteYSpeed,X               ;;8A76|8A76/8A76\8A76;
                      CMP.B #$10                          ;;8A78|8A78/8A78\8A78;
                      BPL +                               ;;8A7A|8A7A/8A7A\8A7A;
                      INC.W !SpriteMisc1602,X             ;;8A7C|8A7C/8A7C\8A7C;
                    + JSL UpdateSpritePos                 ;;8A7F|8A7F/8A7F\8A7F;
                      LDA.W !SpriteBlockedDirs,X          ;;8A83|8A83/8A83\8A83; \ Branch if not touching object 
                      AND.B #$03                          ;;8A86|8A86/8A86\8A86;  | 
                      BEQ +                               ;;8A88|8A88/8A88\8A88; / 
                      LDA.B !SpriteXSpeed,X               ;;8A8A|8A8A/8A8A\8A8A;
                      EOR.B #$FF                          ;;8A8C|8A8C/8A8C\8A8C;
                      INC A                               ;;8A8E|8A8E/8A8E\8A8E;
                      STA.B !SpriteXSpeed,X               ;;8A8F|8A8F/8A8F\8A8F;
                      LDA.W !SpriteMisc157C,X             ;;8A91|8A91/8A91\8A91;
                      EOR.B #$01                          ;;8A94|8A94/8A94\8A94;
                      STA.W !SpriteMisc157C,X             ;;8A96|8A96/8A96\8A96;
                    + LDA.W !SpriteBlockedDirs,X          ;;8A99|8A99/8A99\8A99; \ Branch if not on ground 
                      AND.B #$04                          ;;8A9C|8A9C/8A9C\8A9C;  | 
                      BEQ Return038AC6                    ;;8A9E|8A9E/8A9E\8A9E; / 
                      LDA.B #$10                          ;;8AA0|8AA0/8AA0\8AA0;
                      STA.B !SpriteYSpeed,X               ;;8AA2|8AA2/8AA2\8AA2;
                      STZ.B !SpriteXSpeed,X               ;;8AA4|8AA4/8AA4\8AA4; Sprite X Speed = 0 
                      LDA.W !SpriteMisc1540,X             ;;8AA6|8AA6/8AA6\8AA6;
                      BEQ CODE_038AC1                     ;;8AA9|8AA9/8AA9\8AA9;
                      DEC A                               ;;8AAB|8AAB/8AAB\8AAB;
                      BNE Return038AC6                    ;;8AAC|8AAC/8AAC\8AAC;
                      LDA.B #$C0                          ;;8AAE|8AAE/8AAE\8AAE;
                      STA.B !SpriteYSpeed,X               ;;8AB0|8AB0/8AB0\8AB0;
                      JSR SubHorzPosBnk3                  ;;8AB2|8AB2/8AB2\8AB2;
                      TYA                                 ;;8AB5|8AB5/8AB5\8AB5;
                      STA.W !SpriteMisc157C,X             ;;8AB6|8AB6/8AB6\8AB6;
                      LDA.W BwsrStatueSpeed,Y             ;;8AB9|8AB9/8AB9\8AB9;
                      STA.B !SpriteXSpeed,X               ;;8ABC|8ABC/8ABC\8ABC;
                      RTS                                 ;;8ABE|8ABE/8ABE\8ABE; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BwsrStatueSpeed:      db $10,$F0                          ;;8ABF|8ABF/8ABF\8ABF;
                                                          ;;                   ;
CODE_038AC1:          LDA.B #$30                          ;;8AC1|8AC1/8AC1\8AC1;
                      STA.W !SpriteMisc1540,X             ;;8AC3|8AC3/8AC3\8AC3;
Return038AC6:         RTS                                 ;;8AC6|8AC6/8AC6\8AC6; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BwserFireDispXLo:     db $10,$F0                          ;;8AC7|8AC7/8AC7\8AC7;
                                                          ;;                   ;
BwserFireDispXHi:     db $00,$FF                          ;;8AC9|8AC9/8AC9\8AC9;
                                                          ;;                   ;
CODE_038ACB:          TXA                                 ;;8ACB|8ACB/8ACB\8ACB;
                      ASL A                               ;;8ACC|8ACC/8ACC\8ACC;
                      ASL A                               ;;8ACD|8ACD/8ACD\8ACD;
                      ADC.B !TrueFrame                    ;;8ACE|8ACE/8ACE\8ACE;
                      AND.B #$7F                          ;;8AD0|8AD0/8AD0\8AD0;
                      BNE +                               ;;8AD2|8AD2/8AD2\8AD2;
                      JSL FindFreeSprSlot                 ;;8AD4|8AD4/8AD4\8AD4; \ Return if no free slots 
                      BMI +                               ;;8AD8|8AD8/8AD8\8AD8; / 
                      LDA.B #$17                          ;;8ADA|8ADA/8ADA\8ADA; \ Play sound effect 
                      STA.W !SPCIO3                       ;;8ADC|8ADC/8ADC\8ADC; / 
                      LDA.B #$08                          ;;8ADF|8ADF/8ADF\8ADF; \ Sprite status = Normal 
                      STA.W !SpriteStatus,Y               ;;8AE1|8AE1/8AE1\8AE1; / 
                      LDA.B #$B3                          ;;8AE4|8AE4/8AE4\8AE4; \ Sprite = Bowser Statue Fireball 
                      STA.W !SpriteNumber,Y               ;;8AE6|8AE6/8AE6\8AE6; / 
                      LDA.B !SpriteXPosLow,X              ;;8AE9|8AE9/8AE9\8AE9;
                      STA.B !_0                           ;;8AEB|8AEB/8AEB\8AEB;
                      LDA.W !SpriteYPosHigh,X             ;;8AED|8AED/8AED\8AED;
                      STA.B !_1                           ;;8AF0|8AF0/8AF0\8AF0;
                      PHX                                 ;;8AF2|8AF2/8AF2\8AF2;
                      LDA.W !SpriteMisc157C,X             ;;8AF3|8AF3/8AF3\8AF3;
                      TAX                                 ;;8AF6|8AF6/8AF6\8AF6;
                      LDA.B !_0                           ;;8AF7|8AF7/8AF7\8AF7;
                      CLC                                 ;;8AF9|8AF9/8AF9\8AF9;
                      ADC.W BwserFireDispXLo,X            ;;8AFA|8AFA/8AFA\8AFA;
                      STA.W !SpriteXPosLow,Y              ;;8AFD|8AFD/8AFD\8AFD;
                      LDA.B !_1                           ;;8B00|8B00/8B00\8B00;
                      ADC.W BwserFireDispXHi,X            ;;8B02|8B02/8B02\8B02;
                      STA.W !SpriteYPosHigh,Y             ;;8B05|8B05/8B05\8B05;
                      TYX                                 ;;8B08|8B08/8B08\8B08; \ Reset sprite tables 
                      JSL InitSpriteTables                ;;8B09|8B09/8B09\8B09;  | 
                      PLX                                 ;;8B0D|8B0D/8B0D\8B0D; / 
                      LDA.B !SpriteYPosLow,X              ;;8B0E|8B0E/8B0E\8B0E;
                      SEC                                 ;;8B10|8B10/8B10\8B10;
                      SBC.B #$02                          ;;8B11|8B11/8B11\8B11;
                      STA.W !SpriteYPosLow,Y              ;;8B13|8B13/8B13\8B13;
                      LDA.W !SpriteXPosHigh,X             ;;8B16|8B16/8B16\8B16;
                      SBC.B #$00                          ;;8B19|8B19/8B19\8B19;
                      STA.W !SpriteXPosHigh,Y             ;;8B1B|8B1B/8B1B\8B1B;
                      LDA.W !SpriteMisc157C,X             ;;8B1E|8B1E/8B1E\8B1E;
                      STA.W !SpriteMisc157C,Y             ;;8B21|8B21/8B21\8B21;
                    + RTS                                 ;;8B24|8B24/8B24\8B24; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BwsrStatueDispX:      db $08,$F8,$00,$00,$08,$00          ;;8B25|8B25/8B25\8B25;
                                                          ;;                   ;
BwsrStatueDispY:      db $10,$F8,$00                      ;;8B2B|8B2B/8B2B\8B2B;
                                                          ;;                   ;
BwsrStatueTiles:      db $56,$30,$41,$56,$30,$35          ;;8B2E|8B2E/8B2E\8B2E;
                                                          ;;                   ;
BwsrStatueTileSize:   db $00,$02,$02                      ;;8B34|8B34/8B34\8B34;
                                                          ;;                   ;
BwsrStatueGfxProp:    db $00,$00,$00,$40,$40,$40          ;;8B37|8B37/8B37\8B37;
                                                          ;;                   ;
BowserStatueGfx:      JSR GetDrawInfoBnk3                 ;;8B3D|8B3D/8B3D\8B3D;
                      LDA.W !SpriteMisc1602,X             ;;8B40|8B40/8B40\8B40;
                      STA.B !_4                           ;;8B43|8B43/8B43\8B43;
                      EOR.B #$01                          ;;8B45|8B45/8B45\8B45;
                      DEC A                               ;;8B47|8B47/8B47\8B47;
                      STA.B !_3                           ;;8B48|8B48/8B48\8B48;
                      LDA.W !SpriteOBJAttribute,X         ;;8B4A|8B4A/8B4A\8B4A;
                      STA.B !_5                           ;;8B4D|8B4D/8B4D\8B4D;
                      LDA.W !SpriteMisc157C,X             ;;8B4F|8B4F/8B4F\8B4F;
                      STA.B !_2                           ;;8B52|8B52/8B52\8B52;
                      PHX                                 ;;8B54|8B54/8B54\8B54;
                      LDX.B #$02                          ;;8B55|8B55/8B55\8B55;
CODE_038B57:          PHX                                 ;;8B57|8B57/8B57\8B57;
                      LDA.B !_2                           ;;8B58|8B58/8B58\8B58;
                      BNE +                               ;;8B5A|8B5A/8B5A\8B5A;
                      INX                                 ;;8B5C|8B5C/8B5C\8B5C;
                      INX                                 ;;8B5D|8B5D/8B5D\8B5D;
                      INX                                 ;;8B5E|8B5E/8B5E\8B5E;
                    + LDA.B !_0                           ;;8B5F|8B5F/8B5F\8B5F;
                      CLC                                 ;;8B61|8B61/8B61\8B61;
                      ADC.W BwsrStatueDispX,X             ;;8B62|8B62/8B62\8B62;
                      STA.W !OAMTileXPos+$100,Y           ;;8B65|8B65/8B65\8B65;
                      LDA.W BwsrStatueGfxProp,X           ;;8B68|8B68/8B68\8B68;
                      ORA.B !_5                           ;;8B6B|8B6B/8B6B\8B6B;
                      ORA.B !SpriteProperties             ;;8B6D|8B6D/8B6D\8B6D;
                      STA.W !OAMTileAttr+$100,Y           ;;8B6F|8B6F/8B6F\8B6F;
                      PLX                                 ;;8B72|8B72/8B72\8B72;
                      LDA.B !_1                           ;;8B73|8B73/8B73\8B73;
                      CLC                                 ;;8B75|8B75/8B75\8B75;
                      ADC.W BwsrStatueDispY,X             ;;8B76|8B76/8B76\8B76;
                      STA.W !OAMTileYPos+$100,Y           ;;8B79|8B79/8B79\8B79;
                      PHX                                 ;;8B7C|8B7C/8B7C\8B7C;
                      LDA.B !_4                           ;;8B7D|8B7D/8B7D\8B7D;
                      BEQ +                               ;;8B7F|8B7F/8B7F\8B7F;
                      INX                                 ;;8B81|8B81/8B81\8B81;
                      INX                                 ;;8B82|8B82/8B82\8B82;
                      INX                                 ;;8B83|8B83/8B83\8B83;
                    + LDA.W BwsrStatueTiles,X             ;;8B84|8B84/8B84\8B84;
                      STA.W !OAMTileNo+$100,Y             ;;8B87|8B87/8B87\8B87;
                      PLX                                 ;;8B8A|8B8A/8B8A\8B8A;
                      PHY                                 ;;8B8B|8B8B/8B8B\8B8B;
                      TYA                                 ;;8B8C|8B8C/8B8C\8B8C;
                      LSR A                               ;;8B8D|8B8D/8B8D\8B8D;
                      LSR A                               ;;8B8E|8B8E/8B8E\8B8E;
                      TAY                                 ;;8B8F|8B8F/8B8F\8B8F;
                      LDA.W BwsrStatueTileSize,X          ;;8B90|8B90/8B90\8B90;
                      STA.W !OAMTileSize+$40,Y            ;;8B93|8B93/8B93\8B93;
                      PLY                                 ;;8B96|8B96/8B96\8B96;
                      INY                                 ;;8B97|8B97/8B97\8B97;
                      INY                                 ;;8B98|8B98/8B98\8B98;
                      INY                                 ;;8B99|8B99/8B99\8B99;
                      INY                                 ;;8B9A|8B9A/8B9A\8B9A;
                      DEX                                 ;;8B9B|8B9B/8B9B\8B9B;
                      CPX.B !_3                           ;;8B9C|8B9C/8B9C\8B9C;
                      BNE CODE_038B57                     ;;8B9E|8B9E/8B9E\8B9E;
                      PLX                                 ;;8BA0|8BA0/8BA0\8BA0;
                      LDY.B #$FF                          ;;8BA1|8BA1/8BA1\8BA1;
                      LDA.B #$02                          ;;8BA3|8BA3/8BA3\8BA3;
                      JSL FinishOAMWrite                  ;;8BA5|8BA5/8BA5\8BA5;
                      RTS                                 ;;8BA9|8BA9/8BA9\8BA9; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_038BAA:          db $20,$20,$20,$20,$20,$20,$20,$20  ;;8BAA|8BAA/8BAA\8BAA;
                      db $20,$20,$20,$20,$20,$20,$20,$20  ;;8BB2|8BB2/8BB2\8BB2;
                      db $20,$1F,$1E,$1D,$1C,$1B,$1A,$19  ;;8BBA|8BBA/8BBA\8BBA;
                      db $18,$17,$16,$15,$14,$13,$12,$11  ;;8BC2|8BC2/8BC2\8BC2;
                      db $10,$0F,$0E,$0D,$0C,$0B,$0A,$09  ;;8BCA|8BCA/8BCA\8BCA;
                      db $08,$07,$06,$05,$04,$03,$02,$01  ;;8BD2|8BD2/8BD2\8BD2;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;8BDA|8BDA/8BDA\8BDA;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;8BE2|8BE2/8BE2\8BE2;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;8BEA|8BEA/8BEA\8BEA;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;8BF2|8BF2/8BF2\8BF2;
                      db $01,$02,$03,$04,$05,$06,$07,$08  ;;8BFA|8BFA/8BFA\8BFA;
                      db $09,$0A,$0B,$0C,$0D,$0E,$0F,$10  ;;8C02|8C02/8C02\8C02;
                      db $11,$12,$13,$14,$15,$16,$17,$18  ;;8C0A|8C0A/8C0A\8C0A;
                      db $19,$1A,$1B,$1C,$1D,$1E,$1F,$20  ;;8C12|8C12/8C12\8C12;
                      db $20,$20,$20,$20,$20,$20,$20,$20  ;;8C1A|8C1A/8C1A\8C1A;
                      db $20,$20,$20,$20,$20,$20,$20,$20  ;;8C22|8C22/8C22\8C22;
DATA_038C2A:          db $00,$F8,$00,$08                  ;;8C2A|8C2A/8C2A\8C2A;
                                                          ;;                   ;
                    - RTS                                 ;;8C2E|8C2E/8C2E\8C2E; Return 
                                                          ;;                   ;
CarrotTopLift:        JSR CarrotTopLiftGfx                ;;8C2F|8C2F/8C2F\8C2F;
                      LDA.B !SpriteLock                   ;;8C32|8C32/8C32\8C32;
                      BNE -                               ;;8C34|8C34/8C34\8C34;
                      JSR SubOffscreen0Bnk3               ;;8C36|8C36/8C36\8C36;
                      LDA.W !SpriteMisc1540,X             ;;8C39|8C39/8C39\8C39;
                      BNE +                               ;;8C3C|8C3C/8C3C\8C3C;
                      INC.B !SpriteTableC2,X              ;;8C3E|8C3E/8C3E\8C3E;
                      LDA.B #$80                          ;;8C40|8C40/8C40\8C40;
                      STA.W !SpriteMisc1540,X             ;;8C42|8C42/8C42\8C42;
                    + LDA.B !SpriteTableC2,X              ;;8C45|8C45/8C45\8C45;
                      AND.B #$03                          ;;8C47|8C47/8C47\8C47;
                      TAY                                 ;;8C49|8C49/8C49\8C49;
                      LDA.W DATA_038C2A,Y                 ;;8C4A|8C4A/8C4A\8C4A;
                      STA.B !SpriteXSpeed,X               ;;8C4D|8C4D/8C4D\8C4D;
                      LDA.B !SpriteXSpeed,X               ;;8C4F|8C4F/8C4F\8C4F;
                      LDY.B !SpriteNumber,X               ;;8C51|8C51/8C51\8C51;
                      CPY.B #$B8                          ;;8C53|8C53/8C53\8C53;
                      BEQ +                               ;;8C55|8C55/8C55\8C55;
                      EOR.B #$FF                          ;;8C57|8C57/8C57\8C57;
                      INC A                               ;;8C59|8C59/8C59\8C59;
                    + STA.B !SpriteYSpeed,X               ;;8C5A|8C5A/8C5A\8C5A;
                      JSL UpdateYPosNoGvtyW               ;;8C5C|8C5C/8C5C\8C5C;
                      LDA.B !SpriteXPosLow,X              ;;8C60|8C60/8C60\8C60;
                      STA.W !SpriteMisc151C,X             ;;8C62|8C62/8C62\8C62;
                      JSL UpdateXPosNoGvtyW               ;;8C65|8C65/8C65\8C65;
                      JSR CODE_038CE4                     ;;8C69|8C69/8C69\8C69;
                      JSL GetSpriteClippingA              ;;8C6C|8C6C/8C6C\8C6C;
                      JSL CheckForContact                 ;;8C70|8C70/8C70\8C70;
                      BCC Return038CE3                    ;;8C74|8C74/8C74\8C74;
                      LDA.B !PlayerYSpeed                 ;;8C76|8C76/8C76\8C76;
                      BMI Return038CE3                    ;;8C78|8C78/8C78\8C78;
                      LDA.B !PlayerXPosNext               ;;8C7A|8C7A/8C7A\8C7A;
                      SEC                                 ;;8C7C|8C7C/8C7C\8C7C;
                      SBC.W !SpriteMisc151C,X             ;;8C7D|8C7D/8C7D\8C7D;
                      CLC                                 ;;8C80|8C80/8C80\8C80;
                      ADC.B #$1C                          ;;8C81|8C81/8C81\8C81;
                      LDY.B !SpriteNumber,X               ;;8C83|8C83/8C83\8C83;
                      CPY.B #$B8                          ;;8C85|8C85/8C85\8C85;
                      BNE +                               ;;8C87|8C87/8C87\8C87;
                      CLC                                 ;;8C89|8C89/8C89\8C89;
                      ADC.B #$38                          ;;8C8A|8C8A/8C8A\8C8A;
                    + TAY                                 ;;8C8C|8C8C/8C8C\8C8C;
                      LDA.W !PlayerRidingYoshi            ;;8C8D|8C8D/8C8D\8C8D;
                      CMP.B #$01                          ;;8C90|8C90/8C90\8C90;
                      LDA.B #$20                          ;;8C92|8C92/8C92\8C92;
                      BCC +                               ;;8C94|8C94/8C94\8C94;
                      LDA.B #$30                          ;;8C96|8C96/8C96\8C96;
                    + CLC                                 ;;8C98|8C98/8C98\8C98;
                      ADC.B !PlayerYPosNext               ;;8C99|8C99/8C99\8C99;
                      STA.B !_0                           ;;8C9B|8C9B/8C9B\8C9B;
                      LDA.B !SpriteYPosLow,X              ;;8C9D|8C9D/8C9D\8C9D;
                      CLC                                 ;;8C9F|8C9F/8C9F\8C9F;
                      ADC.W DATA_038BAA,Y                 ;;8CA0|8CA0/8CA0\8CA0;
                      CMP.B !_0                           ;;8CA3|8CA3/8CA3\8CA3;
                      BPL Return038CE3                    ;;8CA5|8CA5/8CA5\8CA5;
                      LDA.W !PlayerRidingYoshi            ;;8CA7|8CA7/8CA7\8CA7;
                      CMP.B #$01                          ;;8CAA|8CAA/8CAA\8CAA;
                      LDA.B #$1D                          ;;8CAC|8CAC/8CAC\8CAC;
                      BCC +                               ;;8CAE|8CAE/8CAE\8CAE;
                      LDA.B #$2D                          ;;8CB0|8CB0/8CB0\8CB0;
                    + STA.B !_0                           ;;8CB2|8CB2/8CB2\8CB2;
                      LDA.B !SpriteYPosLow,X              ;;8CB4|8CB4/8CB4\8CB4;
                      CLC                                 ;;8CB6|8CB6/8CB6\8CB6;
                      ADC.W DATA_038BAA,Y                 ;;8CB7|8CB7/8CB7\8CB7;
                      PHP                                 ;;8CBA|8CBA/8CBA\8CBA;
                      SEC                                 ;;8CBB|8CBB/8CBB\8CBB;
                      SBC.B !_0                           ;;8CBC|8CBC/8CBC\8CBC;
                      STA.B !PlayerYPosNext               ;;8CBE|8CBE/8CBE\8CBE;
                      LDA.W !SpriteXPosHigh,X             ;;8CC0|8CC0/8CC0\8CC0;
                      SBC.B #$00                          ;;8CC3|8CC3/8CC3\8CC3;
                      PLP                                 ;;8CC5|8CC5/8CC5\8CC5;
                      ADC.B #$00                          ;;8CC6|8CC6/8CC6\8CC6;
                      STA.B !PlayerYPosNext+1             ;;8CC8|8CC8/8CC8\8CC8;
                      STZ.B !PlayerYSpeed                 ;;8CCA|8CCA/8CCA\8CCA;
                      LDA.B #$01                          ;;8CCC|8CCC/8CCC\8CCC;
                      STA.W !StandOnSolidSprite           ;;8CCE|8CCE/8CCE\8CCE;
                      LDY.B #$00                          ;;8CD1|8CD1/8CD1\8CD1;
                      LDA.W !SpriteXMovement              ;;8CD3|8CD3/8CD3\8CD3;
                      BPL +                               ;;8CD6|8CD6/8CD6\8CD6;
                      DEY                                 ;;8CD8|8CD8/8CD8\8CD8;
                    + CLC                                 ;;8CD9|8CD9/8CD9\8CD9;
                      ADC.B !PlayerXPosNext               ;;8CDA|8CDA/8CDA\8CDA;
                      STA.B !PlayerXPosNext               ;;8CDC|8CDC/8CDC\8CDC;
                      TYA                                 ;;8CDE|8CDE/8CDE\8CDE;
                      ADC.B !PlayerXPosNext+1             ;;8CDF|8CDF/8CDF\8CDF;
                      STA.B !PlayerXPosNext+1             ;;8CE1|8CE1/8CE1\8CE1;
Return038CE3:         RTS                                 ;;8CE3|8CE3/8CE3\8CE3; Return 
                                                          ;;                   ;
CODE_038CE4:          LDA.B !PlayerXPosNext               ;;8CE4|8CE4/8CE4\8CE4;
                      CLC                                 ;;8CE6|8CE6/8CE6\8CE6;
                      ADC.B #$04                          ;;8CE7|8CE7/8CE7\8CE7;
                      STA.B !_0                           ;;8CE9|8CE9/8CE9\8CE9;
                      LDA.B !PlayerXPosNext+1             ;;8CEB|8CEB/8CEB\8CEB;
                      ADC.B #$00                          ;;8CED|8CED/8CED\8CED;
                      STA.B !_8                           ;;8CEF|8CEF/8CEF\8CEF;
                      LDA.B #$08                          ;;8CF1|8CF1/8CF1\8CF1;
                      STA.B !_2                           ;;8CF3|8CF3/8CF3\8CF3;
                      STA.B !_3                           ;;8CF5|8CF5/8CF5\8CF5;
                      LDA.B #$20                          ;;8CF7|8CF7/8CF7\8CF7;
                      LDY.W !PlayerRidingYoshi            ;;8CF9|8CF9/8CF9\8CF9;
                      BEQ +                               ;;8CFC|8CFC/8CFC\8CFC;
                      LDA.B #$30                          ;;8CFE|8CFE/8CFE\8CFE;
                    + CLC                                 ;;8D00|8D00/8D00\8D00;
                      ADC.B !PlayerYPosNext               ;;8D01|8D01/8D01\8D01;
                      STA.B !_1                           ;;8D03|8D03/8D03\8D03;
                      LDA.B !PlayerYPosNext+1             ;;8D05|8D05/8D05\8D05;
                      ADC.B #$00                          ;;8D07|8D07/8D07\8D07;
                      STA.B !_9                           ;;8D09|8D09/8D09\8D09;
                      RTS                                 ;;8D0B|8D0B/8D0B\8D0B; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DiagPlatDispX:        db $10,$00,$10,$00,$10,$00          ;;8D0C|8D0C/8D0C\8D0C;
                                                          ;;                   ;
DiagPlatDispY:        db $00,$10,$10,$00,$10,$10          ;;8D12|8D12/8D12\8D12;
                                                          ;;                   ;
DiagPlatTiles2:       db $E4,$E0,$E2,$E4,$E0,$E2          ;;8D18|8D18/8D18\8D18;
                                                          ;;                   ;
DiagPlatGfxProp:      db $0B,$0B,$0B,$4B,$4B,$4B          ;;8D1E|8D1E/8D1E\8D1E;
                                                          ;;                   ;
CarrotTopLiftGfx:     JSR GetDrawInfoBnk3                 ;;8D24|8D24/8D24\8D24;
                      PHX                                 ;;8D27|8D27/8D27\8D27;
                      LDA.B !SpriteNumber,X               ;;8D28|8D28/8D28\8D28;
                      CMP.B #$B8                          ;;8D2A|8D2A/8D2A\8D2A;
                      LDX.B #$02                          ;;8D2C|8D2C/8D2C\8D2C;
                      STX.B !_2                           ;;8D2E|8D2E/8D2E\8D2E;
                      BCC CODE_038D34                     ;;8D30|8D30/8D30\8D30;
                      LDX.B #$05                          ;;8D32|8D32/8D32\8D32;
CODE_038D34:          LDA.B !_0                           ;;8D34|8D34/8D34\8D34;
                      CLC                                 ;;8D36|8D36/8D36\8D36;
                      ADC.W DiagPlatDispX,X               ;;8D37|8D37/8D37\8D37;
                      STA.W !OAMTileXPos+$100,Y           ;;8D3A|8D3A/8D3A\8D3A;
                      LDA.B !_1                           ;;8D3D|8D3D/8D3D\8D3D;
                      CLC                                 ;;8D3F|8D3F/8D3F\8D3F;
                      ADC.W DiagPlatDispY,X               ;;8D40|8D40/8D40\8D40;
                      STA.W !OAMTileYPos+$100,Y           ;;8D43|8D43/8D43\8D43;
                      LDA.W DiagPlatTiles2,X              ;;8D46|8D46/8D46\8D46;
                      STA.W !OAMTileNo+$100,Y             ;;8D49|8D49/8D49\8D49;
                      LDA.W DiagPlatGfxProp,X             ;;8D4C|8D4C/8D4C\8D4C;
                      ORA.B !SpriteProperties             ;;8D4F|8D4F/8D4F\8D4F;
                      STA.W !OAMTileAttr+$100,Y           ;;8D51|8D51/8D51\8D51;
                      INY                                 ;;8D54|8D54/8D54\8D54;
                      INY                                 ;;8D55|8D55/8D55\8D55;
                      INY                                 ;;8D56|8D56/8D56\8D56;
                      INY                                 ;;8D57|8D57/8D57\8D57;
                      DEX                                 ;;8D58|8D58/8D58\8D58;
                      DEC.B !_2                           ;;8D59|8D59/8D59\8D59;
                      BPL CODE_038D34                     ;;8D5B|8D5B/8D5B\8D5B;
                      PLX                                 ;;8D5D|8D5D/8D5D\8D5D;
                      LDY.B #$02                          ;;8D5E|8D5E/8D5E\8D5E;
                      TYA                                 ;;8D60|8D60/8D60\8D60;
                      JSL FinishOAMWrite                  ;;8D61|8D61/8D61\8D61;
                      RTS                                 ;;8D65|8D65/8D65\8D65; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_038D66:          db $00,$04,$07,$08,$08,$07,$04,$00  ;;8D66|8D66/8D66\8D66;
                      db $00                              ;;8D6E|8D6E/8D6E\8D6E;
                                                          ;;                   ;
InfoBox:              JSL InvisBlkMainRt                  ;;8D6F|8D6F/8D6F\8D6F;
                      JSR SubOffscreen0Bnk3               ;;8D73|8D73/8D73\8D73;
                      LDA.W !SpriteMisc1558,X             ;;8D76|8D76/8D76\8D76;
                      CMP.B #$01                          ;;8D79|8D79/8D79\8D79;
                      BNE +                               ;;8D7B|8D7B/8D7B\8D7B;
                      LDA.B #$22                          ;;8D7D|8D7D/8D7D\8D7D; \ Play sound effect 
                      STA.W !SPCIO3                       ;;8D7F|8D7F/8D7F\8D7F; / 
                      STZ.W !SpriteMisc1558,X             ;;8D82|8D82/8D82\8D82;
                      STZ.B !SpriteTableC2,X              ;;8D85|8D85/8D85\8D85;
                      LDA.B !SpriteXPosLow,X              ;;8D87|8D87/8D87\8D87;
                      LSR A                               ;;8D89|8D89/8D89\8D89;
                      LSR A                               ;;8D8A|8D8A/8D8A\8D8A;
                      LSR A                               ;;8D8B|8D8B/8D8B\8D8B;
                      LSR A                               ;;8D8C|8D8C/8D8C\8D8C;
                      AND.B #$01                          ;;8D8D|8D8D/8D8D\8D8D;
                      INC A                               ;;8D8F|8D8F/8D8F\8D8F;
                      STA.W !MessageBoxTrigger            ;;8D90|8D90/8D90\8D90;
                    + LDA.W !SpriteMisc1558,X             ;;8D93|8D93/8D93\8D93;
                      LSR A                               ;;8D96|8D96/8D96\8D96;
                      TAY                                 ;;8D97|8D97/8D97\8D97;
                      LDA.B !Layer1YPos                   ;;8D98|8D98/8D98\8D98;
                      PHA                                 ;;8D9A|8D9A/8D9A\8D9A;
                      CLC                                 ;;8D9B|8D9B/8D9B\8D9B;
                      ADC.W DATA_038D66,Y                 ;;8D9C|8D9C/8D9C\8D9C;
                      STA.B !Layer1YPos                   ;;8D9F|8D9F/8D9F\8D9F;
                      LDA.B !Layer1YPos+1                 ;;8DA1|8DA1/8DA1\8DA1;
                      PHA                                 ;;8DA3|8DA3/8DA3\8DA3;
                      ADC.B #$00                          ;;8DA4|8DA4/8DA4\8DA4;
                      STA.B !Layer1YPos+1                 ;;8DA6|8DA6/8DA6\8DA6;
                      JSL GenericSprGfxRt2                ;;8DA8|8DA8/8DA8\8DA8;
                      LDY.W !SpriteOAMIndex,X             ;;8DAC|8DAC/8DAC\8DAC; Y = Index into sprite OAM 
                      LDA.B #$C0                          ;;8DAF|8DAF/8DAF\8DAF;
                      STA.W !OAMTileNo+$100,Y             ;;8DB1|8DB1/8DB1\8DB1;
                      PLA                                 ;;8DB4|8DB4/8DB4\8DB4;
                      STA.B !Layer1YPos+1                 ;;8DB5|8DB5/8DB5\8DB5;
                      PLA                                 ;;8DB7|8DB7/8DB7\8DB7;
                      STA.B !Layer1YPos                   ;;8DB8|8DB8/8DB8\8DB8;
                      RTS                                 ;;8DBA|8DBA/8DBA\8DBA; Return 
                                                          ;;                   ;
TimedLift:            JSR TimedPlatformGfx                ;;8DBB|8DBB/8DBB\8DBB;
                      LDA.B !SpriteLock                   ;;8DBE|8DBE/8DBE\8DBE;
                      BNE Return038DEF                    ;;8DC0|8DC0/8DC0\8DC0;
                      JSR SubOffscreen0Bnk3               ;;8DC2|8DC2/8DC2\8DC2;
                      LDA.B !TrueFrame                    ;;8DC5|8DC5/8DC5\8DC5;
                      AND.B #$00                          ;;8DC7|8DC7/8DC7\8DC7;
                      BNE +                               ;;8DC9|8DC9/8DC9\8DC9;
                      LDA.B !SpriteTableC2,X              ;;8DCB|8DCB/8DCB\8DCB;
                      BEQ +                               ;;8DCD|8DCD/8DCD\8DCD;
                      LDA.W !SpriteMisc1570,X             ;;8DCF|8DCF/8DCF\8DCF;
                      BEQ +                               ;;8DD2|8DD2/8DD2\8DD2;
                      DEC.W !SpriteMisc1570,X             ;;8DD4|8DD4/8DD4\8DD4;
                    + LDA.W !SpriteMisc1570,X             ;;8DD7|8DD7/8DD7\8DD7;
                      BEQ CODE_038DF0                     ;;8DDA|8DDA/8DDA\8DDA;
                      JSL UpdateXPosNoGvtyW               ;;8DDC|8DDC/8DDC\8DDC;
                      STA.W !SpriteMisc1528,X             ;;8DE0|8DE0/8DE0\8DE0;
                      JSL InvisBlkMainRt                  ;;8DE3|8DE3/8DE3\8DE3;
                      BCC Return038DEF                    ;;8DE7|8DE7/8DE7\8DE7;
                      LDA.B #$10                          ;;8DE9|8DE9/8DE9\8DE9;
                      STA.B !SpriteXSpeed,X               ;;8DEB|8DEB/8DEB\8DEB;
                      STA.B !SpriteTableC2,X              ;;8DED|8DED/8DED\8DED;
Return038DEF:         RTS                                 ;;8DEF|8DEF/8DEF\8DEF; Return 
                                                          ;;                   ;
CODE_038DF0:          JSL UpdateSpritePos                 ;;8DF0|8DF0/8DF0\8DF0;
                      LDA.W !SpriteXMovement              ;;8DF4|8DF4/8DF4\8DF4;
                      STA.W !SpriteMisc1528,X             ;;8DF7|8DF7/8DF7\8DF7;
                      JSL InvisBlkMainRt                  ;;8DFA|8DFA/8DFA\8DFA;
                      RTS                                 ;;8DFE|8DFE/8DFE\8DFE; Return 
                                                          ;;                   ;
                                                          ;;                   ;
TimedPlatDispX:       db $00,$10,$0C                      ;;8DFF|8DFF/8DFF\8DFF;
                                                          ;;                   ;
TimedPlatDispY:       db $00,$00,$04                      ;;8E02|8E02/8E02\8E02;
                                                          ;;                   ;
TimedPlatTiles:       db $C4,$C4,$00                      ;;8E05|8E05/8E05\8E05;
                                                          ;;                   ;
TimedPlatGfxProp:     db $0B,$4B,$0B                      ;;8E08|8E08/8E08\8E08;
                                                          ;;                   ;
TimedPlatTileSize:    db $02,$02,$00                      ;;8E0B|8E0B/8E0B\8E0B;
                                                          ;;                   ;
TimedPlatNumTiles:    db $B6,$B5,$B4,$B3                  ;;8E0E|8E0E/8E0E\8E0E;
                                                          ;;                   ;
TimedPlatformGfx:     JSR GetDrawInfoBnk3                 ;;8E12|8E12/8E12\8E12;
                      LDA.W !SpriteMisc1570,X             ;;8E15|8E15/8E15\8E15;
                      PHX                                 ;;8E18|8E18/8E18\8E18;
                      PHA                                 ;;8E19|8E19/8E19\8E19;
                      LSR A                               ;;8E1A|8E1A/8E1A\8E1A;
                      LSR A                               ;;8E1B|8E1B/8E1B\8E1B;
                      LSR A                               ;;8E1C|8E1C/8E1C\8E1C;
                      LSR A                               ;;8E1D|8E1D/8E1D\8E1D;
                      LSR A                               ;;8E1E|8E1E/8E1E\8E1E;
                      LSR A                               ;;8E1F|8E1F/8E1F\8E1F;
                      TAX                                 ;;8E20|8E20/8E20\8E20;
                      LDA.W TimedPlatNumTiles,X           ;;8E21|8E21/8E21\8E21;
                      STA.B !_2                           ;;8E24|8E24/8E24\8E24;
                      LDX.B #$02                          ;;8E26|8E26/8E26\8E26;
                      PLA                                 ;;8E28|8E28/8E28\8E28;
                      CMP.B #$08                          ;;8E29|8E29/8E29\8E29;
                      BCS CODE_038E2E                     ;;8E2B|8E2B/8E2B\8E2B;
                      DEX                                 ;;8E2D|8E2D/8E2D\8E2D;
CODE_038E2E:          LDA.B !_0                           ;;8E2E|8E2E/8E2E\8E2E;
                      CLC                                 ;;8E30|8E30/8E30\8E30;
                      ADC.W TimedPlatDispX,X              ;;8E31|8E31/8E31\8E31;
                      STA.W !OAMTileXPos+$100,Y           ;;8E34|8E34/8E34\8E34;
                      LDA.B !_1                           ;;8E37|8E37/8E37\8E37;
                      CLC                                 ;;8E39|8E39/8E39\8E39;
                      ADC.W TimedPlatDispY,X              ;;8E3A|8E3A/8E3A\8E3A;
                      STA.W !OAMTileYPos+$100,Y           ;;8E3D|8E3D/8E3D\8E3D;
                      LDA.W TimedPlatTiles,X              ;;8E40|8E40/8E40\8E40;
                      CPX.B #$02                          ;;8E43|8E43/8E43\8E43;
                      BNE +                               ;;8E45|8E45/8E45\8E45;
                      LDA.B !_2                           ;;8E47|8E47/8E47\8E47;
                    + STA.W !OAMTileNo+$100,Y             ;;8E49|8E49/8E49\8E49;
                      LDA.W TimedPlatGfxProp,X            ;;8E4C|8E4C/8E4C\8E4C;
                      ORA.B !SpriteProperties             ;;8E4F|8E4F/8E4F\8E4F;
                      STA.W !OAMTileAttr+$100,Y           ;;8E51|8E51/8E51\8E51;
                      PHY                                 ;;8E54|8E54/8E54\8E54;
                      TYA                                 ;;8E55|8E55/8E55\8E55;
                      LSR A                               ;;8E56|8E56/8E56\8E56;
                      LSR A                               ;;8E57|8E57/8E57\8E57;
                      TAY                                 ;;8E58|8E58/8E58\8E58;
                      LDA.W TimedPlatTileSize,X           ;;8E59|8E59/8E59\8E59;
                      STA.W !OAMTileSize+$40,Y            ;;8E5C|8E5C/8E5C\8E5C;
                      PLY                                 ;;8E5F|8E5F/8E5F\8E5F;
                      INY                                 ;;8E60|8E60/8E60\8E60;
                      INY                                 ;;8E61|8E61/8E61\8E61;
                      INY                                 ;;8E62|8E62/8E62\8E62;
                      INY                                 ;;8E63|8E63/8E63\8E63;
                      DEX                                 ;;8E64|8E64/8E64\8E64;
                      BPL CODE_038E2E                     ;;8E65|8E65/8E65\8E65;
                      PLX                                 ;;8E67|8E67/8E67\8E67;
                      LDY.B #$FF                          ;;8E68|8E68/8E68\8E68;
                      LDA.B #$02                          ;;8E6A|8E6A/8E6A\8E6A;
                      JSL FinishOAMWrite                  ;;8E6C|8E6C/8E6C\8E6C;
                      RTS                                 ;;8E70|8E70/8E70\8E70; Return 
                                                          ;;                   ;
                                                          ;;                   ;
GreyMoveBlkSpeed:     db $00,$F0,$00,$10                  ;;8E71|8E71/8E71\8E71;
                                                          ;;                   ;
GreyMoveBlkTiming:    db $40,$50,$40,$50                  ;;8E75|8E75/8E75\8E75;
                                                          ;;                   ;
GreyCastleBlock:      JSR CODE_038EB4                     ;;8E79|8E79/8E79\8E79;
                      LDA.B !SpriteLock                   ;;8E7C|8E7C/8E7C\8E7C;
                      BNE Return038EA7                    ;;8E7E|8E7E/8E7E\8E7E;
                      LDA.W !SpriteMisc1540,X             ;;8E80|8E80/8E80\8E80;
                      BNE +                               ;;8E83|8E83/8E83\8E83;
                      INC.B !SpriteTableC2,X              ;;8E85|8E85/8E85\8E85;
                      LDA.B !SpriteTableC2,X              ;;8E87|8E87/8E87\8E87;
                      AND.B #$03                          ;;8E89|8E89/8E89\8E89;
                      TAY                                 ;;8E8B|8E8B/8E8B\8E8B;
                      LDA.W GreyMoveBlkTiming,Y           ;;8E8C|8E8C/8E8C\8E8C;
                      STA.W !SpriteMisc1540,X             ;;8E8F|8E8F/8E8F\8E8F;
                    + LDA.B !SpriteTableC2,X              ;;8E92|8E92/8E92\8E92;
                      AND.B #$03                          ;;8E94|8E94/8E94\8E94;
                      TAY                                 ;;8E96|8E96/8E96\8E96;
                      LDA.W GreyMoveBlkSpeed,Y            ;;8E97|8E97/8E97\8E97;
                      STA.B !SpriteXSpeed,X               ;;8E9A|8E9A/8E9A\8E9A;
                      JSL UpdateXPosNoGvtyW               ;;8E9C|8E9C/8E9C\8E9C;
                      STA.W !SpriteMisc1528,X             ;;8EA0|8EA0/8EA0\8EA0;
                      JSL InvisBlkMainRt                  ;;8EA3|8EA3/8EA3\8EA3;
Return038EA7:         RTS                                 ;;8EA7|8EA7/8EA7\8EA7; Return 
                                                          ;;                   ;
                                                          ;;                   ;
GreyMoveBlkDispX:     db $00,$10,$00,$10                  ;;8EA8|8EA8/8EA8\8EA8;
                                                          ;;                   ;
GreyMoveBlkDispY:     db $00,$00,$10,$10                  ;;8EAC|8EAC/8EAC\8EAC;
                                                          ;;                   ;
GreyMoveBlkTiles:     db $CC,$CE,$EC,$EE                  ;;8EB0|8EB0/8EB0\8EB0;
                                                          ;;                   ;
CODE_038EB4:          JSR GetDrawInfoBnk3                 ;;8EB4|8EB4/8EB4\8EB4;
                      PHX                                 ;;8EB7|8EB7/8EB7\8EB7;
                      LDX.B #$03                          ;;8EB8|8EB8/8EB8\8EB8;
                    - LDA.B !_0                           ;;8EBA|8EBA/8EBA\8EBA;
                      CLC                                 ;;8EBC|8EBC/8EBC\8EBC;
                      ADC.W GreyMoveBlkDispX,X            ;;8EBD|8EBD/8EBD\8EBD;
                      STA.W !OAMTileXPos+$100,Y           ;;8EC0|8EC0/8EC0\8EC0;
                      LDA.B !_1                           ;;8EC3|8EC3/8EC3\8EC3;
                      CLC                                 ;;8EC5|8EC5/8EC5\8EC5;
                      ADC.W GreyMoveBlkDispY,X            ;;8EC6|8EC6/8EC6\8EC6;
                      STA.W !OAMTileYPos+$100,Y           ;;8EC9|8EC9/8EC9\8EC9;
                      LDA.W GreyMoveBlkTiles,X            ;;8ECC|8ECC/8ECC\8ECC;
                      STA.W !OAMTileNo+$100,Y             ;;8ECF|8ECF/8ECF\8ECF;
                      LDA.B #$03                          ;;8ED2|8ED2/8ED2\8ED2;
                      ORA.B !SpriteProperties             ;;8ED4|8ED4/8ED4\8ED4;
                      STA.W !OAMTileAttr+$100,Y           ;;8ED6|8ED6/8ED6\8ED6;
                      INY                                 ;;8ED9|8ED9/8ED9\8ED9;
                      INY                                 ;;8EDA|8EDA/8EDA\8EDA;
                      INY                                 ;;8EDB|8EDB/8EDB\8EDB;
                      INY                                 ;;8EDC|8EDC/8EDC\8EDC;
                      DEX                                 ;;8EDD|8EDD/8EDD\8EDD;
                      BPL -                               ;;8EDE|8EDE/8EDE\8EDE;
                      PLX                                 ;;8EE0|8EE0/8EE0\8EE0;
                      LDY.B #$02                          ;;8EE1|8EE1/8EE1\8EE1;
                      LDA.B #$03                          ;;8EE3|8EE3/8EE3\8EE3;
                      JSL FinishOAMWrite                  ;;8EE5|8EE5/8EE5\8EE5;
                      RTS                                 ;;8EE9|8EE9/8EE9\8EE9; Return 
                                                          ;;                   ;
                                                          ;;                   ;
StatueFireSpeed:      db $10,$F0                          ;;8EEA|8EEA/8EEA\8EEA;
                                                          ;;                   ;
StatueFireball:       JSR StatueFireballGfx               ;;8EEC|8EEC/8EEC\8EEC;
                      LDA.B !SpriteLock                   ;;8EEF|8EEF/8EEF\8EEF;
                      BNE +                               ;;8EF1|8EF1/8EF1\8EF1;
                      JSR SubOffscreen0Bnk3               ;;8EF3|8EF3/8EF3\8EF3;
                      JSL MarioSprInteract                ;;8EF6|8EF6/8EF6\8EF6;
                      LDY.W !SpriteMisc157C,X             ;;8EFA|8EFA/8EFA\8EFA;
                      LDA.W StatueFireSpeed,Y             ;;8EFD|8EFD/8EFD\8EFD;
                      STA.B !SpriteXSpeed,X               ;;8F00|8F00/8F00\8F00;
                      JSL UpdateXPosNoGvtyW               ;;8F02|8F02/8F02\8F02;
                    + RTS                                 ;;8F06|8F06/8F06\8F06; Return 
                                                          ;;                   ;
                                                          ;;                   ;
StatueFireDispX:      db $08,$00,$00,$08                  ;;8F07|8F07/8F07\8F07;
                                                          ;;                   ;
StatueFireTiles:      db $32,$50,$33,$34,$32,$50,$33,$34  ;;8F0B|8F0B/8F0B\8F0B;
StatueFireGfxProp:    db $09,$09,$09,$09,$89,$89,$89,$89  ;;8F13|8F13/8F13\8F13;
                                                          ;;                   ;
StatueFireballGfx:    JSR GetDrawInfoBnk3                 ;;8F1B|8F1B/8F1B\8F1B;
                      LDA.W !SpriteMisc157C,X             ;;8F1E|8F1E/8F1E\8F1E;
                      ASL A                               ;;8F21|8F21/8F21\8F21;
                      STA.B !_2                           ;;8F22|8F22/8F22\8F22;
                      LDA.B !EffFrame                     ;;8F24|8F24/8F24\8F24;
                      LSR A                               ;;8F26|8F26/8F26\8F26;
                      AND.B #$03                          ;;8F27|8F27/8F27\8F27;
                      ASL A                               ;;8F29|8F29/8F29\8F29;
                      STA.B !_3                           ;;8F2A|8F2A/8F2A\8F2A;
                      PHX                                 ;;8F2C|8F2C/8F2C\8F2C;
                      LDX.B #$01                          ;;8F2D|8F2D/8F2D\8F2D;
CODE_038F2F:          LDA.B !_1                           ;;8F2F|8F2F/8F2F\8F2F;
                      STA.W !OAMTileYPos+$100,Y           ;;8F31|8F31/8F31\8F31;
                      PHX                                 ;;8F34|8F34/8F34\8F34;
                      TXA                                 ;;8F35|8F35/8F35\8F35;
                      ORA.B !_2                           ;;8F36|8F36/8F36\8F36;
                      TAX                                 ;;8F38|8F38/8F38\8F38;
                      LDA.B !_0                           ;;8F39|8F39/8F39\8F39;
                      CLC                                 ;;8F3B|8F3B/8F3B\8F3B;
                      ADC.W StatueFireDispX,X             ;;8F3C|8F3C/8F3C\8F3C;
                      STA.W !OAMTileXPos+$100,Y           ;;8F3F|8F3F/8F3F\8F3F;
                      PLA                                 ;;8F42|8F42/8F42\8F42;
                      PHA                                 ;;8F43|8F43/8F43\8F43;
                      ORA.B !_3                           ;;8F44|8F44/8F44\8F44;
                      TAX                                 ;;8F46|8F46/8F46\8F46;
                      LDA.W StatueFireTiles,X             ;;8F47|8F47/8F47\8F47;
                      STA.W !OAMTileNo+$100,Y             ;;8F4A|8F4A/8F4A\8F4A;
                      LDA.W StatueFireGfxProp,X           ;;8F4D|8F4D/8F4D\8F4D;
                      LDX.B !_2                           ;;8F50|8F50/8F50\8F50;
                      BNE +                               ;;8F52|8F52/8F52\8F52;
                      EOR.B #$40                          ;;8F54|8F54/8F54\8F54;
                    + ORA.B !SpriteProperties             ;;8F56|8F56/8F56\8F56;
                      STA.W !OAMTileAttr+$100,Y           ;;8F58|8F58/8F58\8F58;
                      PLX                                 ;;8F5B|8F5B/8F5B\8F5B;
                      INY                                 ;;8F5C|8F5C/8F5C\8F5C;
                      INY                                 ;;8F5D|8F5D/8F5D\8F5D;
                      INY                                 ;;8F5E|8F5E/8F5E\8F5E;
                      INY                                 ;;8F5F|8F5F/8F5F\8F5F;
                      DEX                                 ;;8F60|8F60/8F60\8F60;
                      BPL CODE_038F2F                     ;;8F61|8F61/8F61\8F61;
                      PLX                                 ;;8F63|8F63/8F63\8F63;
                      LDY.B #$00                          ;;8F64|8F64/8F64\8F64;
                      LDA.B #$01                          ;;8F66|8F66/8F66\8F66;
                      JSL FinishOAMWrite                  ;;8F68|8F68/8F68\8F68;
                      RTS                                 ;;8F6C|8F6C/8F6C\8F6C; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BooStreamFrntTiles:   db $88,$8C,$8E,$A8,$AA,$AE,$88,$8C  ;;8F6D|8F6D/8F6D\8F6D;
                                                          ;;                   ;
ReflectingFireball:   JSR CODE_038FF2                     ;;8F75|8F75/8F75\8F75;
                      BRA CODE_038FA4                     ;;8F78|8F78/8F78\8F78;
                                                          ;;                   ;
BooStream:            LDA.B #$00                          ;;8F7A|8F7A/8F7A\8F7A;
                      LDY.B !SpriteXSpeed,X               ;;8F7C|8F7C/8F7C\8F7C;
                      BPL +                               ;;8F7E|8F7E/8F7E\8F7E;
                      INC A                               ;;8F80|8F80/8F80\8F80;
                    + STA.W !SpriteMisc157C,X             ;;8F81|8F81/8F81\8F81;
                      JSL GenericSprGfxRt2                ;;8F84|8F84/8F84\8F84;
                      LDY.W !SpriteOAMIndex,X             ;;8F88|8F88/8F88\8F88; Y = Index into sprite OAM 
                      LDA.B !EffFrame                     ;;8F8B|8F8B/8F8B\8F8B;
                      LSR A                               ;;8F8D|8F8D/8F8D\8F8D;
                      LSR A                               ;;8F8E|8F8E/8F8E\8F8E;
                      LSR A                               ;;8F8F|8F8F/8F8F\8F8F;
                      LSR A                               ;;8F90|8F90/8F90\8F90;
                      AND.B #$01                          ;;8F91|8F91/8F91\8F91;
                      STA.B !_0                           ;;8F93|8F93/8F93\8F93;
                      TXA                                 ;;8F95|8F95/8F95\8F95;
                      AND.B #$03                          ;;8F96|8F96/8F96\8F96;
                      ASL A                               ;;8F98|8F98/8F98\8F98;
                      ORA.B !_0                           ;;8F99|8F99/8F99\8F99;
                      PHX                                 ;;8F9B|8F9B/8F9B\8F9B;
                      TAX                                 ;;8F9C|8F9C/8F9C\8F9C;
                      LDA.W BooStreamFrntTiles,X          ;;8F9D|8F9D/8F9D\8F9D;
                      STA.W !OAMTileNo+$100,Y             ;;8FA0|8FA0/8FA0\8FA0;
                      PLX                                 ;;8FA3|8FA3/8FA3\8FA3;
CODE_038FA4:          LDA.W !SpriteStatus,X               ;;8FA4|8FA4/8FA4\8FA4;
                      CMP.B #$08                          ;;8FA7|8FA7/8FA7\8FA7;
                      BNE Return038FF1                    ;;8FA9|8FA9/8FA9\8FA9;
                      LDA.B !SpriteLock                   ;;8FAB|8FAB/8FAB\8FAB;
                      BNE Return038FF1                    ;;8FAD|8FAD/8FAD\8FAD;
                      TXA                                 ;;8FAF|8FAF/8FAF\8FAF;
                      EOR.B !EffFrame                     ;;8FB0|8FB0/8FB0\8FB0;
                      AND.B #$07                          ;;8FB2|8FB2/8FB2\8FB2;
                      ORA.W !SpriteOffscreenVert,X        ;;8FB4|8FB4/8FB4\8FB4;
                      BNE +                               ;;8FB7|8FB7/8FB7\8FB7;
                      LDA.B !SpriteNumber,X               ;;8FB9|8FB9/8FB9\8FB9;
                      CMP.B #$B0                          ;;8FBB|8FBB/8FBB\8FBB;
                      BNE +                               ;;8FBD|8FBD/8FBD\8FBD;
                      JSR CODE_039020                     ;;8FBF|8FBF/8FBF\8FBF;
                    + JSL UpdateYPosNoGvtyW               ;;8FC2|8FC2/8FC2\8FC2;
                      JSL UpdateXPosNoGvtyW               ;;8FC6|8FC6/8FC6\8FC6;
                      JSL CODE_019138                     ;;8FCA|8FCA/8FCA\8FCA;
                      LDA.W !SpriteBlockedDirs,X          ;;8FCE|8FCE/8FCE\8FCE; \ Branch if not touching object 
                      AND.B #$03                          ;;8FD1|8FD1/8FD1\8FD1;  | 
                      BEQ +                               ;;8FD3|8FD3/8FD3\8FD3; / 
                      LDA.B !SpriteXSpeed,X               ;;8FD5|8FD5/8FD5\8FD5;
                      EOR.B #$FF                          ;;8FD7|8FD7/8FD7\8FD7;
                      INC A                               ;;8FD9|8FD9/8FD9\8FD9;
                      STA.B !SpriteXSpeed,X               ;;8FDA|8FDA/8FDA\8FDA;
                    + LDA.W !SpriteBlockedDirs,X          ;;8FDC|8FDC/8FDC\8FDC;
                      AND.B #$0C                          ;;8FDF|8FDF/8FDF\8FDF;
                      BEQ +                               ;;8FE1|8FE1/8FE1\8FE1;
                      LDA.B !SpriteYSpeed,X               ;;8FE3|8FE3/8FE3\8FE3;
                      EOR.B #$FF                          ;;8FE5|8FE5/8FE5\8FE5;
                      INC A                               ;;8FE7|8FE7/8FE7\8FE7;
                      STA.B !SpriteYSpeed,X               ;;8FE8|8FE8/8FE8\8FE8;
                    + JSL MarioSprInteract                ;;8FEA|8FEA/8FEA\8FEA;
                      JSR SubOffscreen0Bnk3               ;;8FEE|8FEE/8FEE\8FEE;
Return038FF1:         RTS                                 ;;8FF1|8FF1/8FF1\8FF1; Return 
                                                          ;;                   ;
CODE_038FF2:          JSL GenericSprGfxRt2                ;;8FF2|8FF2/8FF2\8FF2;
                      LDA.B !EffFrame                     ;;8FF6|8FF6/8FF6\8FF6;
                      LSR A                               ;;8FF8|8FF8/8FF8\8FF8;
                      LSR A                               ;;8FF9|8FF9/8FF9\8FF9;
                      LDA.B #$04                          ;;8FFA|8FFA/8FFA\8FFA;
                      BCC +                               ;;8FFC|8FFC/8FFC\8FFC;
                      ASL A                               ;;8FFE|8FFE/8FFE\8FFE;
                    + LDY.B !SpriteXSpeed,X               ;;8FFF|8FFF/8FFF\8FFF;
                      BPL +                               ;;9001|9001/9001\9001;
                      EOR.B #$40                          ;;9003|9003/9003\9003;
                    + LDY.B !SpriteYSpeed,X               ;;9005|9005/9005\9005;
                      BMI +                               ;;9007|9007/9007\9007;
                      EOR.B #$80                          ;;9009|9009/9009\9009;
                    + STA.B !_0                           ;;900B|900B/900B\900B;
                      LDY.W !SpriteOAMIndex,X             ;;900D|900D/900D\900D; Y = Index into sprite OAM 
                      LDA.B #$AC                          ;;9010|9010/9010\9010;
                      STA.W !OAMTileNo+$100,Y             ;;9012|9012/9012\9012;
                      LDA.W !OAMTileAttr+$100,Y           ;;9015|9015/9015\9015;
                      AND.B #$31                          ;;9018|9018/9018\9018;
                      ORA.B !_0                           ;;901A|901A/901A\901A;
                      STA.W !OAMTileAttr+$100,Y           ;;901C|901C/901C\901C;
                      RTS                                 ;;901F|901F/901F\901F; Return 
                                                          ;;                   ;
CODE_039020:          LDY.B #$0B                          ;;9020|9020/9020\9020;
CODE_039022:          LDA.W !MinExtSpriteNumber,Y         ;;9022|9022/9022\9022;
                      BEQ CODE_039037                     ;;9025|9025/9025\9025;
                      DEY                                 ;;9027|9027/9027\9027;
                      BPL CODE_039022                     ;;9028|9028/9028\9028;
                      DEC.W !MinExtSpriteSlotIdx          ;;902A|902A/902A\902A;
                      BPL +                               ;;902D|902D/902D\902D;
                      LDA.B #$0B                          ;;902F|902F/902F\902F;
                      STA.W !MinExtSpriteSlotIdx          ;;9031|9031/9031\9031;
                    + LDY.W !MinExtSpriteSlotIdx          ;;9034|9034/9034\9034;
CODE_039037:          LDA.B #$0A                          ;;9037|9037/9037\9037;
                      STA.W !MinExtSpriteNumber,Y         ;;9039|9039/9039\9039;
                      LDA.B !SpriteXPosLow,X              ;;903C|903C/903C\903C;
                      STA.W !MinExtSpriteXPosLow,Y        ;;903E|903E/903E\903E;
                      LDA.W !SpriteYPosHigh,X             ;;9041|9041/9041\9041;
                      STA.W !MinExtSpriteXPosHigh,Y       ;;9044|9044/9044\9044;
                      LDA.B !SpriteYPosLow,X              ;;9047|9047/9047\9047;
                      STA.W !MinExtSpriteYPosLow,Y        ;;9049|9049/9049\9049;
                      LDA.W !SpriteXPosHigh,X             ;;904C|904C/904C\904C;
                      STA.W !MinExtSpriteYPosHigh,Y       ;;904F|904F/904F\904F;
                      LDA.B #$30                          ;;9052|9052/9052\9052;
                      STA.W !MinExtSpriteXPosSpx,Y        ;;9054|9054/9054\9054;
                      LDA.B !SpriteXSpeed,X               ;;9057|9057/9057\9057;
                      STA.W !MinExtSpriteXSpeed,Y         ;;9059|9059/9059\9059;
                      RTS                                 ;;905C|905C/905C\905C; Return 
                                                          ;;                   ;
                                                          ;;                   ;
FishinBooAccelX:      db $01,$FF                          ;;905D|905D/905D\905D;
                                                          ;;                   ;
FishinBooMaxSpeedX:   db $20,$E0                          ;;905F|905F/905F\905F;
                                                          ;;                   ;
FishinBooAccelY:      db $01,$FF                          ;;9061|9061/9061\9061;
                                                          ;;                   ;
FishinBooMaxSpeedY:   db $10,$F0                          ;;9063|9063/9063\9063;
                                                          ;;                   ;
FishinBoo:            JSR FishinBooGfx                    ;;9065|9065/9065\9065;
                      LDA.B !SpriteLock                   ;;9068|9068/9068\9068;
                      BNE Return0390EA                    ;;906A|906A/906A\906A;
                      JSL MarioSprInteract                ;;906C|906C/906C\906C;
                      JSR SubHorzPosBnk3                  ;;9070|9070/9070\9070;
                      STZ.W !SpriteMisc1602,X             ;;9073|9073/9073\9073;
                      LDA.W !SpriteMisc15AC,X             ;;9076|9076/9076\9076;
                      BEQ +                               ;;9079|9079/9079\9079;
                      INC.W !SpriteMisc1602,X             ;;907B|907B/907B\907B;
                      CMP.B #$10                          ;;907E|907E/907E\907E;
                      BNE +                               ;;9080|9080/9080\9080;
                      TYA                                 ;;9082|9082/9082\9082;
                      STA.W !SpriteMisc157C,X             ;;9083|9083/9083\9083;
                    + TXA                                 ;;9086|9086/9086\9086;
                      ASL A                               ;;9087|9087/9087\9087;
                      ASL A                               ;;9088|9088/9088\9088;
                      ASL A                               ;;9089|9089/9089\9089;
                      ASL A                               ;;908A|908A/908A\908A;
                      ADC.B !TrueFrame                    ;;908B|908B/908B\908B;
                      AND.B #$3F                          ;;908D|908D/908D\908D;
                      ORA.W !SpriteMisc15AC,X             ;;908F|908F/908F\908F;
                      BNE +                               ;;9092|9092/9092\9092;
                      LDA.B #$20                          ;;9094|9094/9094\9094;
                      STA.W !SpriteMisc15AC,X             ;;9096|9096/9096\9096;
                    + LDA.W !SpriteWillAppear             ;;9099|9099/9099\9099;
                      BEQ +                               ;;909C|909C/909C\909C;
                      TYA                                 ;;909E|909E/909E\909E;
                      EOR.B #$01                          ;;909F|909F/909F\909F;
                      TAY                                 ;;90A1|90A1/90A1\90A1;
                    + LDA.B !SpriteXSpeed,X               ;;90A2|90A2/90A2\90A2; \ If not at max X speed, accelerate 
                      CMP.W FishinBooMaxSpeedX,Y          ;;90A4|90A4/90A4\90A4;  | 
                      BEQ +                               ;;90A7|90A7/90A7\90A7;  | 
                      CLC                                 ;;90A9|90A9/90A9\90A9;  | 
                      ADC.W FishinBooAccelX,Y             ;;90AA|90AA/90AA\90AA;  | 
                      STA.B !SpriteXSpeed,X               ;;90AD|90AD/90AD\90AD; / 
                    + LDA.B !TrueFrame                    ;;90AF|90AF/90AF\90AF;
                      AND.B #$01                          ;;90B1|90B1/90B1\90B1;
                      BNE +                               ;;90B3|90B3/90B3\90B3;
                      LDA.B !SpriteTableC2,X              ;;90B5|90B5/90B5\90B5;
                      AND.B #$01                          ;;90B7|90B7/90B7\90B7;
                      TAY                                 ;;90B9|90B9/90B9\90B9;
                      LDA.B !SpriteYSpeed,X               ;;90BA|90BA/90BA\90BA;
                      CLC                                 ;;90BC|90BC/90BC\90BC;
                      ADC.W FishinBooAccelY,Y             ;;90BD|90BD/90BD\90BD;
                      STA.B !SpriteYSpeed,X               ;;90C0|90C0/90C0\90C0;
                      CMP.W FishinBooMaxSpeedY,Y          ;;90C2|90C2/90C2\90C2;
                      BNE +                               ;;90C5|90C5/90C5\90C5;
                      INC.B !SpriteTableC2,X              ;;90C7|90C7/90C7\90C7;
                    + LDA.B !SpriteXSpeed,X               ;;90C9|90C9/90C9\90C9;
                      PHA                                 ;;90CB|90CB/90CB\90CB;
                      LDY.W !SpriteWillAppear             ;;90CC|90CC/90CC\90CC;
                      BNE +                               ;;90CF|90CF/90CF\90CF;
                      LDA.W !Layer1DXPos                  ;;90D1|90D1/90D1\90D1;
                      ASL A                               ;;90D4|90D4/90D4\90D4;
                      ASL A                               ;;90D5|90D5/90D5\90D5;
                      ASL A                               ;;90D6|90D6/90D6\90D6;
                      CLC                                 ;;90D7|90D7/90D7\90D7;
                      ADC.B !SpriteXSpeed,X               ;;90D8|90D8/90D8\90D8;
                      STA.B !SpriteXSpeed,X               ;;90DA|90DA/90DA\90DA;
                    + JSL UpdateXPosNoGvtyW               ;;90DC|90DC/90DC\90DC;
                      PLA                                 ;;90E0|90E0/90E0\90E0;
                      STA.B !SpriteXSpeed,X               ;;90E1|90E1/90E1\90E1;
                      JSL UpdateYPosNoGvtyW               ;;90E3|90E3/90E3\90E3;
                      JSR CODE_0390F3                     ;;90E7|90E7/90E7\90E7;
Return0390EA:         RTS                                 ;;90EA|90EA/90EA\90EA; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_0390EB:          db $1A,$14,$EE,$F8                  ;;90EB|90EB/90EB\90EB;
                                                          ;;                   ;
DATA_0390EF:          db $00,$00,$FF,$FF                  ;;90EF|90EF/90EF\90EF;
                                                          ;;                   ;
CODE_0390F3:          LDA.W !SpriteMisc157C,X             ;;90F3|90F3/90F3\90F3;
                      ASL A                               ;;90F6|90F6/90F6\90F6;
                      ADC.W !SpriteMisc1602,X             ;;90F7|90F7/90F7\90F7;
                      TAY                                 ;;90FA|90FA/90FA\90FA;
                      LDA.B !SpriteXPosLow,X              ;;90FB|90FB/90FB\90FB;
                      CLC                                 ;;90FD|90FD/90FD\90FD;
                      ADC.W DATA_0390EB,Y                 ;;90FE|90FE/90FE\90FE;
                      STA.B !_4                           ;;9101|9101/9101\9101;
                      LDA.W !SpriteYPosHigh,X             ;;9103|9103/9103\9103;
                      ADC.W DATA_0390EF,Y                 ;;9106|9106/9106\9106;
                      STA.B !_A                           ;;9109|9109/9109\9109;
                      LDA.B #$04                          ;;910B|910B/910B\910B;
                      STA.B !_6                           ;;910D|910D/910D\910D;
                      STA.B !_7                           ;;910F|910F/910F\910F;
                      LDA.B !SpriteYPosLow,X              ;;9111|9111/9111\9111;
                      CLC                                 ;;9113|9113/9113\9113;
                      ADC.B #$47                          ;;9114|9114/9114\9114;
                      STA.B !_5                           ;;9116|9116/9116\9116;
                      LDA.W !SpriteXPosHigh,X             ;;9118|9118/9118\9118;
                      ADC.B #$00                          ;;911B|911B/911B\911B;
                      STA.B !_B                           ;;911D|911D/911D\911D;
                      JSL GetMarioClipping                ;;911F|911F/911F\911F;
                      JSL CheckForContact                 ;;9123|9123/9123\9123;
                      BCC +                               ;;9127|9127/9127\9127;
                      JSL HurtMario                       ;;9129|9129/9129\9129;
                    + RTS                                 ;;912D|912D/912D\912D; Return 
                                                          ;;                   ;
                                                          ;;                   ;
FishinBooDispX:       db $FB,$05,$00,$F2,$FD,$03,$EA,$EA  ;;912E|912E/912E\912E;
                      db $EA,$EA,$FB,$05,$00,$FA,$FD,$03  ;;9136|9136/9136\9136;
                      db $F2,$F2,$F2,$F2,$FB,$05,$00,$0E  ;;913E|913E/913E\913E;
                      db $03,$FD,$16,$16,$16,$16,$FB,$05  ;;9146|9146/9146\9146;
                      db $00,$06,$03,$FD,$0E,$0E,$0E,$0E  ;;914E|914E/914E\914E;
FishinBooDispY:       db $0B,$0B,$00,$03,$0F,$0F,$13,$23  ;;9156|9156/9156\9156;
                      db $33,$43                          ;;915E|915E/915E\915E;
                                                          ;;                   ;
FishinBooTiles1:      db $60,$60,$64,$8A,$60,$60,$AC,$AC  ;;9160|9160/9160\9160;
                      db $AC,$CE                          ;;9168|9168/9168\9168;
                                                          ;;                   ;
FishinBooGfxProp:     db $04,$04,$0D,$09,$04,$04,$0D,$0D  ;;916A|916A/916A\916A;
                      db $0D,$07                          ;;9172|9172/9172\9172;
                                                          ;;                   ;
FishinBooTiles2:      db $CC,$CE,$CC,$CE                  ;;9174|9174/9174\9174;
                                                          ;;                   ;
DATA_039178:          db $00,$00,$40,$40                  ;;9178|9178/9178\9178;
                                                          ;;                   ;
DATA_03917C:          db $00,$40,$C0,$80                  ;;917C|917C/917C\917C;
                                                          ;;                   ;
FishinBooGfx:         JSR GetDrawInfoBnk3                 ;;9180|9180/9180\9180;
                      LDA.W !SpriteMisc1602,X             ;;9183|9183/9183\9183;
                      STA.B !_4                           ;;9186|9186/9186\9186;
                      LDA.W !SpriteMisc157C,X             ;;9188|9188/9188\9188;
                      STA.B !_2                           ;;918B|918B/918B\918B;
                      PHX                                 ;;918D|918D/918D\918D;
                      PHY                                 ;;918E|918E/918E\918E;
                      LDX.B #$09                          ;;918F|918F/918F\918F;
CODE_039191:          LDA.B !_1                           ;;9191|9191/9191\9191;
                      CLC                                 ;;9193|9193/9193\9193;
                      ADC.W FishinBooDispY,X              ;;9194|9194/9194\9194;
                      STA.W !OAMTileYPos+$100,Y           ;;9197|9197/9197\9197;
                      STZ.B !_3                           ;;919A|919A/919A\919A;
                      LDA.W FishinBooTiles1,X             ;;919C|919C/919C\919C;
                      CPX.B #$09                          ;;919F|919F/919F\919F;
                      BNE +                               ;;91A1|91A1/91A1\91A1;
                      LDA.B !EffFrame                     ;;91A3|91A3/91A3\91A3;
                      LSR A                               ;;91A5|91A5/91A5\91A5;
                      LSR A                               ;;91A6|91A6/91A6\91A6;
                      PHX                                 ;;91A7|91A7/91A7\91A7;
                      AND.B #$03                          ;;91A8|91A8/91A8\91A8;
                      TAX                                 ;;91AA|91AA/91AA\91AA;
                      LDA.W DATA_039178,X                 ;;91AB|91AB/91AB\91AB;
                      STA.B !_3                           ;;91AE|91AE/91AE\91AE;
                      LDA.W FishinBooTiles2,X             ;;91B0|91B0/91B0\91B0;
                      PLX                                 ;;91B3|91B3/91B3\91B3;
                    + STA.W !OAMTileNo+$100,Y             ;;91B4|91B4/91B4\91B4;
                      LDA.B !_2                           ;;91B7|91B7/91B7\91B7;
                      CMP.B #$01                          ;;91B9|91B9/91B9\91B9;
                      LDA.W FishinBooGfxProp,X            ;;91BB|91BB/91BB\91BB;
                      EOR.B !_3                           ;;91BE|91BE/91BE\91BE;
                      ORA.B !SpriteProperties             ;;91C0|91C0/91C0\91C0;
                      BCS +                               ;;91C2|91C2/91C2\91C2;
                      EOR.B #$40                          ;;91C4|91C4/91C4\91C4;
                    + STA.W !OAMTileAttr+$100,Y           ;;91C6|91C6/91C6\91C6;
                      PHX                                 ;;91C9|91C9/91C9\91C9;
                      LDA.B !_4                           ;;91CA|91CA/91CA\91CA;
                      BEQ +                               ;;91CC|91CC/91CC\91CC;
                      TXA                                 ;;91CE|91CE/91CE\91CE;
                      CLC                                 ;;91CF|91CF/91CF\91CF;
                      ADC.B #$0A                          ;;91D0|91D0/91D0\91D0;
                      TAX                                 ;;91D2|91D2/91D2\91D2;
                    + LDA.B !_2                           ;;91D3|91D3/91D3\91D3;
                      BNE +                               ;;91D5|91D5/91D5\91D5;
                      TXA                                 ;;91D7|91D7/91D7\91D7;
                      CLC                                 ;;91D8|91D8/91D8\91D8;
                      ADC.B #$14                          ;;91D9|91D9/91D9\91D9;
                      TAX                                 ;;91DB|91DB/91DB\91DB;
                    + LDA.B !_0                           ;;91DC|91DC/91DC\91DC;
                      CLC                                 ;;91DE|91DE/91DE\91DE;
                      ADC.W FishinBooDispX,X              ;;91DF|91DF/91DF\91DF;
                      STA.W !OAMTileXPos+$100,Y           ;;91E2|91E2/91E2\91E2;
                      PLX                                 ;;91E5|91E5/91E5\91E5;
                      INY                                 ;;91E6|91E6/91E6\91E6;
                      INY                                 ;;91E7|91E7/91E7\91E7;
                      INY                                 ;;91E8|91E8/91E8\91E8;
                      INY                                 ;;91E9|91E9/91E9\91E9;
                      DEX                                 ;;91EA|91EA/91EA\91EA;
                      BPL CODE_039191                     ;;91EB|91EB/91EB\91EB;
                      LDA.B !EffFrame                     ;;91ED|91ED/91ED\91ED;
                      LSR A                               ;;91EF|91EF/91EF\91EF;
                      LSR A                               ;;91F0|91F0/91F0\91F0;
                      LSR A                               ;;91F1|91F1/91F1\91F1;
                      AND.B #$03                          ;;91F2|91F2/91F2\91F2;
                      TAX                                 ;;91F4|91F4/91F4\91F4;
                      PLY                                 ;;91F5|91F5/91F5\91F5;
                      LDA.W DATA_03917C,X                 ;;91F6|91F6/91F6\91F6;
                      EOR.W !OAMTileAttr+$110,Y           ;;91F9|91F9/91F9\91F9;
                      STA.W !OAMTileAttr+$110,Y           ;;91FC|91FC/91FC\91FC;
                      STA.W !OAMTileAttr+$124,Y           ;;91FF|91FF/91FF\91FF;
                      EOR.B #$C0                          ;;9202|9202/9202\9202;
                      STA.W !OAMTileAttr+$114,Y           ;;9204|9204/9204\9204;
                      STA.W !OAMTileAttr+$120,Y           ;;9207|9207/9207\9207;
                      PLX                                 ;;920A|920A/920A\920A;
                      LDY.B #$02                          ;;920B|920B/920B\920B;
                      LDA.B #$09                          ;;920D|920D/920D\920D;
                      JSL FinishOAMWrite                  ;;920F|920F/920F\920F;
                      RTS                                 ;;9213|9213/9213\9213; Return 
                                                          ;;                   ;
FallingSpike:         JSL GenericSprGfxRt2                ;;9214|9214/9214\9214;
                      LDY.W !SpriteOAMIndex,X             ;;9218|9218/9218\9218; Y = Index into sprite OAM 
                      LDA.B #$E0                          ;;921B|921B/921B\921B;
                      STA.W !OAMTileNo+$100,Y             ;;921D|921D/921D\921D;
                      LDA.W !OAMTileYPos+$100,Y           ;;9220|9220/9220\9220;
                      DEC A                               ;;9223|9223/9223\9223;
                      STA.W !OAMTileYPos+$100,Y           ;;9224|9224/9224\9224;
                      LDA.W !SpriteMisc1540,X             ;;9227|9227/9227\9227;
                      BEQ +                               ;;922A|922A/922A\922A;
                      LSR A                               ;;922C|922C/922C\922C;
                      LSR A                               ;;922D|922D/922D\922D;
                      AND.B #$01                          ;;922E|922E/922E\922E;
                      CLC                                 ;;9230|9230/9230\9230;
                      ADC.W !OAMTileXPos+$100,Y           ;;9231|9231/9231\9231;
                      STA.W !OAMTileXPos+$100,Y           ;;9234|9234/9234\9234;
                    + LDA.B !SpriteLock                   ;;9237|9237/9237\9237;
                      BNE CODE_03926C                     ;;9239|9239/9239\9239;
                      JSR SubOffscreen0Bnk3               ;;923B|923B/923B\923B;
                      JSL UpdateSpritePos                 ;;923E|923E/923E\923E;
                      LDA.B !SpriteTableC2,X              ;;9242|9242/9242\9242;
                      JSL ExecutePtr                      ;;9244|9244/9244\9244;
                                                          ;;                   ;
                      dw CODE_03924C                      ;;9248|9248/9248\9248;
                      dw CODE_039262                      ;;924A|924A/924A\924A;
                                                          ;;                   ;
CODE_03924C:          STZ.B !SpriteYSpeed,X               ;;924C|924C/924C\924C; Sprite Y Speed = 0 
                      JSR SubHorzPosBnk3                  ;;924E|924E/924E\924E;
                      LDA.B !_F                           ;;9251|9251/9251\9251;
                      CLC                                 ;;9253|9253/9253\9253;
                      ADC.B #$40                          ;;9254|9254/9254\9254;
                      CMP.B #$80                          ;;9256|9256/9256\9256;
                      BCS +                               ;;9258|9258/9258\9258;
                      INC.B !SpriteTableC2,X              ;;925A|925A/925A\925A;
                      LDA.B #con($40,$40,$20,$20)         ;;925C|925C/925C\925C;
                      STA.W !SpriteMisc1540,X             ;;925E|925E/925E\925E;
                    + RTS                                 ;;9261|9261/9261\9261; Return 
                                                          ;;                   ;
CODE_039262:          LDA.W !SpriteMisc1540,X             ;;9262|9262/9262\9262;
                      BNE CODE_03926C                     ;;9265|9265/9265\9265;
                      JSL MarioSprInteract                ;;9267|9267/9267\9267;
                      RTS                                 ;;926B|926B/926B\926B; Return 
                                                          ;;                   ;
CODE_03926C:          STZ.B !SpriteYSpeed,X               ;;926C|926C/926C\926C; Sprite Y Speed = 0 
                      RTS                                 ;;926E|926E/926E\926E; Return 
                                                          ;;                   ;
                                                          ;;                   ;
CrtEatBlkSpeedX:      db $10,$F0,$00,$00,$00              ;;926F|926F/926F\926F;
                                                          ;;                   ;
CrtEatBlkSpeedY:      db $00,$00,$10,$F0,$00              ;;9274|9274/9274\9274;
                                                          ;;                   ;
DATA_039279:          db $00,$00,$01,$00,$02,$00,$00,$00  ;;9279|9279/9279\9279;
                      db $03,$00,$00                      ;;9281|9281/9281\9281;
                                                          ;;                   ;
CreateEatBlock:       JSL GenericSprGfxRt2                ;;9284|9284/9284\9284;
                      LDY.W !SpriteOAMIndex,X             ;;9288|9288/9288\9288; Y = Index into sprite OAM 
                      LDA.W !OAMTileYPos+$100,Y           ;;928B|928B/928B\928B;
                      DEC A                               ;;928E|928E/928E\928E;
                      STA.W !OAMTileYPos+$100,Y           ;;928F|928F/928F\928F;
                      LDA.B #$2E                          ;;9292|9292/9292\9292;
                      STA.W !OAMTileNo+$100,Y             ;;9294|9294/9294\9294;
                      LDA.W !OAMTileAttr+$100,Y           ;;9297|9297/9297\9297;
                      AND.B #$3F                          ;;929A|929A/929A\929A;
                      STA.W !OAMTileAttr+$100,Y           ;;929C|929C/929C\929C;
                      LDY.B #$02                          ;;929F|929F/929F\929F;
                      LDA.B #$00                          ;;92A1|92A1/92A1\92A1;
                      JSL FinishOAMWrite                  ;;92A3|92A3/92A3\92A3;
                      LDY.B #$04                          ;;92A7|92A7/92A7\92A7;
                      LDA.W !BlockSnakeActive             ;;92A9|92A9/92A9\92A9;
                      CMP.B #$FF                          ;;92AC|92AC/92AC\92AC;
                      BEQ CODE_0392C0                     ;;92AE|92AE/92AE\92AE;
                      LDA.B !TrueFrame                    ;;92B0|92B0/92B0\92B0;
                      AND.B #$03                          ;;92B2|92B2/92B2\92B2;
                      ORA.B !SpriteLock                   ;;92B4|92B4/92B4\92B4;
                      BNE +                               ;;92B6|92B6/92B6\92B6;
                      LDA.B #$04                          ;;92B8|92B8/92B8\92B8; \ Play sound effect 
                      STA.W !SPCIO1                       ;;92BA|92BA/92BA\92BA; / 
                    + LDY.W !SpriteMisc157C,X             ;;92BD|92BD/92BD\92BD;
CODE_0392C0:          LDA.B !SpriteLock                   ;;92C0|92C0/92C0\92C0;
                      BNE Return03932B                    ;;92C2|92C2/92C2\92C2;
                      LDA.W CrtEatBlkSpeedX,Y             ;;92C4|92C4/92C4\92C4;
                      STA.B !SpriteXSpeed,X               ;;92C7|92C7/92C7\92C7;
                      LDA.W CrtEatBlkSpeedY,Y             ;;92C9|92C9/92C9\92C9;
                      STA.B !SpriteYSpeed,X               ;;92CC|92CC/92CC\92CC;
                      JSL UpdateYPosNoGvtyW               ;;92CE|92CE/92CE\92CE;
                      JSL UpdateXPosNoGvtyW               ;;92D2|92D2/92D2\92D2;
                      STZ.W !SpriteMisc1528,X             ;;92D6|92D6/92D6\92D6;
                      JSL InvisBlkMainRt                  ;;92D9|92D9/92D9\92D9;
                      LDA.W !BlockSnakeActive             ;;92DD|92DD/92DD\92DD;
                      CMP.B #$FF                          ;;92E0|92E0/92E0\92E0;
                      BEQ Return03932B                    ;;92E2|92E2/92E2\92E2;
                      LDA.B !SpriteYPosLow,X              ;;92E4|92E4/92E4\92E4;
                      ORA.B !SpriteXPosLow,X              ;;92E6|92E6/92E6\92E6;
                      AND.B #$0F                          ;;92E8|92E8/92E8\92E8;
                      BNE Return03932B                    ;;92EA|92EA/92EA\92EA;
                      LDA.W !SpriteMisc151C,X             ;;92EC|92EC/92EC\92EC;
                      BNE CODE_03932C                     ;;92EF|92EF/92EF\92EF;
                      DEC.W !SpriteMisc1570,X             ;;92F1|92F1/92F1\92F1;
                      BMI CODE_0392F8                     ;;92F4|92F4/92F4\92F4;
                      BNE CODE_03931F                     ;;92F6|92F6/92F6\92F6;
CODE_0392F8:          LDY.W !PlayerTurnLvl                ;;92F8|92F8/92F8\92F8;
                      LDA.W !OWPlayerSubmap,Y             ;;92FB|92FB/92FB\92FB;
                      CMP.B #$01                          ;;92FE|92FE/92FE\92FE;
                      LDY.W !SpriteMisc1534,X             ;;9300|9300/9300\9300;
                      INC.W !SpriteMisc1534,X             ;;9303|9303/9303\9303;
                      LDA.W CrtEatBlkData1,Y              ;;9306|9306/9306\9306;
                      BCS +                               ;;9309|9309/9309\9309;
                      LDA.W CrtEatBlkData2,Y              ;;930B|930B/930B\930B;
                    + STA.W !SpriteMisc1602,X             ;;930E|930E/930E\930E;
                      PHA                                 ;;9311|9311/9311\9311;
                      LSR A                               ;;9312|9312/9312\9312;
                      LSR A                               ;;9313|9313/9313\9313;
                      LSR A                               ;;9314|9314/9314\9314;
                      LSR A                               ;;9315|9315/9315\9315;
                      STA.W !SpriteMisc1570,X             ;;9316|9316/9316\9316;
                      PLA                                 ;;9319|9319/9319\9319;
                      AND.B #$03                          ;;931A|931A/931A\931A;
                      STA.W !SpriteMisc157C,X             ;;931C|931C/931C\931C;
CODE_03931F:          LDA.B #$0D                          ;;931F|931F/931F\931F;
                      JSR GenTileFromSpr1                 ;;9321|9321/9321\9321;
                      LDA.W !SpriteMisc1602,X             ;;9324|9324/9324\9324;
                      CMP.B #$FF                          ;;9327|9327/9327\9327;
                      BEQ +                               ;;9329|9329/9329\9329;
Return03932B:         RTS                                 ;;932B|932B/932B\932B; Return 
                                                          ;;                   ;
CODE_03932C:          LDA.B #$02                          ;;932C|932C/932C\932C;
                      JSR GenTileFromSpr1                 ;;932E|932E/932E\932E;
                      LDA.B #$01                          ;;9331|9331/9331\9331;
                      STA.B !SpriteXSpeed,X               ;;9333|9333/9333\9333;
                      STA.B !SpriteYSpeed,X               ;;9335|9335/9335\9335;
                      JSL CODE_019138                     ;;9337|9337/9337\9337;
                      LDA.W !SpriteBlockedDirs,X          ;;933B|933B/933B\933B;
                      PHA                                 ;;933E|933E/933E\933E;
                      LDA.B #$FF                          ;;933F|933F/933F\933F;
                      STA.B !SpriteXSpeed,X               ;;9341|9341/9341\9341;
                      STA.B !SpriteYSpeed,X               ;;9343|9343/9343\9343;
                      LDA.B !SpriteXPosLow,X              ;;9345|9345/9345\9345;
                      PHA                                 ;;9347|9347/9347\9347;
                      SEC                                 ;;9348|9348/9348\9348;
                      SBC.B #$01                          ;;9349|9349/9349\9349;
                      STA.B !SpriteXPosLow,X              ;;934B|934B/934B\934B;
                      LDA.W !SpriteYPosHigh,X             ;;934D|934D/934D\934D;
                      PHA                                 ;;9350|9350/9350\9350;
                      SBC.B #$00                          ;;9351|9351/9351\9351;
                      STA.W !SpriteYPosHigh,X             ;;9353|9353/9353\9353;
                      LDA.B !SpriteYPosLow,X              ;;9356|9356/9356\9356;
                      PHA                                 ;;9358|9358/9358\9358;
                      SEC                                 ;;9359|9359/9359\9359;
                      SBC.B #$01                          ;;935A|935A/935A\935A;
                      STA.B !SpriteYPosLow,X              ;;935C|935C/935C\935C;
                      LDA.W !SpriteXPosHigh,X             ;;935E|935E/935E\935E;
                      PHA                                 ;;9361|9361/9361\9361;
                      SBC.B #$00                          ;;9362|9362/9362\9362;
                      STA.W !SpriteXPosHigh,X             ;;9364|9364/9364\9364;
                      JSL CODE_019138                     ;;9367|9367/9367\9367;
                      PLA                                 ;;936B|936B/936B\936B;
                      STA.W !SpriteXPosHigh,X             ;;936C|936C/936C\936C;
                      PLA                                 ;;936F|936F/936F\936F;
                      STA.B !SpriteYPosLow,X              ;;9370|9370/9370\9370;
                      PLA                                 ;;9372|9372/9372\9372;
                      STA.W !SpriteYPosHigh,X             ;;9373|9373/9373\9373;
                      PLA                                 ;;9376|9376/9376\9376;
                      STA.B !SpriteXPosLow,X              ;;9377|9377/9377\9377;
                      PLA                                 ;;9379|9379/9379\9379;
                      ORA.W !SpriteBlockedDirs,X          ;;937A|937A/937A\937A;
                      BEQ +                               ;;937D|937D/937D\937D;
                      TAY                                 ;;937F|937F/937F\937F;
                      LDA.W DATA_039279,Y                 ;;9380|9380/9380\9380;
                      STA.W !SpriteMisc157C,X             ;;9383|9383/9383\9383;
                      RTS                                 ;;9386|9386/9386\9386; Return 
                                                          ;;                   ;
                    + STZ.W !SpriteStatus,X               ;;9387|9387/9387\9387;
                      RTS                                 ;;938A|938A/938A\938A; Return 
                                                          ;;                   ;
GenTileFromSpr1:      STA.B !Map16TileGenerate            ;;938B|938B/938B\938B; $9C = tile to generate 
                      LDA.B !SpriteXPosLow,X              ;;938D|938D/938D\938D; \ $9A = Sprite X position 
                      STA.B !TouchBlockXPos               ;;938F|938F/938F\938F;  | for block creation 
                      LDA.W !SpriteYPosHigh,X             ;;9391|9391/9391\9391;  | 
                      STA.B !TouchBlockXPos+1             ;;9394|9394/9394\9394; / 
                      LDA.B !SpriteYPosLow,X              ;;9396|9396/9396\9396; \ $98 = Sprite Y position 
                      STA.B !TouchBlockYPos               ;;9398|9398/9398\9398;  | for block creation 
                      LDA.W !SpriteXPosHigh,X             ;;939A|939A/939A\939A;  | 
                      STA.B !TouchBlockYPos+1             ;;939D|939D/939D\939D; / 
                      JSL GenerateTile                    ;;939F|939F/939F\939F; Generate the tile 
                      RTS                                 ;;93A3|93A3/93A3\93A3; Return 
                                                          ;;                   ;
                                                          ;;                   ;
CrtEatBlkData1:       db $10,$13,$10,$13,$10,$13,$10,$13  ;;93A4|93A4/93A4\93A4;
                      db $10,$13,$10,$13,$10,$13,$10,$13  ;;93AC|93AC/93AC\93AC;
                      db $F0,$F0,$20,$12,$10,$12,$10,$12  ;;93B4|93B4/93B4\93B4;
                      db $10,$12,$10,$12,$10,$12,$10,$12  ;;93BC|93BC/93BC\93BC;
                      db $D0,$C3,$F1,$21,$22,$F1,$F1,$51  ;;93C4|93C4/93C4\93C4;
                      db $43,$10,$13,$10,$13,$10,$13,$F0  ;;93CC|93CC/93CC\93CC;
                      db $F0,$F0,$60,$32,$60,$32,$71,$32  ;;93D4|93D4/93D4\93D4;
                      db $60,$32,$61,$32,$70,$33,$10,$33  ;;93DC|93DC/93DC\93DC;
                      db $10,$33,$10,$33,$10,$33,$F0,$10  ;;93E4|93E4/93E4\93E4;
                      db $F2,$52,$FF                      ;;93EC|93EC/93EC\93EC;
                                                          ;;                   ;
CrtEatBlkData2:       db $80,$13,$10,$13,$10,$13,$10,$13  ;;93EF|93EF/93EF\93EF;
                      db $60,$23,$20,$23,$B0,$22,$A1,$22  ;;93F7|93F7/93F7\93F7;
                      db $A0,$22,$A1,$22,$C0,$13,$10,$13  ;;93FF|93FF/93FF\93FF;
                      db $10,$13,$10,$13,$10,$13,$10,$13  ;;9407|9407/9407\9407;
                      db $10,$13,$F0,$F0,$F0,$52,$50,$33  ;;940F|940F/940F\940F;
                      db $50,$32,$50,$33,$50,$22,$50,$33  ;;9417|9417/9417\9417;
                      db $F0,$50,$82,$FF                  ;;941F|941F/941F\941F;
                                                          ;;                   ;
WoodenSpike:          JSR WoodSpikeGfx                    ;;9423|9423/9423\9423;
                      LDA.B !SpriteLock                   ;;9426|9426/9426\9426;
                      BNE +                               ;;9428|9428/9428\9428;
                      JSR SubOffscreen0Bnk3               ;;942A|942A/942A\942A;
                      JSR CODE_039488                     ;;942D|942D/942D\942D;
                      LDA.B !SpriteTableC2,X              ;;9430|9430/9430\9430;
                      AND.B #$03                          ;;9432|9432/9432\9432;
                      JSL ExecutePtr                      ;;9434|9434/9434\9434;
                                                          ;;                   ;
                      dw CODE_039458                      ;;9438|9438/9438\9438;
                      dw CODE_03944E                      ;;943A|943A/943A\943A;
                      dw CODE_039441                      ;;943C|943C/943C\943C;
                      dw CODE_03946B                      ;;943E|943E/943E\943E;
                                                          ;;                   ;
                    + RTS                                 ;;9440|9440/9440\9440; Return 
                                                          ;;                   ;
CODE_039441:          LDA.W !SpriteMisc1540,X             ;;9441|9441/9441\9441;
                      BEQ CODE_03944A                     ;;9444|9444/9444\9444;
                      LDA.B #$20                          ;;9446|9446/9446\9446;
                      BRA CODE_039475                     ;;9448|9448/9448\9448;
                                                          ;;                   ;
CODE_03944A:          LDA.B #$30                          ;;944A|944A/944A\944A;
                      BRA SetTimerNextState               ;;944C|944C/944C\944C;
                                                          ;;                   ;
CODE_03944E:          LDA.W !SpriteMisc1540,X             ;;944E|944E/944E\944E;
                      BNE Return039457                    ;;9451|9451/9451\9451;
                      LDA.B #$18                          ;;9453|9453/9453\9453;
                      BRA SetTimerNextState               ;;9455|9455/9455\9455;
                                                          ;;                   ;
Return039457:         RTS                                 ;;9457|9457/9457\9457; Return 
                                                          ;;                   ;
CODE_039458:          LDA.W !SpriteMisc1540,X             ;;9458|9458/9458\9458;
                      BEQ +                               ;;945B|945B/945B\945B;
                      LDA.B #$F0                          ;;945D|945D/945D\945D;
                      JSR CODE_039475                     ;;945F|945F/945F\945F;
                      RTS                                 ;;9462|9462/9462\9462; Return 
                                                          ;;                   ;
                    + LDA.B #$30                          ;;9463|9463/9463\9463;
SetTimerNextState:    STA.W !SpriteMisc1540,X             ;;9465|9465/9465\9465;
                      INC.B !SpriteTableC2,X              ;;9468|9468/9468\9468; Goto next state 
                      RTS                                 ;;946A|946A/946A\946A; Return 
                                                          ;;                   ;
CODE_03946B:          LDA.W !SpriteMisc1540,X             ;;946B|946B/946B\946B; \ If stall timer us up, 
                      BNE Return039474                    ;;946E|946E/946E\946E;  | reset it to #$2F... 
                      LDA.B #$2F                          ;;9470|9470/9470\9470;  | 
                      BRA SetTimerNextState               ;;9472|9472/9472\9472;  | ...and goto next state 
                                                          ;;                   ;
Return039474:         RTS                                 ;;9474|9474/9474\9474; / 
                                                          ;;                   ;
CODE_039475:          LDY.W !SpriteMisc151C,X             ;;9475|9475/9475\9475;
                      BEQ +                               ;;9478|9478/9478\9478;
                      EOR.B #$FF                          ;;947A|947A/947A\947A;
                      INC A                               ;;947C|947C/947C\947C;
                    + STA.B !SpriteYSpeed,X               ;;947D|947D/947D\947D;
                      JSL UpdateYPosNoGvtyW               ;;947F|947F/947F\947F;
                      RTS                                 ;;9483|9483/9483\9483; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_039484:          db $01,$FF                          ;;9484|9484/9484\9484;
                                                          ;;                   ;
DATA_039486:          db $00,$FF                          ;;9486|9486/9486\9486;
                                                          ;;                   ;
CODE_039488:          JSL MarioSprInteract                ;;9488|9488/9488\9488;
                      BCC Return0394B0                    ;;948C|948C/948C\948C;
                      JSR SubHorzPosBnk3                  ;;948E|948E/948E\948E;
                      LDA.B !_F                           ;;9491|9491/9491\9491;
                      CLC                                 ;;9493|9493/9493\9493;
                      ADC.B #$04                          ;;9494|9494/9494\9494;
                      CMP.B #$08                          ;;9496|9496/9496\9496;
                      BCS +                               ;;9498|9498/9498\9498;
                      JSL HurtMario                       ;;949A|949A/949A\949A;
                      RTS                                 ;;949E|949E/949E\949E; Return 
                                                          ;;                   ;
                    + LDA.B !PlayerXPosNext               ;;949F|949F/949F\949F;
                      CLC                                 ;;94A1|94A1/94A1\94A1;
                      ADC.W DATA_039484,Y                 ;;94A2|94A2/94A2\94A2;
                      STA.B !PlayerXPosNext               ;;94A5|94A5/94A5\94A5;
                      LDA.B !PlayerXPosNext+1             ;;94A7|94A7/94A7\94A7;
                      ADC.W DATA_039486,Y                 ;;94A9|94A9/94A9\94A9;
                      STA.B !PlayerXPosNext+1             ;;94AC|94AC/94AC\94AC;
                      STZ.B !PlayerXSpeed                 ;;94AE|94AE/94AE\94AE;
Return0394B0:         RTS                                 ;;94B0|94B0/94B0\94B0; Return 
                                                          ;;                   ;
                                                          ;;                   ;
WoodSpikeDispY:       db $00,$10,$20,$30,$40,$40,$30,$20  ;;94B1|94B1/94B1\94B1;
                      db $10,$00                          ;;94B9|94B9/94B9\94B9;
                                                          ;;                   ;
WoodSpikeTiles:       db $6A,$6A,$6A,$6A,$4A,$6A,$6A,$6A  ;;94BB|94BB/94BB\94BB;
                      db $6A,$4A                          ;;94C3|94C3/94C3\94C3;
                                                          ;;                   ;
WoodSpikeGfxProp:     db $81,$81,$81,$81,$81,$01,$01,$01  ;;94C5|94C5/94C5\94C5;
                      db $01,$01                          ;;94CD|94CD/94CD\94CD;
                                                          ;;                   ;
WoodSpikeGfx:         JSR GetDrawInfoBnk3                 ;;94CF|94CF/94CF\94CF;
                      STZ.B !_2                           ;;94D2|94D2/94D2\94D2; \ Set $02 based on sprite number 
                      LDA.B !SpriteNumber,X               ;;94D4|94D4/94D4\94D4;  | 
                      CMP.B #$AD                          ;;94D6|94D6/94D6\94D6;  | 
                      BNE +                               ;;94D8|94D8/94D8\94D8;  | 
                      LDA.B #$05                          ;;94DA|94DA/94DA\94DA;  | 
                      STA.B !_2                           ;;94DC|94DC/94DC\94DC; / 
                    + PHX                                 ;;94DE|94DE/94DE\94DE;
                      LDX.B #$04                          ;;94DF|94DF/94DF\94DF; Draw 4 tiles: 
                    - PHX                                 ;;94E1|94E1/94E1\94E1;
                      TXA                                 ;;94E2|94E2/94E2\94E2;
                      CLC                                 ;;94E3|94E3/94E3\94E3;
                      ADC.B !_2                           ;;94E4|94E4/94E4\94E4;
                      TAX                                 ;;94E6|94E6/94E6\94E6;
                      LDA.B !_0                           ;;94E7|94E7/94E7\94E7; \ Set X 
                      STA.W !OAMTileXPos+$100,Y           ;;94E9|94E9/94E9\94E9; / 
                      LDA.B !_1                           ;;94EC|94EC/94EC\94EC; \ Set Y 
                      CLC                                 ;;94EE|94EE/94EE\94EE;  | 
                      ADC.W WoodSpikeDispY,X              ;;94EF|94EF/94EF\94EF;  | 
                      STA.W !OAMTileYPos+$100,Y           ;;94F2|94F2/94F2\94F2; / 
                      LDA.W WoodSpikeTiles,X              ;;94F5|94F5/94F5\94F5; \ Set tile 
                      STA.W !OAMTileNo+$100,Y             ;;94F8|94F8/94F8\94F8; / 
                      LDA.W WoodSpikeGfxProp,X            ;;94FB|94FB/94FB\94FB; \ Set gfs properties 
                      STA.W !OAMTileAttr+$100,Y           ;;94FE|94FE/94FE\94FE; / 
                      INY                                 ;;9501|9501/9501\9501; \ We wrote 4 times, so increase index by 4 
                      INY                                 ;;9502|9502/9502\9502;  | 
                      INY                                 ;;9503|9503/9503\9503;  | 
                      INY                                 ;;9504|9504/9504\9504; / 
                      PLX                                 ;;9505|9505/9505\9505;
                      DEX                                 ;;9506|9506/9506\9506;
                      BPL -                               ;;9507|9507/9507\9507;
                      PLX                                 ;;9509|9509/9509\9509;
                      LDY.B #$02                          ;;950A|950A/950A\950A; \ Wrote 5 16x16 tiles... 
                      LDA.B #$04                          ;;950C|950C/950C\950C;  | 
                      JSL FinishOAMWrite                  ;;950E|950E/950E\950E; / 
                      RTS                                 ;;9512|9512/9512\9512; Return 
                                                          ;;                   ;
                                                          ;;                   ;
RexSpeed:             db $08,$F8,$10,$F0                  ;;9513|9513/9513\9513;
                                                          ;;                   ;
RexMainRt:            JSR RexGfxRt                        ;;9517|9517/9517\9517; Draw Rex gfx        
                      LDA.W !SpriteStatus,X               ;;951A|951A/951A\951A; \ If Rex status != 8...        
                      CMP.B #$08                          ;;951D|951D/951D\951D;  |   ... not (killed with spin jump [4] or star [2])        
                      BNE RexReturn                       ;;951F|951F/951F\951F; /    ... return        
                      LDA.B !SpriteLock                   ;;9521|9521/9521\9521; \ If sprites locked...        
                      BNE RexReturn                       ;;9523|9523/9523\9523; /    ... return        
                      LDA.W !SpriteMisc1558,X             ;;9525|9525/9525\9525; \ If Rex not defeated (timer to show remains > 0)...        
                      BEQ RexAlive                        ;;9528|9528/9528\9528; /    ... goto RexAlive        
                      STA.W !SpriteOnYoshiTongue,X        ;;952A|952A/952A\952A; \         
                      DEC A                               ;;952D|952D/952D\952D;  |   If Rex remains don't disappear next frame...        
                      BNE RexReturn                       ;;952E|952E/952E\952E; /    ... return        
                      STZ.W !SpriteStatus,X               ;;9530|9530/9530\9530; This is the last frame to show remains, so set Rex status = 0 
RexReturn:            RTS                                 ;;9533|9533/9533\9533; Return 
                                                          ;;                   ;
RexAlive:             JSR SubOffscreen0Bnk3               ;;9534|9534/9534\9534; Only process Rex while on screen    
                      INC.W !SpriteMisc1570,X             ;;9537|9537/9537\9537; Increment number of frames Rex has been on sc 
                      LDA.W !SpriteMisc1570,X             ;;953A|953A/953A\953A; \ Calculate which frame to show:    
                      LSR A                               ;;953D|953D/953D\953D;  |     
                      LSR A                               ;;953E|953E/953E\953E;  |     
                      LDY.B !SpriteTableC2,X              ;;953F|953F/953F\953F;  | Number of hits determines if smushed    
                      BEQ CODE_03954A                     ;;9541|9541/9541\9541;  |    
                      AND.B #$01                          ;;9543|9543/9543\9543;  | Update every 8 cycles if smushed    
                      CLC                                 ;;9545|9545/9545\9545;  |    
                      ADC.B #$03                          ;;9546|9546/9546\9546;  | Show smushed frame    
                      BRA +                               ;;9548|9548/9548\9548;  |    
                                                          ;;                   ;
CODE_03954A:          LSR A                               ;;954A|954A/954A\954A;  |     
                      AND.B #$01                          ;;954B|954B/954B\954B;  | Update every 16 cycles if normal    
                    + STA.W !SpriteMisc1602,X             ;;954D|954D/954D\954D; / Write frame to show    
                      LDA.W !SpriteBlockedDirs,X          ;;9550|9550/9550\9550; \  If sprite is not on ground...    
                      AND.B #$04                          ;;9553|9553/9553\9553;  |    ...(4 = on ground) ...    
                      BEQ RexInAir                        ;;9555|9555/9555\9555; /     ...goto IN_AIR    
                      LDA.B #$10                          ;;9557|9557/9557\9557; \  Y speed = 10    
                      STA.B !SpriteYSpeed,X               ;;9559|9559/9559\9559; /    
                      LDY.W !SpriteMisc157C,X             ;;955B|955B/955B\955B; Load, y = Rex direction, as index for speed   
                      LDA.B !SpriteTableC2,X              ;;955E|955E/955E\955E; \ If hits on Rex == 0...    
                      BEQ +                               ;;9560|9560/9560\9560; /    ...goto DONT_ADJUST_SPEED    
                      INY                                 ;;9562|9562/9562\9562; \ Increment y twice...    
                      INY                                 ;;9563|9563/9563\9563; /    ...in order to get speed for smushed Rex 
                    + LDA.W RexSpeed,Y                    ;;9564|9564/9564\9564; \ Load x speed from ROM...    
                      STA.B !SpriteXSpeed,X               ;;9567|9567/9567\9567; /    ...and store it    
RexInAir:             LDA.W !SpriteMisc1FE2,X             ;;9569|9569/9569\9569; \ If time to show half-smushed Rex > 0...    
                      BNE +                               ;;956C|956C/956C\956C; /    ...goto HALF_SMUSHED    
                      JSL UpdateSpritePos                 ;;956E|956E/956E\956E; Update position based on speed values    
                    + LDA.W !SpriteBlockedDirs,X          ;;9572|9572/9572\9572; \ If Rex is touching the side of an object... 
                      AND.B #$03                          ;;9575|9575/9575\9575;  |        
                      BEQ +                               ;;9577|9577/9577\9577;  |        
                      LDA.W !SpriteMisc157C,X             ;;9579|9579/9579\9579;  |        
                      EOR.B #$01                          ;;957C|957C/957C\957C;  |    ... change Rex direction        
                      STA.W !SpriteMisc157C,X             ;;957E|957E/957E\957E; /        
                    + JSL SprSprInteract                  ;;9581|9581/9581\9581; Interact with other sprites        
                      JSL MarioSprInteract                ;;9585|9585/9585\9585; Check for mario/Rex contact 
                      BCC NoRexContact                    ;;9589|9589/9589\9589; (carry set = mario/Rex contact)        
                      LDA.W !InvinsibilityTimer           ;;958B|958B/958B\958B; \ If mario star timer > 0 ...        
                      BNE RexStarKill                     ;;958E|958E/958E\958E; /    ... goto HAS_STAR        
                      LDA.W !SpriteMisc154C,X             ;;9590|9590/9590\9590; \ If Rex invincibility timer > 0 ...      
                      BNE NoRexContact                    ;;9593|9593/9593\9593; /    ... goto NO_CONTACT        
                      LDA.B #$08                          ;;9595|9595/9595\9595; \ Rex invincibility timer = $08        
                      STA.W !SpriteMisc154C,X             ;;9597|9597/9597\9597; /        
                      LDA.B !PlayerYSpeed                 ;;959A|959A/959A\959A; \  If mario's y speed < 10 ...        
                      CMP.B #$10                          ;;959C|959C/959C\959C;  |   ... Rex will hurt mario        
                      BMI RexWins                         ;;959E|959E/959E\959E; /            
                      JSR RexPoints                       ;;95A0|95A0/95A0\95A0; Give mario points        
                      JSL BoostMarioSpeed                 ;;95A3|95A3/95A3\95A3; Set mario speed        
                      JSL DisplayContactGfx               ;;95A7|95A7/95A7\95A7; Display contact graphic        
                      LDA.W !SpinJumpFlag                 ;;95AB|95AB/95AB\95AB; \  If mario is spin jumping...        
                      ORA.W !PlayerRidingYoshi            ;;95AE|95AE/95AE\95AE;  |    ... or on yoshi ...        
                      BNE RexSpinKill                     ;;95B1|95B1/95B1\95B1; /     ... goto SPIN_KILL        
                      INC.B !SpriteTableC2,X              ;;95B3|95B3/95B3\95B3; Increment Rex hit counter        
                      LDA.B !SpriteTableC2,X              ;;95B5|95B5/95B5\95B5; \  If Rex hit counter == 2        
                      CMP.B #$02                          ;;95B7|95B7/95B7\95B7;  |           
                      BNE +                               ;;95B9|95B9/95B9\95B9;  |        
                      LDA.B #$20                          ;;95BB|95BB/95BB\95BB;  |    ... time to show defeated Rex = $20 
                      STA.W !SpriteMisc1558,X             ;;95BD|95BD/95BD\95BD; / 
                      RTS                                 ;;95C0|95C0/95C0\95C0; Return 
                                                          ;;                   ;
                    + LDA.B #$0C                          ;;95C1|95C1/95C1\95C1; \ Time to show semi-squashed Rex = $0C 
                      STA.W !SpriteMisc1FE2,X             ;;95C3|95C3/95C3\95C3; /     
                      STZ.W !SpriteTweakerB,X             ;;95C6|95C6/95C6\95C6; Change clipping area for squashed Rex  
                      RTS                                 ;;95C9|95C9/95C9\95C9; Return 
                                                          ;;                   ;
RexWins:              LDA.W !IFrameTimer                  ;;95CA|95CA/95CA\95CA; \ If mario is invincible...  
                      ORA.W !PlayerRidingYoshi            ;;95CD|95CD/95CD\95CD;  |  ... or mario on yoshi...  
                      BNE NoRexContact                    ;;95D0|95D0/95D0\95D0; /   ... return  
                      JSR SubHorzPosBnk3                  ;;95D2|95D2/95D2\95D2; \  Set new Rex direction  
                      TYA                                 ;;95D5|95D5/95D5\95D5;  |    
                      STA.W !SpriteMisc157C,X             ;;95D6|95D6/95D6\95D6; /  
                      JSL HurtMario                       ;;95D9|95D9/95D9\95D9; Hurt mario  
NoRexContact:         RTS                                 ;;95DD|95DD/95DD\95DD; Return 
                                                          ;;                   ;
RexSpinKill:          LDA.B #$04                          ;;95DE|95DE/95DE\95DE; \ Rex status = 4 (being killed by spin jump)   
                      STA.W !SpriteStatus,X               ;;95E0|95E0/95E0\95E0; /        
                      LDA.B #$1F                          ;;95E3|95E3/95E3\95E3; \ Set spin jump animation timer     
                      STA.W !SpriteMisc1540,X             ;;95E5|95E5/95E5\95E5; /     
                      JSL CODE_07FC3B                     ;;95E8|95E8/95E8\95E8; Show star animation     
                      LDA.B #$08                          ;;95EC|95EC/95EC\95EC; \ 
                      STA.W !SPCIO0                       ;;95EE|95EE/95EE\95EE; / Play sound effect 
                      RTS                                 ;;95F1|95F1/95F1\95F1; Return 
                                                          ;;                   ;
RexStarKill:          LDA.B #$02                          ;;95F2|95F2/95F2\95F2; \ Rex status = 2 (being killed by star)   
                      STA.W !SpriteStatus,X               ;;95F4|95F4/95F4\95F4; /   
                      LDA.B #$D0                          ;;95F7|95F7/95F7\95F7; \ Set y speed   
                      STA.B !SpriteYSpeed,X               ;;95F9|95F9/95F9\95F9; /   
                      JSR SubHorzPosBnk3                  ;;95FB|95FB/95FB\95FB; Get new Rex direction   
                      LDA.W RexKilledSpeed,Y              ;;95FE|95FE/95FE\95FE; \ Set x speed based on Rex direction   
                      STA.B !SpriteXSpeed,X               ;;9601|9601/9601\9601; /   
                      INC.W !StarKillCounter              ;;9603|9603/9603\9603; Increment number consecutive enemies killed   
                      LDA.W !StarKillCounter              ;;9606|9606/9606\9606; \   
                      CMP.B #$08                          ;;9609|9609/9609\9609;  | If consecutive enemies stomped >= 8, reset to 8   
                      BCC +                               ;;960B|960B/960B\960B;  |   
                      LDA.B #$08                          ;;960D|960D/960D\960D;  |   
                      STA.W !StarKillCounter              ;;960F|960F/960F\960F; /      
                    + JSL GivePoints                      ;;9612|9612/9612\9612; Give mario points   
                      LDY.W !StarKillCounter              ;;9616|9616/9616\9616; \    
                      CPY.B #$08                          ;;9619|9619/9619\9619;  | If consecutive enemies stomped < 8 ...   
                      BCS +                               ;;961B|961B/961B\961B;  |   
                      LDA.W DATA_038000-1,Y               ;;961D|961D/961D\961D;  |    ... play sound effect   
                      STA.W !SPCIO0                       ;;9620|9620/9620\9620; / Play sound effect 
                    + RTS                                 ;;9623|9623/9623\9623; Return 
                                                          ;;                   ;
                      RTS                                 ;;9624|9624/9624\9624;
                                                          ;;                   ;
                                                          ;;                   ;
RexKilledSpeed:       db $F0,$10                          ;;9625|9625/9625\9625;
                                                          ;;                   ;
                      RTS                                 ;;9627|9627/9627\9627;
                                                          ;;                   ;
RexPoints:            PHY                                 ;;9628|9628/9628\9628;
                      LDA.W !SpriteStompCounter           ;;9629|9629/9629\9629;
                      CLC                                 ;;962C|962C/962C\962C;
                      ADC.W !SpriteMisc1626,X             ;;962D|962D/962D\962D;
                      INC.W !SpriteStompCounter           ;;9630|9630/9630\9630; Increase consecutive enemies stomped       
                      TAY                                 ;;9633|9633/9633\9633;       
                      INY                                 ;;9634|9634/9634\9634;       
                      CPY.B #$08                          ;;9635|9635/9635\9635; \ If consecutive enemies stomped >= 8 ...       
                      BCS +                               ;;9637|9637/9637\9637; /    ... don't play sound        
                      LDA.W DATA_038000-1,Y               ;;9639|9639/9639\9639; \  
                      STA.W !SPCIO0                       ;;963C|963C/963C\963C; / Play sound effect 
                    + TYA                                 ;;963F|963F/963F\963F; \       
                      CMP.B #$08                          ;;9640|9640/9640\9640;  | If consecutive enemies stomped >= 8, reset to 8       
                      BCC +                               ;;9642|9642/9642\9642;  |       
                      LDA.B #$08                          ;;9644|9644/9644\9644; /       
                    + JSL GivePoints                      ;;9646|9646/9646\9646; Give mario points       
                      PLY                                 ;;964A|964A/964A\964A;       
                      RTS                                 ;;964B|964B/964B\964B; Return 
                                                          ;;                   ;
                                                          ;;                   ;
RexTileDispX:         db $FC,$00,$FC,$00,$FE,$00,$00,$00  ;;964C|964C/964C\964C;
                      db $00,$00,$00,$08,$04,$00,$04,$00  ;;9654|9654/9654\9654;
                      db $02,$00,$00,$00,$00,$00,$08,$00  ;;965C|965C/965C\965C;
RexTileDispY:         db $F1,$00,$F0,$00,$F8,$00,$00,$00  ;;9664|9664/9664\9664;
                      db $00,$00,$08,$08                  ;;966C|966C/966C\966C;
                                                          ;;                   ;
RexTiles:             db $8A,$AA,$8A,$AC,$8A,$AA,$8C,$8C  ;;9670|9670/9670\9670;
                      db $A8,$A8,$A2,$B2                  ;;9678|9678/9678\9678;
                                                          ;;                   ;
RexGfxProp:           db $47,$07                          ;;967C|967C/967C\967C;
                                                          ;;                   ;
RexGfxRt:             LDA.W !SpriteMisc1558,X             ;;967E|967E/967E\967E; \ If time to show Rex remains > 0...  
                      BEQ +                               ;;9681|9681/9681\9681;  |  
                      LDA.B #$05                          ;;9683|9683/9683\9683;  |    ...set Rex frame = 5 (fully squashed)  
                      STA.W !SpriteMisc1602,X             ;;9685|9685/9685\9685; /  
                    + LDA.W !SpriteMisc1FE2,X             ;;9688|9688/9688\9688; \ If time to show half smushed Rex > 0...  
                      BEQ +                               ;;968B|968B/968B\968B;  |  
                      LDA.B #$02                          ;;968D|968D/968D\968D;  |    ...set Rex frame = 2 (half smushed)  
                      STA.W !SpriteMisc1602,X             ;;968F|968F/968F\968F; /  
                    + JSR GetDrawInfoBnk3                 ;;9692|9692/9692\9692; Y = index to sprite tile map, $00 = sprite x, $01 = sprite y 
                      LDA.W !SpriteMisc1602,X             ;;9695|9695/9695\9695; \  
                      ASL A                               ;;9698|9698/9698\9698;  | $03 = index to frame start (frame to show * 2 tile per frame)  
                      STA.B !_3                           ;;9699|9699/9699\9699; /  
                      LDA.W !SpriteMisc157C,X             ;;969B|969B/969B\969B; \ $02 = sprite direction  
                      STA.B !_2                           ;;969E|969E/969E\969E; /  
                      PHX                                 ;;96A0|96A0/96A0\96A0; Push sprite index  
                      LDX.B #$01                          ;;96A1|96A1/96A1\96A1; Loop counter = (number of tiles per frame) - 1  
RexGfxLoopStart:      PHX                                 ;;96A3|96A3/96A3\96A3; Push current tile number  
                      TXA                                 ;;96A4|96A4/96A4\96A4; \ X = index to horizontal displacement  
                      ORA.B !_3                           ;;96A5|96A5/96A5\96A5; / get index of tile (index to first tile of frame + current tile number)  
                      PHA                                 ;;96A7|96A7/96A7\96A7; Push index of current tile  
                      LDX.B !_2                           ;;96A8|96A8/96A8\96A8; \ If facing right...  
                      BNE +                               ;;96AA|96AA/96AA\96AA;  |  
                      CLC                                 ;;96AC|96AC/96AC\96AC;  |      
                      ADC.B #$0C                          ;;96AD|96AD/96AD\96AD; /    ...use row 2 of horizontal tile displacement table  
                    + TAX                                 ;;96AF|96AF/96AF\96AF; \   
                      LDA.B !_0                           ;;96B0|96B0/96B0\96B0;  | Tile x position = sprite x location ($00) + tile displacement  
                      CLC                                 ;;96B2|96B2/96B2\96B2;  |  
                      ADC.W RexTileDispX,X                ;;96B3|96B3/96B3\96B3;  |  
                      STA.W !OAMTileXPos+$100,Y           ;;96B6|96B6/96B6\96B6; /  
                      PLX                                 ;;96B9|96B9/96B9\96B9; \ Pull, X = index to vertical displacement and tilemap  
                      LDA.B !_1                           ;;96BA|96BA/96BA\96BA;  | Tile y position = sprite y location ($01) + tile displacement  
                      CLC                                 ;;96BC|96BC/96BC\96BC;  |  
                      ADC.W RexTileDispY,X                ;;96BD|96BD/96BD\96BD;  |  
                      STA.W !OAMTileYPos+$100,Y           ;;96C0|96C0/96C0\96C0; /  
                      LDA.W RexTiles,X                    ;;96C3|96C3/96C3\96C3; \ Store tile  
                      STA.W !OAMTileNo+$100,Y             ;;96C6|96C6/96C6\96C6; /   
                      LDX.B !_2                           ;;96C9|96C9/96C9\96C9; \  
                      LDA.W RexGfxProp,X                  ;;96CB|96CB/96CB\96CB;  | Get tile properties using sprite direction  
                      ORA.B !SpriteProperties             ;;96CE|96CE/96CE\96CE;  | Level properties 
                      STA.W !OAMTileAttr+$100,Y           ;;96D0|96D0/96D0\96D0; / Store tile properties  
                      TYA                                 ;;96D3|96D3/96D3\96D3; \ Get index to sprite property map ($460)...  
                      LSR A                               ;;96D4|96D4/96D4\96D4;  |    ...we use the sprite OAM index...  
                      LSR A                               ;;96D5|96D5/96D5\96D5;  |    ...and divide by 4 because a 16x16 tile is 4 8x8 tiles  
                      LDX.B !_3                           ;;96D6|96D6/96D6\96D6;  | If index of frame start is > 0A   
                      CPX.B #$0A                          ;;96D8|96D8/96D8\96D8;  |  
                      TAX                                 ;;96DA|96DA/96DA\96DA;  | 
                      LDA.B #$00                          ;;96DB|96DB/96DB\96DB;  |     ...show only an 8x8 tile   
                      BCS +                               ;;96DD|96DD/96DD\96DD;  |   
                      LDA.B #$02                          ;;96DF|96DF/96DF\96DF;  | Else show a full 16 x 16 tile   
                    + STA.W !OAMTileSize+$40,X            ;;96E1|96E1/96E1\96E1; /   
                      PLX                                 ;;96E4|96E4/96E4\96E4; \ Pull, X = current tile of the frame we're drawing  
                      INY                                 ;;96E5|96E5/96E5\96E5;  | Increase index to sprite tile map ($300)...   
                      INY                                 ;;96E6|96E6/96E6\96E6;  |    ...we wrote 4 times...   
                      INY                                 ;;96E7|96E7/96E7\96E7;  |    ...so increment 4 times  
                      INY                                 ;;96E8|96E8/96E8\96E8;  | 
                      DEX                                 ;;96E9|96E9/96E9\96E9;  | Go to next tile of frame and loop   
                      BPL RexGfxLoopStart                 ;;96EA|96EA/96EA\96EA; /    
                      PLX                                 ;;96EC|96EC/96EC\96EC; Pull, X = sprite index   
                      LDY.B #$FF                          ;;96ED|96ED/96ED\96ED; \ FF because we already wrote size to $0460       
                      LDA.B #$01                          ;;96EF|96EF/96EF\96EF;  | A = number of tiles drawn - 1   
                      JSL FinishOAMWrite                  ;;96F1|96F1/96F1\96F1; / Don't draw if offscreen   
                      RTS                                 ;;96F5|96F5/96F5\96F5; Return 
                                                          ;;                   ;
Fishbone:             JSR FishboneGfx                     ;;96F6|96F6/96F6\96F6;
                      LDA.B !SpriteLock                   ;;96F9|96F9/96F9\96F9;
                      BNE Return03972A                    ;;96FB|96FB/96FB\96FB;
                      JSR SubOffscreen0Bnk3               ;;96FD|96FD/96FD\96FD;
                      JSL MarioSprInteract                ;;9700|9700/9700\9700;
                      JSL UpdateXPosNoGvtyW               ;;9704|9704/9704\9704;
                      TXA                                 ;;9708|9708/9708\9708;
                      ASL A                               ;;9709|9709/9709\9709;
                      ASL A                               ;;970A|970A/970A\970A;
                      ASL A                               ;;970B|970B/970B\970B;
                      ASL A                               ;;970C|970C/970C\970C;
                      ADC.B !TrueFrame                    ;;970D|970D/970D\970D;
                      AND.B #$7F                          ;;970F|970F/970F\970F;
                      BNE +                               ;;9711|9711/9711\9711;
                      JSL GetRand                         ;;9713|9713/9713\9713;
                      AND.B #$01                          ;;9717|9717/9717\9717;
                      BNE +                               ;;9719|9719/9719\9719;
                      LDA.B #$0C                          ;;971B|971B/971B\971B;
                      STA.W !SpriteMisc1558,X             ;;971D|971D/971D\971D;
                    + LDA.B !SpriteTableC2,X              ;;9720|9720/9720\9720;
                      JSL ExecutePtr                      ;;9722|9722/9722\9722;
                                                          ;;                   ;
                      dw CODE_03972F                      ;;9726|9726/9726\9726;
                      dw CODE_03975E                      ;;9728|9728/9728\9728;
                                                          ;;                   ;
Return03972A:         RTS                                 ;;972A|972A/972A\972A; Return 
                                                          ;;                   ;
                                                          ;;                   ;
FishboneMaxSpeed:     db $10,$F0                          ;;972B|972B/972B\972B;
                                                          ;;                   ;
FishboneAcceler:      db $01,$FF                          ;;972D|972D/972D\972D;
                                                          ;;                   ;
CODE_03972F:          INC.W !SpriteMisc1570,X             ;;972F|972F/972F\972F;
                      LDA.W !SpriteMisc1570,X             ;;9732|9732/9732\9732;
                      NOP                                 ;;9735|9735/9735\9735;
                      LSR A                               ;;9736|9736/9736\9736;
                      AND.B #$01                          ;;9737|9737/9737\9737;
                      STA.W !SpriteMisc1602,X             ;;9739|9739/9739\9739;
                      LDA.W !SpriteMisc1540,X             ;;973C|973C/973C\973C;
                      BEQ CODE_039756                     ;;973F|973F/973F\973F;
                      AND.B #$01                          ;;9741|9741/9741\9741;
                      BNE +                               ;;9743|9743/9743\9743;
                      LDY.W !SpriteMisc157C,X             ;;9745|9745/9745\9745;
                      LDA.B !SpriteXSpeed,X               ;;9748|9748/9748\9748;
                      CMP.W FishboneMaxSpeed,Y            ;;974A|974A/974A\974A;
                      BEQ +                               ;;974D|974D/974D\974D;
                      CLC                                 ;;974F|974F/974F\974F;
                      ADC.W FishboneAcceler,Y             ;;9750|9750/9750\9750;
                      STA.B !SpriteXSpeed,X               ;;9753|9753/9753\9753;
                    + RTS                                 ;;9755|9755/9755\9755; Return 
                                                          ;;                   ;
CODE_039756:          INC.B !SpriteTableC2,X              ;;9756|9756/9756\9756;
                      LDA.B #$30                          ;;9758|9758/9758\9758;
                      STA.W !SpriteMisc1540,X             ;;975A|975A/975A\975A;
                      RTS                                 ;;975D|975D/975D\975D; Return 
                                                          ;;                   ;
CODE_03975E:          STZ.W !SpriteMisc1602,X             ;;975E|975E/975E\975E;
                      LDA.W !SpriteMisc1540,X             ;;9761|9761/9761\9761;
                      BEQ CODE_039776                     ;;9764|9764/9764\9764;
                      AND.B #$03                          ;;9766|9766/9766\9766;
                      BNE Return039775                    ;;9768|9768/9768\9768;
                      LDA.B !SpriteXSpeed,X               ;;976A|976A/976A\976A;
                      BEQ Return039775                    ;;976C|976C/976C\976C;
                      BPL +                               ;;976E|976E/976E\976E;
                      INC.B !SpriteXSpeed,X               ;;9770|9770/9770\9770;
                      RTS                                 ;;9772|9772/9772\9772; Return 
                                                          ;;                   ;
                    + DEC.B !SpriteXSpeed,X               ;;9773|9773/9773\9773;
Return039775:         RTS                                 ;;9775|9775/9775\9775; Return 
                                                          ;;                   ;
CODE_039776:          STZ.B !SpriteTableC2,X              ;;9776|9776/9776\9776;
                      LDA.B #$30                          ;;9778|9778/9778\9778;
                      STA.W !SpriteMisc1540,X             ;;977A|977A/977A\977A;
                      RTS                                 ;;977D|977D/977D\977D; Return 
                                                          ;;                   ;
                                                          ;;                   ;
FishboneDispX:        db $F8,$F8,$10,$10                  ;;977E|977E/977E\977E;
                                                          ;;                   ;
FishboneDispY:        db $00,$08                          ;;9782|9782/9782\9782;
                                                          ;;                   ;
FishboneGfxProp:      db $4D,$CD,$0D,$8D                  ;;9784|9784/9784\9784;
                                                          ;;                   ;
FishboneTailTiles:    db $A3,$A3,$B3,$B3                  ;;9788|9788/9788\9788;
                                                          ;;                   ;
FishboneGfx:          JSL GenericSprGfxRt2                ;;978C|978C/978C\978C;
                      LDY.W !SpriteOAMIndex,X             ;;9790|9790/9790\9790; Y = Index into sprite OAM 
                      LDA.W !SpriteMisc1558,X             ;;9793|9793/9793\9793;
                      CMP.B #$01                          ;;9796|9796/9796\9796;
                      LDA.B #$A6                          ;;9798|9798/9798\9798;
                      BCC +                               ;;979A|979A/979A\979A;
                      LDA.B #$A8                          ;;979C|979C/979C\979C;
                    + STA.W !OAMTileNo+$100,Y             ;;979E|979E/979E\979E;
                      JSR GetDrawInfoBnk3                 ;;97A1|97A1/97A1\97A1;
                      LDA.W !SpriteMisc157C,X             ;;97A4|97A4/97A4\97A4;
                      ASL A                               ;;97A7|97A7/97A7\97A7;
                      STA.B !_2                           ;;97A8|97A8/97A8\97A8;
                      LDA.W !SpriteMisc1602,X             ;;97AA|97AA/97AA\97AA;
                      ASL A                               ;;97AD|97AD/97AD\97AD;
                      STA.B !_3                           ;;97AE|97AE/97AE\97AE;
                      LDA.W !SpriteOAMIndex,X             ;;97B0|97B0/97B0\97B0;
                      CLC                                 ;;97B3|97B3/97B3\97B3;
                      ADC.B #$04                          ;;97B4|97B4/97B4\97B4;
                      STA.W !SpriteOAMIndex,X             ;;97B6|97B6/97B6\97B6;
                      TAY                                 ;;97B9|97B9/97B9\97B9;
                      PHX                                 ;;97BA|97BA/97BA\97BA;
                      LDX.B #$01                          ;;97BB|97BB/97BB\97BB;
                    - LDA.B !_1                           ;;97BD|97BD/97BD\97BD;
                      CLC                                 ;;97BF|97BF/97BF\97BF;
                      ADC.W FishboneDispY,X               ;;97C0|97C0/97C0\97C0;
                      STA.W !OAMTileYPos+$100,Y           ;;97C3|97C3/97C3\97C3;
                      PHX                                 ;;97C6|97C6/97C6\97C6;
                      TXA                                 ;;97C7|97C7/97C7\97C7;
                      ORA.B !_2                           ;;97C8|97C8/97C8\97C8;
                      TAX                                 ;;97CA|97CA/97CA\97CA;
                      LDA.B !_0                           ;;97CB|97CB/97CB\97CB;
                      CLC                                 ;;97CD|97CD/97CD\97CD;
                      ADC.W FishboneDispX,X               ;;97CE|97CE/97CE\97CE;
                      STA.W !OAMTileXPos+$100,Y           ;;97D1|97D1/97D1\97D1;
                      LDA.W FishboneGfxProp,X             ;;97D4|97D4/97D4\97D4;
                      ORA.B !SpriteProperties             ;;97D7|97D7/97D7\97D7;
                      STA.W !OAMTileAttr+$100,Y           ;;97D9|97D9/97D9\97D9;
                      PLA                                 ;;97DC|97DC/97DC\97DC;
                      PHA                                 ;;97DD|97DD/97DD\97DD;
                      ORA.B !_3                           ;;97DE|97DE/97DE\97DE;
                      TAX                                 ;;97E0|97E0/97E0\97E0;
                      LDA.W FishboneTailTiles,X           ;;97E1|97E1/97E1\97E1;
                      STA.W !OAMTileNo+$100,Y             ;;97E4|97E4/97E4\97E4;
                      PLX                                 ;;97E7|97E7/97E7\97E7;
                      INY                                 ;;97E8|97E8/97E8\97E8;
                      INY                                 ;;97E9|97E9/97E9\97E9;
                      INY                                 ;;97EA|97EA/97EA\97EA;
                      INY                                 ;;97EB|97EB/97EB\97EB;
                      DEX                                 ;;97EC|97EC/97EC\97EC;
                      BPL -                               ;;97ED|97ED/97ED\97ED;
                      PLX                                 ;;97EF|97EF/97EF\97EF;
                      LDY.B #$00                          ;;97F0|97F0/97F0\97F0;
                      LDA.B #$02                          ;;97F2|97F2/97F2\97F2;
                      JSL FinishOAMWrite                  ;;97F4|97F4/97F4\97F4;
                      RTS                                 ;;97F8|97F8/97F8\97F8; Return 
                                                          ;;                   ;
CODE_0397F9:          STA.B !_1                           ;;97F9|97F9/97F9\97F9;
                      PHX                                 ;;97FB|97FB/97FB\97FB;
                      PHY                                 ;;97FC|97FC/97FC\97FC;
                      JSR SubVertPosBnk3                  ;;97FD|97FD/97FD\97FD;
                      STY.B !_2                           ;;9800|9800/9800\9800;
                      LDA.B !_E                           ;;9802|9802/9802\9802;
                      BPL +                               ;;9804|9804/9804\9804;
                      EOR.B #$FF                          ;;9806|9806/9806\9806;
                      CLC                                 ;;9808|9808/9808\9808;
                      ADC.B #$01                          ;;9809|9809/9809\9809;
                    + STA.B !_C                           ;;980B|980B/980B\980B;
                      JSR SubHorzPosBnk3                  ;;980D|980D/980D\980D;
                      STY.B !_3                           ;;9810|9810/9810\9810;
                      LDA.B !_F                           ;;9812|9812/9812\9812;
                      BPL +                               ;;9814|9814/9814\9814;
                      EOR.B #$FF                          ;;9816|9816/9816\9816;
                      CLC                                 ;;9818|9818/9818\9818;
                      ADC.B #$01                          ;;9819|9819/9819\9819;
                    + STA.B !_D                           ;;981B|981B/981B\981B;
                      LDY.B #$00                          ;;981D|981D/981D\981D;
                      LDA.B !_D                           ;;981F|981F/981F\981F;
                      CMP.B !_C                           ;;9821|9821/9821\9821;
                      BCS +                               ;;9823|9823/9823\9823;
                      INY                                 ;;9825|9825/9825\9825;
                      PHA                                 ;;9826|9826/9826\9826;
                      LDA.B !_C                           ;;9827|9827/9827\9827;
                      STA.B !_D                           ;;9829|9829/9829\9829;
                      PLA                                 ;;982B|982B/982B\982B;
                      STA.B !_C                           ;;982C|982C/982C\982C;
                    + LDA.B #$00                          ;;982E|982E/982E\982E;
                      STA.B !_B                           ;;9830|9830/9830\9830;
                      STA.B !_0                           ;;9832|9832/9832\9832;
                      LDX.B !_1                           ;;9834|9834/9834\9834;
CODE_039836:          LDA.B !_B                           ;;9836|9836/9836\9836;
                      CLC                                 ;;9838|9838/9838\9838;
                      ADC.B !_C                           ;;9839|9839/9839\9839;
                      CMP.B !_D                           ;;983B|983B/983B\983B;
                      BCC +                               ;;983D|983D/983D\983D;
                      SBC.B !_D                           ;;983F|983F/983F\983F;
                      INC.B !_0                           ;;9841|9841/9841\9841;
                    + STA.B !_B                           ;;9843|9843/9843\9843;
                      DEX                                 ;;9845|9845/9845\9845;
                      BNE CODE_039836                     ;;9846|9846/9846\9846;
                      TYA                                 ;;9848|9848/9848\9848;
                      BEQ +                               ;;9849|9849/9849\9849;
                      LDA.B !_0                           ;;984B|984B/984B\984B;
                      PHA                                 ;;984D|984D/984D\984D;
                      LDA.B !_1                           ;;984E|984E/984E\984E;
                      STA.B !_0                           ;;9850|9850/9850\9850;
                      PLA                                 ;;9852|9852/9852\9852;
                      STA.B !_1                           ;;9853|9853/9853\9853;
                    + LDA.B !_0                           ;;9855|9855/9855\9855;
                      LDY.B !_2                           ;;9857|9857/9857\9857;
                      BEQ +                               ;;9859|9859/9859\9859;
                      EOR.B #$FF                          ;;985B|985B/985B\985B;
                      CLC                                 ;;985D|985D/985D\985D;
                      ADC.B #$01                          ;;985E|985E/985E\985E;
                      STA.B !_0                           ;;9860|9860/9860\9860;
                    + LDA.B !_1                           ;;9862|9862/9862\9862;
                      LDY.B !_3                           ;;9864|9864/9864\9864;
                      BEQ +                               ;;9866|9866/9866\9866;
                      EOR.B #$FF                          ;;9868|9868/9868\9868;
                      CLC                                 ;;986A|986A/986A\986A;
                      ADC.B #$01                          ;;986B|986B/986B\986B;
                      STA.B !_1                           ;;986D|986D/986D\986D;
                    + PLY                                 ;;986F|986F/986F\986F;
                      PLX                                 ;;9870|9870/9870\9870;
                      RTS                                 ;;9871|9871/9871\9871; Return 
                                                          ;;                   ;
ReznorInit:           CPX.B #$07                          ;;9872|9872/9872\9872;
                      BNE +                               ;;9874|9874/9874\9874;
                      LDA.B #$04                          ;;9876|9876/9876\9876;
                      STA.B !SpriteTableC2,X              ;;9878|9878/9878\9878;
                      JSL CODE_03DD7D                     ;;987A|987A/987A\987A;
                    + JSL GetRand                         ;;987E|987E/987E\987E;
                      STA.W !SpriteMisc1570,X             ;;9882|9882/9882\9882;
                      RTL                                 ;;9885|9885/9885\9885; Return 
                                                          ;;                   ;
                                                          ;;                   ;
ReznorStartPosLo:     db $00,$80,$00,$80                  ;;9886|9886/9886\9886;
                                                          ;;                   ;
ReznorStartPosHi:     db $00,$00,$01,$01                  ;;988A|988A/988A\988A;
                                                          ;;                   ;
ReboundSpeedX:        db $20,$E0                          ;;988E|988E/988E\988E;
                                                          ;;                   ;
Reznor:               INC.W !ReznorOAMIndex               ;;9890|9890/9890\9890;
                      LDA.B !SpriteLock                   ;;9893|9893/9893\9893;
                      BEQ +                               ;;9895|9895/9895\9895;
                      JMP DrawReznor                      ;;9897|9897/9897\9897;
                                                          ;;                   ;
                    + CPX.B #$07                          ;;989A|989A/989A\989A;
                      BNE CODE_039910                     ;;989C|989C/989C\989C;
                      PHX                                 ;;989E|989E/989E\989E;
                      JSL CODE_03D70C                     ;;989F|989F/989F\989F; Break bridge when necessary 
                      LDA.B #$80                          ;;98A3|98A3/98A3\98A3; \ Set radius for Reznor sign rotation 
                      STA.B !Mode7CenterX                 ;;98A5|98A5/98A5\98A5;  | 
                      STZ.B !Mode7CenterX+1               ;;98A7|98A7/98A7\98A7; / 
                      LDX.B #$00                          ;;98A9|98A9/98A9\98A9;
                      LDA.B #$C0                          ;;98AB|98AB/98AB\98AB; \ X position of Reznor sign 
                      STA.B !SpriteXPosLow                ;;98AD|98AD/98AD\98AD;  | 
                      STZ.W !SpriteYPosHigh               ;;98AF|98AF/98AF\98AF; / 
                      LDA.B #$B2                          ;;98B2|98B2/98B2\98B2; \ Y position of Reznor sign 
                      STA.B !SpriteYPosLow                ;;98B4|98B4/98B4\98B4;  | 
                      STZ.W !SpriteXPosHigh               ;;98B6|98B6/98B6\98B6; / 
                      LDA.B #$2C                          ;;98B9|98B9/98B9\98B9;
                      STA.W !Mode7TileIndex               ;;98BB|98BB/98BB\98BB;
                      JSL CODE_03DEDF                     ;;98BE|98BE/98BE\98BE; Applies position changes to Reznor sign 
                      PLX                                 ;;98C2|98C2/98C2\98C2; Pull, X = sprite index 
                      REP #$20                            ;;98C3|98C3/98C3\98C3; Accum (16 bit) 
                      LDA.B !Mode7Angle                   ;;98C5|98C5/98C5\98C5; \ Rotate 1 frame around the circle (clockwise) 
                      CLC                                 ;;98C7|98C7/98C7\98C7;  | $37,36 = 0 to 1FF, denotes circle position 
                      ADC.W #$0001                        ;;98C8|98C8/98C8\98C8;  | 
                      AND.W #$01FF                        ;;98CB|98CB/98CB\98CB;  | 
                      STA.B !Mode7Angle                   ;;98CE|98CE/98CE\98CE; / 
                      SEP #$20                            ;;98D0|98D0/98D0\98D0; Accum (8 bit) 
                      CPX.B #$07                          ;;98D2|98D2/98D2\98D2;
                      BNE CODE_039910                     ;;98D4|98D4/98D4\98D4;
                      LDA.W !SpriteMisc163E,X             ;;98D6|98D6/98D6\98D6; \ Branch if timer to trigger level isn't set 
                      BEQ ReznorNoLevelEnd                ;;98D9|98D9/98D9\98D9; / 
                      DEC A                               ;;98DB|98DB/98DB\98DB;
                      BNE CODE_039910                     ;;98DC|98DC/98DC\98DC;
                      DEC.W !CutsceneID                   ;;98DE|98DE/98DE\98DE; Prevent mario from walking at level end 
                      LDA.B #$FF                          ;;98E1|98E1/98E1\98E1; \ Set time before return to overworld 
                      STA.W !EndLevelTimer                ;;98E3|98E3/98E3\98E3; / 
                      LDA.B #$0B                          ;;98E6|98E6/98E6\98E6; \ 
                      STA.W !SPCIO2                       ;;98E8|98E8/98E8\98E8; / Play sound effect 
                      RTS                                 ;;98EB|98EB/98EB\98EB; Return 
                                                          ;;                   ;
ReznorNoLevelEnd:     LDA.W !SpriteMisc151C+7             ;;98EC|98EC/98EC\98EC; \ 
                      CLC                                 ;;98EF|98EF/98EF\98EF;  | 
                      ADC.W !SpriteMisc151C+6             ;;98F0|98F0/98F0\98F0;  | 
                      ADC.W !SpriteMisc151C+5             ;;98F3|98F3/98F3\98F3;  | 
                      ADC.W !SpriteMisc151C+4             ;;98F6|98F6/98F6\98F6;  | 
                      CMP.B #$04                          ;;98F9|98F9/98F9\98F9;  | 
                      BNE CODE_039910                     ;;98FB|98FB/98FB\98FB;  | 
                      LDA.B #$90                          ;;98FD|98FD/98FD\98FD;  | Set time to trigger level if all Reznors are dead 
                      STA.W !SpriteMisc163E,X             ;;98FF|98FF/98FF\98FF; / 
                      JSL KillMostSprites                 ;;9902|9902/9902\9902;
                      LDY.B #$07                          ;;9906|9906/9906\9906; \ Zero out extended sprite table 
                      LDA.B #$00                          ;;9908|9908/9908\9908;  | 
                    - STA.W !ExtSpriteNumber,Y            ;;990A|990A/990A\990A;  | 
                      DEY                                 ;;990D|990D/990D\990D;  | 
                      BPL -                               ;;990E|990E/990E\990E; / 
CODE_039910:          LDA.W !SpriteStatus,X               ;;9910|9910/9910\9910;
                      CMP.B #$08                          ;;9913|9913/9913\9913;
                      BEQ +                               ;;9915|9915/9915\9915;
                      JMP DrawReznor                      ;;9917|9917/9917\9917;
                                                          ;;                   ;
                    + TXA                                 ;;991A|991A/991A\991A; \ Load Y with Reznor number (0-3)  
                      AND.B #$03                          ;;991B|991B/991B\991B;  |  
                      TAY                                 ;;991D|991D/991D\991D; /  
                      LDA.B !Mode7Angle                   ;;991E|991E/991E\991E; \  
                      CLC                                 ;;9920|9920/9920\9920;  |  
                      ADC.W ReznorStartPosLo,Y            ;;9921|9921/9921\9921;  |  
                      STA.B !_0                           ;;9924|9924/9924\9924;  | $01,00 = 0-1FF, position Reznors on the circle  
                      LDA.B !Mode7Angle+1                 ;;9926|9926/9926\9926;  |  
                      ADC.W ReznorStartPosHi,Y            ;;9928|9928/9928\9928;  |  
                      AND.B #$01                          ;;992B|992B/992B\992B;  |  
                      STA.B !_1                           ;;992D|992D/992D\992D; /  
                      REP #$30                            ;;992F|992F/992F\992F; \   Index (16 bit) Accum (16 bit)  ; Index (16 bit) Accum (16 bit) 
                      LDA.B !_0                           ;;9931|9931/9931\9931;  | Make Reznors turn clockwise rather than counter clockwise 
                      EOR.W #$01FF                        ;;9933|9933/9933\9933;  | ($01,00 = -1 * $01,00)   
                      INC A                               ;;9936|9936/9936\9936;  |  
                      STA.B !_0                           ;;9937|9937/9937\9937; /                                                           
                      CLC                                 ;;9939|9939/9939\9939;
                      ADC.W #$0080                        ;;993A|993A/993A\993A;
                      AND.W #$01FF                        ;;993D|993D/993D\993D;
                      STA.B !_2                           ;;9940|9940/9940\9940;
                      LDA.B !_0                           ;;9942|9942/9942\9942;
                      AND.W #$00FF                        ;;9944|9944/9944\9944;
                      ASL A                               ;;9947|9947/9947\9947;
                      TAX                                 ;;9948|9948/9948\9948;
                      LDA.L CircleCoords,X                ;;9949|9949/9949\9949;
                      STA.B !_4                           ;;994D|994D/994D\994D;
                      LDA.B !_2                           ;;994F|994F/994F\994F;
                      AND.W #$00FF                        ;;9951|9951/9951\9951;
                      ASL A                               ;;9954|9954/9954\9954;
                      TAX                                 ;;9955|9955/9955\9955;
                      LDA.L CircleCoords,X                ;;9956|9956/9956\9956;
                      STA.B !_6                           ;;995A|995A/995A\995A;
                      SEP #$30                            ;;995C|995C/995C\995C; Index (8 bit) Accum (8 bit) 
                      LDA.B !_4                           ;;995E|995E/995E\995E;
                      STA.W !HW_WRMPYA                    ;;9960|9960/9960\9960; Multiplicand A
                      LDA.B #$38                          ;;9963|9963/9963\9963;
                      LDY.B !_5                           ;;9965|9965/9965\9965;
                      BNE +                               ;;9967|9967/9967\9967;
                      STA.W !HW_WRMPYB                    ;;9969|9969/9969\9969; Multplier B
                      NOP                                 ;;996C|996C/996C\996C;
                      NOP                                 ;;996D|996D/996D\996D;
                      NOP                                 ;;996E|996E/996E\996E;
                      NOP                                 ;;996F|996F/996F\996F;
                      ASL.W !HW_RDMPY                     ;;9970|9970/9970\9970; Product/Remainder Result (Low Byte)
                      LDA.W !HW_RDMPY+1                   ;;9973|9973/9973\9973; Product/Remainder Result (High Byte)
                      ADC.B #$00                          ;;9976|9976/9976\9976;
                    + LSR.B !_1                           ;;9978|9978/9978\9978;
                      BCC +                               ;;997A|997A/997A\997A;
                      EOR.B #$FF                          ;;997C|997C/997C\997C;
                      INC A                               ;;997E|997E/997E\997E;
                    + STA.B !_4                           ;;997F|997F/997F\997F;
                      LDA.B !_6                           ;;9981|9981/9981\9981;
                      STA.W !HW_WRMPYA                    ;;9983|9983/9983\9983; Multiplicand A
                      LDA.B #$38                          ;;9986|9986/9986\9986;
                      LDY.B !_7                           ;;9988|9988/9988\9988;
                      BNE +                               ;;998A|998A/998A\998A;
                      STA.W !HW_WRMPYB                    ;;998C|998C/998C\998C; Multplier B
                      NOP                                 ;;998F|998F/998F\998F;
                      NOP                                 ;;9990|9990/9990\9990;
                      NOP                                 ;;9991|9991/9991\9991;
                      NOP                                 ;;9992|9992/9992\9992;
                      ASL.W !HW_RDMPY                     ;;9993|9993/9993\9993; Product/Remainder Result (Low Byte)
                      LDA.W !HW_RDMPY+1                   ;;9996|9996/9996\9996; Product/Remainder Result (High Byte)
                      ADC.B #$00                          ;;9999|9999/9999\9999;
                    + LSR.B !_3                           ;;999B|999B/999B\999B;
                      BCC +                               ;;999D|999D/999D\999D;
                      EOR.B #$FF                          ;;999F|999F/999F\999F;
                      INC A                               ;;99A1|99A1/99A1\99A1;
                    + STA.B !_6                           ;;99A2|99A2/99A2\99A2;
                      LDX.W !CurSpriteProcess             ;;99A4|99A4/99A4\99A4; X = sprite index 
                      LDA.B !SpriteXPosLow,X              ;;99A7|99A7/99A7\99A7;
                      PHA                                 ;;99A9|99A9/99A9\99A9;
                      STZ.B !_0                           ;;99AA|99AA/99AA\99AA;
                      LDA.B !_4                           ;;99AC|99AC/99AC\99AC;
                      BPL +                               ;;99AE|99AE/99AE\99AE;
                      DEC.B !_0                           ;;99B0|99B0/99B0\99B0;
                    + CLC                                 ;;99B2|99B2/99B2\99B2;
                      ADC.B !Mode7CenterX                 ;;99B3|99B3/99B3\99B3;
                      PHP                                 ;;99B5|99B5/99B5\99B5;
                      CLC                                 ;;99B6|99B6/99B6\99B6;
                      ADC.B #$40                          ;;99B7|99B7/99B7\99B7;
                      STA.B !SpriteXPosLow,X              ;;99B9|99B9/99B9\99B9;
                      LDA.B !Mode7CenterX+1               ;;99BB|99BB/99BB\99BB;
                      ADC.B #$00                          ;;99BD|99BD/99BD\99BD;
                      PLP                                 ;;99BF|99BF/99BF\99BF;
                      ADC.B !_0                           ;;99C0|99C0/99C0\99C0;
                      STA.W !SpriteYPosHigh,X             ;;99C2|99C2/99C2\99C2;
                      PLA                                 ;;99C5|99C5/99C5\99C5;
                      SEC                                 ;;99C6|99C6/99C6\99C6;
                      SBC.B !SpriteXPosLow,X              ;;99C7|99C7/99C7\99C7;
                      EOR.B #$FF                          ;;99C9|99C9/99C9\99C9;
                      INC A                               ;;99CB|99CB/99CB\99CB;
                      STA.W !SpriteMisc1528,X             ;;99CC|99CC/99CC\99CC;
                      STZ.B !_1                           ;;99CF|99CF/99CF\99CF;
                      LDA.B !_6                           ;;99D1|99D1/99D1\99D1;
                      BPL +                               ;;99D3|99D3/99D3\99D3;
                      DEC.B !_1                           ;;99D5|99D5/99D5\99D5;
                    + CLC                                 ;;99D7|99D7/99D7\99D7;
                      ADC.B !Mode7CenterY                 ;;99D8|99D8/99D8\99D8;
                      PHP                                 ;;99DA|99DA/99DA\99DA;
                      ADC.B #$20                          ;;99DB|99DB/99DB\99DB;
                      STA.B !SpriteYPosLow,X              ;;99DD|99DD/99DD\99DD;
                      LDA.B !Mode7CenterY+1               ;;99DF|99DF/99DF\99DF;
                      ADC.B #$00                          ;;99E1|99E1/99E1\99E1;
                      PLP                                 ;;99E3|99E3/99E3\99E3;
                      ADC.B !_1                           ;;99E4|99E4/99E4\99E4;
                      STA.W !SpriteXPosHigh,X             ;;99E6|99E6/99E6\99E6;
                      LDA.W !SpriteMisc151C,X             ;;99E9|99E9/99E9\99E9; \ If a Reznor is dead, make it's platform standable 
                      BEQ +                               ;;99EC|99EC/99EC\99EC;  | 
                      JSL InvisBlkMainRt                  ;;99EE|99EE/99EE\99EE;  | 
                      JMP DrawReznor                      ;;99F2|99F2/99F2\99F2; / 
                                                          ;;                   ;
                    + LDA.B !TrueFrame                    ;;99F5|99F5/99F5\99F5; \ Don't try to spit fire if turning 
                      AND.B #$00                          ;;99F7|99F7/99F7\99F7;  | 
                      ORA.W !SpriteMisc15AC,X             ;;99F9|99F9/99F9\99F9;  | 
                      BNE +                               ;;99FC|99FC/99FC\99FC; / 
                      INC.W !SpriteMisc1570,X             ;;99FE|99FE/99FE\99FE;
                      LDA.W !SpriteMisc1570,X             ;;9A01|9A01/9A01\9A01;
                      CMP.B #$00                          ;;9A04|9A04/9A04\9A04;
                      BNE +                               ;;9A06|9A06/9A06\9A06;
                      STZ.W !SpriteMisc1570,X             ;;9A08|9A08/9A08\9A08;
                      LDA.B #$40                          ;;9A0B|9A0B/9A0B\9A0B; \ Set time to show firing graphic = 0A 
                      STA.W !SpriteMisc1558,X             ;;9A0D|9A0D/9A0D\9A0D; / 
                    + TXA                                 ;;9A10|9A10/9A10\9A10;
                      ASL A                               ;;9A11|9A11/9A11\9A11;
                      ASL A                               ;;9A12|9A12/9A12\9A12;
                      ASL A                               ;;9A13|9A13/9A13\9A13;
                      ASL A                               ;;9A14|9A14/9A14\9A14;
                      ADC.B !EffFrame                     ;;9A15|9A15/9A15\9A15;
                      AND.B #$3F                          ;;9A17|9A17/9A17\9A17;
                      ORA.W !SpriteMisc1558,X             ;;9A19|9A19/9A19\9A19; Firing 
                      ORA.W !SpriteMisc15AC,X             ;;9A1C|9A1C/9A1C\9A1C; Turning 
                      BNE +                               ;;9A1F|9A1F/9A1F\9A1F;
                      LDA.W !SpriteMisc157C,X             ;;9A21|9A21/9A21\9A21; \ if direction has changed since last frame...   
                      PHA                                 ;;9A24|9A24/9A24\9A24;  |   
                      JSR SubHorzPosBnk3                  ;;9A25|9A25/9A25\9A25;  |   
                      TYA                                 ;;9A28|9A28/9A28\9A28;  |   
                      STA.W !SpriteMisc157C,X             ;;9A29|9A29/9A29\9A29;  |   
                      PLA                                 ;;9A2C|9A2C/9A2C\9A2C;  |   
                      CMP.W !SpriteMisc157C,X             ;;9A2D|9A2D/9A2D\9A2D;  |   
                      BEQ +                               ;;9A30|9A30/9A30\9A30;  |   
                      LDA.B #$0A                          ;;9A32|9A32/9A32\9A32;  | ...set time to show turning graphic = 0A   
                      STA.W !SpriteMisc15AC,X             ;;9A34|9A34/9A34\9A34; /   
                    + LDA.W !SpriteMisc154C,X             ;;9A37|9A37/9A37\9A37; \ If disable interaction timer > 0, just draw Reznor   
                      BNE DrawReznor                      ;;9A3A|9A3A/9A3A\9A3A; /   
                      JSL MarioSprInteract                ;;9A3C|9A3C/9A3C\9A3C; \ Interact with mario   
                      BCC DrawReznor                      ;;9A40|9A40/9A40\9A40; / If no contact, just draw Reznor   
                      LDA.B #$08                          ;;9A42|9A42/9A42\9A42; \ Disable interaction timer = 08   
                      STA.W !SpriteMisc154C,X             ;;9A44|9A44/9A44\9A44; / (eg. after hitting Reznor, or getting bounced by platform) 
                      LDA.B !PlayerYPosNext               ;;9A47|9A47/9A47\9A47; \ Compare y positions to see if mario hit Reznor   
                      SEC                                 ;;9A49|9A49/9A49\9A49;  |   
                      SBC.B !SpriteYPosLow,X              ;;9A4A|9A4A/9A4A\9A4A;  |   
                      CMP.B #$ED                          ;;9A4C|9A4C/9A4C\9A4C;  |   
                      BMI HitReznor                       ;;9A4E|9A4E/9A4E\9A4E; /   
                      CMP.B #$F2                          ;;9A50|9A50/9A50\9A50; \ See if mario hit side of the platform   
                      BMI HitPlatSide                     ;;9A52|9A52/9A52\9A52;  |   
                      LDA.B !PlayerYSpeed                 ;;9A54|9A54/9A54\9A54;  |   
                      BPL HitPlatSide                     ;;9A56|9A56/9A56\9A56; /   
                      LDA.B #$29                          ;;9A58|9A58/9A58\9A58; ??Something about boosting mario on platform?? 
                      STA.W !SpriteTweakerB,X             ;;9A5A|9A5A/9A5A\9A5A;     
                      LDA.B #$0F                          ;;9A5D|9A5D/9A5D\9A5D; \ Time to bounce platform = 0F   
                      STA.W !SpriteMisc1564,X             ;;9A5F|9A5F/9A5F\9A5F; /   
                      LDA.B #$10                          ;;9A62|9A62/9A62\9A62; \ Set mario's y speed to rebound down off platform   
                      STA.B !PlayerYSpeed                 ;;9A64|9A64/9A64\9A64; /   
                      LDA.B #$01                          ;;9A66|9A66/9A66\9A66; \ 
                      STA.W !SPCIO0                       ;;9A68|9A68/9A68\9A68; / Play sound effect 
                      BRA DrawReznor                      ;;9A6B|9A6B/9A6B\9A6B;
                                                          ;;                   ;
HitPlatSide:          JSR SubHorzPosBnk3                  ;;9A6D|9A6D/9A6D\9A6D; \ Set mario to bounce back   
                      LDA.W ReboundSpeedX,Y               ;;9A70|9A70/9A70\9A70;  | (hit side of platform?)   
                      STA.B !PlayerXSpeed                 ;;9A73|9A73/9A73\9A73;  |   
                      BRA DrawReznor                      ;;9A75|9A75/9A75\9A75; /                                                            
                                                          ;;                   ;
HitReznor:            JSL HurtMario                       ;;9A77|9A77/9A77\9A77; Hurt Mario 
DrawReznor:           STZ.W !SpriteMisc1602,X             ;;9A7B|9A7B/9A7B\9A7B; Set normal image 
                      LDA.W !SpriteMisc157C,X             ;;9A7E|9A7E/9A7E\9A7E;
                      PHA                                 ;;9A81|9A81/9A81\9A81;
                      LDY.W !SpriteMisc15AC,X             ;;9A82|9A82/9A82\9A82;
                      BEQ ReznorNoTurning                 ;;9A85|9A85/9A85\9A85;
                      CPY.B #$05                          ;;9A87|9A87/9A87\9A87;
                      BCC +                               ;;9A89|9A89/9A89\9A89;
                      EOR.B #$01                          ;;9A8B|9A8B/9A8B\9A8B;
                      STA.W !SpriteMisc157C,X             ;;9A8D|9A8D/9A8D\9A8D;
                    + LDA.B #$02                          ;;9A90|9A90/9A90\9A90; \ Set turning image 
                      STA.W !SpriteMisc1602,X             ;;9A92|9A92/9A92\9A92; / 
ReznorNoTurning:      LDA.W !SpriteMisc1558,X             ;;9A95|9A95/9A95\9A95; \ Shoot fire if "time to show firing image" == 20        
                      BEQ ReznorNoFiring                  ;;9A98|9A98/9A98\9A98;  |        
                      CMP.B #$20                          ;;9A9A|9A9A/9A9A\9A9A;  | (shows image for 20 frames after the fireball is shot) 
                      BNE +                               ;;9A9C|9A9C/9A9C\9A9C;  |        
                      JSR ReznorFireRt                    ;;9A9E|9A9E/9A9E\9A9E; /        
                    + LDA.B #$01                          ;;9AA1|9AA1/9AA1\9AA1; \ Set firing image        
                      STA.W !SpriteMisc1602,X             ;;9AA3|9AA3/9AA3\9AA3; /        
ReznorNoFiring:       JSR ReznorGfxRt                     ;;9AA6|9AA6/9AA6\9AA6; Draw Reznor                                               
                      PLA                                 ;;9AA9|9AA9/9AA9\9AA9;
                      STA.W !SpriteMisc157C,X             ;;9AAA|9AAA/9AAA\9AAA;
                      LDA.B !SpriteLock                   ;;9AAD|9AAD/9AAD\9AAD; \ If sprites locked, or mario already killed the Reznor on the platform, return   
                      ORA.W !SpriteMisc151C,X             ;;9AAF|9AAF/9AAF\9AAF;  |   
                      BNE +                               ;;9AB2|9AB2/9AB2\9AB2; /   
                      LDA.W !SpriteMisc1564,X             ;;9AB4|9AB4/9AB4\9AB4; \ If time to bounce platform != 0C, return   
                      CMP.B #$0C                          ;;9AB7|9AB7/9AB7\9AB7;  | (causes delay between start of boucing platform and killing Reznor)   
                      BNE +                               ;;9AB9|9AB9/9AB9\9AB9; /   
                      LDA.B #$03                          ;;9ABB|9ABB/9ABB\9ABB; \ 
                      STA.W !SPCIO0                       ;;9ABD|9ABD/9ABD\9ABD; / Play sound effect 
                      STZ.W !SpriteMisc1558,X             ;;9AC0|9AC0/9AC0\9AC0; Prevent from throwing fire after death   
                      INC.W !SpriteMisc151C,X             ;;9AC3|9AC3/9AC3\9AC3; Record a hit on Reznor   
                      JSL FindFreeSprSlot                 ;;9AC6|9AC6/9AC6\9AC6; \ Load Y with a free sprite index for dead Reznor   
                      BMI +                               ;;9ACA|9ACA/9ACA\9ACA; / Return if no free index   
                      LDA.B #$02                          ;;9ACC|9ACC/9ACC\9ACC; \ Set status to being killed   
                      STA.W !SpriteStatus,Y               ;;9ACE|9ACE/9ACE\9ACE; /   
                      LDA.B #$A9                          ;;9AD1|9AD1/9AD1\9AD1; \ Sprite to use for dead Reznor   
                      STA.W !SpriteNumber,Y               ;;9AD3|9AD3/9AD3\9AD3; /   
                      LDA.B !SpriteXPosLow,X              ;;9AD6|9AD6/9AD6\9AD6; \ Transfer x position to dead Reznor   
                      STA.W !SpriteXPosLow,Y              ;;9AD8|9AD8/9AD8\9AD8;  |   
                      LDA.W !SpriteYPosHigh,X             ;;9ADB|9ADB/9ADB\9ADB;  |   
                      STA.W !SpriteYPosHigh,Y             ;;9ADE|9ADE/9ADE\9ADE; /   
                      LDA.B !SpriteYPosLow,X              ;;9AE1|9AE1/9AE1\9AE1; \ Transfer y position to dead Reznor   
                      STA.W !SpriteYPosLow,Y              ;;9AE3|9AE3/9AE3\9AE3;  |   
                      LDA.W !SpriteXPosHigh,X             ;;9AE6|9AE6/9AE6\9AE6;  |   
                      STA.W !SpriteXPosHigh,Y             ;;9AE9|9AE9/9AE9\9AE9; /   
                      PHX                                 ;;9AEC|9AEC/9AEC\9AEC; \    
                      TYX                                 ;;9AED|9AED/9AED\9AED;  | Before: X must have index of sprite being generated   
                      JSL InitSpriteTables                ;;9AEE|9AEE/9AEE\9AEE; /  Routine clears all old sprite values and loads in new values for the 6 main sprite tables 
                      LDA.B #$C0                          ;;9AF2|9AF2/9AF2\9AF2; \ Set y speed for Reznor's bounce off the platform   
                      STA.B !SpriteYSpeed,X               ;;9AF4|9AF4/9AF4\9AF4; /   
                      PLX                                 ;;9AF6|9AF6/9AF6\9AF6; pull, X = sprite index                                                                       
                    + RTS                                 ;;9AF7|9AF7/9AF7\9AF7; Return 
                                                          ;;                   ;
ReznorFireRt:         LDY.B #$07                          ;;9AF8|9AF8/9AF8\9AF8; \ find a free extended sprite slot, return if all full 
CODE_039AFA:          LDA.W !ExtSpriteNumber,Y            ;;9AFA|9AFA/9AFA\9AFA;  | 
                      BEQ FoundRznrFireSlot               ;;9AFD|9AFD/9AFD\9AFD;  | 
                      DEY                                 ;;9AFF|9AFF/9AFF\9AFF;  | 
                      BPL CODE_039AFA                     ;;9B00|9B00/9B00\9B00;  | 
                      RTS                                 ;;9B02|9B02/9B02\9B02; / Return if no free slots 
                                                          ;;                   ;
FoundRznrFireSlot:    LDA.B #$10                          ;;9B03|9B03/9B03\9B03; \ 
                      STA.W !SPCIO0                       ;;9B05|9B05/9B05\9B05; / Play sound effect 
                      LDA.B #$02                          ;;9B08|9B08/9B08\9B08; \ Extended sprite = Reznor fireball 
                      STA.W !ExtSpriteNumber,Y            ;;9B0A|9B0A/9B0A\9B0A; / 
                      LDA.B !SpriteXPosLow,X              ;;9B0D|9B0D/9B0D\9B0D;
                      PHA                                 ;;9B0F|9B0F/9B0F\9B0F;
                      SEC                                 ;;9B10|9B10/9B10\9B10;
                      SBC.B #$08                          ;;9B11|9B11/9B11\9B11;
                      STA.W !ExtSpriteXPosLow,Y           ;;9B13|9B13/9B13\9B13;
                      STA.B !SpriteXPosLow,X              ;;9B16|9B16/9B16\9B16;
                      LDA.W !SpriteYPosHigh,X             ;;9B18|9B18/9B18\9B18;
                      SBC.B #$00                          ;;9B1B|9B1B/9B1B\9B1B;
                      STA.W !ExtSpriteXPosHigh,Y          ;;9B1D|9B1D/9B1D\9B1D;
                      LDA.B !SpriteYPosLow,X              ;;9B20|9B20/9B20\9B20;
                      PHA                                 ;;9B22|9B22/9B22\9B22;
                      SEC                                 ;;9B23|9B23/9B23\9B23;
                      SBC.B #$14                          ;;9B24|9B24/9B24\9B24;
                      STA.B !SpriteYPosLow,X              ;;9B26|9B26/9B26\9B26;
                      STA.W !ExtSpriteYPosLow,Y           ;;9B28|9B28/9B28\9B28;
                      LDA.W !SpriteXPosHigh,X             ;;9B2B|9B2B/9B2B\9B2B;
                      PHA                                 ;;9B2E|9B2E/9B2E\9B2E;
                      SBC.B #$00                          ;;9B2F|9B2F/9B2F\9B2F;
                      STA.W !ExtSpriteYPosHigh,Y          ;;9B31|9B31/9B31\9B31;
                      STA.W !SpriteXPosHigh,X             ;;9B34|9B34/9B34\9B34;
                      LDA.B #$10                          ;;9B37|9B37/9B37\9B37;
                      JSR CODE_0397F9                     ;;9B39|9B39/9B39\9B39;
                      PLA                                 ;;9B3C|9B3C/9B3C\9B3C;
                      STA.W !SpriteXPosHigh,X             ;;9B3D|9B3D/9B3D\9B3D;
                      PLA                                 ;;9B40|9B40/9B40\9B40;
                      STA.B !SpriteYPosLow,X              ;;9B41|9B41/9B41\9B41;
                      PLA                                 ;;9B43|9B43/9B43\9B43;
                      STA.B !SpriteXPosLow,X              ;;9B44|9B44/9B44\9B44;
                      LDA.B !_0                           ;;9B46|9B46/9B46\9B46;
                      STA.W !ExtSpriteYSpeed,Y            ;;9B48|9B48/9B48\9B48;
                      LDA.B !_1                           ;;9B4B|9B4B/9B4B\9B4B;
                      STA.W !ExtSpriteXSpeed,Y            ;;9B4D|9B4D/9B4D\9B4D;
                      RTS                                 ;;9B50|9B50/9B50\9B50; Return 
                                                          ;;                   ;
                                                          ;;                   ;
ReznorTileDispX:      db $00,$F0,$00,$F0,$F0,$00,$F0,$00  ;;9B51|9B51/9B51\9B51;
ReznorTileDispY:      db $E0,$E0,$F0,$F0                  ;;9B59|9B59/9B59\9B59;
                                                          ;;                   ;
ReznorTiles:          db $40,$42,$60,$62,$44,$46,$64,$66  ;;9B5D|9B5D/9B5D\9B5D;
                      db $28,$28,$48,$48                  ;;9B65|9B65/9B65\9B65;
                                                          ;;                   ;
ReznorPal:            db $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F  ;;9B69|9B69/9B69\9B69;
                      db $7F,$3F,$7F,$3F                  ;;9B71|9B71/9B71\9B71;
                                                          ;;                   ;
ReznorGfxRt:          LDA.W !SpriteMisc151C,X             ;;9B75|9B75/9B75\9B75; \ if the reznor is dead, only draw the platform  
                      BNE DrawReznorPlats                 ;;9B78|9B78/9B78\9B78; /  
                      JSR GetDrawInfoBnk3                 ;;9B7A|9B7A/9B7A\9B7A; after: Y = index to sprite tile map, $00 = sprite x, $01 = sprite y 
                      LDA.W !SpriteMisc1602,X             ;;9B7D|9B7D/9B7D\9B7D; \ $03 = index to frame start (frame to show * 4 tiles per frame)  
                      ASL A                               ;;9B80|9B80/9B80\9B80;  |   
                      ASL A                               ;;9B81|9B81/9B81\9B81;  |  
                      STA.B !_3                           ;;9B82|9B82/9B82\9B82; /  
                      LDA.W !SpriteMisc157C,X             ;;9B84|9B84/9B84\9B84; \ $02 = direction index  
                      ASL A                               ;;9B87|9B87/9B87\9B87;  |  
                      ASL A                               ;;9B88|9B88/9B88\9B88;  |  
                      STA.B !_2                           ;;9B89|9B89/9B89\9B89; /                                                                   
                      PHX                                 ;;9B8B|9B8B/9B8B\9B8B;
                      LDX.B #$03                          ;;9B8C|9B8C/9B8C\9B8C;
RznrGfxLoopStart:     PHX                                 ;;9B8E|9B8E/9B8E\9B8E;
                      LDA.B !_3                           ;;9B8F|9B8F/9B8F\9B8F;
                      CMP.B #$08                          ;;9B91|9B91/9B91\9B91;
                      BCS +                               ;;9B93|9B93/9B93\9B93;
                      TXA                                 ;;9B95|9B95/9B95\9B95;
                      ORA.B !_2                           ;;9B96|9B96/9B96\9B96;
                      TAX                                 ;;9B98|9B98/9B98\9B98;
                    + LDA.B !_0                           ;;9B99|9B99/9B99\9B99;
                      CLC                                 ;;9B9B|9B9B/9B9B\9B9B;
                      ADC.W ReznorTileDispX,X             ;;9B9C|9B9C/9B9C\9B9C;
                      STA.W !OAMTileXPos+$100,Y           ;;9B9F|9B9F/9B9F\9B9F;
                      PLX                                 ;;9BA2|9BA2/9BA2\9BA2;
                      LDA.B !_1                           ;;9BA3|9BA3/9BA3\9BA3;
                      CLC                                 ;;9BA5|9BA5/9BA5\9BA5;
                      ADC.W ReznorTileDispY,X             ;;9BA6|9BA6/9BA6\9BA6;
                      STA.W !OAMTileYPos+$100,Y           ;;9BA9|9BA9/9BA9\9BA9;
                      PHX                                 ;;9BAC|9BAC/9BAC\9BAC;
                      TXA                                 ;;9BAD|9BAD/9BAD\9BAD;
                      ORA.B !_3                           ;;9BAE|9BAE/9BAE\9BAE;
                      TAX                                 ;;9BB0|9BB0/9BB0\9BB0;
                      LDA.W ReznorTiles,X                 ;;9BB1|9BB1/9BB1\9BB1; \ set tile  
                      STA.W !OAMTileNo+$100,Y             ;;9BB4|9BB4/9BB4\9BB4; /  
                      LDA.W ReznorPal,X                   ;;9BB7|9BB7/9BB7\9BB7; \ set palette/properties  
                      CPX.B #$08                          ;;9BBA|9BBA/9BBA\9BBA;  | if turning, don't flip  
                      BCS +                               ;;9BBC|9BBC/9BBC\9BBC;  |   
                      LDX.B !_2                           ;;9BBE|9BBE/9BBE\9BBE;  | if direction = 0, don't flip  
                      BNE +                               ;;9BC0|9BC0/9BC0\9BC0;  |  
                      EOR.B #$40                          ;;9BC2|9BC2/9BC2\9BC2;  |  
                    + STA.W !OAMTileAttr+$100,Y           ;;9BC4|9BC4/9BC4\9BC4; /  
                      PLX                                 ;;9BC7|9BC7/9BC7\9BC7; \ pull, X = current tile of the frame we're drawing 
                      INY                                 ;;9BC8|9BC8/9BC8\9BC8;  | Increase index to sprite tile map ($300)...  
                      INY                                 ;;9BC9|9BC9/9BC9\9BC9;  |    ...we wrote 4 bytes...  
                      INY                                 ;;9BCA|9BCA/9BCA\9BCA;  |    ...so increment 4 times  
                      INY                                 ;;9BCB|9BCB/9BCB\9BCB;  |      
                      DEX                                 ;;9BCC|9BCC/9BCC\9BCC;  | Go to next tile of frame and loop  
                      BPL RznrGfxLoopStart                ;;9BCD|9BCD/9BCD\9BCD; /   
                      PLX                                 ;;9BCF|9BCF/9BCF\9BCF; \  
                      LDY.B #$02                          ;;9BD0|9BD0/9BD0\9BD0;  | Y = 02 (All 16x16 tiles)  
                      LDA.B #$03                          ;;9BD2|9BD2/9BD2\9BD2;  | A = number of tiles drawn - 1  
                      JSL FinishOAMWrite                  ;;9BD4|9BD4/9BD4\9BD4; / Don't draw if offscreen                           
                      LDA.W !SpriteStatus,X               ;;9BD8|9BD8/9BD8\9BD8;
                      CMP.B #$02                          ;;9BDB|9BDB/9BDB\9BDB;
                      BEQ +                               ;;9BDD|9BDD/9BDD\9BDD;
DrawReznorPlats:      JSR ReznorPlatGfxRt                 ;;9BDF|9BDF/9BDF\9BDF;
                    + RTS                                 ;;9BE2|9BE2/9BE2\9BE2; Return 
                                                          ;;                   ;
                                                          ;;                   ;
ReznorPlatDispY:      db $00,$03,$04,$05,$05,$04,$03,$00  ;;9BE3|9BE3/9BE3\9BE3;
                                                          ;;                   ;
ReznorPlatGfxRt:      LDA.W !SpriteOAMIndex,X             ;;9BEB|9BEB/9BEB\9BEB;
                      CLC                                 ;;9BEE|9BEE/9BEE\9BEE;
                      ADC.B #$10                          ;;9BEF|9BEF/9BEF\9BEF;
                      STA.W !SpriteOAMIndex,X             ;;9BF1|9BF1/9BF1\9BF1;
                      JSR GetDrawInfoBnk3                 ;;9BF4|9BF4/9BF4\9BF4;
                      LDA.W !SpriteMisc1564,X             ;;9BF7|9BF7/9BF7\9BF7;
                      LSR A                               ;;9BFA|9BFA/9BFA\9BFA;
                      PHY                                 ;;9BFB|9BFB/9BFB\9BFB;
                      TAY                                 ;;9BFC|9BFC/9BFC\9BFC;
                      LDA.W ReznorPlatDispY,Y             ;;9BFD|9BFD/9BFD\9BFD;
                      STA.B !_2                           ;;9C00|9C00/9C00\9C00;
                      PLY                                 ;;9C02|9C02/9C02\9C02;
                      LDA.B !_0                           ;;9C03|9C03/9C03\9C03;
                      STA.W !OAMTileXPos+$104,Y           ;;9C05|9C05/9C05\9C05;
                      SEC                                 ;;9C08|9C08/9C08\9C08;
                      SBC.B #$10                          ;;9C09|9C09/9C09\9C09;
                      STA.W !OAMTileXPos+$100,Y           ;;9C0B|9C0B/9C0B\9C0B;
                      LDA.B !_1                           ;;9C0E|9C0E/9C0E\9C0E;
                      SEC                                 ;;9C10|9C10/9C10\9C10;
                      SBC.B !_2                           ;;9C11|9C11/9C11\9C11;
                      STA.W !OAMTileYPos+$100,Y           ;;9C13|9C13/9C13\9C13;
                      STA.W !OAMTileYPos+$104,Y           ;;9C16|9C16/9C16\9C16;
                      LDA.B #$4E                          ;;9C19|9C19/9C19\9C19; \ Tile of reznor platform...     
                      STA.W !OAMTileNo+$100,Y             ;;9C1B|9C1B/9C1B\9C1B;  | ...store left side       
                      STA.W !OAMTileNo+$104,Y             ;;9C1E|9C1E/9C1E\9C1E; /  ...store right side       
                      LDA.B #$33                          ;;9C21|9C21/9C21\9C21; \ Palette of reznor platform...  
                      STA.W !OAMTileAttr+$100,Y           ;;9C23|9C23/9C23\9C23;  |       
                      ORA.B #$40                          ;;9C26|9C26/9C26\9C26;  | ...flip right side       
                      STA.W !OAMTileAttr+$104,Y           ;;9C28|9C28/9C28\9C28; /       
                      LDY.B #$02                          ;;9C2B|9C2B/9C2B\9C2B; \       
                      LDA.B #$01                          ;;9C2D|9C2D/9C2D\9C2D;  | A = number of tiles drawn - 1 
                      JSL FinishOAMWrite                  ;;9C2F|9C2F/9C2F\9C2F; / Don't draw if offscreen        
                      RTS                                 ;;9C33|9C33/9C33\9C33; Return 
                                                          ;;                   ;
InvisBlk_DinosMain:   LDA.B !SpriteNumber,X               ;;9C34|9C34/9C34\9C34; \ Branch if sprite isn't "Invisible solid block" 
                      CMP.B #$6D                          ;;9C36|9C36/9C36\9C36;  | 
                      BNE +                               ;;9C38|9C38/9C38\9C38; / 
                      JSL InvisBlkMainRt                  ;;9C3A|9C3A/9C3A\9C3A; \ Call "Invisible solid block" routine 
                      RTL                                 ;;9C3E|9C3E/9C3E\9C3E; Return 
                                                          ;;                   ;
                    + PHB                                 ;;9C3F|9C3F/9C3F\9C3F;
                      PHK                                 ;;9C40|9C40/9C40\9C40;
                      PLB                                 ;;9C41|9C41/9C41\9C41;
                      JSR DinoMainSubRt                   ;;9C42|9C42/9C42\9C42;
                      PLB                                 ;;9C45|9C45/9C45\9C45;
                      RTL                                 ;;9C46|9C46/9C46\9C46; Return 
                                                          ;;                   ;
DinoMainSubRt:        JSR DinoGfxRt                       ;;9C47|9C47/9C47\9C47;
                      LDA.B !SpriteLock                   ;;9C4A|9C4A/9C4A\9C4A;
                      BNE Return039CA3                    ;;9C4C|9C4C/9C4C\9C4C;
                      LDA.W !SpriteStatus,X               ;;9C4E|9C4E/9C4E\9C4E;
                      CMP.B #$08                          ;;9C51|9C51/9C51\9C51;
                      BNE Return039CA3                    ;;9C53|9C53/9C53\9C53;
                      JSR SubOffscreen0Bnk3               ;;9C55|9C55/9C55\9C55;
                      JSL MarioSprInteract                ;;9C58|9C58/9C58\9C58;
                      JSL UpdateSpritePos                 ;;9C5C|9C5C/9C5C\9C5C;
                      LDA.B !SpriteTableC2,X              ;;9C60|9C60/9C60\9C60;
                      JSL ExecutePtr                      ;;9C62|9C62/9C62\9C62;
                                                          ;;                   ;
                      dw CODE_039CA8                      ;;9C66|9C66/9C66\9C66;
                      dw CODE_039D41                      ;;9C68|9C68/9C68\9C68;
                      dw CODE_039D41                      ;;9C6A|9C6A/9C6A\9C6A;
                      dw CODE_039C74                      ;;9C6C|9C6C/9C6C\9C6C;
                                                          ;;                   ;
DATA_039C6E:          db $00,$FE,$02                      ;;9C6E|9C6E/9C6E\9C6E;
                                                          ;;                   ;
DATA_039C71:          db $00,$FF,$00                      ;;9C71|9C71/9C71\9C71;
                                                          ;;                   ;
CODE_039C74:          LDA.B !SpriteYSpeed,X               ;;9C74|9C74/9C74\9C74;
                      BMI CODE_039C89                     ;;9C76|9C76/9C76\9C76;
                      STZ.B !SpriteTableC2,X              ;;9C78|9C78/9C78\9C78;
                      LDA.W !SpriteBlockedDirs,X          ;;9C7A|9C7A/9C7A\9C7A; \ Branch if not touching object 
                      AND.B #$03                          ;;9C7D|9C7D/9C7D\9C7D;  | 
                      BEQ CODE_039C89                     ;;9C7F|9C7F/9C7F\9C7F; / 
                      LDA.W !SpriteMisc157C,X             ;;9C81|9C81/9C81\9C81;
                      EOR.B #$01                          ;;9C84|9C84/9C84\9C84;
                      STA.W !SpriteMisc157C,X             ;;9C86|9C86/9C86\9C86;
CODE_039C89:          STZ.W !SpriteMisc1602,X             ;;9C89|9C89/9C89\9C89;
                      LDA.W !SpriteBlockedDirs,X          ;;9C8C|9C8C/9C8C\9C8C;
                      AND.B #$03                          ;;9C8F|9C8F/9C8F\9C8F;
                      TAY                                 ;;9C91|9C91/9C91\9C91;
                      LDA.B !SpriteXPosLow,X              ;;9C92|9C92/9C92\9C92;
                      CLC                                 ;;9C94|9C94/9C94\9C94;
                      ADC.W DATA_039C6E,Y                 ;;9C95|9C95/9C95\9C95;
                      STA.B !SpriteXPosLow,X              ;;9C98|9C98/9C98\9C98;
                      LDA.W !SpriteYPosHigh,X             ;;9C9A|9C9A/9C9A\9C9A;
                      ADC.W DATA_039C71,Y                 ;;9C9D|9C9D/9C9D\9C9D;
                      STA.W !SpriteYPosHigh,X             ;;9CA0|9CA0/9CA0\9CA0;
Return039CA3:         RTS                                 ;;9CA3|9CA3/9CA3\9CA3; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DinoSpeed:            db $08,$F8,$10,$F0                  ;;9CA4|9CA4/9CA4\9CA4;
                                                          ;;                   ;
CODE_039CA8:          LDA.W !SpriteBlockedDirs,X          ;;9CA8|9CA8/9CA8\9CA8; \ Branch if not on ground 
                      AND.B #$04                          ;;9CAB|9CAB/9CAB\9CAB;  | 
                      BEQ CODE_039C89                     ;;9CAD|9CAD/9CAD\9CAD; / 
                      LDA.W !SpriteMisc1540,X             ;;9CAF|9CAF/9CAF\9CAF;
                      BNE +                               ;;9CB2|9CB2/9CB2\9CB2;
                      LDA.B !SpriteNumber,X               ;;9CB4|9CB4/9CB4\9CB4;
                      CMP.B #$6E                          ;;9CB6|9CB6/9CB6\9CB6;
                      BEQ +                               ;;9CB8|9CB8/9CB8\9CB8;
                      LDA.B #$FF                          ;;9CBA|9CBA/9CBA\9CBA; \ Set fire breathing timer 
                      STA.W !SpriteMisc1540,X             ;;9CBC|9CBC/9CBC\9CBC; / 
                      JSL GetRand                         ;;9CBF|9CBF/9CBF\9CBF;
                      AND.B #$01                          ;;9CC3|9CC3/9CC3\9CC3;
                      INC A                               ;;9CC5|9CC5/9CC5\9CC5;
                      STA.B !SpriteTableC2,X              ;;9CC6|9CC6/9CC6\9CC6;
                    + TXA                                 ;;9CC8|9CC8/9CC8\9CC8;
                      ASL A                               ;;9CC9|9CC9/9CC9\9CC9;
                      ASL A                               ;;9CCA|9CCA/9CCA\9CCA;
                      ASL A                               ;;9CCB|9CCB/9CCB\9CCB;
                      ASL A                               ;;9CCC|9CCC/9CCC\9CCC;
                      ADC.B !EffFrame                     ;;9CCD|9CCD/9CCD\9CCD;
                      AND.B #$3F                          ;;9CCF|9CCF/9CCF\9CCF;
                      BNE +                               ;;9CD1|9CD1/9CD1\9CD1;
                      JSR SubHorzPosBnk3                  ;;9CD3|9CD3/9CD3\9CD3; \ If not facing mario, change directions 
                      TYA                                 ;;9CD6|9CD6/9CD6\9CD6;  | 
                      STA.W !SpriteMisc157C,X             ;;9CD7|9CD7/9CD7\9CD7; / 
                    + LDA.B #$10                          ;;9CDA|9CDA/9CDA\9CDA;
                      STA.B !SpriteYSpeed,X               ;;9CDC|9CDC/9CDC\9CDC;
                      LDY.W !SpriteMisc157C,X             ;;9CDE|9CDE/9CDE\9CDE; \ Set x speed for rhino based on direction and sprite number 
                      LDA.B !SpriteNumber,X               ;;9CE1|9CE1/9CE1\9CE1;  | 
                      CMP.B #$6E                          ;;9CE3|9CE3/9CE3\9CE3;  | 
                      BEQ +                               ;;9CE5|9CE5/9CE5\9CE5;  | 
                      INY                                 ;;9CE7|9CE7/9CE7\9CE7;  | 
                      INY                                 ;;9CE8|9CE8/9CE8\9CE8;  | 
                    + LDA.W DinoSpeed,Y                   ;;9CE9|9CE9/9CE9\9CE9;  | 
                      STA.B !SpriteXSpeed,X               ;;9CEC|9CEC/9CEC\9CEC; / 
                      JSR DinoSetGfxFrame                 ;;9CEE|9CEE/9CEE\9CEE;
                      LDA.W !SpriteBlockedDirs,X          ;;9CF1|9CF1/9CF1\9CF1; \ Branch if not touching object 
                      AND.B #$03                          ;;9CF4|9CF4/9CF4\9CF4;  | 
                      BEQ +                               ;;9CF6|9CF6/9CF6\9CF6; / 
                      LDA.B #$C0                          ;;9CF8|9CF8/9CF8\9CF8;
                      STA.B !SpriteYSpeed,X               ;;9CFA|9CFA/9CFA\9CFA;
                      LDA.B #$03                          ;;9CFC|9CFC/9CFC\9CFC;
                      STA.B !SpriteTableC2,X              ;;9CFE|9CFE/9CFE\9CFE;
                    + RTS                                 ;;9D00|9D00/9D00\9D00; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DinoFlameTable:       db $41,$42,$42,$32,$22,$12,$02,$02  ;;9D01|9D01/9D01\9D01;
                      db $02,$02,$02,$02,$02,$02,$02,$02  ;;9D09|9D09/9D09\9D09;
                      db $02,$02,$02,$02,$02,$02,$02,$12  ;;9D11|9D11/9D11\9D11;
                      db $22,$32,$42,$42,$42,$42,$41,$41  ;;9D19|9D19/9D19\9D19;
                      db $41,$43,$43,$33,$23,$13,$03,$03  ;;9D21|9D21/9D21\9D21;
                      db $03,$03,$03,$03,$03,$03,$03,$03  ;;9D29|9D29/9D29\9D29;
                      db $03,$03,$03,$03,$03,$03,$03,$13  ;;9D31|9D31/9D31\9D31;
                      db $23,$33,$43,$43,$43,$43,$41,$41  ;;9D39|9D39/9D39\9D39;
                                                          ;;                   ;
CODE_039D41:          STZ.B !SpriteXSpeed,X               ;;9D41|9D41/9D41\9D41; Sprite X Speed = 0 
                      LDA.W !SpriteMisc1540,X             ;;9D43|9D43/9D43\9D43;
                      BNE +                               ;;9D46|9D46/9D46\9D46;
                      STZ.B !SpriteTableC2,X              ;;9D48|9D48/9D48\9D48;
                      LDA.B #$40                          ;;9D4A|9D4A/9D4A\9D4A;
                      STA.W !SpriteMisc1540,X             ;;9D4C|9D4C/9D4C\9D4C;
                      LDA.B #$00                          ;;9D4F|9D4F/9D4F\9D4F;
                    + CMP.B #$C0                          ;;9D51|9D51/9D51\9D51;
                      BNE +                               ;;9D53|9D53/9D53\9D53;
                      LDY.B #$17                          ;;9D55|9D55/9D55\9D55; \ Play sound effect 
                      STY.W !SPCIO3                       ;;9D57|9D57/9D57\9D57; / 
                    + LSR A                               ;;9D5A|9D5A/9D5A\9D5A;
                      LSR A                               ;;9D5B|9D5B/9D5B\9D5B;
                      LSR A                               ;;9D5C|9D5C/9D5C\9D5C;
                      LDY.B !SpriteTableC2,X              ;;9D5D|9D5D/9D5D\9D5D;
                      CPY.B #$02                          ;;9D5F|9D5F/9D5F\9D5F;
                      BNE +                               ;;9D61|9D61/9D61\9D61;
                      CLC                                 ;;9D63|9D63/9D63\9D63;
                      ADC.B #$20                          ;;9D64|9D64/9D64\9D64;
                    + TAY                                 ;;9D66|9D66/9D66\9D66;
                      LDA.W DinoFlameTable,Y              ;;9D67|9D67/9D67\9D67;
                      PHA                                 ;;9D6A|9D6A/9D6A\9D6A;
                      AND.B #$0F                          ;;9D6B|9D6B/9D6B\9D6B;
                      STA.W !SpriteMisc1602,X             ;;9D6D|9D6D/9D6D\9D6D;
                      PLA                                 ;;9D70|9D70/9D70\9D70;
                      LSR A                               ;;9D71|9D71/9D71\9D71;
                      LSR A                               ;;9D72|9D72/9D72\9D72;
                      LSR A                               ;;9D73|9D73/9D73\9D73;
                      LSR A                               ;;9D74|9D74/9D74\9D74;
                      STA.W !SpriteMisc151C,X             ;;9D75|9D75/9D75\9D75;
                      BNE +                               ;;9D78|9D78/9D78\9D78;
                      LDA.B !SpriteNumber,X               ;;9D7A|9D7A/9D7A\9D7A;
                      CMP.B #$6E                          ;;9D7C|9D7C/9D7C\9D7C;
                      BEQ +                               ;;9D7E|9D7E/9D7E\9D7E;
                      TXA                                 ;;9D80|9D80/9D80\9D80;
                      EOR.B !TrueFrame                    ;;9D81|9D81/9D81\9D81;
                      AND.B #$03                          ;;9D83|9D83/9D83\9D83;
                      BNE +                               ;;9D85|9D85/9D85\9D85;
                      JSR DinoFlameClipping               ;;9D87|9D87/9D87\9D87;
                      JSL GetMarioClipping                ;;9D8A|9D8A/9D8A\9D8A;
                      JSL CheckForContact                 ;;9D8E|9D8E/9D8E\9D8E;
                      BCC +                               ;;9D92|9D92/9D92\9D92;
                      LDA.W !InvinsibilityTimer           ;;9D94|9D94/9D94\9D94; \ Branch if Mario has star 
                      BNE +                               ;;9D97|9D97/9D97\9D97; / 
                      JSL HurtMario                       ;;9D99|9D99/9D99\9D99;
                    + RTS                                 ;;9D9D|9D9D/9D9D\9D9D; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DinoFlame1:           db $DC,$02,$10,$02                  ;;9D9E|9D9E/9D9E\9D9E;
                                                          ;;                   ;
DinoFlame2:           db $FF,$00,$00,$00                  ;;9DA2|9DA2/9DA2\9DA2;
                                                          ;;                   ;
DinoFlame3:           db $24,$0C,$24,$0C                  ;;9DA6|9DA6/9DA6\9DA6;
                                                          ;;                   ;
DinoFlame4:           db $02,$DC,$02,$DC                  ;;9DAA|9DAA/9DAA\9DAA;
                                                          ;;                   ;
DinoFlame5:           db $00,$FF,$00,$FF                  ;;9DAE|9DAE/9DAE\9DAE;
                                                          ;;                   ;
DinoFlame6:           db $0C,$24,$0C,$24                  ;;9DB2|9DB2/9DB2\9DB2;
                                                          ;;                   ;
DinoFlameClipping:    LDA.W !SpriteMisc1602,X             ;;9DB6|9DB6/9DB6\9DB6;
                      SEC                                 ;;9DB9|9DB9/9DB9\9DB9;
                      SBC.B #$02                          ;;9DBA|9DBA/9DBA\9DBA;
                      TAY                                 ;;9DBC|9DBC/9DBC\9DBC;
                      LDA.W !SpriteMisc157C,X             ;;9DBD|9DBD/9DBD\9DBD;
                      BNE +                               ;;9DC0|9DC0/9DC0\9DC0;
                      INY                                 ;;9DC2|9DC2/9DC2\9DC2;
                      INY                                 ;;9DC3|9DC3/9DC3\9DC3;
                    + LDA.B !SpriteXPosLow,X              ;;9DC4|9DC4/9DC4\9DC4;
                      CLC                                 ;;9DC6|9DC6/9DC6\9DC6;
                      ADC.W DinoFlame1,Y                  ;;9DC7|9DC7/9DC7\9DC7;
                      STA.B !_4                           ;;9DCA|9DCA/9DCA\9DCA;
                      LDA.W !SpriteYPosHigh,X             ;;9DCC|9DCC/9DCC\9DCC;
                      ADC.W DinoFlame2,Y                  ;;9DCF|9DCF/9DCF\9DCF;
                      STA.B !_A                           ;;9DD2|9DD2/9DD2\9DD2;
                      LDA.W DinoFlame3,Y                  ;;9DD4|9DD4/9DD4\9DD4;
                      STA.B !_6                           ;;9DD7|9DD7/9DD7\9DD7;
                      LDA.B !SpriteYPosLow,X              ;;9DD9|9DD9/9DD9\9DD9;
                      CLC                                 ;;9DDB|9DDB/9DDB\9DDB;
                      ADC.W DinoFlame4,Y                  ;;9DDC|9DDC/9DDC\9DDC;
                      STA.B !_5                           ;;9DDF|9DDF/9DDF\9DDF;
                      LDA.W !SpriteXPosHigh,X             ;;9DE1|9DE1/9DE1\9DE1;
                      ADC.W DinoFlame5,Y                  ;;9DE4|9DE4/9DE4\9DE4;
                      STA.B !_B                           ;;9DE7|9DE7/9DE7\9DE7;
                      LDA.W DinoFlame6,Y                  ;;9DE9|9DE9/9DE9\9DE9;
                      STA.B !_7                           ;;9DEC|9DEC/9DEC\9DEC;
                      RTS                                 ;;9DEE|9DEE/9DEE\9DEE; Return 
                                                          ;;                   ;
DinoSetGfxFrame:      INC.W !SpriteMisc1570,X             ;;9DEF|9DEF/9DEF\9DEF;
                      LDA.W !SpriteMisc1570,X             ;;9DF2|9DF2/9DF2\9DF2;
                      AND.B #$08                          ;;9DF5|9DF5/9DF5\9DF5;
                      LSR A                               ;;9DF7|9DF7/9DF7\9DF7;
                      LSR A                               ;;9DF8|9DF8/9DF8\9DF8;
                      LSR A                               ;;9DF9|9DF9/9DF9\9DF9;
                      STA.W !SpriteMisc1602,X             ;;9DFA|9DFA/9DFA\9DFA;
                      RTS                                 ;;9DFD|9DFD/9DFD\9DFD; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DinoTorchTileDispX:   db $D8,$E0,$EC,$F8,$00,$FF,$FF,$FF  ;;9DFE|9DFE/9DFE\9DFE;
                      db $FF,$00                          ;;9E06|9E06/9E06\9E06;
                                                          ;;                   ;
DinoTorchTileDispY:   db $00,$00,$00,$00,$00,$D8,$E0,$EC  ;;9E08|9E08/9E08\9E08;
                      db $F8,$00                          ;;9E10|9E10/9E10\9E10;
                                                          ;;                   ;
DinoFlameTiles:       db $80,$82,$84,$86,$00,$88,$8A,$8C  ;;9E12|9E12/9E12\9E12;
                      db $8E,$00                          ;;9E1A|9E1A/9E1A\9E1A;
                                                          ;;                   ;
DinoTorchGfxProp:     db $09,$05,$05,$05,$0F              ;;9E1C|9E1C/9E1C\9E1C;
                                                          ;;                   ;
DinoTorchTiles:       db $EA,$AA,$C4,$C6                  ;;9E21|9E21/9E21\9E21;
                                                          ;;                   ;
DinoRhinoTileDispX:   db $F8,$08,$F8,$08,$08,$F8,$08,$F8  ;;9E25|9E25/9E25\9E25;
DinoRhinoGfxProp:     db $2F,$2F,$2F,$2F,$6F,$6F,$6F,$6F  ;;9E2D|9E2D/9E2D\9E2D;
DinoRhinoTileDispY:   db $F0,$F0,$00,$00                  ;;9E35|9E35/9E35\9E35;
                                                          ;;                   ;
DinoRhinoTiles:       db $C0,$C2,$E4,$E6,$C0,$C2,$E0,$E2  ;;9E39|9E39/9E39\9E39;
                      db $C8,$CA,$E8,$E2,$CC,$CE,$EC,$EE  ;;9E41|9E41/9E41\9E41;
                                                          ;;                   ;
DinoGfxRt:            JSR GetDrawInfoBnk3                 ;;9E49|9E49/9E49\9E49;
                      LDA.W !SpriteMisc157C,X             ;;9E4C|9E4C/9E4C\9E4C;
                      STA.B !_2                           ;;9E4F|9E4F/9E4F\9E4F;
                      LDA.W !SpriteMisc1602,X             ;;9E51|9E51/9E51\9E51;
                      STA.B !_4                           ;;9E54|9E54/9E54\9E54;
                      LDA.B !SpriteNumber,X               ;;9E56|9E56/9E56\9E56;
                      CMP.B #$6F                          ;;9E58|9E58/9E58\9E58;
                      BEQ CODE_039EA9                     ;;9E5A|9E5A/9E5A\9E5A;
                      PHX                                 ;;9E5C|9E5C/9E5C\9E5C;
                      LDX.B #$03                          ;;9E5D|9E5D/9E5D\9E5D;
CODE_039E5F:          STX.B !_F                           ;;9E5F|9E5F/9E5F\9E5F;
                      LDA.B !_2                           ;;9E61|9E61/9E61\9E61;
                      CMP.B #$01                          ;;9E63|9E63/9E63\9E63;
                      BCS +                               ;;9E65|9E65/9E65\9E65;
                      TXA                                 ;;9E67|9E67/9E67\9E67;
                      CLC                                 ;;9E68|9E68/9E68\9E68;
                      ADC.B #$04                          ;;9E69|9E69/9E69\9E69;
                      TAX                                 ;;9E6B|9E6B/9E6B\9E6B;
                    + %LorW_X(LDA,DinoRhinoGfxProp)       ;;9E6C|9E6C/9E6C\9E6C;
                      STA.W !OAMTileAttr+$100,Y           ;;9E70|9E6F/9E6F\9E6F;
                      %LorW_X(LDA,DinoRhinoTileDispX)     ;;9E73|9E72/9E72\9E72;
                      CLC                                 ;;9E77|9E75/9E75\9E75;
                      ADC.B !_0                           ;;9E78|9E76/9E76\9E76;
                      STA.W !OAMTileXPos+$100,Y           ;;9E7A|9E78/9E78\9E78;
                      LDA.B !_4                           ;;9E7D|9E7B/9E7B\9E7B;
                      CMP.B #$01                          ;;9E7F|9E7D/9E7D\9E7D;
                      LDX.B !_F                           ;;9E81|9E7F/9E7F\9E7F;
                      %LorW_X(LDA,DinoRhinoTileDispY)     ;;9E83|9E81/9E81\9E81;
                      ADC.B !_1                           ;;9E87|9E84/9E84\9E84;
                      STA.W !OAMTileYPos+$100,Y           ;;9E89|9E86/9E86\9E86;
                      LDA.B !_4                           ;;9E8C|9E89/9E89\9E89;
                      ASL A                               ;;9E8E|9E8B/9E8B\9E8B;
                      ASL A                               ;;9E8F|9E8C/9E8C\9E8C;
                      ADC.B !_F                           ;;9E90|9E8D/9E8D\9E8D;
                      TAX                                 ;;9E92|9E8F/9E8F\9E8F;
                      %LorW_X(LDA,DinoRhinoTiles)         ;;9E93|9E90/9E90\9E90;
                      STA.W !OAMTileNo+$100,Y             ;;9E97|9E93/9E93\9E93;
                      INY                                 ;;9E9A|9E96/9E96\9E96;
                      INY                                 ;;9E9B|9E97/9E97\9E97;
                      INY                                 ;;9E9C|9E98/9E98\9E98;
                      INY                                 ;;9E9D|9E99/9E99\9E99;
                      LDX.B !_F                           ;;9E9E|9E9A/9E9A\9E9A;
                      DEX                                 ;;9EA0|9E9C/9E9C\9E9C;
                      BPL CODE_039E5F                     ;;9EA1|9E9D/9E9D\9E9D;
                      PLX                                 ;;9EA3|9E9F/9E9F\9E9F;
                      LDA.B #$03                          ;;9EA4|9EA0/9EA0\9EA0;
                      LDY.B #$02                          ;;9EA6|9EA2/9EA2\9EA2;
                      JSL FinishOAMWrite                  ;;9EA8|9EA4/9EA4\9EA4;
                      RTS                                 ;;9EAC|9EA8/9EA8\9EA8; Return 
                                                          ;;                   ;
CODE_039EA9:          LDA.W !SpriteMisc151C,X             ;;9EAD|9EA9/9EA9\9EA9;
                      STA.B !_3                           ;;9EB0|9EAC/9EAC\9EAC;
                      LDA.W !SpriteMisc1602,X             ;;9EB2|9EAE/9EAE\9EAE;
                      STA.B !_4                           ;;9EB5|9EB1/9EB1\9EB1;
                      PHX                                 ;;9EB7|9EB3/9EB3\9EB3;
                      LDA.B !EffFrame                     ;;9EB8|9EB4/9EB4\9EB4;
                      AND.B #$02                          ;;9EBA|9EB6/9EB6\9EB6;
                      ASL A                               ;;9EBC|9EB8/9EB8\9EB8;
                      ASL A                               ;;9EBD|9EB9/9EB9\9EB9;
                      ASL A                               ;;9EBE|9EBA/9EBA\9EBA;
                      ASL A                               ;;9EBF|9EBB/9EBB\9EBB;
                      ASL A                               ;;9EC0|9EBC/9EBC\9EBC;
                      LDX.B !_4                           ;;9EC1|9EBD/9EBD\9EBD;
                      CPX.B #$03                          ;;9EC3|9EBF/9EBF\9EBF;
                      BEQ +                               ;;9EC5|9EC1/9EC1\9EC1;
                      ASL A                               ;;9EC7|9EC3/9EC3\9EC3;
                    + STA.B !_5                           ;;9EC8|9EC4/9EC4\9EC4;
                      LDX.B #$04                          ;;9ECA|9EC6/9EC6\9EC6;
CODE_039EC8:          STX.B !_6                           ;;9ECC|9EC8/9EC8\9EC8;
                      LDA.B !_4                           ;;9ECE|9ECA/9ECA\9ECA;
                      CMP.B #$03                          ;;9ED0|9ECC/9ECC\9ECC;
                      BNE +                               ;;9ED2|9ECE/9ECE\9ECE;
                      TXA                                 ;;9ED4|9ED0/9ED0\9ED0;
                      CLC                                 ;;9ED5|9ED1/9ED1\9ED1;
                      ADC.B #$05                          ;;9ED6|9ED2/9ED2\9ED2;
                      TAX                                 ;;9ED8|9ED4/9ED4\9ED4;
                    + PHX                                 ;;9ED9|9ED5/9ED5\9ED5;
                      LDA.W DinoTorchTileDispX,X          ;;9EDA|9ED6/9ED6\9ED6;
                      LDX.B !_2                           ;;9EDD|9ED9/9ED9\9ED9;
                      BNE +                               ;;9EDF|9EDB/9EDB\9EDB;
                      EOR.B #$FF                          ;;9EE1|9EDD/9EDD\9EDD;
                      INC A                               ;;9EE3|9EDF/9EDF\9EDF;
                    + PLX                                 ;;9EE4|9EE0/9EE0\9EE0;
                      CLC                                 ;;9EE5|9EE1/9EE1\9EE1;
                      ADC.B !_0                           ;;9EE6|9EE2/9EE2\9EE2;
                      STA.W !OAMTileXPos+$100,Y           ;;9EE8|9EE4/9EE4\9EE4;
                      LDA.W DinoTorchTileDispY,X          ;;9EEB|9EE7/9EE7\9EE7;
                      CLC                                 ;;9EEE|9EEA/9EEA\9EEA;
                      ADC.B !_1                           ;;9EEF|9EEB/9EEB\9EEB;
                      STA.W !OAMTileYPos+$100,Y           ;;9EF1|9EED/9EED\9EED;
                      LDA.B !_6                           ;;9EF4|9EF0/9EF0\9EF0;
                      CMP.B #$04                          ;;9EF6|9EF2/9EF2\9EF2;
                      BNE CODE_039EFD                     ;;9EF8|9EF4/9EF4\9EF4;
                      LDX.B !_4                           ;;9EFA|9EF6/9EF6\9EF6;
                      LDA.W DinoTorchTiles,X              ;;9EFC|9EF8/9EF8\9EF8;
                      BRA +                               ;;9EFF|9EFB/9EFB\9EFB;
                                                          ;;                   ;
CODE_039EFD:          LDA.W DinoFlameTiles,X              ;;9F01|9EFD/9EFD\9EFD;
                    + STA.W !OAMTileNo+$100,Y             ;;9F04|9F00/9F00\9F00;
                      LDA.B #$00                          ;;9F07|9F03/9F03\9F03;
                      LDX.B !_2                           ;;9F09|9F05/9F05\9F05;
                      BNE +                               ;;9F0B|9F07/9F07\9F07;
                      ORA.B #$40                          ;;9F0D|9F09/9F09\9F09;
                    + LDX.B !_6                           ;;9F0F|9F0B/9F0B\9F0B;
                      CPX.B #$04                          ;;9F11|9F0D/9F0D\9F0D;
                      BEQ +                               ;;9F13|9F0F/9F0F\9F0F;
                      EOR.B !_5                           ;;9F15|9F11/9F11\9F11;
                    + ORA.W DinoTorchGfxProp,X            ;;9F17|9F13/9F13\9F13;
                      ORA.B !SpriteProperties             ;;9F1A|9F16/9F16\9F16;
                      STA.W !OAMTileAttr+$100,Y           ;;9F1C|9F18/9F18\9F18;
                      INY                                 ;;9F1F|9F1B/9F1B\9F1B;
                      INY                                 ;;9F20|9F1C/9F1C\9F1C;
                      INY                                 ;;9F21|9F1D/9F1D\9F1D;
                      INY                                 ;;9F22|9F1E/9F1E\9F1E;
                      DEX                                 ;;9F23|9F1F/9F1F\9F1F;
                      CPX.B !_3                           ;;9F24|9F20/9F20\9F20;
                      BPL CODE_039EC8                     ;;9F26|9F22/9F22\9F22;
                      PLX                                 ;;9F28|9F24/9F24\9F24;
                      LDY.W !SpriteMisc151C,X             ;;9F29|9F25/9F25\9F25;
                      LDA.W DinoTilesWritten,Y            ;;9F2C|9F28/9F28\9F28;
                      LDY.B #$02                          ;;9F2F|9F2B/9F2B\9F2B;
                      JSL FinishOAMWrite                  ;;9F31|9F2D/9F2D\9F2D;
                      RTS                                 ;;9F35|9F31/9F31\9F31; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DinoTilesWritten:     db $04,$03,$02,$01,$00              ;;9F36|9F32/9F32\9F32;
                                                          ;;                   ;
                      RTS                                 ;;9F3B|9F37/9F37\9F37;
                                                          ;;                   ;
Blargg:               JSR CODE_03A062                     ;;9F3C|9F38/9F38\9F38;
                      LDA.B !SpriteLock                   ;;9F3F|9F3B/9F3B\9F3B;
                      BNE +                               ;;9F41|9F3D/9F3D\9F3D;
                      JSL MarioSprInteract                ;;9F43|9F3F/9F3F\9F3F;
                      JSR SubOffscreen0Bnk3               ;;9F47|9F43/9F43\9F43;
                      LDA.B !SpriteTableC2,X              ;;9F4A|9F46/9F46\9F46;
                      JSL ExecutePtr                      ;;9F4C|9F48/9F48\9F48;
                                                          ;;                   ;
                      dw CODE_039F57                      ;;9F50|9F4C/9F4C\9F4C;
                      dw CODE_039F8B                      ;;9F52|9F4E/9F4E\9F4E;
                      dw CODE_039FA4                      ;;9F54|9F50/9F50\9F50;
                      dw CODE_039FC8                      ;;9F56|9F52/9F52\9F52;
                      dw CODE_039FEF                      ;;9F58|9F54/9F54\9F54;
                                                          ;;                   ;
                    + RTS                                 ;;9F5A|9F56/9F56\9F56; Return 
                                                          ;;                   ;
CODE_039F57:          LDA.W !SpriteOffscreenX,X           ;;9F5B|9F57/9F57\9F57;
                      ORA.W !SpriteMisc1540,X             ;;9F5E|9F5A/9F5A\9F5A;
                      BNE +                               ;;9F61|9F5D/9F5D\9F5D;
                      JSR SubHorzPosBnk3                  ;;9F63|9F5F/9F5F\9F5F;
                      LDA.B !_F                           ;;9F66|9F62/9F62\9F62;
                      CLC                                 ;;9F68|9F64/9F64\9F64;
                      ADC.B #$70                          ;;9F69|9F65/9F65\9F65;
                      CMP.B #$E0                          ;;9F6B|9F67/9F67\9F67;
                      BCS +                               ;;9F6D|9F69/9F69\9F69;
                      LDA.B #$E3                          ;;9F6F|9F6B/9F6B\9F6B;
                      STA.B !SpriteYSpeed,X               ;;9F71|9F6D/9F6D\9F6D;
                      LDA.W !SpriteYPosHigh,X             ;;9F73|9F6F/9F6F\9F6F;
                      STA.W !SpriteMisc151C,X             ;;9F76|9F72/9F72\9F72;
                      LDA.B !SpriteXPosLow,X              ;;9F79|9F75/9F75\9F75;
                      STA.W !SpriteMisc1528,X             ;;9F7B|9F77/9F77\9F77;
                      LDA.W !SpriteXPosHigh,X             ;;9F7E|9F7A/9F7A\9F7A;
                      STA.W !SpriteMisc1534,X             ;;9F81|9F7D/9F7D\9F7D;
                      LDA.B !SpriteYPosLow,X              ;;9F84|9F80/9F80\9F80;
                      STA.W !SpriteMisc1594,X             ;;9F86|9F82/9F82\9F82;
                      JSR CODE_039FC0                     ;;9F89|9F85/9F85\9F85;
                      INC.B !SpriteTableC2,X              ;;9F8C|9F88/9F88\9F88;
                    + RTS                                 ;;9F8E|9F8A/9F8A\9F8A; Return 
                                                          ;;                   ;
CODE_039F8B:          LDA.B !SpriteYSpeed,X               ;;9F8F|9F8B/9F8B\9F8B;
                      CMP.B #$10                          ;;9F91|9F8D/9F8D\9F8D;
                      BMI +                               ;;9F93|9F8F/9F8F\9F8F;
                      LDA.B #$50                          ;;9F95|9F91/9F91\9F91;
                      STA.W !SpriteMisc1540,X             ;;9F97|9F93/9F93\9F93;
                      INC.B !SpriteTableC2,X              ;;9F9A|9F96/9F96\9F96;
                      STZ.B !SpriteYSpeed,X               ;;9F9C|9F98/9F98\9F98; Sprite Y Speed = 0 
                      RTS                                 ;;9F9E|9F9A/9F9A\9F9A; Return 
                                                          ;;                   ;
                    + JSL UpdateYPosNoGvtyW               ;;9F9F|9F9B/9F9B\9F9B;
                      INC.B !SpriteYSpeed,X               ;;9FA3|9F9F/9F9F\9F9F;
                      INC.B !SpriteYSpeed,X               ;;9FA5|9FA1/9FA1\9FA1;
                      RTS                                 ;;9FA7|9FA3/9FA3\9FA3; Return 
                                                          ;;                   ;
CODE_039FA4:          LDA.W !SpriteMisc1540,X             ;;9FA8|9FA4/9FA4\9FA4;
                      BNE +                               ;;9FAB|9FA7/9FA7\9FA7;
                      INC.B !SpriteTableC2,X              ;;9FAD|9FA9/9FA9\9FA9;
                      LDA.B #$0A                          ;;9FAF|9FAB/9FAB\9FAB;
                      STA.W !SpriteMisc1540,X             ;;9FB1|9FAD/9FAD\9FAD;
                      RTS                                 ;;9FB4|9FB0/9FB0\9FB0; Return 
                                                          ;;                   ;
                    + CMP.B #$20                          ;;9FB5|9FB1/9FB1\9FB1;
                      BCC CODE_039FC0                     ;;9FB7|9FB3/9FB3\9FB3;
                      AND.B #$1F                          ;;9FB9|9FB5/9FB5\9FB5;
                      BNE Return039FC7                    ;;9FBB|9FB7/9FB7\9FB7;
                      LDA.W !SpriteMisc157C,X             ;;9FBD|9FB9/9FB9\9FB9;
                      EOR.B #$01                          ;;9FC0|9FBC/9FBC\9FBC;
                      BRA +                               ;;9FC2|9FBE/9FBE\9FBE;
                                                          ;;                   ;
CODE_039FC0:          JSR SubHorzPosBnk3                  ;;9FC4|9FC0/9FC0\9FC0;
                      TYA                                 ;;9FC7|9FC3/9FC3\9FC3;
                    + STA.W !SpriteMisc157C,X             ;;9FC8|9FC4/9FC4\9FC4;
Return039FC7:         RTS                                 ;;9FCB|9FC7/9FC7\9FC7; Return 
                                                          ;;                   ;
CODE_039FC8:          LDA.W !SpriteMisc1540,X             ;;9FCC|9FC8/9FC8\9FC8;
                      BEQ +                               ;;9FCF|9FCB/9FCB\9FCB;
                      LDA.B #$20                          ;;9FD1|9FCD/9FCD\9FCD;
                      STA.B !SpriteYSpeed,X               ;;9FD3|9FCF/9FCF\9FCF;
                      JSL UpdateYPosNoGvtyW               ;;9FD5|9FD1/9FD1\9FD1;
                      RTS                                 ;;9FD9|9FD5/9FD5\9FD5; Return 
                                                          ;;                   ;
                    + LDA.B #$20                          ;;9FDA|9FD6/9FD6\9FD6;
                      STA.W !SpriteMisc1540,X             ;;9FDC|9FD8/9FD8\9FD8;
                      LDY.W !SpriteMisc157C,X             ;;9FDF|9FDB/9FDB\9FDB;
                      LDA.W DATA_039FED,Y                 ;;9FE2|9FDE/9FDE\9FDE;
                      STA.B !SpriteXSpeed,X               ;;9FE5|9FE1/9FE1\9FE1;
                      LDA.B #$E2                          ;;9FE7|9FE3/9FE3\9FE3;
                      STA.B !SpriteYSpeed,X               ;;9FE9|9FE5/9FE5\9FE5;
                      JSR CODE_03A045                     ;;9FEB|9FE7/9FE7\9FE7;
                      INC.B !SpriteTableC2,X              ;;9FEE|9FEA/9FEA\9FEA;
                      RTS                                 ;;9FF0|9FEC/9FEC\9FEC; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_039FED:          db $10,$F0                          ;;9FF1|9FED/9FED\9FED;
                                                          ;;                   ;
CODE_039FEF:          STZ.W !SpriteMisc1602,X             ;;9FF3|9FEF/9FEF\9FEF;
                      LDA.W !SpriteMisc1540,X             ;;9FF6|9FF2/9FF2\9FF2;
                      BEQ CODE_03A002                     ;;9FF9|9FF5/9FF5\9FF5;
                      DEC A                               ;;9FFB|9FF7/9FF7\9FF7;
                      BNE CODE_03A038                     ;;9FFC|9FF8/9FF8\9FF8;
                      LDA.B #$25                          ;;9FFE|9FFA/9FFA\9FFA; \ Play sound effect 
                      STA.W !SPCIO0                       ;;A000|9FFC/9FFC\9FFC; / 
                      JSR CODE_03A045                     ;;A003|9FFF/9FFF\9FFF;
CODE_03A002:          JSL UpdateXPosNoGvtyW               ;;A006|A002/A002\A002;
                      JSL UpdateYPosNoGvtyW               ;;A00A|A006/A006\A006;
                      LDA.B !TrueFrame                    ;;A00E|A00A/A00A\A00A;
                      AND.B #$00                          ;;A010|A00C/A00C\A00C;
                      BNE +                               ;;A012|A00E/A00E\A00E;
                      INC.B !SpriteYSpeed,X               ;;A014|A010/A010\A010;
                    + LDA.B !SpriteYSpeed,X               ;;A016|A012/A012\A012;
                      CMP.B #$20                          ;;A018|A014/A014\A014;
                      BMI CODE_03A038                     ;;A01A|A016/A016\A016;
                      JSR CODE_03A045                     ;;A01C|A018/A018\A018;
                      STZ.B !SpriteTableC2,X              ;;A01F|A01B/A01B\A01B;
                      LDA.W !SpriteMisc151C,X             ;;A021|A01D/A01D\A01D;
                      STA.W !SpriteYPosHigh,X             ;;A024|A020/A020\A020;
                      LDA.W !SpriteMisc1528,X             ;;A027|A023/A023\A023;
                      STA.B !SpriteXPosLow,X              ;;A02A|A026/A026\A026;
                      LDA.W !SpriteMisc1534,X             ;;A02C|A028/A028\A028;
                      STA.W !SpriteXPosHigh,X             ;;A02F|A02B/A02B\A02B;
                      LDA.W !SpriteMisc1594,X             ;;A032|A02E/A02E\A02E;
                      STA.B !SpriteYPosLow,X              ;;A035|A031/A031\A031;
                      LDA.B #$40                          ;;A037|A033/A033\A033;
                      STA.W !SpriteMisc1540,X             ;;A039|A035/A035\A035;
CODE_03A038:          LDA.B !SpriteYSpeed,X               ;;A03C|A038/A038\A038;
                      CLC                                 ;;A03E|A03A/A03A\A03A;
                      ADC.B #$06                          ;;A03F|A03B/A03B\A03B;
                      CMP.B #$0C                          ;;A041|A03D/A03D\A03D;
                      BCS +                               ;;A043|A03F/A03F\A03F;
                      INC.W !SpriteMisc1602,X             ;;A045|A041/A041\A041;
                    + RTS                                 ;;A048|A044/A044\A044; Return 
                                                          ;;                   ;
CODE_03A045:          LDA.B !SpriteYPosLow,X              ;;A049|A045/A045\A045;
                      PHA                                 ;;A04B|A047/A047\A047;
                      SEC                                 ;;A04C|A048/A048\A048;
                      SBC.B #$0C                          ;;A04D|A049/A049\A049;
                      STA.B !SpriteYPosLow,X              ;;A04F|A04B/A04B\A04B;
                      LDA.W !SpriteXPosHigh,X             ;;A051|A04D/A04D\A04D;
                      PHA                                 ;;A054|A050/A050\A050;
                      SBC.B #$00                          ;;A055|A051/A051\A051;
                      STA.W !SpriteXPosHigh,X             ;;A057|A053/A053\A053;
                      JSL CODE_028528                     ;;A05A|A056/A056\A056;
                      PLA                                 ;;A05E|A05A/A05A\A05A;
                      STA.W !SpriteXPosHigh,X             ;;A05F|A05B/A05B\A05B;
                      PLA                                 ;;A062|A05E/A05E\A05E;
                      STA.B !SpriteYPosLow,X              ;;A063|A05F/A05F\A05F;
                      RTS                                 ;;A065|A061/A061\A061; Return 
                                                          ;;                   ;
CODE_03A062:          JSR GetDrawInfoBnk3                 ;;A066|A062/A062\A062;
                      LDA.B !SpriteTableC2,X              ;;A069|A065/A065\A065;
                      BEQ CODE_03A038                     ;;A06B|A067/A067\A067;
                      CMP.B #$04                          ;;A06D|A069/A069\A069;
                      BEQ +                               ;;A06F|A06B/A06B\A06B;
                      JSL GenericSprGfxRt2                ;;A071|A06D/A06D\A06D;
                      LDY.W !SpriteOAMIndex,X             ;;A075|A071/A071\A071; Y = Index into sprite OAM 
                      LDA.B #$A0                          ;;A078|A074/A074\A074;
                      STA.W !OAMTileNo+$100,Y             ;;A07A|A076/A076\A076;
                      LDA.W !OAMTileAttr+$100,Y           ;;A07D|A079/A079\A079;
                      AND.B #$CF                          ;;A080|A07C/A07C\A07C;
                      STA.W !OAMTileAttr+$100,Y           ;;A082|A07E/A07E\A07E;
                      RTS                                 ;;A085|A081/A081\A081; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A082:          db $F8,$08,$F8,$08,$18,$08,$F8,$08  ;;A086|A082/A082\A082;
                      db $F8,$E8                          ;;A08E|A08A/A08A\A08A;
                                                          ;;                   ;
DATA_03A08C:          db $F8,$F8,$08,$08,$08              ;;A090|A08C/A08C\A08C;
                                                          ;;                   ;
BlarggTilemap:        db $A2,$A4,$C2,$C4,$A6,$A2,$A4,$E6  ;;A095|A091/A091\A091;
                      db $C8,$A6                          ;;A09D|A099/A099\A099;
                                                          ;;                   ;
DATA_03A09B:          db $45,$05                          ;;A09F|A09B/A09B\A09B;
                                                          ;;                   ;
                    + LDA.W !SpriteMisc1602,X             ;;A0A1|A09D/A09D\A09D;
                      ASL A                               ;;A0A4|A0A0/A0A0\A0A0;
                      ASL A                               ;;A0A5|A0A1/A0A1\A0A1;
                      ADC.W !SpriteMisc1602,X             ;;A0A6|A0A2/A0A2\A0A2;
                      STA.B !_3                           ;;A0A9|A0A5/A0A5\A0A5;
                      LDA.W !SpriteMisc157C,X             ;;A0AB|A0A7/A0A7\A0A7;
                      STA.B !_2                           ;;A0AE|A0AA/A0AA\A0AA;
                      PHX                                 ;;A0B0|A0AC/A0AC\A0AC;
                      LDX.B #$04                          ;;A0B1|A0AD/A0AD\A0AD;
CODE_03A0AF:          PHX                                 ;;A0B3|A0AF/A0AF\A0AF;
                      PHX                                 ;;A0B4|A0B0/A0B0\A0B0;
                      LDA.B !_1                           ;;A0B5|A0B1/A0B1\A0B1;
                      CLC                                 ;;A0B7|A0B3/A0B3\A0B3;
                      ADC.W DATA_03A08C,X                 ;;A0B8|A0B4/A0B4\A0B4;
                      STA.W !OAMTileYPos+$100,Y           ;;A0BB|A0B7/A0B7\A0B7;
                      LDA.B !_2                           ;;A0BE|A0BA/A0BA\A0BA;
                      BNE +                               ;;A0C0|A0BC/A0BC\A0BC;
                      TXA                                 ;;A0C2|A0BE/A0BE\A0BE;
                      CLC                                 ;;A0C3|A0BF/A0BF\A0BF;
                      ADC.B #$05                          ;;A0C4|A0C0/A0C0\A0C0;
                      TAX                                 ;;A0C6|A0C2/A0C2\A0C2;
                    + LDA.B !_0                           ;;A0C7|A0C3/A0C3\A0C3;
                      CLC                                 ;;A0C9|A0C5/A0C5\A0C5;
                      ADC.W DATA_03A082,X                 ;;A0CA|A0C6/A0C6\A0C6;
                      STA.W !OAMTileXPos+$100,Y           ;;A0CD|A0C9/A0C9\A0C9;
                      PLA                                 ;;A0D0|A0CC/A0CC\A0CC;
                      CLC                                 ;;A0D1|A0CD/A0CD\A0CD;
                      ADC.B !_3                           ;;A0D2|A0CE/A0CE\A0CE;
                      TAX                                 ;;A0D4|A0D0/A0D0\A0D0;
                      LDA.W BlarggTilemap,X               ;;A0D5|A0D1/A0D1\A0D1;
                      STA.W !OAMTileNo+$100,Y             ;;A0D8|A0D4/A0D4\A0D4;
                      LDX.B !_2                           ;;A0DB|A0D7/A0D7\A0D7;
                      LDA.W DATA_03A09B,X                 ;;A0DD|A0D9/A0D9\A0D9;
                      STA.W !OAMTileAttr+$100,Y           ;;A0E0|A0DC/A0DC\A0DC;
                      PLX                                 ;;A0E3|A0DF/A0DF\A0DF;
                      INY                                 ;;A0E4|A0E0/A0E0\A0E0;
                      INY                                 ;;A0E5|A0E1/A0E1\A0E1;
                      INY                                 ;;A0E6|A0E2/A0E2\A0E2;
                      INY                                 ;;A0E7|A0E3/A0E3\A0E3;
                      DEX                                 ;;A0E8|A0E4/A0E4\A0E4;
                      BPL CODE_03A0AF                     ;;A0E9|A0E5/A0E5\A0E5;
                      PLX                                 ;;A0EB|A0E7/A0E7\A0E7;
                      LDY.B #$02                          ;;A0EC|A0E8/A0E8\A0E8;
                      LDA.B #$04                          ;;A0EE|A0EA/A0EA\A0EA;
                      JSL FinishOAMWrite                  ;;A0F0|A0EC/A0EC\A0EC;
                      RTS                                 ;;A0F4|A0F0/A0F0\A0F0; Return 
                                                          ;;                   ;
CODE_03A0F1:          JSL InitSpriteTables                ;;A0F5|A0F1/A0F1\A0F1;
                      STZ.W !SpriteOffscreenX,X           ;;A0F9|A0F5/A0F5\A0F5;
                      LDA.B #$80                          ;;A0FC|A0F8/A0F8\A0F8;
                      STA.B !SpriteYPosLow,X              ;;A0FE|A0FA/A0FA\A0FA;
                      LDA.B #$FF                          ;;A100|A0FC/A0FC\A0FC;
                      STA.W !SpriteXPosHigh,X             ;;A102|A0FE/A0FE\A0FE;
                      LDA.B #$D0                          ;;A105|A101/A101\A101;
                      STA.B !SpriteXPosLow,X              ;;A107|A103/A103\A103;
                      LDA.B #$00                          ;;A109|A105/A105\A105;
                      STA.W !SpriteYPosHigh,X             ;;A10B|A107/A107\A107;
                      LDA.B #$02                          ;;A10E|A10A/A10A\A10A;
                      STA.W !SpriteMisc187B,X             ;;A110|A10C/A10C\A10C;
                      LDA.B #$03                          ;;A113|A10F/A10F\A10F;
                      STA.B !SpriteTableC2,X              ;;A115|A111/A111\A111;
                      JSL CODE_03DD7D                     ;;A117|A113/A113\A113;
                      RTL                                 ;;A11B|A117/A117\A117; Return 
                                                          ;;                   ;
Bnk3CallSprMain:      PHB                                 ;;A11C|A118/A118\A118;
                      PHK                                 ;;A11D|A119/A119\A119;
                      PLB                                 ;;A11E|A11A/A11A\A11A;
                      LDA.B !SpriteNumber,X               ;;A11F|A11B/A11B\A11B;
                      CMP.B #$C8                          ;;A121|A11D/A11D\A11D;
                      BNE +                               ;;A123|A11F/A11F\A11F;
                      JSR LightSwitch                     ;;A125|A121/A121\A121;
                      PLB                                 ;;A128|A124/A124\A124;
                      RTL                                 ;;A129|A125/A125\A125; Return 
                                                          ;;                   ;
                    + CMP.B #$C7                          ;;A12A|A126/A126\A126;
                      BNE +                               ;;A12C|A128/A128\A128;
                      JSR InvisMushroom                   ;;A12E|A12A/A12A\A12A;
                      PLB                                 ;;A131|A12D/A12D\A12D;
                      RTL                                 ;;A132|A12E/A12E\A12E; Return 
                                                          ;;                   ;
                    + CMP.B #$51                          ;;A133|A12F/A12F\A12F;
                      BNE +                               ;;A135|A131/A131\A131;
                      JSR Ninji                           ;;A137|A133/A133\A133;
                      PLB                                 ;;A13A|A136/A136\A136;
                      RTL                                 ;;A13B|A137/A137\A137; Return 
                                                          ;;                   ;
                    + CMP.B #$1B                          ;;A13C|A138/A138\A138;
                      BNE +                               ;;A13E|A13A/A13A\A13A;
                      JSR Football                        ;;A140|A13C/A13C\A13C;
                      PLB                                 ;;A143|A13F/A13F\A13F;
                      RTL                                 ;;A144|A140/A140\A140; Return 
                                                          ;;                   ;
                    + CMP.B #$C6                          ;;A145|A141/A141\A141;
                      BNE +                               ;;A147|A143/A143\A143;
                      JSR DarkRoomWithLight               ;;A149|A145/A145\A145;
                      PLB                                 ;;A14C|A148/A148\A148;
                      RTL                                 ;;A14D|A149/A149\A149; Return 
                                                          ;;                   ;
                    + CMP.B #$7A                          ;;A14E|A14A/A14A\A14A;
                      BNE +                               ;;A150|A14C/A14C\A14C;
                      JSR Firework                        ;;A152|A14E/A14E\A14E;
                      PLB                                 ;;A155|A151/A151\A151;
                      RTL                                 ;;A156|A152/A152\A152; Return 
                                                          ;;                   ;
                    + CMP.B #$7C                          ;;A157|A153/A153\A153;
                      BNE +                               ;;A159|A155/A155\A155;
                      JSR PrincessPeach                   ;;A15B|A157/A157\A157;
                      PLB                                 ;;A15E|A15A/A15A\A15A;
                      RTL                                 ;;A15F|A15B/A15B\A15B; Return 
                                                          ;;                   ;
                    + CMP.B #$C5                          ;;A160|A15C/A15C\A15C;
                      BNE +                               ;;A162|A15E/A15E\A15E;
                      JSR BigBooBoss                      ;;A164|A160/A160\A160;
                      PLB                                 ;;A167|A163/A163\A163;
                      RTL                                 ;;A168|A164/A164\A164; Return 
                                                          ;;                   ;
                    + CMP.B #$C4                          ;;A169|A165/A165\A165;
                      BNE +                               ;;A16B|A167/A167\A167;
                      JSR GreyFallingPlat                 ;;A16D|A169/A169\A169;
                      PLB                                 ;;A170|A16C/A16C\A16C;
                      RTL                                 ;;A171|A16D/A16D\A16D; Return 
                                                          ;;                   ;
                    + CMP.B #$C2                          ;;A172|A16E/A16E\A16E;
                      BNE +                               ;;A174|A170/A170\A170;
                      JSR Blurp                           ;;A176|A172/A172\A172;
                      PLB                                 ;;A179|A175/A175\A175;
                      RTL                                 ;;A17A|A176/A176\A176; Return 
                                                          ;;                   ;
                    + CMP.B #$C3                          ;;A17B|A177/A177\A177;
                      BNE +                               ;;A17D|A179/A179\A179;
                      JSR PorcuPuffer                     ;;A17F|A17B/A17B\A17B;
                      PLB                                 ;;A182|A17E/A17E\A17E;
                      RTL                                 ;;A183|A17F/A17F\A17F; Return 
                                                          ;;                   ;
                    + CMP.B #$C1                          ;;A184|A180/A180\A180;
                      BNE +                               ;;A186|A182/A182\A182;
                      JSR FlyingTurnBlocks                ;;A188|A184/A184\A184;
                      PLB                                 ;;A18B|A187/A187\A187;
                      RTL                                 ;;A18C|A188/A188\A188; Return 
                                                          ;;                   ;
                    + CMP.B #$C0                          ;;A18D|A189/A189\A189;
                      BNE +                               ;;A18F|A18B/A18B\A18B;
                      JSR GrayLavaPlatform                ;;A191|A18D/A18D\A18D;
                      PLB                                 ;;A194|A190/A190\A190;
                      RTL                                 ;;A195|A191/A191\A191; Return 
                                                          ;;                   ;
                    + CMP.B #$BF                          ;;A196|A192/A192\A192;
                      BNE +                               ;;A198|A194/A194\A194;
                      JSR MegaMole                        ;;A19A|A196/A196\A196;
                      PLB                                 ;;A19D|A199/A199\A199;
                      RTL                                 ;;A19E|A19A/A19A\A19A; Return 
                                                          ;;                   ;
                    + CMP.B #$BE                          ;;A19F|A19B/A19B\A19B;
                      BNE +                               ;;A1A1|A19D/A19D\A19D;
                      JSR Swooper                         ;;A1A3|A19F/A19F\A19F;
                      PLB                                 ;;A1A6|A1A2/A1A2\A1A2;
                      RTL                                 ;;A1A7|A1A3/A1A3\A1A3; Return 
                                                          ;;                   ;
                    + CMP.B #$BD                          ;;A1A8|A1A4/A1A4\A1A4;
                      BNE +                               ;;A1AA|A1A6/A1A6\A1A6;
                      JSR SlidingKoopa                    ;;A1AC|A1A8/A1A8\A1A8;
                      PLB                                 ;;A1AF|A1AB/A1AB\A1AB;
                      RTL                                 ;;A1B0|A1AC/A1AC\A1AC; Return 
                                                          ;;                   ;
                    + CMP.B #$BC                          ;;A1B1|A1AD/A1AD\A1AD;
                      BNE +                               ;;A1B3|A1AF/A1AF\A1AF;
                      JSR BowserStatue                    ;;A1B5|A1B1/A1B1\A1B1;
                      PLB                                 ;;A1B8|A1B4/A1B4\A1B4;
                      RTL                                 ;;A1B9|A1B5/A1B5\A1B5; Return 
                                                          ;;                   ;
                    + CMP.B #$B8                          ;;A1BA|A1B6/A1B6\A1B6;
                      BEQ CODE_03A1BE                     ;;A1BC|A1B8/A1B8\A1B8;
                      CMP.B #$B7                          ;;A1BE|A1BA/A1BA\A1BA;
                      BNE +                               ;;A1C0|A1BC/A1BC\A1BC;
CODE_03A1BE:          JSR CarrotTopLift                   ;;A1C2|A1BE/A1BE\A1BE;
                      PLB                                 ;;A1C5|A1C1/A1C1\A1C1;
                      RTL                                 ;;A1C6|A1C2/A1C2\A1C2; Return 
                                                          ;;                   ;
                    + CMP.B #$B9                          ;;A1C7|A1C3/A1C3\A1C3;
                      BNE +                               ;;A1C9|A1C5/A1C5\A1C5;
                      JSR InfoBox                         ;;A1CB|A1C7/A1C7\A1C7;
                      PLB                                 ;;A1CE|A1CA/A1CA\A1CA;
                      RTL                                 ;;A1CF|A1CB/A1CB\A1CB; Return 
                                                          ;;                   ;
                    + CMP.B #$BA                          ;;A1D0|A1CC/A1CC\A1CC;
                      BNE +                               ;;A1D2|A1CE/A1CE\A1CE;
                      JSR TimedLift                       ;;A1D4|A1D0/A1D0\A1D0;
                      PLB                                 ;;A1D7|A1D3/A1D3\A1D3;
                      RTL                                 ;;A1D8|A1D4/A1D4\A1D4; Return 
                                                          ;;                   ;
                    + CMP.B #$BB                          ;;A1D9|A1D5/A1D5\A1D5;
                      BNE +                               ;;A1DB|A1D7/A1D7\A1D7;
                      JSR GreyCastleBlock                 ;;A1DD|A1D9/A1D9\A1D9;
                      PLB                                 ;;A1E0|A1DC/A1DC\A1DC;
                      RTL                                 ;;A1E1|A1DD/A1DD\A1DD; Return 
                                                          ;;                   ;
                    + CMP.B #$B3                          ;;A1E2|A1DE/A1DE\A1DE;
                      BNE +                               ;;A1E4|A1E0/A1E0\A1E0;
                      JSR StatueFireball                  ;;A1E6|A1E2/A1E2\A1E2;
                      PLB                                 ;;A1E9|A1E5/A1E5\A1E5;
                      RTL                                 ;;A1EA|A1E6/A1E6\A1E6; Return 
                                                          ;;                   ;
                    + LDA.B !SpriteNumber,X               ;;A1EB|A1E7/A1E7\A1E7;
                      CMP.B #$B2                          ;;A1ED|A1E9/A1E9\A1E9;
                      BNE +                               ;;A1EF|A1EB/A1EB\A1EB;
                      JSR FallingSpike                    ;;A1F1|A1ED/A1ED\A1ED;
                      PLB                                 ;;A1F4|A1F0/A1F0\A1F0;
                      RTL                                 ;;A1F5|A1F1/A1F1\A1F1; Return 
                                                          ;;                   ;
                    + CMP.B #$AE                          ;;A1F6|A1F2/A1F2\A1F2;
                      BNE +                               ;;A1F8|A1F4/A1F4\A1F4;
                      JSR FishinBoo                       ;;A1FA|A1F6/A1F6\A1F6;
                      PLB                                 ;;A1FD|A1F9/A1F9\A1F9;
                      RTL                                 ;;A1FE|A1FA/A1FA\A1FA; Return 
                                                          ;;                   ;
                    + CMP.B #$B6                          ;;A1FF|A1FB/A1FB\A1FB;
                      BNE +                               ;;A201|A1FD/A1FD\A1FD;
                      JSR ReflectingFireball              ;;A203|A1FF/A1FF\A1FF;
                      PLB                                 ;;A206|A202/A202\A202;
                      RTL                                 ;;A207|A203/A203\A203; Return 
                                                          ;;                   ;
                    + CMP.B #$B0                          ;;A208|A204/A204\A204;
                      BNE +                               ;;A20A|A206/A206\A206;
                      JSR BooStream                       ;;A20C|A208/A208\A208;
                      PLB                                 ;;A20F|A20B/A20B\A20B;
                      RTL                                 ;;A210|A20C/A20C\A20C; Return 
                                                          ;;                   ;
                    + CMP.B #$B1                          ;;A211|A20D/A20D\A20D;
                      BNE +                               ;;A213|A20F/A20F\A20F;
                      JSR CreateEatBlock                  ;;A215|A211/A211\A211;
                      PLB                                 ;;A218|A214/A214\A214;
                      RTL                                 ;;A219|A215/A215\A215; Return 
                                                          ;;                   ;
                    + CMP.B #$AC                          ;;A21A|A216/A216\A216;
                      BEQ CODE_03A21E                     ;;A21C|A218/A218\A218;
                      CMP.B #$AD                          ;;A21E|A21A/A21A\A21A;
                      BNE +                               ;;A220|A21C/A21C\A21C;
CODE_03A21E:          JSR WoodenSpike                     ;;A222|A21E/A21E\A21E;
                      PLB                                 ;;A225|A221/A221\A221;
                      RTL                                 ;;A226|A222/A222\A222; Return 
                                                          ;;                   ;
                    + CMP.B #$AB                          ;;A227|A223/A223\A223;
                      BNE +                               ;;A229|A225/A225\A225;
                      JSR RexMainRt                       ;;A22B|A227/A227\A227;
                      PLB                                 ;;A22E|A22A/A22A\A22A;
                      RTL                                 ;;A22F|A22B/A22B\A22B; Return 
                                                          ;;                   ;
                    + CMP.B #$AA                          ;;A230|A22C/A22C\A22C;
                      BNE +                               ;;A232|A22E/A22E\A22E;
                      JSR Fishbone                        ;;A234|A230/A230\A230;
                      PLB                                 ;;A237|A233/A233\A233;
                      RTL                                 ;;A238|A234/A234\A234; Return 
                                                          ;;                   ;
                    + CMP.B #$A9                          ;;A239|A235/A235\A235;
                      BNE +                               ;;A23B|A237/A237\A237;
                      JSR Reznor                          ;;A23D|A239/A239\A239;
                      PLB                                 ;;A240|A23C/A23C\A23C;
                      RTL                                 ;;A241|A23D/A23D\A23D; Return 
                                                          ;;                   ;
                    + CMP.B #$A8                          ;;A242|A23E/A23E\A23E;
                      BNE +                               ;;A244|A240/A240\A240;
                      JSR Blargg                          ;;A246|A242/A242\A242;
                      PLB                                 ;;A249|A245/A245\A245;
                      RTL                                 ;;A24A|A246/A246\A246; Return 
                                                          ;;                   ;
                    + CMP.B #$A1                          ;;A24B|A247/A247\A247;
                      BNE +                               ;;A24D|A249/A249\A249;
                      JSR BowserBowlingBall               ;;A24F|A24B/A24B\A24B;
                      PLB                                 ;;A252|A24E/A24E\A24E;
                      RTL                                 ;;A253|A24F/A24F\A24F; Return 
                                                          ;;                   ;
                    + CMP.B #$A2                          ;;A254|A250/A250\A250;
                      BNE +                               ;;A256|A252/A252\A252;
                      JSR MechaKoopa                      ;;A258|A254/A254\A254;
                      PLB                                 ;;A25B|A257/A257\A257;
                      RTL                                 ;;A25C|A258/A258\A258; Return 
                                                          ;;                   ;
                    + JSL CODE_03DFCC                     ;;A25D|A259/A259\A259;
                      JSR CODE_03A279                     ;;A261|A25D/A25D\A25D;
                      JSR CODE_03B43C                     ;;A264|A260/A260\A260;
                      PLB                                 ;;A267|A263/A263\A263;
                      RTL                                 ;;A268|A264/A264\A264; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A265:          db $04,$03,$02,$01,$00,$01,$02,$03  ;;A269|A265/A265\A265;
                      db $04,$05,$06,$07,$07,$07,$07,$07  ;;A271|A26D/A26D\A26D;
                      db $07,$07,$07,$07                  ;;A279|A275/A275\A275;
                                                          ;;                   ;
CODE_03A279:          LDA.B !Mode7XScale                  ;;A27D|A279/A279\A279;
                      LSR A                               ;;A27F|A27B/A27B\A27B;
                      LSR A                               ;;A280|A27C/A27C\A27C;
                      LSR A                               ;;A281|A27D/A27D\A27D;
                      TAY                                 ;;A282|A27E/A27E\A27E;
                      LDA.W DATA_03A265,Y                 ;;A283|A27F/A27F\A27F;
                      STA.W !BowserPalette                ;;A286|A282/A282\A282;
                      LDA.W !SpriteMisc1570,X             ;;A289|A285/A285\A285;
                      CLC                                 ;;A28C|A288/A288\A288;
                      ADC.B #$1E                          ;;A28D|A289/A289\A289;
                      ORA.W !SpriteMisc157C,X             ;;A28F|A28B/A28B\A28B;
                      STA.W !Mode7TileIndex               ;;A292|A28E/A28E\A28E;
                      LDA.B !EffFrame                     ;;A295|A291/A291\A291;
                      LSR A                               ;;A297|A293/A293\A293;
                      AND.B #$03                          ;;A298|A294/A294\A294;
                      STA.W !ClownCarPropeller            ;;A29A|A296/A296\A296;
                      LDA.B #$90                          ;;A29D|A299/A299\A299;
                      STA.B !Mode7CenterX                 ;;A29F|A29B/A29B\A29B;
                      LDA.B #$C8                          ;;A2A1|A29D/A29D\A29D;
                      STA.B !Mode7CenterY                 ;;A2A3|A29F/A29F\A29F;
                      JSL CODE_03DEDF                     ;;A2A5|A2A1/A2A1\A2A1;
                      LDA.W !BrSwingXDist+1               ;;A2A9|A2A5/A2A5\A2A5;
                      BEQ +                               ;;A2AC|A2A8/A2A8\A2A8;
                      JSR CODE_03AF59                     ;;A2AE|A2AA/A2AA\A2AA;
                    + LDA.W !SpriteMisc1564,X             ;;A2B1|A2AD/A2AD\A2AD;
                      BEQ +                               ;;A2B4|A2B0/A2B0\A2B0;
                      JSR CODE_03A3E2                     ;;A2B6|A2B2/A2B2\A2B2;
                    + LDA.W !SpriteMisc1594,X             ;;A2B9|A2B5/A2B5\A2B5;
                      BEQ +                               ;;A2BC|A2B8/A2B8\A2B8;
                      DEC A                               ;;A2BE|A2BA/A2BA\A2BA;
                      LSR A                               ;;A2BF|A2BB/A2BB\A2BB;
                      LSR A                               ;;A2C0|A2BC/A2BC\A2BC;
                      PHA                                 ;;A2C1|A2BD/A2BD\A2BD;
                      LSR A                               ;;A2C2|A2BE/A2BE\A2BE;
                      TAY                                 ;;A2C3|A2BF/A2BF\A2BF;
                      LDA.W DATA_03A8BE,Y                 ;;A2C4|A2C0/A2C0\A2C0;
                      STA.B !_2                           ;;A2C7|A2C3/A2C3\A2C3;
                      PLA                                 ;;A2C9|A2C5/A2C5\A2C5;
                      AND.B #$03                          ;;A2CA|A2C6/A2C6\A2C6;
                      STA.B !_3                           ;;A2CC|A2C8/A2C8\A2C8;
                      JSR CODE_03AA6E                     ;;A2CE|A2CA/A2CA\A2CA;
                      NOP                                 ;;A2D1|A2CD/A2CD\A2CD;
                    + LDA.B !SpriteLock                   ;;A2D2|A2CE/A2CE\A2CE;
                      BNE Return03A340                    ;;A2D4|A2D0/A2D0\A2D0;
                      STZ.W !SpriteMisc1594,X             ;;A2D6|A2D2/A2D2\A2D2;
                      LDA.B #$30                          ;;A2D9|A2D5/A2D5\A2D5;
                      STA.B !SpriteProperties             ;;A2DB|A2D7/A2D7\A2D7;
                      LDA.B !Mode7XScale                  ;;A2DD|A2D9/A2D9\A2D9;
                      CMP.B #$20                          ;;A2DF|A2DB/A2DB\A2DB;
                      BCS +                               ;;A2E1|A2DD/A2DD\A2DD;
                      STZ.B !SpriteProperties             ;;A2E3|A2DF/A2DF\A2DF;
                    + JSR CODE_03A661                     ;;A2E5|A2E1/A2E1\A2E1;
                      LDA.W !BrSwingCenterXPos            ;;A2E8|A2E4/A2E4\A2E4;
                      BEQ +                               ;;A2EB|A2E7/A2E7\A2E7;
                      LDA.B !TrueFrame                    ;;A2ED|A2E9/A2E9\A2E9;
                      AND.B #$03                          ;;A2EF|A2EB/A2EB\A2EB;
                      BNE +                               ;;A2F1|A2ED/A2ED\A2ED;
                      DEC.W !BrSwingCenterXPos            ;;A2F3|A2EF/A2EF\A2EF;
                    + LDA.B !TrueFrame                    ;;A2F6|A2F2/A2F2\A2F2;
                      AND.B #$7F                          ;;A2F8|A2F4/A2F4\A2F4;
                      BNE +                               ;;A2FA|A2F6/A2F6\A2F6;
                      JSL GetRand                         ;;A2FC|A2F8/A2F8\A2F8;
                      AND.B #$01                          ;;A300|A2FC/A2FC\A2FC;
                      BNE +                               ;;A302|A2FE/A2FE\A2FE;
                      LDA.B #$0C                          ;;A304|A300/A300\A300;
                      STA.W !SpriteMisc1558,X             ;;A306|A302/A302\A302;
                    + JSR CODE_03B078                     ;;A309|A305/A305\A305;
                      LDA.W !SpriteMisc151C,X             ;;A30C|A308/A308\A308;
                      CMP.B #$09                          ;;A30F|A30B/A30B\A30B;
                      BEQ +                               ;;A311|A30D/A30D\A30D;
                      STZ.W !ClownCarImage                ;;A313|A30F/A30F\A30F;
                      LDA.W !SpriteMisc1558,X             ;;A316|A312/A312\A312;
                      BEQ +                               ;;A319|A315/A315\A315;
                      INC.W !ClownCarImage                ;;A31B|A317/A317\A317;
                    + JSR CODE_03A5AD                     ;;A31E|A31A/A31A\A31A;
                      JSL UpdateXPosNoGvtyW               ;;A321|A31D/A31D\A31D;
                      JSL UpdateYPosNoGvtyW               ;;A325|A321/A321\A321;
                      LDA.W !SpriteMisc151C,X             ;;A329|A325/A325\A325;
                      JSL ExecutePtr                      ;;A32C|A328/A328\A328;
                                                          ;;                   ;
                      dw CODE_03A441                      ;;A330|A32C/A32C\A32C;
                      dw CODE_03A6F8                      ;;A332|A32E/A32E\A32E;
                      dw CODE_03A84B                      ;;A334|A330/A330\A330;
                      dw CODE_03A7AD                      ;;A336|A332/A332\A332;
                      dw CODE_03AB9F                      ;;A338|A334/A334\A334;
                      dw CODE_03ABBE                      ;;A33A|A336/A336\A336;
                      dw CODE_03AC03                      ;;A33C|A338/A338\A338;
                      dw CODE_03A49C                      ;;A33E|A33A/A33A\A33A;
                      dw CODE_03AB21                      ;;A340|A33C/A33C\A33C;
                      dw CODE_03AB64                      ;;A342|A33E/A33E\A33E;
                                                          ;;                   ;
Return03A340:         RTS                                 ;;A344|A340/A340\A340; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A341:          db $D5,$DD,$23,$2B,$D5,$DD,$23,$2B  ;;A345|A341/A341\A341;
                      db $D5,$DD,$23,$2B,$D5,$DD,$23,$2B  ;;A34D|A349/A349\A349;
                      db $D6,$DE,$22,$2A,$D6,$DE,$22,$2A  ;;A355|A351/A351\A351;
                      db $D7,$DF,$21,$29,$D7,$DF,$21,$29  ;;A35D|A359/A359\A359;
                      db $D8,$E0,$20,$28,$D8,$E0,$20,$28  ;;A365|A361/A361\A361;
                      db $DA,$E2,$1E,$26,$DA,$E2,$1E,$26  ;;A36D|A369/A369\A369;
                      db $DC,$E4,$1C,$24,$DC,$E4,$1C,$24  ;;A375|A371/A371\A371;
                      db $E0,$E8,$18,$20,$E0,$E8,$18,$20  ;;A37D|A379/A379\A379;
                      db $E8,$F0,$10,$18,$E8,$F0,$10,$18  ;;A385|A381/A381\A381;
DATA_03A389:          db $DD,$D5,$D5,$DD,$23,$2B,$2B,$23  ;;A38D|A389/A389\A389;
                      db $DD,$D5,$D5,$DD,$23,$2B,$2B,$23  ;;A395|A391/A391\A391;
                      db $DE,$D6,$D6,$DE,$22,$2A,$2A,$22  ;;A39D|A399/A399\A399;
                      db $DF,$D7,$D7,$DF,$21,$29,$29,$21  ;;A3A5|A3A1/A3A1\A3A1;
                      db $E0,$D8,$D8,$E0,$20,$28,$28,$20  ;;A3AD|A3A9/A3A9\A3A9;
                      db $E2,$DA,$DA,$E2,$1E,$26,$26,$1E  ;;A3B5|A3B1/A3B1\A3B1;
                      db $E4,$DC,$DC,$E4,$1C,$24,$24,$1C  ;;A3BD|A3B9/A3B9\A3B9;
                      db $E8,$E0,$E0,$E8,$18,$20,$20,$18  ;;A3C5|A3C1/A3C1\A3C1;
                      db $F0,$E8,$E8,$F0,$10,$18,$18,$10  ;;A3CD|A3C9/A3C9\A3C9;
DATA_03A3D1:          db $80,$40,$00,$C0,$00,$C0,$80,$40  ;;A3D5|A3D1/A3D1\A3D1;
DATA_03A3D9:          db $E3,$ED,$ED,$EB,$EB,$E9,$E9,$E7  ;;A3DD|A3D9/A3D9\A3D9;
                      db $E7                              ;;A3E5|A3E1/A3E1\A3E1;
                                                          ;;                   ;
CODE_03A3E2:          JSR GetDrawInfoBnk3                 ;;A3E6|A3E2/A3E2\A3E2;
                      LDA.W !SpriteMisc1564,X             ;;A3E9|A3E5/A3E5\A3E5;
                      DEC A                               ;;A3EC|A3E8/A3E8\A3E8;
                      LSR A                               ;;A3ED|A3E9/A3E9\A3E9;
                      STA.B !_3                           ;;A3EE|A3EA/A3EA\A3EA;
                      ASL A                               ;;A3F0|A3EC/A3EC\A3EC;
                      ASL A                               ;;A3F1|A3ED/A3ED\A3ED;
                      ASL A                               ;;A3F2|A3EE/A3EE\A3EE;
                      STA.B !_2                           ;;A3F3|A3EF/A3EF\A3EF;
                      LDA.B #$70                          ;;A3F5|A3F1/A3F1\A3F1;
                      STA.W !SpriteOAMIndex,X             ;;A3F7|A3F3/A3F3\A3F3;
                      TAY                                 ;;A3FA|A3F6/A3F6\A3F6;
                      PHX                                 ;;A3FB|A3F7/A3F7\A3F7;
                      LDX.B #$07                          ;;A3FC|A3F8/A3F8\A3F8;
                    - PHX                                 ;;A3FE|A3FA/A3FA\A3FA;
                      TXA                                 ;;A3FF|A3FB/A3FB\A3FB;
                      ORA.B !_2                           ;;A400|A3FC/A3FC\A3FC;
                      TAX                                 ;;A402|A3FE/A3FE\A3FE;
                      LDA.B !_0                           ;;A403|A3FF/A3FF\A3FF;
                      CLC                                 ;;A405|A401/A401\A401;
                      ADC.W DATA_03A341,X                 ;;A406|A402/A402\A402;
                      CLC                                 ;;A409|A405/A405\A405;
                      ADC.B #$08                          ;;A40A|A406/A406\A406;
                      STA.W !OAMTileXPos+$100,Y           ;;A40C|A408/A408\A408;
                      LDA.B !_1                           ;;A40F|A40B/A40B\A40B;
                      CLC                                 ;;A411|A40D/A40D\A40D;
                      ADC.W DATA_03A389,X                 ;;A412|A40E/A40E\A40E;
                      CLC                                 ;;A415|A411/A411\A411;
                      ADC.B #$30                          ;;A416|A412/A412\A412;
                      STA.W !OAMTileYPos+$100,Y           ;;A418|A414/A414\A414;
                      LDX.B !_3                           ;;A41B|A417/A417\A417;
                      LDA.W DATA_03A3D9,X                 ;;A41D|A419/A419\A419;
                      STA.W !OAMTileNo+$100,Y             ;;A420|A41C/A41C\A41C;
                      PLX                                 ;;A423|A41F/A41F\A41F;
                      LDA.W DATA_03A3D1,X                 ;;A424|A420/A420\A420;
                      STA.W !OAMTileAttr+$100,Y           ;;A427|A423/A423\A423;
                      INY                                 ;;A42A|A426/A426\A426;
                      INY                                 ;;A42B|A427/A427\A427;
                      INY                                 ;;A42C|A428/A428\A428;
                      INY                                 ;;A42D|A429/A429\A429;
                      DEX                                 ;;A42E|A42A/A42A\A42A;
                      BPL -                               ;;A42F|A42B/A42B\A42B;
                      PLX                                 ;;A431|A42D/A42D\A42D;
                      LDY.B #$02                          ;;A432|A42E/A42E\A42E;
                      LDA.B #$07                          ;;A434|A430/A430\A430;
                      JSL FinishOAMWrite                  ;;A436|A432/A432\A432;
                      RTS                                 ;;A43A|A436/A436\A436; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A437:          db $00,$00,$00,$00,$02,$04,$06,$08  ;;A43B|A437/A437\A437;
                      db $0A,$0E                          ;;A443|A43F/A43F\A43F;
                                                          ;;                   ;
CODE_03A441:          LDA.W !SpriteMisc154C,X             ;;A445|A441/A441\A441;
                      BNE CODE_03A482                     ;;A448|A444/A444\A444;
                      LDA.W !SpriteMisc1540,X             ;;A44A|A446/A446\A446;
                      BNE CODE_03A465                     ;;A44D|A449/A449\A449;
                      LDA.B #$0E                          ;;A44F|A44B/A44B\A44B;
                      STA.W !SpriteMisc1570,X             ;;A451|A44D/A44D\A44D;
                      LDA.B #con($04,$04,$05,$05)         ;;A454|A450/A450\A450;
                      STA.B !SpriteYSpeed,X               ;;A456|A452/A452\A452;
                      STZ.B !SpriteXSpeed,X               ;;A458|A454/A454\A454; Sprite X Speed = 0 
                      LDA.B !SpriteYPosLow,X              ;;A45A|A456/A456\A456;
                      SEC                                 ;;A45C|A458/A458\A458;
                      SBC.B !Layer1YPos                   ;;A45D|A459/A459\A459;
                      CMP.B #$10                          ;;A45F|A45B/A45B\A45B;
                      BNE +                               ;;A461|A45D/A45D\A45D;
                      LDA.B #$A4                          ;;A463|A45F/A45F\A45F;
                      STA.W !SpriteMisc1540,X             ;;A465|A461/A461\A461;
                    + RTS                                 ;;A468|A464/A464\A464; Return 
                                                          ;;                   ;
CODE_03A465:          STZ.B !SpriteYSpeed,X               ;;A469|A465/A465\A465; Sprite Y Speed = 0 
                      STZ.B !SpriteXSpeed,X               ;;A46B|A467/A467\A467; Sprite X Speed = 0 
                      CMP.B #$01                          ;;A46D|A469/A469\A469;
                      BEQ CODE_03A47C                     ;;A46F|A46B/A46B\A46B;
                      CMP.B #$40                          ;;A471|A46D/A46D\A46D;
                      BCS +                               ;;A473|A46F/A46F\A46F;
                      LSR A                               ;;A475|A471/A471\A471;
                      LSR A                               ;;A476|A472/A472\A472;
                      LSR A                               ;;A477|A473/A473\A473;
                      TAY                                 ;;A478|A474/A474\A474;
                      LDA.W DATA_03A437,Y                 ;;A479|A475/A475\A475;
                      STA.W !SpriteMisc1570,X             ;;A47C|A478/A478\A478;
                    + RTS                                 ;;A47F|A47B/A47B\A47B; Return 
                                                          ;;                   ;
CODE_03A47C:          LDA.B #con($24,$24,$15,$15)         ;;A480|A47C/A47C\A47C;
                      STA.W !SpriteMisc154C,X             ;;A482|A47E/A47E\A47E;
                      RTS                                 ;;A485|A481/A481\A481; Return 
                                                          ;;                   ;
CODE_03A482:          DEC A                               ;;A486|A482/A482\A482;
                      BNE +                               ;;A487|A483/A483\A483;
                      LDA.B #$07                          ;;A489|A485/A485\A485;
                      STA.W !SpriteMisc151C,X             ;;A48B|A487/A487\A487;
                      LDA.B #$78                          ;;A48E|A48A/A48A\A48A;
                      STA.W !BrSwingCenterXPos            ;;A490|A48C/A48C\A48C;
                    + RTS                                 ;;A493|A48F/A48F\A48F; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A490:          db $FF,$01                          ;;A494|A490/A490\A490;
                                                          ;;                   ;
DATA_03A492:          db $C8,$38                          ;;A496|A492/A492\A492;
                                                          ;;                   ;
DATA_03A494:          db $01,$FF                          ;;A498|A494/A494\A494;
                                                          ;;                   ;
DATA_03A496:          db $1C,$E4                          ;;A49A|A496/A496\A496;
                                                          ;;                   ;
DATA_03A498:          db $00,$02,$04,$02                  ;;A49C|A498/A498\A498;
                                                          ;;                   ;
CODE_03A49C:          JSR CODE_03A4D2                     ;;A4A0|A49C/A49C\A49C;
                      JSR CODE_03A4FD                     ;;A4A3|A49F/A49F\A49F;
                      JSR CODE_03A4ED                     ;;A4A6|A4A2/A4A2\A4A2;
                      LDA.W !SpriteMisc1528,X             ;;A4A9|A4A5/A4A5\A4A5;
                      AND.B #$01                          ;;A4AC|A4A8/A4A8\A4A8;
                      TAY                                 ;;A4AE|A4AA/A4AA\A4AA;
                      LDA.B !SpriteXSpeed,X               ;;A4AF|A4AB/A4AB\A4AB;
                      CLC                                 ;;A4B1|A4AD/A4AD\A4AD;
                      ADC.W DATA_03A490,Y                 ;;A4B2|A4AE/A4AE\A4AE;
                      STA.B !SpriteXSpeed,X               ;;A4B5|A4B1/A4B1\A4B1;
                      CMP.W DATA_03A492,Y                 ;;A4B7|A4B3/A4B3\A4B3;
                      BNE +                               ;;A4BA|A4B6/A4B6\A4B6;
                      INC.W !SpriteMisc1528,X             ;;A4BC|A4B8/A4B8\A4B8;
                    + LDA.W !SpriteMisc1534,X             ;;A4BF|A4BB/A4BB\A4BB;
                      AND.B #$01                          ;;A4C2|A4BE/A4BE\A4BE;
                      TAY                                 ;;A4C4|A4C0/A4C0\A4C0;
                      LDA.B !SpriteYSpeed,X               ;;A4C5|A4C1/A4C1\A4C1;
                      CLC                                 ;;A4C7|A4C3/A4C3\A4C3;
                      ADC.W DATA_03A494,Y                 ;;A4C8|A4C4/A4C4\A4C4;
                      STA.B !SpriteYSpeed,X               ;;A4CB|A4C7/A4C7\A4C7;
                      CMP.W DATA_03A496,Y                 ;;A4CD|A4C9/A4C9\A4C9;
                      BNE +                               ;;A4D0|A4CC/A4CC\A4CC;
                      INC.W !SpriteMisc1534,X             ;;A4D2|A4CE/A4CE\A4CE;
                    + RTS                                 ;;A4D5|A4D1/A4D1\A4D1; Return 
                                                          ;;                   ;
CODE_03A4D2:          LDY.B #$00                          ;;A4D6|A4D2/A4D2\A4D2;
                      LDA.B !TrueFrame                    ;;A4D8|A4D4/A4D4\A4D4;
                      AND.B #$E0                          ;;A4DA|A4D6/A4D6\A4D6;
                      BNE +                               ;;A4DC|A4D8/A4D8\A4D8;
                      LDA.B !TrueFrame                    ;;A4DE|A4DA/A4DA\A4DA;
                      AND.B #$18                          ;;A4E0|A4DC/A4DC\A4DC;
                      LSR A                               ;;A4E2|A4DE/A4DE\A4DE;
                      LSR A                               ;;A4E3|A4DF/A4DF\A4DF;
                      LSR A                               ;;A4E4|A4E0/A4E0\A4E0;
                      TAY                                 ;;A4E5|A4E1/A4E1\A4E1;
                      LDA.W DATA_03A498,Y                 ;;A4E6|A4E2/A4E2\A4E2;
                      TAY                                 ;;A4E9|A4E5/A4E5\A4E5;
                    + TYA                                 ;;A4EA|A4E6/A4E6\A4E6;
                      STA.W !SpriteMisc1570,X             ;;A4EB|A4E7/A4E7\A4E7;
                      RTS                                 ;;A4EE|A4EA/A4EA\A4EA; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A4EB:          db $80,$00                          ;;A4EF|A4EB/A4EB\A4EB;
                                                          ;;                   ;
CODE_03A4ED:          LDA.B !TrueFrame                    ;;A4F1|A4ED/A4ED\A4ED;
                      AND.B #$1F                          ;;A4F3|A4EF/A4EF\A4EF;
                      BNE +                               ;;A4F5|A4F1/A4F1\A4F1;
                      JSR SubHorzPosBnk3                  ;;A4F7|A4F3/A4F3\A4F3;
                      LDA.W DATA_03A4EB,Y                 ;;A4FA|A4F6/A4F6\A4F6;
                      STA.W !SpriteMisc157C,X             ;;A4FD|A4F9/A4F9\A4F9;
                    + RTS                                 ;;A500|A4FC/A4FC\A4FC; Return 
                                                          ;;                   ;
CODE_03A4FD:          LDA.W !BrSwingCenterXPos            ;;A501|A4FD/A4FD\A4FD;
                      BNE Return03A52C                    ;;A504|A500/A500\A500;
                      LDA.W !SpriteMisc151C,X             ;;A506|A502/A502\A502;
                      CMP.B #$08                          ;;A509|A505/A505\A505;
                      BNE CODE_03A51A                     ;;A50B|A507/A507\A507;
                      INC.W !BrSwingPlatXPos              ;;A50D|A509/A509\A509;
                      LDA.W !BrSwingPlatXPos              ;;A510|A50C/A50C\A50C;
                      CMP.B #$03                          ;;A513|A50F/A50F\A50F;
                      BEQ CODE_03A51A                     ;;A515|A511/A511\A511;
                      LDA.B #$FF                          ;;A517|A513/A513\A513;
                      STA.W !BrSwingYDist                 ;;A519|A515/A515\A515;
                      BRA Return03A52C                    ;;A51C|A518/A518\A518;
                                                          ;;                   ;
CODE_03A51A:          STZ.W !BrSwingPlatXPos              ;;A51E|A51A/A51A\A51A;
                      LDA.W !SpriteStatus                 ;;A521|A51D/A51D\A51D;
                      BEQ CODE_03A527                     ;;A524|A520/A520\A520;
                      LDA.W !SpriteStatus+1               ;;A526|A522/A522\A522;
                      BNE Return03A52C                    ;;A529|A525/A525\A525;
CODE_03A527:          LDA.B #$FF                          ;;A52B|A527/A527\A527;
                      STA.W !BrSwingCenterXPos+1          ;;A52D|A529/A529\A529;
Return03A52C:         RTS                                 ;;A530|A52C/A52C\A52C; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A52D:          db $00,$00,$00,$00,$00,$00,$00,$00  ;;A531|A52D/A52D\A52D;
                      db $00,$02,$04,$06,$08,$0A,$0E,$0E  ;;A539|A535/A535\A535;
                      db $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E  ;;A541|A53D/A53D\A53D;
                      db $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E  ;;A549|A545/A545\A545;
                      db $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E  ;;A551|A54D/A54D\A54D;
                      db $0E,$0E,$0A,$08,$06,$04,$02,$00  ;;A559|A555/A555\A555;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;A561|A55D/A55D\A55D;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;A569|A565/A565\A565;
DATA_03A56D:          db $00,$00,$00,$00,$00,$00,$00,$00  ;;A571|A56D/A56D\A56D;
                      db $00,$00,$10,$20,$30,$40,$50,$60  ;;A579|A575/A575\A575;
                      db $80,$A0,$C0,$E0,$FF,$FF,$FF,$FF  ;;A581|A57D/A57D\A57D;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;A589|A585/A585\A585;
                      db $FF,$FF,$FF,$FF,$FF,$C0,$80,$60  ;;A591|A58D/A58D\A58D;
                      db $40,$30,$20,$10,$00,$00,$00,$00  ;;A599|A595/A595\A595;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;A5A1|A59D/A59D\A59D;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;A5A9|A5A5/A5A5\A5A5;
                                                          ;;                   ;
CODE_03A5AD:          LDA.W !BrSwingCenterXPos+1          ;;A5B1|A5AD/A5AD\A5AD;
                      BEQ CODE_03A5D8                     ;;A5B4|A5B0/A5B0\A5B0;
                      DEC.W !BrSwingCenterXPos+1          ;;A5B6|A5B2/A5B2\A5B2;
                      BNE +                               ;;A5B9|A5B5/A5B5\A5B5;
                      LDA.B #$54                          ;;A5BB|A5B7/A5B7\A5B7;
                      STA.W !BrSwingCenterXPos            ;;A5BD|A5B9/A5B9\A5B9;
                      RTS                                 ;;A5C0|A5BC/A5BC\A5BC; Return 
                                                          ;;                   ;
                    + LSR A                               ;;A5C1|A5BD/A5BD\A5BD;
                      LSR A                               ;;A5C2|A5BE/A5BE\A5BE;
                      TAY                                 ;;A5C3|A5BF/A5BF\A5BF;
                      LDA.W DATA_03A52D,Y                 ;;A5C4|A5C0/A5C0\A5C0;
                      STA.W !SpriteMisc1570,X             ;;A5C7|A5C3/A5C3\A5C3;
                      LDA.W !BrSwingCenterXPos+1          ;;A5CA|A5C6/A5C6\A5C6;
                      CMP.B #$80                          ;;A5CD|A5C9/A5C9\A5C9;
                      BNE +                               ;;A5CF|A5CB/A5CB\A5CB;
                      JSR CODE_03B019                     ;;A5D1|A5CD/A5CD\A5CD;
                      LDA.B #$08                          ;;A5D4|A5D0/A5D0\A5D0; \ Play sound effect 
                      STA.W !SPCIO3                       ;;A5D6|A5D2/A5D2\A5D2; / 
                    + PLA                                 ;;A5D9|A5D5/A5D5\A5D5;
                      PLA                                 ;;A5DA|A5D6/A5D6\A5D6;
                      RTS                                 ;;A5DB|A5D7/A5D7\A5D7; Return 
                                                          ;;                   ;
CODE_03A5D8:          LDA.W !BrSwingYDist                 ;;A5DC|A5D8/A5D8\A5D8;
                      BEQ Return03A60D                    ;;A5DF|A5DB/A5DB\A5DB;
                      DEC.W !BrSwingYDist                 ;;A5E1|A5DD/A5DD\A5DD;
                      BEQ CODE_03A60E                     ;;A5E4|A5E0/A5E0\A5E0;
                      LSR A                               ;;A5E6|A5E2/A5E2\A5E2;
                      LSR A                               ;;A5E7|A5E3/A5E3\A5E3;
                      TAY                                 ;;A5E8|A5E4/A5E4\A5E4;
                      LDA.W DATA_03A52D,Y                 ;;A5E9|A5E5/A5E5\A5E5;
                      STA.W !SpriteMisc1570,X             ;;A5EC|A5E8/A5E8\A5E8;
                      LDA.W DATA_03A56D,Y                 ;;A5EF|A5EB/A5EB\A5EB;
                      STA.B !Mode7Angle                   ;;A5F2|A5EE/A5EE\A5EE;
                      STZ.B !Mode7Angle+1                 ;;A5F4|A5F0/A5F0\A5F0;
                      CMP.B #$FF                          ;;A5F6|A5F2/A5F2\A5F2;
                      BNE +                               ;;A5F8|A5F4/A5F4\A5F4;
                      STZ.B !Mode7Angle                   ;;A5FA|A5F6/A5F6\A5F6;
                      INC.B !Mode7Angle+1                 ;;A5FC|A5F8/A5F8\A5F8;
                      STZ.B !SpriteProperties             ;;A5FE|A5FA/A5FA\A5FA;
                    + LDA.W !BrSwingYDist                 ;;A600|A5FC/A5FC\A5FC;
                      CMP.B #$80                          ;;A603|A5FF/A5FF\A5FF;
                      BNE +                               ;;A605|A601/A601\A601;
                      LDA.B #$09                          ;;A607|A603/A603\A603; \ Play sound effect 
                      STA.W !SPCIO3                       ;;A609|A605/A605\A605; / 
                      JSR CODE_03A61D                     ;;A60C|A608/A608\A608;
                    + PLA                                 ;;A60F|A60B/A60B\A60B;
                      PLA                                 ;;A610|A60C/A60C\A60C;
Return03A60D:         RTS                                 ;;A611|A60D/A60D\A60D; Return 
                                                          ;;                   ;
CODE_03A60E:          LDA.B #$60                          ;;A612|A60E/A60E\A60E;
                      LDY.W !BrSwingPlatXPos              ;;A614|A610/A610\A610;
                      CPY.B #$02                          ;;A617|A613/A613\A613;
                      BEQ +                               ;;A619|A615/A615\A615;
                      LDA.B #$20                          ;;A61B|A617/A617\A617;
                    + STA.W !BrSwingCenterXPos            ;;A61D|A619/A619\A619;
                      RTS                                 ;;A620|A61C/A61C\A61C; Return 
                                                          ;;                   ;
CODE_03A61D:          LDA.B #$08                          ;;A621|A61D/A61D\A61D;
                      STA.W !SpriteStatus+8               ;;A623|A61F/A61F\A61F;
                      LDA.B #$A1                          ;;A626|A622/A622\A622;
                      STA.B !SpriteNumber+8               ;;A628|A624/A624\A624;
                      LDA.B !SpriteXPosLow,X              ;;A62A|A626/A626\A626;
                      CLC                                 ;;A62C|A628/A628\A628;
                      ADC.B #$08                          ;;A62D|A629/A629\A629;
                      STA.B !SpriteXPosLow+8              ;;A62F|A62B/A62B\A62B;
                      LDA.W !SpriteYPosHigh,X             ;;A631|A62D/A62D\A62D;
                      ADC.B #$00                          ;;A634|A630/A630\A630;
                      STA.W !SpriteYPosHigh+8             ;;A636|A632/A632\A632;
                      LDA.B !SpriteYPosLow,X              ;;A639|A635/A635\A635;
                      CLC                                 ;;A63B|A637/A637\A637;
                      ADC.B #$40                          ;;A63C|A638/A638\A638;
                      STA.B !SpriteYPosLow+8              ;;A63E|A63A/A63A\A63A;
                      LDA.W !SpriteXPosHigh,X             ;;A640|A63C/A63C\A63C;
                      ADC.B #$00                          ;;A643|A63F/A63F\A63F;
                      STA.W !SpriteXPosHigh+8             ;;A645|A641/A641\A641;
                      PHX                                 ;;A648|A644/A644\A644;
                      LDX.B #$08                          ;;A649|A645/A645\A645;
                      JSL InitSpriteTables                ;;A64B|A647/A647\A647;
                      PLX                                 ;;A64F|A64B/A64B\A64B;
                      RTS                                 ;;A650|A64C/A64C\A64C; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A64D:          db $00,$00,$00,$00,$FC,$F8,$F4,$F0  ;;A651|A64D/A64D\A64D;
                      db $F4,$F8,$FC,$00,$04,$08,$0C,$10  ;;A659|A655/A655\A655;
                      db $0C,$08,$04,$00                  ;;A661|A65D/A65D\A65D;
                                                          ;;                   ;
CODE_03A661:          LDA.W !BrSwingXDist+1               ;;A665|A661/A661\A661;
                      BEQ Return03A6BF                    ;;A668|A664/A664\A664;
                      STZ.W !BrSwingCenterXPos+1          ;;A66A|A666/A666\A666;
                      STZ.W !BrSwingYDist                 ;;A66D|A669/A669\A669;
                      DEC.W !BrSwingXDist+1               ;;A670|A66C/A66C\A66C;
                      BNE CODE_03A691                     ;;A673|A66F/A66F\A66F;
                      LDA.B #$50                          ;;A675|A671/A671\A671;
                      STA.W !BrSwingCenterXPos            ;;A677|A673/A673\A673;
                      DEC.W !SpriteMisc187B,X             ;;A67A|A676/A676\A676;
                      BNE CODE_03A691                     ;;A67D|A679/A679\A679;
                      LDA.W !SpriteMisc151C,X             ;;A67F|A67B/A67B\A67B;
                      CMP.B #$09                          ;;A682|A67E/A67E\A67E;
                      BEQ CODE_03A6C0                     ;;A684|A680/A680\A680;
                      LDA.B #$02                          ;;A686|A682/A682\A682;
                      STA.W !SpriteMisc187B,X             ;;A688|A684/A684\A684;
                      LDA.B #$01                          ;;A68B|A687/A687\A687;
                      STA.W !SpriteMisc151C,X             ;;A68D|A689/A689\A689;
                      LDA.B #$80                          ;;A690|A68C/A68C\A68C;
                      STA.W !SpriteMisc1540,X             ;;A692|A68E/A68E\A68E;
CODE_03A691:          PLY                                 ;;A695|A691/A691\A691;
                      PLY                                 ;;A696|A692/A692\A692;
                      PHA                                 ;;A697|A693/A693\A693;
                      LDA.W !BrSwingXDist+1               ;;A698|A694/A694\A694;
                      LSR A                               ;;A69B|A697/A697\A697;
                      LSR A                               ;;A69C|A698/A698\A698;
                      TAY                                 ;;A69D|A699/A699\A699;
                      LDA.W DATA_03A64D,Y                 ;;A69E|A69A/A69A\A69A;
                      STA.B !Mode7Angle                   ;;A6A1|A69D/A69D\A69D;
                      STZ.B !Mode7Angle+1                 ;;A6A3|A69F/A69F\A69F;
                      BPL +                               ;;A6A5|A6A1/A6A1\A6A1;
                      INC.B !Mode7Angle+1                 ;;A6A7|A6A3/A6A3\A6A3;
                    + PLA                                 ;;A6A9|A6A5/A6A5\A6A5;
                      LDY.B #$0C                          ;;A6AA|A6A6/A6A6\A6A6;
                      CMP.B #$40                          ;;A6AC|A6A8/A6A8\A6A8;
                      BCS +                               ;;A6AE|A6AA/A6AA\A6AA;
CODE_03A6AC:          LDA.B !TrueFrame                    ;;A6B0|A6AC/A6AC\A6AC;
                      LDY.B #$10                          ;;A6B2|A6AE/A6AE\A6AE;
                      AND.B #$04                          ;;A6B4|A6B0/A6B0\A6B0;
                      BEQ +                               ;;A6B6|A6B2/A6B2\A6B2;
                      LDY.B #$12                          ;;A6B8|A6B4/A6B4\A6B4;
                    + TYA                                 ;;A6BA|A6B6/A6B6\A6B6;
                      STA.W !SpriteMisc1570,X             ;;A6BB|A6B7/A6B7\A6B7;
                      LDA.B #$02                          ;;A6BE|A6BA/A6BA\A6BA;
                      STA.W !ClownCarImage                ;;A6C0|A6BC/A6BC\A6BC;
Return03A6BF:         RTS                                 ;;A6C3|A6BF/A6BF\A6BF; Return 
                                                          ;;                   ;
CODE_03A6C0:          LDA.B #$04                          ;;A6C4|A6C0/A6C0\A6C0;
                      STA.W !SpriteMisc151C,X             ;;A6C6|A6C2/A6C2\A6C2;
                      STZ.B !SpriteXSpeed,X               ;;A6C9|A6C5/A6C5\A6C5; Sprite X Speed = 0 
                      RTS                                 ;;A6CB|A6C7/A6C7\A6C7; Return 
                                                          ;;                   ;
KillMostSprites:      LDY.B #$09                          ;;A6CC|A6C8/A6C8\A6C8;
CODE_03A6CA:          LDA.W !SpriteStatus,Y               ;;A6CE|A6CA/A6CA\A6CA;
                      BEQ +                               ;;A6D1|A6CD/A6CD\A6CD;
                      LDA.W !SpriteNumber,Y               ;;A6D3|A6CF/A6CF\A6CF;
                      CMP.B #$A9                          ;;A6D6|A6D2/A6D2\A6D2;
                      BEQ +                               ;;A6D8|A6D4/A6D4\A6D4;
                      CMP.B #$29                          ;;A6DA|A6D6/A6D6\A6D6;
                      BEQ +                               ;;A6DC|A6D8/A6D8\A6D8;
                      CMP.B #$A0                          ;;A6DE|A6DA/A6DA\A6DA;
                      BEQ +                               ;;A6E0|A6DC/A6DC\A6DC;
                      CMP.B #$C5                          ;;A6E2|A6DE/A6DE\A6DE;
                      BEQ +                               ;;A6E4|A6E0/A6E0\A6E0;
                      LDA.B #$04                          ;;A6E6|A6E2/A6E2\A6E2; \ Sprite status = Killed by spin jump 
                      STA.W !SpriteStatus,Y               ;;A6E8|A6E4/A6E4\A6E4; / 
                      LDA.B #$1F                          ;;A6EB|A6E7/A6E7\A6E7; \ Time to show cloud of smoke = #$1F 
                      STA.W !SpriteMisc1540,Y             ;;A6ED|A6E9/A6E9\A6E9; / 
                    + DEY                                 ;;A6F0|A6EC/A6EC\A6EC;
                      BPL CODE_03A6CA                     ;;A6F1|A6ED/A6ED\A6ED;
                      RTL                                 ;;A6F3|A6EF/A6EF\A6EF; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A6F0:          db $0E,$0E,$0A,$08,$06,$04,$02,$00  ;;A6F4|A6F0/A6F0\A6F0;
                                                          ;;                   ;
CODE_03A6F8:          LDA.W !SpriteMisc1540,X             ;;A6FC|A6F8/A6F8\A6F8;
                      BEQ CODE_03A731                     ;;A6FF|A6FB/A6FB\A6FB;
                      CMP.B #$01                          ;;A701|A6FD/A6FD\A6FD;
                      BNE +                               ;;A703|A6FF/A6FF\A6FF;
                      LDY.B #$17                          ;;A705|A701/A701\A701;
                      STY.W !SPCIO2                       ;;A707|A703/A703\A703; / Change music 
                    + LSR A                               ;;A70A|A706/A706\A706;
                      LSR A                               ;;A70B|A707/A707\A707;
                      LSR A                               ;;A70C|A708/A708\A708;
                      LSR A                               ;;A70D|A709/A709\A709;
                      TAY                                 ;;A70E|A70A/A70A\A70A;
                      LDA.W DATA_03A6F0,Y                 ;;A70F|A70B/A70B\A70B;
                      STA.W !SpriteMisc1570,X             ;;A712|A70E/A70E\A70E;
                      STZ.B !SpriteXSpeed,X               ;;A715|A711/A711\A711; Sprite X Speed = 0 
                      STZ.B !SpriteYSpeed,X               ;;A717|A713/A713\A713; Sprite Y Speed = 0 
                      STZ.W !SpriteMisc1528,X             ;;A719|A715/A715\A715;
                      STZ.W !SpriteMisc1534,X             ;;A71C|A718/A718\A718;
                      STZ.W !BrSwingCenterYPos            ;;A71F|A71B/A71B\A71B;
                      RTS                                 ;;A722|A71E/A71E\A71E; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A71F:          db $01,$FF                          ;;A723|A71F/A71F\A71F;
                                                          ;;                   ;
DATA_03A721:          db $10,$80                          ;;A725|A721/A721\A721;
                                                          ;;                   ;
DATA_03A723:          db $07,$03                          ;;A727|A723/A723\A723;
                                                          ;;                   ;
DATA_03A725:          db $FF,$01                          ;;A729|A725/A725\A725;
                                                          ;;                   ;
DATA_03A727:          db $F0,$08                          ;;A72B|A727/A727\A727;
                                                          ;;                   ;
DATA_03A729:          db $01,$FF                          ;;A72D|A729/A729\A729;
                                                          ;;                   ;
DATA_03A72B:          db $03,$03                          ;;A72F|A72B/A72B\A72B;
                                                          ;;                   ;
DATA_03A72D:          db $60,$02                          ;;A731|A72D/A72D\A72D;
                                                          ;;                   ;
DATA_03A72F:          db $01,$01                          ;;A733|A72F/A72F\A72F;
                                                          ;;                   ;
CODE_03A731:          LDY.W !SpriteMisc1528,X             ;;A735|A731/A731\A731;
                      CPY.B #$02                          ;;A738|A734/A734\A734;
                      BCS +                               ;;A73A|A736/A736\A736;
                      LDA.B !TrueFrame                    ;;A73C|A738/A738\A738;
                      AND.W DATA_03A723,Y                 ;;A73E|A73A/A73A\A73A;
                      BNE +                               ;;A741|A73D/A73D\A73D;
                      LDA.B !SpriteXSpeed,X               ;;A743|A73F/A73F\A73F;
                      CLC                                 ;;A745|A741/A741\A741;
                      ADC.W DATA_03A71F,Y                 ;;A746|A742/A742\A742;
                      STA.B !SpriteXSpeed,X               ;;A749|A745/A745\A745;
                      CMP.W DATA_03A721,Y                 ;;A74B|A747/A747\A747;
                      BNE +                               ;;A74E|A74A/A74A\A74A;
                      INC.W !SpriteMisc1528,X             ;;A750|A74C/A74C\A74C;
                    + LDY.W !SpriteMisc1534,X             ;;A753|A74F/A74F\A74F;
                      CPY.B #$02                          ;;A756|A752/A752\A752;
                      BCS +                               ;;A758|A754/A754\A754;
                      LDA.B !TrueFrame                    ;;A75A|A756/A756\A756;
                      AND.W DATA_03A72B,Y                 ;;A75C|A758/A758\A758;
                      BNE +                               ;;A75F|A75B/A75B\A75B;
                      LDA.B !SpriteYSpeed,X               ;;A761|A75D/A75D\A75D;
                      CLC                                 ;;A763|A75F/A75F\A75F;
                      ADC.W DATA_03A725,Y                 ;;A764|A760/A760\A760;
                      STA.B !SpriteYSpeed,X               ;;A767|A763/A763\A763;
                      CMP.W DATA_03A727,Y                 ;;A769|A765/A765\A765;
                      BNE +                               ;;A76C|A768/A768\A768;
                      INC.W !SpriteMisc1534,X             ;;A76E|A76A/A76A\A76A;
                    + LDY.W !BrSwingCenterYPos            ;;A771|A76D/A76D\A76D;
                      CPY.B #$02                          ;;A774|A770/A770\A770;
                      BEQ CODE_03A794                     ;;A776|A772/A772\A772;
                      LDA.B !TrueFrame                    ;;A778|A774/A774\A774;
                      AND.W DATA_03A72F,Y                 ;;A77A|A776/A776\A776;
                      BNE +                               ;;A77D|A779/A779\A779;
                      LDA.B !Mode7XScale                  ;;A77F|A77B/A77B\A77B;
                      CLC                                 ;;A781|A77D/A77D\A77D;
                      ADC.W DATA_03A729,Y                 ;;A782|A77E/A77E\A77E;
                      STA.B !Mode7XScale                  ;;A785|A781/A781\A781;
                      STA.B !Mode7YScale                  ;;A787|A783/A783\A783;
                      CMP.W DATA_03A72D,Y                 ;;A789|A785/A785\A785;
                      BNE +                               ;;A78C|A788/A788\A788;
                      INC.W !BrSwingCenterYPos            ;;A78E|A78A/A78A\A78A;
                    + LDA.W !SpriteYPosHigh,X             ;;A791|A78D/A78D\A78D;
                      CMP.B #$FE                          ;;A794|A790/A790\A790;
                      BNE +                               ;;A796|A792/A792\A792;
CODE_03A794:          LDA.B #$03                          ;;A798|A794/A794\A794;
                      STA.W !SpriteMisc151C,X             ;;A79A|A796/A796\A796;
                      LDA.B #$80                          ;;A79D|A799/A799\A799;
                      STA.W !BrSwingCenterXPos            ;;A79F|A79B/A79B\A79B;
                      JSL GetRand                         ;;A7A2|A79E/A79E\A79E;
                      AND.B #$F0                          ;;A7A6|A7A2/A7A2\A7A2;
                      STA.W !BrSwingYDist+1               ;;A7A8|A7A4/A7A4\A7A4;
                      LDA.B #$1D                          ;;A7AB|A7A7/A7A7\A7A7;
                      STA.W !SPCIO2                       ;;A7AD|A7A9/A7A9\A7A9; / Change music 
                    + RTS                                 ;;A7B0|A7AC/A7AC\A7AC; Return 
                                                          ;;                   ;
CODE_03A7AD:          LDA.B #$60                          ;;A7B1|A7AD/A7AD\A7AD;
                      STA.B !Mode7XScale                  ;;A7B3|A7AF/A7AF\A7AF;
                      STA.B !Mode7YScale                  ;;A7B5|A7B1/A7B1\A7B1;
                      LDA.B #$FF                          ;;A7B7|A7B3/A7B3\A7B3;
                      STA.W !SpriteYPosHigh,X             ;;A7B9|A7B5/A7B5\A7B5;
                      LDA.B #$60                          ;;A7BC|A7B8/A7B8\A7B8;
                      STA.B !SpriteXPosLow,X              ;;A7BE|A7BA/A7BA\A7BA;
                      LDA.W !BrSwingCenterXPos            ;;A7C0|A7BC/A7BC\A7BC;
                      BNE +                               ;;A7C3|A7BF/A7BF\A7BF;
                      LDA.B #$18                          ;;A7C5|A7C1/A7C1\A7C1;
                      STA.W !SPCIO2                       ;;A7C7|A7C3/A7C3\A7C3; / Change music 
                      LDA.B #$02                          ;;A7CA|A7C6/A7C6\A7C6;
                      STA.W !SpriteMisc151C,X             ;;A7CC|A7C8/A7C8\A7C8;
                      LDA.B #$18                          ;;A7CF|A7CB/A7CB\A7CB;
                      STA.B !SpriteYPosLow,X              ;;A7D1|A7CD/A7CD\A7CD;
                      LDA.B #$00                          ;;A7D3|A7CF/A7CF\A7CF;
                      STA.W !SpriteXPosHigh,X             ;;A7D5|A7D1/A7D1\A7D1;
                      LDA.B #$08                          ;;A7D8|A7D4/A7D4\A7D4;
                      STA.B !Mode7XScale                  ;;A7DA|A7D6/A7D6\A7D6;
                      STA.B !Mode7YScale                  ;;A7DC|A7D8/A7D8\A7D8;
                      LDA.B #$64                          ;;A7DE|A7DA/A7DA\A7DA;
                      STA.B !SpriteXSpeed,X               ;;A7E0|A7DC/A7DC\A7DC;
                      RTS                                 ;;A7E2|A7DE/A7DE\A7DE; Return 
                                                          ;;                   ;
                    + CMP.B #$60                          ;;A7E3|A7DF/A7DF\A7DF;
                      BCS Return03A840                    ;;A7E5|A7E1/A7E1\A7E1;
                      LDA.B !TrueFrame                    ;;A7E7|A7E3/A7E3\A7E3;
                      AND.B #$1F                          ;;A7E9|A7E5/A7E5\A7E5;
                      BNE Return03A840                    ;;A7EB|A7E7/A7E7\A7E7;
                      LDY.B #$07                          ;;A7ED|A7E9/A7E9\A7E9;
CODE_03A7EB:          LDA.W !SpriteStatus,Y               ;;A7EF|A7EB/A7EB\A7EB;
                      BEQ CODE_03A7F6                     ;;A7F2|A7EE/A7EE\A7EE;
                      DEY                                 ;;A7F4|A7F0/A7F0\A7F0;
                      CPY.B #$01                          ;;A7F5|A7F1/A7F1\A7F1;
                      BNE CODE_03A7EB                     ;;A7F7|A7F3/A7F3\A7F3;
                      RTS                                 ;;A7F9|A7F5/A7F5\A7F5; Return 
                                                          ;;                   ;
CODE_03A7F6:          LDA.B #$17                          ;;A7FA|A7F6/A7F6\A7F6; \ Play sound effect 
                      STA.W !SPCIO3                       ;;A7FC|A7F8/A7F8\A7F8; / 
                      LDA.B #$08                          ;;A7FF|A7FB/A7FB\A7FB; \ Sprite status = Normal 
                      STA.W !SpriteStatus,Y               ;;A801|A7FD/A7FD\A7FD; / 
                      LDA.B #$33                          ;;A804|A800/A800\A800;
                      STA.W !SpriteNumber,Y               ;;A806|A802/A802\A802;
                      LDA.W !BrSwingYDist+1               ;;A809|A805/A805\A805;
                      PHA                                 ;;A80C|A808/A808\A808;
                      STA.W !SpriteXPosLow,Y              ;;A80D|A809/A809\A809;
                      CLC                                 ;;A810|A80C/A80C\A80C;
                      ADC.B #$20                          ;;A811|A80D/A80D\A80D;
                      STA.W !BrSwingYDist+1               ;;A813|A80F/A80F\A80F;
                      LDA.B #$00                          ;;A816|A812/A812\A812;
                      STA.W !SpriteYPosHigh,Y             ;;A818|A814/A814\A814;
                      LDA.B #$00                          ;;A81B|A817/A817\A817;
                      STA.W !SpriteYPosLow,Y              ;;A81D|A819/A819\A819;
                      STA.W !SpriteXPosHigh,Y             ;;A820|A81C/A81C\A81C;
                      PHX                                 ;;A823|A81F/A81F\A81F;
                      TYX                                 ;;A824|A820/A820\A820;
                      JSL InitSpriteTables                ;;A825|A821/A821\A821;
                      INC.B !SpriteTableC2,X              ;;A829|A825/A825\A825;
                      ASL.W !SpriteTweakerE,X             ;;A82B|A827/A827\A827;
                      LSR.W !SpriteTweakerE,X             ;;A82E|A82A/A82A\A82A;
                      LDA.B #$39                          ;;A831|A82D/A82D\A82D;
                      STA.W !SpriteTweakerB,X             ;;A833|A82F/A82F\A82F;
                      PLX                                 ;;A836|A832/A832\A832;
                      PLA                                 ;;A837|A833/A833\A833;
                      LSR A                               ;;A838|A834/A834\A834;
                      LSR A                               ;;A839|A835/A835\A835;
                      LSR A                               ;;A83A|A836/A836\A836;
                      LSR A                               ;;A83B|A837/A837\A837;
                      LSR A                               ;;A83C|A838/A838\A838;
                      TAY                                 ;;A83D|A839/A839\A839;
                      LDA.W BowserSound,Y                 ;;A83E|A83A/A83A\A83A;
                      STA.W !SPCIO3                       ;;A841|A83D/A83D\A83D; / Play sound effect 
Return03A840:         RTS                                 ;;A844|A840/A840\A840; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BowserSound:          db $2D                              ;;A845|A841/A841\A841;
                                                          ;;                   ;
BowserSoundMusic:     db $2E,$2F,$30,$31,$32,$33,$34,$19  ;;A846|A842/A842\A842;
                      db $1A                              ;;A84E|A84A/A84A\A84A;
                                                          ;;                   ;
CODE_03A84B:          STZ.B !SpriteYSpeed,X               ;;A84F|A84B/A84B\A84B; Sprite Y Speed = 0 
                      LDA.W !SpriteMisc1540,X             ;;A851|A84D/A84D\A84D;
                      BNE CODE_03A86E                     ;;A854|A850/A850\A850;
                      LDA.B !SpriteXSpeed,X               ;;A856|A852/A852\A852;
                      BEQ +                               ;;A858|A854/A854\A854;
                      DEC.B !SpriteXSpeed,X               ;;A85A|A856/A856\A856;
                    + LDA.B !TrueFrame                    ;;A85C|A858/A858\A858;
                      AND.B #$03                          ;;A85E|A85A/A85A\A85A;
                      BNE +                               ;;A860|A85C/A85C\A85C;
                      INC.B !Mode7XScale                  ;;A862|A85E/A85E\A85E;
                      INC.B !Mode7YScale                  ;;A864|A860/A860\A860;
                      LDA.B !Mode7XScale                  ;;A866|A862/A862\A862;
                      CMP.B #$20                          ;;A868|A864/A864\A864;
                      BNE +                               ;;A86A|A866/A866\A866;
                      LDA.B #$FF                          ;;A86C|A868/A868\A868;
                      STA.W !SpriteMisc1540,X             ;;A86E|A86A/A86A\A86A;
                    + RTS                                 ;;A871|A86D/A86D\A86D; Return 
                                                          ;;                   ;
CODE_03A86E:          CMP.B #$A0                          ;;A872|A86E/A86E\A86E;
                      BNE +                               ;;A874|A870/A870\A870;
                      PHA                                 ;;A876|A872/A872\A872;
                      JSR CODE_03A8D6                     ;;A877|A873/A873\A873;
                      PLA                                 ;;A87A|A876/A876\A876;
                    + STZ.B !SpriteXSpeed,X               ;;A87B|A877/A877\A877; Sprite X Speed = 0 
                      STZ.B !SpriteYSpeed,X               ;;A87D|A879/A879\A879; Sprite Y Speed = 0 
                      CMP.B #$01                          ;;A87F|A87B/A87B\A87B;
                      BEQ CODE_03A89D                     ;;A881|A87D/A87D\A87D;
                      CMP.B #$40                          ;;A883|A87F/A87F\A87F;
                      BCS CODE_03A8AE                     ;;A885|A881/A881\A881;
                      CMP.B #$3F                          ;;A887|A883/A883\A883;
                      BNE +                               ;;A889|A885/A885\A885;
                      PHA                                 ;;A88B|A887/A887\A887;
                      LDY.W !BrSwingXDist                 ;;A88C|A888/A888\A888;
                      LDA.W BowserSoundMusic,Y            ;;A88F|A88B/A88B\A88B;
                      STA.W !SPCIO2                       ;;A892|A88E/A88E\A88E; / Change music 
                      PLA                                 ;;A895|A891/A891\A891;
                    + LSR A                               ;;A896|A892/A892\A892;
                      LSR A                               ;;A897|A893/A893\A893;
                      LSR A                               ;;A898|A894/A894\A894;
                      TAY                                 ;;A899|A895/A895\A895;
                      LDA.W DATA_03A437,Y                 ;;A89A|A896/A896\A896;
                      STA.W !SpriteMisc1570,X             ;;A89D|A899/A899\A899;
                      RTS                                 ;;A8A0|A89C/A89C\A89C; Return 
                                                          ;;                   ;
CODE_03A89D:          LDA.W !BrSwingXDist                 ;;A8A1|A89D/A89D\A89D;
                      INC A                               ;;A8A4|A8A0/A8A0\A8A0;
                      STA.W !SpriteMisc151C,X             ;;A8A5|A8A1/A8A1\A8A1;
                      STZ.B !SpriteXSpeed,X               ;;A8A8|A8A4/A8A4\A8A4; Sprite X Speed = 0 
                      STZ.B !SpriteYSpeed,X               ;;A8AA|A8A6/A8A6\A8A6; Sprite Y Speed = 0 
                      LDA.B #$80                          ;;A8AC|A8A8/A8A8\A8A8;
                      STA.W !BrSwingCenterXPos            ;;A8AE|A8AA/A8AA\A8AA;
                      RTS                                 ;;A8B1|A8AD/A8AD\A8AD; Return 
                                                          ;;                   ;
CODE_03A8AE:          CMP.B #$E8                          ;;A8B2|A8AE/A8AE\A8AE;
                      BNE +                               ;;A8B4|A8B0/A8B0\A8B0;
                      LDY.B #$2A                          ;;A8B6|A8B2/A8B2\A8B2; \ Play sound effect 
                      STY.W !SPCIO0                       ;;A8B8|A8B4/A8B4\A8B4; / 
                    + SEC                                 ;;A8BB|A8B7/A8B7\A8B7;
                      SBC.B #$3F                          ;;A8BC|A8B8/A8B8\A8B8;
                      STA.W !SpriteMisc1594,X             ;;A8BE|A8BA/A8BA\A8BA;
                      RTS                                 ;;A8C1|A8BD/A8BD\A8BD; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A8BE:          db $00,$00,$00,$08,$10,$14,$14,$16  ;;A8C2|A8BE/A8BE\A8BE;
                      db $16,$18,$18,$17,$16,$16,$17,$18  ;;A8CA|A8C6/A8C6\A8C6;
                      db $18,$17,$14,$10,$0C,$08,$04,$00  ;;A8D2|A8CE/A8CE\A8CE;
                                                          ;;                   ;
CODE_03A8D6:          LDY.B #$07                          ;;A8DA|A8D6/A8D6\A8D6;
CODE_03A8D8:          LDA.W !SpriteStatus,Y               ;;A8DC|A8D8/A8D8\A8D8;
                      BEQ CODE_03A8E3                     ;;A8DF|A8DB/A8DB\A8DB;
                      DEY                                 ;;A8E1|A8DD/A8DD\A8DD;
                      CPY.B #$01                          ;;A8E2|A8DE/A8DE\A8DE;
                      BNE CODE_03A8D8                     ;;A8E4|A8E0/A8E0\A8E0;
                      RTS                                 ;;A8E6|A8E2/A8E2\A8E2; Return 
                                                          ;;                   ;
CODE_03A8E3:          LDA.B #$10                          ;;A8E7|A8E3/A8E3\A8E3; \ Play sound effect 
                      STA.W !SPCIO0                       ;;A8E9|A8E5/A8E5\A8E5; / 
                      LDA.B #$08                          ;;A8EC|A8E8/A8E8\A8E8; \ Sprite status = Normal 
                      STA.W !SpriteStatus,Y               ;;A8EE|A8EA/A8EA\A8EA; / 
                      LDA.B #$74                          ;;A8F1|A8ED/A8ED\A8ED;
                      STA.W !SpriteNumber,Y               ;;A8F3|A8EF/A8EF\A8EF;
                      LDA.B !SpriteXPosLow,X              ;;A8F6|A8F2/A8F2\A8F2;
                      CLC                                 ;;A8F8|A8F4/A8F4\A8F4;
                      ADC.B #$04                          ;;A8F9|A8F5/A8F5\A8F5;
                      STA.W !SpriteXPosLow,Y              ;;A8FB|A8F7/A8F7\A8F7;
                      LDA.W !SpriteYPosHigh,X             ;;A8FE|A8FA/A8FA\A8FA;
                      ADC.B #$00                          ;;A901|A8FD/A8FD\A8FD;
                      STA.W !SpriteYPosHigh,Y             ;;A903|A8FF/A8FF\A8FF;
                      LDA.B !SpriteYPosLow,X              ;;A906|A902/A902\A902;
                      CLC                                 ;;A908|A904/A904\A904;
                      ADC.B #$18                          ;;A909|A905/A905\A905;
                      STA.W !SpriteYPosLow,Y              ;;A90B|A907/A907\A907;
                      LDA.W !SpriteXPosHigh,X             ;;A90E|A90A/A90A\A90A;
                      ADC.B #$00                          ;;A911|A90D/A90D\A90D;
                      STA.W !SpriteXPosHigh,Y             ;;A913|A90F/A90F\A90F;
                      PHX                                 ;;A916|A912/A912\A912;
                      TYX                                 ;;A917|A913/A913\A913;
                      JSL InitSpriteTables                ;;A918|A914/A914\A914;
                      LDA.B #$C0                          ;;A91C|A918/A918\A918;
                      STA.B !SpriteYSpeed,X               ;;A91E|A91A/A91A\A91A;
                      STZ.W !SpriteMisc157C,X             ;;A920|A91C/A91C\A91C;
                      LDY.B #$0C                          ;;A923|A91F/A91F\A91F;
                      LDA.B !SpriteXPosLow,X              ;;A925|A921/A921\A921;
                      BPL +                               ;;A927|A923/A923\A923;
                      LDY.B #$F4                          ;;A929|A925/A925\A925;
                      INC.W !SpriteMisc157C,X             ;;A92B|A927/A927\A927;
                    + STY.B !SpriteXSpeed,X               ;;A92E|A92A/A92A\A92A;
                      PLX                                 ;;A930|A92C/A92C\A92C;
                      RTS                                 ;;A931|A92D/A92D\A92D; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03A92E:          db $00,$08,$00,$08,$00,$08,$00,$08  ;;A932|A92E/A92E\A92E;
                      db $00,$08,$00,$08,$00,$08,$00,$08  ;;A93A|A936/A936\A936;
                      db $00,$08,$00,$08,$00,$08,$00,$08  ;;A942|A93E/A93E\A93E;
                      db $00,$08,$00,$08,$00,$08,$00,$08  ;;A94A|A946/A946\A946;
                      db $00,$08,$00,$08,$00,$08,$00,$08  ;;A952|A94E/A94E\A94E;
                      db $00,$08,$00,$08,$00,$08,$00,$08  ;;A95A|A956/A956\A956;
                      db $08,$00,$08,$00,$08,$00,$08,$00  ;;A962|A95E/A95E\A95E;
                      db $08,$00,$08,$00,$08,$00,$08,$00  ;;A96A|A966/A966\A966;
                      db $08,$00,$08,$00,$08,$00,$08,$00  ;;A972|A96E/A96E\A96E;
                      db $08,$00,$08,$00,$08,$00,$08,$00  ;;A97A|A976/A976\A976;
DATA_03A97E:          db $00,$00,$08,$08,$00,$00,$08,$08  ;;A982|A97E/A97E\A97E;
                      db $00,$00,$08,$08,$00,$00,$08,$08  ;;A98A|A986/A986\A986;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A992|A98E/A98E\A98E;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A99A|A996/A996\A996;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A9A2|A99E/A99E\A99E;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A9AA|A9A6/A9A6\A9A6;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A9B2|A9AE/A9AE\A9AE;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A9BA|A9B6/A9B6\A9B6;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A9C2|A9BE/A9BE\A9BE;
                      db $00,$00,$10,$10,$00,$00,$10,$10  ;;A9CA|A9C6/A9C6\A9C6;
DATA_03A9CE:          db $05,$06,$15,$16,$9D,$9E,$4E,$AE  ;;A9D2|A9CE/A9CE\A9CE;
                      db $06,$05,$16,$15,$9E,$9D,$AE,$4E  ;;A9DA|A9D6/A9D6\A9D6;
                      db $8A,$8B,$AA,$68,$83,$84,$AA,$68  ;;A9E2|A9DE/A9DE\A9DE;
                      db $8A,$8B,$80,$81,$83,$84,$80,$81  ;;A9EA|A9E6/A9E6\A9E6;
                      db $85,$86,$A5,$A6,$83,$84,$A5,$A6  ;;A9F2|A9EE/A9EE\A9EE;
                      db $82,$83,$A2,$A3,$82,$83,$A2,$A3  ;;A9FA|A9F6/A9F6\A9F6;
                      db $8A,$8B,$AA,$68,$83,$84,$AA,$68  ;;AA02|A9FE/A9FE\A9FE;
                      db $8A,$8B,$80,$81,$83,$84,$80,$81  ;;AA0A|AA06/AA06\AA06;
                      db $85,$86,$A5,$A6,$83,$84,$A5,$A6  ;;AA12|AA0E/AA0E\AA0E;
                      db $82,$83,$A2,$A3,$82,$83,$A2,$A3  ;;AA1A|AA16/AA16\AA16;
DATA_03AA1E:          db $01,$01,$01,$01,$01,$01,$01,$01  ;;AA22|AA1E/AA1E\AA1E;
                      db $41,$41,$41,$41,$41,$41,$41,$41  ;;AA2A|AA26/AA26\AA26;
                      db $01,$01,$01,$01,$01,$01,$01,$01  ;;AA32|AA2E/AA2E\AA2E;
                      db $01,$01,$01,$01,$01,$01,$01,$01  ;;AA3A|AA36/AA36\AA36;
                      db $00,$00,$00,$00,$01,$01,$00,$00  ;;AA42|AA3E/AA3E\AA3E;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;AA4A|AA46/AA46\AA46;
                      db $41,$41,$41,$41,$41,$41,$41,$41  ;;AA52|AA4E/AA4E\AA4E;
                      db $41,$41,$41,$41,$41,$41,$41,$41  ;;AA5A|AA56/AA56\AA56;
                      db $40,$40,$40,$40,$41,$41,$40,$40  ;;AA62|AA5E/AA5E\AA5E;
                      db $40,$40,$40,$40,$40,$40,$40,$40  ;;AA6A|AA66/AA66\AA66;
                                                          ;;                   ;
CODE_03AA6E:          LDA.B !SpriteXPosLow,X              ;;AA72|AA6E/AA6E\AA6E;
                      CLC                                 ;;AA74|AA70/AA70\AA70;
                      ADC.B #$04                          ;;AA75|AA71/AA71\AA71;
                      SEC                                 ;;AA77|AA73/AA73\AA73;
                      SBC.B !Layer1XPos                   ;;AA78|AA74/AA74\AA74;
                      STA.B !_0                           ;;AA7A|AA76/AA76\AA76;
                      LDA.B !SpriteYPosLow,X              ;;AA7C|AA78/AA78\AA78;
                      CLC                                 ;;AA7E|AA7A/AA7A\AA7A;
                      ADC.B #$20                          ;;AA7F|AA7B/AA7B\AA7B;
                      SEC                                 ;;AA81|AA7D/AA7D\AA7D;
                      SBC.B !_2                           ;;AA82|AA7E/AA7E\AA7E;
                      SEC                                 ;;AA84|AA80/AA80\AA80;
                      SBC.B !Layer1YPos                   ;;AA85|AA81/AA81\AA81;
                      STA.B !_1                           ;;AA87|AA83/AA83\AA83;
                      CPY.B #$08                          ;;AA89|AA85/AA85\AA85;
                      BCC +                               ;;AA8B|AA87/AA87\AA87;
                      CPY.B #$10                          ;;AA8D|AA89/AA89\AA89;
                      BCS +                               ;;AA8F|AA8B/AA8B\AA8B;
                      LDA.B !_0                           ;;AA91|AA8D/AA8D\AA8D;
                      SEC                                 ;;AA93|AA8F/AA8F\AA8F;
                      SBC.B #$04                          ;;AA94|AA90/AA90\AA90;
                      STA.W !OAMTileXPos+$A0              ;;AA96|AA92/AA92\AA92;
                      CLC                                 ;;AA99|AA95/AA95\AA95;
                      ADC.B #$10                          ;;AA9A|AA96/AA96\AA96;
                      STA.W !OAMTileXPos+$A4              ;;AA9C|AA98/AA98\AA98;
                      LDA.B !_1                           ;;AA9F|AA9B/AA9B\AA9B;
                      SEC                                 ;;AAA1|AA9D/AA9D\AA9D;
                      SBC.B #$18                          ;;AAA2|AA9E/AA9E\AA9E;
                      STA.W !OAMTileYPos+$A0              ;;AAA4|AAA0/AAA0\AAA0;
                      STA.W !OAMTileYPos+$A4              ;;AAA7|AAA3/AAA3\AAA3;
                      LDA.B #$20                          ;;AAAA|AAA6/AAA6\AAA6;
                      STA.W !OAMTileNo+$A0                ;;AAAC|AAA8/AAA8\AAA8;
                      LDA.B #$22                          ;;AAAF|AAAB/AAAB\AAAB;
                      STA.W !OAMTileNo+$A4                ;;AAB1|AAAD/AAAD\AAAD;
                      LDA.B !EffFrame                     ;;AAB4|AAB0/AAB0\AAB0;
                      LSR A                               ;;AAB6|AAB2/AAB2\AAB2;
                      AND.B #$06                          ;;AAB7|AAB3/AAB3\AAB3;
                      INC A                               ;;AAB9|AAB5/AAB5\AAB5;
                      INC A                               ;;AABA|AAB6/AAB6\AAB6;
                      INC A                               ;;AABB|AAB7/AAB7\AAB7;
                      STA.W !OAMTileAttr+$A0              ;;AABC|AAB8/AAB8\AAB8;
                      STA.W !OAMTileAttr+$A4              ;;AABF|AABB/AABB\AABB;
                      LDA.B #$02                          ;;AAC2|AABE/AABE\AABE;
                      STA.W !OAMTileSize+$28              ;;AAC4|AAC0/AAC0\AAC0;
                      STA.W !OAMTileSize+$29              ;;AAC7|AAC3/AAC3\AAC3;
                    + LDY.B #$70                          ;;AACA|AAC6/AAC6\AAC6;
CODE_03AAC8:          LDA.B !_3                           ;;AACC|AAC8/AAC8\AAC8;
                      ASL A                               ;;AACE|AACA/AACA\AACA;
                      ASL A                               ;;AACF|AACB/AACB\AACB;
                      STA.B !_4                           ;;AAD0|AACC/AACC\AACC;
                      PHX                                 ;;AAD2|AACE/AACE\AACE;
                      LDX.B #$03                          ;;AAD3|AACF/AACF\AACF;
CODE_03AAD1:          PHX                                 ;;AAD5|AAD1/AAD1\AAD1;
                      TXA                                 ;;AAD6|AAD2/AAD2\AAD2;
                      CLC                                 ;;AAD7|AAD3/AAD3\AAD3;
                      ADC.B !_4                           ;;AAD8|AAD4/AAD4\AAD4;
                      TAX                                 ;;AADA|AAD6/AAD6\AAD6;
                      LDA.B !_0                           ;;AADB|AAD7/AAD7\AAD7;
                      CLC                                 ;;AADD|AAD9/AAD9\AAD9;
                      ADC.W DATA_03A92E,X                 ;;AADE|AADA/AADA\AADA;
                      STA.W !OAMTileXPos+$100,Y           ;;AAE1|AADD/AADD\AADD;
                      LDA.B !_1                           ;;AAE4|AAE0/AAE0\AAE0;
                      CLC                                 ;;AAE6|AAE2/AAE2\AAE2;
                      ADC.W DATA_03A97E,X                 ;;AAE7|AAE3/AAE3\AAE3;
                      STA.W !OAMTileYPos+$100,Y           ;;AAEA|AAE6/AAE6\AAE6;
                      LDA.W DATA_03A9CE,X                 ;;AAED|AAE9/AAE9\AAE9;
                      STA.W !OAMTileNo+$100,Y             ;;AAF0|AAEC/AAEC\AAEC;
                      LDA.W DATA_03AA1E,X                 ;;AAF3|AAEF/AAEF\AAEF;
                      PHX                                 ;;AAF6|AAF2/AAF2\AAF2;
                      LDX.W !CurSpriteProcess             ;;AAF7|AAF3/AAF3\AAF3; X = Sprite index 
                      CPX.B #$09                          ;;AAFA|AAF6/AAF6\AAF6;
                      BEQ +                               ;;AAFC|AAF8/AAF8\AAF8;
                      ORA.B #$30                          ;;AAFE|AAFA/AAFA\AAFA;
                    + STA.W !OAMTileAttr+$100,Y           ;;AB00|AAFC/AAFC\AAFC;
                      PLX                                 ;;AB03|AAFF/AAFF\AAFF;
                      PHY                                 ;;AB04|AB00/AB00\AB00;
                      TYA                                 ;;AB05|AB01/AB01\AB01;
                      LSR A                               ;;AB06|AB02/AB02\AB02;
                      LSR A                               ;;AB07|AB03/AB03\AB03;
                      TAY                                 ;;AB08|AB04/AB04\AB04;
                      LDA.B #$02                          ;;AB09|AB05/AB05\AB05;
                      STA.W !OAMTileSize+$40,Y            ;;AB0B|AB07/AB07\AB07;
                      PLY                                 ;;AB0E|AB0A/AB0A\AB0A;
                      INY                                 ;;AB0F|AB0B/AB0B\AB0B;
                      INY                                 ;;AB10|AB0C/AB0C\AB0C;
                      INY                                 ;;AB11|AB0D/AB0D\AB0D;
                      INY                                 ;;AB12|AB0E/AB0E\AB0E;
                      PLX                                 ;;AB13|AB0F/AB0F\AB0F;
                      DEX                                 ;;AB14|AB10/AB10\AB10;
                      BPL CODE_03AAD1                     ;;AB15|AB11/AB11\AB11;
                      PLX                                 ;;AB17|AB13/AB13\AB13;
                      RTS                                 ;;AB18|AB14/AB14\AB14; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03AB15:          db $01,$FF                          ;;AB19|AB15/AB15\AB15;
                                                          ;;                   ;
DATA_03AB17:          db $20,$E0                          ;;AB1B|AB17/AB17\AB17;
                                                          ;;                   ;
DATA_03AB19:          db $02,$FE                          ;;AB1D|AB19/AB19\AB19;
                                                          ;;                   ;
DATA_03AB1B:          db $20,$E0,$01,$FF,$10,$F0          ;;AB1F|AB1B/AB1B\AB1B;
                                                          ;;                   ;
CODE_03AB21:          JSR CODE_03A4FD                     ;;AB25|AB21/AB21\AB21;
                      JSR CODE_03A4D2                     ;;AB28|AB24/AB24\AB24;
                      JSR CODE_03A4ED                     ;;AB2B|AB27/AB27\AB27;
                      LDA.B !TrueFrame                    ;;AB2E|AB2A/AB2A\AB2A;
                      AND.B #$00                          ;;AB30|AB2C/AB2C\AB2C;
                      BNE CODE_03AB4B                     ;;AB32|AB2E/AB2E\AB2E;
                      LDY.B #$00                          ;;AB34|AB30/AB30\AB30;
                      LDA.B !SpriteXPosLow,X              ;;AB36|AB32/AB32\AB32;
                      CMP.B !PlayerXPosNext               ;;AB38|AB34/AB34\AB34;
                      LDA.W !SpriteYPosHigh,X             ;;AB3A|AB36/AB36\AB36;
                      SBC.B !PlayerXPosNext+1             ;;AB3D|AB39/AB39\AB39;
                      BMI +                               ;;AB3F|AB3B/AB3B\AB3B;
                      INY                                 ;;AB41|AB3D/AB3D\AB3D;
                    + LDA.B !SpriteXSpeed,X               ;;AB42|AB3E/AB3E\AB3E;
                      CMP.W DATA_03AB17,Y                 ;;AB44|AB40/AB40\AB40;
                      BEQ CODE_03AB4B                     ;;AB47|AB43/AB43\AB43;
                      CLC                                 ;;AB49|AB45/AB45\AB45;
                      ADC.W DATA_03AB15,Y                 ;;AB4A|AB46/AB46\AB46;
                      STA.B !SpriteXSpeed,X               ;;AB4D|AB49/AB49\AB49;
CODE_03AB4B:          LDY.B #$00                          ;;AB4F|AB4B/AB4B\AB4B;
                      LDA.B !SpriteYPosLow,X              ;;AB51|AB4D/AB4D\AB4D;
                      CMP.B #$10                          ;;AB53|AB4F/AB4F\AB4F;
                      BMI +                               ;;AB55|AB51/AB51\AB51;
                      INY                                 ;;AB57|AB53/AB53\AB53;
                    + LDA.B !SpriteYSpeed,X               ;;AB58|AB54/AB54\AB54;
                      CMP.W DATA_03AB1B,Y                 ;;AB5A|AB56/AB56\AB56;
                      BEQ +                               ;;AB5D|AB59/AB59\AB59;
                      CLC                                 ;;AB5F|AB5B/AB5B\AB5B;
                      ADC.W DATA_03AB19,Y                 ;;AB60|AB5C/AB5C\AB5C;
                      STA.B !SpriteYSpeed,X               ;;AB63|AB5F/AB5F\AB5F;
                    + RTS                                 ;;AB65|AB61/AB61\AB61; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03AB62:          db $10,$F0                          ;;AB66|AB62/AB62\AB62;
                                                          ;;                   ;
CODE_03AB64:          LDA.B #$03                          ;;AB68|AB64/AB64\AB64;
                      STA.W !ClownCarImage                ;;AB6A|AB66/AB66\AB66;
                      JSR CODE_03A4FD                     ;;AB6D|AB69/AB69\AB69;
                      JSR CODE_03A4D2                     ;;AB70|AB6C/AB6C\AB6C;
                      JSR CODE_03A4ED                     ;;AB73|AB6F/AB6F\AB6F;
                      LDA.B !SpriteYSpeed,X               ;;AB76|AB72/AB72\AB72;
                      CLC                                 ;;AB78|AB74/AB74\AB74;
                      ADC.B #$03                          ;;AB79|AB75/AB75\AB75;
                      STA.B !SpriteYSpeed,X               ;;AB7B|AB77/AB77\AB77;
                      LDA.B !SpriteYPosLow,X              ;;AB7D|AB79/AB79\AB79;
                      CMP.B #con($64,$64,$64,$74)         ;;AB7F|AB7B/AB7B\AB7B;
                      BCC +                               ;;AB81|AB7D/AB7D\AB7D;
                      LDA.W !SpriteXPosHigh,X             ;;AB83|AB7F/AB7F\AB7F;
                      BMI +                               ;;AB86|AB82/AB82\AB82;
                      LDA.B #$64                          ;;AB88|AB84/AB84\AB84;
                      STA.B !SpriteYPosLow,X              ;;AB8A|AB86/AB86\AB86;
                      LDA.B #$A0                          ;;AB8C|AB88/AB88\AB88;
                      STA.B !SpriteYSpeed,X               ;;AB8E|AB8A/AB8A\AB8A;
                      LDA.B #$09                          ;;AB90|AB8C/AB8C\AB8C; \ Play sound effect 
                      STA.W !SPCIO3                       ;;AB92|AB8E/AB8E\AB8E; / 
                      JSR SubHorzPosBnk3                  ;;AB95|AB91/AB91\AB91;
                      LDA.W DATA_03AB62,Y                 ;;AB98|AB94/AB94\AB94;
                      STA.B !SpriteXSpeed,X               ;;AB9B|AB97/AB97\AB97;
                      LDA.B #$20                          ;;AB9D|AB99/AB99\AB99; \ Set ground shake timer 
                      STA.W !ScreenShakeTimer             ;;AB9F|AB9B/AB9B\AB9B; / 
                    + RTS                                 ;;ABA2|AB9E/AB9E\AB9E; Return 
                                                          ;;                   ;
CODE_03AB9F:          JSR CODE_03A6AC                     ;;ABA3|AB9F/AB9F\AB9F;
                      LDA.W !SpriteXPosHigh,X             ;;ABA6|ABA2/ABA2\ABA2;
                      BMI CODE_03ABAF                     ;;ABA9|ABA5/ABA5\ABA5;
                      BNE +                               ;;ABAB|ABA7/ABA7\ABA7;
                      LDA.B !SpriteYPosLow,X              ;;ABAD|ABA9/ABA9\ABA9;
                      CMP.B #$10                          ;;ABAF|ABAB/ABAB\ABAB;
                      BCS +                               ;;ABB1|ABAD/ABAD\ABAD;
CODE_03ABAF:          LDA.B #$05                          ;;ABB3|ABAF/ABAF\ABAF;
                      STA.W !SpriteMisc151C,X             ;;ABB5|ABB1/ABB1\ABB1;
                      LDA.B #con($60,$60,$50,$50)         ;;ABB8|ABB4/ABB4\ABB4;
                      STA.W !SpriteMisc1540,X             ;;ABBA|ABB6/ABB6\ABB6;
                    + LDA.B #$F8                          ;;ABBD|ABB9/ABB9\ABB9;
                      STA.B !SpriteYSpeed,X               ;;ABBF|ABBB/ABBB\ABBB;
                      RTS                                 ;;ABC1|ABBD/ABBD\ABBD; Return 
                                                          ;;                   ;
CODE_03ABBE:          JSR CODE_03A6AC                     ;;ABC2|ABBE/ABBE\ABBE;
                      STZ.B !SpriteXSpeed,X               ;;ABC5|ABC1/ABC1\ABC1; Sprite X Speed = 0 
                      STZ.B !SpriteYSpeed,X               ;;ABC7|ABC3/ABC3\ABC3; Sprite Y Speed = 0 
                      LDA.W !SpriteMisc1540,X             ;;ABC9|ABC5/ABC5\ABC5;
                      BNE CODE_03ABEB                     ;;ABCC|ABC8/ABC8\ABC8;
                      LDA.B !Mode7Angle                   ;;ABCE|ABCA/ABCA\ABCA;
                      CLC                                 ;;ABD0|ABCC/ABCC\ABCC;
                      ADC.B #$0A                          ;;ABD1|ABCD/ABCD\ABCD;
                      STA.B !Mode7Angle                   ;;ABD3|ABCF/ABCF\ABCF;
                      LDA.B !Mode7Angle+1                 ;;ABD5|ABD1/ABD1\ABD1;
                      ADC.B #$00                          ;;ABD7|ABD3/ABD3\ABD3;
                      STA.B !Mode7Angle+1                 ;;ABD9|ABD5/ABD5\ABD5;
                      BEQ +                               ;;ABDB|ABD7/ABD7\ABD7;
                      STZ.B !Mode7Angle                   ;;ABDD|ABD9/ABD9\ABD9;
                      LDA.B #$20                          ;;ABDF|ABDB/ABDB\ABDB;
                      STA.W !SpriteMisc154C,X             ;;ABE1|ABDD/ABDD\ABDD;
                      LDA.B #con($60,$60,$50,$50)         ;;ABE4|ABE0/ABE0\ABE0;
                      STA.W !SpriteMisc1540,X             ;;ABE6|ABE2/ABE2\ABE2;
                      LDA.B #$06                          ;;ABE9|ABE5/ABE5\ABE5;
                      STA.W !SpriteMisc151C,X             ;;ABEB|ABE7/ABE7\ABE7;
                    + RTS                                 ;;ABEE|ABEA/ABEA\ABEA; Return 
                                                          ;;                   ;
CODE_03ABEB:          CMP.B #con($40,$40,$30,$30)         ;;ABEF|ABEB/ABEB\ABEB;
                      BCC Return03AC02                    ;;ABF1|ABED/ABED\ABED;
                      CMP.B #con($5E,$5E,$4A,$4A)         ;;ABF3|ABEF/ABEF\ABEF;
                      BNE +                               ;;ABF5|ABF1/ABF1\ABF1;
                      LDY.B #$1B                          ;;ABF7|ABF3/ABF3\ABF3;
                      STY.W !SPCIO2                       ;;ABF9|ABF5/ABF5\ABF5; / Change music 
                    + LDA.W !SpriteMisc1564,X             ;;ABFC|ABF8/ABF8\ABF8;
                      BNE Return03AC02                    ;;ABFF|ABFB/ABFB\ABFB;
                      LDA.B #$12                          ;;AC01|ABFD/ABFD\ABFD;
                      STA.W !SpriteMisc1564,X             ;;AC03|ABFF/ABFF\ABFF;
Return03AC02:         RTS                                 ;;AC06|AC02/AC02\AC02; Return 
                                                          ;;                   ;
CODE_03AC03:          JSR CODE_03A6AC                     ;;AC07|AC03/AC03\AC03;
                      LDA.W !SpriteMisc154C,X             ;;AC0A|AC06/AC06\AC06;
                      CMP.B #$01                          ;;AC0D|AC09/AC09\AC09;
                      BNE +                               ;;AC0F|AC0B/AC0B\AC0B;
                      LDA.B #$0B                          ;;AC11|AC0D/AC0D\AC0D;
                      STA.B !PlayerAnimation              ;;AC13|AC0F/AC0F\AC0F;
                      INC.W !FinalCutscene                ;;AC15|AC11/AC11\AC11;
                      STZ.W !BackgroundColor              ;;AC18|AC14/AC14\AC14;
                      STZ.W !BackgroundColor+1            ;;AC1B|AC17/AC17\AC17;
                      LDA.B #$03                          ;;AC1E|AC1A/AC1A\AC1A;
                      STA.W !PlayerBehindNet              ;;AC20|AC1C/AC1C\AC1C;
                      JSR CODE_03AC63                     ;;AC23|AC1F/AC1F\AC1F;
                    + LDA.W !SpriteMisc1540,X             ;;AC26|AC22/AC22\AC22;
                      BNE Return03AC4C                    ;;AC29|AC25/AC25\AC25;
                      LDA.B #$FA                          ;;AC2B|AC27/AC27\AC27;
                      STA.B !SpriteXSpeed,X               ;;AC2D|AC29/AC29\AC29;
                      LDA.B #$FC                          ;;AC2F|AC2B/AC2B\AC2B;
                      STA.B !SpriteYSpeed,X               ;;AC31|AC2D/AC2D\AC2D;
                      LDA.B !Mode7Angle                   ;;AC33|AC2F/AC2F\AC2F;
                      CLC                                 ;;AC35|AC31/AC31\AC31;
                      ADC.B #$05                          ;;AC36|AC32/AC32\AC32;
                      STA.B !Mode7Angle                   ;;AC38|AC34/AC34\AC34;
                      LDA.B !Mode7Angle+1                 ;;AC3A|AC36/AC36\AC36;
                      ADC.B #$00                          ;;AC3C|AC38/AC38\AC38;
                      STA.B !Mode7Angle+1                 ;;AC3E|AC3A/AC3A\AC3A;
                      LDA.B !TrueFrame                    ;;AC40|AC3C/AC3C\AC3C;
                      AND.B #$03                          ;;AC42|AC3E/AC3E\AC3E;
                      BNE Return03AC4C                    ;;AC44|AC40/AC40\AC40;
                      LDA.B !Mode7XScale                  ;;AC46|AC42/AC42\AC42;
                      CMP.B #$80                          ;;AC48|AC44/AC44\AC44;
                      BCS +                               ;;AC4A|AC46/AC46\AC46;
                      INC.B !Mode7XScale                  ;;AC4C|AC48/AC48\AC48;
                      INC.B !Mode7YScale                  ;;AC4E|AC4A/AC4A\AC4A;
Return03AC4C:         RTS                                 ;;AC50|AC4C/AC4C\AC4C; Return 
                                                          ;;                   ;
                    + LDA.W !SpriteInLiquid,X             ;;AC51|AC4D/AC4D\AC4D;
                      BNE +                               ;;AC54|AC50/AC50\AC50;
                      LDA.B #$1C                          ;;AC56|AC52/AC52\AC52;
                      STA.W !SPCIO2                       ;;AC58|AC54/AC54\AC54; / Change music 
                      INC.W !SpriteInLiquid,X             ;;AC5B|AC57/AC57\AC57;
                    + LDA.B #$FE                          ;;AC5E|AC5A/AC5A\AC5A;
                      STA.W !SpriteYPosHigh,X             ;;AC60|AC5C/AC5C\AC5C;
                      STA.W !SpriteXPosHigh,X             ;;AC63|AC5F/AC5F\AC5F;
                      RTS                                 ;;AC66|AC62/AC62\AC62; Return 
                                                          ;;                   ;
CODE_03AC63:          LDA.B #$08                          ;;AC67|AC63/AC63\AC63;
                      STA.W !SpriteStatus+8               ;;AC69|AC65/AC65\AC65;
                      LDA.B #$7C                          ;;AC6C|AC68/AC68\AC68;
                      STA.B !SpriteNumber+8               ;;AC6E|AC6A/AC6A\AC6A;
                      LDA.B !SpriteXPosLow,X              ;;AC70|AC6C/AC6C\AC6C;
                      CLC                                 ;;AC72|AC6E/AC6E\AC6E;
                      ADC.B #$08                          ;;AC73|AC6F/AC6F\AC6F;
                      STA.B !SpriteXPosLow+8              ;;AC75|AC71/AC71\AC71;
                      LDA.W !SpriteYPosHigh,X             ;;AC77|AC73/AC73\AC73;
                      ADC.B #$00                          ;;AC7A|AC76/AC76\AC76;
                      STA.W !SpriteYPosHigh+8             ;;AC7C|AC78/AC78\AC78;
                      LDA.B !SpriteYPosLow,X              ;;AC7F|AC7B/AC7B\AC7B;
                      CLC                                 ;;AC81|AC7D/AC7D\AC7D;
                      ADC.B #$47                          ;;AC82|AC7E/AC7E\AC7E;
                      STA.B !SpriteYPosLow+8              ;;AC84|AC80/AC80\AC80;
                      LDA.W !SpriteXPosHigh,X             ;;AC86|AC82/AC82\AC82;
                      ADC.B #$00                          ;;AC89|AC85/AC85\AC85;
                      STA.W !SpriteXPosHigh+8             ;;AC8B|AC87/AC87\AC87;
                      PHX                                 ;;AC8E|AC8A/AC8A\AC8A;
                      LDX.B #$08                          ;;AC8F|AC8B/AC8B\AC8B;
                      JSL InitSpriteTables                ;;AC91|AC8D/AC8D\AC8D;
                      PLX                                 ;;AC95|AC91/AC91\AC91;
                      RTS                                 ;;AC96|AC92/AC92\AC92; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BlushTileDispY:       db $01,$11                          ;;AC97|AC93/AC93\AC93;
                                                          ;;                   ;
BlushTiles:           db $6E,$88                          ;;AC99|AC95/AC95\AC95;
                                                          ;;                   ;
PrincessPeach:        LDA.B !SpriteXPosLow,X              ;;AC9B|AC97/AC97\AC97;
                      SEC                                 ;;AC9D|AC99/AC99\AC99;
                      SBC.B !Layer1XPos                   ;;AC9E|AC9A/AC9A\AC9A;
                      STA.B !_0                           ;;ACA0|AC9C/AC9C\AC9C;
                      LDA.B !SpriteYPosLow,X              ;;ACA2|AC9E/AC9E\AC9E;
                      SEC                                 ;;ACA4|ACA0/ACA0\ACA0;
                      SBC.B !Layer1YPos                   ;;ACA5|ACA1/ACA1\ACA1;
                      STA.B !_1                           ;;ACA7|ACA3/ACA3\ACA3;
                      LDA.B !TrueFrame                    ;;ACA9|ACA5/ACA5\ACA5;
                      AND.B #$7F                          ;;ACAB|ACA7/ACA7\ACA7;
                      BNE +                               ;;ACAD|ACA9/ACA9\ACA9;
                      JSL GetRand                         ;;ACAF|ACAB/ACAB\ACAB;
                      AND.B #$07                          ;;ACB3|ACAF/ACAF\ACAF;
                      BNE +                               ;;ACB5|ACB1/ACB1\ACB1;
                      LDA.B #$0C                          ;;ACB7|ACB3/ACB3\ACB3;
                      STA.W !SpriteMisc154C,X             ;;ACB9|ACB5/ACB5\ACB5;
                    + LDY.W !SpriteMisc1602,X             ;;ACBC|ACB8/ACB8\ACB8;
                      LDA.W !SpriteMisc154C,X             ;;ACBF|ACBB/ACBB\ACBB;
                      BEQ +                               ;;ACC2|ACBE/ACBE\ACBE;
                      INY                                 ;;ACC4|ACC0/ACC0\ACC0;
                    + LDA.W !SpriteMisc157C,X             ;;ACC5|ACC1/ACC1\ACC1;
                      BNE +                               ;;ACC8|ACC4/ACC4\ACC4;
                      TYA                                 ;;ACCA|ACC6/ACC6\ACC6;
                      CLC                                 ;;ACCB|ACC7/ACC7\ACC7;
                      ADC.B #$08                          ;;ACCC|ACC8/ACC8\ACC8;
                      TAY                                 ;;ACCE|ACCA/ACCA\ACCA;
                    + STY.B !_3                           ;;ACCF|ACCB/ACCB\ACCB;
                      LDA.B #$D0                          ;;ACD1|ACCD/ACCD\ACCD;
                      STA.W !SpriteOAMIndex,X             ;;ACD3|ACCF/ACCF\ACCF;
                      TAY                                 ;;ACD6|ACD2/ACD2\ACD2;
                      JSR CODE_03AAC8                     ;;ACD7|ACD3/ACD3\ACD3;
                      LDY.B #$02                          ;;ACDA|ACD6/ACD6\ACD6;
                      LDA.B #$03                          ;;ACDC|ACD8/ACD8\ACD8;
                      JSL FinishOAMWrite                  ;;ACDE|ACDA/ACDA\ACDA;
                      LDA.W !SpriteMisc1558,X             ;;ACE2|ACDE/ACDE\ACDE;
                      BEQ CODE_03AD18                     ;;ACE5|ACE1/ACE1\ACE1;
                      PHX                                 ;;ACE7|ACE3/ACE3\ACE3;
                      LDX.B #$00                          ;;ACE8|ACE4/ACE4\ACE4;
                      LDA.B !Powerup                      ;;ACEA|ACE6/ACE6\ACE6;
                      BNE +                               ;;ACEC|ACE8/ACE8\ACE8;
                      INX                                 ;;ACEE|ACEA/ACEA\ACEA;
                    + LDY.B #$4C                          ;;ACEF|ACEB/ACEB\ACEB;
                      LDA.B !PlayerXPosScrRel             ;;ACF1|ACED/ACED\ACED;
                      STA.W !OAMTileXPos+$100,Y           ;;ACF3|ACEF/ACEF\ACEF;
                      LDA.B !PlayerYPosScrRel             ;;ACF6|ACF2/ACF2\ACF2;
                      CLC                                 ;;ACF8|ACF4/ACF4\ACF4;
                      ADC.W BlushTileDispY,X              ;;ACF9|ACF5/ACF5\ACF5;
                      STA.W !OAMTileYPos+$100,Y           ;;ACFC|ACF8/ACF8\ACF8;
                      LDA.W BlushTiles,X                  ;;ACFF|ACFB/ACFB\ACFB;
                      STA.W !OAMTileNo+$100,Y             ;;AD02|ACFE/ACFE\ACFE;
                      PLX                                 ;;AD05|AD01/AD01\AD01;
                      LDA.B !PlayerDirection              ;;AD06|AD02/AD02\AD02;
                      CMP.B #$01                          ;;AD08|AD04/AD04\AD04;
                      LDA.B #$31                          ;;AD0A|AD06/AD06\AD06;
                      BCC +                               ;;AD0C|AD08/AD08\AD08;
                      ORA.B #$40                          ;;AD0E|AD0A/AD0A\AD0A;
                    + STA.W !OAMTileAttr+$100,Y           ;;AD10|AD0C/AD0C\AD0C;
                      TYA                                 ;;AD13|AD0F/AD0F\AD0F;
                      LSR A                               ;;AD14|AD10/AD10\AD10;
                      LSR A                               ;;AD15|AD11/AD11\AD11;
                      TAY                                 ;;AD16|AD12/AD12\AD12;
                      LDA.B #$02                          ;;AD17|AD13/AD13\AD13;
                      STA.W !OAMTileSize+$40,Y            ;;AD19|AD15/AD15\AD15;
CODE_03AD18:          STZ.B !SpriteXSpeed,X               ;;AD1C|AD18/AD18\AD18; Sprite X Speed = 0 
                      STZ.B !PlayerXSpeed                 ;;AD1E|AD1A/AD1A\AD1A;
                      LDA.B #$04                          ;;AD20|AD1C/AD1C\AD1C;
                      STA.W !SpriteMisc1602,X             ;;AD22|AD1E/AD1E\AD1E;
                      LDA.B !SpriteTableC2,X              ;;AD25|AD21/AD21\AD21;
                      JSL ExecutePtr                      ;;AD27|AD23/AD23\AD23;
                                                          ;;                   ;
                      dw CODE_03AD37                      ;;AD2B|AD27/AD27\AD27;
                      dw CODE_03ADB3                      ;;AD2D|AD29/AD29\AD29;
                      dw CODE_03ADDD                      ;;AD2F|AD2B/AD2B\AD2B;
                      dw CODE_03AE25                      ;;AD31|AD2D/AD2D\AD2D;
                      dw CODE_03AE32                      ;;AD33|AD2F/AD2F\AD2F;
                      dw CODE_03AEAF                      ;;AD35|AD31/AD31\AD31;
                      dw CODE_03AEE8                      ;;AD37|AD33/AD33\AD33;
                      dw CODE_03C796                      ;;AD39|AD35/AD35\AD35;
                                                          ;;                   ;
CODE_03AD37:          LDA.B #$06                          ;;AD3B|AD37/AD37\AD37;
                      STA.W !SpriteMisc1602,X             ;;AD3D|AD39/AD39\AD39;
                      JSL UpdateYPosNoGvtyW               ;;AD40|AD3C/AD3C\AD3C;
                      LDA.B !SpriteYSpeed,X               ;;AD44|AD40/AD40\AD40;
                      CMP.B #$08                          ;;AD46|AD42/AD42\AD42;
                      BCS +                               ;;AD48|AD44/AD44\AD44;
                      CLC                                 ;;AD4A|AD46/AD46\AD46;
                      ADC.B #$01                          ;;AD4B|AD47/AD47\AD47;
                      STA.B !SpriteYSpeed,X               ;;AD4D|AD49/AD49\AD49;
                    + LDA.W !SpriteXPosHigh,X             ;;AD4F|AD4B/AD4B\AD4B;
                      BMI +                               ;;AD52|AD4E/AD4E\AD4E;
                      LDA.B !SpriteYPosLow,X              ;;AD54|AD50/AD50\AD50;
                      CMP.B #con($A0,$A0,$A0,$B0)         ;;AD56|AD52/AD52\AD52;
                      BCC +                               ;;AD58|AD54/AD54\AD54;
                      LDA.B #con($A0,$A0,$A0,$B0)         ;;AD5A|AD56/AD56\AD56;
                      STA.B !SpriteYPosLow,X              ;;AD5C|AD58/AD58\AD58;
                      STZ.B !SpriteYSpeed,X               ;;AD5E|AD5A/AD5A\AD5A; Sprite Y Speed = 0 
                      LDA.B #$A0                          ;;AD60|AD5C/AD5C\AD5C;
                      STA.W !SpriteMisc1540,X             ;;AD62|AD5E/AD5E\AD5E;
                      INC.B !SpriteTableC2,X              ;;AD65|AD61/AD61\AD61;
                    + LDA.B !TrueFrame                    ;;AD67|AD63/AD63\AD63;
                      AND.B #$07                          ;;AD69|AD65/AD65\AD65;
                      BNE Return03AD73                    ;;AD6B|AD67/AD67\AD67;
                      LDY.B #$0B                          ;;AD6D|AD69/AD69\AD69;
CODE_03AD6B:          LDA.W !MinExtSpriteNumber,Y         ;;AD6F|AD6B/AD6B\AD6B;
                      BEQ CODE_03AD74                     ;;AD72|AD6E/AD6E\AD6E;
                      DEY                                 ;;AD74|AD70/AD70\AD70;
                      BPL CODE_03AD6B                     ;;AD75|AD71/AD71\AD71;
Return03AD73:         RTS                                 ;;AD77|AD73/AD73\AD73; Return 
                                                          ;;                   ;
CODE_03AD74:          LDA.B #$05                          ;;AD78|AD74/AD74\AD74;
                      STA.W !MinExtSpriteNumber,Y         ;;AD7A|AD76/AD76\AD76;
                      JSL GetRand                         ;;AD7D|AD79/AD79\AD79;
                      STZ.B !_0                           ;;AD81|AD7D/AD7D\AD7D;
                      AND.B #$1F                          ;;AD83|AD7F/AD7F\AD7F;
                      CLC                                 ;;AD85|AD81/AD81\AD81;
                      ADC.B #$F8                          ;;AD86|AD82/AD82\AD82;
                      BPL +                               ;;AD88|AD84/AD84\AD84;
                      DEC.B !_0                           ;;AD8A|AD86/AD86\AD86;
                    + CLC                                 ;;AD8C|AD88/AD88\AD88;
                      ADC.B !SpriteXPosLow,X              ;;AD8D|AD89/AD89\AD89;
                      STA.W !MinExtSpriteXPosLow,Y        ;;AD8F|AD8B/AD8B\AD8B;
                      LDA.W !SpriteYPosHigh,X             ;;AD92|AD8E/AD8E\AD8E;
                      ADC.B !_0                           ;;AD95|AD91/AD91\AD91;
                      STA.W !MinExtSpriteXPosHigh,Y       ;;AD97|AD93/AD93\AD93;
                      LDA.W !RandomNumber+1               ;;AD9A|AD96/AD96\AD96;
                      AND.B #$1F                          ;;AD9D|AD99/AD99\AD99;
                      ADC.B !SpriteYPosLow,X              ;;AD9F|AD9B/AD9B\AD9B;
                      STA.W !MinExtSpriteYPosLow,Y        ;;ADA1|AD9D/AD9D\AD9D;
                      LDA.W !SpriteXPosHigh,X             ;;ADA4|ADA0/ADA0\ADA0;
                      ADC.B #$00                          ;;ADA7|ADA3/ADA3\ADA3;
                      STA.W !MinExtSpriteYPosHigh,Y       ;;ADA9|ADA5/ADA5\ADA5;
                      LDA.B #$00                          ;;ADAC|ADA8/ADA8\ADA8;
                      STA.W !MinExtSpriteYSpeed,Y         ;;ADAE|ADAA/ADAA\ADAA;
                      LDA.B #$17                          ;;ADB1|ADAD/ADAD\ADAD;
                      STA.W !MinExtSpriteXPosSpx,Y        ;;ADB3|ADAF/ADAF\ADAF;
                      RTS                                 ;;ADB6|ADB2/ADB2\ADB2; Return 
                                                          ;;                   ;
CODE_03ADB3:          LDA.W !SpriteMisc1540,X             ;;ADB7|ADB3/ADB3\ADB3;
                      BNE +                               ;;ADBA|ADB6/ADB6\ADB6;
                      INC.B !SpriteTableC2,X              ;;ADBC|ADB8/ADB8\ADB8;
                      JSR CODE_03ADCC                     ;;ADBE|ADBA/ADBA\ADBA;
                      BCC +                               ;;ADC1|ADBD/ADBD\ADBD;
                      INC.W !SpriteMisc151C,X             ;;ADC3|ADBF/ADBF\ADBF;
                    + JSR SubHorzPosBnk3                  ;;ADC6|ADC2/ADC2\ADC2;
                      TYA                                 ;;ADC9|ADC5/ADC5\ADC5;
                      STA.W !SpriteMisc157C,X             ;;ADCA|ADC6/ADC6\ADC6;
                      STA.B !PlayerDirection              ;;ADCD|ADC9/ADC9\ADC9;
                      RTS                                 ;;ADCF|ADCB/ADCB\ADCB; Return 
                                                          ;;                   ;
CODE_03ADCC:          JSL GetSpriteClippingA              ;;ADD0|ADCC/ADCC\ADCC;
                      JSL GetMarioClipping                ;;ADD4|ADD0/ADD0\ADD0;
                      JSL CheckForContact                 ;;ADD8|ADD4/ADD4\ADD4;
                      RTS                                 ;;ADDC|ADD8/ADD8\ADD8; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03ADD9:          db $08,$F8,$F8,$08                  ;;ADDD|ADD9/ADD9\ADD9;
                                                          ;;                   ;
CODE_03ADDD:          LDA.B !EffFrame                     ;;ADE1|ADDD/ADDD\ADDD;
                      AND.B #$08                          ;;ADE3|ADDF/ADDF\ADDF;
                      BNE +                               ;;ADE5|ADE1/ADE1\ADE1;
                      LDA.B #$08                          ;;ADE7|ADE3/ADE3\ADE3;
                      STA.W !SpriteMisc1602,X             ;;ADE9|ADE5/ADE5\ADE5;
                    + JSR CODE_03ADCC                     ;;ADEC|ADE8/ADE8\ADE8;
                      PHP                                 ;;ADEF|ADEB/ADEB\ADEB;
                      JSR SubHorzPosBnk3                  ;;ADF0|ADEC/ADEC\ADEC;
                      PLP                                 ;;ADF3|ADEF/ADEF\ADEF;
                      LDA.W !SpriteMisc151C,X             ;;ADF4|ADF0/ADF0\ADF0;
                      BNE ADDR_03ADF9                     ;;ADF7|ADF3/ADF3\ADF3;
                      BCS CODE_03AE14                     ;;ADF9|ADF5/ADF5\ADF5;
                      BRA CODE_03ADFF                     ;;ADFB|ADF7/ADF7\ADF7;
                                                          ;;                   ;
ADDR_03ADF9:          BCC CODE_03AE14                     ;;ADFD|ADF9/ADF9\ADF9;
                      TYA                                 ;;ADFF|ADFB/ADFB\ADFB;
                      EOR.B #$01                          ;;AE00|ADFC/ADFC\ADFC;
                      TAY                                 ;;AE02|ADFE/ADFE\ADFE;
CODE_03ADFF:          LDA.W DATA_03ADD9,Y                 ;;AE03|ADFF/ADFF\ADFF;
                      STA.B !SpriteXSpeed,X               ;;AE06|AE02/AE02\AE02;
                      EOR.B #$FF                          ;;AE08|AE04/AE04\AE04;
                      INC A                               ;;AE0A|AE06/AE06\AE06;
                      STA.B !PlayerXSpeed                 ;;AE0B|AE07/AE07\AE07;
                      TYA                                 ;;AE0D|AE09/AE09\AE09;
                      STA.W !SpriteMisc157C,X             ;;AE0E|AE0A/AE0A\AE0A;
                      STA.B !PlayerDirection              ;;AE11|AE0D/AE0D\AE0D;
                      JSL UpdateXPosNoGvtyW               ;;AE13|AE0F/AE0F\AE0F;
                      RTS                                 ;;AE17|AE13/AE13\AE13; Return 
                                                          ;;                   ;
CODE_03AE14:          JSR SubHorzPosBnk3                  ;;AE18|AE14/AE14\AE14;
                      TYA                                 ;;AE1B|AE17/AE17\AE17;
                      STA.W !SpriteMisc157C,X             ;;AE1C|AE18/AE18\AE18;
                      STA.B !PlayerDirection              ;;AE1F|AE1B/AE1B\AE1B;
                      INC.B !SpriteTableC2,X              ;;AE21|AE1D/AE1D\AE1D;
                      LDA.B #$60                          ;;AE23|AE1F/AE1F\AE1F;
                      STA.W !SpriteMisc1540,X             ;;AE25|AE21/AE21\AE21;
                      RTS                                 ;;AE28|AE24/AE24\AE24; Return 
                                                          ;;                   ;
CODE_03AE25:          LDA.W !SpriteMisc1540,X             ;;AE29|AE25/AE25\AE25;
                      BNE +                               ;;AE2C|AE28/AE28\AE28;
                      INC.B !SpriteTableC2,X              ;;AE2E|AE2A/AE2A\AE2A;
                      LDA.B #$A0                          ;;AE30|AE2C/AE2C\AE2C;
                      STA.W !SpriteMisc1540,X             ;;AE32|AE2E/AE2E\AE2E;
                    + RTS                                 ;;AE35|AE31/AE31\AE31; Return 
                                                          ;;                   ;
CODE_03AE32:          LDA.W !SpriteMisc1540,X             ;;AE36|AE32/AE32\AE32;
                      BNE +                               ;;AE39|AE35/AE35\AE35;
                      INC.B !SpriteTableC2,X              ;;AE3B|AE37/AE37\AE37;
                      STZ.W !Empty188A                    ;;AE3D|AE39/AE39\AE39;
                      STZ.W !ScrShakePlayerYOffset        ;;AE40|AE3C/AE3C\AE3C;
                    + CMP.B #$50                          ;;AE43|AE3F/AE3F\AE3F;
                      BCC Return03AE5A                    ;;AE45|AE41/AE41\AE41;
                      PHA                                 ;;AE47|AE43/AE43\AE43;
                      BNE +                               ;;AE48|AE44/AE44\AE44;
                      LDA.B #$14                          ;;AE4A|AE46/AE46\AE46;
                      STA.W !SpriteMisc154C,X             ;;AE4C|AE48/AE48\AE48;
                    + LDA.B #$0A                          ;;AE4F|AE4B/AE4B\AE4B;
                      STA.W !SpriteMisc1602,X             ;;AE51|AE4D/AE4D\AE4D;
                      PLA                                 ;;AE54|AE50/AE50\AE50;
                      CMP.B #$68                          ;;AE55|AE51/AE51\AE51;
                      BNE Return03AE5A                    ;;AE57|AE53/AE53\AE53;
                      LDA.B #$80                          ;;AE59|AE55/AE55\AE55;
                      STA.W !SpriteMisc1558,X             ;;AE5B|AE57/AE57\AE57;
Return03AE5A:         RTS                                 ;;AE5E|AE5A/AE5A\AE5A; Return 
                                                          ;;                   ;
                                                          ;;                   ;
                   if !_VER == 0                ;\   IF   ;;+++++++++++++++++++; J
DATA_03AE5B:          db $08,$08,$00,$10,$08,$08,$00,$08  ;;AE5F               ;
                      db $08,$08,$08,$08,$08,$00,$08,$08  ;;AE67               ;
                      db $08,$08,$10,$08,$08,$08,$00,$08  ;;AE6F               ;
                      db $03,$38,$04,$10,$04,$10,$0C,$08  ;;AE77               ;
                      db $08,$08,$08,$08,$08,$04,$0C,$04  ;;AE7F               ;
                      db $10,$00,$08,$08,$08,$08,$08,$08  ;;AE87               ;
                      db $08,$08,$08,$00,$08,$08,$08,$03  ;;AE8F               ;
                      db $08,$08,$00,$10,$08,$08,$08,$00  ;;AE97               ;
                      db $08,$08,$00,$08,$08,$08,$08,$40  ;;AE9F               ;
                      db $10,$10,$10,$C0                  ;;AEA7               ;
                   elseif !_VER == 1            ;< ELSEIF ;;-------------------; U
DATA_03AE5B:          db $08,$08,$08,$08,$08,$08,$18,$08  ;;    |AE5B          ;
                      db $08,$08,$08,$08,$08,$08,$08,$08  ;;    |AE63          ;
                      db $08,$08,$08,$08,$08,$08,$20,$08  ;;    |AE6B          ;
                      db $08,$08,$08,$08,$20,$08,$08,$10  ;;    |AE73          ;
                      db $08,$08,$08,$08,$08,$08,$08,$08  ;;    |AE7B          ;
                      db $20,$08,$08,$08,$08,$08,$20,$08  ;;    |AE83          ;
                      db $04,$20,$08,$08,$08,$08,$08,$08  ;;    |AE8B          ;
                      db $08,$08,$08,$08,$08,$08,$10,$08  ;;    |AE93          ;
                      db $08,$08,$08,$08,$08,$08,$08,$08  ;;    |AE9B          ;
                      db $08,$08,$10,$08,$08,$08,$08,$08  ;;    |AEA3          ;
                      db $08,$08,$08,$40                  ;;    |AEAB          ;
                   else                         ;<  ELSE  ;;-------------------; E0 & E1
DATA_03AE5B:          db $05,$05,$05,$05,$05,$05,$10,$05  ;;         /AE5B\AE5B;
                      db $05,$05,$05,$05,$05,$05,$05,$05  ;;         /AE63\AE63;
                      db $08,$05,$05,$05,$05,$05,$14,$08  ;;         /AE6B\AE6B;
                      db $05,$05,$05,$05,$14,$05,$05,$08  ;;         /AE73\AE73;
                      db $05,$05,$05,$05,$05,$05,$05,$05  ;;         /AE7B\AE7B;
                      db $14,$05,$05,$05,$05,$05,$14,$05  ;;         /AE83\AE83;
                      db $03,$14,$05,$05,$05,$05,$05,$05  ;;         /AE8B\AE8B;
                      db $05,$05,$05,$05,$05,$05,$08,$05  ;;         /AE93\AE93;
                      db $05,$05,$05,$05,$05,$05,$05,$05  ;;         /AE9B\AE9B;
                      db $05,$05,$08,$05,$05,$05,$05,$05  ;;         /AEA3\AEA3;
                      db $05,$05,$05,$50                  ;;         /AEAB\AEAB;
                   endif                        ;/ ENDIF  ;;+++++++++++++++++++;
                                                          ;;                   ;
CODE_03AEAF:          JSR CODE_03D674                     ;;AEAB|AEAF/AEAF\AEAF;
                      LDA.W !SpriteMisc1540,X             ;;AEAE|AEB2/AEB2\AEB2;
                      BNE Return03AEC7                    ;;AEB1|AEB5/AEB5\AEB5;
                      LDY.W !FinalMessageTimer            ;;AEB3|AEB7/AEB7\AEB7;
                      CPY.B #con($4C,$54,$54,$54)         ;;AEB6|AEBA/AEBA\AEBA;
                      BEQ +                               ;;AEB8|AEBC/AEBC\AEBC;
                      INC.W !FinalMessageTimer            ;;AEBA|AEBE/AEBE\AEBE;
                      LDA.W DATA_03AE5B,Y                 ;;AEBD|AEC1/AEC1\AEC1;
                      STA.W !SpriteMisc1540,X             ;;AEC0|AEC4/AEC4\AEC4;
Return03AEC7:         RTS                                 ;;AEC3|AEC7/AEC7\AEC7; Return 
                                                          ;;                   ;
                    + INC.B !SpriteTableC2,X              ;;AEC4|AEC8/AEC8\AEC8;
                      LDA.B #$40                          ;;AEC6|AECA/AECA\AECA;
                      STA.W !SpriteMisc1540,X             ;;AEC8|AECC/AECC\AECC;
                      RTS                                 ;;AECB|AECF/AECF\AECF; Return 
                                                          ;;                   ;
                    - INC.B !SpriteTableC2,X              ;;AECC|AED0/AED0\AED0;
                      LDA.B #$80                          ;;AECE|AED2/AED2\AED2;
                      STA.W !SpriteMisc1FE2+9             ;;AED0|AED4/AED4\AED4;
                      RTS                                 ;;AED3|AED7/AED7\AED7; Return 
                                                          ;;                   ;
                                                          ;;                   ;
                      db $00,$00,$94,$18,$18,$9C,$9C,$FF  ;;AED4|AED8/AED8\AED8;
                      db $00,$00,$52,$63,$63,$73,$73,$7F  ;;AEDC|AEE0/AEE0\AEE0;
                                                          ;;                   ;
CODE_03AEE8:          LDA.W !SpriteMisc1540,X             ;;AEE4|AEE8/AEE8\AEE8;
                      BEQ -                               ;;AEE7|AEEB/AEEB\AEEB;
                      LSR A                               ;;AEE9|AEED/AEED\AEED;
                      STA.B !_0                           ;;AEEA|AEEE/AEEE\AEEE;
                      STZ.B !_1                           ;;AEEC|AEF0/AEF0\AEF0;
                      REP #$20                            ;;AEEE|AEF2/AEF2\AEF2; Accum (16 bit) 
                      LDA.B !_0                           ;;AEF0|AEF4/AEF4\AEF4;
                      ASL A                               ;;AEF2|AEF6/AEF6\AEF6;
                      ASL A                               ;;AEF3|AEF7/AEF7\AEF7;
                      ASL A                               ;;AEF4|AEF8/AEF8\AEF8;
                      ASL A                               ;;AEF5|AEF9/AEF9\AEF9;
                      ASL A                               ;;AEF6|AEFA/AEFA\AEFA;
                      ORA.B !_0                           ;;AEF7|AEFB/AEFB\AEFB;
                      STA.B !_0                           ;;AEF9|AEFD/AEFD\AEFD;
                      ASL A                               ;;AEFB|AEFF/AEFF\AEFF;
                      ASL A                               ;;AEFC|AF00/AF00\AF00;
                      ASL A                               ;;AEFD|AF01/AF01\AF01;
                      ASL A                               ;;AEFE|AF02/AF02\AF02;
                      ASL A                               ;;AEFF|AF03/AF03\AF03;
                      ORA.B !_0                           ;;AF00|AF04/AF04\AF04;
                      STA.B !_0                           ;;AF02|AF06/AF06\AF06;
                      SEP #$20                            ;;AF04|AF08/AF08\AF08; Accum (8 bit) 
                      PHX                                 ;;AF06|AF0A/AF0A\AF0A;
                      TAX                                 ;;AF07|AF0B/AF0B\AF0B;
                      LDY.W !DynPaletteIndex              ;;AF08|AF0C/AF0C\AF0C;
                      LDA.B #$02                          ;;AF0B|AF0F/AF0F\AF0F;
                      STA.W !DynPaletteTable,Y            ;;AF0D|AF11/AF11\AF11;
                      LDA.B #$F1                          ;;AF10|AF14/AF14\AF14;
                      STA.W !DynPaletteTable+1,Y          ;;AF12|AF16/AF16\AF16;
                      LDA.B !_0                           ;;AF15|AF19/AF19\AF19;
                      STA.W !DynPaletteTable+2,Y          ;;AF17|AF1B/AF1B\AF1B;
                      LDA.B !_1                           ;;AF1A|AF1E/AF1E\AF1E;
                      STA.W !DynPaletteTable+3,Y          ;;AF1C|AF20/AF20\AF20;
                      LDA.B #$00                          ;;AF1F|AF23/AF23\AF23;
                      STA.W !DynPaletteTable+4,Y          ;;AF21|AF25/AF25\AF25;
                      TYA                                 ;;AF24|AF28/AF28\AF28;
                      CLC                                 ;;AF25|AF29/AF29\AF29;
                      ADC.B #$04                          ;;AF26|AF2A/AF2A\AF2A;
                      STA.W !DynPaletteIndex              ;;AF28|AF2C/AF2C\AF2C;
                      PLX                                 ;;AF2B|AF2F/AF2F\AF2F;
                      JSR CODE_03D674                     ;;AF2C|AF30/AF30\AF30;
                      RTS                                 ;;AF2F|AF33/AF33\AF33; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03AF34:          db $F4,$FF,$0C,$19,$24,$19,$0C,$FF  ;;AF30|AF34/AF34\AF34;
DATA_03AF3C:          db $FC,$F6,$F4,$F6,$FC,$02,$04,$02  ;;AF38|AF3C/AF3C\AF3C;
DATA_03AF44:          db $05,$05,$05,$05,$45,$45,$45,$45  ;;AF40|AF44/AF44\AF44;
DATA_03AF4C:          db $34,$34,$34,$35,$35,$36,$36,$37  ;;AF48|AF4C/AF4C\AF4C;
                      db $38,$3A,$3E,$46,$54              ;;AF50|AF54/AF54\AF54;
                                                          ;;                   ;
CODE_03AF59:          JSR GetDrawInfoBnk3                 ;;AF55|AF59/AF59\AF59;
                      LDA.W !SpriteMisc157C,X             ;;AF58|AF5C/AF5C\AF5C;
                      STA.B !_4                           ;;AF5B|AF5F/AF5F\AF5F;
                      LDA.B !EffFrame                     ;;AF5D|AF61/AF61\AF61;
                      LSR A                               ;;AF5F|AF63/AF63\AF63;
                      LSR A                               ;;AF60|AF64/AF64\AF64;
                      AND.B #$07                          ;;AF61|AF65/AF65\AF65;
                      STA.B !_2                           ;;AF63|AF67/AF67\AF67;
                      LDA.B #$EC                          ;;AF65|AF69/AF69\AF69;
                      STA.W !SpriteOAMIndex,X             ;;AF67|AF6B/AF6B\AF6B;
                      TAY                                 ;;AF6A|AF6E/AF6E\AF6E;
                      PHX                                 ;;AF6B|AF6F/AF6F\AF6F;
                      LDX.B #$03                          ;;AF6C|AF70/AF70\AF70;
                    - PHX                                 ;;AF6E|AF72/AF72\AF72;
                      TXA                                 ;;AF6F|AF73/AF73\AF73;
                      ASL A                               ;;AF70|AF74/AF74\AF74;
                      ASL A                               ;;AF71|AF75/AF75\AF75;
                      ADC.B !_2                           ;;AF72|AF76/AF76\AF76;
                      AND.B #$07                          ;;AF74|AF78/AF78\AF78;
                      TAX                                 ;;AF76|AF7A/AF7A\AF7A;
                      LDA.B !_0                           ;;AF77|AF7B/AF7B\AF7B;
                      CLC                                 ;;AF79|AF7D/AF7D\AF7D;
                      ADC.W DATA_03AF34,X                 ;;AF7A|AF7E/AF7E\AF7E;
                      STA.W !OAMTileXPos+$100,Y           ;;AF7D|AF81/AF81\AF81;
                      LDA.B !_1                           ;;AF80|AF84/AF84\AF84;
                      CLC                                 ;;AF82|AF86/AF86\AF86;
                      ADC.W DATA_03AF3C,X                 ;;AF83|AF87/AF87\AF87;
                      STA.W !OAMTileYPos+$100,Y           ;;AF86|AF8A/AF8A\AF8A;
                      LDA.B #$59                          ;;AF89|AF8D/AF8D\AF8D;
                      STA.W !OAMTileNo+$100,Y             ;;AF8B|AF8F/AF8F\AF8F;
                      LDA.W DATA_03AF44,X                 ;;AF8E|AF92/AF92\AF92;
                      ORA.B !SpriteProperties             ;;AF91|AF95/AF95\AF95;
                      STA.W !OAMTileAttr+$100,Y           ;;AF93|AF97/AF97\AF97;
                      PLX                                 ;;AF96|AF9A/AF9A\AF9A;
                      INY                                 ;;AF97|AF9B/AF9B\AF9B;
                      INY                                 ;;AF98|AF9C/AF9C\AF9C;
                      INY                                 ;;AF99|AF9D/AF9D\AF9D;
                      INY                                 ;;AF9A|AF9E/AF9E\AF9E;
                      DEX                                 ;;AF9B|AF9F/AF9F\AF9F;
                      BPL -                               ;;AF9C|AFA0/AFA0\AFA0;
                      LDA.W !BrSwingCenterYPos+1          ;;AF9E|AFA2/AFA2\AFA2;
                      INC.W !BrSwingCenterYPos+1          ;;AFA1|AFA5/AFA5\AFA5;
                      LSR A                               ;;AFA4|AFA8/AFA8\AFA8;
                      LSR A                               ;;AFA5|AFA9/AFA9\AFA9;
                      LSR A                               ;;AFA6|AFAA/AFAA\AFAA;
                      CMP.B #$0D                          ;;AFA7|AFAB/AFAB\AFAB;
                      BCS +                               ;;AFA9|AFAD/AFAD\AFAD;
                      TAX                                 ;;AFAB|AFAF/AFAF\AFAF;
                      LDY.B #$FC                          ;;AFAC|AFB0/AFB0\AFB0;
                      LDA.B !_4                           ;;AFAE|AFB2/AFB2\AFB2;
                      ASL A                               ;;AFB0|AFB4/AFB4\AFB4;
                      ROL A                               ;;AFB1|AFB5/AFB5\AFB5;
                      ASL A                               ;;AFB2|AFB6/AFB6\AFB6;
                      ASL A                               ;;AFB3|AFB7/AFB7\AFB7;
                      ASL A                               ;;AFB4|AFB8/AFB8\AFB8;
                      ADC.B !_0                           ;;AFB5|AFB9/AFB9\AFB9;
                      CLC                                 ;;AFB7|AFBB/AFBB\AFBB;
                      ADC.B #$15                          ;;AFB8|AFBC/AFBC\AFBC;
                      STA.W !OAMTileXPos+$100,Y           ;;AFBA|AFBE/AFBE\AFBE;
                      LDA.B !_1                           ;;AFBD|AFC1/AFC1\AFC1;
                      CLC                                 ;;AFBF|AFC3/AFC3\AFC3;
                      ADC.L DATA_03AF4C,X                 ;;AFC0|AFC4/AFC4\AFC4;
                      STA.W !OAMTileYPos+$100,Y           ;;AFC4|AFC8/AFC8\AFC8;
                      LDA.B #$49                          ;;AFC7|AFCB/AFCB\AFCB;
                      STA.W !OAMTileNo+$100,Y             ;;AFC9|AFCD/AFCD\AFCD;
                      LDA.B #$07                          ;;AFCC|AFD0/AFD0\AFD0;
                      ORA.B !SpriteProperties             ;;AFCE|AFD2/AFD2\AFD2;
                      STA.W !OAMTileAttr+$100,Y           ;;AFD0|AFD4/AFD4\AFD4;
                    + PLX                                 ;;AFD3|AFD7/AFD7\AFD7;
                      LDY.B #$00                          ;;AFD4|AFD8/AFD8\AFD8;
                      LDA.B #$04                          ;;AFD6|AFDA/AFDA\AFDA;
                      JSL FinishOAMWrite                  ;;AFD8|AFDC/AFDC\AFDC;
                      LDY.W !SpriteOAMIndex,X             ;;AFDC|AFE0/AFE0\AFE0; Y = Index into sprite OAM 
                      PHX                                 ;;AFDF|AFE3/AFE3\AFE3;
                      LDX.B #$04                          ;;AFE0|AFE4/AFE4\AFE4;
                    - LDA.W !OAMTileXPos+$100,Y           ;;AFE2|AFE6/AFE6\AFE6;
                      STA.W !OAMTileXPos,Y                ;;AFE5|AFE9/AFE9\AFE9;
                      LDA.W !OAMTileYPos+$100,Y           ;;AFE8|AFEC/AFEC\AFEC;
                      STA.W !OAMTileYPos,Y                ;;AFEB|AFEF/AFEF\AFEF;
                      LDA.W !OAMTileNo+$100,Y             ;;AFEE|AFF2/AFF2\AFF2;
                      STA.W !OAMTileNo,Y                  ;;AFF1|AFF5/AFF5\AFF5;
                      LDA.W !OAMTileAttr+$100,Y           ;;AFF4|AFF8/AFF8\AFF8;
                      STA.W !OAMTileAttr,Y                ;;AFF7|AFFB/AFFB\AFFB;
                      PHY                                 ;;AFFA|AFFE/AFFE\AFFE;
                      TYA                                 ;;AFFB|AFFF/AFFF\AFFF;
                      LSR A                               ;;AFFC|B000/B000\B000;
                      LSR A                               ;;AFFD|B001/B001\B001;
                      TAY                                 ;;AFFE|B002/B002\B002;
                      LDA.W !OAMTileSize+$40,Y            ;;AFFF|B003/B003\B003;
                      STA.W !OAMTileSize,Y                ;;B002|B006/B006\B006;
                      PLY                                 ;;B005|B009/B009\B009;
                      INY                                 ;;B006|B00A/B00A\B00A;
                      INY                                 ;;B007|B00B/B00B\B00B;
                      INY                                 ;;B008|B00C/B00C\B00C;
                      INY                                 ;;B009|B00D/B00D\B00D;
                      DEX                                 ;;B00A|B00E/B00E\B00E;
                      BPL -                               ;;B00B|B00F/B00F\B00F;
                      PLX                                 ;;B00D|B011/B011\B011;
                      RTS                                 ;;B00E|B012/B012\B012; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03B013:          db $00,$10                          ;;B00F|B013/B013\B013;
                                                          ;;                   ;
DATA_03B015:          db $00,$00                          ;;B011|B015/B015\B015;
                                                          ;;                   ;
DATA_03B017:          db $F8,$08                          ;;B013|B017/B017\B017;
                                                          ;;                   ;
CODE_03B019:          STZ.B !_2                           ;;B015|B019/B019\B019;
                      JSR CODE_03B020                     ;;B017|B01B/B01B\B01B;
                      INC.B !_2                           ;;B01A|B01E/B01E\B01E;
CODE_03B020:          LDY.B #$01                          ;;B01C|B020/B020\B020;
CODE_03B022:          LDA.W !SpriteStatus,Y               ;;B01E|B022/B022\B022;
                      BEQ CODE_03B02B                     ;;B021|B025/B025\B025;
                      DEY                                 ;;B023|B027/B027\B027;
                      BPL CODE_03B022                     ;;B024|B028/B028\B028;
                      RTS                                 ;;B026|B02A/B02A\B02A; Return 
                                                          ;;                   ;
CODE_03B02B:          LDA.B #$08                          ;;B027|B02B/B02B\B02B; \ Sprite status = Normal 
                      STA.W !SpriteStatus,Y               ;;B029|B02D/B02D\B02D; / 
                      LDA.B #$A2                          ;;B02C|B030/B030\B030;
                      STA.W !SpriteNumber,Y               ;;B02E|B032/B032\B032;
                      LDA.B !SpriteYPosLow,X              ;;B031|B035/B035\B035;
                      CLC                                 ;;B033|B037/B037\B037;
                      ADC.B #$10                          ;;B034|B038/B038\B038;
                      STA.W !SpriteYPosLow,Y              ;;B036|B03A/B03A\B03A;
                      LDA.W !SpriteXPosHigh,X             ;;B039|B03D/B03D\B03D;
                      ADC.B #$00                          ;;B03C|B040/B040\B040;
                      STA.W !SpriteXPosHigh,Y             ;;B03E|B042/B042\B042;
                      LDA.B !SpriteXPosLow,X              ;;B041|B045/B045\B045;
                      STA.B !_0                           ;;B043|B047/B047\B047;
                      LDA.W !SpriteYPosHigh,X             ;;B045|B049/B049\B049;
                      STA.B !_1                           ;;B048|B04C/B04C\B04C;
                      PHX                                 ;;B04A|B04E/B04E\B04E;
                      LDX.B !_2                           ;;B04B|B04F/B04F\B04F;
                      LDA.B !_0                           ;;B04D|B051/B051\B051;
                      CLC                                 ;;B04F|B053/B053\B053;
                      ADC.W DATA_03B013,X                 ;;B050|B054/B054\B054;
                      STA.W !SpriteXPosLow,Y              ;;B053|B057/B057\B057;
                      LDA.B !_1                           ;;B056|B05A/B05A\B05A;
                      ADC.W DATA_03B015,X                 ;;B058|B05C/B05C\B05C;
                      STA.W !SpriteYPosHigh,Y             ;;B05B|B05F/B05F\B05F;
                      TYX                                 ;;B05E|B062/B062\B062;
                      JSL InitSpriteTables                ;;B05F|B063/B063\B063;
                      LDY.B !_2                           ;;B063|B067/B067\B067;
                      LDA.W DATA_03B017,Y                 ;;B065|B069/B069\B069;
                      STA.B !SpriteXSpeed,X               ;;B068|B06C/B06C\B06C;
                      LDA.B #$C0                          ;;B06A|B06E/B06E\B06E;
                      STA.B !SpriteYSpeed,X               ;;B06C|B070/B070\B070;
                      PLX                                 ;;B06E|B072/B072\B072;
                      RTS                                 ;;B06F|B073/B073\B073; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03B074:          db $40,$C0                          ;;B070|B074/B074\B074;
                                                          ;;                   ;
DATA_03B076:          db $10,$F0                          ;;B072|B076/B076\B076;
                                                          ;;                   ;
CODE_03B078:          LDA.B !Mode7XScale                  ;;B074|B078/B078\B078;
                      CMP.B #$20                          ;;B076|B07A/B07A\B07A;
                      BNE Return03B0DB                    ;;B078|B07C/B07C\B07C;
                      LDA.W !SpriteMisc151C,X             ;;B07A|B07E/B07E\B07E;
                      CMP.B #$07                          ;;B07D|B081/B081\B081;
                      BCC Return03B0F2                    ;;B07F|B083/B083\B083;
                      LDA.B !Mode7Angle                   ;;B081|B085/B085\B085;
                      ORA.B !Mode7Angle+1                 ;;B083|B087/B087\B087;
                      BNE Return03B0F2                    ;;B085|B089/B089\B089;
                      JSR CODE_03B0DC                     ;;B087|B08B/B08B\B08B;
                      LDA.W !SpriteMisc154C,X             ;;B08A|B08E/B08E\B08E;
                      BNE Return03B0DB                    ;;B08D|B091/B091\B091;
                      LDA.B #$24                          ;;B08F|B093/B093\B093;
                      STA.W !SpriteTweakerB,X             ;;B091|B095/B095\B095;
                      JSL MarioSprInteract                ;;B094|B098/B098\B098;
                      BCC CODE_03B0BD                     ;;B098|B09C/B09C\B09C;
                      JSR CODE_03B0D6                     ;;B09A|B09E/B09E\B09E;
                      STZ.B !PlayerYSpeed                 ;;B09D|B0A1/B0A1\B0A1;
                      JSR SubHorzPosBnk3                  ;;B09F|B0A3/B0A3\B0A3;
                      LDA.W !BrSwingCenterXPos+1          ;;B0A2|B0A6/B0A6\B0A6;
                      ORA.W !BrSwingYDist                 ;;B0A5|B0A9/B0A9\B0A9;
                      BEQ CODE_03B0B3                     ;;B0A8|B0AC/B0AC\B0AC;
                      LDA.W DATA_03B076,Y                 ;;B0AA|B0AE/B0AE\B0AE;
                      BRA +                               ;;B0AD|B0B1/B0B1\B0B1;
                                                          ;;                   ;
CODE_03B0B3:          LDA.W DATA_03B074,Y                 ;;B0AF|B0B3/B0B3\B0B3;
                    + STA.B !PlayerXSpeed                 ;;B0B2|B0B6/B0B6\B0B6;
                      LDA.B #$01                          ;;B0B4|B0B8/B0B8\B0B8; \ Play sound effect 
                      STA.W !SPCIO0                       ;;B0B6|B0BA/B0BA\B0BA; / 
CODE_03B0BD:          INC.W !SpriteTweakerB,X             ;;B0B9|B0BD/B0BD\B0BD;
                      JSL MarioSprInteract                ;;B0BC|B0C0/B0C0\B0C0;
                      BCC +                               ;;B0C0|B0C4/B0C4\B0C4;
                      JSR CODE_03B0D2                     ;;B0C2|B0C6/B0C6\B0C6;
                    + INC.W !SpriteTweakerB,X             ;;B0C5|B0C9/B0C9\B0C9;
                      JSL MarioSprInteract                ;;B0C8|B0CC/B0CC\B0CC;
                      BCC Return03B0DB                    ;;B0CC|B0D0/B0D0\B0D0;
CODE_03B0D2:          JSL HurtMario                       ;;B0CE|B0D2/B0D2\B0D2;
CODE_03B0D6:          LDA.B #$20                          ;;B0D2|B0D6/B0D6\B0D6;
                      STA.W !SpriteMisc154C,X             ;;B0D4|B0D8/B0D8\B0D8;
Return03B0DB:         RTS                                 ;;B0D7|B0DB/B0DB\B0DB; Return 
                                                          ;;                   ;
CODE_03B0DC:          LDY.B #$01                          ;;B0D8|B0DC/B0DC\B0DC;
CODE_03B0DE:          PHY                                 ;;B0DA|B0DE/B0DE\B0DE;
                      LDA.W !SpriteStatus,Y               ;;B0DB|B0DF/B0DF\B0DF;
                      CMP.B #$09                          ;;B0DE|B0E2/B0E2\B0E2;
                      BNE +                               ;;B0E0|B0E4/B0E4\B0E4;
                      LDA.W !SpriteOffscreenX,Y           ;;B0E2|B0E6/B0E6\B0E6;
                      BNE +                               ;;B0E5|B0E9/B0E9\B0E9;
                      JSR CODE_03B0F3                     ;;B0E7|B0EB/B0EB\B0EB;
                    + PLY                                 ;;B0EA|B0EE/B0EE\B0EE;
                      DEY                                 ;;B0EB|B0EF/B0EF\B0EF;
                      BPL CODE_03B0DE                     ;;B0EC|B0F0/B0F0\B0F0;
Return03B0F2:         RTS                                 ;;B0EE|B0F2/B0F2\B0F2; Return 
                                                          ;;                   ;
CODE_03B0F3:          PHX                                 ;;B0EF|B0F3/B0F3\B0F3;
                      TYX                                 ;;B0F0|B0F4/B0F4\B0F4;
                      JSL GetSpriteClippingB              ;;B0F1|B0F5/B0F5\B0F5;
                      PLX                                 ;;B0F5|B0F9/B0F9\B0F9;
                      LDA.B #$24                          ;;B0F6|B0FA/B0FA\B0FA;
                      STA.W !SpriteTweakerB,X             ;;B0F8|B0FC/B0FC\B0FC;
                      JSL GetSpriteClippingA              ;;B0FB|B0FF/B0FF\B0FF;
                      JSL CheckForContact                 ;;B0FF|B103/B103\B103;
                      BCS CODE_03B142                     ;;B103|B107/B107\B107;
                      INC.W !SpriteTweakerB,X             ;;B105|B109/B109\B109;
                      JSL GetSpriteClippingA              ;;B108|B10C/B10C\B10C;
                      JSL CheckForContact                 ;;B10C|B110/B110\B110;
                      BCC Return03B160                    ;;B110|B114/B114\B114;
                      LDA.W !BrSwingXDist+1               ;;B112|B116/B116\B116;
                      BNE Return03B160                    ;;B115|B119/B119\B119;
                      LDA.B #$4C                          ;;B117|B11B/B11B\B11B;
                      STA.W !BrSwingXDist+1               ;;B119|B11D/B11D\B11D;
                      STZ.W !BrSwingCenterYPos+1          ;;B11C|B120/B120\B120;
                      LDA.W !SpriteMisc151C,X             ;;B11F|B123/B123\B123;
                      STA.W !BrSwingXDist                 ;;B122|B126/B126\B126;
                      LDA.B #$28                          ;;B125|B129/B129\B129; \ Play sound effect 
                      STA.W !SPCIO3                       ;;B127|B12B/B12B\B12B; / 
                      LDA.W !SpriteMisc151C,X             ;;B12A|B12E/B12E\B12E;
                      CMP.B #$09                          ;;B12D|B131/B131\B131;
                      BNE CODE_03B142                     ;;B12F|B133/B133\B133;
                      LDA.W !SpriteMisc187B,X             ;;B131|B135/B135\B135;
                      CMP.B #$01                          ;;B134|B138/B138\B138;
                      BNE CODE_03B142                     ;;B136|B13A/B13A\B13A;
                      PHY                                 ;;B138|B13C/B13C\B13C;
                      JSL KillMostSprites                 ;;B139|B13D/B13D\B13D;
                      PLY                                 ;;B13D|B141/B141\B141;
CODE_03B142:          LDA.B #$00                          ;;B13E|B142/B142\B142;
                      STA.W !SpriteXSpeed,Y               ;;B140|B144/B144\B144;
                      PHX                                 ;;B143|B147/B147\B147;
                      LDX.B #$10                          ;;B144|B148/B148\B148;
                      LDA.W !SpriteYSpeed,Y               ;;B146|B14A/B14A\B14A;
                      BMI +                               ;;B149|B14D/B14D\B14D;
                      LDX.B #$D0                          ;;B14B|B14F/B14F\B14F;
                    + TXA                                 ;;B14D|B151/B151\B151;
                      STA.W !SpriteYSpeed,Y               ;;B14E|B152/B152\B152;
                      LDA.B #$02                          ;;B151|B155/B155\B155; \ Sprite status = Killed 
                      STA.W !SpriteStatus,Y               ;;B153|B157/B157\B157; / 
                      TYX                                 ;;B156|B15A/B15A\B15A;
                      JSL CODE_01AB6F                     ;;B157|B15B/B15B\B15B;
                      PLX                                 ;;B15B|B15F/B15F\B15F;
Return03B160:         RTS                                 ;;B15C|B160/B160\B160; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BowserBallSpeed:      db $10,$F0                          ;;B15D|B161/B161\B161;
                                                          ;;                   ;
BowserBowlingBall:    JSR BowserBallGfx                   ;;B15F|B163/B163\B163;
                      LDA.B !SpriteLock                   ;;B162|B166/B166\B166;
                      BNE Return03B1D4                    ;;B164|B168/B168\B168;
                      JSR SubOffscreen0Bnk3               ;;B166|B16A/B16A\B16A;
                      JSL MarioSprInteract                ;;B169|B16D/B16D\B16D;
                      JSL UpdateXPosNoGvtyW               ;;B16D|B171/B171\B171;
                      JSL UpdateYPosNoGvtyW               ;;B171|B175/B175\B175;
                      LDA.B !SpriteYSpeed,X               ;;B175|B179/B179\B179;
                      CMP.B #$40                          ;;B177|B17B/B17B\B17B;
                      BPL CODE_03B186                     ;;B179|B17D/B17D\B17D;
                      CLC                                 ;;B17B|B17F/B17F\B17F;
                      ADC.B #$03                          ;;B17C|B180/B180\B180;
                      STA.B !SpriteYSpeed,X               ;;B17E|B182/B182\B182;
                      BRA +                               ;;B180|B184/B184\B184;
                                                          ;;                   ;
CODE_03B186:          LDA.B #$40                          ;;B182|B186/B186\B186;
                      STA.B !SpriteYSpeed,X               ;;B184|B188/B188\B188;
                    + LDA.B !SpriteYSpeed,X               ;;B186|B18A/B18A\B18A;
                      BMI CODE_03B1C5                     ;;B188|B18C/B18C\B18C;
                      LDA.W !SpriteXPosHigh,X             ;;B18A|B18E/B18E\B18E;
                      BMI CODE_03B1C5                     ;;B18D|B191/B191\B191;
                      LDA.B !SpriteYPosLow,X              ;;B18F|B193/B193\B193;
                      CMP.B #con($B0,$B0,$B0,$C0)         ;;B191|B195/B195\B195;
                      BCC CODE_03B1C5                     ;;B193|B197/B197\B197;
                      LDA.B #con($B0,$B0,$B0,$C0)         ;;B195|B199/B199\B199;
                      STA.B !SpriteYPosLow,X              ;;B197|B19B/B19B\B19B;
                      LDA.B !SpriteYSpeed,X               ;;B199|B19D/B19D\B19D;
                      CMP.B #$3E                          ;;B19B|B19F/B19F\B19F;
                      BCC +                               ;;B19D|B1A1/B1A1\B1A1;
                      LDY.B #$25                          ;;B19F|B1A3/B1A3\B1A3; \ Play sound effect 
                      STY.W !SPCIO3                       ;;B1A1|B1A5/B1A5\B1A5; / 
                      LDY.B #$20                          ;;B1A4|B1A8/B1A8\B1A8; \ Set ground shake timer 
                      STY.W !ScreenShakeTimer             ;;B1A6|B1AA/B1AA\B1AA; / 
                    + CMP.B #$08                          ;;B1A9|B1AD/B1AD\B1AD;
                      BCC +                               ;;B1AB|B1AF/B1AF\B1AF;
                      LDA.B #$01                          ;;B1AD|B1B1/B1B1\B1B1; \ Play sound effect 
                      STA.W !SPCIO0                       ;;B1AF|B1B3/B1B3\B1B3; / 
                    + JSR CODE_03B7F8                     ;;B1B2|B1B6/B1B6\B1B6;
                      LDA.B !SpriteXSpeed,X               ;;B1B5|B1B9/B1B9\B1B9;
                      BNE CODE_03B1C5                     ;;B1B7|B1BB/B1BB\B1BB;
                      JSR SubHorzPosBnk3                  ;;B1B9|B1BD/B1BD\B1BD;
                      LDA.W BowserBallSpeed,Y             ;;B1BC|B1C0/B1C0\B1C0;
                      STA.B !SpriteXSpeed,X               ;;B1BF|B1C3/B1C3\B1C3;
CODE_03B1C5:          LDA.B !SpriteXSpeed,X               ;;B1C1|B1C5/B1C5\B1C5;
                      BEQ Return03B1D4                    ;;B1C3|B1C7/B1C7\B1C7;
                      BMI +                               ;;B1C5|B1C9/B1C9\B1C9;
                      DEC.W !SpriteMisc1570,X             ;;B1C7|B1CB/B1CB\B1CB;
                      DEC.W !SpriteMisc1570,X             ;;B1CA|B1CE/B1CE\B1CE;
                    + INC.W !SpriteMisc1570,X             ;;B1CD|B1D1/B1D1\B1D1;
Return03B1D4:         RTS                                 ;;B1D0|B1D4/B1D4\B1D4; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BowserBallDispX:      db $F0,$00,$10,$F0,$00,$10,$F0,$00  ;;B1D1|B1D5/B1D5\B1D5;
                      db $10,$00,$00,$F8                  ;;B1D9|B1DD/B1DD\B1DD;
                                                          ;;                   ;
BowserBallDispY:      db $E2,$E2,$E2,$F2,$F2,$F2,$02,$02  ;;B1DD|B1E1/B1E1\B1E1;
                      db $02,$02,$02,$EA                  ;;B1E5|B1E9/B1E9\B1E9;
                                                          ;;                   ;
BowserBallTiles:      db $45,$47,$45,$65,$66,$65,$45,$47  ;;B1E9|B1ED/B1ED\B1ED;
                      db $45,$39,$38,$63                  ;;B1F1|B1F5/B1F5\B1F5;
                                                          ;;                   ;
BowserBallGfxProp:    db $0D,$0D,$4D,$0D,$0D,$4D,$8D,$8D  ;;B1F5|B1F9/B1F9\B1F9;
                      db $CD,$0D,$0D,$0D                  ;;B1FD|B201/B201\B201;
                                                          ;;                   ;
BowserBallTileSize:   db $02,$02,$02,$02,$02,$02,$02,$02  ;;B201|B205/B205\B205;
                      db $02,$00,$00,$02                  ;;B209|B20D/B20D\B20D;
                                                          ;;                   ;
BowserBallDispX2:     db $04,$0D,$10,$0D,$04,$FB,$F8,$FB  ;;B20D|B211/B211\B211;
BowserBallDispY2:     db $00,$FD,$F4,$EB,$E8,$EB,$F4,$FD  ;;B215|B219/B219\B219;
                                                          ;;                   ;
BowserBallGfx:        LDA.B #$70                          ;;B21D|B221/B221\B221;
                      STA.W !SpriteOAMIndex,X             ;;B21F|B223/B223\B223;
                      JSR GetDrawInfoBnk3                 ;;B222|B226/B226\B226;
                      PHX                                 ;;B225|B229/B229\B229;
                      LDX.B #$0B                          ;;B226|B22A/B22A\B22A;
                    - LDA.B !_0                           ;;B228|B22C/B22C\B22C;
                      CLC                                 ;;B22A|B22E/B22E\B22E;
                      ADC.W BowserBallDispX,X             ;;B22B|B22F/B22F\B22F;
                      STA.W !OAMTileXPos+$100,Y           ;;B22E|B232/B232\B232;
                      LDA.B !_1                           ;;B231|B235/B235\B235;
                      CLC                                 ;;B233|B237/B237\B237;
                      ADC.W BowserBallDispY,X             ;;B234|B238/B238\B238;
                      STA.W !OAMTileYPos+$100,Y           ;;B237|B23B/B23B\B23B;
                      LDA.W BowserBallTiles,X             ;;B23A|B23E/B23E\B23E;
                      STA.W !OAMTileNo+$100,Y             ;;B23D|B241/B241\B241;
                      LDA.W BowserBallGfxProp,X           ;;B240|B244/B244\B244;
                      ORA.B !SpriteProperties             ;;B243|B247/B247\B247;
                      STA.W !OAMTileAttr+$100,Y           ;;B245|B249/B249\B249;
                      PHY                                 ;;B248|B24C/B24C\B24C;
                      TYA                                 ;;B249|B24D/B24D\B24D;
                      LSR A                               ;;B24A|B24E/B24E\B24E;
                      LSR A                               ;;B24B|B24F/B24F\B24F;
                      TAY                                 ;;B24C|B250/B250\B250;
                      LDA.W BowserBallTileSize,X          ;;B24D|B251/B251\B251;
                      STA.W !OAMTileSize+$40,Y            ;;B250|B254/B254\B254;
                      PLY                                 ;;B253|B257/B257\B257;
                      INY                                 ;;B254|B258/B258\B258;
                      INY                                 ;;B255|B259/B259\B259;
                      INY                                 ;;B256|B25A/B25A\B25A;
                      INY                                 ;;B257|B25B/B25B\B25B;
                      DEX                                 ;;B258|B25C/B25C\B25C;
                      BPL -                               ;;B259|B25D/B25D\B25D;
                      PLX                                 ;;B25B|B25F/B25F\B25F;
                      PHX                                 ;;B25C|B260/B260\B260;
                      LDY.W !SpriteOAMIndex,X             ;;B25D|B261/B261\B261; Y = Index into sprite OAM 
                      LDA.W !SpriteMisc1570,X             ;;B260|B264/B264\B264;
                      LSR A                               ;;B263|B267/B267\B267;
                      LSR A                               ;;B264|B268/B268\B268;
                      LSR A                               ;;B265|B269/B269\B269;
                      AND.B #$07                          ;;B266|B26A/B26A\B26A;
                      PHA                                 ;;B268|B26C/B26C\B26C;
                      TAX                                 ;;B269|B26D/B26D\B26D;
                      LDA.W !OAMTileXPos+$104,Y           ;;B26A|B26E/B26E\B26E;
                      CLC                                 ;;B26D|B271/B271\B271;
                      ADC.W BowserBallDispX2,X            ;;B26E|B272/B272\B272;
                      STA.W !OAMTileXPos+$104,Y           ;;B271|B275/B275\B275;
                      LDA.W !OAMTileYPos+$104,Y           ;;B274|B278/B278\B278;
                      CLC                                 ;;B277|B27B/B27B\B27B;
                      ADC.W BowserBallDispY2,X            ;;B278|B27C/B27C\B27C;
                      STA.W !OAMTileYPos+$104,Y           ;;B27B|B27F/B27F\B27F;
                      PLA                                 ;;B27E|B282/B282\B282;
                      CLC                                 ;;B27F|B283/B283\B283;
                      ADC.B #$02                          ;;B280|B284/B284\B284;
                      AND.B #$07                          ;;B282|B286/B286\B286;
                      TAX                                 ;;B284|B288/B288\B288;
                      LDA.W !OAMTileXPos+$108,Y           ;;B285|B289/B289\B289;
                      CLC                                 ;;B288|B28C/B28C\B28C;
                      ADC.W BowserBallDispX2,X            ;;B289|B28D/B28D\B28D;
                      STA.W !OAMTileXPos+$108,Y           ;;B28C|B290/B290\B290;
                      LDA.W !OAMTileYPos+$108,Y           ;;B28F|B293/B293\B293;
                      CLC                                 ;;B292|B296/B296\B296;
                      ADC.W BowserBallDispY2,X            ;;B293|B297/B297\B297;
                      STA.W !OAMTileYPos+$108,Y           ;;B296|B29A/B29A\B29A;
                      PLX                                 ;;B299|B29D/B29D\B29D;
                      LDA.B #$0B                          ;;B29A|B29E/B29E\B29E;
                      LDY.B #$FF                          ;;B29C|B2A0/B2A0\B2A0;
                      JSL FinishOAMWrite                  ;;B29E|B2A2/B2A2\B2A2;
                      RTS                                 ;;B2A2|B2A6/B2A6\B2A6; Return 
                                                          ;;                   ;
                                                          ;;                   ;
MechakoopaSpeed:      db $08,$F8                          ;;B2A3|B2A7/B2A7\B2A7;
                                                          ;;                   ;
MechaKoopa:           JSL CODE_03B307                     ;;B2A5|B2A9/B2A9\B2A9;
                      LDA.W !SpriteStatus,X               ;;B2A9|B2AD/B2AD\B2AD;
                      CMP.B #$08                          ;;B2AC|B2B0/B2B0\B2B0;
                      BNE Return03B306                    ;;B2AE|B2B2/B2B2\B2B2;
                      LDA.B !SpriteLock                   ;;B2B0|B2B4/B2B4\B2B4;
                      BNE Return03B306                    ;;B2B2|B2B6/B2B6\B2B6;
                      JSR SubOffscreen0Bnk3               ;;B2B4|B2B8/B2B8\B2B8;
                      JSL SprSpr_MarioSprRts              ;;B2B7|B2BB/B2BB\B2BB;
                      JSL UpdateSpritePos                 ;;B2BB|B2BF/B2BF\B2BF;
                      LDA.W !SpriteBlockedDirs,X          ;;B2BF|B2C3/B2C3\B2C3; \ Branch if not on ground 
                      AND.B #$04                          ;;B2C2|B2C6/B2C6\B2C6;  | 
                      BEQ +                               ;;B2C4|B2C8/B2C8\B2C8; / 
                      STZ.B !SpriteYSpeed,X               ;;B2C6|B2CA/B2CA\B2CA; Sprite Y Speed = 0 
                      LDY.W !SpriteMisc157C,X             ;;B2C8|B2CC/B2CC\B2CC;
                      LDA.W MechakoopaSpeed,Y             ;;B2CB|B2CF/B2CF\B2CF;
                      STA.B !SpriteXSpeed,X               ;;B2CE|B2D2/B2D2\B2D2;
                      LDA.B !SpriteTableC2,X              ;;B2D0|B2D4/B2D4\B2D4;
                      INC.B !SpriteTableC2,X              ;;B2D2|B2D6/B2D6\B2D6;
                      AND.B #$3F                          ;;B2D4|B2D8/B2D8\B2D8;
                      BNE +                               ;;B2D6|B2DA/B2DA\B2DA;
                      JSR SubHorzPosBnk3                  ;;B2D8|B2DC/B2DC\B2DC;
                      TYA                                 ;;B2DB|B2DF/B2DF\B2DF;
                      STA.W !SpriteMisc157C,X             ;;B2DC|B2E0/B2E0\B2E0;
                    + LDA.W !SpriteBlockedDirs,X          ;;B2DF|B2E3/B2E3\B2E3; \ Branch if not touching object 
                      AND.B #$03                          ;;B2E2|B2E6/B2E6\B2E6;  | 
                      BEQ +                               ;;B2E4|B2E8/B2E8\B2E8; / 
                      LDA.B !SpriteXSpeed,X               ;;B2E6|B2EA/B2EA\B2EA;
                      EOR.B #$FF                          ;;B2E8|B2EC/B2EC\B2EC;
                      INC A                               ;;B2EA|B2EE/B2EE\B2EE;
                      STA.B !SpriteXSpeed,X               ;;B2EB|B2EF/B2EF\B2EF;
                      LDA.W !SpriteMisc157C,X             ;;B2ED|B2F1/B2F1\B2F1;
                      EOR.B #$01                          ;;B2F0|B2F4/B2F4\B2F4;
                      STA.W !SpriteMisc157C,X             ;;B2F2|B2F6/B2F6\B2F6;
                    + INC.W !SpriteMisc1570,X             ;;B2F5|B2F9/B2F9\B2F9;
                      LDA.W !SpriteMisc1570,X             ;;B2F8|B2FC/B2FC\B2FC;
                      AND.B #$0C                          ;;B2FB|B2FF/B2FF\B2FF;
                      LSR A                               ;;B2FD|B301/B301\B301;
                      LSR A                               ;;B2FE|B302/B302\B302;
                      STA.W !SpriteMisc1602,X             ;;B2FF|B303/B303\B303;
Return03B306:         RTS                                 ;;B302|B306/B306\B306; Return 
                                                          ;;                   ;
CODE_03B307:          PHB                                 ;;B303|B307/B307\B307; Wrapper 
                      PHK                                 ;;B304|B308/B308\B308;
                      PLB                                 ;;B305|B309/B309\B309;
                      JSR MechaKoopaGfx                   ;;B306|B30A/B30A\B30A;
                      PLB                                 ;;B309|B30D/B30D\B30D;
                      RTL                                 ;;B30A|B30E/B30E\B30E; Return 
                                                          ;;                   ;
                                                          ;;                   ;
MechakoopaDispX:      db $F8,$08,$F8,$00,$08,$00,$10,$00  ;;B30B|B30F/B30F\B30F;
MechakoopaDispY:      db $F8,$F8,$08,$00,$F9,$F9,$09,$00  ;;B313|B317/B317\B317;
                      db $F8,$F8,$08,$00,$F9,$F9,$09,$00  ;;B31B|B31F/B31F\B31F;
                      db $FD,$00,$05,$00,$00,$00,$08,$00  ;;B323|B327/B327\B327;
MechakoopaTiles:      db $40,$42,$60,$51,$40,$42,$60,$0A  ;;B32B|B32F/B32F\B32F;
                      db $40,$42,$60,$0C,$40,$42,$60,$0E  ;;B333|B337/B337\B337;
                      db $00,$02,$10,$01,$00,$02,$10,$01  ;;B33B|B33F/B33F\B33F;
MechakoopaGfxProp:    db $00,$00,$00,$00,$40,$40,$40,$40  ;;B343|B347/B347\B347;
MechakoopaTileSize:   db $02,$00,$00,$02                  ;;B34B|B34F/B34F\B34F;
                                                          ;;                   ;
MechakoopaPalette:    db $0B,$05                          ;;B34F|B353/B353\B353;
                                                          ;;                   ;
MechaKoopaGfx:        LDA.B #$0B                          ;;B351|B355/B355\B355;
                      STA.W !SpriteOBJAttribute,X         ;;B353|B357/B357\B357;
                      LDA.W !SpriteMisc1540,X             ;;B356|B35A/B35A\B35A;
                      BEQ CODE_03B37F                     ;;B359|B35D/B35D\B35D;
                      LDY.B #$05                          ;;B35B|B35F/B35F\B35F;
                      CMP.B #$05                          ;;B35D|B361/B361\B361;
                      BCC CODE_03B369                     ;;B35F|B363/B363\B363;
                      CMP.B #$FA                          ;;B361|B365/B365\B365;
                      BCC +                               ;;B363|B367/B367\B367;
CODE_03B369:          LDY.B #$04                          ;;B365|B369/B369\B369;
                    + TYA                                 ;;B367|B36B/B36B\B36B;
                      STA.W !SpriteMisc1602,X             ;;B368|B36C/B36C\B36C;
                      LDA.W !SpriteMisc1540,X             ;;B36B|B36F/B36F\B36F;
                      CMP.B #$30                          ;;B36E|B372/B372\B372;
                      BCS CODE_03B37F                     ;;B370|B374/B374\B374;
                      AND.B #$01                          ;;B372|B376/B376\B376;
                      TAY                                 ;;B374|B378/B378\B378;
                      LDA.W MechakoopaPalette,Y           ;;B375|B379/B379\B379;
                      STA.W !SpriteOBJAttribute,X         ;;B378|B37C/B37C\B37C;
CODE_03B37F:          JSR GetDrawInfoBnk3                 ;;B37B|B37F/B37F\B37F;
                      LDA.W !SpriteOBJAttribute,X         ;;B37E|B382/B382\B382;
                      STA.B !_4                           ;;B381|B385/B385\B385;
                      TYA                                 ;;B383|B387/B387\B387;
                      CLC                                 ;;B384|B388/B388\B388;
                      ADC.B #$0C                          ;;B385|B389/B389\B389;
                      TAY                                 ;;B387|B38B/B38B\B38B;
                      LDA.W !SpriteMisc1602,X             ;;B388|B38C/B38C\B38C;
                      ASL A                               ;;B38B|B38F/B38F\B38F;
                      ASL A                               ;;B38C|B390/B390\B390;
                      STA.B !_3                           ;;B38D|B391/B391\B391;
                      LDA.W !SpriteMisc157C,X             ;;B38F|B393/B393\B393;
                      ASL A                               ;;B392|B396/B396\B396;
                      ASL A                               ;;B393|B397/B397\B397;
                      EOR.B #$04                          ;;B394|B398/B398\B398;
                      STA.B !_2                           ;;B396|B39A/B39A\B39A;
                      PHX                                 ;;B398|B39C/B39C\B39C;
                      LDX.B #$03                          ;;B399|B39D/B39D\B39D;
                    - PHX                                 ;;B39B|B39F/B39F\B39F;
                      PHY                                 ;;B39C|B3A0/B3A0\B3A0;
                      TYA                                 ;;B39D|B3A1/B3A1\B3A1;
                      LSR A                               ;;B39E|B3A2/B3A2\B3A2;
                      LSR A                               ;;B39F|B3A3/B3A3\B3A3;
                      TAY                                 ;;B3A0|B3A4/B3A4\B3A4;
                      LDA.W MechakoopaTileSize,X          ;;B3A1|B3A5/B3A5\B3A5;
                      STA.W !OAMTileSize+$40,Y            ;;B3A4|B3A8/B3A8\B3A8;
                      PLY                                 ;;B3A7|B3AB/B3AB\B3AB;
                      PLA                                 ;;B3A8|B3AC/B3AC\B3AC;
                      PHA                                 ;;B3A9|B3AD/B3AD\B3AD;
                      CLC                                 ;;B3AA|B3AE/B3AE\B3AE;
                      ADC.B !_2                           ;;B3AB|B3AF/B3AF\B3AF;
                      TAX                                 ;;B3AD|B3B1/B3B1\B3B1;
                      LDA.B !_0                           ;;B3AE|B3B2/B3B2\B3B2;
                      CLC                                 ;;B3B0|B3B4/B3B4\B3B4;
                      ADC.W MechakoopaDispX,X             ;;B3B1|B3B5/B3B5\B3B5;
                      STA.W !OAMTileXPos+$100,Y           ;;B3B4|B3B8/B3B8\B3B8;
                      LDA.W MechakoopaGfxProp,X           ;;B3B7|B3BB/B3BB\B3BB;
                      ORA.B !_4                           ;;B3BA|B3BE/B3BE\B3BE;
                      ORA.B !SpriteProperties             ;;B3BC|B3C0/B3C0\B3C0;
                      STA.W !OAMTileAttr+$100,Y           ;;B3BE|B3C2/B3C2\B3C2;
                      PLA                                 ;;B3C1|B3C5/B3C5\B3C5;
                      PHA                                 ;;B3C2|B3C6/B3C6\B3C6;
                      CLC                                 ;;B3C3|B3C7/B3C7\B3C7;
                      ADC.B !_3                           ;;B3C4|B3C8/B3C8\B3C8;
                      TAX                                 ;;B3C6|B3CA/B3CA\B3CA;
                      LDA.W MechakoopaTiles,X             ;;B3C7|B3CB/B3CB\B3CB;
                      STA.W !OAMTileNo+$100,Y             ;;B3CA|B3CE/B3CE\B3CE;
                      LDA.B !_1                           ;;B3CD|B3D1/B3D1\B3D1;
                      CLC                                 ;;B3CF|B3D3/B3D3\B3D3;
                      ADC.W MechakoopaDispY,X             ;;B3D0|B3D4/B3D4\B3D4;
                      STA.W !OAMTileYPos+$100,Y           ;;B3D3|B3D7/B3D7\B3D7;
                      PLX                                 ;;B3D6|B3DA/B3DA\B3DA;
                      DEY                                 ;;B3D7|B3DB/B3DB\B3DB;
                      DEY                                 ;;B3D8|B3DC/B3DC\B3DC;
                      DEY                                 ;;B3D9|B3DD/B3DD\B3DD;
                      DEY                                 ;;B3DA|B3DE/B3DE\B3DE;
                      DEX                                 ;;B3DB|B3DF/B3DF\B3DF;
                      BPL -                               ;;B3DC|B3E0/B3E0\B3E0;
                      PLX                                 ;;B3DE|B3E2/B3E2\B3E2;
                      LDY.B #$FF                          ;;B3DF|B3E3/B3E3\B3E3;
                      LDA.B #$03                          ;;B3E1|B3E5/B3E5\B3E5;
                      JSL FinishOAMWrite                  ;;B3E3|B3E7/B3E7\B3E7;
                      JSR MechaKoopaKeyGfx                ;;B3E7|B3EB/B3EB\B3EB;
                      RTS                                 ;;B3EA|B3EE/B3EE\B3EE; Return 
                                                          ;;                   ;
                                                          ;;                   ;
MechaKeyDispX:        db $F9,$0F                          ;;B3EB|B3EF/B3EF\B3EF;
                                                          ;;                   ;
MechaKeyGfxProp:      db $4D,$0D                          ;;B3ED|B3F1/B3F1\B3F1;
                                                          ;;                   ;
MechaKeyTiles:        db $70,$71,$72,$71                  ;;B3EF|B3F3/B3F3\B3F3;
                                                          ;;                   ;
MechaKoopaKeyGfx:     LDA.W !SpriteOAMIndex,X             ;;B3F3|B3F7/B3F7\B3F7;
                      CLC                                 ;;B3F6|B3FA/B3FA\B3FA;
                      ADC.B #$10                          ;;B3F7|B3FB/B3FB\B3FB;
                      STA.W !SpriteOAMIndex,X             ;;B3F9|B3FD/B3FD\B3FD;
                      JSR GetDrawInfoBnk3                 ;;B3FC|B400/B400\B400;
                      PHX                                 ;;B3FF|B403/B403\B403;
                      LDA.W !SpriteMisc1570,X             ;;B400|B404/B404\B404;
                      LSR A                               ;;B403|B407/B407\B407;
                      LSR A                               ;;B404|B408/B408\B408;
                      AND.B #$03                          ;;B405|B409/B409\B409;
                      STA.B !_2                           ;;B407|B40B/B40B\B40B;
                      LDA.W !SpriteMisc157C,X             ;;B409|B40D/B40D\B40D;
                      TAX                                 ;;B40C|B410/B410\B410;
                      LDA.B !_0                           ;;B40D|B411/B411\B411;
                      CLC                                 ;;B40F|B413/B413\B413;
                      ADC.W MechaKeyDispX,X               ;;B410|B414/B414\B414;
                      STA.W !OAMTileXPos+$100,Y           ;;B413|B417/B417\B417;
                      LDA.B !_1                           ;;B416|B41A/B41A\B41A;
                      SEC                                 ;;B418|B41C/B41C\B41C;
                      SBC.B #$00                          ;;B419|B41D/B41D\B41D;
                      STA.W !OAMTileYPos+$100,Y           ;;B41B|B41F/B41F\B41F;
                      LDA.W MechaKeyGfxProp,X             ;;B41E|B422/B422\B422;
                      ORA.B !SpriteProperties             ;;B421|B425/B425\B425;
                      STA.W !OAMTileAttr+$100,Y           ;;B423|B427/B427\B427;
                      LDX.B !_2                           ;;B426|B42A/B42A\B42A;
                      LDA.W MechaKeyTiles,X               ;;B428|B42C/B42C\B42C;
                      STA.W !OAMTileNo+$100,Y             ;;B42B|B42F/B42F\B42F;
                      PLX                                 ;;B42E|B432/B432\B432;
                      LDY.B #$00                          ;;B42F|B433/B433\B433;
                      LDA.B #$00                          ;;B431|B435/B435\B435;
                      JSL FinishOAMWrite                  ;;B433|B437/B437\B437;
                      RTS                                 ;;B437|B43B/B43B\B43B; Return 
                                                          ;;                   ;
CODE_03B43C:          JSR BowserItemBoxGfx                ;;B438|B43C/B43C\B43C;
                      JSR BowserSceneGfx                  ;;B43B|B43F/B43F\B43F;
                      RTS                                 ;;B43E|B442/B442\B442; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BowserItemBoxPosX:    db $70,$80,$70,$80                  ;;B43F|B443/B443\B443;
                                                          ;;                   ;
BowserItemBoxPosY:    db $07,$07,$17,$17                  ;;B443|B447/B447\B447;
                                                          ;;                   ;
BowserItemBoxProp:    db $37,$77,$B7,$F7                  ;;B447|B44B/B44B\B44B;
                                                          ;;                   ;
BowserItemBoxGfx:     LDA.W !FinalCutscene                ;;B44B|B44F/B44F\B44F;
                      BEQ +                               ;;B44E|B452/B452\B452;
                      STZ.W !PlayerItembox                ;;B450|B454/B454\B454;
                    + LDA.W !PlayerItembox                ;;B453|B457/B457\B457;
                      BEQ Return03B48B                    ;;B456|B45A/B45A\B45A;
                      PHX                                 ;;B458|B45C/B45C\B45C;
                      LDX.B #$03                          ;;B459|B45D/B45D\B45D;
                      LDY.B #$04                          ;;B45B|B45F/B45F\B45F;
                    - LDA.W BowserItemBoxPosX,X           ;;B45D|B461/B461\B461;
                      STA.W !OAMTileXPos,Y                ;;B460|B464/B464\B464;
                      LDA.W BowserItemBoxPosY,X           ;;B463|B467/B467\B467;
                      STA.W !OAMTileYPos,Y                ;;B466|B46A/B46A\B46A;
                      LDA.B #$43                          ;;B469|B46D/B46D\B46D;
                      STA.W !OAMTileNo,Y                  ;;B46B|B46F/B46F\B46F;
                      LDA.W BowserItemBoxProp,X           ;;B46E|B472/B472\B472;
                      STA.W !OAMTileAttr,Y                ;;B471|B475/B475\B475;
                      PHY                                 ;;B474|B478/B478\B478;
                      TYA                                 ;;B475|B479/B479\B479;
                      LSR A                               ;;B476|B47A/B47A\B47A;
                      LSR A                               ;;B477|B47B/B47B\B47B;
                      TAY                                 ;;B478|B47C/B47C\B47C;
                      LDA.B #$02                          ;;B479|B47D/B47D\B47D;
                      STA.W !OAMTileSize,Y                ;;B47B|B47F/B47F\B47F;
                      PLY                                 ;;B47E|B482/B482\B482;
                      INY                                 ;;B47F|B483/B483\B483;
                      INY                                 ;;B480|B484/B484\B484;
                      INY                                 ;;B481|B485/B485\B485;
                      INY                                 ;;B482|B486/B486\B486;
                      DEX                                 ;;B483|B487/B487\B487;
                      BPL -                               ;;B484|B488/B488\B488;
                      PLX                                 ;;B486|B48A/B48A\B48A;
Return03B48B:         RTS                                 ;;B487|B48B/B48B\B48B; Return 
                                                          ;;                   ;
                                                          ;;                   ;
BowserRoofPosX:       db $00,$30,$60,$90,$C0,$F0,$00,$30  ;;B488|B48C/B48C\B48C;
                      db $40,$50,$60,$90,$A0,$B0,$C0,$F0  ;;B490|B494/B494\B494;
                   if !_VER != 3                ;\   IF   ;;+++++++++++++++++++; J, U, & E0
BowserRoofPosY:       db $B0,$B0,$B0,$B0,$B0,$B0,$D0,$D0  ;;B498|B49C/B49C     ;
                      db $D0,$D0,$D0,$D0,$D0,$D0,$D0,$D0  ;;B4A0|B4A4/B4A4     ;
                   else                         ;<  ELSE  ;;-------------------; E1
BowserRoofPosY:       db $C0,$C0,$C0,$C0,$C0,$C0,$E0,$E0  ;;              \B49C;
                      db $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0  ;;              \B4A4;
                   endif                        ;/ ENDIF  ;;+++++++++++++++++++;
                                                          ;;                   ;
BowserSceneGfx:       PHX                                 ;;B4A8|B4AC/B4AC\B4AC;
                      LDY.B #$BC                          ;;B4A9|B4AD/B4AD\B4AD;
                      STZ.B !_1                           ;;B4AB|B4AF/B4AF\B4AF;
                      LDA.W !FinalCutscene                ;;B4AD|B4B1/B4B1\B4B1;
                      STA.B !_F                           ;;B4B0|B4B4/B4B4\B4B4;
                      CMP.B #$01                          ;;B4B2|B4B6/B4B6\B4B6;
                      LDX.B #$10                          ;;B4B4|B4B8/B4B8\B4B8;
                      BCC CODE_03B4BF                     ;;B4B6|B4BA/B4BA\B4BA;
                      LDY.B #$90                          ;;B4B8|B4BC/B4BC\B4BC;
                      DEX                                 ;;B4BA|B4BE/B4BE\B4BE;
CODE_03B4BF:          LDA.B #con($C0,$C0,$C0,$D0)         ;;B4BB|B4BF/B4BF\B4BF;
                      SEC                                 ;;B4BD|B4C1/B4C1\B4C1;
                      SBC.B !Layer1YPos                   ;;B4BE|B4C2/B4C2\B4C2;
                      STA.W !OAMTileYPos+$100,Y           ;;B4C0|B4C4/B4C4\B4C4;
                      LDA.B !_1                           ;;B4C3|B4C7/B4C7\B4C7;
                      SEC                                 ;;B4C5|B4C9/B4C9\B4C9;
                      SBC.B !Layer1XPos                   ;;B4C6|B4CA/B4CA\B4CA;
                      STA.W !OAMTileXPos+$100,Y           ;;B4C8|B4CC/B4CC\B4CC;
                      CLC                                 ;;B4CB|B4CF/B4CF\B4CF;
                      ADC.B #$10                          ;;B4CC|B4D0/B4D0\B4D0;
                      STA.B !_1                           ;;B4CE|B4D2/B4D2\B4D2;
                      LDA.B #$08                          ;;B4D0|B4D4/B4D4\B4D4;
                      STA.W !OAMTileNo+$100,Y             ;;B4D2|B4D6/B4D6\B4D6;
                      LDA.B #$0D                          ;;B4D5|B4D9/B4D9\B4D9;
                      ORA.B !SpriteProperties             ;;B4D7|B4DB/B4DB\B4DB;
                      STA.W !OAMTileAttr+$100,Y           ;;B4D9|B4DD/B4DD\B4DD;
                      PHY                                 ;;B4DC|B4E0/B4E0\B4E0;
                      TYA                                 ;;B4DD|B4E1/B4E1\B4E1;
                      LSR A                               ;;B4DE|B4E2/B4E2\B4E2;
                      LSR A                               ;;B4DF|B4E3/B4E3\B4E3;
                      TAY                                 ;;B4E0|B4E4/B4E4\B4E4;
                      LDA.B #$02                          ;;B4E1|B4E5/B4E5\B4E5;
                      STA.W !OAMTileSize+$40,Y            ;;B4E3|B4E7/B4E7\B4E7;
                      PLY                                 ;;B4E6|B4EA/B4EA\B4EA;
                      INY                                 ;;B4E7|B4EB/B4EB\B4EB;
                      INY                                 ;;B4E8|B4EC/B4EC\B4EC;
                      INY                                 ;;B4E9|B4ED/B4ED\B4ED;
                      INY                                 ;;B4EA|B4EE/B4EE\B4EE;
                      DEX                                 ;;B4EB|B4EF/B4EF\B4EF;
                      BPL CODE_03B4BF                     ;;B4EC|B4F0/B4F0\B4F0;
                      LDX.B #$0F                          ;;B4EE|B4F2/B4F2\B4F2;
                      LDA.B !_F                           ;;B4F0|B4F4/B4F4\B4F4;
                      BNE CODE_03B532                     ;;B4F2|B4F6/B4F6\B4F6;
                      LDY.B #$14                          ;;B4F4|B4F8/B4F8\B4F8;
CODE_03B4FA:          %LorW_X(LDA,BowserRoofPosX)         ;;B4F6|B4FA/B4FA\B4FA;
                      SEC                                 ;;B4FA|B4FD/B4FD\B4FD;
                      SBC.B !Layer1XPos                   ;;B4FB|B4FE/B4FE\B4FE;
                      STA.W !OAMTileXPos,Y                ;;B4FD|B500/B500\B500;
                      %LorW_X(LDA,BowserRoofPosY)         ;;B500|B503/B503\B503;
                      SEC                                 ;;B504|B506/B506\B506;
                      SBC.B !Layer1YPos                   ;;B505|B507/B507\B507;
                      STA.W !OAMTileYPos,Y                ;;B507|B509/B509\B509;
                      LDA.B #$08                          ;;B50A|B50C/B50C\B50C;
                      CPX.B #$06                          ;;B50C|B50E/B50E\B50E;
                      BCS +                               ;;B50E|B510/B510\B510;
                      LDA.B #$03                          ;;B510|B512/B512\B512;
                    + STA.W !OAMTileNo,Y                  ;;B512|B514/B514\B514;
                      LDA.B #$0D                          ;;B515|B517/B517\B517;
                      ORA.B !SpriteProperties             ;;B517|B519/B519\B519;
                      STA.W !OAMTileAttr,Y                ;;B519|B51B/B51B\B51B;
                      PHY                                 ;;B51C|B51E/B51E\B51E;
                      TYA                                 ;;B51D|B51F/B51F\B51F;
                      LSR A                               ;;B51E|B520/B520\B520;
                      LSR A                               ;;B51F|B521/B521\B521;
                      TAY                                 ;;B520|B522/B522\B522;
                      LDA.B #$02                          ;;B521|B523/B523\B523;
                      STA.W !OAMTileSize,Y                ;;B523|B525/B525\B525;
                      PLY                                 ;;B526|B528/B528\B528;
                      INY                                 ;;B527|B529/B529\B529;
                      INY                                 ;;B528|B52A/B52A\B52A;
                      INY                                 ;;B529|B52B/B52B\B52B;
                      INY                                 ;;B52A|B52C/B52C\B52C;
                      DEX                                 ;;B52B|B52D/B52D\B52D;
                      BPL CODE_03B4FA                     ;;B52C|B52E/B52E\B52E;
                      BRA CODE_03B56A                     ;;B52E|B530/B530\B530;
                                                          ;;                   ;
CODE_03B532:          LDY.B #$50                          ;;B530|B532/B532\B532;
CODE_03B534:          %LorW_X(LDA,BowserRoofPosX)         ;;B532|B534/B534\B534;
                      SEC                                 ;;B536|B537/B537\B537;
                      SBC.B !Layer1XPos                   ;;B537|B538/B538\B538;
                      STA.W !OAMTileXPos+$100,Y           ;;B539|B53A/B53A\B53A;
                      %LorW_X(LDA,BowserRoofPosY)         ;;B53C|B53D/B53D\B53D;
                      SEC                                 ;;B540|B540/B540\B540;
                      SBC.B !Layer1YPos                   ;;B541|B541/B541\B541;
                      STA.W !OAMTileYPos+$100,Y           ;;B543|B543/B543\B543;
                      LDA.B #$08                          ;;B546|B546/B546\B546;
                      CPX.B #$06                          ;;B548|B548/B548\B548;
                      BCS +                               ;;B54A|B54A/B54A\B54A;
                      LDA.B #$03                          ;;B54C|B54C/B54C\B54C;
                    + STA.W !OAMTileNo+$100,Y             ;;B54E|B54E/B54E\B54E;
                      LDA.B #$0D                          ;;B551|B551/B551\B551;
                      ORA.B !SpriteProperties             ;;B553|B553/B553\B553;
                      STA.W !OAMTileAttr+$100,Y           ;;B555|B555/B555\B555;
                      PHY                                 ;;B558|B558/B558\B558;
                      TYA                                 ;;B559|B559/B559\B559;
                      LSR A                               ;;B55A|B55A/B55A\B55A;
                      LSR A                               ;;B55B|B55B/B55B\B55B;
                      TAY                                 ;;B55C|B55C/B55C\B55C;
                      LDA.B #$02                          ;;B55D|B55D/B55D\B55D;
                      STA.W !OAMTileSize+$40,Y            ;;B55F|B55F/B55F\B55F;
                      PLY                                 ;;B562|B562/B562\B562;
                      INY                                 ;;B563|B563/B563\B563;
                      INY                                 ;;B564|B564/B564\B564;
                      INY                                 ;;B565|B565/B565\B565;
                      INY                                 ;;B566|B566/B566\B566;
                      DEX                                 ;;B567|B567/B567\B567;
                      BPL CODE_03B534                     ;;B568|B568/B568\B568;
CODE_03B56A:          PLX                                 ;;B56A|B56A/B56A\B56A;
                      RTS                                 ;;B56B|B56B/B56B\B56B; Return 
                                                          ;;                   ;
                                                          ;;                   ;
SprClippingDispX:     db $02,$02,$10,$14,$00,$00,$01,$08  ;;B56C|B56C/B56C\B56C;
                      db $F8,$FE,$03,$06,$01,$00,$06,$02  ;;B574|B574/B574\B574;
                      db $00,$E8,$FC,$FC,$04,$00,$FC,$02  ;;B57C|B57C/B57C\B57C;
                      db $02,$02,$02,$02,$00,$02,$E0,$F0  ;;B584|B584/B584\B584;
                      db $FC,$FC,$00,$F8,$F4,$F2,$00,$FC  ;;B58C|B58C/B58C\B58C;
                      db $F2,$F0,$02,$00,$F8,$04,$02,$02  ;;B594|B594/B594\B594;
                      db $08,$00,$00,$00,$FC,$03,$08,$00  ;;B59C|B59C/B59C\B59C;
                      db $08,$04,$F8,$00                  ;;B5A4|B5A4/B5A4\B5A4;
                                                          ;;                   ;
SprClippingWidth:     db $0C,$0C,$10,$08,$30,$50,$0E,$28  ;;B5A8|B5A8/B5A8\B5A8;
                      db $20,$14,$01,$03,$0D,$0F,$14,$24  ;;B5B0|B5B0/B5B0\B5B0;
                      db $0F,$40,$08,$08,$18,$0F,$18,$0C  ;;B5B8|B5B8/B5B8\B5B8;
                      db $0C,$0C,$0C,$0C,$0A,$1C,$30,$30  ;;B5C0|B5C0/B5C0\B5C0;
                      db $08,$08,$10,$20,$38,$3C,$20,$18  ;;B5C8|B5C8/B5C8\B5C8;
                      db $1C,$20,$0C,$10,$10,$08,$1C,$1C  ;;B5D0|B5D0/B5D0\B5D0;
                      db $10,$30,$30,$40,$08,$12,$34,$0F  ;;B5D8|B5D8/B5D8\B5D8;
                      db $20,$08,$20,$10                  ;;B5E0|B5E0/B5E0\B5E0;
                                                          ;;                   ;
SprClippingDispY:     db $03,$03,$FE,$08,$FE,$FE,$02,$08  ;;B5E4|B5E4/B5E4\B5E4;
                      db $FE,$08,$07,$06,$FE,$FC,$06,$FE  ;;B5EC|B5EC/B5EC\B5EC;
                      db $FE,$E8,$10,$10,$02,$FE,$F4,$08  ;;B5F4|B5F4/B5F4\B5F4;
                      db $13,$23,$33,$43,$0A,$FD,$F8,$FC  ;;B5FC|B5FC/B5FC\B5FC;
                      db $E8,$10,$00,$E8,$20,$04,$58,$FC  ;;B604|B604/B604\B604;
                      db $E8,$FC,$F8,$02,$F8,$04,$FE,$FE  ;;B60C|B60C/B60C\B60C;
                      db $F2,$FE,$FE,$FE,$FC,$00,$08,$F8  ;;B614|B614/B614\B614;
                      db $10,$03,$10,$00                  ;;B61C|B61C/B61C\B61C;
                                                          ;;                   ;
SprClippingHeight:    db $0A,$15,$12,$08,$0E,$0E,$18,$30  ;;B620|B620/B620\B620;
                      db $10,$1E,$02,$03,$16,$10,$14,$12  ;;B628|B628/B628\B628;
                      db $20,$40,$34,$74,$0C,$0E,$18,$45  ;;B630|B630/B630\B630;
                      db $3A,$2A,$1A,$0A,$30,$1B,$20,$12  ;;B638|B638/B638\B638;
                      db $18,$18,$10,$20,$38,$14,$08,$18  ;;B640|B640/B640\B640;
                      db $28,$1B,$13,$4C,$10,$04,$22,$20  ;;B648|B648/B648\B648;
                      db $1C,$12,$12,$12,$08,$20,$2E,$14  ;;B650|B650/B650\B650;
                      db $28,$0A,$10,$0D                  ;;B658|B658/B658\B658;
                                                          ;;                   ;
MairoClipDispY:       db $06,$14,$10,$18                  ;;B65C|B65C/B65C\B65C;
                                                          ;;                   ;
MarioClippingHeight:  db $1A,$0C,$20,$18                  ;;B660|B660/B660\B660;
                                                          ;;                   ;
GetMarioClipping:     PHX                                 ;;B664|B664/B664\B664;
                      LDA.B !PlayerXPosNext               ;;B665|B665/B665\B665; \ 
                      CLC                                 ;;B667|B667/B667\B667;  | 
                      ADC.B #$02                          ;;B668|B668/B668\B668;  | 
                      STA.B !_0                           ;;B66A|B66A/B66A\B66A;  | $00 = (Mario X position + #$02) Low byte 
                      LDA.B !PlayerXPosNext+1             ;;B66C|B66C/B66C\B66C;  | 
                      ADC.B #$00                          ;;B66E|B66E/B66E\B66E;  | 
                      STA.B !_8                           ;;B670|B670/B670\B670; / $08 = (Mario X position + #$02) High byte 
                      LDA.B #$0C                          ;;B672|B672/B672\B672; \ $06 = Clipping width X (#$0C) 
                      STA.B !_2                           ;;B674|B674/B674\B674; / 
                      LDX.B #$00                          ;;B676|B676/B676\B676; \ If mario small or ducking, X = #$01 
                      LDA.B !PlayerIsDucking              ;;B678|B678/B678\B678;  | else, X = #$00 
                      BNE CODE_03B680                     ;;B67A|B67A/B67A\B67A;  | 
                      LDA.B !Powerup                      ;;B67C|B67C/B67C\B67C;  | 
                      BNE +                               ;;B67E|B67E/B67E\B67E;  | 
CODE_03B680:          INX                                 ;;B680|B680/B680\B680; / 
                    + LDA.W !PlayerRidingYoshi            ;;B681|B681/B681\B681; \ If on Yoshi, X += #$02 
                      BEQ +                               ;;B684|B684/B684\B684;  | 
                      INX                                 ;;B686|B686/B686\B686;  | 
                      INX                                 ;;B687|B687/B687\B687; / 
                    + LDA.L MarioClippingHeight,X         ;;B688|B688/B688\B688; \ $03 = Clipping height 
                      STA.B !_3                           ;;B68C|B68C/B68C\B68C; / 
                      LDA.B !PlayerYPosNext               ;;B68E|B68E/B68E\B68E; \ 
                      CLC                                 ;;B690|B690/B690\B690;  | 
                      ADC.L MairoClipDispY,X              ;;B691|B691/B691\B691;  | 
                      STA.B !_1                           ;;B695|B695/B695\B695;  | $01 = (Mario Y position + displacement) Low byte 
                      LDA.B !PlayerYPosNext+1             ;;B697|B697/B697\B697;  | 
                      ADC.B #$00                          ;;B699|B699/B699\B699;  | 
                      STA.B !_9                           ;;B69B|B69B/B69B\B69B; / $09 = (Mario Y position + displacement) High byte 
                      PLX                                 ;;B69D|B69D/B69D\B69D;
                      RTL                                 ;;B69E|B69E/B69E\B69E; Return 
                                                          ;;                   ;
GetSpriteClippingA:   PHY                                 ;;B69F|B69F/B69F\B69F;
                      PHX                                 ;;B6A0|B6A0/B6A0\B6A0;
                      TXY                                 ;;B6A1|B6A1/B6A1\B6A1; Y = Sprite index 
                      LDA.W !SpriteTweakerB,X             ;;B6A2|B6A2/B6A2\B6A2; \ X = Clipping table index 
                      AND.B #$3F                          ;;B6A5|B6A5/B6A5\B6A5;  | 
                      TAX                                 ;;B6A7|B6A7/B6A7\B6A7; / 
                      STZ.B !_F                           ;;B6A8|B6A8/B6A8\B6A8; \ 
                      LDA.L SprClippingDispX,X            ;;B6AA|B6AA/B6AA\B6AA;  | Load low byte of X displacement 
                      BPL +                               ;;B6AE|B6AE/B6AE\B6AE;  | 
                      DEC.B !_F                           ;;B6B0|B6B0/B6B0\B6B0;  | $0F = High byte of X displacement 
                    + CLC                                 ;;B6B2|B6B2/B6B2\B6B2;  | 
                      ADC.W !SpriteXPosLow,Y              ;;B6B3|B6B3/B6B3\B6B3;  | 
                      STA.B !_4                           ;;B6B6|B6B6/B6B6\B6B6;  | $04 = (Sprite X position + displacement) Low byte 
                      LDA.W !SpriteYPosHigh,Y             ;;B6B8|B6B8/B6B8\B6B8;  | 
                      ADC.B !_F                           ;;B6BB|B6BB/B6BB\B6BB;  | 
                      STA.B !_A                           ;;B6BD|B6BD/B6BD\B6BD; / $0A = (Sprite X position + displacement) High byte 
                      LDA.L SprClippingWidth,X            ;;B6BF|B6BF/B6BF\B6BF; \ $06 = Clipping width 
                      STA.B !_6                           ;;B6C3|B6C3/B6C3\B6C3; / 
                      STZ.B !_F                           ;;B6C5|B6C5/B6C5\B6C5; \ 
                      LDA.L SprClippingDispY,X            ;;B6C7|B6C7/B6C7\B6C7;  | Load low byte of Y displacement 
                      BPL +                               ;;B6CB|B6CB/B6CB\B6CB;  | 
                      DEC.B !_F                           ;;B6CD|B6CD/B6CD\B6CD;  | $0F = High byte of Y displacement 
                    + CLC                                 ;;B6CF|B6CF/B6CF\B6CF;  | 
                      ADC.W !SpriteYPosLow,Y              ;;B6D0|B6D0/B6D0\B6D0;  | 
                      STA.B !_5                           ;;B6D3|B6D3/B6D3\B6D3;  | $05 = (Sprite Y position + displacement) Low byte 
                      LDA.W !SpriteXPosHigh,Y             ;;B6D5|B6D5/B6D5\B6D5;  | 
                      ADC.B !_F                           ;;B6D8|B6D8/B6D8\B6D8;  | 
                      STA.B !_B                           ;;B6DA|B6DA/B6DA\B6DA; / $0B = (Sprite Y position + displacement) High byte 
                      LDA.L SprClippingHeight,X           ;;B6DC|B6DC/B6DC\B6DC; \ $07 = Clipping height 
                      STA.B !_7                           ;;B6E0|B6E0/B6E0\B6E0; / 
                      PLX                                 ;;B6E2|B6E2/B6E2\B6E2; X = Sprite index 
                      PLY                                 ;;B6E3|B6E3/B6E3\B6E3;
                      RTL                                 ;;B6E4|B6E4/B6E4\B6E4; Return 
                                                          ;;                   ;
GetSpriteClippingB:   PHY                                 ;;B6E5|B6E5/B6E5\B6E5;
                      PHX                                 ;;B6E6|B6E6/B6E6\B6E6;
                      TXY                                 ;;B6E7|B6E7/B6E7\B6E7; Y = Sprite index 
                      LDA.W !SpriteTweakerB,X             ;;B6E8|B6E8/B6E8\B6E8; \ X = Clipping table index 
                      AND.B #$3F                          ;;B6EB|B6EB/B6EB\B6EB;  | 
                      TAX                                 ;;B6ED|B6ED/B6ED\B6ED; / 
                      STZ.B !_F                           ;;B6EE|B6EE/B6EE\B6EE; \ 
                      LDA.L SprClippingDispX,X            ;;B6F0|B6F0/B6F0\B6F0;  | Load low byte of X displacement 
                      BPL +                               ;;B6F4|B6F4/B6F4\B6F4;  | 
                      DEC.B !_F                           ;;B6F6|B6F6/B6F6\B6F6;  | $0F = High byte of X displacement 
                    + CLC                                 ;;B6F8|B6F8/B6F8\B6F8;  | 
                      ADC.W !SpriteXPosLow,Y              ;;B6F9|B6F9/B6F9\B6F9;  | 
                      STA.B !_0                           ;;B6FC|B6FC/B6FC\B6FC;  | $00 = (Sprite X position + displacement) Low byte 
                      LDA.W !SpriteYPosHigh,Y             ;;B6FE|B6FE/B6FE\B6FE;  | 
                      ADC.B !_F                           ;;B701|B701/B701\B701;  | 
                      STA.B !_8                           ;;B703|B703/B703\B703; / $08 = (Sprite X position + displacement) High byte 
                      LDA.L SprClippingWidth,X            ;;B705|B705/B705\B705; \ $02 = Clipping width 
                      STA.B !_2                           ;;B709|B709/B709\B709; / 
                      STZ.B !_F                           ;;B70B|B70B/B70B\B70B; \ 
                      LDA.L SprClippingDispY,X            ;;B70D|B70D/B70D\B70D;  | Load low byte of Y displacement 
                      BPL +                               ;;B711|B711/B711\B711;  | 
                      DEC.B !_F                           ;;B713|B713/B713\B713;  | $0F = High byte of Y displacement 
                    + CLC                                 ;;B715|B715/B715\B715;  | 
                      ADC.W !SpriteYPosLow,Y              ;;B716|B716/B716\B716;  | 
                      STA.B !_1                           ;;B719|B719/B719\B719;  | $01 = (Sprite Y position + displacement) Low byte 
                      LDA.W !SpriteXPosHigh,Y             ;;B71B|B71B/B71B\B71B;  | 
                      ADC.B !_F                           ;;B71E|B71E/B71E\B71E;  | 
                      STA.B !_9                           ;;B720|B720/B720\B720; / $09 = (Sprite Y position + displacement) High byte 
                      LDA.L SprClippingHeight,X           ;;B722|B722/B722\B722; \ $03 = Clipping height 
                      STA.B !_3                           ;;B726|B726/B726\B726; / 
                      PLX                                 ;;B728|B728/B728\B728; X = Sprite index 
                      PLY                                 ;;B729|B729/B729\B729;
                      RTL                                 ;;B72A|B72A/B72A\B72A; Return 
                                                          ;;                   ;
CheckForContact:      PHX                                 ;;B72B|B72B/B72B\B72B;
                      LDX.B #$01                          ;;B72C|B72C/B72C\B72C;
CODE_03B72E:          LDA.B !_0,X                         ;;B72E|B72E/B72E\B72E;
                      SEC                                 ;;B730|B730/B730\B730;
                      SBC.B !_4,X                         ;;B731|B731/B731\B731;
                      PHA                                 ;;B733|B733/B733\B733;
                      LDA.B !_8,X                         ;;B734|B734/B734\B734;
                      SBC.B !_A,X                         ;;B736|B736/B736\B736;
                      STA.B !_C                           ;;B738|B738/B738\B738;
                      PLA                                 ;;B73A|B73A/B73A\B73A;
                      CLC                                 ;;B73B|B73B/B73B\B73B;
                      ADC.B #$80                          ;;B73C|B73C/B73C\B73C;
                      LDA.B !_C                           ;;B73E|B73E/B73E\B73E;
                      ADC.B #$00                          ;;B740|B740/B740\B740;
                      BNE CODE_03B75A                     ;;B742|B742/B742\B742;
                      LDA.B !_4,X                         ;;B744|B744/B744\B744;
                      SEC                                 ;;B746|B746/B746\B746;
                      SBC.B !_0,X                         ;;B747|B747/B747\B747;
                      CLC                                 ;;B749|B749/B749\B749;
                      ADC.B !_6,X                         ;;B74A|B74A/B74A\B74A;
                      STA.B !_F                           ;;B74C|B74C/B74C\B74C;
                      LDA.B !_2,X                         ;;B74E|B74E/B74E\B74E;
                      CLC                                 ;;B750|B750/B750\B750;
                      ADC.B !_6,X                         ;;B751|B751/B751\B751;
                      CMP.B !_F                           ;;B753|B753/B753\B753;
                      BCC CODE_03B75A                     ;;B755|B755/B755\B755;
                      DEX                                 ;;B757|B757/B757\B757;
                      BPL CODE_03B72E                     ;;B758|B758/B758\B758;
CODE_03B75A:          PLX                                 ;;B75A|B75A/B75A\B75A;
                      RTL                                 ;;B75B|B75B/B75B\B75B; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03B75C:          db $0C,$1C                          ;;B75C|B75C/B75C\B75C;
                                                          ;;                   ;
DATA_03B75E:          db $01,$02                          ;;B75E|B75E/B75E\B75E;
                                                          ;;                   ;
GetDrawInfoBnk3:      STZ.W !SpriteOffscreenVert,X        ;;B760|B760/B760\B760; Reset sprite offscreen flag, vertical 
                      STZ.W !SpriteOffscreenX,X           ;;B763|B763/B763\B763; Reset sprite offscreen flag, horizontal 
                      LDA.B !SpriteXPosLow,X              ;;B766|B766/B766\B766; \ 
                      CMP.B !Layer1XPos                   ;;B768|B768/B768\B768;  | Set horizontal offscreen if necessary 
                      LDA.W !SpriteYPosHigh,X             ;;B76A|B76A/B76A\B76A;  | 
                      SBC.B !Layer1XPos+1                 ;;B76D|B76D/B76D\B76D;  | 
                      BEQ +                               ;;B76F|B76F/B76F\B76F;  | 
                      INC.W !SpriteOffscreenX,X           ;;B771|B771/B771\B771; / 
                    + LDA.W !SpriteYPosHigh,X             ;;B774|B774/B774\B774; \ 
                      XBA                                 ;;B777|B777/B777\B777;  | Mark sprite invalid if far enough off screen 
                      LDA.B !SpriteXPosLow,X              ;;B778|B778/B778\B778;  | 
                      REP #$20                            ;;B77A|B77A/B77A\B77A; Accum (16 bit) 
                      SEC                                 ;;B77C|B77C/B77C\B77C;  | 
                      SBC.B !Layer1XPos                   ;;B77D|B77D/B77D\B77D;  | 
                      CLC                                 ;;B77F|B77F/B77F\B77F;  | 
                      ADC.W #$0040                        ;;B780|B780/B780\B780;  | 
                      CMP.W #$0180                        ;;B783|B783/B783\B783;  | 
                      SEP #$20                            ;;B786|B786/B786\B786; Accum (8 bit) 
                      ROL A                               ;;B788|B788/B788\B788;  | 
                      AND.B #$01                          ;;B789|B789/B789\B789;  | 
                      STA.W !SpriteWayOffscreenX,X        ;;B78B|B78B/B78B\B78B;  | 
                      BNE CODE_03B7CF                     ;;B78E|B78E/B78E\B78E; /  
                      LDY.B #$00                          ;;B790|B790/B790\B790; \ set up loop: 
                      LDA.W !SpriteTweakerB,X             ;;B792|B792/B792\B792;  |  
                      AND.B #$20                          ;;B795|B795/B795\B795;  | if not smushed (1662 & 0x20), go through loop twice 
                      BEQ CODE_03B79A                     ;;B797|B797/B797\B797;  | else, go through loop once 
                      INY                                 ;;B799|B799/B799\B799; /                        
CODE_03B79A:          LDA.B !SpriteYPosLow,X              ;;B79A|B79A/B79A\B79A; \                        
                      CLC                                 ;;B79C|B79C/B79C\B79C;  | set vertical offscree 
                      ADC.W DATA_03B75C,Y                 ;;B79D|B79D/B79D\B79D;  |                       
                      PHP                                 ;;B7A0|B7A0/B7A0\B7A0;  |                       
                      CMP.B !Layer1YPos                   ;;B7A1|B7A1/B7A1\B7A1;  | (vert screen boundry) 
                      ROL.B !_0                           ;;B7A3|B7A3/B7A3\B7A3;  |                       
                      PLP                                 ;;B7A5|B7A5/B7A5\B7A5;  |                       
                      LDA.W !SpriteXPosHigh,X             ;;B7A6|B7A6/B7A6\B7A6;  |                       
                      ADC.B #$00                          ;;B7A9|B7A9/B7A9\B7A9;  |                       
                      LSR.B !_0                           ;;B7AB|B7AB/B7AB\B7AB;  |                       
                      SBC.B !Layer1YPos+1                 ;;B7AD|B7AD/B7AD\B7AD;  |                       
                      BEQ +                               ;;B7AF|B7AF/B7AF\B7AF;  |                       
                      LDA.W !SpriteOffscreenVert,X        ;;B7B1|B7B1/B7B1\B7B1;  | (vert offscreen)      
                      ORA.W DATA_03B75E,Y                 ;;B7B4|B7B4/B7B4\B7B4;  |                       
                      STA.W !SpriteOffscreenVert,X        ;;B7B7|B7B7/B7B7\B7B7;  |                       
                    + DEY                                 ;;B7BA|B7BA/B7BA\B7BA;  |                       
                      BPL CODE_03B79A                     ;;B7BB|B7BB/B7BB\B7BB; /                        
                      LDY.W !SpriteOAMIndex,X             ;;B7BD|B7BD/B7BD\B7BD; get offset to sprite OAM                           
                      LDA.B !SpriteXPosLow,X              ;;B7C0|B7C0/B7C0\B7C0; \ 
                      SEC                                 ;;B7C2|B7C2/B7C2\B7C2;  |                                                     
                      SBC.B !Layer1XPos                   ;;B7C3|B7C3/B7C3\B7C3;  |                                                    
                      STA.B !_0                           ;;B7C5|B7C5/B7C5\B7C5; / $00 = sprite x position relative to screen boarder 
                      LDA.B !SpriteYPosLow,X              ;;B7C7|B7C7/B7C7\B7C7; \                                                     
                      SEC                                 ;;B7C9|B7C9/B7C9\B7C9;  |                                                     
                      SBC.B !Layer1YPos                   ;;B7CA|B7CA/B7CA\B7CA;  |                                                    
                      STA.B !_1                           ;;B7CC|B7CC/B7CC\B7CC; / $01 = sprite y position relative to screen boarder 
                      RTS                                 ;;B7CE|B7CE/B7CE\B7CE; Return 
                                                          ;;                   ;
CODE_03B7CF:          PLA                                 ;;B7CF|B7CF/B7CF\B7CF; \ Return from *main gfx routine* subroutine... 
                      PLA                                 ;;B7D0|B7D0/B7D0\B7D0;  |    ...(not just this subroutine) 
                      RTS                                 ;;B7D1|B7D1/B7D1\B7D1; / 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03B7D2:          db $00,$00,$00,$F8,$F8,$F8,$F8,$F8  ;;B7D2|B7D2/B7D2\B7D2;
                      db $F8,$F7,$F6,$F5,$F4,$F3,$F2,$E8  ;;B7DA|B7DA/B7DA\B7DA;
                      db $E8,$E8,$E8,$00,$00,$00,$00,$FE  ;;B7E2|B7E2/B7E2\B7E2;
                      db $FC,$F8,$EC,$EC,$EC,$E8,$E4,$E0  ;;B7EA|B7EA/B7EA\B7EA;
                      db $DC,$D8,$D4,$D0,$CC,$C8          ;;B7F2|B7F2/B7F2\B7F2;
                                                          ;;                   ;
CODE_03B7F8:          LDA.B !SpriteYSpeed,X               ;;B7F8|B7F8/B7F8\B7F8;
                      PHA                                 ;;B7FA|B7FA/B7FA\B7FA;
                      STZ.B !SpriteYSpeed,X               ;;B7FB|B7FB/B7FB\B7FB; Sprite Y Speed = 0 
                      PLA                                 ;;B7FD|B7FD/B7FD\B7FD;
                      LSR A                               ;;B7FE|B7FE/B7FE\B7FE;
                      LSR A                               ;;B7FF|B7FF/B7FF\B7FF;
                      TAY                                 ;;B800|B800/B800\B800;
                      LDA.B !SpriteNumber,X               ;;B801|B801/B801\B801;
                      CMP.B #$A1                          ;;B803|B803/B803\B803;
                      BNE +                               ;;B805|B805/B805\B805;
                      TYA                                 ;;B807|B807/B807\B807;
                      CLC                                 ;;B808|B808/B808\B808;
                      ADC.B #$13                          ;;B809|B809/B809\B809;
                      TAY                                 ;;B80B|B80B/B80B\B80B;
                    + LDA.W DATA_03B7D2,Y                 ;;B80C|B80C/B80C\B80C;
                      LDY.W !SpriteBlockedDirs,X          ;;B80F|B80F/B80F\B80F;
                      BMI +                               ;;B812|B812/B812\B812;
                      STA.B !SpriteYSpeed,X               ;;B814|B814/B814\B814;
                    + RTS                                 ;;B816|B816/B816\B816; Return 
                                                          ;;                   ;
SubHorzPosBnk3:       LDY.B #$00                          ;;B817|B817/B817\B817;
                      LDA.B !PlayerXPosNext               ;;B819|B819/B819\B819;
                      SEC                                 ;;B81B|B81B/B81B\B81B;
                      SBC.B !SpriteXPosLow,X              ;;B81C|B81C/B81C\B81C;
                      STA.B !_F                           ;;B81E|B81E/B81E\B81E;
                      LDA.B !PlayerXPosNext+1             ;;B820|B820/B820\B820;
                      SBC.W !SpriteYPosHigh,X             ;;B822|B822/B822\B822;
                      BPL +                               ;;B825|B825/B825\B825;
                      INY                                 ;;B827|B827/B827\B827;
                    + RTS                                 ;;B828|B828/B828\B828; Return 
                                                          ;;                   ;
SubVertPosBnk3:       LDY.B #$00                          ;;B829|B829/B829\B829;
                      LDA.B !PlayerYPosNext               ;;B82B|B82B/B82B\B82B;
                      SEC                                 ;;B82D|B82D/B82D\B82D;
                      SBC.B !SpriteYPosLow,X              ;;B82E|B82E/B82E\B82E;
                      STA.B !_F                           ;;B830|B830/B830\B830;
                      LDA.B !PlayerYPosNext+1             ;;B832|B832/B832\B832;
                      SBC.W !SpriteXPosHigh,X             ;;B834|B834/B834\B834;
                      BPL +                               ;;B837|B837/B837\B837;
                      INY                                 ;;B839|B839/B839\B839;
                    + RTS                                 ;;B83A|B83A/B83A\B83A; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03B83B:          db $40,$B0                          ;;B83B|B83B/B83B\B83B;
                                                          ;;                   ;
DATA_03B83D:          db $01,$FF                          ;;B83D|B83D/B83D\B83D;
                                                          ;;                   ;
DATA_03B83F:          db $30,$C0,$A0,$80,$A0,$40,$60,$B0  ;;B83F|B83F/B83F\B83F;
DATA_03B847:          db $01,$FF,$01,$FF,$01,$00,$01,$FF  ;;B847|B847/B847\B847;
                                                          ;;                   ;
SubOffscreen3Bnk3:    LDA.B #$06                          ;;B84F|B84F/B84F\B84F; \ Entry point of routine determines value of $03 
                      BRA +                               ;;B851|B851/B851\B851;  | 
                                                          ;;                   ;
                      LDA.B #$04                          ;;B853|B853/B853\B853;  | 
                      BRA +                               ;;B855|B855/B855\B855;  | 
                                                          ;;                   ;
                      LDA.B #$02                          ;;B857|B857/B857\B857;  | 
                    + STA.B !_3                           ;;B859|B859/B859\B859;  | 
                      BRA +                               ;;B85B|B85B/B85B\B85B;  | 
                                                          ;;                   ;
SubOffscreen0Bnk3:    STZ.B !_3                           ;;B85D|B85D/B85D\B85D; / 
                    + JSR IsSprOffScreenBnk3              ;;B85F|B85F/B85F\B85F; \ if sprite is not off screen, return 
                      BEQ Return03B8C2                    ;;B862|B862/B862\B862; / 
                      LDA.B !ScreenMode                   ;;B864|B864/B864\B864; \  vertical level 
                      AND.B #$01                          ;;B866|B866/B866\B866;  | 
                      BNE VerticalLevelBnk3               ;;B868|B868/B868\B868; / 
                      LDA.B !SpriteYPosLow,X              ;;B86A|B86A/B86A\B86A; \ 
                      CLC                                 ;;B86C|B86C/B86C\B86C;  | 
                      ADC.B #$50                          ;;B86D|B86D/B86D\B86D;  | if the sprite has gone off the bottom of the level... 
                      LDA.W !SpriteXPosHigh,X             ;;B86F|B86F/B86F\B86F;  | (if adding 0x50 to the sprite y position would make the high byte >= 2) 
                      ADC.B #$00                          ;;B872|B872/B872\B872;  | 
                      CMP.B #$02                          ;;B874|B874/B874\B874;  | 
                      BPL OffScrEraseSprBnk3              ;;B876|B876/B876\B876; /    ...erase the sprite 
                      LDA.W !SpriteTweakerD,X             ;;B878|B878/B878\B878; \ if "process offscreen" flag is set, return 
                      AND.B #$04                          ;;B87B|B87B/B87B\B87B;  | 
                      BNE Return03B8C2                    ;;B87D|B87D/B87D\B87D; / 
                      LDA.B !TrueFrame                    ;;B87F|B87F/B87F\B87F;
                      AND.B #$01                          ;;B881|B881/B881\B881;
                      ORA.B !_3                           ;;B883|B883/B883\B883;
                      STA.B !_1                           ;;B885|B885/B885\B885;
                      TAY                                 ;;B887|B887/B887\B887;
                      LDA.B !Layer1XPos                   ;;B888|B888/B888\B888;
                      CLC                                 ;;B88A|B88A/B88A\B88A;
                      ADC.W DATA_03B83F,Y                 ;;B88B|B88B/B88B\B88B;
                      ROL.B !_0                           ;;B88E|B88E/B88E\B88E;
                      CMP.B !SpriteXPosLow,X              ;;B890|B890/B890\B890;
                      PHP                                 ;;B892|B892/B892\B892;
                      LDA.B !Layer1XPos+1                 ;;B893|B893/B893\B893;
                      LSR.B !_0                           ;;B895|B895/B895\B895;
                      ADC.W DATA_03B847,Y                 ;;B897|B897/B897\B897;
                      PLP                                 ;;B89A|B89A/B89A\B89A;
                      SBC.W !SpriteYPosHigh,X             ;;B89B|B89B/B89B\B89B;
                      STA.B !_0                           ;;B89E|B89E/B89E\B89E;
                      LSR.B !_1                           ;;B8A0|B8A0/B8A0\B8A0;
                      BCC +                               ;;B8A2|B8A2/B8A2\B8A2;
                      EOR.B #$80                          ;;B8A4|B8A4/B8A4\B8A4;
                      STA.B !_0                           ;;B8A6|B8A6/B8A6\B8A6;
                    + LDA.B !_0                           ;;B8A8|B8A8/B8A8\B8A8;
                      BPL Return03B8C2                    ;;B8AA|B8AA/B8AA\B8AA;
OffScrEraseSprBnk3:   LDA.W !SpriteStatus,X               ;;B8AC|B8AC/B8AC\B8AC; \ If sprite status < 8, permanently erase sprite 
                      CMP.B #$08                          ;;B8AF|B8AF/B8AF\B8AF;  | 
                      BCC +                               ;;B8B1|B8B1/B8B1\B8B1; / 
                      LDY.W !SpriteLoadIndex,X            ;;B8B3|B8B3/B8B3\B8B3; \ Branch if should permanently erase sprite 
                      CPY.B #$FF                          ;;B8B6|B8B6/B8B6\B8B6;  | 
                      BEQ +                               ;;B8B8|B8B8/B8B8\B8B8; / 
                      LDA.B #$00                          ;;B8BA|B8BA/B8BA\B8BA; \ Allow sprite to be reloaded by level loading routine 
                      STA.W !SpriteLoadStatus,Y           ;;B8BC|B8BC/B8BC\B8BC; / 
                    + STZ.W !SpriteStatus,X               ;;B8BF|B8BF/B8BF\B8BF;
Return03B8C2:         RTS                                 ;;B8C2|B8C2/B8C2\B8C2; Return 
                                                          ;;                   ;
VerticalLevelBnk3:    LDA.W !SpriteTweakerD,X             ;;B8C3|B8C3/B8C3\B8C3; \ If "process offscreen" flag is set, return 
                      AND.B #$04                          ;;B8C6|B8C6/B8C6\B8C6;  | 
                      BNE Return03B8C2                    ;;B8C8|B8C8/B8C8\B8C8; / 
                      LDA.B !TrueFrame                    ;;B8CA|B8CA/B8CA\B8CA; \ Return every other frame 
                      LSR A                               ;;B8CC|B8CC/B8CC\B8CC;  | 
                      BCS Return03B8C2                    ;;B8CD|B8CD/B8CD\B8CD; / 
                      AND.B #$01                          ;;B8CF|B8CF/B8CF\B8CF;
                      STA.B !_1                           ;;B8D1|B8D1/B8D1\B8D1;
                      TAY                                 ;;B8D3|B8D3/B8D3\B8D3;
                      LDA.B !Layer1YPos                   ;;B8D4|B8D4/B8D4\B8D4;
                      CLC                                 ;;B8D6|B8D6/B8D6\B8D6;
                      ADC.W DATA_03B83B,Y                 ;;B8D7|B8D7/B8D7\B8D7;
                      ROL.B !_0                           ;;B8DA|B8DA/B8DA\B8DA;
                      CMP.B !SpriteYPosLow,X              ;;B8DC|B8DC/B8DC\B8DC;
                      PHP                                 ;;B8DE|B8DE/B8DE\B8DE;
                      LDA.W !Layer1YPos+1                 ;;B8DF|B8DF/B8DF\B8DF;
                      LSR.B !_0                           ;;B8E2|B8E2/B8E2\B8E2;
                      ADC.W DATA_03B83D,Y                 ;;B8E4|B8E4/B8E4\B8E4;
                      PLP                                 ;;B8E7|B8E7/B8E7\B8E7;
                      SBC.W !SpriteXPosHigh,X             ;;B8E8|B8E8/B8E8\B8E8;
                      STA.B !_0                           ;;B8EB|B8EB/B8EB\B8EB;
                      LDY.B !_1                           ;;B8ED|B8ED/B8ED\B8ED;
                      BEQ +                               ;;B8EF|B8EF/B8EF\B8EF;
                      EOR.B #$80                          ;;B8F1|B8F1/B8F1\B8F1;
                      STA.B !_0                           ;;B8F3|B8F3/B8F3\B8F3;
                    + LDA.B !_0                           ;;B8F5|B8F5/B8F5\B8F5;
                      BPL Return03B8C2                    ;;B8F7|B8F7/B8F7\B8F7;
                      BMI OffScrEraseSprBnk3              ;;B8F9|B8F9/B8F9\B8F9;
IsSprOffScreenBnk3:   LDA.W !SpriteOffscreenX,X           ;;B8FB|B8FB/B8FB\B8FB; \ If sprite is on screen, A = 0  
                      ORA.W !SpriteOffscreenVert,X        ;;B8FE|B8FE/B8FE\B8FE;  | 
                      RTS                                 ;;B901|B901/B901\B901; / Return 
                                                          ;;                   ;
                                                          ;;                   ;
MagiKoopaPals:        db $FF,$7F,$4A,$29,$00,$00,$00,$14  ;;B902|B902/B902\B902;
                      db $00,$20,$92,$7E,$0A,$00,$2A,$00  ;;B90A|B90A/B90A\B90A;
                      db $FF,$7F,$AD,$35,$00,$00,$00,$24  ;;B912|B912/B912\B912;
                      db $00,$2C,$2F,$72,$0D,$00,$AD,$00  ;;B91A|B91A/B91A\B91A;
                      db $FF,$7F,$10,$42,$00,$00,$00,$30  ;;B922|B922/B922\B922;
                      db $00,$38,$CC,$65,$50,$00,$10,$01  ;;B92A|B92A/B92A\B92A;
                      db $FF,$7F,$73,$4E,$00,$00,$00,$3C  ;;B932|B932/B932\B932;
                      db $41,$44,$69,$59,$B3,$00,$73,$01  ;;B93A|B93A/B93A\B93A;
                      db $FF,$7F,$D6,$5A,$00,$00,$00,$48  ;;B942|B942/B942\B942;
                      db $A4,$50,$06,$4D,$16,$01,$D6,$01  ;;B94A|B94A/B94A\B94A;
                      db $FF,$7F,$39,$67,$00,$00,$42,$54  ;;B952|B952/B952\B952;
                      db $07,$5D,$A3,$40,$79,$01,$39,$02  ;;B95A|B95A/B95A\B95A;
                      db $FF,$7F,$9C,$73,$00,$00,$A5,$60  ;;B962|B962/B962\B962;
                      db $6A,$69,$40,$34,$DC,$01,$9C,$02  ;;B96A|B96A/B96A\B96A;
                      db $FF,$7F,$FF,$7F,$00,$00,$08,$6D  ;;B972|B972/B972\B972;
                      db $CD,$75,$00,$28,$3F,$02,$FF,$02  ;;B97A|B97A/B97A\B97A;
BooBossPals:          db $FF,$7F,$63,$0C,$00,$00,$00,$0C  ;;B982|B982/B982\B982;
                      db $00,$0C,$00,$0C,$00,$0C,$03,$00  ;;B98A|B98A/B98A\B98A;
                      db $FF,$7F,$E7,$1C,$00,$00,$00,$1C  ;;B992|B992/B992\B992;
                      db $00,$1C,$20,$1C,$81,$1C,$07,$00  ;;B99A|B99A/B99A\B99A;
                      db $FF,$7F,$6B,$2D,$00,$00,$00,$2C  ;;B9A2|B9A2/B9A2\B9A2;
                      db $40,$2C,$A2,$2C,$05,$2D,$0B,$00  ;;B9AA|B9AA/B9AA\B9AA;
                      db $FF,$7F,$EF,$3D,$00,$00,$60,$3C  ;;B9B2|B9B2/B9B2\B9B2;
                      db $C3,$3C,$26,$3D,$89,$3D,$0F,$00  ;;B9BA|B9BA/B9BA\B9BA;
                      db $FF,$7F,$73,$4E,$00,$00,$E4,$4C  ;;B9C2|B9C2/B9C2\B9C2;
                      db $47,$4D,$AA,$4D,$0D,$4E,$13,$10  ;;B9CA|B9CA/B9CA\B9CA;
                      db $FF,$7F,$F7,$5E,$00,$00,$68,$5D  ;;B9D2|B9D2/B9D2\B9D2;
                      db $CB,$5D,$2E,$5E,$91,$5E,$17,$20  ;;B9DA|B9DA/B9DA\B9DA;
                      db $FF,$7F,$7B,$6F,$00,$00,$EC,$6D  ;;B9E2|B9E2/B9E2\B9E2;
                      db $4F,$6E,$B2,$6E,$15,$6F,$1B,$30  ;;B9EA|B9EA/B9EA\B9EA;
                      db $FF,$7F,$FF,$7F,$00,$00,$70,$7E  ;;B9F2|B9F2/B9F2\B9F2;
                      db $D3,$7E,$36,$7F,$99,$7F,$1F,$40  ;;B9FA|B9FA/B9FA\B9FA;
                                                          ;;                   ;
                      %insert_empty($5FE,$5FE,$5FE,$5FE)  ;;BA02|BA02/BA02\BA02;
                                                          ;;                   ;
GenTileFromSpr2:      STA.B !Map16TileGenerate            ;;C000|C000/C000\C000; $9C = tile to generate 
                      LDA.B !SpriteXPosLow,X              ;;C002|C002/C002\C002; \ $9A = Sprite X position + #$08 
                      SEC                                 ;;C004|C004/C004\C004;  | for block creation 
                      SBC.B #$08                          ;;C005|C005/C005\C005;  | 
                      STA.B !TouchBlockXPos               ;;C007|C007/C007\C007;  | 
                      LDA.W !SpriteYPosHigh,X             ;;C009|C009/C009\C009;  | 
                      SBC.B #$00                          ;;C00C|C00C/C00C\C00C;  | 
                      STA.B !TouchBlockXPos+1             ;;C00E|C00E/C00E\C00E; / 
                      LDA.B !SpriteYPosLow,X              ;;C010|C010/C010\C010; \ $98 = Sprite Y position + #$08 
                      CLC                                 ;;C012|C012/C012\C012;  | for block creation 
                      ADC.B #$08                          ;;C013|C013/C013\C013;  | 
                      STA.B !TouchBlockYPos               ;;C015|C015/C015\C015;  | 
                      LDA.W !SpriteXPosHigh,X             ;;C017|C017/C017\C017;  | 
                      ADC.B #$00                          ;;C01A|C01A/C01A\C01A;  | 
                      STA.B !TouchBlockYPos+1             ;;C01C|C01C/C01C\C01C; / 
                      JSL GenerateTile                    ;;C01E|C01E/C01E\C01E; Generate the tile 
                      RTL                                 ;;C022|C022/C022\C022; Return 
                                                          ;;                   ;
CODE_03C023:          PHB                                 ;;C023|C023/C023\C023; Wrapper 
                      PHK                                 ;;C024|C024/C024\C024;
                      PLB                                 ;;C025|C025/C025\C025;
                      JSR CODE_03C02F                     ;;C026|C026/C026\C026;
                      PLB                                 ;;C029|C029/C029\C029;
                      RTL                                 ;;C02A|C02A/C02A\C02A; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C02B:          db $74,$75,$77,$76                  ;;C02B|C02B/C02B\C02B;
                                                          ;;                   ;
CODE_03C02F:          LDY.W !SpriteMisc160E,X             ;;C02F|C02F/C02F\C02F;
                      LDA.B #$00                          ;;C032|C032/C032\C032;
                      STA.W !SpriteStatus,Y               ;;C034|C034/C034\C034;
                      LDA.B #$06                          ;;C037|C037/C037\C037; \ Play sound effect 
                      STA.W !SPCIO0                       ;;C039|C039/C039\C039; / 
                      LDA.W !SpriteMisc160E,Y             ;;C03C|C03C/C03C\C03C;
                      BNE CODE_03C09B                     ;;C03F|C03F/C03F\C03F;
                      LDA.W !SpriteNumber,Y               ;;C041|C041/C041\C041;
                      CMP.B #$81                          ;;C044|C044/C044\C044;
                      BNE +                               ;;C046|C046/C046\C046;
                      LDA.B !EffFrame                     ;;C048|C048/C048\C048;
                      LSR A                               ;;C04A|C04A/C04A\C04A;
                      LSR A                               ;;C04B|C04B/C04B\C04B;
                      LSR A                               ;;C04C|C04C/C04C\C04C;
                      LSR A                               ;;C04D|C04D/C04D\C04D;
                      AND.B #$03                          ;;C04E|C04E/C04E\C04E;
                      TAY                                 ;;C050|C050/C050\C050;
                      LDA.W DATA_03C02B,Y                 ;;C051|C051/C051\C051;
                    + CMP.B #$74                          ;;C054|C054/C054\C054;
                      BCC CODE_03C09B                     ;;C056|C056/C056\C056;
                      CMP.B #$78                          ;;C058|C058/C058\C058;
                      BCS CODE_03C09B                     ;;C05A|C05A/C05A\C05A;
ADDR_03C05C:          STZ.W !YoshiSwallowTimer            ;;C05C|C05C/C05C\C05C;
                      STZ.W !YoshiHasWingsEvt             ;;C05F|C05F/C05F\C05F; No Yoshi wing ability 
                      LDA.B #$35                          ;;C062|C062/C062\C062;
                      STA.W !SpriteNumber,X               ;;C064|C064/C064\C064;
                      LDA.B #$08                          ;;C067|C067/C067\C067; \ Sprite status = Normal 
                      STA.W !SpriteStatus,X               ;;C069|C069/C069\C069; / 
                      LDA.B #$1F                          ;;C06C|C06C/C06C\C06C; \ Play sound effect 
                      STA.W !SPCIO3                       ;;C06E|C06E/C06E\C06E; / 
                      LDA.B !SpriteYPosLow,X              ;;C071|C071/C071\C071;
                      SBC.B #$10                          ;;C073|C073/C073\C073;
                      STA.B !SpriteYPosLow,X              ;;C075|C075/C075\C075;
                      LDA.W !SpriteXPosHigh,X             ;;C077|C077/C077\C077;
                      SBC.B #$00                          ;;C07A|C07A/C07A\C07A;
                      STA.W !SpriteXPosHigh,X             ;;C07C|C07C/C07C\C07C;
                      LDA.W !SpriteOBJAttribute,X         ;;C07F|C07F/C07F\C07F;
                      PHA                                 ;;C082|C082/C082\C082;
                      JSL InitSpriteTables                ;;C083|C083/C083\C083;
                      PLA                                 ;;C087|C087/C087\C087;
                      AND.B #$FE                          ;;C088|C088/C088\C088;
                      STA.W !SpriteOBJAttribute,X         ;;C08A|C08A/C08A\C08A;
                      LDA.B #$0C                          ;;C08D|C08D/C08D\C08D;
                      STA.W !SpriteMisc1602,X             ;;C08F|C08F/C08F\C08F;
                      DEC.W !SpriteMisc160E,X             ;;C092|C092/C092\C092;
                      LDA.B #$40                          ;;C095|C095/C095\C095;
                      STA.W !YoshiGrowingTimer            ;;C097|C097/C097\C097;
                      RTS                                 ;;C09A|C09A/C09A\C09A; Return 
                                                          ;;                   ;
CODE_03C09B:          INC.W !SpriteMisc1570,X             ;;C09B|C09B/C09B\C09B;
                      LDA.W !SpriteMisc1570,X             ;;C09E|C09E/C09E\C09E;
                      CMP.B #$05                          ;;C0A1|C0A1/C0A1\C0A1;
                      BNE CODE_03C0A7                     ;;C0A3|C0A3/C0A3\C0A3;
                      BRA ADDR_03C05C                     ;;C0A5|C0A5/C0A5\C0A5;
                                                          ;;                   ;
CODE_03C0A7:          JSL CODE_05B34A                     ;;C0A7|C0A7/C0A7\C0A7;
                      LDA.B #$01                          ;;C0AB|C0AB/C0AB\C0AB;
                      JSL GivePoints                      ;;C0AD|C0AD/C0AD\C0AD;
                      RTS                                 ;;C0B1|C0B1/C0B1\C0B1; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C0B2:          db $68,$6A,$6C,$6E                  ;;C0B2|C0B2/C0B2\C0B2;
                                                          ;;                   ;
DATA_03C0B6:          db $00,$03,$01,$02,$04,$02,$00,$01  ;;C0B6|C0B6/C0B6\C0B6;
                      db $00,$04,$00,$02,$00,$03,$04,$01  ;;C0BE|C0BE/C0BE\C0BE;
                                                          ;;                   ;
CODE_03C0C6:          LDA.B !SpriteLock                   ;;C0C6|C0C6/C0C6\C0C6;
                      BNE +                               ;;C0C8|C0C8/C0C8\C0C8;
                      JSR CODE_03C11E                     ;;C0CA|C0CA/C0CA\C0CA;
                    + STZ.B !_0                           ;;C0CD|C0CD/C0CD\C0CD;
                      LDX.B #$13                          ;;C0CF|C0CF/C0CF\C0CF;
                      LDY.B #$B0                          ;;C0D1|C0D1/C0D1\C0D1;
                    - STX.B !_2                           ;;C0D3|C0D3/C0D3\C0D3;
                      LDA.B !_0                           ;;C0D5|C0D5/C0D5\C0D5;
                      STA.W !OAMTileXPos+$100,Y           ;;C0D7|C0D7/C0D7\C0D7;
                      CLC                                 ;;C0DA|C0DA/C0DA\C0DA;
                      ADC.B #$10                          ;;C0DB|C0DB/C0DB\C0DB;
                      STA.B !_0                           ;;C0DD|C0DD/C0DD\C0DD;
                      LDA.B #$C4                          ;;C0DF|C0DF/C0DF\C0DF;
                      STA.W !OAMTileYPos+$100,Y           ;;C0E1|C0E1/C0E1\C0E1;
                      LDA.B !SpriteProperties             ;;C0E4|C0E4/C0E4\C0E4;
                      ORA.B #$09                          ;;C0E6|C0E6/C0E6\C0E6;
                      STA.W !OAMTileAttr+$100,Y           ;;C0E8|C0E8/C0E8\C0E8;
                      PHX                                 ;;C0EB|C0EB/C0EB\C0EB;
                      LDA.B !EffFrame                     ;;C0EC|C0EC/C0EC\C0EC;
                      LSR A                               ;;C0EE|C0EE/C0EE\C0EE;
                      LSR A                               ;;C0EF|C0EF/C0EF\C0EF;
                      LSR A                               ;;C0F0|C0F0/C0F0\C0F0;
                      CLC                                 ;;C0F1|C0F1/C0F1\C0F1;
                      ADC.L DATA_03C0B6,X                 ;;C0F2|C0F2/C0F2\C0F2;
                      AND.B #$03                          ;;C0F6|C0F6/C0F6\C0F6;
                      TAX                                 ;;C0F8|C0F8/C0F8\C0F8;
                      LDA.L DATA_03C0B2,X                 ;;C0F9|C0F9/C0F9\C0F9;
                      STA.W !OAMTileNo+$100,Y             ;;C0FD|C0FD/C0FD\C0FD;
                      TYA                                 ;;C100|C100/C100\C100;
                      LSR A                               ;;C101|C101/C101\C101;
                      LSR A                               ;;C102|C102/C102\C102;
                      TAX                                 ;;C103|C103/C103\C103;
                      LDA.B #$02                          ;;C104|C104/C104\C104;
                      STA.W !OAMTileSize+$40,X            ;;C106|C106/C106\C106;
                      PLX                                 ;;C109|C109/C109\C109;
                      INY                                 ;;C10A|C10A/C10A\C10A;
                      INY                                 ;;C10B|C10B/C10B\C10B;
                      INY                                 ;;C10C|C10C/C10C\C10C;
                      INY                                 ;;C10D|C10D/C10D\C10D;
                      DEX                                 ;;C10E|C10E/C10E\C10E;
                      BPL -                               ;;C10F|C10F/C10F\C10F;
                      RTL                                 ;;C111|C111/C111\C111; Return 
                                                          ;;                   ;
                                                          ;;                   ;
IggyPlatSpeed:        db $FF,$01,$FF,$01                  ;;C112|C112/C112\C112;
                                                          ;;                   ;
DATA_03C116:          db $FF,$00,$FF,$00                  ;;C116|C116/C116\C116;
                                                          ;;                   ;
IggyPlatBounds:       db $E7,$18,$D7,$28                  ;;C11A|C11A/C11A\C11A;
                                                          ;;                   ;
CODE_03C11E:          LDA.B !SpriteLock                   ;;C11E|C11E/C11E\C11E; \ If sprites locked... 
                      ORA.W !EndLevelTimer                ;;C120|C120/C120\C120;  | ...or battle is over (set to FF when over)... 
                      BNE Return03C175                    ;;C123|C123/C123\C123; / ...return 
                      LDA.W !IggyLarryPlatWait            ;;C125|C125/C125\C125; \ If platform at a maximum tilt, (stationary timer > 0) 
                      BEQ +                               ;;C128|C128/C128\C128;  | 
                      DEC.W !IggyLarryPlatWait            ;;C12A|C12A/C12A\C12A; / decrement stationary timer 
                    + LDA.B !TrueFrame                    ;;C12D|C12D/C12D\C12D; \ Return every other time through... 
                      AND.B #$01                          ;;C12F|C12F/C12F\C12F;  | 
                      ORA.W !IggyLarryPlatWait            ;;C131|C131/C131\C131;  | ...return if stationary 
                      BNE Return03C175                    ;;C134|C134/C134\C134; / 
                      LDA.W !IggyLarryPlatTilt            ;;C136|C136/C136\C136; $1907 holds the total number of tilts made 
                      AND.B #$01                          ;;C139|C139/C139\C139; \ X=1 if platform tilted up to the right (/)... 
                      TAX                                 ;;C13B|C13B/C13B\C13B; / ...else X=0 
                      LDA.W !IggyLarryPlatPhase           ;;C13C|C13C/C13C\C13C; $1907 holds the current phase: 0/ 1\ 2/ 3\ 4// 5\\ 
                      CMP.B #$04                          ;;C13F|C13F/C13F\C13F; \ If this is phase 4 or 5... 
                      BCC +                               ;;C141|C141/C141\C141;  | ...cause a steep tilt by setting X=X+2 
                      INX                                 ;;C143|C143/C143\C143;  | 
                      INX                                 ;;C144|C144/C144\C144; / 
                    + LDA.B !Mode7Angle                   ;;C145|C145/C145\C145; $36 is tilt of platform: //D8 /E8 -0- 18\ 28\\ 
                      CLC                                 ;;C147|C147/C147\C147; \ Get new tilt of platform by adding value 
                      ADC.L IggyPlatSpeed,X               ;;C148|C148/C148\C148;  | 
                      STA.B !Mode7Angle                   ;;C14C|C14C/C14C\C14C; / 
                      PHA                                 ;;C14E|C14E/C14E\C14E;
                      LDA.B !Mode7Angle+1                 ;;C14F|C14F/C14F\C14F; $37 is boolean tilt of platform: 0\ /1 
                      ADC.L DATA_03C116,X                 ;;C151|C151/C151\C151; \ if tilted up to left,  $37=0 
                      AND.B #$01                          ;;C155|C155/C155\C155;  | if tilted up to right, $37=1 
                      STA.B !Mode7Angle+1                 ;;C157|C157/C157\C157; / 
                      PLA                                 ;;C159|C159/C159\C159;
                      CMP.L IggyPlatBounds,X              ;;C15A|C15A/C15A\C15A; \ Return if platform not at a maximum tilt 
                      BNE Return03C175                    ;;C15E|C15E/C15E\C15E; / 
                      INC.W !IggyLarryPlatTilt            ;;C160|C160/C160\C160; Increment total number of tilts made 
                      LDA.B #$40                          ;;C163|C163/C163\C163; \ Set timer to stay stationary 
                      STA.W !IggyLarryPlatWait            ;;C165|C165/C165\C165; / 
                      INC.W !IggyLarryPlatPhase           ;;C168|C168/C168\C168; Increment phase 
                      LDA.W !IggyLarryPlatPhase           ;;C16B|C16B/C16B\C16B; \ If phase > 5, phase = 0 
                      CMP.B #$06                          ;;C16E|C16E/C16E\C16E;  | 
                      BNE Return03C175                    ;;C170|C170/C170\C170;  | 
                      STZ.W !IggyLarryPlatPhase           ;;C172|C172/C172\C172; / 
Return03C175:         RTS                                 ;;C175|C175/C175\C175; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C176:          db $0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D  ;;C176|C176/C176\C176;
                      db $0D,$0D,$FC,$FC,$FC,$FC,$FC,$FC  ;;C17E|C17E/C17E\C17E;
                      db $FB,$FB,$FB,$FB,$0C,$0C,$0C,$0C  ;;C186|C186/C186\C186;
                      db $0C,$0C,$0D,$0D,$0D,$0D,$FC,$FC  ;;C18E|C18E/C18E\C18E;
                      db $FC,$FC,$FC,$FC,$FB,$FB,$FB,$FB  ;;C196|C196/C196\C196;
DATA_03C19E:          db $0E,$0E,$0E,$0D,$0D,$0D,$0C,$0C  ;;C19E|C19E/C19E\C19E;
                      db $0B,$0B,$0E,$0E,$0E,$0D,$0D,$0D  ;;C1A6|C1A6/C1A6\C1A6;
                      db $0C,$0C,$0B,$0B,$12,$12,$12,$11  ;;C1AE|C1AE/C1AE\C1AE;
                      db $11,$11,$10,$10,$0F,$0F,$12,$12  ;;C1B6|C1B6/C1B6\C1B6;
                      db $12,$11,$11,$11,$10,$10,$0F,$0F  ;;C1BE|C1BE/C1BE\C1BE;
DATA_03C1C6:          db $02,$FE                          ;;C1C6|C1C6/C1C6\C1C6;
                                                          ;;                   ;
DATA_03C1C8:          db $00,$FF                          ;;C1C8|C1C8/C1C8\C1C8;
                                                          ;;                   ;
CODE_03C1CA:          PHB                                 ;;C1CA|C1CA/C1CA\C1CA;
                      PHK                                 ;;C1CB|C1CB/C1CB\C1CB;
                      PLB                                 ;;C1CC|C1CC/C1CC\C1CC;
                      LDY.B #$00                          ;;C1CD|C1CD/C1CD\C1CD;
                      LDA.W !SpriteSlope,X                ;;C1CF|C1CF/C1CF\C1CF;
                      BPL +                               ;;C1D2|C1D2/C1D2\C1D2;
                      INY                                 ;;C1D4|C1D4/C1D4\C1D4;
                    + LDA.B !SpriteXPosLow,X              ;;C1D5|C1D5/C1D5\C1D5;
                      CLC                                 ;;C1D7|C1D7/C1D7\C1D7;
                      ADC.W DATA_03C1C6,Y                 ;;C1D8|C1D8/C1D8\C1D8;
                      STA.B !SpriteXPosLow,X              ;;C1DB|C1DB/C1DB\C1DB;
                      LDA.W !SpriteYPosHigh,X             ;;C1DD|C1DD/C1DD\C1DD;
                      ADC.W DATA_03C1C8,Y                 ;;C1E0|C1E0/C1E0\C1E0;
                      STA.W !SpriteYPosHigh,X             ;;C1E3|C1E3/C1E3\C1E3;
                      LDA.B #$18                          ;;C1E6|C1E6/C1E6\C1E6;
                      STA.B !SpriteYSpeed,X               ;;C1E8|C1E8/C1E8\C1E8;
                      PLB                                 ;;C1EA|C1EA/C1EA\C1EA;
                      RTL                                 ;;C1EB|C1EB/C1EB\C1EB; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C1EC:          db $00,$04,$07,$08,$08,$07,$04,$00  ;;C1EC|C1EC/C1EC\C1EC;
                      db $00                              ;;C1F4|C1F4/C1F4\C1F4;
                                                          ;;                   ;
LightSwitch:          LDA.B !SpriteLock                   ;;C1F5|C1F5/C1F5\C1F5;
                      BNE CODE_03C22B                     ;;C1F7|C1F7/C1F7\C1F7;
                      JSL InvisBlkMainRt                  ;;C1F9|C1F9/C1F9\C1F9;
                      JSR SubOffscreen0Bnk3               ;;C1FD|C1FD/C1FD\C1FD;
                      LDA.W !SpriteMisc1558,X             ;;C200|C200/C200\C200;
                      CMP.B #$05                          ;;C203|C203/C203\C203;
                      BNE CODE_03C22B                     ;;C205|C205/C205\C205;
                      STZ.B !SpriteTableC2,X              ;;C207|C207/C207\C207;
                      LDY.B #$0B                          ;;C209|C209/C209\C209; \ Play sound effect 
                      STY.W !SPCIO0                       ;;C20B|C20B/C20B\C20B; / 
                      PHA                                 ;;C20E|C20E/C20E\C20E;
                      LDY.B #$09                          ;;C20F|C20F/C20F\C20F;
CODE_03C211:          LDA.W !SpriteStatus,Y               ;;C211|C211/C211\C211;
                      CMP.B #$08                          ;;C214|C214/C214\C214;
                      BNE +                               ;;C216|C216/C216\C216;
                      LDA.W !SpriteNumber,Y               ;;C218|C218/C218\C218;
                      CMP.B #$C6                          ;;C21B|C21B/C21B\C21B;
                      BNE +                               ;;C21D|C21D/C21D\C21D;
                      LDA.W !SpriteTableC2,Y              ;;C21F|C21F/C21F\C21F;
                      EOR.B #$01                          ;;C222|C222/C222\C222;
                      STA.W !SpriteTableC2,Y              ;;C224|C224/C224\C224;
                    + DEY                                 ;;C227|C227/C227\C227;
                      BPL CODE_03C211                     ;;C228|C228/C228\C228;
                      PLA                                 ;;C22A|C22A/C22A\C22A;
CODE_03C22B:          LDA.W !SpriteMisc1558,X             ;;C22B|C22B/C22B\C22B;
                      LSR A                               ;;C22E|C22E/C22E\C22E;
                      TAY                                 ;;C22F|C22F/C22F\C22F;
                      LDA.B !Layer1YPos                   ;;C230|C230/C230\C230;
                      PHA                                 ;;C232|C232/C232\C232;
                      CLC                                 ;;C233|C233/C233\C233;
                      ADC.W DATA_03C1EC,Y                 ;;C234|C234/C234\C234;
                      STA.B !Layer1YPos                   ;;C237|C237/C237\C237;
                      LDA.B !Layer1YPos+1                 ;;C239|C239/C239\C239;
                      PHA                                 ;;C23B|C23B/C23B\C23B;
                      ADC.B #$00                          ;;C23C|C23C/C23C\C23C;
                      STA.B !Layer1YPos+1                 ;;C23E|C23E/C23E\C23E;
                      JSL GenericSprGfxRt2                ;;C240|C240/C240\C240;
                      LDY.W !SpriteOAMIndex,X             ;;C244|C244/C244\C244; Y = Index into sprite OAM 
                      LDA.B #$2A                          ;;C247|C247/C247\C247;
                      STA.W !OAMTileNo+$100,Y             ;;C249|C249/C249\C249;
                      LDA.W !OAMTileAttr+$100,Y           ;;C24C|C24C/C24C\C24C;
                      AND.B #$BF                          ;;C24F|C24F/C24F\C24F;
                      STA.W !OAMTileAttr+$100,Y           ;;C251|C251/C251\C251;
                      PLA                                 ;;C254|C254/C254\C254;
                      STA.B !Layer1YPos+1                 ;;C255|C255/C255\C255;
                      PLA                                 ;;C257|C257/C257\C257;
                      STA.B !Layer1YPos                   ;;C258|C258/C258\C258;
                      RTS                                 ;;C25A|C25A/C25A\C25A; Return 
                                                          ;;                   ;
                                                          ;;                   ;
ChainsawMotorTiles:   db $E0,$C2,$C0,$C2                  ;;C25B|C25B/C25B\C25B;
                                                          ;;                   ;
DATA_03C25F:          db $F2,$0E                          ;;C25F|C25F/C25F\C25F;
                                                          ;;                   ;
DATA_03C261:          db $33,$B3                          ;;C261|C261/C261\C261;
                                                          ;;                   ;
CODE_03C263:          PHB                                 ;;C263|C263/C263\C263; Wrapper 
                      PHK                                 ;;C264|C264/C264\C264;
                      PLB                                 ;;C265|C265/C265\C265;
                      JSR ChainsawGfx                     ;;C266|C266/C266\C266;
                      PLB                                 ;;C269|C269/C269\C269;
                      RTL                                 ;;C26A|C26A/C26A\C26A; Return 
                                                          ;;                   ;
ChainsawGfx:          JSR GetDrawInfoBnk3                 ;;C26B|C26B/C26B\C26B;
                      PHX                                 ;;C26E|C26E/C26E\C26E;
                      LDA.B !SpriteNumber,X               ;;C26F|C26F/C26F\C26F;
                      SEC                                 ;;C271|C271/C271\C271;
                      SBC.B #$65                          ;;C272|C272/C272\C272;
                      TAX                                 ;;C274|C274/C274\C274;
                      LDA.W DATA_03C25F,X                 ;;C275|C275/C275\C275;
                      STA.B !_3                           ;;C278|C278/C278\C278;
                      LDA.W DATA_03C261,X                 ;;C27A|C27A/C27A\C27A;
                      STA.B !_4                           ;;C27D|C27D/C27D\C27D;
                      PLX                                 ;;C27F|C27F/C27F\C27F;
                      LDA.B !EffFrame                     ;;C280|C280/C280\C280;
                      AND.B #$02                          ;;C282|C282/C282\C282;
                      STA.B !_2                           ;;C284|C284/C284\C284;
                      LDA.B !_0                           ;;C286|C286/C286\C286;
                      SEC                                 ;;C288|C288/C288\C288;
                      SBC.B #$08                          ;;C289|C289/C289\C289;
                      STA.W !OAMTileXPos+$100,Y           ;;C28B|C28B/C28B\C28B;
                      STA.W !OAMTileXPos+$104,Y           ;;C28E|C28E/C28E\C28E;
                      STA.W !OAMTileXPos+$108,Y           ;;C291|C291/C291\C291;
                      LDA.B !_1                           ;;C294|C294/C294\C294;
                      SEC                                 ;;C296|C296/C296\C296;
                      SBC.B #$08                          ;;C297|C297/C297\C297;
                      STA.W !OAMTileYPos+$100,Y           ;;C299|C299/C299\C299;
                      CLC                                 ;;C29C|C29C/C29C\C29C;
                      ADC.B !_3                           ;;C29D|C29D/C29D\C29D;
                      CLC                                 ;;C29F|C29F/C29F\C29F;
                      ADC.B !_2                           ;;C2A0|C2A0/C2A0\C2A0;
                      STA.W !OAMTileYPos+$104,Y           ;;C2A2|C2A2/C2A2\C2A2;
                      CLC                                 ;;C2A5|C2A5/C2A5\C2A5;
                      ADC.B !_3                           ;;C2A6|C2A6/C2A6\C2A6;
                      STA.W !OAMTileYPos+$108,Y           ;;C2A8|C2A8/C2A8\C2A8;
                      LDA.B !EffFrame                     ;;C2AB|C2AB/C2AB\C2AB;
                      LSR A                               ;;C2AD|C2AD/C2AD\C2AD;
                      LSR A                               ;;C2AE|C2AE/C2AE\C2AE;
                      AND.B #$03                          ;;C2AF|C2AF/C2AF\C2AF;
                      PHX                                 ;;C2B1|C2B1/C2B1\C2B1;
                      TAX                                 ;;C2B2|C2B2/C2B2\C2B2;
                      LDA.W ChainsawMotorTiles,X          ;;C2B3|C2B3/C2B3\C2B3;
                      STA.W !OAMTileNo+$100,Y             ;;C2B6|C2B6/C2B6\C2B6;
                      PLX                                 ;;C2B9|C2B9/C2B9\C2B9;
                      LDA.B #$AE                          ;;C2BA|C2BA/C2BA\C2BA;
                      STA.W !OAMTileNo+$104,Y             ;;C2BC|C2BC/C2BC\C2BC;
                      LDA.B #$8E                          ;;C2BF|C2BF/C2BF\C2BF;
                      STA.W !OAMTileNo+$108,Y             ;;C2C1|C2C1/C2C1\C2C1;
                      LDA.B #$37                          ;;C2C4|C2C4/C2C4\C2C4;
                      STA.W !OAMTileAttr+$100,Y           ;;C2C6|C2C6/C2C6\C2C6;
                      LDA.B !_4                           ;;C2C9|C2C9/C2C9\C2C9;
                      STA.W !OAMTileAttr+$104,Y           ;;C2CB|C2CB/C2CB\C2CB;
                      STA.W !OAMTileAttr+$108,Y           ;;C2CE|C2CE/C2CE\C2CE;
                      LDY.B #$02                          ;;C2D1|C2D1/C2D1\C2D1;
                      TYA                                 ;;C2D3|C2D3/C2D3\C2D3;
                      JSL FinishOAMWrite                  ;;C2D4|C2D4/C2D4\C2D4;
                      RTS                                 ;;C2D8|C2D8/C2D8\C2D8; Return 
                                                          ;;                   ;
TriggerInivis1Up:     PHX                                 ;;C2D9|C2D9/C2D9\C2D9; \ Find free sprite slot (#$0B-#$00) 
                      LDX.B #$0B                          ;;C2DA|C2DA/C2DA\C2DA;  | 
CODE_03C2DC:          LDA.W !SpriteStatus,X               ;;C2DC|C2DC/C2DC\C2DC;  | 
                      BEQ Generate1Up                     ;;C2DF|C2DF/C2DF\C2DF;  | 
                      DEX                                 ;;C2E1|C2E1/C2E1\C2E1;  | 
                      BPL CODE_03C2DC                     ;;C2E2|C2E2/C2E2\C2E2;  | 
                      PLX                                 ;;C2E4|C2E4/C2E4\C2E4;  | 
                      RTL                                 ;;C2E5|C2E5/C2E5\C2E5; / 
                                                          ;;                   ;
Generate1Up:          LDA.B #$08                          ;;C2E6|C2E6/C2E6\C2E6; \ Sprite status = Normal 
                      STA.W !SpriteStatus,X               ;;C2E8|C2E8/C2E8\C2E8; / 
                      LDA.B #$78                          ;;C2EB|C2EB/C2EB\C2EB; \ Sprite = 1Up 
                      STA.B !SpriteNumber,X               ;;C2ED|C2ED/C2ED\C2ED; / 
                      LDA.B !PlayerXPosNext               ;;C2EF|C2EF/C2EF\C2EF; \ Sprite X position = Mario X position 
                      STA.B !SpriteXPosLow,X              ;;C2F1|C2F1/C2F1\C2F1;  | 
                      LDA.B !PlayerXPosNext+1             ;;C2F3|C2F3/C2F3\C2F3;  | 
                      STA.W !SpriteYPosHigh,X             ;;C2F5|C2F5/C2F5\C2F5; / 
                      LDA.B !PlayerYPosNext               ;;C2F8|C2F8/C2F8\C2F8; \ Sprite Y position = Matio Y position 
                      STA.B !SpriteYPosLow,X              ;;C2FA|C2FA/C2FA\C2FA;  | 
                      LDA.B !PlayerYPosNext+1             ;;C2FC|C2FC/C2FC\C2FC;  | 
                      STA.W !SpriteXPosHigh,X             ;;C2FE|C2FE/C2FE\C2FE; / 
                      JSL InitSpriteTables                ;;C301|C301/C301\C301; Load sprite tables 
                      LDA.B #$10                          ;;C305|C305/C305\C305; \ Disable interaction timer = #$10 
                      STA.W !SpriteMisc154C,X             ;;C307|C307/C307\C307; / 
                      JSR PopupMushroom                   ;;C30A|C30A/C30A\C30A;
                      PLX                                 ;;C30D|C30D/C30D\C30D;
                      RTL                                 ;;C30E|C30E/C30E\C30E; Return 
                                                          ;;                   ;
InvisMushroom:        JSR GetDrawInfoBnk3                 ;;C30F|C30F/C30F\C30F;
                      JSL MarioSprInteract                ;;C312|C312/C312\C312; \ Return if no interaction 
                      BCC Return03C347                    ;;C316|C316/C316\C316; / 
                      LDA.B #$74                          ;;C318|C318/C318\C318; \ Replace, Sprite = Mushroom 
                      STA.B !SpriteNumber,X               ;;C31A|C31A/C31A\C31A; / 
                      JSL InitSpriteTables                ;;C31C|C31C/C31C\C31C; Reset sprite tables 
                      LDA.B #$20                          ;;C320|C320/C320\C320; \ Disable interaction timer = #$20 
                      STA.W !SpriteMisc154C,X             ;;C322|C322/C322\C322; / 
                      LDA.B !SpriteYPosLow,X              ;;C325|C325/C325\C325; \ Sprite Y position = Mario Y position - $000F 
                      SEC                                 ;;C327|C327/C327\C327;  | 
                      SBC.B #$0F                          ;;C328|C328/C328\C328;  | 
                      STA.B !SpriteYPosLow,X              ;;C32A|C32A/C32A\C32A;  | 
                      LDA.W !SpriteXPosHigh,X             ;;C32C|C32C/C32C\C32C;  | 
                      SBC.B #$00                          ;;C32F|C32F/C32F\C32F;  | 
                      STA.W !SpriteXPosHigh,X             ;;C331|C331/C331\C331; / 
PopupMushroom:        LDA.B #$00                          ;;C334|C334/C334\C334; \ Sprite direction = dirction of Mario's X speed 
                      LDY.B !PlayerXSpeed                 ;;C336|C336/C336\C336;  | 
                      BPL +                               ;;C338|C338/C338\C338;  | 
                      INC A                               ;;C33A|C33A/C33A\C33A;  | 
                    + STA.W !SpriteMisc157C,X             ;;C33B|C33B/C33B\C33B; / 
                      LDA.B #$C0                          ;;C33E|C33E/C33E\C33E; \ Set upward speed 
                      STA.B !SpriteYSpeed,X               ;;C340|C340/C340\C340; / 
                      LDA.B #$02                          ;;C342|C342/C342\C342; \ Play sound effect 
                      STA.W !SPCIO3                       ;;C344|C344/C344\C344; / 
Return03C347:         RTS                                 ;;C347|C347/C347\C347; Return 
                                                          ;;                   ;
                                                          ;;                   ;
NinjiSpeedY:          db $D0,$C0,$B0,$D0                  ;;C348|C348/C348\C348;
                                                          ;;                   ;
Ninji:                JSL GenericSprGfxRt2                ;;C34C|C34C/C34C\C34C; Draw sprite uing the routine for sprites <= 53 
                      LDA.B !SpriteLock                   ;;C350|C350/C350\C350; \ Return if sprites locked 
                      BNE Return03C38F                    ;;C352|C352/C352\C352; / 
                      JSR SubHorzPosBnk3                  ;;C354|C354/C354\C354; \ Always face mario 
                      TYA                                 ;;C357|C357/C357\C357;  | 
                      STA.W !SpriteMisc157C,X             ;;C358|C358/C358\C358; / 
                      JSR SubOffscreen0Bnk3               ;;C35B|C35B/C35B\C35B; Only process while onscreen 
                      JSL SprSpr_MarioSprRts              ;;C35E|C35E/C35E\C35E; Interact with mario 
                      JSL UpdateSpritePos                 ;;C362|C362/C362\C362; Update position based on speed values       
                      LDA.W !SpriteBlockedDirs,X          ;;C366|C366/C366\C366; \ Branch if not on ground 
                      AND.B #$04                          ;;C369|C369/C369\C369;  | 
                      BEQ +                               ;;C36B|C36B/C36B\C36B; / 
                      STZ.B !SpriteYSpeed,X               ;;C36D|C36D/C36D\C36D; Sprite Y Speed = 0 
                      LDA.W !SpriteMisc1540,X             ;;C36F|C36F/C36F\C36F;
                      BNE +                               ;;C372|C372/C372\C372;
                      LDA.B #$60                          ;;C374|C374/C374\C374;
                      STA.W !SpriteMisc1540,X             ;;C376|C376/C376\C376;
                      INC.B !SpriteTableC2,X              ;;C379|C379/C379\C379;
                      LDA.B !SpriteTableC2,X              ;;C37B|C37B/C37B\C37B;
                      AND.B #$03                          ;;C37D|C37D/C37D\C37D;
                      TAY                                 ;;C37F|C37F/C37F\C37F;
                      LDA.W NinjiSpeedY,Y                 ;;C380|C380/C380\C380;
                      STA.B !SpriteYSpeed,X               ;;C383|C383/C383\C383;
                    + LDA.B #$00                          ;;C385|C385/C385\C385;
                      LDY.B !SpriteYSpeed,X               ;;C387|C387/C387\C387;
                      BMI +                               ;;C389|C389/C389\C389;
                      INC A                               ;;C38B|C38B/C38B\C38B;
                    + STA.W !SpriteMisc1602,X             ;;C38C|C38C/C38C\C38C;
Return03C38F:         RTS                                 ;;C38F|C38F/C38F\C38F; Return 
                                                          ;;                   ;
CODE_03C390:          PHB                                 ;;C390|C390/C390\C390;
                      PHK                                 ;;C391|C391/C391\C391;
                      PLB                                 ;;C392|C392/C392\C392;
                      LDA.W !SpriteMisc157C,X             ;;C393|C393/C393\C393;
                      PHA                                 ;;C396|C396/C396\C396;
                      LDY.W !SpriteMisc15AC,X             ;;C397|C397/C397\C397;
                      BEQ +                               ;;C39A|C39A/C39A\C39A;
                      CPY.B #$05                          ;;C39C|C39C/C39C\C39C;
                      BCC +                               ;;C39E|C39E/C39E\C39E;
                      EOR.B #$01                          ;;C3A0|C3A0/C3A0\C3A0;
                      STA.W !SpriteMisc157C,X             ;;C3A2|C3A2/C3A2\C3A2;
                    + JSR CODE_03C3DA                     ;;C3A5|C3A5/C3A5\C3A5;
                      PLA                                 ;;C3A8|C3A8/C3A8\C3A8;
                      STA.W !SpriteMisc157C,X             ;;C3A9|C3A9/C3A9\C3A9;
                      PLB                                 ;;C3AC|C3AC/C3AC\C3AC;
                      RTL                                 ;;C3AD|C3AD/C3AD\C3AD; Return 
                                                          ;;                   ;
                    - JSL GenericSprGfxRt2                ;;C3AE|C3AE/C3AE\C3AE;
                      RTS                                 ;;C3B2|C3B2/C3B2\C3B2; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DryBonesTileDispX:    db $00,$08,$00,$00,$F8,$00,$00,$04  ;;C3B3|C3B3/C3B3\C3B3;
                      db $00,$00,$FC,$00                  ;;C3BB|C3BB/C3BB\C3BB;
                                                          ;;                   ;
DryBonesGfxProp:      db $43,$43,$43,$03,$03,$03          ;;C3BF|C3BF/C3BF\C3BF;
                                                          ;;                   ;
DryBonesTileDispY:    db $F4,$F0,$00,$F4,$F1,$00,$F4,$F0  ;;C3C5|C3C5/C3C5\C3C5;
                      db $00                              ;;C3CD|C3CD/C3CD\C3CD;
                                                          ;;                   ;
DryBonesTiles:        db $00,$64,$66,$00,$64,$68,$82,$64  ;;C3CE|C3CE/C3CE\C3CE;
                      db $E6                              ;;C3D6|C3D6/C3D6\C3D6;
                                                          ;;                   ;
DATA_03C3D7:          db $00,$00,$FF                      ;;C3D7|C3D7/C3D7\C3D7;
                                                          ;;                   ;
CODE_03C3DA:          LDA.B !SpriteNumber,X               ;;C3DA|C3DA/C3DA\C3DA;
                      CMP.B #$31                          ;;C3DC|C3DC/C3DC\C3DC;
                      BEQ -                               ;;C3DE|C3DE/C3DE\C3DE;
                      JSR GetDrawInfoBnk3                 ;;C3E0|C3E0/C3E0\C3E0;
                      LDA.W !SpriteMisc15AC,X             ;;C3E3|C3E3/C3E3\C3E3;
                      STA.B !_5                           ;;C3E6|C3E6/C3E6\C3E6;
                      LDA.W !SpriteMisc157C,X             ;;C3E8|C3E8/C3E8\C3E8;
                      ASL A                               ;;C3EB|C3EB/C3EB\C3EB;
                      ADC.W !SpriteMisc157C,X             ;;C3EC|C3EC/C3EC\C3EC;
                      STA.B !_2                           ;;C3EF|C3EF/C3EF\C3EF;
                      PHX                                 ;;C3F1|C3F1/C3F1\C3F1;
                      LDA.W !SpriteMisc1602,X             ;;C3F2|C3F2/C3F2\C3F2;
                      PHA                                 ;;C3F5|C3F5/C3F5\C3F5;
                      ASL A                               ;;C3F6|C3F6/C3F6\C3F6;
                      ADC.W !SpriteMisc1602,X             ;;C3F7|C3F7/C3F7\C3F7;
                      STA.B !_3                           ;;C3FA|C3FA/C3FA\C3FA;
                      PLX                                 ;;C3FC|C3FC/C3FC\C3FC;
                      LDA.W DATA_03C3D7,X                 ;;C3FD|C3FD/C3FD\C3FD;
                      STA.B !_4                           ;;C400|C400/C400\C400;
                      LDX.B #$02                          ;;C402|C402/C402\C402;
CODE_03C404:          PHX                                 ;;C404|C404/C404\C404;
                      TXA                                 ;;C405|C405/C405\C405;
                      CLC                                 ;;C406|C406/C406\C406;
                      ADC.B !_2                           ;;C407|C407/C407\C407;
                      TAX                                 ;;C409|C409/C409\C409;
                      PHX                                 ;;C40A|C40A/C40A\C40A;
                      LDA.B !_5                           ;;C40B|C40B/C40B\C40B;
                      BEQ +                               ;;C40D|C40D/C40D\C40D;
                      TXA                                 ;;C40F|C40F/C40F\C40F;
                      CLC                                 ;;C410|C410/C410\C410;
                      ADC.B #$06                          ;;C411|C411/C411\C411;
                      TAX                                 ;;C413|C413/C413\C413;
                    + LDA.B !_0                           ;;C414|C414/C414\C414;
                      CLC                                 ;;C416|C416/C416\C416;
                      ADC.W DryBonesTileDispX,X           ;;C417|C417/C417\C417;
                      STA.W !OAMTileXPos+$100,Y           ;;C41A|C41A/C41A\C41A;
                      PLX                                 ;;C41D|C41D/C41D\C41D;
                      LDA.W DryBonesGfxProp,X             ;;C41E|C41E/C41E\C41E;
                      ORA.B !SpriteProperties             ;;C421|C421/C421\C421;
                      STA.W !OAMTileAttr+$100,Y           ;;C423|C423/C423\C423;
                      PLA                                 ;;C426|C426/C426\C426;
                      PHA                                 ;;C427|C427/C427\C427;
                      CLC                                 ;;C428|C428/C428\C428;
                      ADC.B !_3                           ;;C429|C429/C429\C429;
                      TAX                                 ;;C42B|C42B/C42B\C42B;
                      LDA.B !_1                           ;;C42C|C42C/C42C\C42C;
                      CLC                                 ;;C42E|C42E/C42E\C42E;
                      ADC.W DryBonesTileDispY,X           ;;C42F|C42F/C42F\C42F;
                      STA.W !OAMTileYPos+$100,Y           ;;C432|C432/C432\C432;
                      LDA.W DryBonesTiles,X               ;;C435|C435/C435\C435;
                      STA.W !OAMTileNo+$100,Y             ;;C438|C438/C438\C438;
                      PLX                                 ;;C43B|C43B/C43B\C43B;
                      INY                                 ;;C43C|C43C/C43C\C43C;
                      INY                                 ;;C43D|C43D/C43D\C43D;
                      INY                                 ;;C43E|C43E/C43E\C43E;
                      INY                                 ;;C43F|C43F/C43F\C43F;
                      DEX                                 ;;C440|C440/C440\C440;
                      CPX.B !_4                           ;;C441|C441/C441\C441;
                      BNE CODE_03C404                     ;;C443|C443/C443\C443;
                      PLX                                 ;;C445|C445/C445\C445;
                      LDY.B #$02                          ;;C446|C446/C446\C446;
                      TYA                                 ;;C448|C448/C448\C448;
                      JSL FinishOAMWrite                  ;;C449|C449/C449\C449;
                      RTS                                 ;;C44D|C44D/C44D\C44D; Return 
                                                          ;;                   ;
CODE_03C44E:          LDA.W !SpriteOffscreenX,X           ;;C44E|C44E/C44E\C44E;
                      ORA.W !SpriteOffscreenVert,X        ;;C451|C451/C451\C451;
                      BNE Return03C460                    ;;C454|C454/C454\C454;
                      LDY.B #$07                          ;;C456|C456/C456\C456; \ Find a free extended sprite slot 
CODE_03C458:          LDA.W !ExtSpriteNumber,Y            ;;C458|C458/C458\C458;  | 
                      BEQ CODE_03C461                     ;;C45B|C45B/C45B\C45B;  | 
                      DEY                                 ;;C45D|C45D/C45D\C45D;  | 
                      BPL CODE_03C458                     ;;C45E|C45E/C45E\C45E;  | 
Return03C460:         RTL                                 ;;C460|C460/C460\C460; / Return if no free slots 
                                                          ;;                   ;
CODE_03C461:          LDA.B #$06                          ;;C461|C461/C461\C461; \ Extended sprite = Bone 
                      STA.W !ExtSpriteNumber,Y            ;;C463|C463/C463\C463; / 
                      LDA.B !SpriteYPosLow,X              ;;C466|C466/C466\C466;
                      SEC                                 ;;C468|C468/C468\C468;
                      SBC.B #$10                          ;;C469|C469/C469\C469;
                      STA.W !ExtSpriteYPosLow,Y           ;;C46B|C46B/C46B\C46B;
                      LDA.W !SpriteXPosHigh,X             ;;C46E|C46E/C46E\C46E;
                      SBC.B #$00                          ;;C471|C471/C471\C471;
                      STA.W !ExtSpriteYPosHigh,Y          ;;C473|C473/C473\C473;
                      LDA.B !SpriteXPosLow,X              ;;C476|C476/C476\C476;
                      STA.W !ExtSpriteXPosLow,Y           ;;C478|C478/C478\C478;
                      LDA.W !SpriteYPosHigh,X             ;;C47B|C47B/C47B\C47B;
                      STA.W !ExtSpriteXPosHigh,Y          ;;C47E|C47E/C47E\C47E;
                      LDA.W !SpriteMisc157C,X             ;;C481|C481/C481\C481;
                      LSR A                               ;;C484|C484/C484\C484;
                      LDA.B #$18                          ;;C485|C485/C485\C485;
                      BCC +                               ;;C487|C487/C487\C487;
                      LDA.B #$E8                          ;;C489|C489/C489\C489;
                    + STA.W !ExtSpriteXSpeed,Y            ;;C48B|C48B/C48B\C48B;
                      RTL                                 ;;C48E|C48E/C48E\C48E; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C48F:          db $01,$FF                          ;;C48F|C48F/C48F\C48F;
                                                          ;;                   ;
DATA_03C491:          db $FF,$90                          ;;C491|C491/C491\C491;
                                                          ;;                   ;
DiscoBallTiles:       db $80,$82,$84,$86,$88,$8C,$C0,$C2  ;;C493|C493/C493\C493;
                      db $C2                              ;;C49B|C49B/C49B\C49B;
                                                          ;;                   ;
DATA_03C49C:          db $31,$33,$35,$37,$31,$33,$35,$37  ;;C49C|C49C/C49C\C49C;
                      db $39                              ;;C4A4|C4A4/C4A4\C4A4;
                                                          ;;                   ;
CODE_03C4A5:          LDY.W !SpriteOAMIndex,X             ;;C4A5|C4A5/C4A5\C4A5; Y = Index into sprite OAM 
                      LDA.B #$78                          ;;C4A8|C4A8/C4A8\C4A8;
                      STA.W !OAMTileXPos+$100,Y           ;;C4AA|C4AA/C4AA\C4AA;
                      LDA.B #$28                          ;;C4AD|C4AD/C4AD\C4AD;
                      STA.W !OAMTileYPos+$100,Y           ;;C4AF|C4AF/C4AF\C4AF;
                      PHX                                 ;;C4B2|C4B2/C4B2\C4B2;
                      LDA.B !SpriteTableC2,X              ;;C4B3|C4B3/C4B3\C4B3;
                      LDX.B #$08                          ;;C4B5|C4B5/C4B5\C4B5;
                      AND.B #$01                          ;;C4B7|C4B7/C4B7\C4B7;
                      BEQ +                               ;;C4B9|C4B9/C4B9\C4B9;
                      LDA.B !TrueFrame                    ;;C4BB|C4BB/C4BB\C4BB;
                      LSR A                               ;;C4BD|C4BD/C4BD\C4BD;
                      AND.B #$07                          ;;C4BE|C4BE/C4BE\C4BE;
                      TAX                                 ;;C4C0|C4C0/C4C0\C4C0;
                    + LDA.W DiscoBallTiles,X              ;;C4C1|C4C1/C4C1\C4C1;
                      STA.W !OAMTileNo+$100,Y             ;;C4C4|C4C4/C4C4\C4C4;
                      LDA.W DATA_03C49C,X                 ;;C4C7|C4C7/C4C7\C4C7;
                      STA.W !OAMTileAttr+$100,Y           ;;C4CA|C4CA/C4CA\C4CA;
                      TYA                                 ;;C4CD|C4CD/C4CD\C4CD;
                      LSR A                               ;;C4CE|C4CE/C4CE\C4CE;
                      LSR A                               ;;C4CF|C4CF/C4CF\C4CF;
                      TAY                                 ;;C4D0|C4D0/C4D0\C4D0;
                      LDA.B #$02                          ;;C4D1|C4D1/C4D1\C4D1;
                      STA.W !OAMTileSize+$40,Y            ;;C4D3|C4D3/C4D3\C4D3;
                      PLX                                 ;;C4D6|C4D6/C4D6\C4D6;
                      RTS                                 ;;C4D7|C4D7/C4D7\C4D7; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C4D8:          db $10,$8C                          ;;C4D8|C4D8/C4D8\C4D8;
                                                          ;;                   ;
DATA_03C4DA:          db $42,$31                          ;;C4DA|C4DA/C4DA\C4DA;
                                                          ;;                   ;
DarkRoomWithLight:    LDA.W !SpriteMisc1534,X             ;;C4DC|C4DC/C4DC\C4DC;
                      BNE CODE_03C500                     ;;C4DF|C4DF/C4DF\C4DF;
                      LDY.B #$09                          ;;C4E1|C4E1/C4E1\C4E1;
CODE_03C4E3:          CPY.W !CurSpriteProcess             ;;C4E3|C4E3/C4E3\C4E3;
                      BEQ +                               ;;C4E6|C4E6/C4E6\C4E6;
                      LDA.W !SpriteStatus,Y               ;;C4E8|C4E8/C4E8\C4E8;
                      CMP.B #$08                          ;;C4EB|C4EB/C4EB\C4EB;
                      BNE +                               ;;C4ED|C4ED/C4ED\C4ED;
                      LDA.W !SpriteNumber,Y               ;;C4EF|C4EF/C4EF\C4EF;
                      CMP.B #$C6                          ;;C4F2|C4F2/C4F2\C4F2;
                      BNE +                               ;;C4F4|C4F4/C4F4\C4F4;
                      STZ.W !SpriteStatus,X               ;;C4F6|C4F6/C4F6\C4F6;
Return03C4F9:         RTS                                 ;;C4F9|C4F9/C4F9\C4F9; Return 
                                                          ;;                   ;
                    + DEY                                 ;;C4FA|C4FA/C4FA\C4FA;
                      BPL CODE_03C4E3                     ;;C4FB|C4FB/C4FB\C4FB;
                      INC.W !SpriteMisc1534,X             ;;C4FD|C4FD/C4FD\C4FD;
CODE_03C500:          JSR CODE_03C4A5                     ;;C500|C500/C500\C500;
                      LDA.B #$FF                          ;;C503|C503/C503\C503;
                      STA.B !ColorSettings                ;;C505|C505/C505\C505;
                      LDA.B #$20                          ;;C507|C507/C507\C507;
                      STA.B !ColorAddition                ;;C509|C509/C509\C509;
                      LDA.B #$20                          ;;C50B|C50B/C50B\C50B;
                      STA.B !OBJCWWindow                  ;;C50D|C50D/C50D\C50D;
                      LDA.B #$80                          ;;C50F|C50F/C50F\C50F;
                      STA.W !HDMAEnable                   ;;C511|C511/C511\C511;
                      LDA.B !SpriteTableC2,X              ;;C514|C514/C514\C514;
                      AND.B #$01                          ;;C516|C516/C516\C516;
                      TAY                                 ;;C518|C518/C518\C518;
                      LDA.W DATA_03C4D8,Y                 ;;C519|C519/C519\C519;
                      STA.W !BackgroundColor              ;;C51C|C51C/C51C\C51C;
                      LDA.W DATA_03C4DA,Y                 ;;C51F|C51F/C51F\C51F;
                      STA.W !BackgroundColor+1            ;;C522|C522/C522\C522;
                      LDA.B !SpriteLock                   ;;C525|C525/C525\C525;
                      BNE Return03C4F9                    ;;C527|C527/C527\C527;
                      LDA.W !LightSkipInit                ;;C529|C529/C529\C529;
                      BNE +                               ;;C52C|C52C/C52C\C52C;
                      LDA.B #$00                          ;;C52E|C52E/C52E\C52E;
                      STA.W !LightBotWinOpenPos           ;;C530|C530/C530\C530;
                      LDA.B #$90                          ;;C533|C533/C533\C533;
                      STA.W !LightBotWinClosePos          ;;C535|C535/C535\C535;
                      LDA.B #$78                          ;;C538|C538/C538\C538;
                      STA.W !LightTopWinOpenPos           ;;C53A|C53A/C53A\C53A;
                      LDA.B #$87                          ;;C53D|C53D/C53D\C53D;
                      STA.W !LightTopWinClosePos          ;;C53F|C53F/C53F\C53F;
                      LDA.B #$01                          ;;C542|C542/C542\C542;
                      STA.W !LightExists                  ;;C544|C544/C544\C544;
                      STZ.W !LightMoveDir                 ;;C547|C547/C547\C547;
                      INC.W !LightSkipInit                ;;C54A|C54A/C54A\C54A;
                    + LDY.W !LightMoveDir                 ;;C54D|C54D/C54D\C54D;
                      LDA.W !LightBotWinOpenPos           ;;C550|C550/C550\C550;
                      CLC                                 ;;C553|C553/C553\C553;
                      ADC.W DATA_03C48F,Y                 ;;C554|C554/C554\C554;
                      STA.W !LightBotWinOpenPos           ;;C557|C557/C557\C557;
                      LDA.W !LightBotWinClosePos          ;;C55A|C55A/C55A\C55A;
                      CLC                                 ;;C55D|C55D/C55D\C55D;
                      ADC.W DATA_03C48F,Y                 ;;C55E|C55E/C55E\C55E;
                      STA.W !LightBotWinClosePos          ;;C561|C561/C561\C561;
                      CMP.W DATA_03C491,Y                 ;;C564|C564/C564\C564;
                      BNE +                               ;;C567|C567/C567\C567;
                      LDA.W !LightMoveDir                 ;;C569|C569/C569\C569;
                      INC A                               ;;C56C|C56C/C56C\C56C;
                      AND.B #$01                          ;;C56D|C56D/C56D\C56D;
                      STA.W !LightMoveDir                 ;;C56F|C56F/C56F\C56F;
                    + LDA.B !TrueFrame                    ;;C572|C572/C572\C572;
                      AND.B #$03                          ;;C574|C574/C574\C574;
                      BNE Return03C4F9                    ;;C576|C576/C576\C576;
                      LDY.B #$00                          ;;C578|C578/C578\C578;
                      LDA.W !LightTopWinOpenPos           ;;C57A|C57A/C57A\C57A;
                      STA.W !LightWinOpenCalc             ;;C57D|C57D/C57D\C57D;
                      SEC                                 ;;C580|C580/C580\C580;
                      SBC.W !LightBotWinOpenPos           ;;C581|C581/C581\C581;
                      BCS +                               ;;C584|C584/C584\C584;
                      INY                                 ;;C586|C586/C586\C586;
                      EOR.B #$FF                          ;;C587|C587/C587\C587;
                      INC A                               ;;C589|C589/C589\C589;
                    + STA.W !LightLeftWidth               ;;C58A|C58A/C58A\C58A;
                      STY.W !LightLeftRelPos              ;;C58D|C58D/C58D\C58D;
                      STZ.W !LightWinOpenMove             ;;C590|C590/C590\C590;
                      LDY.B #$00                          ;;C593|C593/C593\C593;
                      LDA.W !LightTopWinClosePos          ;;C595|C595/C595\C595;
                      STA.W !LightWinCloseCalc            ;;C598|C598/C598\C598;
                      SEC                                 ;;C59B|C59B/C59B\C59B;
                      SBC.W !LightBotWinClosePos          ;;C59C|C59C/C59C\C59C;
                      BCS +                               ;;C59F|C59F/C59F\C59F;
                      INY                                 ;;C5A1|C5A1/C5A1\C5A1;
                      EOR.B #$FF                          ;;C5A2|C5A2/C5A2\C5A2;
                      INC A                               ;;C5A4|C5A4/C5A4\C5A4;
                    + STA.W !LightRightWidth              ;;C5A5|C5A5/C5A5\C5A5;
                      STY.W !LightRightRelPos             ;;C5A8|C5A8/C5A8\C5A8;
                      STZ.W !LightWinCloseMove            ;;C5AB|C5AB/C5AB\C5AB;
                      LDA.B !SpriteTableC2,X              ;;C5AE|C5AE/C5AE\C5AE;
                      STA.B !_F                           ;;C5B0|C5B0/C5B0\C5B0;
                      PHX                                 ;;C5B2|C5B2/C5B2\C5B2;
                      REP #$10                            ;;C5B3|C5B3/C5B3\C5B3; Index (16 bit) 
                      LDX.W #$0000                        ;;C5B5|C5B5/C5B5\C5B5;
CODE_03C5B8:          CPX.W #$005F                        ;;C5B8|C5B8/C5B8\C5B8;
                      BCC CODE_03C607                     ;;C5BB|C5BB/C5BB\C5BB;
                      LDA.W !LightWinOpenMove             ;;C5BD|C5BD/C5BD\C5BD;
                      CLC                                 ;;C5C0|C5C0/C5C0\C5C0;
                      ADC.W !LightLeftWidth               ;;C5C1|C5C1/C5C1\C5C1;
                      STA.W !LightWinOpenMove             ;;C5C4|C5C4/C5C4\C5C4;
                      BCS CODE_03C5CD                     ;;C5C7|C5C7/C5C7\C5C7;
                      CMP.B #$CF                          ;;C5C9|C5C9/C5C9\C5C9;
                      BCC +                               ;;C5CB|C5CB/C5CB\C5CB;
CODE_03C5CD:          SBC.B #$CF                          ;;C5CD|C5CD/C5CD\C5CD;
                      STA.W !LightWinOpenMove             ;;C5CF|C5CF/C5CF\C5CF;
                      INC.W !LightWinOpenCalc             ;;C5D2|C5D2/C5D2\C5D2;
                      LDA.W !LightLeftRelPos              ;;C5D5|C5D5/C5D5\C5D5;
                      BNE +                               ;;C5D8|C5D8/C5D8\C5D8;
                      DEC.W !LightWinOpenCalc             ;;C5DA|C5DA/C5DA\C5DA;
                      DEC.W !LightWinOpenCalc             ;;C5DD|C5DD/C5DD\C5DD;
                    + LDA.W !LightWinCloseMove            ;;C5E0|C5E0/C5E0\C5E0;
                      CLC                                 ;;C5E3|C5E3/C5E3\C5E3;
                      ADC.W !LightRightWidth              ;;C5E4|C5E4/C5E4\C5E4;
                      STA.W !LightWinCloseMove            ;;C5E7|C5E7/C5E7\C5E7;
                      BCS CODE_03C5F0                     ;;C5EA|C5EA/C5EA\C5EA;
                      CMP.B #$CF                          ;;C5EC|C5EC/C5EC\C5EC;
                      BCC +                               ;;C5EE|C5EE/C5EE\C5EE;
CODE_03C5F0:          SBC.B #$CF                          ;;C5F0|C5F0/C5F0\C5F0;
                      STA.W !LightWinCloseMove            ;;C5F2|C5F2/C5F2\C5F2;
                      INC.W !LightWinCloseCalc            ;;C5F5|C5F5/C5F5\C5F5;
                      LDA.W !LightRightRelPos             ;;C5F8|C5F8/C5F8\C5F8;
                      BNE +                               ;;C5FB|C5FB/C5FB\C5FB;
                      DEC.W !LightWinCloseCalc            ;;C5FD|C5FD/C5FD\C5FD;
                      DEC.W !LightWinCloseCalc            ;;C600|C600/C600\C600;
                    + LDA.B !_F                           ;;C603|C603/C603\C603;
                      BNE CODE_03C60F                     ;;C605|C605/C605\C605;
CODE_03C607:          LDA.B #$01                          ;;C607|C607/C607\C607;
                      STA.W !WindowTable,X                ;;C609|C609/C609\C609;
                      DEC A                               ;;C60C|C60C/C60C\C60C;
                      BRA +                               ;;C60D|C60D/C60D\C60D;
                                                          ;;                   ;
CODE_03C60F:          LDA.W !LightWinOpenCalc             ;;C60F|C60F/C60F\C60F;
                      STA.W !WindowTable,X                ;;C612|C612/C612\C612;
                      LDA.W !LightWinCloseCalc            ;;C615|C615/C615\C615;
                    + STA.W !WindowTable+1,X              ;;C618|C618/C618\C618;
                      INX                                 ;;C61B|C61B/C61B\C61B;
                      INX                                 ;;C61C|C61C/C61C\C61C;
                      CPX.W #con($01C0,$01C0,$01C0,$01E0) ;;C61D|C61D/C61D\C61D;
                      BNE CODE_03C5B8                     ;;C620|C620/C620\C620;
                      SEP #$10                            ;;C622|C622/C622\C622; Index (8 bit) 
                      PLX                                 ;;C624|C624/C624\C624;
                      RTS                                 ;;C625|C625/C625\C625; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C626:          db $14,$28,$38,$20,$30,$4C,$40,$34  ;;C626|C626/C626\C626;
                      db $2C,$1C,$08,$0C,$04,$0C,$1C,$24  ;;C62E|C62E/C62E\C62E;
                      db $2C,$38,$40,$48,$50,$5C,$5C,$6C  ;;C636|C636/C636\C636;
                      db $4C,$58,$24,$78,$64,$70,$78,$7C  ;;C63E|C63E/C63E\C63E;
                      db $70,$68,$58,$4C,$40,$34,$24,$04  ;;C646|C646/C646\C646;
                      db $18,$2C,$0C,$0C,$14,$18,$1C,$24  ;;C64E|C64E/C64E\C64E;
                      db $2C,$28,$24,$30,$30,$34,$38,$3C  ;;C656|C656/C656\C656;
                      db $44,$54,$48,$5C,$68,$40,$4C,$40  ;;C65E|C65E/C65E\C65E;
                      db $3C,$40,$50,$54,$60,$54,$4C,$5C  ;;C666|C666/C666\C666;
                      db $5C,$68,$74,$6C,$7C,$78,$68,$80  ;;C66E|C66E/C66E\C66E;
                      db $18,$48,$2C,$1C                  ;;C676|C676/C676\C676;
                                                          ;;                   ;
DATA_03C67A:          db $1C,$0C,$08,$1C,$14,$08,$14,$24  ;;C67A|C67A/C67A\C67A;
                      db $28,$2C,$30,$3C,$44,$4C,$44,$34  ;;C682|C682/C682\C682;
                      db $40,$34,$24,$1C,$10,$0C,$18,$18  ;;C68A|C68A/C68A\C68A;
                      db $2C,$28,$68,$28,$34,$34,$38,$40  ;;C692|C692/C692\C692;
                      db $44,$44,$38,$3C,$44,$48,$4C,$5C  ;;C69A|C69A/C69A\C69A;
                      db $5C,$54,$64,$74,$74,$88,$80,$94  ;;C6A2|C6A2/C6A2\C6A2;
                      db $8C,$78,$6C,$64,$70,$7C,$8C,$98  ;;C6AA|C6AA/C6AA\C6AA;
                      db $90,$98,$84,$84,$88,$78,$78,$6C  ;;C6B2|C6B2/C6B2\C6B2;
                      db $5C,$50,$50,$48,$50,$5C,$64,$64  ;;C6BA|C6BA/C6BA\C6BA;
                      db $74,$78,$74,$64,$60,$58,$54,$50  ;;C6C2|C6C2/C6C2\C6C2;
                      db $50,$58,$30,$34                  ;;C6CA|C6CA/C6CA\C6CA;
                                                          ;;                   ;
DATA_03C6CE:          db $20,$30,$39,$47,$50,$60,$70,$7C  ;;C6CE|C6CE/C6CE\C6CE;
                      db $7B,$80,$7D,$78,$6E,$60,$4F,$47  ;;C6D6|C6D6/C6D6\C6D6;
                      db $41,$38,$30,$2A,$20,$10,$04,$00  ;;C6DE|C6DE/C6DE\C6DE;
                      db $00,$08,$10,$20,$1A,$10,$0A,$06  ;;C6E6|C6E6/C6E6\C6E6;
                      db $0F,$17,$16,$1C,$1F,$21,$10,$18  ;;C6EE|C6EE/C6EE\C6EE;
                      db $20,$2C,$2E,$3B,$30,$30,$2D,$2A  ;;C6F6|C6F6/C6F6\C6F6;
                      db $34,$36,$3A,$3F,$45,$4D,$5F,$54  ;;C6FE|C6FE/C6FE\C6FE;
                      db $4E,$67,$70,$67,$70,$5C,$4E,$40  ;;C706|C706/C706\C706;
                      db $48,$56,$57,$5F,$68,$72,$77,$6F  ;;C70E|C70E/C70E\C70E;
                      db $66,$60,$67,$5C,$57,$4B,$4D,$54  ;;C716|C716/C716\C716;
                      db $48,$43,$3D,$3C                  ;;C71E|C71E/C71E\C71E;
                                                          ;;                   ;
DATA_03C722:          db $18,$1E,$25,$22,$1A,$17,$20,$30  ;;C722|C722/C722\C722;
                      db $41,$4F,$61,$70,$7F,$8C,$94,$92  ;;C72A|C72A/C72A\C72A;
                      db $A0,$86,$93,$88,$88,$78,$66,$50  ;;C732|C732/C732\C732;
                      db $40,$30,$22,$20,$2C,$30,$40,$4F  ;;C73A|C73A/C73A\C73A;
                      db $59,$51,$3F,$39,$4C,$5F,$6A,$6F  ;;C742|C742/C742\C742;
                      db $77,$7E,$6C,$60,$58,$48,$3D,$2F  ;;C74A|C74A/C74A\C74A;
                      db $28,$38,$44,$30,$36,$27,$21,$2F  ;;C752|C752/C752\C752;
                      db $39,$2A,$2F,$39,$40,$3F,$49,$50  ;;C75A|C75A/C75A\C75A;
                      db $60,$59,$4C,$51,$48,$4F,$56,$67  ;;C762|C762/C762\C762;
                      db $5B,$68,$75,$7D,$87,$8A,$7A,$6B  ;;C76A|C76A/C76A\C76A;
                      db $70,$82,$73,$92                  ;;C772|C772/C772\C772;
                                                          ;;                   ;
DATA_03C776:          db $60,$B0,$40,$80                  ;;C776|C776/C776\C776;
                                                          ;;                   ;
FireworkSfx1:         db $26,$00,$26,$28                  ;;C77A|C77A/C77A\C77A;
                                                          ;;                   ;
FireworkSfx2:         db $00,$2B,$00,$00                  ;;C77E|C77E/C77E\C77E;
                                                          ;;                   ;
FireworkSfx3:         db $27,$00,$27,$29                  ;;C782|C782/C782\C782;
                                                          ;;                   ;
FireworkSfx4:         db $00,$2C,$00,$00                  ;;C786|C786/C786\C786;
                                                          ;;                   ;
DATA_03C78A:          db $00,$AA,$FF,$AA                  ;;C78A|C78A/C78A\C78A;
                                                          ;;                   ;
DATA_03C78E:          db $00,$7E,$27,$7E                  ;;C78E|C78E/C78E\C78E;
                                                          ;;                   ;
DATA_03C792:          db $C0,$C0,$FF,$C0                  ;;C792|C792/C792\C792;
                                                          ;;                   ;
CODE_03C796:          LDA.W !SpriteMisc1564,X             ;;C796|C796/C796\C796;
                      BEQ CODE_03C7A7                     ;;C799|C799/C799\C799;
                      DEC A                               ;;C79B|C79B/C79B\C79B;
                      BNE +                               ;;C79C|C79C/C79C\C79C;
                      INC.W !CutsceneID                   ;;C79E|C79E/C79E\C79E;
                      LDA.B #$FF                          ;;C7A1|C7A1/C7A1\C7A1;
                      STA.W !EndLevelTimer                ;;C7A3|C7A3/C7A3\C7A3;
                    + RTS                                 ;;C7A6|C7A6/C7A6\C7A6; Return 
                                                          ;;                   ;
CODE_03C7A7:          LDA.W !SpriteMisc1564+9             ;;C7A7|C7A7/C7A7\C7A7;
                      AND.B #$03                          ;;C7AA|C7AA/C7AA\C7AA;
                      TAY                                 ;;C7AC|C7AC/C7AC\C7AC;
                      LDA.W DATA_03C78A,Y                 ;;C7AD|C7AD/C7AD\C7AD;
                      STA.W !BackgroundColor              ;;C7B0|C7B0/C7B0\C7B0;
                      LDA.W DATA_03C78E,Y                 ;;C7B3|C7B3/C7B3\C7B3;
                      STA.W !BackgroundColor+1            ;;C7B6|C7B6/C7B6\C7B6;
                      LDA.W !SpriteMisc1FE2+9             ;;C7B9|C7B9/C7B9\C7B9;
                      BNE Return03C80F                    ;;C7BC|C7BC/C7BC\C7BC;
                      LDA.W !SpriteMisc1534,X             ;;C7BE|C7BE/C7BE\C7BE;
                      CMP.B #$04                          ;;C7C1|C7C1/C7C1\C7C1;
                      BEQ CODE_03C810                     ;;C7C3|C7C3/C7C3\C7C3;
                      LDY.B #$01                          ;;C7C5|C7C5/C7C5\C7C5;
CODE_03C7C7:          LDA.W !SpriteStatus,Y               ;;C7C7|C7C7/C7C7\C7C7;
                      BEQ CODE_03C7D0                     ;;C7CA|C7CA/C7CA\C7CA;
                      DEY                                 ;;C7CC|C7CC/C7CC\C7CC;
                      BPL CODE_03C7C7                     ;;C7CD|C7CD/C7CD\C7CD;
                      RTS                                 ;;C7CF|C7CF/C7CF\C7CF; Return 
                                                          ;;                   ;
CODE_03C7D0:          LDA.B #$08                          ;;C7D0|C7D0/C7D0\C7D0; \ Sprite status = Normal 
                      STA.W !SpriteStatus,Y               ;;C7D2|C7D2/C7D2\C7D2; / 
                      LDA.B #$7A                          ;;C7D5|C7D5/C7D5\C7D5;
                      STA.W !SpriteNumber,Y               ;;C7D7|C7D7/C7D7\C7D7;
                      LDA.B #$00                          ;;C7DA|C7DA/C7DA\C7DA;
                      STA.W !SpriteYPosHigh,Y             ;;C7DC|C7DC/C7DC\C7DC;
                      LDA.B #$A8                          ;;C7DF|C7DF/C7DF\C7DF;
                      CLC                                 ;;C7E1|C7E1/C7E1\C7E1;
                      ADC.B !Layer1YPos                   ;;C7E2|C7E2/C7E2\C7E2;
                      STA.W !SpriteYPosLow,Y              ;;C7E4|C7E4/C7E4\C7E4;
                      LDA.B !Layer1YPos+1                 ;;C7E7|C7E7/C7E7\C7E7;
                      ADC.B #$00                          ;;C7E9|C7E9/C7E9\C7E9;
                      STA.W !SpriteXPosHigh,Y             ;;C7EB|C7EB/C7EB\C7EB;
                      PHX                                 ;;C7EE|C7EE/C7EE\C7EE;
                      TYX                                 ;;C7EF|C7EF/C7EF\C7EF;
                      JSL InitSpriteTables                ;;C7F0|C7F0/C7F0\C7F0;
                      PLX                                 ;;C7F4|C7F4/C7F4\C7F4;
                      PHX                                 ;;C7F5|C7F5/C7F5\C7F5;
                      LDA.W !SpriteMisc1534,X             ;;C7F6|C7F6/C7F6\C7F6;
                      AND.B #$03                          ;;C7F9|C7F9/C7F9\C7F9;
                      STA.W !SpriteMisc1534,Y             ;;C7FB|C7FB/C7FB\C7FB;
                      TAX                                 ;;C7FE|C7FE/C7FE\C7FE;
                      LDA.W DATA_03C792,X                 ;;C7FF|C7FF/C7FF\C7FF;
                      STA.W !SpriteMisc1FE2+9             ;;C802|C802/C802\C802;
                      LDA.W DATA_03C776,X                 ;;C805|C805/C805\C805;
                      STA.W !SpriteXPosLow,Y              ;;C808|C808/C808\C808;
                      PLX                                 ;;C80B|C80B/C80B\C80B;
                      INC.W !SpriteMisc1534,X             ;;C80C|C80C/C80C\C80C;
Return03C80F:         RTS                                 ;;C80F|C80F/C80F\C80F; Return 
                                                          ;;                   ;
CODE_03C810:          LDA.B #$70                          ;;C810|C810/C810\C810;
                      STA.W !SpriteMisc1564,X             ;;C812|C812/C812\C812;
                      RTS                                 ;;C815|C815/C815\C815; Return 
                                                          ;;                   ;
Firework:             LDA.B !SpriteTableC2,X              ;;C816|C816/C816\C816;
                      JSL ExecutePtr                      ;;C818|C818/C818\C818;
                                                          ;;                   ;
                      dw CODE_03C828                      ;;C81C|C81C/C81C\C81C;
                      dw CODE_03C845                      ;;C81E|C81E/C81E\C81E;
                      dw CODE_03C88D                      ;;C820|C820/C820\C820;
                      dw CODE_03C941                      ;;C822|C822/C822\C822;
                                                          ;;                   ;
FireworkSpeedY:       db $E4,$E6,$E4,$E2                  ;;C824|C824/C824\C824;
                                                          ;;                   ;
CODE_03C828:          LDY.W !SpriteMisc1534,X             ;;C828|C828/C828\C828;
                      LDA.W FireworkSpeedY,Y              ;;C82B|C82B/C82B\C82B;
                      STA.B !SpriteYSpeed,X               ;;C82E|C82E/C82E\C82E;
                      LDA.B #$25                          ;;C830|C830/C830\C830; \ Play sound effect 
                      STA.W !SPCIO3                       ;;C832|C832/C832\C832; / 
                      LDA.B #$10                          ;;C835|C835/C835\C835;
                      STA.W !SpriteMisc1564,X             ;;C837|C837/C837\C837;
                      INC.B !SpriteTableC2,X              ;;C83A|C83A/C83A\C83A;
                      RTS                                 ;;C83C|C83C/C83C\C83C; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C83D:          db $14,$0C,$10,$15                  ;;C83D|C83D/C83D\C83D;
                                                          ;;                   ;
DATA_03C841:          db $08,$10,$0C,$05                  ;;C841|C841/C841\C841;
                                                          ;;                   ;
CODE_03C845:          LDA.W !SpriteMisc1564,X             ;;C845|C845/C845\C845;
                      CMP.B #$01                          ;;C848|C848/C848\C848;
                      BNE +                               ;;C84A|C84A/C84A\C84A;
                      LDY.W !SpriteMisc1534,X             ;;C84C|C84C/C84C\C84C;
                      LDA.W FireworkSfx1,Y                ;;C84F|C84F/C84F\C84F; \ Play sound effect 
                      STA.W !SPCIO0                       ;;C852|C852/C852\C852; / 
                      LDA.W FireworkSfx2,Y                ;;C855|C855/C855\C855; \ Play sound effect 
                      STA.W !SPCIO3                       ;;C858|C858/C858\C858; / 
                    + JSL UpdateYPosNoGvtyW               ;;C85B|C85B/C85B\C85B;
                      INC.B !SpriteXSpeed,X               ;;C85F|C85F/C85F\C85F;
                      LDA.B !SpriteXSpeed,X               ;;C861|C861/C861\C861;
                      AND.B #$03                          ;;C863|C863/C863\C863;
                      BNE +                               ;;C865|C865/C865\C865;
                      INC.B !SpriteYSpeed,X               ;;C867|C867/C867\C867;
                    + LDA.B !SpriteYSpeed,X               ;;C869|C869/C869\C869;
                      CMP.B #$FC                          ;;C86B|C86B/C86B\C86B;
                      BNE +                               ;;C86D|C86D/C86D\C86D;
                      INC.B !SpriteTableC2,X              ;;C86F|C86F/C86F\C86F;
                      LDY.W !SpriteMisc1534,X             ;;C871|C871/C871\C871;
                      LDA.W DATA_03C83D,Y                 ;;C874|C874/C874\C874;
                      STA.W !SpriteMisc151C,X             ;;C877|C877/C877\C877;
                      LDA.W DATA_03C841,Y                 ;;C87A|C87A/C87A\C87A;
                      STA.W !SpriteMisc15AC,X             ;;C87D|C87D/C87D\C87D;
                      LDA.B #$08                          ;;C880|C880/C880\C880;
                      STA.W !SpriteMisc1564+9             ;;C882|C882/C882\C882;
                    + JSR CODE_03C96D                     ;;C885|C885/C885\C885;
                      RTS                                 ;;C888|C888/C888\C888; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C889:          db $FF,$80,$C0,$FF                  ;;C889|C889/C889\C889;
                                                          ;;                   ;
CODE_03C88D:          LDA.W !SpriteMisc15AC,X             ;;C88D|C88D/C88D\C88D;
                      DEC A                               ;;C890|C890/C890\C890;
                      BNE +                               ;;C891|C891/C891\C891;
                      LDY.W !SpriteMisc1534,X             ;;C893|C893/C893\C893;
                      LDA.W FireworkSfx3,Y                ;;C896|C896/C896\C896; \ Play sound effect 
                      STA.W !SPCIO0                       ;;C899|C899/C899\C899; / 
                      LDA.W FireworkSfx4,Y                ;;C89C|C89C/C89C\C89C; \ Play sound effect 
                      STA.W !SPCIO3                       ;;C89F|C89F/C89F\C89F; / 
                    + JSR CODE_03C8B1                     ;;C8A2|C8A2/C8A2\C8A2;
                      LDA.B !SpriteTableC2,X              ;;C8A5|C8A5/C8A5\C8A5;
                      CMP.B #$02                          ;;C8A7|C8A7/C8A7\C8A7;
                      BNE +                               ;;C8A9|C8A9/C8A9\C8A9;
                      JSR CODE_03C8B1                     ;;C8AB|C8AB/C8AB\C8AB;
                    + JMP CODE_03C9E9                     ;;C8AE|C8AE/C8AE\C8AE;
                                                          ;;                   ;
CODE_03C8B1:          LDY.W !SpriteMisc1534,X             ;;C8B1|C8B1/C8B1\C8B1;
                      LDA.W !SpriteMisc1570,X             ;;C8B4|C8B4/C8B4\C8B4;
                      CLC                                 ;;C8B7|C8B7/C8B7\C8B7;
                      ADC.W !SpriteMisc151C,X             ;;C8B8|C8B8/C8B8\C8B8;
                      STA.W !SpriteMisc1570,X             ;;C8BB|C8BB/C8BB\C8BB;
                      BCS ADDR_03C8DB                     ;;C8BE|C8BE/C8BE\C8BE;
                      CMP.W DATA_03C889,Y                 ;;C8C0|C8C0/C8C0\C8C0;
                      BCS CODE_03C8E0                     ;;C8C3|C8C3/C8C3\C8C3;
                      LDA.W !SpriteMisc151C,X             ;;C8C5|C8C5/C8C5\C8C5;
                      CMP.B #$02                          ;;C8C8|C8C8/C8C8\C8C8;
                      BCC CODE_03C8D4                     ;;C8CA|C8CA/C8CA\C8CA;
                      SEC                                 ;;C8CC|C8CC/C8CC\C8CC;
                      SBC.B #$01                          ;;C8CD|C8CD/C8CD\C8CD;
                      STA.W !SpriteMisc151C,X             ;;C8CF|C8CF/C8CF\C8CF;
                      BCS +                               ;;C8D2|C8D2/C8D2\C8D2;
CODE_03C8D4:          LDA.B #$01                          ;;C8D4|C8D4/C8D4\C8D4;
                      STA.W !SpriteMisc151C,X             ;;C8D6|C8D6/C8D6\C8D6;
                      BRA +                               ;;C8D9|C8D9/C8D9\C8D9;
                                                          ;;                   ;
ADDR_03C8DB:          LDA.B #$FF                          ;;C8DB|C8DB/C8DB\C8DB;
                      STA.W !SpriteMisc1570,X             ;;C8DD|C8DD/C8DD\C8DD;
CODE_03C8E0:          INC.B !SpriteTableC2,X              ;;C8E0|C8E0/C8E0\C8E0;
                      STZ.B !SpriteYSpeed,X               ;;C8E2|C8E2/C8E2\C8E2; Sprite Y Speed = 0 
                    + LDA.W !SpriteMisc151C,X             ;;C8E4|C8E4/C8E4\C8E4;
                      AND.B #$FF                          ;;C8E7|C8E7/C8E7\C8E7;
                      TAY                                 ;;C8E9|C8E9/C8E9\C8E9;
                      LDA.W DATA_03C8F1,Y                 ;;C8EA|C8EA/C8EA\C8EA;
                      STA.W !SpriteMisc1602,X             ;;C8ED|C8ED/C8ED\C8ED;
                      RTS                                 ;;C8F0|C8F0/C8F0\C8F0; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C8F1:          db $06,$05,$04,$03,$03,$03,$03,$02  ;;C8F1|C8F1/C8F1\C8F1;
                      db $02,$02,$02,$02,$02,$02,$01,$01  ;;C8F9|C8F9/C8F9\C8F9;
                      db $01,$00,$00,$00,$00,$00,$00,$00  ;;C901|C901/C901\C901;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;C909|C909/C909\C909;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;C911|C911/C911\C911;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;C919|C919/C919\C919;
                      db $03,$03,$03,$03,$03,$03,$03,$03  ;;C921|C921/C921\C921;
                      db $03,$03,$02,$02,$02,$02,$02,$02  ;;C929|C929/C929\C929;
                      db $02,$02,$02,$02,$02,$02,$02,$02  ;;C931|C931/C931\C931;
                      db $02,$02,$02,$02,$02,$02,$02,$02  ;;C939|C939/C939\C939;
                                                          ;;                   ;
CODE_03C941:          LDA.B !TrueFrame                    ;;C941|C941/C941\C941;
                      AND.B #$07                          ;;C943|C943/C943\C943;
                      BNE +                               ;;C945|C945/C945\C945;
                      INC.B !SpriteYSpeed,X               ;;C947|C947/C947\C947;
                    + JSL UpdateYPosNoGvtyW               ;;C949|C949/C949\C949;
                      LDA.B #$07                          ;;C94D|C94D/C94D\C94D;
                      LDY.B !SpriteYSpeed,X               ;;C94F|C94F/C94F\C94F;
                      CPY.B #$08                          ;;C951|C951/C951\C951;
                      BNE +                               ;;C953|C953/C953\C953;
                      STZ.W !SpriteStatus,X               ;;C955|C955/C955\C955;
                    + CPY.B #$03                          ;;C958|C958/C958\C958;
                      BCC +                               ;;C95A|C95A/C95A\C95A;
                      INC A                               ;;C95C|C95C/C95C\C95C;
                      CPY.B #$05                          ;;C95D|C95D/C95D\C95D;
                      BCC +                               ;;C95F|C95F/C95F\C95F;
                      INC A                               ;;C961|C961/C961\C961;
                    + STA.W !SpriteMisc1602,X             ;;C962|C962/C962\C962;
                      JSR CODE_03C9E9                     ;;C965|C965/C965\C965;
                      RTS                                 ;;C968|C968/C968\C968; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C969:          db $EC,$8E,$EC,$EC                  ;;C969|C969/C969\C969;
                                                          ;;                   ;
CODE_03C96D:          TXA                                 ;;C96D|C96D/C96D\C96D;
                      EOR.B !TrueFrame                    ;;C96E|C96E/C96E\C96E;
                      AND.B #$03                          ;;C970|C970/C970\C970;
                      BNE +                               ;;C972|C972/C972\C972;
                      JSR GetDrawInfoBnk3                 ;;C974|C974/C974\C974;
                      LDY.B #$00                          ;;C977|C977/C977\C977;
                      LDA.B !_0                           ;;C979|C979/C979\C979;
                      STA.W !OAMTileXPos+$100,Y           ;;C97B|C97B/C97B\C97B;
                      STA.W !OAMTileXPos+$104,Y           ;;C97E|C97E/C97E\C97E;
                      LDA.B !_1                           ;;C981|C981/C981\C981;
                      STA.W !OAMTileYPos+$100,Y           ;;C983|C983/C983\C983;
                      PHX                                 ;;C986|C986/C986\C986;
                      LDA.W !SpriteMisc1534,X             ;;C987|C987/C987\C987;
                      TAX                                 ;;C98A|C98A/C98A\C98A;
                      LDA.B !TrueFrame                    ;;C98B|C98B/C98B\C98B;
                      LSR A                               ;;C98D|C98D/C98D\C98D;
                      LSR A                               ;;C98E|C98E/C98E\C98E;
                      AND.B #$02                          ;;C98F|C98F/C98F\C98F;
                      LSR A                               ;;C991|C991/C991\C991;
                      ADC.W DATA_03C969,X                 ;;C992|C992/C992\C992;
                      STA.W !OAMTileNo+$100,Y             ;;C995|C995/C995\C995;
                      PLX                                 ;;C998|C998/C998\C998;
                      LDA.B !TrueFrame                    ;;C999|C999/C999\C999;
                      ASL A                               ;;C99B|C99B/C99B\C99B;
                      AND.B #$0E                          ;;C99C|C99C/C99C\C99C;
                      STA.B !_2                           ;;C99E|C99E/C99E\C99E;
                      LDA.B !TrueFrame                    ;;C9A0|C9A0/C9A0\C9A0;
                      ASL A                               ;;C9A2|C9A2/C9A2\C9A2;
                      ASL A                               ;;C9A3|C9A3/C9A3\C9A3;
                      ASL A                               ;;C9A4|C9A4/C9A4\C9A4;
                      ASL A                               ;;C9A5|C9A5/C9A5\C9A5;
                      AND.B #$40                          ;;C9A6|C9A6/C9A6\C9A6;
                      ORA.B !_2                           ;;C9A8|C9A8/C9A8\C9A8;
                      ORA.B #$31                          ;;C9AA|C9AA/C9AA\C9AA;
                      STA.W !OAMTileAttr+$100,Y           ;;C9AC|C9AC/C9AC\C9AC;
                      TYA                                 ;;C9AF|C9AF/C9AF\C9AF;
                      LSR A                               ;;C9B0|C9B0/C9B0\C9B0;
                      LSR A                               ;;C9B1|C9B1/C9B1\C9B1;
                      TAY                                 ;;C9B2|C9B2/C9B2\C9B2;
                      LDA.B #$00                          ;;C9B3|C9B3/C9B3\C9B3;
                      STA.W !OAMTileSize+$40,Y            ;;C9B5|C9B5/C9B5\C9B5;
                    + RTS                                 ;;C9B8|C9B8/C9B8\C9B8; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03C9B9:          db $36,$35,$C7,$34,$34,$34,$34,$24  ;;C9B9|C9B9/C9B9\C9B9;
                      db $03,$03,$36,$35,$C7,$34,$34,$24  ;;C9C1|C9C1/C9C1\C9C1;
                      db $24,$24,$24,$03,$36,$35,$C7,$34  ;;C9C9|C9C9/C9C9\C9C9;
                      db $34,$34,$24,$24,$03,$24,$36,$35  ;;C9D1|C9D1/C9D1\C9D1;
                      db $C7,$34,$24,$24,$24,$24,$24,$03  ;;C9D9|C9D9/C9D9\C9D9;
DATA_03C9E1:          db $00,$01,$01,$00,$00,$FF,$FF,$00  ;;C9E1|C9E1/C9E1\C9E1;
                                                          ;;                   ;
CODE_03C9E9:          TXA                                 ;;C9E9|C9E9/C9E9\C9E9;
                      EOR.B !TrueFrame                    ;;C9EA|C9EA/C9EA\C9EA;
                      STA.B !_5                           ;;C9EC|C9EC/C9EC\C9EC;
                      LDA.W !SpriteMisc1570,X             ;;C9EE|C9EE/C9EE\C9EE;
                      STA.B !_6                           ;;C9F1|C9F1/C9F1\C9F1;
                      LDA.W !SpriteMisc1602,X             ;;C9F3|C9F3/C9F3\C9F3;
                      STA.B !_7                           ;;C9F6|C9F6/C9F6\C9F6;
                      LDA.B !SpriteXPosLow,X              ;;C9F8|C9F8/C9F8\C9F8;
                      STA.B !_8                           ;;C9FA|C9FA/C9FA\C9FA;
                      LDA.B !SpriteYPosLow,X              ;;C9FC|C9FC/C9FC\C9FC;
                      SEC                                 ;;C9FE|C9FE/C9FE\C9FE;
                      SBC.B !Layer1YPos                   ;;C9FF|C9FF/C9FF\C9FF;
                      STA.B !_9                           ;;CA01|CA01/CA01\CA01;
                      LDA.W !SpriteMisc1534,X             ;;CA03|CA03/CA03\CA03;
                      STA.B !_A                           ;;CA06|CA06/CA06\CA06;
                      PHX                                 ;;CA08|CA08/CA08\CA08;
                      LDX.B #$3F                          ;;CA09|CA09/CA09\CA09;
                      LDY.B #$00                          ;;CA0B|CA0B/CA0B\CA0B;
CODE_03CA0D:          STX.B !_4                           ;;CA0D|CA0D/CA0D\CA0D;
                      LDA.B !_A                           ;;CA0F|CA0F/CA0F\CA0F;
                      CMP.B #$03                          ;;CA11|CA11/CA11\CA11;
                      LDA.W DATA_03C626,X                 ;;CA13|CA13/CA13\CA13;
                      BCC +                               ;;CA16|CA16/CA16\CA16;
                      LDA.W DATA_03C6CE,X                 ;;CA18|CA18/CA18\CA18;
                    + SEC                                 ;;CA1B|CA1B/CA1B\CA1B;
                      SBC.B #$40                          ;;CA1C|CA1C/CA1C\CA1C;
                      STA.B !_0                           ;;CA1E|CA1E/CA1E\CA1E;
                      PHY                                 ;;CA20|CA20/CA20\CA20;
                      LDA.B !_A                           ;;CA21|CA21/CA21\CA21;
                      CMP.B #$03                          ;;CA23|CA23/CA23\CA23;
                      LDA.W DATA_03C67A,X                 ;;CA25|CA25/CA25\CA25;
                      BCC +                               ;;CA28|CA28/CA28\CA28;
                      LDA.W DATA_03C722,X                 ;;CA2A|CA2A/CA2A\CA2A;
                    + SEC                                 ;;CA2D|CA2D/CA2D\CA2D;
                      SBC.B #$50                          ;;CA2E|CA2E/CA2E\CA2E;
                      STA.B !_1                           ;;CA30|CA30/CA30\CA30;
                      LDA.B !_0                           ;;CA32|CA32/CA32\CA32;
                      BPL +                               ;;CA34|CA34/CA34\CA34;
                      EOR.B #$FF                          ;;CA36|CA36/CA36\CA36;
                      INC A                               ;;CA38|CA38/CA38\CA38;
                    + STA.W !HW_WRMPYA                    ;;CA39|CA39/CA39\CA39; Multiplicand A
                      LDA.B !_6                           ;;CA3C|CA3C/CA3C\CA3C;
                      STA.W !HW_WRMPYB                    ;;CA3E|CA3E/CA3E\CA3E; Multplier B
                      NOP                                 ;;CA41|CA41/CA41\CA41;
                      NOP                                 ;;CA42|CA42/CA42\CA42;
                      NOP                                 ;;CA43|CA43/CA43\CA43;
                      NOP                                 ;;CA44|CA44/CA44\CA44;
                      LDA.W !HW_RDMPY+1                   ;;CA45|CA45/CA45\CA45; Product/Remainder Result (High Byte)
                      LDY.B !_0                           ;;CA48|CA48/CA48\CA48;
                      BPL +                               ;;CA4A|CA4A/CA4A\CA4A;
                      EOR.B #$FF                          ;;CA4C|CA4C/CA4C\CA4C;
                      INC A                               ;;CA4E|CA4E/CA4E\CA4E;
                    + STA.B !_2                           ;;CA4F|CA4F/CA4F\CA4F;
                      LDA.B !_1                           ;;CA51|CA51/CA51\CA51;
                      BPL +                               ;;CA53|CA53/CA53\CA53;
                      EOR.B #$FF                          ;;CA55|CA55/CA55\CA55;
                      INC A                               ;;CA57|CA57/CA57\CA57;
                    + STA.W !HW_WRMPYA                    ;;CA58|CA58/CA58\CA58; Multiplicand A
                      LDA.B !_6                           ;;CA5B|CA5B/CA5B\CA5B;
                      STA.W !HW_WRMPYB                    ;;CA5D|CA5D/CA5D\CA5D; Multplier B
                      NOP                                 ;;CA60|CA60/CA60\CA60;
                      NOP                                 ;;CA61|CA61/CA61\CA61;
                      NOP                                 ;;CA62|CA62/CA62\CA62;
                      NOP                                 ;;CA63|CA63/CA63\CA63;
                      LDA.W !HW_RDMPY+1                   ;;CA64|CA64/CA64\CA64; Product/Remainder Result (High Byte)
                      LDY.B !_1                           ;;CA67|CA67/CA67\CA67;
                      BPL +                               ;;CA69|CA69/CA69\CA69;
                      EOR.B #$FF                          ;;CA6B|CA6B/CA6B\CA6B;
                      INC A                               ;;CA6D|CA6D/CA6D\CA6D;
                    + STA.B !_3                           ;;CA6E|CA6E/CA6E\CA6E;
                      LDY.B #$00                          ;;CA70|CA70/CA70\CA70;
                      LDA.B !_7                           ;;CA72|CA72/CA72\CA72;
                      CMP.B #$06                          ;;CA74|CA74/CA74\CA74;
                      BCC +                               ;;CA76|CA76/CA76\CA76;
                      LDA.B !_5                           ;;CA78|CA78/CA78\CA78;
                      CLC                                 ;;CA7A|CA7A/CA7A\CA7A;
                      ADC.B !_4                           ;;CA7B|CA7B/CA7B\CA7B;
                      LSR A                               ;;CA7D|CA7D/CA7D\CA7D;
                      LSR A                               ;;CA7E|CA7E/CA7E\CA7E;
                      AND.B #$07                          ;;CA7F|CA7F/CA7F\CA7F;
                      TAY                                 ;;CA81|CA81/CA81\CA81;
                    + LDA.W DATA_03C9E1,Y                 ;;CA82|CA82/CA82\CA82;
                      PLY                                 ;;CA85|CA85/CA85\CA85;
                      CLC                                 ;;CA86|CA86/CA86\CA86;
                      ADC.B !_2                           ;;CA87|CA87/CA87\CA87;
                      CLC                                 ;;CA89|CA89/CA89\CA89;
                      ADC.B !_8                           ;;CA8A|CA8A/CA8A\CA8A;
                      STA.W !OAMTileXPos,Y                ;;CA8C|CA8C/CA8C\CA8C;
                      LDA.B !_3                           ;;CA8F|CA8F/CA8F\CA8F;
                      CLC                                 ;;CA91|CA91/CA91\CA91;
                      ADC.B !_9                           ;;CA92|CA92/CA92\CA92;
                      STA.W !OAMTileYPos,Y                ;;CA94|CA94/CA94\CA94;
                      PHX                                 ;;CA97|CA97/CA97\CA97;
                      LDA.B !_5                           ;;CA98|CA98/CA98\CA98;
                      AND.B #$03                          ;;CA9A|CA9A/CA9A\CA9A;
                      STA.B !_F                           ;;CA9C|CA9C/CA9C\CA9C;
                      ASL A                               ;;CA9E|CA9E/CA9E\CA9E;
                      ASL A                               ;;CA9F|CA9F/CA9F\CA9F;
                      ASL A                               ;;CAA0|CAA0/CAA0\CAA0;
                      ADC.B !_F                           ;;CAA1|CAA1/CAA1\CAA1;
                      ADC.B !_F                           ;;CAA3|CAA3/CAA3\CAA3;
                      ADC.B !_7                           ;;CAA5|CAA5/CAA5\CAA5;
                      TAX                                 ;;CAA7|CAA7/CAA7\CAA7;
                      LDA.W DATA_03C9B9,X                 ;;CAA8|CAA8/CAA8\CAA8;
                      STA.W !OAMTileNo,Y                  ;;CAAB|CAAB/CAAB\CAAB;
                      PLX                                 ;;CAAE|CAAE/CAAE\CAAE;
                      LDA.B !_5                           ;;CAAF|CAAF/CAAF\CAAF;
                      LSR A                               ;;CAB1|CAB1/CAB1\CAB1;
                      NOP                                 ;;CAB2|CAB2/CAB2\CAB2;
                      NOP                                 ;;CAB3|CAB3/CAB3\CAB3;
                      PHX                                 ;;CAB4|CAB4/CAB4\CAB4;
                      LDX.B !_A                           ;;CAB5|CAB5/CAB5\CAB5;
                      CPX.B #$03                          ;;CAB7|CAB7/CAB7\CAB7;
                      BEQ +                               ;;CAB9|CAB9/CAB9\CAB9;
                      EOR.B !_4                           ;;CABB|CABB/CABB\CABB;
                    + AND.B #$0E                          ;;CABD|CABD/CABD\CABD;
                      ORA.B #$31                          ;;CABF|CABF/CABF\CABF;
                      STA.W !OAMTileAttr,Y                ;;CAC1|CAC1/CAC1\CAC1;
                      PLX                                 ;;CAC4|CAC4/CAC4\CAC4;
                      PHY                                 ;;CAC5|CAC5/CAC5\CAC5;
                      TYA                                 ;;CAC6|CAC6/CAC6\CAC6;
                      LSR A                               ;;CAC7|CAC7/CAC7\CAC7;
                      LSR A                               ;;CAC8|CAC8/CAC8\CAC8;
                      TAY                                 ;;CAC9|CAC9/CAC9\CAC9;
                      LDA.B #$00                          ;;CACA|CACA/CACA\CACA;
                      STA.W !OAMTileSize,Y                ;;CACC|CACC/CACC\CACC;
                      PLY                                 ;;CACF|CACF/CACF\CACF;
                      INY                                 ;;CAD0|CAD0/CAD0\CAD0;
                      INY                                 ;;CAD1|CAD1/CAD1\CAD1;
                      INY                                 ;;CAD2|CAD2/CAD2\CAD2;
                      INY                                 ;;CAD3|CAD3/CAD3\CAD3;
                      DEX                                 ;;CAD4|CAD4/CAD4\CAD4;
                      BMI +                               ;;CAD5|CAD5/CAD5\CAD5;
                      JMP CODE_03CA0D                     ;;CAD7|CAD7/CAD7\CAD7;
                                                          ;;                   ;
                    + LDX.B #$53                          ;;CADA|CADA/CADA\CADA;
CODE_03CADC:          STX.B !_4                           ;;CADC|CADC/CADC\CADC;
                      LDA.B !_A                           ;;CADE|CADE/CADE\CADE;
                      CMP.B #$03                          ;;CAE0|CAE0/CAE0\CAE0;
                      LDA.W DATA_03C626,X                 ;;CAE2|CAE2/CAE2\CAE2;
                      BCC +                               ;;CAE5|CAE5/CAE5\CAE5;
                      LDA.W DATA_03C6CE,X                 ;;CAE7|CAE7/CAE7\CAE7;
                    + SEC                                 ;;CAEA|CAEA/CAEA\CAEA;
                      SBC.B #$40                          ;;CAEB|CAEB/CAEB\CAEB;
                      STA.B !_0                           ;;CAED|CAED/CAED\CAED;
                      LDA.B !_A                           ;;CAEF|CAEF/CAEF\CAEF;
                      CMP.B #$03                          ;;CAF1|CAF1/CAF1\CAF1;
                      LDA.W DATA_03C67A,X                 ;;CAF3|CAF3/CAF3\CAF3;
                      BCC +                               ;;CAF6|CAF6/CAF6\CAF6;
                      LDA.W DATA_03C722,X                 ;;CAF8|CAF8/CAF8\CAF8;
                    + SEC                                 ;;CAFB|CAFB/CAFB\CAFB;
                      SBC.B #$50                          ;;CAFC|CAFC/CAFC\CAFC;
                      STA.B !_1                           ;;CAFE|CAFE/CAFE\CAFE;
                      PHY                                 ;;CB00|CB00/CB00\CB00;
                      LDA.B !_0                           ;;CB01|CB01/CB01\CB01;
                      BPL +                               ;;CB03|CB03/CB03\CB03;
                      EOR.B #$FF                          ;;CB05|CB05/CB05\CB05;
                      INC A                               ;;CB07|CB07/CB07\CB07;
                    + STA.W !HW_WRMPYA                    ;;CB08|CB08/CB08\CB08; Multiplicand A
                      LDA.B !_6                           ;;CB0B|CB0B/CB0B\CB0B;
                      STA.W !HW_WRMPYB                    ;;CB0D|CB0D/CB0D\CB0D; Multplier B
                      NOP                                 ;;CB10|CB10/CB10\CB10;
                      NOP                                 ;;CB11|CB11/CB11\CB11;
                      NOP                                 ;;CB12|CB12/CB12\CB12;
                      NOP                                 ;;CB13|CB13/CB13\CB13;
                      LDA.W !HW_RDMPY+1                   ;;CB14|CB14/CB14\CB14; Product/Remainder Result (High Byte)
                      LDY.B !_0                           ;;CB17|CB17/CB17\CB17;
                      BPL +                               ;;CB19|CB19/CB19\CB19;
                      EOR.B #$FF                          ;;CB1B|CB1B/CB1B\CB1B;
                      INC A                               ;;CB1D|CB1D/CB1D\CB1D;
                    + STA.B !_2                           ;;CB1E|CB1E/CB1E\CB1E;
                      LDA.B !_1                           ;;CB20|CB20/CB20\CB20;
                      BPL +                               ;;CB22|CB22/CB22\CB22;
                      EOR.B #$FF                          ;;CB24|CB24/CB24\CB24;
                      INC A                               ;;CB26|CB26/CB26\CB26;
                    + STA.W !HW_WRMPYA                    ;;CB27|CB27/CB27\CB27; Multiplicand A
                      LDA.B !_6                           ;;CB2A|CB2A/CB2A\CB2A;
                      STA.W !HW_WRMPYB                    ;;CB2C|CB2C/CB2C\CB2C; Multplier B
                      NOP                                 ;;CB2F|CB2F/CB2F\CB2F;
                      NOP                                 ;;CB30|CB30/CB30\CB30;
                      NOP                                 ;;CB31|CB31/CB31\CB31;
                      NOP                                 ;;CB32|CB32/CB32\CB32;
                      LDA.W !HW_RDMPY+1                   ;;CB33|CB33/CB33\CB33; Product/Remainder Result (High Byte)
                      LDY.B !_1                           ;;CB36|CB36/CB36\CB36;
                      BPL +                               ;;CB38|CB38/CB38\CB38;
                      EOR.B #$FF                          ;;CB3A|CB3A/CB3A\CB3A;
                      INC A                               ;;CB3C|CB3C/CB3C\CB3C;
                    + STA.B !_3                           ;;CB3D|CB3D/CB3D\CB3D;
                      LDY.B #$00                          ;;CB3F|CB3F/CB3F\CB3F;
                      LDA.B !_7                           ;;CB41|CB41/CB41\CB41;
                      CMP.B #$06                          ;;CB43|CB43/CB43\CB43;
                      BCC +                               ;;CB45|CB45/CB45\CB45;
                      LDA.B !_5                           ;;CB47|CB47/CB47\CB47;
                      CLC                                 ;;CB49|CB49/CB49\CB49;
                      ADC.B !_4                           ;;CB4A|CB4A/CB4A\CB4A;
                      LSR A                               ;;CB4C|CB4C/CB4C\CB4C;
                      LSR A                               ;;CB4D|CB4D/CB4D\CB4D;
                      AND.B #$07                          ;;CB4E|CB4E/CB4E\CB4E;
                      TAY                                 ;;CB50|CB50/CB50\CB50;
                    + LDA.W DATA_03C9E1,Y                 ;;CB51|CB51/CB51\CB51;
                      PLY                                 ;;CB54|CB54/CB54\CB54;
                      CLC                                 ;;CB55|CB55/CB55\CB55;
                      ADC.B !_2                           ;;CB56|CB56/CB56\CB56;
                      CLC                                 ;;CB58|CB58/CB58\CB58;
                      ADC.B !_8                           ;;CB59|CB59/CB59\CB59;
                      STA.W !OAMTileXPos+$100,Y           ;;CB5B|CB5B/CB5B\CB5B;
                      LDA.B !_3                           ;;CB5E|CB5E/CB5E\CB5E;
                      CLC                                 ;;CB60|CB60/CB60\CB60;
                      ADC.B !_9                           ;;CB61|CB61/CB61\CB61;
                      STA.W !OAMTileYPos+$100,Y           ;;CB63|CB63/CB63\CB63;
                      PHX                                 ;;CB66|CB66/CB66\CB66;
                      LDA.B !_5                           ;;CB67|CB67/CB67\CB67;
                      AND.B #$03                          ;;CB69|CB69/CB69\CB69;
                      STA.B !_F                           ;;CB6B|CB6B/CB6B\CB6B;
                      ASL A                               ;;CB6D|CB6D/CB6D\CB6D;
                      ASL A                               ;;CB6E|CB6E/CB6E\CB6E;
                      ASL A                               ;;CB6F|CB6F/CB6F\CB6F;
                      ADC.B !_F                           ;;CB70|CB70/CB70\CB70;
                      ADC.B !_F                           ;;CB72|CB72/CB72\CB72;
                      ADC.B !_7                           ;;CB74|CB74/CB74\CB74;
                      TAX                                 ;;CB76|CB76/CB76\CB76;
                      LDA.W DATA_03C9B9,X                 ;;CB77|CB77/CB77\CB77;
                      STA.W !OAMTileNo+$100,Y             ;;CB7A|CB7A/CB7A\CB7A;
                      PLX                                 ;;CB7D|CB7D/CB7D\CB7D;
                      LDA.B !_5                           ;;CB7E|CB7E/CB7E\CB7E;
                      LSR A                               ;;CB80|CB80/CB80\CB80;
                      NOP                                 ;;CB81|CB81/CB81\CB81;
                      NOP                                 ;;CB82|CB82/CB82\CB82;
                      PHX                                 ;;CB83|CB83/CB83\CB83;
                      LDX.B !_A                           ;;CB84|CB84/CB84\CB84;
                      CPX.B #$03                          ;;CB86|CB86/CB86\CB86;
                      BEQ +                               ;;CB88|CB88/CB88\CB88;
                      EOR.B !_4                           ;;CB8A|CB8A/CB8A\CB8A;
                    + AND.B #$0E                          ;;CB8C|CB8C/CB8C\CB8C;
                      ORA.B #$31                          ;;CB8E|CB8E/CB8E\CB8E;
                      STA.W !OAMTileAttr+$100,Y           ;;CB90|CB90/CB90\CB90;
                      PLX                                 ;;CB93|CB93/CB93\CB93;
                      PHY                                 ;;CB94|CB94/CB94\CB94;
                      TYA                                 ;;CB95|CB95/CB95\CB95;
                      LSR A                               ;;CB96|CB96/CB96\CB96;
                      LSR A                               ;;CB97|CB97/CB97\CB97;
                      TAY                                 ;;CB98|CB98/CB98\CB98;
                      LDA.B #$00                          ;;CB99|CB99/CB99\CB99;
                      STA.W !OAMTileSize+$40,Y            ;;CB9B|CB9B/CB9B\CB9B;
                      PLY                                 ;;CB9E|CB9E/CB9E\CB9E;
                      INY                                 ;;CB9F|CB9F/CB9F\CB9F;
                      INY                                 ;;CBA0|CBA0/CBA0\CBA0;
                      INY                                 ;;CBA1|CBA1/CBA1\CBA1;
                      INY                                 ;;CBA2|CBA2/CBA2\CBA2;
                      DEX                                 ;;CBA3|CBA3/CBA3\CBA3;
                      CPX.B #$3F                          ;;CBA4|CBA4/CBA4\CBA4;
                      BEQ +                               ;;CBA6|CBA6/CBA6\CBA6;
                      JMP CODE_03CADC                     ;;CBA8|CBA8/CBA8\CBA8;
                                                          ;;                   ;
                    + PLX                                 ;;CBAB|CBAB/CBAB\CBAB;
                      RTS                                 ;;CBAC|CBAC/CBAC\CBAC; Return 
                                                          ;;                   ;
                                                          ;;                   ;
ChuckSprGenDispX:     db $14,$EC                          ;;CBAD|CBAD/CBAD\CBAD;
                                                          ;;                   ;
ChuckSprGenSpeedHi:   db $00,$FF                          ;;CBAF|CBAF/CBAF\CBAF;
                                                          ;;                   ;
ChuckSprGenSpeedLo:   db $18,$E8                          ;;CBB1|CBB1/CBB1\CBB1;
                                                          ;;                   ;
CODE_03CBB3:          JSL FindFreeSprSlot                 ;;CBB3|CBB3/CBB3\CBB3; \ Return if no free slots 
                      BMI +                               ;;CBB7|CBB7/CBB7\CBB7; / 
                      LDA.B #$1B                          ;;CBB9|CBB9/CBB9\CBB9; \ Sprite = Football 
                      STA.W !SpriteNumber,Y               ;;CBBB|CBBB/CBBB\CBBB; / 
                      PHX                                 ;;CBBE|CBBE/CBBE\CBBE;
                      TYX                                 ;;CBBF|CBBF/CBBF\CBBF;
                      JSL InitSpriteTables                ;;CBC0|CBC0/CBC0\CBC0;
                      PLX                                 ;;CBC4|CBC4/CBC4\CBC4;
                      LDA.B #$08                          ;;CBC5|CBC5/CBC5\CBC5; \ Sprite status = Normal 
                      STA.W !SpriteStatus,Y               ;;CBC7|CBC7/CBC7\CBC7; / 
                      LDA.B !SpriteYPosLow,X              ;;CBCA|CBCA/CBCA\CBCA;
                      STA.W !SpriteYPosLow,Y              ;;CBCC|CBCC/CBCC\CBCC;
                      LDA.W !SpriteXPosHigh,X             ;;CBCF|CBCF/CBCF\CBCF;
                      STA.W !SpriteXPosHigh,Y             ;;CBD2|CBD2/CBD2\CBD2;
                      LDA.B !SpriteXPosLow,X              ;;CBD5|CBD5/CBD5\CBD5;
                      STA.B !_1                           ;;CBD7|CBD7/CBD7\CBD7;
                      LDA.W !SpriteYPosHigh,X             ;;CBD9|CBD9/CBD9\CBD9;
                      STA.B !_0                           ;;CBDC|CBDC/CBDC\CBDC;
                      PHX                                 ;;CBDE|CBDE/CBDE\CBDE;
                      LDA.W !SpriteMisc157C,X             ;;CBDF|CBDF/CBDF\CBDF;
                      TAX                                 ;;CBE2|CBE2/CBE2\CBE2;
                      LDA.B !_1                           ;;CBE3|CBE3/CBE3\CBE3;
                      CLC                                 ;;CBE5|CBE5/CBE5\CBE5;
                      ADC.L ChuckSprGenDispX,X            ;;CBE6|CBE6/CBE6\CBE6;
                      STA.W !SpriteXPosLow,Y              ;;CBEA|CBEA/CBEA\CBEA;
                      LDA.B !_0                           ;;CBED|CBED/CBED\CBED;
                      ADC.L ChuckSprGenSpeedHi,X          ;;CBEF|CBEF/CBEF\CBEF;
                      STA.W !SpriteYPosHigh,Y             ;;CBF3|CBF3/CBF3\CBF3;
                      LDA.L ChuckSprGenSpeedLo,X          ;;CBF6|CBF6/CBF6\CBF6;
                      STA.W !SpriteXSpeed,Y               ;;CBFA|CBFA/CBFA\CBFA;
                      LDA.B #$E0                          ;;CBFD|CBFD/CBFD\CBFD;
                      STA.W !SpriteYSpeed,Y               ;;CBFF|CBFF/CBFF\CBFF;
                      LDA.B #$10                          ;;CC02|CC02/CC02\CC02;
                      STA.W !SpriteMisc1540,Y             ;;CC04|CC04/CC04\CC04;
                      PLX                                 ;;CC07|CC07/CC07\CC07;
                    + RTL                                 ;;CC08|CC08/CC08\CC08; Return 
                                                          ;;                   ;
CODE_03CC09:          PHB                                 ;;CC09|CC09/CC09\CC09; Wrapper 
                      PHK                                 ;;CC0A|CC0A/CC0A\CC0A;
                      PLB                                 ;;CC0B|CC0B/CC0B\CC0B;
                      STZ.W !SpriteTweakerB,X             ;;CC0C|CC0C/CC0C\CC0C;
                      JSR CODE_03CC14                     ;;CC0F|CC0F/CC0F\CC0F;
                      PLB                                 ;;CC12|CC12/CC12\CC12;
                      RTL                                 ;;CC13|CC13/CC13\CC13; Return 
                                                          ;;                   ;
CODE_03CC14:          JSR CODE_03D484                     ;;CC14|CC14/CC14\CC14;
                      LDA.W !SpriteStatus,X               ;;CC17|CC17/CC17\CC17;
                      CMP.B #$08                          ;;CC1A|CC1A/CC1A\CC1A;
                      BNE +                               ;;CC1C|CC1C/CC1C\CC1C;
                      LDA.B !SpriteLock                   ;;CC1E|CC1E/CC1E\CC1E;
                      BNE +                               ;;CC20|CC20/CC20\CC20;
                      LDA.W !SpriteMisc151C,X             ;;CC22|CC22/CC22\CC22;
                      JSL ExecutePtr                      ;;CC25|CC25/CC25\CC25;
                                                          ;;                   ;
                      dw CODE_03CC8A                      ;;CC29|CC29/CC29\CC29;
                      dw CODE_03CD21                      ;;CC2B|CC2B/CC2B\CC2B;
                      dw CODE_03CDC7                      ;;CC2D|CC2D/CC2D\CC2D;
                      dw CODE_03CDEF                      ;;CC2F|CC2F/CC2F\CC2F;
                      dw CODE_03CE0E                      ;;CC31|CC31/CC31\CC31;
                      dw CODE_03CE5A                      ;;CC33|CC33/CC33\CC33;
                      dw CODE_03CE89                      ;;CC35|CC35/CC35\CC35;
                                                          ;;                   ;
                    + RTS                                 ;;CC37|CC37/CC37\CC37; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03CC38:          db $18,$38,$58,$78,$98,$B8,$D8,$78  ;;CC38|CC38/CC38\CC38;
DATA_03CC40:          db $40,$50,$50,$40,$30,$40,$50,$40  ;;CC40|CC40/CC40\CC40;
DATA_03CC48:          db $50,$4A,$50,$4A,$4A,$40,$4A,$48  ;;CC48|CC48/CC48\CC48;
                      db $4A                              ;;CC50|CC50/CC50\CC50;
                                                          ;;                   ;
DATA_03CC51:          db $02,$04,$06,$08,$0B,$0C,$0E,$10  ;;CC51|CC51/CC51\CC51;
                      db $13                              ;;CC59|CC59/CC59\CC59;
                                                          ;;                   ;
DATA_03CC5A:          db $00,$01,$02,$03,$04,$05,$06,$00  ;;CC5A|CC5A/CC5A\CC5A;
                      db $01,$02,$03,$04,$05,$06,$00,$01  ;;CC62|CC62/CC62\CC62;
                      db $02,$03,$04,$05,$06,$00,$01,$02  ;;CC6A|CC6A/CC6A\CC6A;
                      db $03,$04,$05,$06,$00,$01,$02,$03  ;;CC72|CC72/CC72\CC72;
                      db $04,$05,$06,$00,$01,$02,$03,$04  ;;CC7A|CC7A/CC7A\CC7A;
                      db $05,$06,$00,$01,$02,$03,$04,$05  ;;CC82|CC82/CC82\CC82;
                                                          ;;                   ;
CODE_03CC8A:          LDA.W !SpriteMisc1540,X             ;;CC8A|CC8A/CC8A\CC8A;
                      BNE Return03CCDF                    ;;CC8D|CC8D/CC8D\CC8D;
                      LDA.W !SpriteMisc1570,X             ;;CC8F|CC8F/CC8F\CC8F;
                      BNE +                               ;;CC92|CC92/CC92\CC92;
                      JSL GetRand                         ;;CC94|CC94/CC94\CC94;
                      AND.B #$0F                          ;;CC98|CC98/CC98\CC98;
                      STA.W !SpriteMisc160E,X             ;;CC9A|CC9A/CC9A\CC9A;
                    + LDA.W !SpriteMisc160E,X             ;;CC9D|CC9D/CC9D\CC9D;
                      ORA.W !SpriteMisc1570,X             ;;CCA0|CCA0/CCA0\CCA0;
                      TAY                                 ;;CCA3|CCA3/CCA3\CCA3;
                      LDA.W DATA_03CC5A,Y                 ;;CCA4|CCA4/CCA4\CCA4;
                      TAY                                 ;;CCA7|CCA7/CCA7\CCA7;
                      LDA.W DATA_03CC38,Y                 ;;CCA8|CCA8/CCA8\CCA8;
                      STA.B !SpriteXPosLow,X              ;;CCAB|CCAB/CCAB\CCAB;
                      LDA.B !SpriteTableC2,X              ;;CCAD|CCAD/CCAD\CCAD;
                      CMP.B #$06                          ;;CCAF|CCAF/CCAF\CCAF;
                      LDA.W DATA_03CC40,Y                 ;;CCB1|CCB1/CCB1\CCB1;
                      BCC +                               ;;CCB4|CCB4/CCB4\CCB4;
                      LDA.B #$50                          ;;CCB6|CCB6/CCB6\CCB6;
                    + STA.B !SpriteYPosLow,X              ;;CCB8|CCB8/CCB8\CCB8;
                      LDA.B #$08                          ;;CCBA|CCBA/CCBA\CCBA;
                      LDY.W !SpriteMisc1570,X             ;;CCBC|CCBC/CCBC\CCBC;
                      BNE +                               ;;CCBF|CCBF/CCBF\CCBF;
                      JSR CODE_03CCE2                     ;;CCC1|CCC1/CCC1\CCC1;
                      JSL GetRand                         ;;CCC4|CCC4/CCC4\CCC4;
                      LSR A                               ;;CCC8|CCC8/CCC8\CCC8;
                      LSR A                               ;;CCC9|CCC9/CCC9\CCC9;
                      AND.B #$07                          ;;CCCA|CCCA/CCCA\CCCA;
                    + STA.W !SpriteMisc1528,X             ;;CCCC|CCCC/CCCC\CCCC;
                      TAY                                 ;;CCCF|CCCF/CCCF\CCCF;
                      LDA.W DATA_03CC48,Y                 ;;CCD0|CCD0/CCD0\CCD0;
                      STA.W !SpriteMisc1540,X             ;;CCD3|CCD3/CCD3\CCD3;
                      INC.W !SpriteMisc151C,X             ;;CCD6|CCD6/CCD6\CCD6;
                      LDA.W DATA_03CC51,Y                 ;;CCD9|CCD9/CCD9\CCD9;
                      STA.W !SpriteMisc1602,X             ;;CCDC|CCDC/CCDC\CCDC;
Return03CCDF:         RTS                                 ;;CCDF|CCDF/CCDF\CCDF; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03CCE0:          db $10,$20                          ;;CCE0|CCE0/CCE0\CCE0;
                                                          ;;                   ;
CODE_03CCE2:          LDY.B #$01                          ;;CCE2|CCE2/CCE2\CCE2;
                      JSR CODE_03CCE8                     ;;CCE4|CCE4/CCE4\CCE4;
                      DEY                                 ;;CCE7|CCE7/CCE7\CCE7;
CODE_03CCE8:          LDA.B #$08                          ;;CCE8|CCE8/CCE8\CCE8; \ Sprite status = Normal 
                      STA.W !SpriteStatus,Y               ;;CCEA|CCEA/CCEA\CCEA; / 
                      LDA.B #$29                          ;;CCED|CCED/CCED\CCED;
                      STA.W !SpriteNumber,Y               ;;CCEF|CCEF/CCEF\CCEF;
                      PHX                                 ;;CCF2|CCF2/CCF2\CCF2;
                      TYX                                 ;;CCF3|CCF3/CCF3\CCF3;
                      JSL InitSpriteTables                ;;CCF4|CCF4/CCF4\CCF4;
                      PLX                                 ;;CCF8|CCF8/CCF8\CCF8;
                      LDA.W DATA_03CCE0,Y                 ;;CCF9|CCF9/CCF9\CCF9;
                      STA.W !SpriteMisc1570,Y             ;;CCFC|CCFC/CCFC\CCFC;
                      LDA.B !SpriteTableC2,X              ;;CCFF|CCFF/CCFF\CCFF;
                      STA.W !SpriteTableC2,Y              ;;CD01|CD01/CD01\CD01;
                      LDA.W !SpriteMisc160E,X             ;;CD04|CD04/CD04\CD04;
                      STA.W !SpriteMisc160E,Y             ;;CD07|CD07/CD07\CD07;
                      LDA.B !SpriteXPosLow,X              ;;CD0A|CD0A/CD0A\CD0A;
                      STA.W !SpriteXPosLow,Y              ;;CD0C|CD0C/CD0C\CD0C;
                      LDA.W !SpriteYPosHigh,X             ;;CD0F|CD0F/CD0F\CD0F;
                      STA.W !SpriteYPosHigh,Y             ;;CD12|CD12/CD12\CD12;
                      LDA.B !SpriteYPosLow,X              ;;CD15|CD15/CD15\CD15;
                      STA.W !SpriteYPosLow,Y              ;;CD17|CD17/CD17\CD17;
                      LDA.W !SpriteXPosHigh,X             ;;CD1A|CD1A/CD1A\CD1A;
                      STA.W !SpriteXPosHigh,Y             ;;CD1D|CD1D/CD1D\CD1D;
                      RTS                                 ;;CD20|CD20/CD20\CD20; Return 
                                                          ;;                   ;
CODE_03CD21:          LDA.W !SpriteMisc1540,X             ;;CD21|CD21/CD21\CD21;
                      BNE +                               ;;CD24|CD24/CD24\CD24;
                      LDA.B #$40                          ;;CD26|CD26/CD26\CD26;
                      STA.W !SpriteMisc1540,X             ;;CD28|CD28/CD28\CD28;
                      INC.W !SpriteMisc151C,X             ;;CD2B|CD2B/CD2B\CD2B;
                    + LDA.B #$F8                          ;;CD2E|CD2E/CD2E\CD2E;
                      STA.B !SpriteYSpeed,X               ;;CD30|CD30/CD30\CD30;
                      JSL UpdateYPosNoGvtyW               ;;CD32|CD32/CD32\CD32;
                      RTS                                 ;;CD36|CD36/CD36\CD36; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03CD37:          db $02,$02,$02,$02,$03,$03,$03,$03  ;;CD37|CD37/CD37\CD37;
                      db $03,$03,$03,$03,$02,$02,$02,$02  ;;CD3F|CD3F/CD3F\CD3F;
                      db $04,$04,$04,$04,$05,$05,$04,$05  ;;CD47|CD47/CD47\CD47;
                      db $05,$04,$05,$05,$04,$04,$04,$04  ;;CD4F|CD4F/CD4F\CD4F;
                      db $06,$06,$06,$06,$07,$07,$07,$07  ;;CD57|CD57/CD57\CD57;
                      db $07,$07,$07,$07,$06,$06,$06,$06  ;;CD5F|CD5F/CD5F\CD5F;
                      db $08,$08,$08,$08,$08,$09,$09,$08  ;;CD67|CD67/CD67\CD67;
                      db $08,$09,$09,$08,$08,$08,$08,$08  ;;CD6F|CD6F/CD6F\CD6F;
                      db $0B,$0B,$0B,$0B,$0B,$0A,$0B,$0A  ;;CD77|CD77/CD77\CD77;
                      db $0B,$0A,$0B,$0A,$0B,$0B,$0B,$0B  ;;CD7F|CD7F/CD7F\CD7F;
                      db $0C,$0C,$0C,$0C,$0D,$0C,$0D,$0C  ;;CD87|CD87/CD87\CD87;
                      db $0D,$0C,$0D,$0C,$0D,$0D,$0D,$0D  ;;CD8F|CD8F/CD8F\CD8F;
                      db $0E,$0E,$0E,$0E,$0E,$0F,$0E,$0F  ;;CD97|CD97/CD97\CD97;
                      db $0E,$0F,$0E,$0F,$0E,$0E,$0E,$0E  ;;CD9F|CD9F/CD9F\CD9F;
                      db $10,$10,$10,$10,$11,$12,$11,$10  ;;CDA7|CDA7/CDA7\CDA7;
                      db $11,$12,$11,$10,$11,$11,$11,$11  ;;CDAF|CDAF/CDAF\CDAF;
                      db $13,$13,$13,$13,$13,$13,$13,$13  ;;CDB7|CDB7/CDB7\CDB7;
                      db $13,$13,$13,$13,$13,$13,$13,$13  ;;CDBF|CDBF/CDBF\CDBF;
                                                          ;;                   ;
CODE_03CDC7:          JSR CODE_03CEA7                     ;;CDC7|CDC7/CDC7\CDC7;
                      LDA.W !SpriteMisc1540,X             ;;CDCA|CDCA/CDCA\CDCA;
                      BNE +                               ;;CDCD|CDCD/CDCD\CDCD;
CODE_03CDCF:          LDA.B #$24                          ;;CDCF|CDCF/CDCF\CDCF;
                      STA.W !SpriteMisc1540,X             ;;CDD1|CDD1/CDD1\CDD1;
                      LDA.B #$03                          ;;CDD4|CDD4/CDD4\CDD4;
                      STA.W !SpriteMisc151C,X             ;;CDD6|CDD6/CDD6\CDD6;
                      RTS                                 ;;CDD9|CDD9/CDD9\CDD9; Return 
                                                          ;;                   ;
                    + LSR A                               ;;CDDA|CDDA/CDDA\CDDA;
                      LSR A                               ;;CDDB|CDDB/CDDB\CDDB;
                      STA.B !_0                           ;;CDDC|CDDC/CDDC\CDDC;
                      LDA.W !SpriteMisc1528,X             ;;CDDE|CDDE/CDDE\CDDE;
                      ASL A                               ;;CDE1|CDE1/CDE1\CDE1;
                      ASL A                               ;;CDE2|CDE2/CDE2\CDE2;
                      ASL A                               ;;CDE3|CDE3/CDE3\CDE3;
                      ASL A                               ;;CDE4|CDE4/CDE4\CDE4;
                      ORA.B !_0                           ;;CDE5|CDE5/CDE5\CDE5;
                      TAY                                 ;;CDE7|CDE7/CDE7\CDE7;
                      LDA.W DATA_03CD37,Y                 ;;CDE8|CDE8/CDE8\CDE8;
                      STA.W !SpriteMisc1602,X             ;;CDEB|CDEB/CDEB\CDEB;
                      RTS                                 ;;CDEE|CDEE/CDEE\CDEE; Return 
                                                          ;;                   ;
CODE_03CDEF:          LDA.W !SpriteMisc1540,X             ;;CDEF|CDEF/CDEF\CDEF;
                      BNE CODE_03CE05                     ;;CDF2|CDF2/CDF2\CDF2;
                      LDA.W !SpriteMisc1570,X             ;;CDF4|CDF4/CDF4\CDF4;
                      BEQ +                               ;;CDF7|CDF7/CDF7\CDF7;
                      STZ.W !SpriteStatus,X               ;;CDF9|CDF9/CDF9\CDF9;
                      RTS                                 ;;CDFC|CDFC/CDFC\CDFC; Return 
                                                          ;;                   ;
                    + STZ.W !SpriteMisc151C,X             ;;CDFD|CDFD/CDFD\CDFD;
                      LDA.B #$30                          ;;CE00|CE00/CE00\CE00;
                      STA.W !SpriteMisc1540,X             ;;CE02|CE02/CE02\CE02;
CODE_03CE05:          LDA.B #$10                          ;;CE05|CE05/CE05\CE05;
                      STA.B !SpriteYSpeed,X               ;;CE07|CE07/CE07\CE07;
                      JSL UpdateYPosNoGvtyW               ;;CE09|CE09/CE09\CE09;
                      RTS                                 ;;CE0D|CE0D/CE0D\CE0D; Return 
                                                          ;;                   ;
CODE_03CE0E:          LDA.W !SpriteMisc1540,X             ;;CE0E|CE0E/CE0E\CE0E;
                      BNE CODE_03CE2A                     ;;CE11|CE11/CE11\CE11;
                      INC.W !SpriteMisc1534,X             ;;CE13|CE13/CE13\CE13;
                      LDA.W !SpriteMisc1534,X             ;;CE16|CE16/CE16\CE16;
                      CMP.B #$03                          ;;CE19|CE19/CE19\CE19;
                      BNE CODE_03CDCF                     ;;CE1B|CE1B/CE1B\CE1B;
                      LDA.B #$05                          ;;CE1D|CE1D/CE1D\CE1D;
                      STA.W !SpriteMisc151C,X             ;;CE1F|CE1F/CE1F\CE1F;
                      STZ.B !SpriteYSpeed,X               ;;CE22|CE22/CE22\CE22; Sprite Y Speed = 0 
                      LDA.B #$23                          ;;CE24|CE24/CE24\CE24;
                      STA.W !SPCIO0                       ;;CE26|CE26/CE26\CE26; / Play sound effect 
                      RTS                                 ;;CE29|CE29/CE29\CE29; Return 
                                                          ;;                   ;
CODE_03CE2A:          LDY.W !SpriteMisc1570,X             ;;CE2A|CE2A/CE2A\CE2A;
                      BNE CODE_03CE42                     ;;CE2D|CE2D/CE2D\CE2D;
CODE_03CE2F:          CMP.B #$24                          ;;CE2F|CE2F/CE2F\CE2F;
                      BNE +                               ;;CE31|CE31/CE31\CE31;
                      LDY.B #$29                          ;;CE33|CE33/CE33\CE33;
                      STY.W !SPCIO3                       ;;CE35|CE35/CE35\CE35; / Play sound effect 
                    + LDA.B !EffFrame                     ;;CE38|CE38/CE38\CE38;
                      LSR A                               ;;CE3A|CE3A/CE3A\CE3A;
                      LSR A                               ;;CE3B|CE3B/CE3B\CE3B;
                      AND.B #$01                          ;;CE3C|CE3C/CE3C\CE3C;
                      STA.W !SpriteMisc1602,X             ;;CE3E|CE3E/CE3E\CE3E;
                      RTS                                 ;;CE41|CE41/CE41\CE41; Return 
                                                          ;;                   ;
CODE_03CE42:          CMP.B #$10                          ;;CE42|CE42/CE42\CE42;
                      BNE +                               ;;CE44|CE44/CE44\CE44;
                      LDY.B #$2A                          ;;CE46|CE46/CE46\CE46;
                      STY.W !SPCIO3                       ;;CE48|CE48/CE48\CE48; / Play sound effect 
                    + LSR A                               ;;CE4B|CE4B/CE4B\CE4B;
                      LSR A                               ;;CE4C|CE4C/CE4C\CE4C;
                      LSR A                               ;;CE4D|CE4D/CE4D\CE4D;
                      TAY                                 ;;CE4E|CE4E/CE4E\CE4E;
                      LDA.W DATA_03CE56,Y                 ;;CE4F|CE4F/CE4F\CE4F;
                      STA.W !SpriteMisc1602,X             ;;CE52|CE52/CE52\CE52;
                      RTS                                 ;;CE55|CE55/CE55\CE55; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03CE56:          db $16,$16,$15,$14                  ;;CE56|CE56/CE56\CE56;
                                                          ;;                   ;
CODE_03CE5A:          JSL UpdateYPosNoGvtyW               ;;CE5A|CE5A/CE5A\CE5A;
                      LDA.B !SpriteYSpeed,X               ;;CE5E|CE5E/CE5E\CE5E;
                      CMP.B #$40                          ;;CE60|CE60/CE60\CE60;
                      BPL +                               ;;CE62|CE62/CE62\CE62;
                      CLC                                 ;;CE64|CE64/CE64\CE64;
                      ADC.B #$03                          ;;CE65|CE65/CE65\CE65;
                      STA.B !SpriteYSpeed,X               ;;CE67|CE67/CE67\CE67;
                    + LDA.W !SpriteXPosHigh,X             ;;CE69|CE69/CE69\CE69;
                      BEQ +                               ;;CE6C|CE6C/CE6C\CE6C;
                      LDA.B !SpriteYPosLow,X              ;;CE6E|CE6E/CE6E\CE6E;
                      CMP.B #$85                          ;;CE70|CE70/CE70\CE70;
                      BCC +                               ;;CE72|CE72/CE72\CE72;
                      LDA.B #$06                          ;;CE74|CE74/CE74\CE74;
                      STA.W !SpriteMisc151C,X             ;;CE76|CE76/CE76\CE76;
                      LDA.B #$80                          ;;CE79|CE79/CE79\CE79;
                      STA.W !SpriteMisc1540,X             ;;CE7B|CE7B/CE7B\CE7B;
                      LDA.B #$20                          ;;CE7E|CE7E/CE7E\CE7E;
                      STA.W !SPCIO3                       ;;CE80|CE80/CE80\CE80; / Play sound effect 
                      JSL CODE_028528                     ;;CE83|CE83/CE83\CE83;
                    + BRA CODE_03CE2F                     ;;CE87|CE87/CE87\CE87;
                                                          ;;                   ;
CODE_03CE89:          LDA.W !SpriteMisc1540,X             ;;CE89|CE89/CE89\CE89;
                      BNE +                               ;;CE8C|CE8C/CE8C\CE8C;
                      STZ.W !SpriteStatus,X               ;;CE8E|CE8E/CE8E\CE8E;
                      INC.W !CutsceneID                   ;;CE91|CE91/CE91\CE91;
                      LDA.B #$FF                          ;;CE94|CE94/CE94\CE94;
                      STA.W !EndLevelTimer                ;;CE96|CE96/CE96\CE96;
                      LDA.B #$0B                          ;;CE99|CE99/CE99\CE99;
                      STA.W !SPCIO2                       ;;CE9B|CE9B/CE9B\CE9B; / Change music 
                    + LDA.B #$04                          ;;CE9E|CE9E/CE9E\CE9E;
                      STA.B !SpriteYSpeed,X               ;;CEA0|CEA0/CEA0\CEA0;
                      JSL UpdateYPosNoGvtyW               ;;CEA2|CEA2/CEA2\CEA2;
                      RTS                                 ;;CEA6|CEA6/CEA6\CEA6; Return 
                                                          ;;                   ;
CODE_03CEA7:          JSL MarioSprInteract                ;;CEA7|CEA7/CEA7\CEA7;
                      BCC Return03CEF1                    ;;CEAB|CEAB/CEAB\CEAB;
                      LDA.B !PlayerYSpeed                 ;;CEAD|CEAD/CEAD\CEAD;
                      CMP.B #$10                          ;;CEAF|CEAF/CEAF\CEAF;
                      BMI CODE_03CEED                     ;;CEB1|CEB1/CEB1\CEB1;
                      JSL DisplayContactGfx               ;;CEB3|CEB3/CEB3\CEB3;
                      LDA.B #$02                          ;;CEB7|CEB7/CEB7\CEB7;
                      JSL GivePoints                      ;;CEB9|CEB9/CEB9\CEB9;
                      JSL BoostMarioSpeed                 ;;CEBD|CEBD/CEBD\CEBD;
                      LDA.B #$02                          ;;CEC1|CEC1/CEC1\CEC1;
                      STA.W !SPCIO0                       ;;CEC3|CEC3/CEC3\CEC3; / Play sound effect 
                      LDA.W !SpriteMisc1570,X             ;;CEC6|CEC6/CEC6\CEC6;
                      BNE +                               ;;CEC9|CEC9/CEC9\CEC9;
                      LDA.B #$28                          ;;CECB|CECB/CECB\CECB;
                      STA.W !SPCIO3                       ;;CECD|CECD/CECD\CECD; / Play sound effect 
                      LDA.W !SpriteMisc1534,X             ;;CED0|CED0/CED0\CED0;
                      CMP.B #$02                          ;;CED3|CED3/CED3\CED3;
                      BNE +                               ;;CED5|CED5/CED5\CED5;
                      JSL KillMostSprites                 ;;CED7|CED7/CED7\CED7;
                    + LDA.B #$04                          ;;CEDB|CEDB/CEDB\CEDB;
                      STA.W !SpriteMisc151C,X             ;;CEDD|CEDD/CEDD\CEDD;
                      LDA.B #$50                          ;;CEE0|CEE0/CEE0\CEE0;
                      LDY.W !SpriteMisc1570,X             ;;CEE2|CEE2/CEE2\CEE2;
                      BEQ +                               ;;CEE5|CEE5/CEE5\CEE5;
                      LDA.B #$1F                          ;;CEE7|CEE7/CEE7\CEE7;
                    + STA.W !SpriteMisc1540,X             ;;CEE9|CEE9/CEE9\CEE9;
                      RTS                                 ;;CEEC|CEEC/CEEC\CEEC; Return 
                                                          ;;                   ;
CODE_03CEED:          JSL HurtMario                       ;;CEED|CEED/CEED\CEED;
Return03CEF1:         RTS                                 ;;CEF1|CEF1/CEF1\CEF1; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03CEF2:          db $F8,$08,$F8,$08,$00,$00,$F8,$08  ;;CEF2|CEF2/CEF2\CEF2;
                      db $F8,$08,$00,$00,$F8,$00,$00,$00  ;;CEFA|CEFA/CEFA\CEFA;
                      db $00,$00,$FB,$00,$FB,$03,$00,$00  ;;CF02|CF02/CF02\CF02;
                      db $F8,$08,$00,$00,$08,$00,$F8,$08  ;;CF0A|CF0A/CF0A\CF0A;
                      db $00,$00,$00,$00,$F8,$00,$00,$00  ;;CF12|CF12/CF12\CF12;
                      db $00,$00,$F8,$00,$08,$00,$00,$00  ;;CF1A|CF1A/CF1A\CF1A;
                      db $F8,$08,$00,$06,$00,$00,$F8,$08  ;;CF22|CF22/CF22\CF22;
                      db $00,$02,$00,$00,$F8,$08,$00,$04  ;;CF2A|CF2A/CF2A\CF2A;
                      db $00,$08,$F8,$08,$00,$00,$08,$00  ;;CF32|CF32/CF32\CF32;
                      db $F8,$08,$00,$00,$00,$00,$F8,$08  ;;CF3A|CF3A/CF3A\CF3A;
                      db $00,$00,$00,$00,$F8,$08,$00,$00  ;;CF42|CF42/CF42\CF42;
                      db $08,$00,$F8,$08,$00,$00,$08,$00  ;;CF4A|CF4A/CF4A\CF4A;
                      db $F8,$08,$00,$00,$00,$00,$F8,$08  ;;CF52|CF52/CF52\CF52;
                      db $00,$00,$00,$00,$F8,$08,$00,$00  ;;CF5A|CF5A/CF5A\CF5A;
                      db $00,$00,$F8,$08,$00,$00,$08,$00  ;;CF62|CF62/CF62\CF62;
                      db $F8,$08,$00,$00,$00,$00,$F8,$08  ;;CF6A|CF6A/CF6A\CF6A;
                      db $00,$00,$00,$00,$F8,$08,$00,$00  ;;CF72|CF72/CF72\CF72;
                      db $00,$00                          ;;CF7A|CF7A/CF7A\CF7A;
                                                          ;;                   ;
DATA_03CF7C:          db $F8,$08,$F8,$08,$00,$00,$F8,$08  ;;CF7C|CF7C/CF7C\CF7C;
                      db $F8,$08,$00,$00,$F8,$00,$08,$00  ;;CF84|CF84/CF84\CF84;
                      db $00,$00,$FB,$00,$FB,$03,$00,$00  ;;CF8C|CF8C/CF8C\CF8C;
                      db $F8,$08,$00,$00,$08,$00,$F8,$08  ;;CF94|CF94/CF94\CF94;
                      db $00,$00,$00,$00,$F8,$00,$08,$00  ;;CF9C|CF9C/CF9C\CF9C;
                      db $00,$00,$F8,$00,$08,$00,$00,$00  ;;CFA4|CFA4/CFA4\CFA4;
                      db $F8,$08,$00,$06,$00,$08,$F8,$08  ;;CFAC|CFAC/CFAC\CFAC;
                      db $00,$02,$00,$08,$F8,$08,$00,$04  ;;CFB4|CFB4/CFB4\CFB4;
                      db $00,$08,$F8,$08,$00,$00,$08,$00  ;;CFBC|CFBC/CFBC\CFBC;
                      db $F8,$08,$00,$00,$00,$00,$F8,$08  ;;CFC4|CFC4/CFC4\CFC4;
                      db $00,$00,$00,$00,$F8,$08,$00,$00  ;;CFCC|CFCC/CFCC\CFCC;
                      db $08,$00,$F8,$08,$00,$00,$08,$00  ;;CFD4|CFD4/CFD4\CFD4;
                      db $F8,$08,$00,$00,$00,$00,$F8,$08  ;;CFDC|CFDC/CFDC\CFDC;
                      db $00,$00,$00,$00,$F8,$08,$00,$00  ;;CFE4|CFE4/CFE4\CFE4;
                      db $00,$00,$F8,$08,$00,$00,$08,$00  ;;CFEC|CFEC/CFEC\CFEC;
                      db $F8,$08,$00,$00,$00,$00,$F8,$08  ;;CFF4|CFF4/CFF4\CFF4;
                      db $00,$00,$00,$00,$F8,$08,$00,$00  ;;CFFC|CFFC/CFFC\CFFC;
                      db $00,$00                          ;;D004|D004/D004\D004;
                                                          ;;                   ;
DATA_03D006:          db $04,$04,$14,$14,$00,$00,$04,$04  ;;D006|D006/D006\D006;
                      db $14,$14,$00,$00,$00,$08,$F8,$00  ;;D00E|D00E/D00E\D00E;
                      db $00,$00,$00,$08,$F8,$F8,$00,$00  ;;D016|D016/D016\D016;
                      db $05,$05,$00,$F8,$F8,$00,$05,$05  ;;D01E|D01E/D01E\D01E;
                      db $00,$00,$00,$00,$00,$08,$F8,$00  ;;D026|D026/D026\D026;
                      db $00,$00,$00,$08,$00,$00,$00,$00  ;;D02E|D02E/D02E\D02E;
                      db $05,$05,$00,$F8,$00,$00,$05,$05  ;;D036|D036/D036\D036;
                      db $00,$F8,$00,$00,$05,$05,$00,$0F  ;;D03E|D03E/D03E\D03E;
                      db $F8,$F8,$05,$05,$00,$F8,$F8,$00  ;;D046|D046/D046\D046;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D04E|D04E/D04E\D04E;
                      db $00,$00,$00,$00,$05,$05,$00,$F8  ;;D056|D056/D056\D056;
                      db $F8,$00,$05,$05,$00,$F8,$F8,$00  ;;D05E|D05E/D05E\D05E;
                      db $04,$04,$02,$00,$00,$00,$04,$04  ;;D066|D066/D066\D066;
                      db $01,$00,$00,$00,$04,$04,$00,$00  ;;D06E|D06E/D06E\D06E;
                      db $00,$00,$05,$05,$00,$F8,$F8,$00  ;;D076|D076/D076\D076;
                      db $05,$05,$00,$00,$00,$00,$05,$05  ;;D07E|D07E/D07E\D07E;
                      db $03,$00,$00,$00,$05,$05,$04,$00  ;;D086|D086/D086\D086;
                      db $00,$00                          ;;D08E|D08E/D08E\D08E;
                                                          ;;                   ;
DATA_03D090:          db $04,$04,$14,$14,$00,$00,$04,$04  ;;D090|D090/D090\D090;
                      db $14,$14,$00,$00,$00,$08,$00,$00  ;;D098|D098/D098\D098;
                      db $00,$00,$00,$08,$F8,$F8,$00,$00  ;;D0A0|D0A0/D0A0\D0A0;
                      db $05,$05,$00,$F8,$F8,$00,$05,$05  ;;D0A8|D0A8/D0A8\D0A8;
                      db $00,$00,$00,$00,$00,$08,$00,$00  ;;D0B0|D0B0/D0B0\D0B0;
                      db $00,$00,$00,$08,$08,$00,$00,$00  ;;D0B8|D0B8/D0B8\D0B8;
                      db $05,$05,$00,$F8,$F8,$00,$05,$05  ;;D0C0|D0C0/D0C0\D0C0;
                      db $00,$F8,$F8,$00,$05,$05,$00,$0F  ;;D0C8|D0C8/D0C8\D0C8;
                      db $F8,$F8,$05,$05,$00,$F8,$F8,$00  ;;D0D0|D0D0/D0D0\D0D0;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D0D8|D0D8/D0D8\D0D8;
                      db $00,$00,$00,$00,$05,$05,$00,$F8  ;;D0E0|D0E0/D0E0\D0E0;
                      db $F8,$00,$05,$05,$00,$F8,$F8,$00  ;;D0E8|D0E8/D0E8\D0E8;
                      db $04,$04,$02,$00,$00,$00,$04,$04  ;;D0F0|D0F0/D0F0\D0F0;
                      db $01,$00,$00,$00,$04,$04,$00,$00  ;;D0F8|D0F8/D0F8\D0F8;
                      db $00,$00,$05,$05,$00,$F8,$F8,$00  ;;D100|D100/D100\D100;
                      db $05,$05,$00,$00,$00,$00,$05,$05  ;;D108|D108/D108\D108;
                      db $03,$00,$00,$00,$05,$05,$04,$00  ;;D110|D110/D110\D110;
                      db $00,$00                          ;;D118|D118/D118\D118;
                                                          ;;                   ;
DATA_03D11A:          db $20,$20,$26,$26,$08,$00,$2E,$2E  ;;D11A|D11A/D11A\D11A;
                      db $24,$24,$08,$00,$00,$28,$02,$00  ;;D122|D122/D122\D122;
                      db $00,$00,$04,$28,$12,$12,$00,$00  ;;D12A|D12A/D12A\D12A;
                      db $22,$22,$04,$12,$12,$00,$20,$20  ;;D132|D132/D132\D132;
                      db $08,$00,$00,$00,$00,$28,$02,$00  ;;D13A|D13A/D13A\D13A;
                      db $00,$00,$0A,$28,$13,$00,$00,$00  ;;D142|D142/D142\D142;
                      db $20,$20,$0C,$02,$00,$00,$20,$20  ;;D14A|D14A/D14A\D14A;
                      db $0C,$02,$00,$00,$22,$22,$06,$03  ;;D152|D152/D152\D152;
                      db $12,$12,$20,$20,$06,$12,$12,$00  ;;D15A|D15A/D15A\D15A;
                      db $2A,$2A,$00,$00,$00,$00,$2C,$2C  ;;D162|D162/D162\D162;
                      db $00,$00,$00,$00,$20,$20,$06,$12  ;;D16A|D16A/D16A\D16A;
                      db $12,$00,$20,$20,$06,$12,$12,$00  ;;D172|D172/D172\D172;
                      db $22,$22,$08,$00,$00,$00,$20,$20  ;;D17A|D17A/D17A\D17A;
                      db $08,$00,$00,$00,$2E,$2E,$08,$00  ;;D182|D182/D182\D182;
                      db $00,$00,$4E,$4E,$60,$43,$43,$00  ;;D18A|D18A/D18A\D18A;
                      db $4E,$4E,$64,$00,$00,$00,$62,$62  ;;D192|D192/D192\D192;
                      db $64,$00,$00,$00,$62,$62,$64,$00  ;;D19A|D19A/D19A\D19A;
                      db $00,$00                          ;;D1A2|D1A2/D1A2\D1A2;
                                                          ;;                   ;
DATA_03D1A4:          db $20,$20,$26,$26,$48,$00,$2E,$2E  ;;D1A4|D1A4/D1A4\D1A4;
                      db $24,$24,$48,$00,$40,$28,$42,$00  ;;D1AC|D1AC/D1AC\D1AC;
                      db $00,$00,$44,$28,$52,$52,$00,$00  ;;D1B4|D1B4/D1B4\D1B4;
                      db $22,$22,$44,$52,$52,$00,$20,$20  ;;D1BC|D1BC/D1BC\D1BC;
                      db $48,$00,$00,$00,$40,$28,$42,$00  ;;D1C4|D1C4/D1C4\D1C4;
                      db $00,$00,$4A,$28,$53,$00,$00,$00  ;;D1CC|D1CC/D1CC\D1CC;
                      db $20,$20,$4C,$1E,$1F,$00,$20,$20  ;;D1D4|D1D4/D1D4\D1D4;
                      db $4C,$1F,$1E,$00,$22,$22,$44,$03  ;;D1DC|D1DC/D1DC\D1DC;
                      db $52,$52,$20,$20,$44,$52,$52,$00  ;;D1E4|D1E4/D1E4\D1E4;
                      db $2A,$2A,$00,$00,$00,$00,$2C,$2C  ;;D1EC|D1EC/D1EC\D1EC;
                      db $00,$00,$00,$00,$20,$20,$46,$52  ;;D1F4|D1F4/D1F4\D1F4;
                      db $52,$00,$20,$20,$46,$52,$52,$00  ;;D1FC|D1FC/D1FC\D1FC;
                      db $22,$22,$48,$00,$00,$00,$20,$20  ;;D204|D204/D204\D204;
                      db $48,$00,$00,$00,$2E,$2E,$48,$00  ;;D20C|D20C/D20C\D20C;
                      db $00,$00,$4E,$4E,$66,$68,$68,$00  ;;D214|D214/D214\D214;
                      db $4E,$4E,$6A,$00,$00,$00,$62,$62  ;;D21C|D21C/D21C\D21C;
                      db $6A,$00,$00,$00,$62,$62,$6A,$00  ;;D224|D224/D224\D224;
                      db $00,$00                          ;;D22C|D22C/D22C\D22C;
                                                          ;;                   ;
LemmyGfxProp:         db $05,$45,$05,$45,$05,$00,$05,$45  ;;D22E|D22E/D22E\D22E;
                      db $05,$45,$05,$00,$05,$05,$05,$00  ;;D236|D236/D236\D236;
                      db $00,$00,$05,$05,$05,$45,$00,$00  ;;D23E|D23E/D23E\D23E;
                      db $05,$45,$05,$05,$45,$00,$05,$45  ;;D246|D246/D246\D246;
                      db $05,$00,$00,$00,$05,$05,$05,$00  ;;D24E|D24E/D24E\D24E;
                      db $00,$00,$05,$05,$05,$00,$00,$00  ;;D256|D256/D256\D256;
                      db $05,$45,$05,$05,$00,$00,$05,$45  ;;D25E|D25E/D25E\D25E;
                      db $45,$45,$00,$00,$05,$45,$05,$05  ;;D266|D266/D266\D266;
                      db $05,$45,$05,$45,$45,$05,$45,$00  ;;D26E|D26E/D26E\D26E;
                      db $05,$45,$00,$00,$00,$00,$05,$45  ;;D276|D276/D276\D276;
                      db $00,$00,$00,$00,$05,$45,$45,$05  ;;D27E|D27E/D27E\D27E;
                      db $45,$00,$05,$45,$05,$05,$45,$00  ;;D286|D286/D286\D286;
                      db $05,$45,$05,$00,$00,$00,$05,$45  ;;D28E|D28E/D28E\D28E;
                      db $05,$00,$00,$00,$05,$45,$05,$00  ;;D296|D296/D296\D296;
                      db $00,$00,$07,$47,$07,$07,$47,$00  ;;D29E|D29E/D29E\D29E;
                      db $07,$47,$07,$00,$00,$00,$07,$47  ;;D2A6|D2A6/D2A6\D2A6;
                      db $07,$00,$00,$00,$07,$47,$07,$00  ;;D2AE|D2AE/D2AE\D2AE;
                      db $00,$00                          ;;D2B6|D2B6/D2B6\D2B6;
                                                          ;;                   ;
WendyGfxProp:         db $09,$49,$09,$49,$09,$00,$09,$49  ;;D2B8|D2B8/D2B8\D2B8;
                      db $09,$49,$09,$00,$09,$09,$09,$00  ;;D2C0|D2C0/D2C0\D2C0;
                      db $00,$00,$09,$09,$09,$49,$00,$00  ;;D2C8|D2C8/D2C8\D2C8;
                      db $09,$49,$09,$09,$49,$00,$09,$49  ;;D2D0|D2D0/D2D0\D2D0;
                      db $09,$00,$00,$00,$09,$09,$09,$00  ;;D2D8|D2D8/D2D8\D2D8;
                      db $00,$00,$09,$09,$09,$00,$00,$00  ;;D2E0|D2E0/D2E0\D2E0;
                      db $09,$49,$09,$09,$09,$00,$09,$49  ;;D2E8|D2E8/D2E8\D2E8;
                      db $49,$49,$49,$00,$09,$49,$09,$09  ;;D2F0|D2F0/D2F0\D2F0;
                      db $09,$49,$09,$49,$49,$09,$49,$00  ;;D2F8|D2F8/D2F8\D2F8;
                      db $09,$49,$00,$00,$00,$00,$09,$49  ;;D300|D300/D300\D300;
                      db $00,$00,$00,$00,$09,$49,$49,$09  ;;D308|D308/D308\D308;
                      db $49,$00,$09,$49,$09,$09,$49,$00  ;;D310|D310/D310\D310;
                      db $09,$49,$09,$00,$00,$00,$09,$49  ;;D318|D318/D318\D318;
                      db $09,$00,$00,$00,$09,$49,$09,$00  ;;D320|D320/D320\D320;
                      db $00,$00,$05,$45,$05,$05,$45,$00  ;;D328|D328/D328\D328;
                      db $05,$45,$05,$00,$00,$00,$05,$45  ;;D330|D330/D330\D330;
                      db $05,$00,$00,$00,$05,$45,$05,$00  ;;D338|D338/D338\D338;
                      db $00,$00                          ;;D340|D340/D340\D340;
                                                          ;;                   ;
DATA_03D342:          db $02,$02,$02,$02,$02,$04,$02,$02  ;;D342|D342/D342\D342;
                      db $02,$02,$02,$04,$02,$02,$00,$04  ;;D34A|D34A/D34A\D34A;
                      db $04,$04,$02,$02,$00,$00,$04,$04  ;;D352|D352/D352\D352;
                      db $02,$02,$02,$00,$00,$04,$02,$02  ;;D35A|D35A/D35A\D35A;
                      db $02,$04,$04,$04,$02,$02,$00,$04  ;;D362|D362/D362\D362;
                      db $04,$04,$02,$02,$00,$04,$04,$04  ;;D36A|D36A/D36A\D36A;
                      db $02,$02,$02,$00,$04,$04,$02,$02  ;;D372|D372/D372\D372;
                      db $02,$00,$04,$04,$02,$02,$02,$00  ;;D37A|D37A/D37A\D37A;
                      db $00,$00,$02,$02,$02,$00,$00,$04  ;;D382|D382/D382\D382;
                      db $02,$02,$04,$04,$04,$04,$02,$02  ;;D38A|D38A/D38A\D38A;
                      db $04,$04,$04,$04,$02,$02,$02,$00  ;;D392|D392/D392\D392;
                      db $00,$04,$02,$02,$02,$00,$00,$04  ;;D39A|D39A/D39A\D39A;
                      db $02,$02,$02,$04,$04,$04,$02,$02  ;;D3A2|D3A2/D3A2\D3A2;
                      db $02,$04,$04,$04,$02,$02,$02,$04  ;;D3AA|D3AA/D3AA\D3AA;
                      db $04,$04,$02,$02,$02,$00,$00,$04  ;;D3B2|D3B2/D3B2\D3B2;
                      db $02,$02,$02,$04,$04,$04,$02,$02  ;;D3BA|D3BA/D3BA\D3BA;
                      db $02,$04,$04,$04,$02,$02,$02,$04  ;;D3C2|D3C2/D3C2\D3C2;
                      db $04,$04                          ;;D3CA|D3CA/D3CA\D3CA;
                                                          ;;                   ;
DATA_03D3CC:          db $02,$02,$02,$02,$02,$04,$02,$02  ;;D3CC|D3CC/D3CC\D3CC;
                      db $02,$02,$02,$04,$02,$02,$00,$04  ;;D3D4|D3D4/D3D4\D3D4;
                      db $04,$04,$02,$02,$00,$00,$04,$04  ;;D3DC|D3DC/D3DC\D3DC;
                      db $02,$02,$02,$00,$00,$04,$02,$02  ;;D3E4|D3E4/D3E4\D3E4;
                      db $02,$04,$04,$04,$02,$02,$00,$04  ;;D3EC|D3EC/D3EC\D3EC;
                      db $04,$04,$02,$02,$00,$04,$04,$04  ;;D3F4|D3F4/D3F4\D3F4;
                      db $02,$02,$02,$00,$00,$04,$02,$02  ;;D3FC|D3FC/D3FC\D3FC;
                      db $02,$00,$00,$04,$02,$02,$02,$00  ;;D404|D404/D404\D404;
                      db $00,$00,$02,$02,$02,$00,$00,$04  ;;D40C|D40C/D40C\D40C;
                      db $02,$02,$04,$04,$04,$04,$02,$02  ;;D414|D414/D414\D414;
                      db $04,$04,$04,$04,$02,$02,$02,$00  ;;D41C|D41C/D41C\D41C;
                      db $00,$04,$02,$02,$02,$00,$00,$04  ;;D424|D424/D424\D424;
                      db $02,$02,$02,$04,$04,$04,$02,$02  ;;D42C|D42C/D42C\D42C;
                      db $02,$04,$04,$04,$02,$02,$02,$04  ;;D434|D434/D434\D434;
                      db $04,$04,$02,$02,$02,$00,$00,$04  ;;D43C|D43C/D43C\D43C;
                      db $02,$02,$02,$04,$04,$04,$02,$02  ;;D444|D444/D444\D444;
                      db $02,$04,$04,$04,$02,$02,$02,$04  ;;D44C|D44C/D44C\D44C;
                      db $04,$04                          ;;D454|D454/D454\D454;
                                                          ;;                   ;
DATA_03D456:          db $04,$04,$02,$03,$04,$02,$02,$02  ;;D456|D456/D456\D456;
                      db $03,$03,$05,$04,$01,$01,$04,$04  ;;D45E|D45E/D45E\D45E;
                      db $02,$02,$02,$04,$02,$02,$02      ;;D466|D466/D466\D466;
                                                          ;;                   ;
DATA_03D46D:          db $04,$04,$02,$03,$04,$02,$02,$02  ;;D46D|D46D/D46D\D46D;
                      db $04,$04,$05,$04,$01,$01,$04,$04  ;;D475|D475/D475\D475;
                      db $02,$02,$02,$04,$02,$02,$02      ;;D47D|D47D/D47D\D47D;
                                                          ;;                   ;
CODE_03D484:          JSR GetDrawInfoBnk3                 ;;D484|D484/D484\D484;
                      LDA.W !SpriteMisc1602,X             ;;D487|D487/D487\D487;
                      ASL A                               ;;D48A|D48A/D48A\D48A;
                      ASL A                               ;;D48B|D48B/D48B\D48B;
                      ADC.W !SpriteMisc1602,X             ;;D48C|D48C/D48C\D48C;
                      ADC.W !SpriteMisc1602,X             ;;D48F|D48F/D48F\D48F;
                      STA.B !_2                           ;;D492|D492/D492\D492;
                      LDA.B !SpriteTableC2,X              ;;D494|D494/D494\D494;
                      CMP.B #$06                          ;;D496|D496/D496\D496;
                      BEQ CODE_03D4DF                     ;;D498|D498/D498\D498;
                      PHX                                 ;;D49A|D49A/D49A\D49A;
                      LDA.W !SpriteMisc1602,X             ;;D49B|D49B/D49B\D49B;
                      TAX                                 ;;D49E|D49E/D49E\D49E;
                      %LorW_X(LDA,DATA_03D456)            ;;D49F|D49F/D49F\D49F;
                      TAX                                 ;;D4A3|D4A2/D4A2\D4A2;
                    - PHX                                 ;;D4A4|D4A3/D4A3\D4A3;
                      TXA                                 ;;D4A5|D4A4/D4A4\D4A4;
                      CLC                                 ;;D4A6|D4A5/D4A5\D4A5;
                      ADC.B !_2                           ;;D4A7|D4A6/D4A6\D4A6;
                      TAX                                 ;;D4A9|D4A8/D4A8\D4A8;
                      LDA.B !_0                           ;;D4AA|D4A9/D4A9\D4A9;
                      CLC                                 ;;D4AC|D4AB/D4AB\D4AB;
                      ADC.W DATA_03CEF2,X                 ;;D4AD|D4AC/D4AC\D4AC;
                      STA.W !OAMTileXPos+$100,Y           ;;D4B0|D4AF/D4AF\D4AF;
                      LDA.B !_1                           ;;D4B3|D4B2/D4B2\D4B2;
                      CLC                                 ;;D4B5|D4B4/D4B4\D4B4;
                      ADC.W DATA_03D006,X                 ;;D4B6|D4B5/D4B5\D4B5;
                      STA.W !OAMTileYPos+$100,Y           ;;D4B9|D4B8/D4B8\D4B8;
                      LDA.W DATA_03D11A,X                 ;;D4BC|D4BB/D4BB\D4BB;
                      STA.W !OAMTileNo+$100,Y             ;;D4BF|D4BE/D4BE\D4BE;
                      LDA.W LemmyGfxProp,X                ;;D4C2|D4C1/D4C1\D4C1;
                      ORA.B #$10                          ;;D4C5|D4C4/D4C4\D4C4;
                      STA.W !OAMTileAttr+$100,Y           ;;D4C7|D4C6/D4C6\D4C6;
                      PHY                                 ;;D4CA|D4C9/D4C9\D4C9;
                      TYA                                 ;;D4CB|D4CA/D4CA\D4CA;
                      LSR A                               ;;D4CC|D4CB/D4CB\D4CB;
                      LSR A                               ;;D4CD|D4CC/D4CC\D4CC;
                      TAY                                 ;;D4CE|D4CD/D4CD\D4CD;
                      LDA.W DATA_03D342,X                 ;;D4CF|D4CE/D4CE\D4CE;
                      STA.W !OAMTileSize+$40,Y            ;;D4D2|D4D1/D4D1\D4D1;
                      PLY                                 ;;D4D5|D4D4/D4D4\D4D4;
                      INY                                 ;;D4D6|D4D5/D4D5\D4D5;
                      INY                                 ;;D4D7|D4D6/D4D6\D4D6;
                      INY                                 ;;D4D8|D4D7/D4D7\D4D7;
                      INY                                 ;;D4D9|D4D8/D4D8\D4D8;
                      PLX                                 ;;D4DA|D4D9/D4D9\D4D9;
                      DEX                                 ;;D4DB|D4DA/D4DA\D4DA;
                      BPL -                               ;;D4DC|D4DB/D4DB\D4DB;
CODE_03D4DD:          PLX                                 ;;D4DE|D4DD/D4DD\D4DD;
                      RTS                                 ;;D4DF|D4DE/D4DE\D4DE; Return 
                                                          ;;                   ;
CODE_03D4DF:          PHX                                 ;;D4E0|D4DF/D4DF\D4DF;
                      LDA.W !SpriteMisc1602,X             ;;D4E1|D4E0/D4E0\D4E0;
                      TAX                                 ;;D4E4|D4E3/D4E3\D4E3;
                      %LorW_X(LDA,DATA_03D46D)            ;;D4E5|D4E4/D4E4\D4E4;
                      TAX                                 ;;D4E9|D4E7/D4E7\D4E7;
                    - PHX                                 ;;D4EA|D4E8/D4E8\D4E8;
                      TXA                                 ;;D4EB|D4E9/D4E9\D4E9;
                      CLC                                 ;;D4EC|D4EA/D4EA\D4EA;
                      ADC.B !_2                           ;;D4ED|D4EB/D4EB\D4EB;
                      TAX                                 ;;D4EF|D4ED/D4ED\D4ED;
                      LDA.B !_0                           ;;D4F0|D4EE/D4EE\D4EE;
                      CLC                                 ;;D4F2|D4F0/D4F0\D4F0;
                      ADC.W DATA_03CF7C,X                 ;;D4F3|D4F1/D4F1\D4F1;
                      STA.W !OAMTileXPos+$100,Y           ;;D4F6|D4F4/D4F4\D4F4;
                      LDA.B !_1                           ;;D4F9|D4F7/D4F7\D4F7;
                      CLC                                 ;;D4FB|D4F9/D4F9\D4F9;
                      ADC.W DATA_03D090,X                 ;;D4FC|D4FA/D4FA\D4FA;
                      STA.W !OAMTileYPos+$100,Y           ;;D4FF|D4FD/D4FD\D4FD;
                      LDA.W DATA_03D1A4,X                 ;;D502|D500/D500\D500;
                      STA.W !OAMTileNo+$100,Y             ;;D505|D503/D503\D503;
                      LDA.W WendyGfxProp,X                ;;D508|D506/D506\D506;
                      ORA.B #$10                          ;;D50B|D509/D509\D509;
                      STA.W !OAMTileAttr+$100,Y           ;;D50D|D50B/D50B\D50B;
                      PHY                                 ;;D510|D50E/D50E\D50E;
                      TYA                                 ;;D511|D50F/D50F\D50F;
                      LSR A                               ;;D512|D510/D510\D510;
                      LSR A                               ;;D513|D511/D511\D511;
                      TAY                                 ;;D514|D512/D512\D512;
                      LDA.W DATA_03D3CC,X                 ;;D515|D513/D513\D513;
                      STA.W !OAMTileSize+$40,Y            ;;D518|D516/D516\D516;
                      PLY                                 ;;D51B|D519/D519\D519;
                      INY                                 ;;D51C|D51A/D51A\D51A;
                      INY                                 ;;D51D|D51B/D51B\D51B;
                      INY                                 ;;D51E|D51C/D51C\D51C;
                      INY                                 ;;D51F|D51D/D51D\D51D;
                      PLX                                 ;;D520|D51E/D51E\D51E;
                      DEX                                 ;;D521|D51F/D51F\D51F;
                      BPL -                               ;;D522|D520/D520\D520;
                      BRA CODE_03D4DD                     ;;D524|D522/D522\D522;
                                                          ;;                   ;
                                                          ;;                   ;
                   if !_VER == 0                ;\   IF   ;;+++++++++++++++++++; J
DATA_03D524:          db $28,$30,$88,$0E,$30,$30,$89,$0E  ;;D526|              ;
                      db $38,$30,$8A,$0E,$38,$28,$8B,$0E  ;;D52E|              ;
                      db $48,$30,$88,$0E,$50,$30,$8C,$0E  ;;D536|              ;
                      db $58,$30,$8D,$0E,$58,$28,$8B,$0E  ;;D53E|              ;
                      db $60,$30,$8E,$0E,$68,$30,$98,$0E  ;;D546|              ;
                      db $70,$30,$99,$0E,$78,$30,$9A,$0E  ;;D54E|              ;
                      db $80,$30,$8E,$0E,$88,$30,$9B,$0E  ;;D556|              ;
                      db $88,$28,$8B,$0E,$90,$30,$9C,$0E  ;;D55E|              ;
                      db $98,$30,$9D,$0E,$A0,$30,$8C,$0E  ;;D566|              ;
                      db $A8,$30,$9E,$0E,$B8,$30,$A0,$0E  ;;D56E|              ;
                      db $C0,$30,$A1,$0E,$C8,$30,$99,$0E  ;;D576|              ;
                      db $D0,$30,$8A,$0E,$D0,$28,$8B,$0E  ;;D57E|              ;
                      db $D8,$30,$A8,$0E,$E0,$30,$F2,$0E  ;;D586|              ;
                      db $20,$40,$A9,$0E,$28,$40,$AA,$0E  ;;D58E|              ;
                      db $30,$40,$AB,$0E,$38,$40,$AC,$0E  ;;D596|              ;
                      db $40,$40,$8E,$0E,$48,$40,$AD,$0E  ;;D59E|              ;
                      db $50,$40,$AE,$0E,$58,$40,$AF,$0E  ;;D5A6|              ;
                      db $60,$40,$B0,$0E,$68,$40,$B1,$0E  ;;D5AE|              ;
                      db $70,$40,$A1,$0E,$78,$40,$A1,$0E  ;;D5B6|              ;
                      db $80,$40,$FF,$0E,$88,$40,$8A,$0E  ;;D5BE|              ;
                      db $90,$40,$B8,$0E,$98,$40,$B9,$0E  ;;D5C6|              ;
                      db $98,$38,$BA,$0E,$A0,$40,$AC,$0E  ;;D5CE|              ;
                      db $A8,$40,$BB,$0E,$B0,$40,$8D,$0E  ;;D5D6|              ;
                      db $B8,$40,$8E,$0E,$C0,$40,$BC,$0E  ;;D5DE|              ;
                      db $C8,$40,$8E,$0E,$D0,$40,$BD,$0E  ;;D5E6|              ;
                      db $D8,$40,$BE,$0E,$20,$50,$BF,$0E  ;;D5EE|              ;
                      db $20,$48,$8B,$0E,$28,$50,$DE,$0E  ;;D5F6|              ;
                      db $30,$50,$AC,$0E,$38,$50,$AB,$0E  ;;D5FE|              ;
                      db $40,$50,$DF,$0E,$48,$50,$E2,$0E  ;;D606|              ;
                      db $50,$50,$AE,$0E,$50,$48,$8B,$0E  ;;D60E|              ;
                      db $60,$50,$E5,$0E,$68,$50,$BC,$0E  ;;D616|              ;
                      db $70,$50,$BC,$0E,$78,$50,$E0,$0E  ;;D61E|              ;
                      db $78,$48,$8B,$0E,$80,$50,$9E,$0E  ;;D626|              ;
                      db $88,$50,$BD,$0E,$88,$48,$8B,$0E  ;;D62E|              ;
                      db $90,$50,$AF,$0E,$98,$50,$99,$0E  ;;D636|              ;
                      db $A0,$50,$AF,$0E,$A8,$50,$A8,$0E  ;;D63E|              ;
                      db $B0,$50,$F5,$0E,$B8,$50,$F5,$0E  ;;D646|              ;
                      db $C0,$50,$F5,$0E,$C8,$50,$F5,$0E  ;;D64E|              ;
                   else                         ;<  ELSE  ;;-------------------; U, E0, & E1
DATA_03D524:          db $18,$20,$A1,$0E,$20,$20,$88,$0E  ;;    |D524/D524\D524;
                      db $28,$20,$AB,$0E,$30,$20,$99,$0E  ;;    |D52C/D52C\D52C;
                      db $38,$20,$A8,$0E,$40,$20,$BF,$0E  ;;    |D534/D534\D534;
                      db $48,$20,$AC,$0E,$58,$20,$88,$0E  ;;    |D53C/D53C\D53C;
                      db $60,$20,$8B,$0E,$68,$20,$AF,$0E  ;;    |D544/D544\D544;
                      db $70,$20,$8C,$0E,$78,$20,$9E,$0E  ;;    |D54C/D54C\D54C;
                      db $80,$20,$AD,$0E,$88,$20,$AE,$0E  ;;    |D554/D554\D554;
                      db $90,$20,$AB,$0E,$98,$20,$8C,$0E  ;;    |D55C/D55C\D55C;
                      db $A8,$20,$99,$0E,$B0,$20,$AC,$0E  ;;    |D564/D564\D564;
                      db $C0,$20,$A8,$0E,$C8,$20,$AF,$0E  ;;    |D56C/D56C\D56C;
                      db $D0,$20,$8C,$0E,$D8,$20,$AB,$0E  ;;    |D574/D574\D574;
                      db $E0,$20,$BD,$0E,$18,$30,$A1,$0E  ;;    |D57C/D57C\D57C;
                      db $20,$30,$88,$0E,$28,$30,$AB,$0E  ;;    |D584/D584\D584;
                      db $30,$30,$99,$0E,$38,$30,$A8,$0E  ;;    |D58C/D58C\D58C;
                      db $40,$30,$BE,$0E,$48,$30,$AD,$0E  ;;    |D594/D594\D594;
                      db $50,$30,$98,$0E,$58,$30,$8C,$0E  ;;    |D59C/D59C\D59C;
                      db $68,$30,$A0,$0E,$70,$30,$AB,$0E  ;;    |D5A4/D5A4\D5A4;
                      db $78,$30,$99,$0E,$80,$30,$9E,$0E  ;;    |D5AC/D5AC\D5AC;
                      db $88,$30,$8A,$0E,$90,$30,$8C,$0E  ;;    |D5B4/D5B4\D5B4;
                      db $98,$30,$AC,$0E,$A0,$30,$AC,$0E  ;;    |D5BC/D5BC\D5BC;
                      db $A8,$30,$BE,$0E,$B0,$30,$B0,$0E  ;;    |D5C4/D5C4\D5C4;
                      db $B8,$30,$A8,$0E,$C0,$30,$AC,$0E  ;;    |D5CC/D5CC\D5CC;
                      db $C8,$30,$98,$0E,$D0,$30,$99,$0E  ;;    |D5D4/D5D4\D5D4;
                      db $D8,$30,$BE,$0E,$18,$40,$88,$0E  ;;    |D5DC/D5DC\D5DC;
                      db $20,$40,$9E,$0E,$28,$40,$8B,$0E  ;;    |D5E4/D5E4\D5E4;
                      db $38,$40,$98,$0E,$40,$40,$99,$0E  ;;    |D5EC/D5EC\D5EC;
                      db $48,$40,$AC,$0E,$58,$40,$8D,$0E  ;;    |D5F4/D5F4\D5F4;
                      db $60,$40,$AB,$0E,$68,$40,$99,$0E  ;;    |D5FC/D5FC\D5FC;
                      db $70,$40,$8C,$0E,$78,$40,$9E,$0E  ;;    |D604/D604\D604;
                      db $80,$40,$8B,$0E,$88,$40,$AC,$0E  ;;    |D60C/D60C\D60C;
                      db $98,$40,$88,$0E,$A0,$40,$AB,$0E  ;;    |D614/D614\D614;
                      db $A8,$40,$8C,$0E,$B8,$40,$8E,$0E  ;;    |D61C/D61C\D61C;
                      db $C0,$40,$A8,$0E,$C8,$40,$99,$0E  ;;    |D624/D624\D624;
                      db $D0,$40,$9E,$0E,$D8,$40,$8E,$0E  ;;    |D62C/D62C\D62C;
                      db $18,$50,$AD,$0E,$20,$50,$A8,$0E  ;;    |D634/D634\D634;
                      db $30,$50,$AD,$0E,$38,$50,$88,$0E  ;;    |D63C/D63C\D63C;
                      db $40,$50,$9B,$0E,$48,$50,$8C,$0E  ;;    |D644/D644\D644;
                      db $58,$50,$88,$0E,$68,$50,$AF,$0E  ;;    |D64C/D64C\D64C;
                      db $70,$50,$88,$0E,$78,$50,$8A,$0E  ;;    |D654/D654\D654;
                      db $80,$50,$88,$0E,$88,$50,$AD,$0E  ;;    |D65C/D65C\D65C;
                      db $90,$50,$99,$0E,$98,$50,$A8,$0E  ;;    |D664/D664\D664;
                      db $A0,$50,$9E,$0E,$A8,$50,$BD,$0E  ;;    |D66C/D66C\D66C;
                   endif                        ;/ ENDIF  ;;+++++++++++++++++++;
                                                          ;;                   ;
CODE_03D674:          PHX                                 ;;D656|D674/D674\D674;
                      REP #$30                            ;;D657|D675/D675\D675; Index (16 bit) Accum (16 bit) 
                      LDX.W !FinalMessageTimer            ;;D659|D677/D677\D677;
                      BEQ CODE_03D6A8                     ;;D65C|D67A/D67A\D67A;
                      DEX                                 ;;D65E|D67C/D67C\D67C;
                      LDY.W #$0000                        ;;D65F|D67D/D67D\D67D;
                    - PHX                                 ;;D662|D680/D680\D680;
                      TXA                                 ;;D663|D681/D681\D681;
                      ASL A                               ;;D664|D682/D682\D682;
                      ASL A                               ;;D665|D683/D683\D683;
                      TAX                                 ;;D666|D684/D684\D684;
                      LDA.W DATA_03D524,X                 ;;D667|D685/D685\D685;
                      STA.W !OAMTileXPos,Y                ;;D66A|D688/D688\D688;
                      LDA.W DATA_03D524+2,X               ;;D66D|D68B/D68B\D68B;
                      STA.W !OAMTileNo,Y                  ;;D670|D68E/D68E\D68E;
                      PHY                                 ;;D673|D691/D691\D691;
                      TYA                                 ;;D674|D692/D692\D692;
                      LSR A                               ;;D675|D693/D693\D693;
                      LSR A                               ;;D676|D694/D694\D694;
                      TAY                                 ;;D677|D695/D695\D695;
                      SEP #$20                            ;;D678|D696/D696\D696; Accum (8 bit) 
                      LDA.B #$00                          ;;D67A|D698/D698\D698;
                      STA.W !OAMTileSize,Y                ;;D67C|D69A/D69A\D69A;
                      REP #$20                            ;;D67F|D69D/D69D\D69D; Accum (16 bit) 
                      PLY                                 ;;D681|D69F/D69F\D69F;
                      PLX                                 ;;D682|D6A0/D6A0\D6A0;
                      INY                                 ;;D683|D6A1/D6A1\D6A1;
                      INY                                 ;;D684|D6A2/D6A2\D6A2;
                      INY                                 ;;D685|D6A3/D6A3\D6A3;
                      INY                                 ;;D686|D6A4/D6A4\D6A4;
                      DEX                                 ;;D687|D6A5/D6A5\D6A5;
                      BPL -                               ;;D688|D6A6/D6A6\D6A6;
CODE_03D6A8:          SEP #$30                            ;;D68A|D6A8/D6A8\D6A8; Index (8 bit) Accum (8 bit) 
                      PLX                                 ;;D68C|D6AA/D6AA\D6AA;
                      RTS                                 ;;D68D|D6AB/D6AB\D6AB; Return 
                                                          ;;                   ;
                      %insert_empty($72,$54,$54,$54)      ;;D68E|D6AC/D6AC\D6AC;
                                                          ;;                   ;
DATA_03D700:          db $B0,$A0,$90,$80,$70,$60,$50,$40  ;;D700|D700/D700\D700;
                      db $30,$20,$10,$00                  ;;D708|D708/D708\D708;
                                                          ;;                   ;
CODE_03D70C:          PHX                                 ;;D70C|D70C/D70C\D70C;
                      LDA.W !SpriteMisc151C+4             ;;D70D|D70D/D70D\D70D; \ Return if less than 2 reznors killed 
                      CLC                                 ;;D710|D710/D710\D710;  | 
                      ADC.W !SpriteMisc151C+5             ;;D711|D711/D711\D711;  | 
                      ADC.W !SpriteMisc151C+6             ;;D714|D714/D714\D714;  | 
                      ADC.W !SpriteMisc151C+7             ;;D717|D717/D717\D717;  | 
                      CMP.B #$02                          ;;D71A|D71A/D71A\D71A;  | 
                      BCC CODE_03D757                     ;;D71C|D71C/D71C\D71C; / 
                      LDX.W !ReznorBridgeCount            ;;D71E|D71E/D71E\D71E;
                      CPX.B #$0C                          ;;D721|D721/D721\D721;
                      BCS CODE_03D757                     ;;D723|D723/D723\D723;
                      LDA.L DATA_03D700,X                 ;;D725|D725/D725\D725;
                      STA.B !TouchBlockXPos               ;;D729|D729/D729\D729;
                      STZ.B !TouchBlockXPos+1             ;;D72B|D72B/D72B\D72B;
                      LDA.B #$B0                          ;;D72D|D72D/D72D\D72D;
                      STA.B !TouchBlockYPos               ;;D72F|D72F/D72F\D72F;
                      STZ.B !TouchBlockYPos+1             ;;D731|D731/D731\D731;
                      LDA.W !ReznorBridgeTimer            ;;D733|D733/D733\D733;
                      BEQ CODE_03D74A                     ;;D736|D736/D736\D736;
                      CMP.B #$3C                          ;;D738|D738/D738\D738;
                      BNE CODE_03D757                     ;;D73A|D73A/D73A\D73A;
                      JSR CODE_03D77F                     ;;D73C|D73C/D73C\D73C;
                      JSR CODE_03D759                     ;;D73F|D73F/D73F\D73F;
                      JSR CODE_03D77F                     ;;D742|D742/D742\D742;
                      INC.W !ReznorBridgeCount            ;;D745|D745/D745\D745;
                      BRA CODE_03D757                     ;;D748|D748/D748\D748;
                                                          ;;                   ;
CODE_03D74A:          JSR CODE_03D766                     ;;D74A|D74A/D74A\D74A;
                      LDA.B #$40                          ;;D74D|D74D/D74D\D74D;
                      STA.W !ReznorBridgeTimer            ;;D74F|D74F/D74F\D74F;
                      LDA.B #$07                          ;;D752|D752/D752\D752;
                      STA.W !SPCIO3                       ;;D754|D754/D754\D754; / Play sound effect 
CODE_03D757:          PLX                                 ;;D757|D757/D757\D757;
                      RTL                                 ;;D758|D758/D758\D758; Return 
                                                          ;;                   ;
CODE_03D759:          REP #$20                            ;;D759|D759/D759\D759; Accum (16 bit) 
                      LDA.W #$0170                        ;;D75B|D75B/D75B\D75B;
                      SEC                                 ;;D75E|D75E/D75E\D75E;
                      SBC.B !TouchBlockXPos               ;;D75F|D75F/D75F\D75F;
                      STA.B !TouchBlockXPos               ;;D761|D761/D761\D761;
                      SEP #$20                            ;;D763|D763/D763\D763; Accum (8 bit) 
                      RTS                                 ;;D765|D765/D765\D765; Return 
                                                          ;;                   ;
CODE_03D766:          JSR CODE_03D76C                     ;;D766|D766/D766\D766;
                      JSR CODE_03D759                     ;;D769|D769/D769\D769;
CODE_03D76C:          REP #$20                            ;;D76C|D76C/D76C\D76C; Accum (16 bit) 
                      LDA.B !TouchBlockXPos               ;;D76E|D76E/D76E\D76E;
                      SEC                                 ;;D770|D770/D770\D770;
                      SBC.B !Layer1XPos                   ;;D771|D771/D771\D771;
                      CMP.W #$0100                        ;;D773|D773/D773\D773;
                      SEP #$20                            ;;D776|D776/D776\D776; Accum (8 bit) 
                      BCS +                               ;;D778|D778/D778\D778;
                      JSL CODE_028A44                     ;;D77A|D77A/D77A\D77A;
                    + RTS                                 ;;D77E|D77E/D77E\D77E; Return 
                                                          ;;                   ;
CODE_03D77F:          LDA.B !TouchBlockXPos               ;;D77F|D77F/D77F\D77F;
                      LSR A                               ;;D781|D781/D781\D781;
                      LSR A                               ;;D782|D782/D782\D782;
                      LSR A                               ;;D783|D783/D783\D783;
                      STA.B !_1                           ;;D784|D784/D784\D784;
                      LSR A                               ;;D786|D786/D786\D786;
                      ORA.B !TouchBlockYPos               ;;D787|D787/D787\D787;
                      REP #$20                            ;;D789|D789/D789\D789; Accum (16 bit) 
                      AND.W #$00FF                        ;;D78B|D78B/D78B\D78B;
                      LDX.B !TouchBlockXPos+1             ;;D78E|D78E/D78E\D78E;
                      BEQ +                               ;;D790|D790/D790\D790;
                      CLC                                 ;;D792|D792/D792\D792;
                      ADC.W #$01B0                        ;;D793|D793/D793\D793;
                      LDX.B #$04                          ;;D796|D796/D796\D796;
                    + STX.B !_0                           ;;D798|D798/D798\D798;
                      REP #$10                            ;;D79A|D79A/D79A\D79A; Index (16 bit) 
                      TAX                                 ;;D79C|D79C/D79C\D79C;
                      SEP #$20                            ;;D79D|D79D/D79D\D79D; Accum (8 bit) 
                      LDA.B #$25                          ;;D79F|D79F/D79F\D79F;
                      STA.L !Map16TilesLow,X              ;;D7A1|D7A1/D7A1\D7A1;
                      LDA.B #$00                          ;;D7A5|D7A5/D7A5\D7A5;
                      STA.L !Map16TilesHigh,X             ;;D7A7|D7A7/D7A7\D7A7;
                      REP #$20                            ;;D7AB|D7AB/D7AB\D7AB; Accum (16 bit) 
                      LDA.L !DynStripeImgSize             ;;D7AD|D7AD/D7AD\D7AD;
                      TAX                                 ;;D7B1|D7B1/D7B1\D7B1;
                      LDA.W #$C05A                        ;;D7B2|D7B2/D7B2\D7B2;
                      CLC                                 ;;D7B5|D7B5/D7B5\D7B5;
                      ADC.B !_0                           ;;D7B6|D7B6/D7B6\D7B6;
                      STA.L !DynamicStripeImage,X         ;;D7B8|D7B8/D7B8\D7B8;
                      ORA.W #$2000                        ;;D7BC|D7BC/D7BC\D7BC;
                      STA.L !DynamicStripeImage+6,X       ;;D7BF|D7BF/D7BF\D7BF;
                      LDA.W #$0240                        ;;D7C3|D7C3/D7C3\D7C3;
                      STA.L !DynamicStripeImage+2,X       ;;D7C6|D7C6/D7C6\D7C6;
                      STA.L !DynamicStripeImage+8,X       ;;D7CA|D7CA/D7CA\D7CA;
                      LDA.W #$38FC                        ;;D7CE|D7CE/D7CE\D7CE;
                      STA.L !DynamicStripeImage+4,X       ;;D7D1|D7D1/D7D1\D7D1;
                      STA.L !DynamicStripeImage+$0A,X     ;;D7D5|D7D5/D7D5\D7D5;
                      LDA.W #$00FF                        ;;D7D9|D7D9/D7D9\D7D9;
                      STA.L !DynamicStripeImage+$0C,X     ;;D7DC|D7DC/D7DC\D7DC;
                      TXA                                 ;;D7E0|D7E0/D7E0\D7E0;
                      CLC                                 ;;D7E1|D7E1/D7E1\D7E1;
                      ADC.W #$000C                        ;;D7E2|D7E2/D7E2\D7E2;
                      STA.L !DynStripeImgSize             ;;D7E5|D7E5/D7E5\D7E5;
                      SEP #$30                            ;;D7E9|D7E9/D7E9\D7E9; Index (8 bit) Accum (8 bit) 
                      RTS                                 ;;D7EB|D7EB/D7EB\D7EB; Return 
                                                          ;;                   ;
                                                          ;;                   ;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D7EC|D7EC/D7EC\D7EC;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D7F4|D7F4/D7F4\D7F4;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D7FC|D7FC/D7FC\D7FC;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D804|D804/D804\D804;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D80C|D80C/D80C\D80C;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D814|D814/D814\D814;
                      db $00,$00,$15,$16,$17,$18,$17,$18  ;;D81C|D81C/D81C\D81C;
                      db $17,$18,$17,$18,$19,$1A,$00,$00  ;;D824|D824/D824\D824;
                      db $00,$00,$01,$02,$03,$04,$03,$04  ;;D82C|D82C/D82C\D82C;
                      db $03,$04,$03,$04,$05,$12,$00,$00  ;;D834|D834/D834\D834;
                      db $00,$00,$00,$07,$04,$03,$04,$03  ;;D83C|D83C/D83C\D83C;
                      db $04,$03,$04,$03,$08,$00,$00,$00  ;;D844|D844/D844\D844;
                      db $00,$00,$00,$09,$0A,$04,$03,$04  ;;D84C|D84C/D84C\D84C;
                      db $03,$04,$03,$0B,$0C,$00,$00,$00  ;;D854|D854/D854\D854;
                      db $00,$00,$00,$00,$0D,$0E,$04,$03  ;;D85C|D85C/D85C\D85C;
                      db $04,$03,$0F,$10,$00,$00,$00,$00  ;;D864|D864/D864\D864;
                      db $00,$00,$00,$00,$11,$02,$03,$04  ;;D86C|D86C/D86C\D86C;
                      db $03,$04,$05,$12,$00,$00,$00,$00  ;;D874|D874/D874\D874;
                      db $00,$00,$00,$00,$00,$07,$04,$03  ;;D87C|D87C/D87C\D87C;
                      db $04,$03,$08,$00,$00,$00,$00,$00  ;;D884|D884/D884\D884;
                      db $00,$00,$00,$00,$00,$09,$0A,$04  ;;D88C|D88C/D88C\D88C;
                      db $03,$0B,$0C,$00,$00,$00,$00,$00  ;;D894|D894/D894\D894;
                      db $00,$00,$00,$00,$00,$00,$13,$03  ;;D89C|D89C/D89C\D89C;
                      db $04,$14,$00,$00,$00,$00,$00,$00  ;;D8A4|D8A4/D8A4\D8A4;
                      db $00,$00,$00,$00,$00,$00,$00,$13  ;;D8AC|D8AC/D8AC\D8AC;
                      db $14,$00,$00,$00,$00,$00,$00,$00  ;;D8B4|D8B4/D8B4\D8B4;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D8BC|D8BC/D8BC\D8BC;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D8C4|D8C4/D8C4\D8C4;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D8CC|D8CC/D8CC\D8CC;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D8D4|D8D4/D8D4\D8D4;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D8DC|D8DC/D8DC\D8DC;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;D8E4|D8E4/D8E4\D8E4;
DATA_03D8EC:          db $FF,$FF                          ;;D8EC|D8EC/D8EC\D8EC;
                                                          ;;                   ;
DATA_03D8EE:          db $FF,$FF,$FF,$FF,$24,$34,$25,$0B  ;;D8EE|D8EE/D8EE\D8EE;
                      db $26,$36,$0E,$1B,$0C,$1C,$0D,$1D  ;;D8F6|D8F6/D8F6\D8F6;
                      db $0E,$1E,$29,$39,$2A,$3A,$2B,$3B  ;;D8FE|D8FE/D8FE\D8FE;
                      db $26,$38,$20,$30,$21,$31,$27,$37  ;;D906|D906/D906\D906;
                      db $28,$38,$FF,$FF,$22,$32,$0E,$33  ;;D90E|D90E/D90E\D90E;
                      db $0C,$1C,$0D,$1D,$0E,$3C,$2D,$3D  ;;D916|D916/D916\D916;
                      db $FF,$FF,$07,$17,$0E,$23,$0E,$04  ;;D91E|D91E/D91E\D91E;
                      db $0C,$1C,$0D,$1D,$0E,$09,$0E,$2C  ;;D926|D926/D926\D926;
                      db $0A,$1A,$FF,$FF,$24,$34,$2B,$3B  ;;D92E|D92E/D92E\D92E;
                      db $FF,$FF,$07,$17,$0E,$18,$0E,$19  ;;D936|D936/D936\D936;
                      db $0A,$1A,$02,$12,$03,$13,$03,$08  ;;D93E|D93E/D93E\D93E;
                      db $03,$05,$03,$05,$03,$14,$03,$15  ;;D946|D946/D946\D946;
                      db $03,$05,$03,$05,$03,$08,$03,$06  ;;D94E|D94E/D94E\D94E;
                      db $0F,$1F                          ;;D956|D956/D956\D956;
                                                          ;;                   ;
CODE_03D958:          REP #$10                            ;;D958|D958/D958\D958; Index (16 bit) 
                      STZ.W !HW_VMAINC                    ;;D95A|D95A/D95A\D95A; VRAM Address Increment Value
                      STZ.W !HW_VMADD                     ;;D95D|D95D/D95D\D95D; Address for VRAM Read/Write (Low Byte)
                      STZ.W !HW_VMADD+1                   ;;D960|D960/D960\D960; Address for VRAM Read/Write (High Byte)
                      LDX.W #$4000                        ;;D963|D963/D963\D963;
                      LDA.B #$FF                          ;;D966|D966/D966\D966;
                    - STA.W !HW_VMDATA                    ;;D968|D968/D968\D968; Data for VRAM Write (Low Byte)
                      DEX                                 ;;D96B|D96B/D96B\D96B;
                      BNE -                               ;;D96C|D96C/D96C\D96C;
                      SEP #$10                            ;;D96E|D96E/D96E\D96E; Index (8 bit) 
                      BIT.W !IRQNMICommand                ;;D970|D970/D970\D970;
                      BVS +                               ;;D973|D973/D973\D973;
                      PHB                                 ;;D975|D975/D975\D975;
                      PHK                                 ;;D976|D976/D976\D976;
                      PLB                                 ;;D977|D977/D977\D977;
                      LDA.B #$EC                          ;;D978|D978/D978\D978;
                      STA.B !_5                           ;;D97A|D97A/D97A\D97A;
                      LDA.B #$D7                          ;;D97C|D97C/D97C\D97C;
                      STA.B !_6                           ;;D97E|D97E/D97E\D97E;
                      LDA.B #$03                          ;;D980|D980/D980\D980;
                      STA.B !_7                           ;;D982|D982/D982\D982;
                      LDA.B #$10                          ;;D984|D984/D984\D984;
                      STA.B !_0                           ;;D986|D986/D986\D986;
                      LDA.B #$08                          ;;D988|D988/D988\D988;
                      STA.B !_1                           ;;D98A|D98A/D98A\D98A;
                      JSR CODE_03D991                     ;;D98C|D98C/D98C\D98C;
                      PLB                                 ;;D98F|D98F/D98F\D98F;
                    + RTL                                 ;;D990|D990/D990\D990; Return 
                                                          ;;                   ;
CODE_03D991:          STZ.W !HW_VMAINC                    ;;D991|D991/D991\D991; VRAM Address Increment Value
                      LDY.B #$00                          ;;D994|D994/D994\D994;
CODE_03D996:          STY.B !_2                           ;;D996|D996/D996\D996;
                      LDA.B #$00                          ;;D998|D998/D998\D998;
CODE_03D99A:          STA.B !_3                           ;;D99A|D99A/D99A\D99A;
                      LDA.B !_0                           ;;D99C|D99C/D99C\D99C;
                      STA.W !HW_VMADD                     ;;D99E|D99E/D99E\D99E; Address for VRAM Read/Write (Low Byte)
                      LDA.B !_1                           ;;D9A1|D9A1/D9A1\D9A1;
                      STA.W !HW_VMADD+1                   ;;D9A3|D9A3/D9A3\D9A3; Address for VRAM Read/Write (High Byte)
                      LDY.B !_2                           ;;D9A6|D9A6/D9A6\D9A6;
                      LDA.B #$10                          ;;D9A8|D9A8/D9A8\D9A8;
                      STA.B !_4                           ;;D9AA|D9AA/D9AA\D9AA;
                    - LDA.B [!_5],Y                       ;;D9AC|D9AC/D9AC\D9AC;
                      STA.W !GfxDecompOWAni,Y             ;;D9AE|D9AE/D9AE\D9AE;
                      ASL A                               ;;D9B1|D9B1/D9B1\D9B1;
                      ASL A                               ;;D9B2|D9B2/D9B2\D9B2;
                      ORA.B !_3                           ;;D9B3|D9B3/D9B3\D9B3;
                      TAX                                 ;;D9B5|D9B5/D9B5\D9B5;
                      %WorL_X(LDA,DATA_03D8EC)            ;;D9B6|D9B6/D9B6\D9B6;
                      STA.W !HW_VMDATA                    ;;D9B9|D9BA/D9BA\D9BA; Data for VRAM Write (Low Byte)
                      %WorL_X(LDA,DATA_03D8EE)            ;;D9BC|D9BD/D9BD\D9BD;
                      STA.W !HW_VMDATA                    ;;D9BF|D9C1/D9C1\D9C1; Data for VRAM Write (Low Byte)
                      INY                                 ;;D9C2|D9C4/D9C4\D9C4;
                      DEC.B !_4                           ;;D9C3|D9C5/D9C5\D9C5;
                      BNE -                               ;;D9C5|D9C7/D9C7\D9C7;
                      LDA.B !_0                           ;;D9C7|D9C9/D9C9\D9C9;
                      CLC                                 ;;D9C9|D9CB/D9CB\D9CB;
                      ADC.B #$80                          ;;D9CA|D9CC/D9CC\D9CC;
                      STA.B !_0                           ;;D9CC|D9CE/D9CE\D9CE;
                      BCC +                               ;;D9CE|D9D0/D9D0\D9D0;
                      INC.B !_1                           ;;D9D0|D9D2/D9D2\D9D2;
                    + LDA.B !_3                           ;;D9D2|D9D4/D9D4\D9D4;
                      EOR.B #$01                          ;;D9D4|D9D6/D9D6\D9D6;
                      BNE CODE_03D99A                     ;;D9D6|D9D8/D9D8\D9D8;
                      TYA                                 ;;D9D8|D9DA/D9DA\D9DA;
                      BNE CODE_03D996                     ;;D9D9|D9DB/D9DB\D9DB;
                      RTS                                 ;;D9DB|D9DD/D9DD\D9DD; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03D9DE:          db $FF,$00,$FF,$FF,$02,$04,$06,$FF  ;;D9DC|D9DE/D9DE\D9DE;
                      db $08,$0A,$0C,$FF,$0E,$10,$12,$FF  ;;D9E4|D9E6/D9E6\D9E6;
                      db $FF,$00,$FF,$FF,$02,$04,$06,$FF  ;;D9EC|D9EE/D9EE\D9EE;
                      db $08,$0A,$0C,$FF,$0E,$14,$16,$FF  ;;D9F4|D9F6/D9F6\D9F6;
                      db $FF,$00,$FF,$FF,$02,$04,$06,$FF  ;;D9FC|D9FE/D9FE\D9FE;
                      db $08,$0A,$0C,$FF,$0E,$18,$1A,$FF  ;;DA04|DA06/DA06\DA06;
                      db $46,$48,$4A,$FF,$4C,$4E,$50,$FF  ;;DA0C|DA0E/DA0E\DA0E;
                      db $52,$54,$0C,$FF,$0E,$18,$1A,$FF  ;;DA14|DA16/DA16\DA16;
                      db $FF,$FF,$FF,$FF,$B2,$B4,$06,$FF  ;;DA1C|DA1E/DA1E\DA1E;
                      db $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF  ;;DA24|DA26/DA26\DA26;
                      db $FF,$1C,$FF,$FF,$1E,$20,$22,$FF  ;;DA2C|DA2E/DA2E\DA2E;
                      db $24,$26,$28,$FF,$FF,$2A,$2C,$FF  ;;DA34|DA36/DA36\DA36;
                      db $FF,$2E,$30,$FF,$32,$34,$35,$33  ;;DA3C|DA3E/DA3E\DA3E;
                      db $36,$38,$39,$37,$42,$44,$45,$43  ;;DA44|DA46/DA46\DA46;
                      db $FF,$2E,$30,$FF,$32,$34,$35,$33  ;;DA4C|DA4E/DA4E\DA4E;
                      db $36,$38,$39,$37,$42,$44,$45,$43  ;;DA54|DA56/DA56\DA56;
                      db $FF,$2E,$30,$FF,$32,$34,$35,$33  ;;DA5C|DA5E/DA5E\DA5E;
                      db $36,$38,$39,$37,$3E,$40,$41,$3F  ;;DA64|DA66/DA66\DA66;
                      db $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF  ;;DA6C|DA6E/DA6E\DA6E;
                      db $08,$0A,$0C,$FF,$0E,$10,$12,$FF  ;;DA74|DA76/DA76\DA76;
                      db $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF  ;;DA7C|DA7E/DA7E\DA7E;
                      db $08,$0A,$0C,$FF,$0E,$14,$16,$FF  ;;DA84|DA86/DA86\DA86;
                      db $5A,$FF,$FF,$FF,$5C,$5E,$06,$FF  ;;DA8C|DA8E/DA8E\DA8E;
                      db $08,$0A,$0C,$FF,$0E,$18,$1A,$FF  ;;DA94|DA96/DA96\DA96;
                      db $6C,$6E,$FF,$FF,$72,$74,$50,$FF  ;;DA9C|DA9E/DA9E\DA9E;
                      db $52,$54,$0C,$FF,$0E,$18,$1A,$FF  ;;DAA4|DAA6/DAA6\DAA6;
                      db $FF,$BE,$FF,$FF,$DC,$DE,$06,$FF  ;;DAAC|DAAE/DAAE\DAAE;
                      db $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF  ;;DAB4|DAB6/DAB6\DAB6;
                      db $60,$62,$FF,$FF,$64,$66,$22,$FF  ;;DABC|DABE/DABE\DABE;
                      db $24,$26,$28,$FF,$FF,$2A,$2C,$FF  ;;DAC4|DAC6/DAC6\DAC6;
                      db $FF,$68,$69,$FF,$32,$6A,$6B,$33  ;;DACC|DACE/DACE\DACE;
                      db $36,$38,$39,$37,$42,$44,$45,$43  ;;DAD4|DAD6/DAD6\DAD6;
                      db $FF,$68,$69,$FF,$32,$6A,$6B,$33  ;;DADC|DADE/DADE\DADE;
                      db $36,$38,$39,$37,$42,$44,$45,$43  ;;DAE4|DAE6/DAE6\DAE6;
                      db $FF,$68,$69,$FF,$32,$6A,$6B,$33  ;;DAEC|DAEE/DAEE\DAEE;
                      db $36,$38,$39,$37,$3E,$40,$41,$3F  ;;DAF4|DAF6/DAF6\DAF6;
                      db $7A,$7C,$FF,$FF,$7E,$80,$82,$FF  ;;DAFC|DAFE/DAFE\DAFE;
                      db $84,$86,$0C,$FF,$0E,$10,$12,$FF  ;;DB04|DB06/DB06\DB06;
                      db $7A,$7C,$FF,$FF,$7E,$80,$06,$FF  ;;DB0C|DB0E/DB0E\DB0E;
                      db $84,$86,$0C,$FF,$0E,$14,$16,$FF  ;;DB14|DB16/DB16\DB16;
                      db $7A,$7C,$FF,$FF,$7E,$80,$06,$FF  ;;DB1C|DB1E/DB1E\DB1E;
                      db $84,$86,$0C,$FF,$0E,$18,$1A,$FF  ;;DB24|DB26/DB26\DB26;
                      db $A0,$A2,$A4,$FF,$A6,$A8,$AA,$FF  ;;DB2C|DB2E/DB2E\DB2E;
                      db $52,$54,$0C,$FF,$0E,$18,$1A,$FF  ;;DB34|DB36/DB36\DB36;
                      db $FF,$B8,$FF,$FF,$D6,$D8,$DA,$FF  ;;DB3C|DB3E/DB3E\DB3E;
                      db $D2,$D4,$0C,$FF,$0E,$18,$1A,$FF  ;;DB44|DB46/DB46\DB46;
                      db $88,$8A,$8C,$FF,$8E,$90,$92,$FF  ;;DB4C|DB4E/DB4E\DB4E;
                      db $94,$96,$28,$FF,$FF,$2A,$2C,$FF  ;;DB54|DB56/DB56\DB56;
                      db $98,$9A,$9B,$99,$9C,$9E,$9F,$9D  ;;DB5C|DB5E/DB5E\DB5E;
                      db $36,$38,$39,$37,$42,$44,$45,$43  ;;DB64|DB66/DB66\DB66;
                      db $98,$9A,$9B,$99,$9C,$9E,$9F,$9D  ;;DB6C|DB6E/DB6E\DB6E;
                      db $36,$38,$39,$37,$42,$44,$45,$43  ;;DB74|DB76/DB76\DB76;
                      db $98,$9A,$9B,$99,$9C,$9E,$9F,$9D  ;;DB7C|DB7E/DB7E\DB7E;
                      db $36,$38,$39,$37,$3E,$40,$41,$3F  ;;DB84|DB86/DB86\DB86;
                      db $FF,$FF,$FF,$FF,$FF,$CC,$FF,$FF  ;;DB8C|DB8E/DB8E\DB8E;
                      db $C0,$C2,$C4,$FF,$E0,$E2,$E4,$FF  ;;DB94|DB96/DB96\DB96;
                      db $FF,$FF,$FF,$FF,$FF,$CC,$FF,$FF  ;;DB9C|DB9E/DB9E\DB9E;
                      db $C6,$C8,$CA,$FF,$E6,$E8,$EA,$FF  ;;DBA4|DBA6/DBA6\DBA6;
                      db $FF,$FF,$FF,$FF,$FF,$CD,$FF,$FF  ;;DBAC|DBAE/DBAE\DBAE;
                      db $C5,$C3,$C1,$FF,$E5,$E3,$E1,$FF  ;;DBB4|DBB6/DBB6\DBB6;
                      db $FF,$90,$92,$94,$96,$FF,$FF,$FF  ;;DBBC|DBBE/DBBE\DBBE;
                      db $FF,$B0,$B2,$B4,$B6,$38,$FF,$FF  ;;DBC4|DBC6/DBC6\DBC6;
                      db $FF,$D0,$D2,$D4,$D6,$58,$5A,$FF  ;;DBCC|DBCE/DBCE\DBCE;
                      db $FF,$F0,$F2,$F4,$F6,$78,$7A,$FF  ;;DBD4|DBD6/DBD6\DBD6;
                      db $FF,$90,$92,$94,$96,$FF,$FF,$FF  ;;DBDC|DBDE/DBDE\DBDE;
                      db $FF,$98,$9A,$9C,$B6,$38,$FF,$FF  ;;DBE4|DBE6/DBE6\DBE6;
                      db $FF,$D0,$D2,$D4,$D6,$58,$5A,$FF  ;;DBEC|DBEE/DBEE\DBEE;
                      db $FF,$F0,$F2,$F4,$F6,$78,$7A,$FF  ;;DBF4|DBF6/DBF6\DBF6;
                      db $FF,$90,$92,$94,$96,$FF,$FF,$FF  ;;DBFC|DBFE/DBFE\DBFE;
                      db $FF,$98,$BA,$BC,$B6,$38,$FF,$FF  ;;DC04|DC06/DC06\DC06;
                      db $FF,$D8,$DA,$DC,$D6,$58,$5A,$FF  ;;DC0C|DC0E/DC0E\DC0E;
                      db $FF,$F8,$FA,$FC,$F6,$78,$7A,$FF  ;;DC14|DC16/DC16\DC16;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC1C|DC1E/DC1E\DC1E;
                      db $FF,$FF,$90,$92,$94,$96,$FF,$FF  ;;DC24|DC26/DC26\DC26;
                      db $FF,$FF,$98,$BA,$BC,$B6,$38,$FF  ;;DC2C|DC2E/DC2E\DC2E;
                      db $FF,$FF,$D8,$DA,$DC,$D6,$58,$5A  ;;DC34|DC36/DC36\DC36;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC3C|DC3E/DC3E\DC3E;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC44|DC46/DC46\DC46;
                      db $FF,$FF,$90,$92,$94,$96,$FF,$FF  ;;DC4C|DC4E/DC4E\DC4E;
                      db $FF,$FF,$98,$BA,$BC,$B6,$38,$FF  ;;DC54|DC56/DC56\DC56;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC5C|DC5E/DC5E\DC5E;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC64|DC66/DC66\DC66;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC6C|DC6E/DC6E\DC6E;
                      db $FF,$FF,$90,$92,$94,$96,$FF,$FF  ;;DC74|DC76/DC76\DC76;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC7C|DC7E/DC7E\DC7E;
                      db $FF,$90,$92,$94,$96,$FF,$FF,$FF  ;;DC84|DC86/DC86\DC86;
                      db $FF,$98,$BA,$BC,$B6,$38,$FF,$FF  ;;DC8C|DC8E/DC8E\DC8E;
                      db $FF,$D8,$DA,$DC,$D6,$58,$5A,$FF  ;;DC94|DC96/DC96\DC96;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DC9C|DC9E/DC9E\DC9E;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DCA4|DCA6/DCA6\DCA6;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DCAC|DCAE/DCAE\DCAE;
                      db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;;DCB4|DCB6/DCB6\DCB6;
                      db $04,$06,$08,$0A,$0B,$09,$07,$05  ;;DCBC|DCBE/DCBE\DCBE;
                      db $24,$26,$28,$2A,$2C,$29,$27,$25  ;;DCC4|DCC6/DCC6\DCC6;
                      db $FF,$84,$86,$88,$89,$87,$85,$FF  ;;DCCC|DCCE/DCCE\DCCE;
                      db $FF,$A4,$A6,$A8,$A9,$A7,$A5,$FF  ;;DCD4|DCD6/DCD6\DCD6;
                      db $04,$06,$08,$0A,$0B,$09,$07,$05  ;;DCDC|DCDE/DCDE\DCDE;
                      db $24,$26,$28,$2D,$2B,$29,$27,$25  ;;DCE4|DCE6/DCE6\DCE6;
                      db $FF,$84,$86,$88,$89,$87,$85,$FF  ;;DCEC|DCEE/DCEE\DCEE;
                      db $FF,$A4,$A6,$0C,$0D,$A7,$A5,$FF  ;;DCF4|DCF6/DCF6\DCF6;
                      db $80,$82,$83,$8A,$82,$83,$8C,$8E  ;;DCFC|DCFE/DCFE\DCFE;
                      db $A0,$A2,$A3,$C4,$A2,$A3,$AC,$AE  ;;DD04|DD06/DD06\DD06;
                      db $80,$8A,$8A,$8A,$8A,$8A,$8C,$8E  ;;DD0C|DD0E/DD0E\DD0E;
                      db $A0,$60,$61,$C4,$60,$61,$AC,$AE  ;;DD14|DD16/DD16\DD16;
                      db $80,$03,$01,$8A,$00,$02,$8C,$8E  ;;DD1C|DD1E/DD1E\DD1E;
                      db $A0,$23,$21,$C4,$20,$22,$AC,$AE  ;;DD24|DD26/DD26\DD26;
                      db $80,$00,$02,$8A,$03,$01,$AA,$8E  ;;DD2C|DD2E/DD2E\DD2E;
                      db $A0,$20,$22,$C4,$23,$21,$AC,$AE  ;;DD34|DD36/DD36\DD36;
                      db $C0,$C2,$C4,$C4,$C4,$CA,$CC,$CE  ;;DD3C|DD3E/DD3E\DD3E;
                      db $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE  ;;DD44|DD46/DD46\DD46;
                      db $40,$42,$44,$46,$48,$4A,$4C,$4E  ;;DD4C|DD4E/DD4E\DD4E;
                      db $FF,$62,$64,$66,$68,$6A,$6C,$FF  ;;DD54|DD56/DD56\DD56;
                      db $10,$12,$14,$16,$18,$1A,$1C,$1E  ;;DD5C|DD5E/DD5E\DD5E;
                      db $10,$30,$32,$34,$36,$1A,$1C,$1E  ;;DD64|DD66/DD66\DD66;
                                                          ;;                   ;
KoopaPalPtrLo:        db StandardColors+$6C               ;;DD6C|DD6E/DD6E\DD6E;
                      db StandardColors+$54               ;;DD6D|DD6F/DD6F\DD6F;
                      db StandardColors+$48               ;;DD6E|DD70/DD70\DD70;
                      db SpriteColors+$60                 ;;DD6F|DD71/DD71\DD71;
                      db SpriteColors+$54                 ;;DD70|DD72/DD72\DD72;
                                                          ;;                   ;
KoopaPalPtrHi:        db StandardColors+$6C>>8            ;;DD71|DD73/DD73\DD73;
                      db StandardColors+$54>>8            ;;DD72|DD74/DD74\DD74;
                      db StandardColors+$48>>8            ;;DD73|DD75/DD75\DD75;
                      db SpriteColors+$60>>8              ;;DD74|DD76/DD76\DD76;
                      db SpriteColors+$54>>8              ;;DD75|DD77/DD77\DD77;
                                                          ;;                   ;
DATA_03DD78:          db $0B,$0B,$0B,$21,$00              ;;DD76|DD78/DD78\DD78;
                                                          ;;                   ;
CODE_03DD7D:          PHX                                 ;;DD7B|DD7D/DD7D\DD7D;
                      PHB                                 ;;DD7C|DD7E/DD7E\DD7E;
                      PHK                                 ;;DD7D|DD7F/DD7F\DD7F;
                      PLB                                 ;;DD7E|DD80/DD80\DD80;
                      LDY.B !SpriteTableC2,X              ;;DD7F|DD81/DD81\DD81;
                      STY.W !ActiveBoss                   ;;DD81|DD83/DD83\DD83;
                      CPY.B #$04                          ;;DD84|DD86/DD86\DD86;
                      BNE +                               ;;DD86|DD88/DD88\DD88;
                      JSR CODE_03DE8E                     ;;DD88|DD8A/DD8A\DD8A;
                      LDA.B #$48                          ;;DD8B|DD8D/DD8D\DD8D;
                      STA.B !Mode7CenterY                 ;;DD8D|DD8F/DD8F\DD8F;
                      LDA.B #$14                          ;;DD8F|DD91/DD91\DD91;
                      STA.B !Mode7XScale                  ;;DD91|DD93/DD93\DD93;
                      STA.B !Mode7YScale                  ;;DD93|DD95/DD95\DD95;
                    + LDA.B #$FF                          ;;DD95|DD97/DD97\DD97;
                      STA.B !LevelScrLength               ;;DD97|DD99/DD99\DD99;
                      INC A                               ;;DD99|DD9B/DD9B\DD9B;
                      STA.B !LastScreenHoriz              ;;DD9A|DD9C/DD9C\DD9C;
                      LDY.W !ActiveBoss                   ;;DD9C|DD9E/DD9E\DD9E;
                      LDX.W DATA_03DD78,Y                 ;;DD9F|DDA1/DDA1\DDA1;
                      LDA.W KoopaPalPtrLo,Y               ;;DDA2|DDA4/DDA4\DDA4; \ $00 = Pointer in bank 0 (from above tables) 
                      STA.B !_0                           ;;DDA5|DDA7/DDA7\DDA7;  | 
                      LDA.W KoopaPalPtrHi,Y               ;;DDA7|DDA9/DDA9\DDA9;  | 
                      STA.B !_1                           ;;DDAA|DDAC/DDAC\DDAC;  | 
                      STZ.B !_2                           ;;DDAC|DDAE/DDAE\DDAE; / 
                      LDY.B #$0B                          ;;DDAE|DDB0/DDB0\DDB0; \ Read 0B bytes and put them in $0707 
                    - LDA.B [!_0],Y                       ;;DDB0|DDB2/DDB2\DDB2;  | 
                      STA.W !MainPalette+4,Y              ;;DDB2|DDB4/DDB4\DDB4;  | 
                      DEY                                 ;;DDB5|DDB7/DDB7\DDB7;  | 
                      BPL -                               ;;DDB6|DDB8/DDB8\DDB8; / 
                      LDA.B #$80                          ;;DDB8|DDBA/DDBA\DDBA;
                      STA.W !HW_VMAINC                    ;;DDBA|DDBC/DDBC\DDBC; VRAM Address Increment Value
                      STZ.W !HW_VMADD                     ;;DDBD|DDBF/DDBF\DDBF; Address for VRAM Read/Write (Low Byte)
                      STZ.W !HW_VMADD+1                   ;;DDC0|DDC2/DDC2\DDC2; Address for VRAM Read/Write (High Byte)
                      TXY                                 ;;DDC3|DDC5/DDC5\DDC5;
                      BEQ CODE_03DDD7                     ;;DDC4|DDC6/DDC6\DDC6;
                      JSL CODE_00BA28                     ;;DDC6|DDC8/DDC8\DDC8;
                      LDA.B #$80                          ;;DDCA|DDCC/DDCC\DDCC;
                      STA.B !_3                           ;;DDCC|DDCE/DDCE\DDCE;
                    - JSR CODE_03DDE5                     ;;DDCE|DDD0/DDD0\DDD0;
                      DEC.B !_3                           ;;DDD1|DDD3/DDD3\DDD3;
                      BNE -                               ;;DDD3|DDD5/DDD5\DDD5;
CODE_03DDD7:          LDX.B #$5F                          ;;DDD5|DDD7/DDD7\DDD7;
                    - LDA.B #$FF                          ;;DDD7|DDD9/DDD9\DDD9;
                      STA.L !Mode7BossTilemap,X           ;;DDD9|DDDB/DDDB\DDDB;
                      DEX                                 ;;DDDD|DDDF/DDDF\DDDF;
                      BPL -                               ;;DDDE|DDE0/DDE0\DDE0;
                      PLB                                 ;;DDE0|DDE2/DDE2\DDE2;
                      PLX                                 ;;DDE1|DDE3/DDE3\DDE3;
                      RTL                                 ;;DDE2|DDE4/DDE4\DDE4; Return 
                                                          ;;                   ;
CODE_03DDE5:          LDX.B #$00                          ;;DDE3|DDE5/DDE5\DDE5;
                      TXY                                 ;;DDE5|DDE7/DDE7\DDE7;
                      LDA.B #$08                          ;;DDE6|DDE8/DDE8\DDE8;
                      STA.B !_5                           ;;DDE8|DDEA/DDEA\DDEA;
CODE_03DDEC:          JSR CODE_03DE39                     ;;DDEA|DDEC/DDEC\DDEC;
                      PHY                                 ;;DDED|DDEF/DDEF\DDEF;
                      TYA                                 ;;DDEE|DDF0/DDF0\DDF0;
                      LSR A                               ;;DDEF|DDF1/DDF1\DDF1;
                      CLC                                 ;;DDF0|DDF2/DDF2\DDF2;
                      ADC.B #$0F                          ;;DDF1|DDF3/DDF3\DDF3;
                      TAY                                 ;;DDF3|DDF5/DDF5\DDF5;
                      JSR CODE_03DE3C                     ;;DDF4|DDF6/DDF6\DDF6;
                      LDY.B #$08                          ;;DDF7|DDF9/DDF9\DDF9;
                    - LDA.W !Mode7GfxBuffer,X             ;;DDF9|DDFB/DDFB\DDFB;
                      ASL A                               ;;DDFC|DDFE/DDFE\DDFE;
                      ROL A                               ;;DDFD|DDFF/DDFF\DDFF;
                      ROL A                               ;;DDFE|DE00/DE00\DE00;
                      ROL A                               ;;DDFF|DE01/DE01\DE01;
                      AND.B #$07                          ;;DE00|DE02/DE02\DE02;
                      STA.W !Mode7GfxBuffer,X             ;;DE02|DE04/DE04\DE04;
                      STA.W !HW_VMDATA+1                  ;;DE05|DE07/DE07\DE07; Data for VRAM Write (High Byte)
                      INX                                 ;;DE08|DE0A/DE0A\DE0A;
                      DEY                                 ;;DE09|DE0B/DE0B\DE0B;
                      BNE -                               ;;DE0A|DE0C/DE0C\DE0C;
                      PLY                                 ;;DE0C|DE0E/DE0E\DE0E;
                      DEC.B !_5                           ;;DE0D|DE0F/DE0F\DE0F;
                      BNE CODE_03DDEC                     ;;DE0F|DE11/DE11\DE11;
                      LDA.B #$07                          ;;DE11|DE13/DE13\DE13;
CODE_03DE15:          TAX                                 ;;DE13|DE15/DE15\DE15;
                      LDY.B #$08                          ;;DE14|DE16/DE16\DE16;
                      STY.B !_5                           ;;DE16|DE18/DE18\DE18;
                    - LDY.W !Mode7GfxBuffer,X             ;;DE18|DE1A/DE1A\DE1A;
                      STY.W !HW_VMDATA+1                  ;;DE1B|DE1D/DE1D\DE1D; Data for VRAM Write (High Byte)
                      DEX                                 ;;DE1E|DE20/DE20\DE20;
                      DEC.B !_5                           ;;DE1F|DE21/DE21\DE21;
                      BNE -                               ;;DE21|DE23/DE23\DE23;
                      CLC                                 ;;DE23|DE25/DE25\DE25;
                      ADC.B #$08                          ;;DE24|DE26/DE26\DE26;
                      CMP.B #$40                          ;;DE26|DE28/DE28\DE28;
                      BCC CODE_03DE15                     ;;DE28|DE2A/DE2A\DE2A;
                      REP #$20                            ;;DE2A|DE2C/DE2C\DE2C; Accum (16 bit) 
                      LDA.B !_0                           ;;DE2C|DE2E/DE2E\DE2E;
                      CLC                                 ;;DE2E|DE30/DE30\DE30;
                      ADC.W #$0018                        ;;DE2F|DE31/DE31\DE31;
                      STA.B !_0                           ;;DE32|DE34/DE34\DE34;
                      SEP #$20                            ;;DE34|DE36/DE36\DE36; Accum (8 bit) 
                      RTS                                 ;;DE36|DE38/DE38\DE38; Return 
                                                          ;;                   ;
CODE_03DE39:          JSR CODE_03DE3C                     ;;DE37|DE39/DE39\DE39;
CODE_03DE3C:          PHX                                 ;;DE3A|DE3C/DE3C\DE3C;
                      LDA.B [!_0],Y                       ;;DE3B|DE3D/DE3D\DE3D;
                      PHY                                 ;;DE3D|DE3F/DE3F\DE3F;
                      LDY.B #$08                          ;;DE3E|DE40/DE40\DE40;
                    - ASL A                               ;;DE40|DE42/DE42\DE42;
                      ROR.W !Mode7GfxBuffer,X             ;;DE41|DE43/DE43\DE43;
                      INX                                 ;;DE44|DE46/DE46\DE46;
                      DEY                                 ;;DE45|DE47/DE47\DE47;
                      BNE -                               ;;DE46|DE48/DE48\DE48;
                      PLY                                 ;;DE48|DE4A/DE4A\DE4A;
                      INY                                 ;;DE49|DE4B/DE4B\DE4B;
                      PLX                                 ;;DE4A|DE4C/DE4C\DE4C;
                      RTS                                 ;;DE4B|DE4D/DE4D\DE4D; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03DE4E:          db $40,$41,$42,$43,$44,$45,$46,$47  ;;DE4C|DE4E/DE4E\DE4E;
                      db $50,$51,$52,$53,$54,$55,$56,$57  ;;DE54|DE56/DE56\DE56;
                      db $60,$61,$62,$63,$64,$65,$66,$67  ;;DE5C|DE5E/DE5E\DE5E;
                      db $70,$71,$72,$73,$74,$75,$76,$77  ;;DE64|DE66/DE66\DE66;
                      db $48,$49,$4A,$4B,$4C,$4D,$4E,$4F  ;;DE6C|DE6E/DE6E\DE6E;
                      db $58,$59,$5A,$5B,$5C,$5D,$5E,$5F  ;;DE74|DE76/DE76\DE76;
                      db $68,$69,$6A,$6B,$6C,$6D,$6E,$6F  ;;DE7C|DE7E/DE7E\DE7E;
                      db $78,$79,$7A,$7B,$7C,$7D,$7E,$3F  ;;DE84|DE86/DE86\DE86;
                                                          ;;                   ;
CODE_03DE8E:          STZ.W !HW_VMAINC                    ;;DE8C|DE8E/DE8E\DE8E; VRAM Address Increment Value
                      REP #$20                            ;;DE8F|DE91/DE91\DE91; Accum (16 bit) 
                      LDA.W #$0A1C                        ;;DE91|DE93/DE93\DE93;
                      STA.B !_0                           ;;DE94|DE96/DE96\DE96;
                      LDX.B #$00                          ;;DE96|DE98/DE98\DE98;
CODE_03DE9A:          REP #$20                            ;;DE98|DE9A/DE9A\DE9A; Accum (16 bit) 
                      LDA.B !_0                           ;;DE9A|DE9C/DE9C\DE9C;
                      CLC                                 ;;DE9C|DE9E/DE9E\DE9E;
                      ADC.W #$0080                        ;;DE9D|DE9F/DE9F\DE9F;
                      STA.B !_0                           ;;DEA0|DEA2/DEA2\DEA2;
                      STA.W !HW_VMADD                     ;;DEA2|DEA4/DEA4\DEA4; Address for VRAM Read/Write (Low Byte)
                      SEP #$20                            ;;DEA5|DEA7/DEA7\DEA7; Accum (8 bit) 
                      LDY.B #$08                          ;;DEA7|DEA9/DEA9\DEA9;
                    - %WorL_X(LDA,DATA_03DE4E)            ;;DEA9|DEAB/DEAB\DEAB;
                      STA.W !HW_VMDATA                    ;;DEAC|DEAF/DEAF\DEAF; Data for VRAM Write (Low Byte)
                      INX                                 ;;DEAF|DEB2/DEB2\DEB2;
                      DEY                                 ;;DEB0|DEB3/DEB3\DEB3;
                      BNE -                               ;;DEB1|DEB4/DEB4\DEB4;
                      CPX.B #$40                          ;;DEB3|DEB6/DEB6\DEB6;
                      BCC CODE_03DE9A                     ;;DEB5|DEB8/DEB8\DEB8;
                      RTS                                 ;;DEB7|DEBA/DEBA\DEBA; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03DEBB:          db $00,$01,$10,$01                  ;;DEB8|DEBB/DEBB\DEBB;
                                                          ;;                   ;
DATA_03DEBF:          db $6E,$70,$FF,$50,$FE,$FE,$FF,$57  ;;DEBC|DEBF/DEBF\DEBF;
DATA_03DEC7:          db $72,$74,$52,$54,$3C,$3E,$55,$53  ;;DEC4|DEC7/DEC7\DEC7;
DATA_03DECF:          db $76,$56,$56,$FF,$FF,$FF,$51,$FF  ;;DECC|DECF/DECF\DECF;
DATA_03DED7:          db $20,$03,$30,$03,$40,$03,$50,$03  ;;DED4|DED7/DED7\DED7;
                                                          ;;                   ;
CODE_03DEDF:          PHB                                 ;;DEDC|DEDF/DEDF\DEDF;
                      PHK                                 ;;DEDD|DEE0/DEE0\DEE0;
                      PLB                                 ;;DEDE|DEE1/DEE1\DEE1;
                      LDA.W !SpriteYPosHigh,X             ;;DEDF|DEE2/DEE2\DEE2;
                      XBA                                 ;;DEE2|DEE5/DEE5\DEE5;
                      LDA.B !SpriteXPosLow,X              ;;DEE3|DEE6/DEE6\DEE6;
                      LDY.B #$00                          ;;DEE5|DEE8/DEE8\DEE8;
                      JSR CODE_03DFAE                     ;;DEE7|DEEA/DEEA\DEEA;
                      LDA.W !SpriteXPosHigh,X             ;;DEEA|DEED/DEED\DEED;
                      XBA                                 ;;DEED|DEF0/DEF0\DEF0;
                      LDA.B !SpriteYPosLow,X              ;;DEEE|DEF1/DEF1\DEF1;
                      LDY.B #$02                          ;;DEF0|DEF3/DEF3\DEF3;
                      JSR CODE_03DFAE                     ;;DEF2|DEF5/DEF5\DEF5;
                      PHX                                 ;;DEF5|DEF8/DEF8\DEF8;
                      REP #$30                            ;;DEF6|DEF9/DEF9\DEF9; Index (16 bit) Accum (16 bit) 
                      STZ.B !_6                           ;;DEF8|DEFB/DEFB\DEFB;
                      LDY.W #$0003                        ;;DEFA|DEFD/DEFD\DEFD;
                      LDA.W !IRQNMICommand                ;;DEFD|DF00/DF00\DF00;
                      LSR A                               ;;DF00|DF03/DF03\DF03;
                      BCC CODE_03DF44                     ;;DF01|DF04/DF04\DF04;
                      LDA.W !ClownCarPropeller            ;;DF03|DF06/DF06\DF06;
                      AND.W #$0003                        ;;DF06|DF09/DF09\DF09;
                      ASL A                               ;;DF09|DF0C/DF0C\DF0C;
                      TAX                                 ;;DF0A|DF0D/DF0D\DF0D;
                      %WorL_X(LDA,DATA_03DEBF)            ;;DF0B|DF0E/DF0E\DF0E;
                      STA.L !Mode7BossTilemap+1           ;;DF0E|DF12/DF12\DF12;
                      %WorL_X(LDA,DATA_03DEC7)            ;;DF12|DF16/DF16\DF16;
                      STA.L !Mode7BossTilemap+3           ;;DF15|DF1A/DF1A\DF1A;
                      %WorL_X(LDA,DATA_03DECF)            ;;DF19|DF1E/DF1E\DF1E;
                      STA.L !Mode7BossTilemap+5           ;;DF1C|DF22/DF22\DF22;
                      LDA.W #$0008                        ;;DF20|DF26/DF26\DF26;
                      STA.B !_6                           ;;DF23|DF29/DF29\DF29;
                      LDX.W #$0380                        ;;DF25|DF2B/DF2B\DF2B;
                      LDA.W !Mode7TileIndex               ;;DF28|DF2E/DF2E\DF2E;
                      AND.W #$007F                        ;;DF2B|DF31/DF31\DF31;
                      CMP.W #$002C                        ;;DF2E|DF34/DF34\DF34;
                      BCC +                               ;;DF31|DF37/DF37\DF37;
                      LDX.W #$0388                        ;;DF33|DF39/DF39\DF39;
                    + TXA                                 ;;DF36|DF3C/DF3C\DF3C;
                      LDX.W #$000A                        ;;DF37|DF3D/DF3D\DF3D;
                      LDY.W #$0007                        ;;DF3A|DF40/DF40\DF40;
                      SEC                                 ;;DF3D|DF43/DF43\DF43;
CODE_03DF44:          STY.B !_0                           ;;DF3E|DF44/DF44\DF44;
                      BCS CODE_03DF55                     ;;DF40|DF46/DF46\DF46;
CODE_03DF48:          LDA.W !Mode7TileIndex               ;;DF42|DF48/DF48\DF48;
                      AND.W #$007F                        ;;DF45|DF4B/DF4B\DF4B;
                      ASL A                               ;;DF48|DF4E/DF4E\DF4E;
                      ASL A                               ;;DF49|DF4F/DF4F\DF4F;
                      ASL A                               ;;DF4A|DF50/DF50\DF50;
                      ASL A                               ;;DF4B|DF51/DF51\DF51;
                      LDX.W #$0003                        ;;DF4C|DF52/DF52\DF52;
CODE_03DF55:          STX.B !_2                           ;;DF4F|DF55/DF55\DF55;
                      PHA                                 ;;DF51|DF57/DF57\DF57;
                      LDY.W !LevelLoadObjectTile          ;;DF52|DF58/DF58\DF58;
                      BPL +                               ;;DF55|DF5B/DF5B\DF5B;
                      CLC                                 ;;DF57|DF5D/DF5D\DF5D;
                      ADC.B !_0                           ;;DF58|DF5E/DF5E\DF5E;
                    + TAY                                 ;;DF5A|DF60/DF60\DF60;
                      SEP #$20                            ;;DF5B|DF61/DF61\DF61; Accum (8 bit) 
                      LDX.B !_6                           ;;DF5D|DF63/DF63\DF63;
                      LDA.B !_0                           ;;DF5F|DF65/DF65\DF65;
                      STA.B !_4                           ;;DF61|DF67/DF67\DF67;
CODE_03DF69:          LDA.W DATA_03D9DE,Y                 ;;DF63|DF69/DF69\DF69;
                      INY                                 ;;DF66|DF6C/DF6C\DF6C;
                      BIT.W !Mode7TileIndex               ;;DF67|DF6D/DF6D\DF6D;
                      BPL +                               ;;DF6A|DF70/DF70\DF70;
                      EOR.B #$01                          ;;DF6C|DF72/DF72\DF72;
                      DEY                                 ;;DF6E|DF74/DF74\DF74;
                      DEY                                 ;;DF6F|DF75/DF75\DF75;
                    + STA.L !Mode7BossTilemap,X           ;;DF70|DF76/DF76\DF76;
                      INX                                 ;;DF74|DF7A/DF7A\DF7A;
                      DEC.B !_4                           ;;DF75|DF7B/DF7B\DF7B;
                      BPL CODE_03DF69                     ;;DF77|DF7D/DF7D\DF7D;
                      STX.B !_6                           ;;DF79|DF7F/DF7F\DF7F;
                      REP #$20                            ;;DF7B|DF81/DF81\DF81; Accum (16 bit) 
                      PLA                                 ;;DF7D|DF83/DF83\DF83;
                      SEC                                 ;;DF7E|DF84/DF84\DF84;
                      ADC.B !_0                           ;;DF7F|DF85/DF85\DF85;
                      LDX.B !_2                           ;;DF81|DF87/DF87\DF87;
                      CPX.W #$0004                        ;;DF83|DF89/DF89\DF89;
                      BEQ CODE_03DF48                     ;;DF86|DF8C/DF8C\DF8C;
                      CPX.W #$0008                        ;;DF88|DF8E/DF8E\DF8E;
                      BNE +                               ;;DF8B|DF91/DF91\DF91;
                      LDA.W #$0360                        ;;DF8D|DF93/DF93\DF93;
                    + CPX.W #$000A                        ;;DF90|DF96/DF96\DF96;
                      BNE +                               ;;DF93|DF99/DF99\DF99;
                      LDA.W !ClownCarImage                ;;DF95|DF9B/DF9B\DF9B;
                      AND.W #$0003                        ;;DF98|DF9E/DF9E\DF9E;
                      ASL A                               ;;DF9B|DFA1/DFA1\DFA1;
                      TAY                                 ;;DF9C|DFA2/DFA2\DFA2;
                      LDA.W DATA_03DED7,Y                 ;;DF9D|DFA3/DFA3\DFA3;
                    + DEX                                 ;;DFA0|DFA6/DFA6\DFA6;
                      BPL CODE_03DF55                     ;;DFA1|DFA7/DFA7\DFA7;
                      SEP #$30                            ;;DFA3|DFA9/DFA9\DFA9; Index (8 bit) Accum (8 bit) 
                      PLX                                 ;;DFA5|DFAB/DFAB\DFAB;
                      PLB                                 ;;DFA6|DFAC/DFAC\DFAC;
                      RTL                                 ;;DFA7|DFAD/DFAD\DFAD; Return 
                                                          ;;                   ;
CODE_03DFAE:          PHX                                 ;;DFA8|DFAE/DFAE\DFAE;
                      TYX                                 ;;DFA9|DFAF/DFAF\DFAF;
                      REP #$20                            ;;DFAA|DFB0/DFB0\DFB0; Accum (16 bit) 
                      EOR.W #$FFFF                        ;;DFAC|DFB2/DFB2\DFB2;
                      INC A                               ;;DFAF|DFB5/DFB5\DFB5;
                      CLC                                 ;;DFB0|DFB6/DFB6\DFB6;
                      %WorL_X(ADC,DATA_03DEBB)            ;;DFB1|DFB7/DFB7\DFB7;
                      CLC                                 ;;DFB4|DFBB/DFBB\DFBB;
                      ADC.B !Layer1XPos,X                 ;;DFB5|DFBC/DFBC\DFBC;
                      STA.B !Mode7XPos,X                  ;;DFB7|DFBE/DFBE\DFBE;
                      SEP #$20                            ;;DFB9|DFC0/DFC0\DFC0; Accum (8 bit) 
                      PLX                                 ;;DFBB|DFC2/DFC2\DFC2;
                      RTS                                 ;;DFBC|DFC3/DFC3\DFC3; Return 
                                                          ;;                   ;
                                                          ;;                   ;
DATA_03DFC4:          db $00,$0E,$1C,$2A,$38,$46,$54,$62  ;;DFBD|DFC4/DFC4\DFC4;
                                                          ;;                   ;
CODE_03DFCC:          PHX                                 ;;DFC5|DFCC/DFCC\DFCC;
                      LDX.W !DynPaletteIndex              ;;DFC6|DFCD/DFCD\DFCD;
                      LDA.B #$10                          ;;DFC9|DFD0/DFD0\DFD0;
                      STA.W !DynPaletteTable,X            ;;DFCB|DFD2/DFD2\DFD2;
                      STZ.W !DynPaletteTable+1,X          ;;DFCE|DFD5/DFD5\DFD5;
                      STZ.W !DynPaletteTable+2,X          ;;DFD1|DFD8/DFD8\DFD8;
                      STZ.W !DynPaletteTable+3,X          ;;DFD4|DFDB/DFDB\DFDB;
                      TXY                                 ;;DFD7|DFDE/DFDE\DFDE;
                      LDX.W !LightningFlashIndex          ;;DFD8|DFDF/DFDF\DFDF;
                      BNE CODE_03E01B                     ;;DFDB|DFE2/DFE2\DFE2;
                      LDA.W !FinalCutscene                ;;DFDD|DFE4/DFE4\DFE4;
                      BEQ CODE_03DFF0                     ;;DFE0|DFE7/DFE7\DFE7;
                      REP #$20                            ;;DFE2|DFE9/DFE9\DFE9; Accum (16 bit) 
                      LDA.W !BackgroundColor              ;;DFE4|DFEB/DFEB\DFEB;
                      BRA CODE_03E031                     ;;DFE7|DFEE/DFEE\DFEE;
                                                          ;;                   ;
CODE_03DFF0:          LDA.B !EffFrame                     ;;DFE9|DFF0/DFF0\DFF0; Accum (8 bit) 
                      LSR A                               ;;DFEB|DFF2/DFF2\DFF2;
                      BCC CODE_03E036                     ;;DFEC|DFF3/DFF3\DFF3;
                      DEC.W !LightningWaitTimer           ;;DFEE|DFF5/DFF5\DFF5;
                      BNE CODE_03E036                     ;;DFF1|DFF8/DFF8\DFF8;
                      TAX                                 ;;DFF3|DFFA/DFFA\DFFA;
                      LDA.L CODE_04F708,X                 ;;DFF4|DFFB/DFFB\DFFB;
                      AND.B #$07                          ;;DFF8|DFFF/DFFF\DFFF;
                      TAX                                 ;;DFFA|E001/E001\E001;
                      LDA.L DATA_04F6F8,X                 ;;DFFB|E002/E002\E002;
                      STA.W !LightningWaitTimer           ;;DFFF|E006/E006\E006;
                      LDA.L DATA_04F700,X                 ;;E002|E009/E009\E009;
                      STA.W !LightningFlashIndex          ;;E006|E00D/E00D\E00D;
                      TAX                                 ;;E009|E010/E010\E010;
                      LDA.B #$08                          ;;E00A|E011/E011\E011;
                      STA.W !LightningTimer               ;;E00C|E013/E013\E013;
                      LDA.B #$18                          ;;E00F|E016/E016\E016;
                      STA.W !SPCIO3                       ;;E011|E018/E018\E018; / Play sound effect 
CODE_03E01B:          DEC.W !LightningTimer               ;;E014|E01B/E01B\E01B;
                      BPL +                               ;;E017|E01E/E01E\E01E;
                      DEC.W !LightningFlashIndex          ;;E019|E020/E020\E020;
                      LDA.B #$04                          ;;E01C|E023/E023\E023;
                      STA.W !LightningTimer               ;;E01E|E025/E025\E025;
                    + TXA                                 ;;E021|E028/E028\E028;
                      ASL A                               ;;E022|E029/E029\E029;
                      TAX                                 ;;E023|E02A/E02A\E02A;
                      REP #$20                            ;;E024|E02B/E02B\E02B; Accum (16 bit) 
                      LDA.L OverworldLightning,X          ;;E026|E02D/E02D\E02D;
CODE_03E031:          STA.W !DynPaletteTable+2,Y          ;;E02A|E031/E031\E031;
                      SEP #$20                            ;;E02D|E034/E034\E034; Accum (8 bit) 
CODE_03E036:          LDX.W !BowserPalette                ;;E02F|E036/E036\E036;
                      LDA.L DATA_03DFC4,X                 ;;E032|E039/E039\E039;
                      TAX                                 ;;E036|E03D/E03D\E03D;
                      LDA.B #$0E                          ;;E037|E03E/E03E\E03E;
                      STA.B !_0                           ;;E039|E040/E040\E040;
                    - LDA.L BowserColors,X                ;;E03B|E042/E042\E042;
                      STA.W !DynPaletteTable+4,Y          ;;E03F|E046/E046\E046;
                      INX                                 ;;E042|E049/E049\E049;
                      INY                                 ;;E043|E04A/E04A\E04A;
                      DEC.B !_0                           ;;E044|E04B/E04B\E04B;
                      BNE -                               ;;E046|E04D/E04D\E04D;
                      TYX                                 ;;E048|E04F/E04F\E04F;
                      STZ.W !DynPaletteTable+4,X          ;;E049|E050/E050\E050;
                      INX                                 ;;E04C|E053/E053\E053;
                      INX                                 ;;E04D|E054/E054\E054;
                      INX                                 ;;E04E|E055/E055\E055;
                      INX                                 ;;E04F|E056/E056\E056;
                      STX.W !DynPaletteIndex              ;;E050|E057/E057\E057;
                      PLX                                 ;;E053|E05A/E05A\E05A;
                      RTL                                 ;;E054|E05B/E05B\E05B; Return 
                                                          ;;                   ;
                      %insert_empty($3AB,$3A4,$3A4,$3A4)  ;;E055|E05C/E05C\E05C;
                                                          ;;                   ;
MusicBank3:           dw MusicBank3_End-MusicBank3-4      ;;E400|E400/E400\E400;
                      dw !MusicData                       ;;E402|E402/E402\E402;
                                                          ;;                   ;
                      base !MusicData                     ;;                   ;
                                                          ;;                   ;
                      dw MusicB3S01                       ;;1360|1360/1360\1360;
                      dw MusicB3S02                       ;;1362|1362/1362\1362;
                      dw MusicB3S03                       ;;1364|1364/1364\1364;
                      dw MusicB3S04                       ;;1366|1366/1366\1366;
                      dw MusicB3S01                       ;;1368|1368/1368\1368;
                      dw MusicB3S02                       ;;136A|136A/136A\136A;
                      dw MusicB3S03                       ;;136C|136C/136C\136C;
                      dw MusicB3S04                       ;;136E|136E/136E\136E;
                      dw MusicB3S01                       ;;1370|1370/1370\1370;
                      dw MusicB3S02                       ;;1372|1372/1372\1372;
                      dw MusicB3S03                       ;;1374|1374/1374\1374;
                      dw MusicB3S04                       ;;1376|1376/1376\1376;
                                                          ;;                   ;
                                                          ;;                   ;
MusicB3S01:           dw MusicB3S09L00                    ;;1378|1378/1378\1378;
                      dw MusicB3S0BL0F                    ;;137A|137A/137A\137A;
                      dw MusicB3S09L02                    ;;137C|137C/137C\137C;
                      dw MusicB3S09L03                    ;;137E|137E/137E\137E;
                      dw MusicB3S09L04                    ;;1380|1380/1380\1380;
                      dw MusicB3S09L05                    ;;1382|1382/1382\1382;
                      dw MusicB3S09L06                    ;;1384|1384/1384\1384;
                      dw MusicB3S09L07                    ;;1386|1386/1386\1386;
                      dw MusicB3S09L08                    ;;1388|1388/1388\1388;
                      dw MusicB3S09L09                    ;;138A|138A/138A\138A;
                      dw MusicB3S09L0A                    ;;138C|138C/138C\138C;
                      dw MusicB3S0BL10                    ;;138E|138E/138E\138E;
                      dw MusicB3S0BL11                    ;;1390|1390/1390\1390;
                      dw MusicB3S0BL12                    ;;1392|1392/1392\1392;
                      dw MusicB3S0BL13                    ;;1394|1394/1394\1394;
                      dw MusicB3S0BL14                    ;;1396|1396/1396\1396;
                      dw MusicB3S0BL16                    ;;1398|1398/1398\1398;
                      dw MusicB3S09L11                    ;;139A|139A/139A\139A;
                      dw $0000                            ;;139C|139C/139C\139C;
                                                          ;;                   ;
MusicB3S09L00:        dw MusicB3S01P00                    ;;139E|139E/139E\139E;
                      dw $0000                            ;;13A0|13A0/13A0\13A0;
                      dw $0000                            ;;13A2|13A2/13A2\13A2;
                      dw $0000                            ;;13A4|13A4/13A4\13A4;
                      dw $0000                            ;;13A6|13A6/13A6\13A6;
                      dw $0000                            ;;13A8|13A8/13A8\13A8;
                      dw $0000                            ;;13AA|13AA/13AA\13AA;
                      dw $0000                            ;;13AC|13AC/13AC\13AC;
                                                          ;;                   ;
MusicB3S0BL0F:        dw MusicB3S01P01                    ;;13AE|13AE/13AE\13AE;
                      dw MusicB3S01P02                    ;;13B0|13B0/13B0\13B0;
                      dw MusicB3S01P03                    ;;13B2|13B2/13B2\13B2;
                      dw MusicB3S01P04                    ;;13B4|13B4/13B4\13B4;
                      dw MusicB3S01P05                    ;;13B6|13B6/13B6\13B6;
                      dw MusicB3S01P06                    ;;13B8|13B8/13B8\13B8;
                      dw MusicB3S01P07                    ;;13BA|13BA/13BA\13BA;
                      dw MusicB3S01P08                    ;;13BC|13BC/13BC\13BC;
                                                          ;;                   ;
MusicB3S09L02:        dw MusicB3S01P09                    ;;13BE|13BE/13BE\13BE;
                      dw MusicB3S01P0A                    ;;13C0|13C0/13C0\13C0;
                      dw MusicB3S01P0B                    ;;13C2|13C2/13C2\13C2;
                      dw $0000                            ;;13C4|13C4/13C4\13C4;
                      dw $0000                            ;;13C6|13C6/13C6\13C6;
                      dw $0000                            ;;13C8|13C8/13C8\13C8;
                      dw MusicB3S01P0C                    ;;13CA|13CA/13CA\13CA;
                      dw MusicB3S01P0D                    ;;13CC|13CC/13CC\13CC;
                                                          ;;                   ;
MusicB3S09L04:        dw MusicB3S01P13                    ;;13CE|13CE/13CE\13CE;
                      dw MusicB3S01P0A                    ;;13D0|13D0/13D0\13D0;
                      dw MusicB3S01P0B                    ;;13D2|13D2/13D2\13D2;
                      dw MusicB3S01P14                    ;;13D4|13D4/13D4\13D4;
                      dw $0000                            ;;13D6|13D6/13D6\13D6;
                      dw MusicB3S01P15                    ;;13D8|13D8/13D8\13D8;
                      dw MusicB3S01P0C                    ;;13DA|13DA/13DA\13DA;
                      dw MusicB3S01P0D                    ;;13DC|13DC/13DC\13DC;
                                                          ;;                   ;
MusicB3S09L03:        dw MusicB3S01P0E                    ;;13DE|13DE/13DE\13DE;
                      dw MusicB3S01P0F                    ;;13E0|13E0/13E0\13E0;
                      dw MusicB3S01P10                    ;;13E2|13E2/13E2\13E2;
                      dw $0000                            ;;13E4|13E4/13E4\13E4;
                      dw $0000                            ;;13E6|13E6/13E6\13E6;
                      dw $0000                            ;;13E8|13E8/13E8\13E8;
                      dw MusicB3S01P11                    ;;13EA|13EA/13EA\13EA;
                      dw MusicB3S01P12                    ;;13EC|13EC/13EC\13EC;
                                                          ;;                   ;
MusicB3S09L05:        dw MusicB3S01P16                    ;;13EE|13EE/13EE\13EE;
                      dw MusicB3S01P17                    ;;13F0|13F0/13F0\13F0;
                      dw MusicB3S01P18                    ;;13F2|13F2/13F2\13F2;
                      dw MusicB3S01P19                    ;;13F4|13F4/13F4\13F4;
                      dw $0000                            ;;13F6|13F6/13F6\13F6;
                      dw MusicB3S01P1A                    ;;13F8|13F8/13F8\13F8;
                      dw MusicB3S01P1B                    ;;13FA|13FA/13FA\13FA;
                      dw MusicB3S01P1C                    ;;13FC|13FC/13FC\13FC;
                                                          ;;                   ;
MusicB3S09L06:        dw MusicB3S01P1D                    ;;13FE|13FE/13FE\13FE;
                      dw MusicB3S01P1E                    ;;1400|1400/1400\1400;
                      dw MusicB3S01P1F                    ;;1402|1402/1402\1402;
                      dw MusicB3S01P20                    ;;1404|1404/1404\1404;
                      dw $0000                            ;;1406|1406/1406\1406;
                      dw MusicB3S01P21                    ;;1408|1408/1408\1408;
                      dw MusicB3S01P22                    ;;140A|140A/140A\140A;
                      dw MusicB3S01P23                    ;;140C|140C/140C\140C;
                                                          ;;                   ;
MusicB3S09L07:        dw MusicB3S01P24                    ;;140E|140E/140E\140E;
                      dw MusicB3S01P25                    ;;1410|1410/1410\1410;
                      dw MusicB3S01P26                    ;;1412|1412/1412\1412;
                      dw MusicB3S01P27                    ;;1414|1414/1414\1414;
                      dw $0000                            ;;1416|1416/1416\1416;
                      dw MusicB3S01P28                    ;;1418|1418/1418\1418;
                      dw MusicB3S01P29                    ;;141A|141A/141A\141A;
                      dw MusicB3S01P0D                    ;;141C|141C/141C\141C;
                                                          ;;                   ;
MusicB3S09L08:        dw MusicB3S01P2A                    ;;141E|141E/141E\141E;
                      dw MusicB3S01P0A                    ;;1420|1420/1420\1420;
                      dw MusicB3S01P0B                    ;;1422|1422/1422\1422;
                      dw MusicB3S01P14                    ;;1424|1424/1424\1424;
                      dw MusicB3S01P2B                    ;;1426|1426/1426\1426;
                      dw MusicB3S01P2C                    ;;1428|1428/1428\1428;
                      dw MusicB3S01P0C                    ;;142A|142A/142A\142A;
                      dw MusicB3S01P0D                    ;;142C|142C/142C\142C;
                                                          ;;                   ;
MusicB3S09L09:        dw MusicB3S01P2D                    ;;142E|142E/142E\142E;
                      dw MusicB3S01P2E                    ;;1430|1430/1430\1430;
                      dw MusicB3S01P2F                    ;;1432|1432/1432\1432;
                      dw MusicB3S01P30                    ;;1434|1434/1434\1434;
                      dw MusicB3S01P31                    ;;1436|1436/1436\1436;
                      dw MusicB3S01P32                    ;;1438|1438/1438\1438;
                      dw MusicB3S01P33                    ;;143A|143A/143A\143A;
                      dw MusicB3S01P34                    ;;143C|143C/143C\143C;
                                                          ;;                   ;
MusicB3S09L0A:        dw MusicB3S01P35                    ;;143E|143E/143E\143E;
                      dw MusicB3S01P36                    ;;1440|1440/1440\1440;
                      dw MusicB3S01P37                    ;;1442|1442/1442\1442;
                      dw MusicB3S01P38                    ;;1444|1444/1444\1444;
                      dw MusicB3S01P39                    ;;1446|1446/1446\1446;
                      dw MusicB3S01P3A                    ;;1448|1448/1448\1448;
                      dw MusicB3S01P3B                    ;;144A|144A/144A\144A;
                      dw MusicB3S01P3C                    ;;144C|144C/144C\144C;
                                                          ;;                   ;
MusicB3S0BL10:        dw MusicB3S01P2A                    ;;144E|144E/144E\144E;
                      dw MusicB3S01P3D                    ;;1450|1450/1450\1450;
                      dw MusicB3S01P0B                    ;;1452|1452/1452\1452;
                      dw MusicB3S01P14                    ;;1454|1454/1454\1454;
                      dw MusicB3S01P2B                    ;;1456|1456/1456\1456;
                      dw MusicB3S01P2C                    ;;1458|1458/1458\1458;
                      dw MusicB3S01P0C                    ;;145A|145A/145A\145A;
                      dw MusicB3S01P0D                    ;;145C|145C/145C\145C;
                                                          ;;                   ;
MusicB3S0BL11:        dw MusicB3S01P2D                    ;;145E|145E/145E\145E;
                      dw MusicB3S01P3E                    ;;1460|1460/1460\1460;
                      dw MusicB3S01P3F                    ;;1462|1462/1462\1462;
                      dw MusicB3S01P30                    ;;1464|1464/1464\1464;
                      dw MusicB3S01P31                    ;;1466|1466/1466\1466;
                      dw MusicB3S01P32                    ;;1468|1468/1468\1468;
                      dw MusicB3S01P33                    ;;146A|146A/146A\146A;
                      dw MusicB3S01P34                    ;;146C|146C/146C\146C;
                                                          ;;                   ;
MusicB3S0BL12:        dw MusicB3S01P40                    ;;146E|146E/146E\146E;
                      dw MusicB3S01P41                    ;;1470|1470/1470\1470;
                      dw MusicB3S01P42                    ;;1472|1472/1472\1472;
                      dw MusicB3S01P43                    ;;1474|1474/1474\1474;
                      dw MusicB3S01P44                    ;;1476|1476/1476\1476;
                      dw MusicB3S01P45                    ;;1478|1478/1478\1478;
                      dw MusicB3S01P46                    ;;147A|147A/147A\147A;
                      dw MusicB3S01P47                    ;;147C|147C/147C\147C;
                                                          ;;                   ;
MusicB3S0BL13:        dw MusicB3S01P48                    ;;147E|147E/147E\147E;
                      dw MusicB3S01P49                    ;;1480|1480/1480\1480;
                      dw MusicB3S01P0B                    ;;1482|1482/1482\1482;
                      dw MusicB3S01P14                    ;;1484|1484/1484\1484;
                      dw MusicB3S01P4A                    ;;1486|1486/1486\1486;
                      dw MusicB3S01P4B                    ;;1488|1488/1488\1488;
                      dw MusicB3S01P0C                    ;;148A|148A/148A\148A;
                      dw MusicB3S01P0D                    ;;148C|148C/148C\148C;
                                                          ;;                   ;
MusicB3S0BL14:        dw MusicB3S01P4C                    ;;148E|148E/148E\148E;
                      dw MusicB3S01P4D                    ;;1490|1490/1490\1490;
                      dw MusicB3S01P3F                    ;;1492|1492/1492\1492;
                      dw MusicB3S01P30                    ;;1494|1494/1494\1494;
                      dw MusicB3S01P4E                    ;;1496|1496/1496\1496;
                      dw MusicB3S01P4F                    ;;1498|1498/1498\1498;
                      dw MusicB3S01P33                    ;;149A|149A/149A\149A;
                      dw MusicB3S01P34                    ;;149C|149C/149C\149C;
                                                          ;;                   ;
MusicB3S0BL16:        dw MusicB3S01P50                    ;;149E|149E/149E\149E;
                      dw MusicB3S01P41                    ;;14A0|14A0/14A0\14A0;
                      dw MusicB3S01P42                    ;;14A2|14A2/14A2\14A2;
                      dw MusicB3S01P43                    ;;14A4|14A4/14A4\14A4;
                      dw MusicB3S01P44                    ;;14A6|14A6/14A6\14A6;
                      dw MusicB3S01P45                    ;;14A8|14A8/14A8\14A8;
                      dw MusicB3S01P46                    ;;14AA|14AA/14AA\14AA;
                      dw MusicB3S01P47                    ;;14AC|14AC/14AC\14AC;
                                                          ;;                   ;
MusicB3S09L11:        dw MusicB3S01P51                    ;;14AE|14AE/14AE\14AE;
                      dw MusicB3S01P52                    ;;14B0|14B0/14B0\14B0;
                      dw MusicB3S01P53                    ;;14B2|14B2/14B2\14B2;
                      dw MusicB3S01P54                    ;;14B4|14B4/14B4\14B4;
                      dw MusicB3S01P55                    ;;14B6|14B6/14B6\14B6;
                      dw MusicB3S01P56                    ;;14B8|14B8/14B8\14B8;
                      dw MusicB3S01P57                    ;;14BA|14BA/14BA\14BA;
                      dw $0000                            ;;14BC|14BC/14BC\14BC;
                                                          ;;                   ;
MusicB3S02:           dw MusicB3S0AL00                    ;;14BE|14BE/14BE\14BE;
                      dw $0000                            ;;14C0|14C0/14C0\14C0;
                                                          ;;                   ;
MusicB3S0AL00:        dw MusicB3S02P00                    ;;14C2|14C2/14C2\14C2;
                      dw MusicB3S02P01                    ;;14C4|14C4/14C4\14C4;
                      dw MusicB3S02P02                    ;;14C6|14C6/14C6\14C6;
                      dw MusicB3S02P03                    ;;14C8|14C8/14C8\14C8;
                      dw MusicB3S02P04                    ;;14CA|14CA/14CA\14CA;
                      dw MusicB3S02P05                    ;;14CC|14CC/14CC\14CC;
                      dw MusicB3S02P06                    ;;14CE|14CE/14CE\14CE;
                      dw MusicB3S02P07                    ;;14D0|14D0/14D0\14D0;
                                                          ;;                   ;
MusicB3S0BL00:        dw MusicB3S03P00                    ;;14D2|14D2/14D2\14D2;
                      dw MusicB3S03P01                    ;;14D4|14D4/14D4\14D4;
                      dw MusicB3S03P02                    ;;14D6|14D6/14D6\14D6;
                      dw MusicB3S03P03                    ;;14D8|14D8/14D8\14D8;
                      dw MusicB3S03P04                    ;;14DA|14DA/14DA\14DA;
                      dw MusicB3S03P05                    ;;14DC|14DC/14DC\14DC;
                      dw MusicB3S03P06                    ;;14DE|14DE/14DE\14DE;
                      dw MusicB3S03P07                    ;;14E0|14E0/14E0\14E0;
                                                          ;;                   ;
MusicB3S0BL01:        dw MusicB3S03P08                    ;;14E2|14E2/14E2\14E2;
                      dw MusicB3S03P09                    ;;14E4|14E4/14E4\14E4;
                      dw MusicB3S03P0A                    ;;14E6|14E6/14E6\14E6;
                      dw MusicB3S03P0B                    ;;14E8|14E8/14E8\14E8;
                      dw MusicB3S03P0C                    ;;14EA|14EA/14EA\14EA;
                      dw MusicB3S03P0D                    ;;14EC|14EC/14EC\14EC;
                      dw MusicB3S03P0E                    ;;14EE|14EE/14EE\14EE;
                      dw MusicB3S03P0F                    ;;14F0|14F0/14F0\14F0;
                                                          ;;                   ;
MusicB3S03:           dw MusicB3S0BL00                    ;;14F2|14F2/14F2\14F2;
                      dw MusicB3S0BL01                    ;;14F4|14F4/14F4\14F4;
                      dw MusicB3S0CL00                    ;;14F6|14F6/14F6\14F6;
                      dw MusicB3S0CL01                    ;;14F8|14F8/14F8\14F8;
                      dw MusicB3S0BL04                    ;;14FA|14FA/14FA\14FA;
                      dw MusicB3S0CL02                    ;;14FC|14FC/14FC\14FC;
                      dw MusicB3S0CL03                    ;;14FE|14FE/14FE\14FE;
                      dw MusicB3S0CL04                    ;;1500|1500/1500\1500;
                      dw MusicB3S0BL08                    ;;1502|1502/1502\1502;
                      dw MusicB3S0CL05                    ;;1504|1504/1504\1504;
                      dw MusicB3S0BL0A                    ;;1506|1506/1506\1506;
                      dw MusicB3S0BL0B                    ;;1508|1508/1508\1508;
                      dw MusicB3S0BL0C                    ;;150A|150A/150A\150A;
                      dw MusicB3S0BL0D                    ;;150C|150C/150C\150C;
                      dw MusicB3S0BL0E                    ;;150E|150E/150E\150E;
                      dw MusicB3S0BL0F                    ;;1510|1510/1510\1510;
                      dw MusicB3S0BL10                    ;;1512|1512/1512\1512;
                      dw MusicB3S0BL11                    ;;1514|1514/1514\1514;
                      dw MusicB3S0BL12                    ;;1516|1516/1516\1516;
                      dw MusicB3S0BL13                    ;;1518|1518/1518\1518;
                      dw MusicB3S0BL14                    ;;151A|151A/151A\151A;
                      dw MusicB3S0BL12                    ;;151C|151C/151C\151C;
                      dw MusicB3S0BL15                    ;;151E|151E/151E\151E;
                      dw MusicB3S0BL12                    ;;1520|1520/1520\1520;
                      dw MusicB3S0BL13                    ;;1522|1522/1522\1522;
                      dw MusicB3S0BL14                    ;;1524|1524/1524\1524;
                      dw MusicB3S0BL16                    ;;1526|1526/1526\1526;
                      dw MusicB3S0BL17                    ;;1528|1528/1528\1528;
                      dw $0000                            ;;152A|152A/152A\152A;
                                                          ;;                   ;
MusicB3S0CL00:        dw MusicB3S03P10                    ;;152C|152C/152C\152C;
                      dw MusicB3S03P11                    ;;152E|152E/152E\152E;
                      dw MusicB3S03P12                    ;;1530|1530/1530\1530;
                      dw MusicB3S03P13                    ;;1532|1532/1532\1532;
                      dw MusicB3S03P14                    ;;1534|1534/1534\1534;
                      dw MusicB3S03P15                    ;;1536|1536/1536\1536;
                      dw $0000                            ;;1538|1538/1538\1538;
                      dw MusicB3S03P16                    ;;153A|153A/153A\153A;
                                                          ;;                   ;
MusicB3S0BL04:        dw MusicB3S03P10                    ;;153C|153C/153C\153C;
                      dw MusicB3S03P11                    ;;153E|153E/153E\153E;
                      dw MusicB3S03P12                    ;;1540|1540/1540\1540;
                      dw MusicB3S03P13                    ;;1542|1542/1542\1542;
                      dw MusicB3S03P14                    ;;1544|1544/1544\1544;
                      dw MusicB3S03P1D                    ;;1546|1546/1546\1546;
                      dw $0000                            ;;1548|1548/1548\1548;
                      dw MusicB3S03P16                    ;;154A|154A/154A\154A;
                                                          ;;                   ;
MusicB3S0CL01:        dw MusicB3S03P17                    ;;154C|154C/154C\154C;
                      dw MusicB3S03P18                    ;;154E|154E/154E\154E;
                      dw MusicB3S03P19                    ;;1550|1550/1550\1550;
                      dw MusicB3S03P1A                    ;;1552|1552/1552\1552;
                      dw MusicB3S03P1B                    ;;1554|1554/1554\1554;
                      dw MusicB3S03P1C                    ;;1556|1556/1556\1556;
                      dw $0000                            ;;1558|1558/1558\1558;
                      dw MusicB3S03P16                    ;;155A|155A/155A\155A;
                                                          ;;                   ;
MusicB3S0CL02:        dw MusicB3S03P1E                    ;;155C|155C/155C\155C;
                      dw MusicB3S03P1F                    ;;155E|155E/155E\155E;
                      dw MusicB3S03P20                    ;;1560|1560/1560\1560;
                      dw MusicB3S03P21                    ;;1562|1562/1562\1562;
                      dw MusicB3S03P22                    ;;1564|1564/1564\1564;
                      dw MusicB3S03P23                    ;;1566|1566/1566\1566;
                      dw $0000                            ;;1568|1568/1568\1568;
                      dw MusicB3S03P16                    ;;156A|156A/156A\156A;
                                                          ;;                   ;
MusicB3S0CL03:        dw MusicB3S03P24                    ;;156C|156C/156C\156C;
                      dw MusicB3S03P25                    ;;156E|156E/156E\156E;
                      dw MusicB3S03P26                    ;;1570|1570/1570\1570;
                      dw MusicB3S03P27                    ;;1572|1572/1572\1572;
                      dw MusicB3S03P28                    ;;1574|1574/1574\1574;
                      dw MusicB3S03P29                    ;;1576|1576/1576\1576;
                      dw $0000                            ;;1578|1578/1578\1578;
                      dw MusicB3S03P16                    ;;157A|157A/157A\157A;
                                                          ;;                   ;
MusicB3S0CL04:        dw MusicB3S03P2A                    ;;157C|157C/157C\157C;
                      dw MusicB3S03P2B                    ;;157E|157E/157E\157E;
                      dw MusicB3S03P2C                    ;;1580|1580/1580\1580;
                      dw MusicB3S03P2D                    ;;1582|1582/1582\1582;
                      dw MusicB3S03P2E                    ;;1584|1584/1584\1584;
                      dw MusicB3S03P2F                    ;;1586|1586/1586\1586;
                      dw $0000                            ;;1588|1588/1588\1588;
                      dw MusicB3S03P16                    ;;158A|158A/158A\158A;
                                                          ;;                   ;
MusicB3S0BL08:        dw MusicB3S03P24                    ;;158C|158C/158C\158C;
                      dw MusicB3S03P25                    ;;158E|158E/158E\158E;
                      dw MusicB3S03P26                    ;;1590|1590/1590\1590;
                      dw MusicB3S03P27                    ;;1592|1592/1592\1592;
                      dw MusicB3S03P28                    ;;1594|1594/1594\1594;
                      dw MusicB3S03P29                    ;;1596|1596/1596\1596;
                      dw MusicB3S03P30                    ;;1598|1598/1598\1598;
                      dw MusicB3S03P16                    ;;159A|159A/159A\159A;
                                                          ;;                   ;
MusicB3S0CL05:        dw MusicB3S03P31                    ;;159C|159C/159C\159C;
                      dw MusicB3S03P32                    ;;159E|159E/159E\159E;
                      dw MusicB3S03P33                    ;;15A0|15A0/15A0\15A0;
                      dw MusicB3S03P34                    ;;15A2|15A2/15A2\15A2;
                      dw MusicB3S03P35                    ;;15A4|15A4/15A4\15A4;
                      dw MusicB3S03P36                    ;;15A6|15A6/15A6\15A6;
                      dw MusicB3S03P37                    ;;15A8|15A8/15A8\15A8;
                      dw MusicB3S03P38                    ;;15AA|15AA/15AA\15AA;
                                                          ;;                   ;
MusicB3S0BL0A:        dw MusicB3S03P10                    ;;15AC|15AC/15AC\15AC;
                      dw MusicB3S03P11                    ;;15AE|15AE/15AE\15AE;
                      dw MusicB3S03P12                    ;;15B0|15B0/15B0\15B0;
                      dw MusicB3S03P13                    ;;15B2|15B2/15B2\15B2;
                      dw MusicB3S03P14                    ;;15B4|15B4/15B4\15B4;
                      dw MusicB3S03P15                    ;;15B6|15B6/15B6\15B6;
                      dw MusicB3S03P39                    ;;15B8|15B8/15B8\15B8;
                      dw MusicB3S03P16                    ;;15BA|15BA/15BA\15BA;
                                                          ;;                   ;
MusicB3S0BL0C:        dw MusicB3S03P10                    ;;15BC|15BC/15BC\15BC;
                      dw MusicB3S03P11                    ;;15BE|15BE/15BE\15BE;
                      dw MusicB3S03P12                    ;;15C0|15C0/15C0\15C0;
                      dw MusicB3S03P13                    ;;15C2|15C2/15C2\15C2;
                      dw MusicB3S03P14                    ;;15C4|15C4/15C4\15C4;
                      dw MusicB3S03P1D                    ;;15C6|15C6/15C6\15C6;
                      dw MusicB3S03P39                    ;;15C8|15C8/15C8\15C8;
                      dw MusicB3S03P16                    ;;15CA|15CA/15CA\15CA;
                                                          ;;                   ;
MusicB3S0BL0B:        dw MusicB3S03P17                    ;;15CC|15CC/15CC\15CC;
                      dw MusicB3S03P18                    ;;15CE|15CE/15CE\15CE;
                      dw MusicB3S03P19                    ;;15D0|15D0/15D0\15D0;
                      dw MusicB3S03P1A                    ;;15D2|15D2/15D2\15D2;
                      dw MusicB3S03P1B                    ;;15D4|15D4/15D4\15D4;
                      dw MusicB3S03P1C                    ;;15D6|15D6/15D6\15D6;
                      dw MusicB3S03P3A                    ;;15D8|15D8/15D8\15D8;
                      dw MusicB3S03P16                    ;;15DA|15DA/15DA\15DA;
                                                          ;;                   ;
MusicB3S0BL0D:        dw MusicB3S03P3B                    ;;15DC|15DC/15DC\15DC;
                      dw MusicB3S03P3C                    ;;15DE|15DE/15DE\15DE;
                      dw MusicB3S03P3D                    ;;15E0|15E0/15E0\15E0;
                      dw MusicB3S03P3E                    ;;15E2|15E2/15E2\15E2;
                      dw MusicB3S03P3F                    ;;15E4|15E4/15E4\15E4;
                      dw MusicB3S03P40                    ;;15E6|15E6/15E6\15E6;
                      dw MusicB3S03P41                    ;;15E8|15E8/15E8\15E8;
                      dw MusicB3S03P16                    ;;15EA|15EA/15EA\15EA;
                                                          ;;                   ;
MusicB3S0BL0E:        dw MusicB3S03P42                    ;;15EC|15EC/15EC\15EC;
                      dw $0000                            ;;15EE|15EE/15EE\15EE;
                      dw $0000                            ;;15F0|15F0/15F0\15F0;
                      dw $0000                            ;;15F2|15F2/15F2\15F2;
                      dw $0000                            ;;15F4|15F4/15F4\15F4;
                      dw $0000                            ;;15F6|15F6/15F6\15F6;
                      dw $0000                            ;;15F8|15F8/15F8\15F8;
                      dw $0000                            ;;15FA|15FA/15FA\15FA;
                                                          ;;                   ;
MusicB3S0BL15:        dw MusicB3S03P43                    ;;15FC|15FC/15FC\15FC;
                      dw $0000                            ;;15FE|15FE/15FE\15FE;
                      dw $0000                            ;;1600|1600/1600\1600;
                      dw $0000                            ;;1602|1602/1602\1602;
                      dw $0000                            ;;1604|1604/1604\1604;
                      dw $0000                            ;;1606|1606/1606\1606;
                      dw $0000                            ;;1608|1608/1608\1608;
                      dw $0000                            ;;160A|160A/160A\160A;
                                                          ;;                   ;
MusicB3S0BL17:        dw MusicB3S03P44                    ;;160C|160C/160C\160C;
                      dw MusicB3S03P45                    ;;160E|160E/160E\160E;
                      dw MusicB3S03P46                    ;;1610|1610/1610\1610;
                      dw MusicB3S03P47                    ;;1612|1612/1612\1612;
                      dw MusicB3S03P48                    ;;1614|1614/1614\1614;
                      dw MusicB3S03P49                    ;;1616|1616/1616\1616;
                      dw MusicB3S03P4A                    ;;1618|1618/1618\1618;
                      dw MusicB3S03P4B                    ;;161A|161A/161A\161A;
                                                          ;;                   ;
MusicB3S04:           dw MusicB3S0CL00                    ;;161C|161C/161C\161C;
                      dw MusicB3S0CL01                    ;;161E|161E/161E\161E;
                      dw MusicB3S0CL00                    ;;1620|1620/1620\1620;
                      dw MusicB3S0CL02                    ;;1622|1622/1622\1622;
                      dw MusicB3S0CL03                    ;;1624|1624/1624\1624;
                      dw MusicB3S0CL04                    ;;1626|1626/1626\1626;
                      dw MusicB3S0CL03                    ;;1628|1628/1628\1628;
                      dw MusicB3S0CL05                    ;;162A|162A/162A\162A;
                      dw $00FF,MusicB3S04                 ;;162C|162C/162C\162C;
                      dw $0000                            ;;1630|1630/1630\1630;
                                                          ;;                   ;
MusicB3S03P42:        db $DA,$04,$E2,$16,$E3,$90,$1B,$00  ;;1632|1632/1632\1632;
                                                          ;;                   ;
MusicB3S03P43:        db $E4,$01,$00                      ;;163A|163A/163A\163A;
                                                          ;;                   ;
MusicB3S03P10:        db $DA,$12,$E2,$1E,$DB,$0A,$DE,$14  ;;163D|163D/163D\163D;
                      db $19,$27,$0C,$6D,$B4,$0C,$2E,$B7  ;;1645|1645/1645\1645;
                      db $B9,$30,$6E,$B7,$0C,$2D,$B9,$0C  ;;164D|164D/164D\164D;
                      db $6E,$BB,$C6,$0C,$2D,$BB,$30,$6E  ;;1655|1655/1655\1655;
                      db $B9,$0C,$2D,$B3,$0C,$6E,$B4,$0C  ;;165D|165D/165D\165D;
                      db $2D,$B7,$B9,$30,$6E,$B7,$0C,$2D  ;;1665|1665/1665\1665;
                      db $B8,$0C,$6E,$B9,$C6,$0C,$2D,$B9  ;;166D|166D/166D\166D;
                      db $30,$6E,$B7,$0C,$2D,$B8,$00      ;;1675|1675/1675\1675;
                                                          ;;                   ;
MusicB3S03P39:        db $DA,$12,$DB,$0F,$DE,$14,$14,$20  ;;167C|167C/167C\167C;
                      db $48,$6D,$B7,$18,$B9,$48,$B7,$0C  ;;1684|1684/1684\1684;
                      db $B4,$B5,$30,$B7,$0C,$C6,$B9,$B7  ;;168C|168C/168C\168C;
                      db $B9,$48,$B7,$18,$B4              ;;1694|1694/1694\1694;
                                                          ;;                   ;
MusicB3S03P15:        db $DA,$00,$DB,$05,$DE,$14,$19,$27  ;;1699|1699/1699\1699;
                      db $30,$6B,$C7,$0C,$C7,$B7,$0C,$2C  ;;16A1|16A1/16A1\16A1;
                      db $B9,$BC,$06,$7B,$BB,$BC,$0C,$69  ;;16A9|16A9/16A9\16A9;
                      db $BB,$18,$C6,$0C,$C7,$B3,$0C,$2C  ;;16B1|16B1/16B1\16B1;
                      db $B7,$BB,$06,$7B,$B9,$BB,$0C,$69  ;;16B9|16B9/16B9\16B9;
                      db $B9,$18,$C6,$0C,$C7,$B2,$0C,$2C  ;;16C1|16C1/16C1\16C1;
                      db $B4,$B9,$06,$7B,$B7,$B9,$0C,$69  ;;16C9|16C9/16C9\16C9;
                      db $B7,$18,$C6,$0C,$C7,$06,$4B,$AD  ;;16D1|16D1/16D1\16D1;
                      db $AF,$B0,$B2,$B4,$B5              ;;16D9|16D9/16D9\16D9;
                                                          ;;                   ;
MusicB3S03P1D:        db $30,$6B,$B4,$0C,$C7,$B7,$0C,$2C  ;;16DE|16DE/16DE\16DE;
                      db $B9,$BC,$06,$7B,$BB,$BC,$0C,$69  ;;16E6|16E6/16E6\16E6;
                      db $BB,$18,$C6,$0C,$C7,$B3,$0C,$2C  ;;16EE|16EE/16EE\16EE;
                      db $B7,$BB,$06,$7B,$B9,$BB,$0C,$69  ;;16F6|16F6/16F6\16F6;
                      db $B9,$18,$C6,$0C,$C7,$B2,$0C,$2C  ;;16FE|16FE/16FE\16FE;
                      db $B4,$B9,$06,$7B,$B7,$B9,$0C,$69  ;;1706|1706/1706\1706;
                      db $B7,$18,$C6,$0C,$C7,$06,$4B,$AD  ;;170E|170E/170E\170E;
                      db $AF,$B0,$B2,$B4,$B5              ;;1716|1716/1716\1716;
                                                          ;;                   ;
MusicB3S03P13:        db $DA,$12,$DB,$08,$DE,$14,$1F,$25  ;;171B|171B/171B\171B;
                      db $0C,$6D,$B0,$0C,$2E,$B4,$B4,$30  ;;1723|1723/1723\1723;
                      db $6E,$B4,$0C,$2D,$B4,$0C,$6E,$B7  ;;172B|172B/172B\172B;
                      db $C6,$0C,$2D,$B7,$30,$6E,$B3,$0C  ;;1733|1733/1733\1733;
                      db $2D,$AF,$0C,$6E,$AE,$0C,$2D,$B2  ;;173B|173B/173B\173B;
                      db $B2,$30,$6E,$B2,$0C,$2D,$B2,$0C  ;;1743|1743/1743\1743;
                      db $6E,$B4,$C6,$0C,$2D,$B4,$30,$6E  ;;174B|174B/174B\174B;
                      db $B4,$0C,$2D,$B4                  ;;1753|1753/1753\1753;
                                                          ;;                   ;
MusicB3S03P14:        db $DA,$12,$DB,$0C,$DE,$14,$1B,$26  ;;1757|1757/1757\1757;
                      db $0C,$6D,$AB,$0C,$2E,$B0,$B0,$30  ;;175F|175F/175F\175F;
                      db $6E,$B0,$0C,$2D,$B0,$0C,$6E,$B3  ;;1767|1767/1767\1767;
                      db $C6,$0C,$2D,$B3,$30,$6E,$AF,$0C  ;;176F|176F/176F\176F;
                      db $2D,$AB,$0C,$6E,$AB,$0C,$2E,$AE  ;;1777|1777/1777\1777;
                      db $AE,$30,$6E,$AE,$0C,$2D,$AE,$0C  ;;177F|177F/177F\177F;
                      db $6E,$B1,$C6,$0C,$2D,$B1,$30,$6E  ;;1787|1787/1787\1787;
                      db $B1,$0C,$2D,$B1                  ;;178F|178F/178F\178F;
                                                          ;;                   ;
MusicB3S03P11:        db $DA,$04,$DB,$08,$DE,$14,$19,$28  ;;1793|1793/1793\1793;
                      db $0C,$3B,$C7,$9C,$C7,$9C,$C7,$9C  ;;179B|179B/179B\179B;
                      db $C7,$9C,$C7,$9B,$C7,$9B,$C7,$9B  ;;17A3|17A3/17A3\17A3;
                      db $C7,$9B,$C7,$9A,$C7,$9A,$C7,$9A  ;;17AB|17AB/17AB\17AB;
                      db $C7,$9A,$C7,$99,$C7,$99,$C7,$99  ;;17B3|17B3/17B3\17B3;
                      db $C7,$99                          ;;17BB|17BB/17BB\17BB;
                                                          ;;                   ;
MusicB3S03P12:        db $DA,$08,$DB,$0C,$DE,$14,$19,$28  ;;17BD|17BD/17BD\17BD;
                      db $0C,$6E,$98,$9F,$93,$9F,$98,$9F  ;;17C5|17C5/17C5\17C5;
                      db $93,$9F,$97,$9F,$93,$9F,$97,$9F  ;;17CD|17CD/17CD\17CD;
                      db $93,$9F,$96,$9F,$93,$9F,$96,$9F  ;;17D5|17D5/17D5\17D5;
                      db $93,$9F,$95,$9C,$90,$9C,$95,$9C  ;;17DD|17DD/17DD\17DD;
                      db $90,$9C                          ;;17E5|17E5/17E5\17E5;
                                                          ;;                   ;
MusicB3S03P16:        db $DA,$05,$DB,$14,$DE,$00,$00,$00  ;;17E7|17E7/17E7\17E7;
                      db $E9,$F3,$17,$08,$0C,$4B,$D1,$0C  ;;17EF|17EF/17EF\17EF;
                      db $4C,$D2,$0C,$49,$D1,$0C,$4B,$D2  ;;17F7|17F7/17F7\17F7;
                      db $00                              ;;17FF|17FF/17FF\17FF;
                                                          ;;                   ;
MusicB3S03P17:        db $0C,$6E,$B9,$0C,$2D,$BB,$BC,$30  ;;1800|1800/1800\1800;
                      db $6E,$B9,$0C,$2D,$B8,$0C,$6E,$B7  ;;1808|1808/1808\1808;
                      db $0C,$2D,$B8,$B9,$30,$6E,$B4,$0C  ;;1810|1810/1810\1810;
                      db $C7,$12,$6E,$B4,$06,$6D,$B3,$0C  ;;1818|1818/1818\1818;
                      db $2C,$B2,$12,$6E,$B4,$06,$6D,$B3  ;;1820|1820/1820\1820;
                      db $0C,$2C,$B2,$0C,$2E,$B4,$B2,$30  ;;1828|1828/1828\1828;
                      db $4E,$B7,$C6,$00                  ;;1830|1830/1830\1830;
                                                          ;;                   ;
MusicB3S03P3A:        db $30,$6D,$B0,$0C,$C6,$AF,$C6,$AD  ;;1834|1834/1834\1834;
                      db $AB,$AC,$AD,$B4,$30,$C6,$24,$B4  ;;183C|183C/183C\183C;
                      db $18,$B0,$0C,$AF,$B0,$B1,$30,$B2  ;;1844|1844/1844\1844;
                      db $06,$C7,$AB,$AD,$AF,$B0,$B2,$B4  ;;184C|184C/184C\184C;
                      db $B5                              ;;1854|1854/1854\1854;
                                                          ;;                   ;
MusicB3S03P1C:        db $06,$7B,$B4,$B5,$0C,$69,$B4,$18  ;;1855|1855/1855\1855;
                      db $C6,$0C,$C7,$06,$4B,$AF,$B0,$B2  ;;185D|185D/185D\185D;
                      db $B4,$B5,$B6,$06,$7B,$B7,$B9,$0C  ;;1865|1865/1865\1865;
                      db $69,$B7,$18,$C6,$0C,$C7,$06,$4B  ;;186D|186D/186D\186D;
                      db $B2,$B4,$B5,$B7,$B9,$BB,$30,$BC  ;;1875|1875/1875\1875;
                      db $C6,$BB,$0C,$C7,$06,$4B,$BB,$BC  ;;187D|187D/187D\187D;
                      db $BB,$B9,$B7,$B5                  ;;1885|1885/1885\1885;
                                                          ;;                   ;
MusicB3S03P1A:        db $0C,$6E,$B5,$0C,$2D,$B5,$B9,$30  ;;1889|1889/1889\1889;
                      db $6E,$B6,$0C,$2D,$B6,$0C,$6E,$B4  ;;1891|1891/1891\1891;
                      db $0C,$2D,$B4,$B4,$30,$6E,$B1,$0C  ;;1899|1899/1899\1899;
                      db $C7,$12,$6E,$AD,$06,$6D,$AD,$0C  ;;18A1|18A1/18A1\18A1;
                      db $2C,$AD,$12,$6E,$AD,$06,$6D,$AD  ;;18A9|18A9/18A9\18A9;
                      db $0C,$2C,$AD,$0C,$2E,$AD,$AD,$30  ;;18B1|18B1/18B1\18B1;
                      db $4E,$B2,$C6                      ;;18B9|18B9/18B9\18B9;
                                                          ;;                   ;
MusicB3S03P1B:        db $0C,$6E,$B0,$0C,$2D,$B0,$B5,$30  ;;18BC|18BC/18BC\18BC;
                      db $6E,$B0,$0C,$2D,$B0,$0C,$6E,$B0  ;;18C4|18C4/18C4\18C4;
                      db $0C,$2D,$B0,$B0,$30,$6E,$AB,$0C  ;;18CC|18CC/18CC\18CC;
                      db $C7,$12,$6E,$A9,$06,$6D,$A9,$0C  ;;18D4|18D4/18D4\18D4;
                      db $2C,$A9,$12,$6E,$A9,$06,$6D,$A9  ;;18DC|18DC/18DC\18DC;
                      db $0C,$2C,$A9,$0C,$2E,$A9,$A9,$30  ;;18E4|18E4/18E4\18E4;
                      db $4E,$AF,$C6                      ;;18EC|18EC/18EC\18EC;
                                                          ;;                   ;
MusicB3S03P18:        db $0C,$C7,$9D,$C7,$9D,$C7,$9E,$C7  ;;18EF|18EF/18EF\18EF;
                      db $9E,$C7,$9C,$C7,$9C,$C7,$99,$C7  ;;18F7|18F7/18F7\18F7;
                      db $99,$C7,$9A,$C7,$9A,$C7,$9A,$C7  ;;18FF|18FF/18FF\18FF;
                      db $9A,$C7,$97,$C7,$97,$C7,$97,$C7  ;;1907|1907/1907\1907;
                      db $97                              ;;190F|190F/190F\190F;
                                                          ;;                   ;
MusicB3S03P19:        db $0C,$91,$A1,$98,$A1,$92,$A1,$98  ;;1910|1910/1910\1910;
                      db $A1,$93,$9F,$98,$9F,$95,$9F,$90  ;;1918|1918/1918\1918;
                      db $9F,$8E,$9D,$95,$9D,$8E,$9D,$90  ;;1920|1920/1920\1920;
                      db $91,$93,$9D,$8E,$9D,$93,$9D,$8E  ;;1928|1928/1928\1928;
                      db $9D                              ;;1930|1930/1930\1930;
                                                          ;;                   ;
MusicB3S03P1E:        db $0C,$6E,$B9,$0C,$2D,$BB,$BC,$30  ;;1931|1931/1931\1931;
                      db $6E,$B9,$0C,$2D,$B8,$0C,$6E,$B7  ;;1939|1939/1939\1939;
                      db $0C,$2D,$B8,$B9,$30,$6E,$C0,$0C  ;;1941|1941/1941\1941;
                      db $C7,$0C,$6E,$C0,$0C,$2D,$BF,$C0  ;;1949|1949/1949\1949;
                      db $18,$6E,$BC,$0C,$2E,$BC,$18,$6E  ;;1951|1951/1951\1951;
                      db $B9,$30,$4E,$BC,$C6,$00          ;;1959|1959/1959\1959;
                                                          ;;                   ;
MusicB3S03P23:        db $06,$7B,$B4,$B5,$0C,$69,$B4,$18  ;;195F|195F/195F\195F;
                      db $C6,$0C,$C7,$06,$4B,$AF,$B0,$B2  ;;1967|1967/1967\1967;
                      db $B4,$B5,$B6,$06,$7B,$B7,$B9,$0C  ;;196F|196F/196F\196F;
                      db $69,$B7,$18,$C6,$0C,$C7,$06,$4B  ;;1977|1977/1977\1977;
                      db $B2,$B4,$B5,$B7,$B9,$BB,$30,$BC  ;;197F|197F/197F\197F;
                      db $BB,$60,$BC                      ;;1987|1987/1987\1987;
                                                          ;;                   ;
MusicB3S03P21:        db $0C,$6E,$B5,$0C,$2D,$B5,$B9,$30  ;;198A|198A/198A\198A;
                      db $6E,$B6,$0C,$2D,$B6,$0C,$6E,$B4  ;;1992|1992/1992\1992;
                      db $0C,$2D,$B4,$B4,$30,$6E,$BD,$0C  ;;199A|199A/199A\199A;
                      db $C7,$0C,$6E,$B9,$0C,$2D,$B9,$B9  ;;19A2|19A2/19A2\19A2;
                      db $18,$6E,$B9,$0C,$2E,$B5,$18,$6E  ;;19AA|19AA/19AA\19AA;
                      db $B5,$30,$4E,$B7,$C6              ;;19B2|19B2/19B2\19B2;
                                                          ;;                   ;
MusicB3S03P22:        db $0C,$6E,$B0,$0C,$2D,$B0,$B5,$30  ;;19B7|19B7/19B7\19B7;
                      db $6E,$B0,$0C,$2D,$B0,$0C,$6E,$B0  ;;19BF|19BF/19BF\19BF;
                      db $0C,$2D,$B0,$B0,$30,$6E,$B7,$0C  ;;19C7|19C7/19C7\19C7;
                      db $C7,$0C,$6E,$B5,$0C,$2D,$B5,$B5  ;;19CF|19CF/19CF\19CF;
                      db $18,$6E,$B5,$0C,$2E,$B2,$18,$6E  ;;19D7|19D7/19D7\19D7;
                      db $B2,$30,$4E,$B4,$C6              ;;19DF|19DF/19DF\19DF;
                                                          ;;                   ;
MusicB3S03P1F:        db $0C,$C7,$98,$C7,$98,$C7,$98,$C7  ;;19E4|19E4/19E4\19E4;
                      db $98,$C7,$9C,$C7,$9C,$C7,$99,$C7  ;;19EC|19EC/19EC\19EC;
                      db $99,$C7,$95,$C7,$95,$C7,$97,$C7  ;;19F4|19F4/19F4\19F4;
                      db $97,$C7,$9C,$C7,$9C,$C7,$9C,$C7  ;;19FC|19FC/19FC\19FC;
                      db $9C                              ;;1A04|1A04/1A04\1A04;
                                                          ;;                   ;
MusicB3S03P20:        db $0C,$91,$9D,$98,$9D,$92,$9E,$98  ;;1A05|1A05/1A05\1A05;
                      db $9E,$93,$9F,$9A,$9F,$95,$A1,$9C  ;;1A0D|1A0D/1A0D\1A0D;
                      db $A1,$8E,$9A,$95,$9A,$93,$9F,$9A  ;;1A15|1A15/1A15\1A15;
                      db $9F,$98,$9F,$93,$9F,$98,$98,$97  ;;1A1D|1A1D/1A1D\1A1D;
                      db $96                              ;;1A25|1A25/1A25\1A25;
                                                          ;;                   ;
MusicB3S03P3B:        db $0C,$6E,$B9,$0C,$2D,$BB,$BC,$30  ;;1A26|1A26/1A26\1A26;
                      db $6E,$B9,$0C,$2D,$B8,$0C,$6E,$B7  ;;1A2E|1A2E/1A2E\1A2E;
                      db $0C,$2D,$B8,$B9,$30,$6E,$C0,$0C  ;;1A36|1A36/1A36\1A36;
                      db $C7,$00                          ;;1A3E|1A3E/1A3E\1A3E;
                                                          ;;                   ;
MusicB3S03P41:        db $30,$6D,$B0,$0C,$C6,$AF,$C6,$AD  ;;1A40|1A40/1A40\1A40;
                      db $AB,$AC,$AD,$B4,$30,$C6          ;;1A48|1A48/1A48\1A48;
                                                          ;;                   ;
MusicB3S03P3E:        db $0C,$6E,$B5,$0C,$2D,$B5,$B9,$30  ;;1A4E|1A4E/1A4E\1A4E;
                      db $6E,$B6,$0C,$2D,$B6,$0C,$6E,$B4  ;;1A56|1A56/1A56\1A56;
                      db $0C,$2D,$B4,$B4,$30,$6E,$BD,$0C  ;;1A5E|1A5E/1A5E\1A5E;
                      db $C7                              ;;1A66|1A66/1A66\1A66;
                                                          ;;                   ;
MusicB3S03P3F:        db $0C,$6E,$B0,$0C,$2D,$B0,$B5,$30  ;;1A67|1A67/1A67\1A67;
                      db $6E,$B0,$0C,$2D,$B0,$0C,$6E,$B0  ;;1A6F|1A6F/1A6F\1A6F;
                      db $0C,$2D,$B0,$B0,$30,$6E,$B7,$0C  ;;1A77|1A77/1A77\1A77;
                      db $C7                              ;;1A7F|1A7F/1A7F\1A7F;
                                                          ;;                   ;
MusicB3S03P40:        db $06,$7B,$B4,$B5,$0C,$69,$B4,$18  ;;1A80|1A80/1A80\1A80;
                      db $C6,$0C,$C7,$06,$4B,$AF,$B0,$B2  ;;1A88|1A88/1A88\1A88;
                      db $B4,$B5,$B6,$06,$7B,$B7,$B9,$0C  ;;1A90|1A90/1A90\1A90;
                      db $69,$B7,$18,$C6,$0C,$C7,$06,$4B  ;;1A98|1A98/1A98\1A98;
                      db $B2,$B4,$B5,$B7,$B9,$BB          ;;1AA0|1AA0/1AA0\1AA0;
                                                          ;;                   ;
MusicB3S03P3C:        db $0C,$C7,$98,$C7,$98,$C7,$98,$C7  ;;1AA6|1AA6/1AA6\1AA6;
                      db $98,$C7,$9C,$C7,$9C,$C7,$99,$C7  ;;1AAE|1AAE/1AAE\1AAE;
                      db $99                              ;;1AB6|1AB6/1AB6\1AB6;
                                                          ;;                   ;
MusicB3S03P3D:        db $0C,$91,$9D,$98,$9D,$92,$9E,$98  ;;1AB7|1AB7/1AB7\1AB7;
                      db $9E,$93,$9F,$9A,$9F,$95,$A1,$9C  ;;1ABF|1ABF/1ABF\1ABF;
                      db $A1                              ;;1AC7|1AC7/1AC7\1AC7;
                                                          ;;                   ;
MusicB3S03P24:        db $DA,$12,$18,$6D,$AD,$0C,$B4,$C7  ;;1AC8|1AC8/1AC8\1AC8;
                      db $C7,$0C,$2D,$B4,$0C,$6E,$B3,$0C  ;;1AD0|1AD0/1AD0\1AD0;
                      db $2D,$B4,$0C,$6E,$B5,$0C,$2D,$B4  ;;1AD8|1AD8/1AD8\1AD8;
                      db $B1,$30,$6E,$AD,$0C,$2D,$AD,$0C  ;;1AE0|1AE0/1AE0\1AE0;
                      db $6E,$B4,$0C,$2D,$B2,$0C,$6D,$B4  ;;1AE8|1AE8/1AE8\1AE8;
                      db $0C,$2D,$B2,$0C,$6E,$B4,$0C,$2D  ;;1AF0|1AF0/1AF0\1AF0;
                      db $B2,$C7,$0C,$6D,$AD,$30,$C6,$C7  ;;1AF8|1AF8/1AF8\1AF8;
                      db $00                              ;;1B00|1B00/1B00\1B00;
                                                          ;;                   ;
MusicB3S03P30:        db $DB,$0F,$DE,$14,$14,$20,$DA,$12  ;;1B01|1B01/1B01\1B01;
                      db $18,$6D,$B9,$0C,$C0,$C7,$C7,$0C  ;;1B09|1B09/1B09\1B09;
                      db $2D,$C0,$0C,$6E,$BF,$0C,$2D,$C0  ;;1B11|1B11/1B11\1B11;
                      db $0C,$6E,$C1,$0C,$2D,$C0,$BD,$30  ;;1B19|1B19/1B19\1B19;
                      db $6E,$B9,$0C,$2D,$B9,$0C,$6E,$C0  ;;1B21|1B21/1B21\1B21;
                      db $0C,$2D,$BE,$0C,$6D,$C0,$0C,$2D  ;;1B29|1B29/1B29\1B29;
                      db $BE,$0C,$6E,$C0,$0C,$2D,$BE,$C7  ;;1B31|1B31/1B31\1B31;
                      db $0C,$6D,$B9,$30,$C6,$C7          ;;1B39|1B39/1B39\1B39;
                                                          ;;                   ;
MusicB3S03P27:        db $DA,$12,$18,$6D,$A8,$0C,$AB,$C7  ;;1B3F|1B3F/1B3F\1B3F;
                      db $C7,$0C,$2D,$AB,$0C,$6E,$AA,$0C  ;;1B47|1B47/1B47\1B47;
                      db $2D,$AB,$0C,$6E,$AD,$0C,$2D,$AB  ;;1B4F|1B4F/1B4F\1B4F;
                      db $A8,$30,$6E,$A5,$0C,$2D,$A5,$0C  ;;1B57|1B57/1B57\1B57;
                      db $6E,$AB,$0C,$2D,$AA,$0C,$6D,$AB  ;;1B5F|1B5F/1B5F\1B5F;
                      db $0C,$2D,$AA,$0C,$6E,$AB,$0C,$2D  ;;1B67|1B67/1B67\1B67;
                      db $AA,$C7,$0C,$6D,$A4,$30,$C6,$C7  ;;1B6F|1B6F/1B6F\1B6F;
                                                          ;;                   ;
MusicB3S03P28:        db $DB,$05,$DE,$19,$19,$35,$DA,$00  ;;1B77|1B77/1B77\1B77;
                      db $30,$6B,$A8,$0C,$C6,$A7,$A8,$AD  ;;1B7F|1B7F/1B7F\1B7F;
                      db $48,$B4,$0C,$B3,$B4,$30,$B9,$B4  ;;1B87|1B87/1B87\1B87;
                      db $60,$B2                          ;;1B8F|1B8F/1B8F\1B8F;
                                                          ;;                   ;
MusicB3S03P29:        db $DB,$08,$DE,$19,$18,$34,$DA,$00  ;;1B91|1B91/1B91\1B91;
                      db $30,$6B,$9F,$0C,$C6,$9E,$9F,$A5  ;;1B99|1B99/1B99\1B99;
                      db $48,$AB,$0C,$AA,$AB,$30,$B4,$AB  ;;1BA1|1BA1/1BA1\1BA1;
                      db $60,$AA                          ;;1BA9|1BA9/1BA9\1BA9;
                                                          ;;                   ;
MusicB3S03P25:        db $0C,$C7,$99,$C7,$99,$C7,$99,$C7  ;;1BAB|1BAB/1BAB\1BAB;
                      db $99,$C7,$99,$C7,$99,$C7,$99,$C7  ;;1BB3|1BB3/1BB3\1BB3;
                      db $99,$C7,$98,$C7,$98,$C7,$98,$C7  ;;1BBB|1BBB/1BBB\1BBB;
                      db $98,$C7,$98,$C7,$98,$C7,$98,$C7  ;;1BC3|1BC3/1BC3\1BC3;
                      db $98                              ;;1BCB|1BCB/1BCB\1BCB;
                                                          ;;                   ;
MusicB3S03P26:        db $0C,$95,$9F,$90,$9F,$95,$9F,$90  ;;1BCC|1BCC/1BCC\1BCC;
                      db $9F,$95,$9F,$90,$9F,$95,$9F,$90  ;;1BD4|1BD4/1BD4\1BD4;
                      db $8F,$8E,$9E,$95,$9E,$8E,$9E,$95  ;;1BDC|1BDC/1BDC\1BDC;
                      db $9E,$8E,$9E,$95,$9E,$8E,$9E,$90  ;;1BE4|1BE4/1BE4\1BE4;
                      db $92                              ;;1BEC|1BEC/1BEC\1BEC;
                                                          ;;                   ;
MusicB3S03P2A:        db $18,$6D,$AB,$0C,$B2,$C7,$C7,$0C  ;;1BED|1BED/1BED\1BED;
                      db $2D,$B2,$0C,$6E,$B1,$0C,$2D,$B2  ;;1BF5|1BF5/1BF5\1BF5;
                      db $0C,$6E,$B4,$0C,$2D,$B2,$AF,$30  ;;1BFD|1BFD/1BFD\1BFD;
                      db $6E,$AB,$0C,$2D,$B2,$18,$4E,$B0  ;;1C05|1C05/1C05\1C05;
                      db $B0,$10,$6D,$B0,$10,$6E,$B2,$10  ;;1C0D|1C0D/1C0D\1C0D;
                      db $6E,$B3,$30,$B4,$C7,$00          ;;1C15|1C15/1C15\1C15;
                                                          ;;                   ;
MusicB3S03P2D:        db $18,$6D,$A3,$0C,$A9,$C7,$C7,$0C  ;;1C1B|1C1B/1C1B\1C1B;
                      db $2D,$A9,$0C,$6E,$A8,$0C,$2D,$A9  ;;1C23|1C23/1C23\1C23;
                      db $0C,$6E,$AB,$0C,$2D,$A9,$A6,$30  ;;1C2B|1C2B/1C2B\1C2B;
                      db $6E,$A3,$0C,$2D,$A9,$18,$4E,$A8  ;;1C33|1C33/1C33\1C33;
                      db $A8,$10,$6D,$A8,$10,$6E,$A9,$10  ;;1C3B|1C3B/1C3B\1C3B;
                      db $6E,$AA,$30,$AC,$C7              ;;1C43|1C43/1C43\1C43;
                                                          ;;                   ;
MusicB3S03P2E:        db $30,$69,$AB,$0C,$C6,$A9,$AB,$AF  ;;1C48|1C48/1C48\1C48;
                      db $48,$B2,$0C,$B0,$B2,$48,$B0,$18  ;;1C50|1C50/1C50\1C50;
                      db $B2,$60,$B4                      ;;1C58|1C58/1C58\1C58;
                                                          ;;                   ;
MusicB3S03P2F:        db $30,$69,$A3,$0C,$C6,$A3,$A6,$A9  ;;1C5B|1C5B/1C5B\1C5B;
                      db $48,$AB,$0C,$A9,$AB,$48,$A8,$18  ;;1C63|1C63/1C63\1C63;
                      db $AB,$60,$AC                      ;;1C6B|1C6B/1C6B\1C6B;
                                                          ;;                   ;
MusicB3S03P2B:        db $0C,$C7,$97,$C7,$97,$C7,$97,$C7  ;;1C6E|1C6E/1C6E\1C6E;
                      db $97,$C7,$97,$C7,$97,$C7,$97,$C7  ;;1C76|1C76/1C76\1C76;
                      db $97,$C7,$9C,$C7,$9C,$C7,$9C,$C7  ;;1C7E|1C7E/1C7E\1C7E;
                      db $9C,$C7,$97,$C7,$97,$C7,$97,$C7  ;;1C86|1C86/1C86\1C86;
                      db $97                              ;;1C8E|1C8E/1C8E\1C8E;
                                                          ;;                   ;
MusicB3S03P2C:        db $0C,$93,$9D,$8E,$9D,$93,$9D,$8E  ;;1C8F|1C8F/1C8F\1C8F;
                      db $9D,$93,$9D,$8E,$9D,$93,$9D,$95  ;;1C97|1C97/1C97\1C97;
                      db $97,$98,$9F,$93,$9F,$98,$9F,$93  ;;1C9F|1C9F/1C9F\1C9F;
                      db $9F,$90,$A0,$97,$A0,$90,$A0,$92  ;;1CA7|1CA7/1CA7\1CA7;
                      db $94                              ;;1CAF|1CAF/1CAF\1CAF;
                                                          ;;                   ;
MusicB3S03P31:        db $18,$6D,$AB,$0C,$B2,$C7,$C7,$0C  ;;1CB0|1CB0/1CB0\1CB0;
                      db $2D,$B2,$0C,$6E,$B1,$0C,$2D,$B2  ;;1CB8|1CB8/1CB8\1CB8;
                      db $0C,$6E,$B4,$0C,$2D,$B2,$C7,$30  ;;1CC0|1CC0/1CC0\1CC0;
                      db $6E,$AB,$0C,$2D,$B2,$18,$4E,$B0  ;;1CC8|1CC8/1CC8\1CC8;
                      db $B0,$10,$6D,$B0,$10,$6E,$B2,$10  ;;1CD0|1CD0/1CD0\1CD0;
                      db $6E,$B3,$18,$2E,$B4,$C7,$30,$4E  ;;1CD8|1CD8/1CD8\1CD8;
                      db $B7,$00                          ;;1CE0|1CE0/1CE0\1CE0;
                                                          ;;                   ;
MusicB3S03P37:        db $18,$6D,$B7,$0C,$BE,$C7,$C7,$0C  ;;1CE2|1CE2/1CE2\1CE2;
                      db $2D,$BE,$0C,$6E,$BD,$0C,$2D,$BE  ;;1CEA|1CEA/1CEA\1CEA;
                      db $0C,$6E,$C0,$0C,$2D,$BE,$C7,$30  ;;1CF2|1CF2/1CF2\1CF2;
                      db $6E,$B7,$0C,$2D,$BE,$18,$4E,$BC  ;;1CFA|1CFA/1CFA\1CFA;
                      db $BC,$10,$6D,$BC,$10,$6E,$BE,$10  ;;1D02|1D02/1D02\1D02;
                      db $6E,$BF,$18,$2E,$C0,$C7,$06,$C7  ;;1D0A|1D0A/1D0A\1D0A;
                      db $AB,$AD,$AF,$B0,$B2,$B4,$B5      ;;1D12|1D12/1D12\1D12;
                                                          ;;                   ;
MusicB3S03P34:        db $18,$6D,$A3,$0C,$A9,$C7,$C7,$0C  ;;1D19|1D19/1D19\1D19;
                      db $2D,$A9,$0C,$6E,$A8,$0C,$2D,$A9  ;;1D21|1D21/1D21\1D21;
                      db $0C,$6E,$AB,$0C,$2D,$A9,$C7,$30  ;;1D29|1D29/1D29\1D29;
                      db $6E,$A3,$0C,$2D,$A9,$18,$4E,$A8  ;;1D31|1D31/1D31\1D31;
                      db $A8,$10,$6D,$A8,$10,$6E,$A9,$10  ;;1D39|1D39/1D39\1D39;
                      db $6E,$AA,$18,$2E,$AB,$C7,$30,$4E  ;;1D41|1D41/1D41\1D41;
                      db $AF                              ;;1D49|1D49/1D49\1D49;
                                                          ;;                   ;
MusicB3S03P35:        db $30,$69,$AB,$0C,$C6,$A9,$AB,$AF  ;;1D4A|1D4A/1D4A\1D4A;
                      db $48,$B2,$0C,$B0,$B2,$30,$B0,$B2  ;;1D52|1D52/1D52\1D52;
                      db $30,$B4,$B3                      ;;1D5A|1D5A/1D5A\1D5A;
                                                          ;;                   ;
MusicB3S03P36:        db $30,$69,$A3,$0C,$C6,$A3,$A6,$A9  ;;1D5D|1D5D/1D5D\1D5D;
                      db $48,$AB,$0C,$A9,$AB,$30,$A8,$AB  ;;1D65|1D65/1D65\1D65;
                      db $30,$AB,$AF                      ;;1D6D|1D6D/1D6D\1D6D;
                                                          ;;                   ;
MusicB3S03P32:        db $0C,$C7,$97,$C7,$97,$C7,$97,$C7  ;;1D70|1D70/1D70\1D70;
                      db $97,$C7,$97,$C7,$97,$C7,$97,$C7  ;;1D78|1D78/1D78\1D78;
                      db $97,$C7,$9C,$C7,$9C,$C7,$9C,$C7  ;;1D80|1D80/1D80\1D80;
                      db $9C,$DA,$01,$18,$AF,$C7,$A7,$C6  ;;1D88|1D88/1D88\1D88;
                                                          ;;                   ;
MusicB3S03P33:        db $0C,$93,$9D,$8E,$9D,$93,$9D,$8E  ;;1D90|1D90/1D90\1D90;
                      db $9D,$93,$9D,$8E,$9D,$93,$9D,$95  ;;1D98|1D98/1D98\1D98;
                      db $97,$98,$9F,$93,$9F,$98,$9F,$93  ;;1DA0|1DA0/1DA0\1DA0;
                      db $9F,$18,$8C,$C7,$93,$C6          ;;1DA8|1DA8/1DA8\1DA8;
                                                          ;;                   ;
MusicB3S03P38:        db $DA,$05,$DB,$14,$DE,$00,$00,$00  ;;1DAE|1DAE/1DAE\1DAE;
                      db $E9,$F3,$17,$06,$18,$4C,$D1,$C7  ;;1DB6|1DB6/1DB6\1DB6;
                      db $30,$6D,$D2                      ;;1DBE|1DBE/1DBE\1DBE;
                                                          ;;                   ;
MusicB3S03P44:        db $DA,$04,$DB,$0A,$DE,$22,$19,$38  ;;1DC1|1DC1/1DC1\1DC1;
                      db $60,$5E,$BC,$C6,$DA,$01,$60,$C6  ;;1DC9|1DC9/1DC9\1DC9;
                      db $C6,$C6,$00                      ;;1DD1|1DD1/1DD1\1DD1;
                                                          ;;                   ;
MusicB3S03P45:        db $DA,$04,$DB,$08,$DE,$20,$18,$36  ;;1DD4|1DD4/1DD4\1DD4;
                      db $60,$5D,$B4,$C6,$DA,$01,$60,$C6  ;;1DDC|1DDC/1DDC\1DDC;
                      db $C6,$C6                          ;;1DE4|1DE4/1DE4\1DE4;
                                                          ;;                   ;
MusicB3S03P4A:        db $DA,$04,$DB,$0C,$DE,$21,$1A,$37  ;;1DE6|1DE6/1DE6\1DE6;
                      db $60,$5D,$AB,$C6,$DA,$01,$60,$C6  ;;1DEE|1DEE/1DEE\1DEE;
                      db $C6,$C6                          ;;1DF6|1DF6/1DF6\1DF6;
                                                          ;;                   ;
MusicB3S03P47:        db $DA,$04,$DB,$0A,$DE,$22,$18,$36  ;;1DF8|1DF8/1DF8\1DF8;
                      db $60,$5D,$A4,$C6,$DA,$01,$60,$C6  ;;1E00|1E00/1E00\1E00;
                      db $C6,$C6                          ;;1E08|1E08/1E08\1E08;
                                                          ;;                   ;
MusicB3S03P49:        db $DA,$04,$DB,$0F,$10,$5D,$B0,$C7  ;;1E0A|1E0A/1E0A\1E0A;
                      db $B0,$AE,$C7,$AE,$AD,$C7,$AD,$AC  ;;1E12|1E12/1E12\1E12;
                      db $C7,$AC,$30,$AB,$24,$A7,$6C,$A6  ;;1E1A|1E1A/1E1A\1E1A;
                      db $60,$C6                          ;;1E22|1E22/1E22\1E22;
                                                          ;;                   ;
MusicB3S03P4B:        db $DA,$04,$DB,$0F,$10,$5D,$AB,$C7  ;;1E24|1E24/1E24\1E24;
                      db $AB,$A8,$C7,$A8,$A9,$C7,$A9,$A9  ;;1E2C|1E2C/1E2C\1E2C;
                      db $C7,$A9,$30,$A6,$24,$A3,$6C,$A2  ;;1E34|1E34/1E34\1E34;
                      db $60,$C6                          ;;1E3C|1E3C/1E3C\1E3C;
                                                          ;;                   ;
MusicB3S03P48:        db $DA,$04,$DB,$0F,$10,$5D,$A8,$C7  ;;1E3E|1E3E/1E3E\1E3E;
                      db $A8,$A4,$C7,$A4,$A4,$C7,$A4,$A4  ;;1E46|1E46/1E46\1E46;
                      db $C7,$A4,$30,$A3,$24,$9D,$6C,$9C  ;;1E4E|1E4E/1E4E\1E4E;
                      db $60,$C6                          ;;1E56|1E56/1E56\1E56;
                                                          ;;                   ;
MusicB3S03P46:        db $DA,$08,$DB,$0A,$DE,$22,$19,$38  ;;1E58|1E58/1E58\1E58;
                      db $10,$5D,$8C,$8C,$8C,$90,$90,$90  ;;1E60|1E60/1E60\1E60;
                      db $91,$91,$91,$92,$92,$92,$30,$93  ;;1E68|1E68/1E68\1E68;
                      db $24,$93,$6C,$8C,$60,$C6          ;;1E70|1E70/1E70\1E70;
                                                          ;;                   ;
MusicB3S02P00:        db $DA,$01,$E2,$12,$DB,$0A,$DE,$14  ;;1E76|1E76/1E76\1E76;
                      db $19,$28,$18,$7C,$A7,$0C,$A8,$AB  ;;1E7E|1E7E/1E7E\1E7E;
                      db $AD,$30,$AB,$0C,$AD,$AF,$C6,$AF  ;;1E86|1E86/1E86\1E86;
                      db $30,$AD,$0C,$A7,$A8,$AB,$AD,$30  ;;1E8E|1E8E/1E8E\1E8E;
                      db $AB,$0C,$AC,$AD,$C6,$AD,$60,$AB  ;;1E96|1E96/1E96\1E96;
                      db $60,$77,$C6,$00                  ;;1E9E|1E9E/1E9E\1E9E;
                                                          ;;                   ;
MusicB3S02P03:        db $DA,$02,$DB,$0A,$18,$79,$A7,$0C  ;;1EA2|1EA2/1EA2\1EA2;
                      db $A8,$AB,$AD,$30,$AB,$0C,$AD,$AF  ;;1EAA|1EAA/1EAA\1EAA;
                      db $C6,$AF,$30,$AD,$0C,$A7,$A8,$AB  ;;1EB2|1EB2/1EB2\1EB2;
                      db $AD,$30,$AB,$0C,$AC,$AD,$C6,$AD  ;;1EBA|1EBA/1EBA\1EBA;
                      db $60,$AB,$C6                      ;;1EC2|1EC2/1EC2\1EC2;
                                                          ;;                   ;
MusicB3S02P01:        db $DA,$01,$DB,$0C,$DE,$14,$19,$28  ;;1EC5|1EC5/1EC5\1EC5;
                      db $06,$C6,$18,$79,$A7,$0C,$A8,$AB  ;;1ECD|1ECD/1ECD\1ECD;
                      db $AD,$30,$AB,$0C,$AD,$AF,$C6,$AF  ;;1ED5|1ED5/1ED5\1ED5;
                      db $30,$AD,$0C,$A7,$A8,$AB,$AD,$30  ;;1EDD|1EDD/1EDD\1EDD;
                      db $AB,$0C,$AC,$AD,$C6,$AD,$60,$AB  ;;1EE5|1EE5/1EE5\1EE5;
                      db $60,$75,$C6                      ;;1EED|1EED/1EED\1EED;
                                                          ;;                   ;
MusicB3S02P02:        db $DA,$01,$DB,$0A,$DE,$14,$19,$28  ;;1EF0|1EF0/1EF0\1EF0;
                      db $18,$7B,$C7,$60,$98,$97,$96,$95  ;;1EF8|1EF8/1EF8\1EF8;
                      db $C6,$C6,$C6                      ;;1F00|1F00/1F00\1F00;
                                                          ;;                   ;
MusicB3S02P04:        db $DA,$01,$DB,$0A,$DE,$14,$19,$28  ;;1F03|1F03/1F03\1F03;
                      db $18,$7B,$C7,$0C,$C7,$24,$9F,$30  ;;1F0B|1F0B/1F0B\1F0B;
                      db $B0,$0C,$C7,$24,$9F,$30,$AF,$0C  ;;1F13|1F13/1F13\1F13;
                      db $C7,$24,$9F,$30,$AE,$0C,$C7,$24  ;;1F1B|1F1B/1F1B\1F1B;
                      db $9F,$30,$B1,$60,$C6,$C6,$C6      ;;1F23|1F23/1F23\1F23;
                                                          ;;                   ;
MusicB3S02P05:        db $DA,$01,$DB,$0A,$DE,$14,$19,$28  ;;1F2A|1F2A/1F2A\1F2A;
                      db $18,$7B,$C7,$18,$C7,$48,$A8,$18  ;;1F32|1F32/1F32\1F32;
                      db $C7,$48,$A7,$18,$C7,$48,$A6,$18  ;;1F3A|1F3A/1F3A\1F3A;
                      db $C7,$48,$A5,$60,$C6,$C6,$C6      ;;1F42|1F42/1F42\1F42;
                                                          ;;                   ;
MusicB3S02P06:        db $DA,$01,$DB,$0A,$DE,$14,$19,$28  ;;1F49|1F49/1F49\1F49;
                      db $18,$7B,$C7,$24,$C7,$3C,$AB,$24  ;;1F51|1F51/1F51\1F51;
                      db $C7,$3C,$AB,$24,$C7,$3C,$AB,$24  ;;1F59|1F59/1F59\1F59;
                      db $C7,$3C,$AB,$60,$C6,$C6,$C6      ;;1F61|1F61/1F61\1F61;
                                                          ;;                   ;
MusicB3S02P07:        db $DA,$01,$DB,$0A,$DE,$14,$19,$28  ;;1F68|1F68/1F68\1F68;
                      db $18,$7B,$C7,$30,$C7,$B4,$30,$C7  ;;1F70|1F70/1F70\1F70;
                      db $B3,$30,$C7,$B2,$30,$C7,$B4,$60  ;;1F78|1F78/1F78\1F78;
                      db $C6,$C6,$C6                      ;;1F80|1F80/1F80\1F80;
                                                          ;;                   ;
MusicB3S03P05:        db $DA,$04,$DB,$08,$DE,$22,$18,$14  ;;1F83|1F83/1F83\1F83;
                      db $08,$5C,$C7,$A9,$C7,$A9,$AD,$C7  ;;1F8B|1F8B/1F8B\1F8B;
                      db $24,$AA,$0C,$C7,$08,$A9,$A8,$C7  ;;1F93|1F93/1F93\1F93;
                      db $A8,$A8,$C7,$24,$AB,$0C,$C7,$08  ;;1F9B|1F9B/1F9B\1F9B;
                      db $C7                              ;;1FA3|1FA3/1FA3\1FA3;
                                                          ;;                   ;
MusicB3S03P00:        db $E2,$1C,$DA,$04,$DB,$0A,$DE,$22  ;;1FA4|1FA4/1FA4\1FA4;
                      db $18,$14,$08,$5D,$AC,$AD,$C7,$AF  ;;1FAC|1FAC/1FAC\1FAC;
                      db $B0,$C7,$24,$AD,$0C,$C7,$08,$AC  ;;1FB4|1FB4/1FB4\1FB4;
                      db $AB,$C7,$AC,$AD,$C7,$24,$B4,$0C  ;;1FBC|1FBC/1FBC\1FBC;
                      db $C7,$08,$C7,$00                  ;;1FC4|1FC4/1FC4\1FC4;
                                                          ;;                   ;
MusicB3S03P04:        db $DA,$04,$DB,$0C,$DE,$22,$18,$14  ;;1FC8|1FC8/1FC8\1FC8;
                      db $08,$5C,$C7,$A4,$C7,$A4,$A9,$C7  ;;1FD0|1FD0/1FD0\1FD0;
                      db $24,$A4,$0C,$C7,$08,$A4,$A4,$C7  ;;1FD8|1FD8/1FD8\1FD8;
                      db $A4,$A4,$C7,$24,$A5,$0C,$C7,$08  ;;1FE0|1FE0/1FE0\1FE0;
                      db $C7                              ;;1FE8|1FE8/1FE8\1FE8;
                                                          ;;                   ;
MusicB3S03P03:        db $DA,$06,$DB,$0A,$DE,$22,$18,$14  ;;1FE9|1FE9/1FE9\1FE9;
                      db $08,$5D,$B8,$B9,$C7,$BB,$BC,$C7  ;;1FF1|1FF1/1FF1\1FF1;
                      db $24,$B9,$0C,$C7,$08,$B8,$B7,$C7  ;;1FF9|1FF9/1FF9\1FF9;
                      db $B8,$B9,$C7,$24,$C0,$0C,$C7,$08  ;;2001|2001/2001\2001;
                      db $C7                              ;;2009|2009/2009\2009;
                                                          ;;                   ;
MusicB3S03P01:        db $DA,$0D,$DB,$0F,$DE,$22,$18,$14  ;;200A|200A/200A\200A;
                      db $01,$C7,$08,$C7,$18,$4E,$C7,$9D  ;;2012|2012/2012\2012;
                      db $C7,$9E,$C7,$9F,$C7,$9F,$18,$9E  ;;201A|201A/201A\201A;
                      db $08,$C7,$C7,$9D,$18,$C6,$08,$C7  ;;2022|2022/2022\2022;
                      db $C7,$AB                          ;;202A|202A/202A\202A;
                                                          ;;                   ;
MusicB3S03P06:        db $DA,$0D,$DB,$0F,$DE,$22,$18,$14  ;;202C|202C/202C\202C;
                      db $08,$C7,$18,$4E,$C7,$98,$C7,$98  ;;2034|2034/2034\2034;
                      db $C7,$9A,$C7,$99,$18,$A1,$08,$C7  ;;203C|203C/203C\203C;
                      db $C7,$A3,$18,$C6,$08,$C7,$C7,$A4  ;;2044|2044/2044\2044;
                                                          ;;                   ;
MusicB3S03P02:        db $DA,$08,$DB,$0A,$DE,$22,$18,$14  ;;204C|204C/204C\204C;
                      db $08,$C7,$18,$5F,$91,$08,$C7,$C7  ;;2054|2054/2054\2054;
                      db $91,$18,$92,$08,$C7,$C7,$92,$18  ;;205C|205C/205C\205C;
                      db $93,$08,$C7,$C7,$93,$18,$95,$08  ;;2064|2064/2064\2064;
                      db $95,$90,$8F,$18,$8E,$08,$C6,$C7  ;;206C|206C/206C\206C;
                      db $93,$18,$C6,$08,$C7,$C7,$98      ;;2074|2074/2074\2074;
                                                          ;;                   ;
MusicB3S03P07:        db $DA,$04,$DB,$14,$08,$C7,$18,$6C  ;;207B|207B/207B\207B;
                      db $D1,$08,$D2,$C7,$D1,$18,$D1,$08  ;;2083|2083/2083\2083;
                      db $D2,$C7,$D1,$18,$D1,$08,$D2,$C7  ;;208B|208B/208B\208B;
                      db $D1,$D1,$C7,$D1,$D2,$D1,$D1,$18  ;;2093|2093/2093\2093;
                      db $D2,$08,$C6,$C7,$D2,$18,$C6,$08  ;;209B|209B/209B\209B;
                      db $C7,$C7,$D2                      ;;20A3|20A3/20A3\20A3;
                                                          ;;                   ;
MusicB3S03P08:        db $DA,$04,$DB,$0A,$DE,$22,$19,$38  ;;20A6|20A6/20A6\20A6;
                      db $18,$4D,$B4,$08,$C7,$C7,$B4,$E3  ;;20AE|20AE/20AE\20AE;
                      db $60,$18,$18,$B4,$08,$C7,$C7,$B7  ;;20B6|20B6/20B6\20B6;
                      db $18,$B7,$08,$C7,$C7,$B7,$18,$B7  ;;20BE|20BE/20BE\20BE;
                      db $C7,$00                          ;;20C6|20C6/20C6\20C6;
                                                          ;;                   ;
MusicB3S03P09:        db $DA,$04,$DB,$08,$DE,$20,$18,$36  ;;20C8|20C8/20C8\20C8;
                      db $18,$4D,$A4,$08,$C7,$C7,$A4,$18  ;;20D0|20D0/20D0\20D0;
                      db $A4,$08,$C7,$C7,$A7,$18,$A7,$08  ;;20D8|20D8/20D8\20D8;
                      db $C7,$C7,$A7,$18,$A7,$C7          ;;20E0|20E0/20E0\20E0;
                                                          ;;                   ;
MusicB3S03P0E:        db $DA,$04,$DB,$0C,$DE,$21,$1A,$37  ;;20E6|20E6/20E6\20E6;
                      db $18,$4D,$AD,$08,$C7,$C7,$AD,$18  ;;20EE|20EE/20EE\20EE;
                      db $AD,$08,$C7,$C7,$AF,$18,$AF,$08  ;;20F6|20F6/20F6\20F6;
                      db $C7,$C7,$AF,$18,$AF,$C7          ;;20FE|20FE/20FE\20FE;
                                                          ;;                   ;
MusicB3S03P0B:        db $DA,$04,$DB,$0A,$DE,$22,$18,$36  ;;2104|2104/2104\2104;
                      db $18,$4D,$A9,$08,$C7,$C7,$A9,$18  ;;210C|210C/210C\210C;
                      db $A9,$08,$C7,$C7,$AB,$18,$AB,$08  ;;2114|2114/2114\2114;
                      db $C7,$C7,$AB,$18,$AB,$C7          ;;211C|211C/211C\211C;
                                                          ;;                   ;
MusicB3S03P0D:        db $DA,$04,$DB,$0F,$08,$4D,$C7,$C7  ;;2122|2122/2122\2122;
                      db $9A,$18,$9A,$08,$C7,$C7,$9A,$18  ;;212A|212A/212A\212A;
                      db $9A,$08,$C7,$C7,$9F,$18,$9F,$18  ;;2132|2132/2132\2132;
                      db $C7,$18,$7D,$9F                  ;;213A|213A/213A\213A;
                                                          ;;                   ;
MusicB3S03P0C:        db $DA,$04,$DB,$0F,$08,$4C,$C7,$C7  ;;213E|213E/213E\213E;
                      db $8E,$18,$8E,$08,$C7,$C7,$8E,$18  ;;2146|2146/2146\2146;
                      db $8E,$08,$C7,$C7,$93,$18,$93,$18  ;;214E|214E/214E\214E;
                      db $C7,$18,$7E,$93                  ;;2156|2156/2156\2156;
                                                          ;;                   ;
MusicB3S03P0A:        db $DA,$08,$DB,$0A,$DE,$22,$19,$38  ;;215A|215A/215A\215A;
                      db $08,$5F,$C7,$C7,$8E,$18,$8E,$08  ;;2162|2162/2162\2162;
                      db $C7,$C7,$8E,$18,$8E,$08,$C7,$C7  ;;216A|216A/216A\216A;
                      db $93,$18,$93,$18,$C7,$18,$7F,$93  ;;2172|2172/2172\2172;
                                                          ;;                   ;
MusicB3S03P0F:        db $DA,$00,$DB,$0A,$08,$6C,$C7,$C7  ;;217A|217A/217A\217A;
                      db $D0,$18,$D0,$08,$C7,$C7,$D0,$18  ;;2182|2182/2182\2182;
                      db $D0,$08,$C7,$C7,$D0,$18,$D0,$18  ;;218A|218A/218A\218A;
                      db $C7,$D0                          ;;2192|2192/2192\2192;
                                                          ;;                   ;
MusicB3S01P00:        db $24,$C7,$00                      ;;2194|2194/2194\2194;
                                                          ;;                   ;
MusicB3S01P01:        db $DA,$04,$E2,$16,$E3,$90,$1C,$DB  ;;2197|2197/2197\2197;
                      db $0A,$DE,$22,$19,$38,$18,$4C,$B4  ;;219F|219F/219F\219F;
                      db $08,$C7,$C7,$B4,$18,$B4,$08,$C7  ;;21A7|21A7/21A7\21A7;
                      db $C7,$B7,$18,$B7,$08,$C7,$C7,$B7  ;;21AF|21AF/21AF\21AF;
                      db $18,$B7,$C7,$00                  ;;21B7|21B7/21B7\21B7;
                                                          ;;                   ;
MusicB3S01P02:        db $DA,$04,$DB,$08,$DE,$20,$18,$36  ;;21BB|21BB/21BB\21BB;
                      db $18,$4C,$A4,$08,$C7,$C7,$A4,$18  ;;21C3|21C3/21C3\21C3;
                      db $A4,$08,$C7,$C7,$A7,$18,$A7,$08  ;;21CB|21CB/21CB\21CB;
                      db $C7,$C7,$A7,$18,$A7,$C7          ;;21D3|21D3/21D3\21D3;
                                                          ;;                   ;
MusicB3S01P07:        db $DA,$04,$DB,$0C,$DE,$21,$1A,$37  ;;21D9|21D9/21D9\21D9;
                      db $18,$4C,$AD,$08,$C7,$C7,$AD,$18  ;;21E1|21E1/21E1\21E1;
                      db $AD,$08,$C7,$C7,$AF,$18,$AF,$08  ;;21E9|21E9/21E9\21E9;
                      db $C7,$C7,$AF,$18,$AF,$C7          ;;21F1|21F1/21F1\21F1;
                                                          ;;                   ;
MusicB3S01P04:        db $DA,$04,$DB,$0A,$DE,$22,$18,$36  ;;21F7|21F7/21F7\21F7;
                      db $18,$4C,$A9,$08,$C7,$C7,$A9,$18  ;;21FF|21FF/21FF\21FF;
                      db $A9,$08,$C7,$C7,$AB,$18,$AB,$08  ;;2207|2207/2207\2207;
                      db $C7,$C7,$AB,$18,$AB,$C7          ;;220F|220F/220F\220F;
                                                          ;;                   ;
MusicB3S01P06:        db $DA,$04,$DB,$0F,$08,$4C,$C7,$C7  ;;2215|2215/2215\2215;
                      db $9A,$18,$9A,$08,$C7,$C7,$9A,$18  ;;221D|221D/221D\221D;
                      db $9A,$08,$C7,$C7,$9F,$18,$9F,$08  ;;2225|2225/2225\2225;
                      db $C7,$C7,$C7,$18,$7D,$9F          ;;222D|222D/222D\222D;
                                                          ;;                   ;
MusicB3S01P05:        db $DA,$04,$DB,$0F,$08,$4B,$C7,$C7  ;;2233|2233/2233\2233;
                      db $8E,$18,$8E,$08,$C7,$C7,$8E,$18  ;;223B|223B/223B\223B;
                      db $8E,$08,$C7,$C7,$93,$18,$93,$08  ;;2243|2243/2243\2243;
                      db $C7,$C7,$C7,$18,$7E,$93          ;;224B|224B/224B\224B;
                                                          ;;                   ;
MusicB3S01P03:        db $DA,$08,$DB,$0A,$DE,$22,$19,$38  ;;2251|2251/2251\2251;
                      db $08,$5E,$C7,$C7,$8E,$18,$8E,$08  ;;2259|2259/2259\2259;
                      db $C7,$C7,$8E,$18,$8E,$08,$C7,$C7  ;;2261|2261/2261\2261;
                      db $93,$18,$93,$08,$C7,$C7,$C7,$18  ;;2269|2269/2269\2269;
                      db $7F,$93                          ;;2271|2271/2271\2271;
                                                          ;;                   ;
MusicB3S01P08:        db $DA,$00,$DB,$0A,$08,$6B,$C7,$C7  ;;2273|2273/2273\2273;
                      db $D0,$18,$D0,$08,$C7,$C7,$D0,$18  ;;227B|227B/227B\227B;
                      db $D0,$08,$C7,$C7,$D0,$18,$D0,$C7  ;;2283|2283/2283\2283;
                      db $08,$D0,$DB,$14,$08,$D1,$D1      ;;228B|228B/228B\228B;
                                                          ;;                   ;
MusicB3S01P09:        db $DA,$00,$DB,$0A,$DE,$22,$19,$38  ;;2292|2292/2292\2292;
                      db $08,$5D,$A8,$C7,$AB,$AD,$C7,$24  ;;229A|229A/229A\229A;
                      db $AB,$0C,$C7,$08,$AD,$AF,$C7,$B0  ;;22A2|22A2/22A2\22A2;
                      db $AF,$AE,$24,$AD,$0C,$C7,$08,$A7  ;;22AA|22AA/22AA\22AA;
                      db $A8,$C7,$AB,$AD,$C7,$24,$AB,$0C  ;;22B2|22B2/22B2\22B2;
                      db $C7,$08,$AC,$AD,$C7,$AE,$AD,$AC  ;;22BA|22BA/22BA\22BA;
                      db $24,$AB,$0C,$C7,$08,$AC,$00      ;;22C2|22C2/22C2\22C2;
                                                          ;;                   ;
MusicB3S01P13:        db $DA,$06,$DB,$0A,$DE,$22,$19,$38  ;;22C9|22C9/22C9\22C9;
                                                          ;;                   ;
MusicB3S01P2A:        db $08,$5D,$A8,$C7,$AB,$AD,$C7,$24  ;;22D1|22D1/22D1\22D1;
                      db $AB,$0C,$C7,$08,$AD,$AF,$C7,$B0  ;;22D9|22D9/22D9\22D9;
                      db $AF,$AE,$24,$AD,$0C,$C7,$08,$A7  ;;22E1|22E1/22E1\22E1;
                      db $A8,$C7,$AB,$AD,$C7,$24,$AB,$0C  ;;22E9|22E9/22E9\22E9;
                      db $C7,$08,$AC,$AD,$C7,$AE,$AD,$AC  ;;22F1|22F1/22F1\22F1;
                      db $24,$AB,$0C,$C7,$08,$AC,$00      ;;22F9|22F9/22F9\22F9;
                                                          ;;                   ;
MusicB3S01P14:        db $DA,$12,$DB,$05,$DE,$22,$19,$28  ;;2300|2300/2300\2300;
                      db $60,$6B,$B4,$30,$B3,$08,$C6,$C6  ;;2308|2308/2308\2308;
                      db $B3,$BB,$C6,$B9,$48,$B7,$18,$B2  ;;2310|2310/2310\2310;
                      db $60,$B1                          ;;2318|2318/2318\2318;
                                                          ;;                   ;
MusicB3S01P15:        db $DA,$06,$DB,$08,$DE,$14,$1F,$30  ;;231A|231A/231A\231A;
                      db $08,$6B,$A4,$C7,$A4,$A8,$C7,$24  ;;2322|2322/2322\2322;
                      db $A4,$0C,$C7,$08,$A8,$AB,$C7,$AB  ;;232A|232A/232A\232A;
                      db $A7,$A7,$24,$A7,$0C,$C7,$08,$A3  ;;2332|2332/2332\2332;
                      db $A2,$C7,$A6,$A6,$C7,$24,$A6,$0C  ;;233A|233A/233A\233A;
                      db $C7,$08,$A6,$A8,$C7,$AB,$A8,$A8  ;;2342|2342/2342\2342;
                      db $24,$A8,$0C,$C7,$08,$A8          ;;234A|234A/234A\234A;
                                                          ;;                   ;
MusicB3S01P2C:        db $08,$6D,$A4,$C7,$A4,$A8,$C7,$24  ;;2350|2350/2350\2350;
                      db $A4,$0C,$C7,$08,$A8,$AB,$C7,$AB  ;;2358|2358/2358\2358;
                      db $A7,$A7,$24,$A7,$0C,$C7,$08,$A3  ;;2360|2360/2360\2360;
                      db $A2,$C7,$A6,$A6,$C7,$24,$A6,$0C  ;;2368|2368/2368\2368;
                      db $C7,$08,$A6,$A8,$C7,$AB,$A8,$A8  ;;2370|2370/2370\2370;
                      db $24,$A8,$0C,$C7,$08,$A8          ;;2378|2378/2378\2378;
                                                          ;;                   ;
MusicB3S01P2B:        db $DA,$06,$DB,$0C,$DE,$14,$1F,$30  ;;237E|237E/237E\237E;
                      db $08,$6D,$9F,$C7,$A8,$A4,$C7,$24  ;;2386|2386/2386\2386;
                      db $A8,$0C,$C7,$08,$A4,$A7,$C7,$A7  ;;238E|238E/238E\238E;
                      db $AB,$AB,$24,$A3,$0C,$C7,$08,$9F  ;;2396|2396/2396\2396;
                      db $9F,$C7,$A2,$A2,$C7,$24,$A2,$0C  ;;239E|239E/239E\239E;
                      db $C7,$08,$A2,$A5,$C7,$A8,$A5,$A5  ;;23A6|23A6/23A6\23A6;
                      db $24,$A5,$0C,$C7,$08,$A5          ;;23AE|23AE/23AE\23AE;
                                                          ;;                   ;
MusicB3S01P0A:        db $DA,$0D,$DB,$0F,$01,$C7,$18,$4E  ;;23B4|23B4/23B4\23B4;
                      db $C7,$9F,$C7,$9F,$C7,$9F,$C7,$9F  ;;23BC|23BC/23BC\23BC;
                      db $C7,$9F,$C7,$9F,$C7,$9F,$C7,$9F  ;;23C4|23C4/23C4\23C4;
                                                          ;;                   ;
MusicB3S01P0C:        db $DA,$0D,$DB,$0F,$18,$4E,$C7,$9C  ;;23CC|23CC/23CC\23CC;
                      db $C7,$9C,$C7,$9B,$C7,$9B,$C7,$9A  ;;23D4|23D4/23D4\23D4;
                      db $C7,$9A,$C7,$99,$C7,$99          ;;23DC|23DC/23DC\23DC;
                                                          ;;                   ;
MusicB3S01P0B:        db $DA,$08,$DB,$0A,$DE,$14,$1F,$30  ;;23E2|23E2/23E2\23E2;
                      db $18,$6F,$98,$C7,$18,$93,$08,$C7  ;;23EA|23EA/23EA\23EA;
                      db $C7,$93,$18,$97,$C7,$18,$93,$08  ;;23F2|23F2/23F2\23F2;
                      db $C7,$C7,$93,$18,$96,$C7,$18,$93  ;;23FA|23FA/23FA\23FA;
                      db $08,$C7,$C7,$93,$18,$95,$C7,$18  ;;2402|2402/2402\2402;
                      db $90,$08,$C7,$C7,$90              ;;240A|240A/240A\240A;
                                                          ;;                   ;
MusicB3S01P0D:        db $DA,$00,$DB,$14,$18,$6B,$D1,$08  ;;240F|240F/240F\240F;
                      db $D2,$C7,$D1,$18,$D1,$08,$D2,$C7  ;;2417|2417/2417\2417;
                      db $D1,$18,$D1,$08,$D2,$C7,$D1,$D1  ;;241F|241F/241F\241F;
                      db $C7,$D1,$D2,$D1,$D1,$18,$D1,$08  ;;2427|2427/2427\2427;
                      db $D2,$C7,$D1,$18,$D1,$08,$D2,$C7  ;;242F|242F/242F\242F;
                      db $D1,$18,$D1,$08,$D2,$C7,$D1,$D1  ;;2437|2437/2437\2437;
                      db $C7,$D1,$D2,$D1,$D1              ;;243F|243F/243F\243F;
                                                          ;;                   ;
MusicB3S01P0E:        db $08,$AD,$C7,$AF,$B0,$C7,$24,$AD  ;;2444|2444/2444\2444;
                      db $0C,$C7,$08,$AC,$AB,$C7,$AC,$AD  ;;244C|244C/244C\244C;
                      db $C7,$24,$A8,$0C,$C7,$08,$C7,$A8  ;;2454|2454/2454\2454;
                      db $C7,$A4,$A1,$C7,$A8,$A4,$C7,$A1  ;;245C|245C/245C\245C;
                      db $A4,$C7,$AB,$30,$C6,$C7,$00      ;;2464|2464/2464\2464;
                                                          ;;                   ;
MusicB3S01P0F:        db $01,$C7,$18,$C7,$9D,$C7,$9E,$C7  ;;246B|246B/246B\246B;
                      db $9F,$C7,$9F,$18,$9E,$08,$C7,$C7  ;;2473|2473/2473\2473;
                      db $9E,$18,$C6,$08,$9E,$C7,$9F,$18  ;;247B|247B/247B\247B;
                      db $C6,$08,$C7,$C7,$A3,$A4,$C7,$A4  ;;2483|2483/2483\2483;
                      db $A6,$C7,$A6                      ;;248B|248B/248B\248B;
                                                          ;;                   ;
MusicB3S01P11:        db $18,$C7,$98,$C7,$98,$C7,$9A,$C7  ;;248E|248E/248E\248E;
                      db $99,$18,$A1,$08,$C7,$C7,$A1,$18  ;;2496|2496/2496\2496;
                      db $C6,$08,$A1,$C7,$A3,$18,$C6,$08  ;;249E|249E/249E\249E;
                      db $C7,$C7,$9A,$9C,$C7,$9C,$9D,$C7  ;;24A6|24A6/24A6\24A6;
                      db $9D                              ;;24AE|24AE/24AE\24AE;
                                                          ;;                   ;
MusicB3S01P10:        db $18,$91,$08,$C7,$C7,$91,$18,$92  ;;24AF|24AF/24AF\24AF;
                      db $08,$C7,$C7,$92,$18,$93,$08,$C7  ;;24B7|24B7/24B7\24B7;
                      db $C7,$93,$18,$95,$08,$95,$90,$8F  ;;24BF|24BF/24BF\24BF;
                      db $18,$8E,$08,$C6,$C7,$8E,$18,$C6  ;;24C7|24C7/24C7\24C7;
                      db $08,$8E,$C7,$93,$18,$C6,$08,$C7  ;;24CF|24CF/24CF\24CF;
                      db $C7,$93,$95,$C7,$95,$97,$C7,$97  ;;24D7|24D7/24D7\24D7;
                                                          ;;                   ;
MusicB3S01P12:        db $18,$D1,$08,$D2,$C7,$D1,$18,$D1  ;;24DF|24DF/24DF\24DF;
                      db $08,$D2,$C7,$D1,$18,$D1,$08,$D2  ;;24E7|24E7/24E7\24E7;
                      db $C7,$D1,$D1,$C7,$D1,$D2,$D1,$D1  ;;24EF|24EF/24EF\24EF;
                      db $18,$D2,$08,$C6,$C7,$D2,$18,$C6  ;;24F7|24F7/24F7\24F7;
                      db $08,$D2,$C7,$D2,$18,$C6,$08,$C6  ;;24FF|24FF/24FF\24FF;
                      db $C7,$D1,$D2,$C7,$D1,$D2,$D1,$D1  ;;2507|2507/2507\2507;
                                                          ;;                   ;
MusicB3S01P1A:        db $08,$A9,$C7,$A9,$AD,$C7,$24,$AA  ;;250F|250F/250F\250F;
                      db $0C,$C7,$08,$A9,$A8,$C7,$A8,$A8  ;;2517|2517/2517\2517;
                      db $C7,$24,$AB,$0C,$C7,$08,$C7,$AD  ;;251F|251F/251F\251F;
                      db $C7,$AD,$AD,$C7,$A9,$C7,$C7,$A9  ;;2527|2527/2527\2527;
                      db $A9,$C7,$A8,$30,$C6,$C7          ;;252F|252F/252F\252F;
                                                          ;;                   ;
MusicB3S01P16:        db $08,$AD,$C7,$AF,$B0,$C7,$24,$AD  ;;2535|2535/2535\2535;
                      db $0C,$C7,$08,$AC,$AB,$C7,$AC,$AD  ;;253D|253D/253D\253D;
                      db $C7,$24,$B4,$0C,$C7,$08,$C7,$B4  ;;2545|2545/2545\2545;
                      db $C7,$B3,$B4,$C7,$B0,$C7,$C7,$B0  ;;254D|254D/254D\254D;
                      db $AD,$C7,$B0,$30,$C6,$C7,$00      ;;2555|2555/2555\2555;
                                                          ;;                   ;
MusicB3S01P19:        db $48,$B0,$08,$AD,$C6,$B0,$48,$B4  ;;255C|255C/255C\255C;
                      db $08,$B3,$C6,$B4,$30,$B9,$30,$B4  ;;2564|2564/2564\2564;
                      db $60,$B0                          ;;256C|256C/256C\256C;
                                                          ;;                   ;
MusicB3S01P17:        db $01,$C7,$18,$C7,$9D,$C7,$9E,$C7  ;;256E|256E/256E\256E;
                      db $9F,$C7,$9F,$18,$9E,$08,$C7,$C7  ;;2576|2576/2576\2576;
                      db $9D,$18,$C6,$08,$C7,$C7,$AB,$18  ;;257E|257E/257E\257E;
                      db $C6,$08,$B0,$C7,$B0,$AF,$C7,$AF  ;;2586|2586/2586\2586;
                      db $AE,$C7,$AE                      ;;258E|258E/258E\258E;
                                                          ;;                   ;
MusicB3S01P1B:        db $18,$C7,$98,$C7,$98,$C7,$9A,$C7  ;;2591|2591/2591\2591;
                      db $99,$18,$A1,$08,$C7,$C7,$A3,$18  ;;2599|2599/2599\2599;
                      db $C6,$08,$C7,$C7,$A4,$18,$C6,$08  ;;25A1|25A1/25A1\25A1;
                      db $A8,$C7,$A8,$A7,$C7,$A7,$A6,$C7  ;;25A9|25A9/25A9\25A9;
                      db $A6                              ;;25B1|25B1/25B1\25B1;
                                                          ;;                   ;
MusicB3S01P18:        db $18,$91,$08,$C7,$C7,$91,$18,$92  ;;25B2|25B2/25B2\25B2;
                      db $08,$C7,$C7,$92,$18,$93,$08,$C7  ;;25BA|25BA/25BA\25BA;
                      db $C7,$93,$18,$95,$08,$95,$90,$8F  ;;25C2|25C2/25C2\25C2;
                      db $18,$8E,$08,$C6,$C7,$93,$18,$C6  ;;25CA|25CA/25CA\25CA;
                      db $08,$C7,$C7,$98,$18,$C6,$08,$98  ;;25D2|25D2/25D2\25D2;
                      db $C7,$98,$97,$C7,$97,$96,$C7,$96  ;;25DA|25DA/25DA\25DA;
                                                          ;;                   ;
MusicB3S01P1C:        db $18,$D1,$08,$D2,$C7,$D1,$18,$D1  ;;25E2|25E2/25E2\25E2;
                      db $08,$D2,$C7,$D1,$18,$D1,$08,$D2  ;;25EA|25EA/25EA\25EA;
                      db $C7,$D1,$D1,$C7,$D1,$D2,$D1,$D1  ;;25F2|25F2/25F2\25F2;
                      db $18,$D2,$08,$C6,$C7,$D2,$18,$C6  ;;25FA|25FA/25FA\25FA;
                      db $08,$C7,$C7,$D2,$18,$C6,$08,$D2  ;;2602|2602/2602\2602;
                      db $C7,$D1,$D2,$C7,$D1,$D2,$C7,$D1  ;;260A|260A/260A\260A;
                                                          ;;                   ;
MusicB3S01P1D:        db $DA,$04,$18,$6C,$AD,$B4,$08,$B4  ;;2612|2612/2612\2612;
                      db $C7,$B4,$B3,$C7,$B4,$B5,$C6,$B4  ;;261A|261A/261A\261A;
                      db $B1,$C7,$24,$AD,$0C,$C7,$08,$AD  ;;2622|2622/2622\2622;
                      db $B4,$C6,$B2,$B4,$C6,$B2,$B4,$C6  ;;262A|262A/262A\262A;
                      db $B2,$B0,$C7,$AD,$30,$C6,$C7,$00  ;;2632|2632/2632\2632;
                                                          ;;                   ;
MusicB3S01P21:        db $DA,$04,$18,$6B,$A8,$AB,$08,$AB  ;;263A|263A/263A\263A;
                      db $C7,$AB,$AA,$C7,$AB,$AD,$C6,$AB  ;;2642|2642/2642\2642;
                      db $A8,$C7,$24,$A5,$0C,$C7,$08,$A5  ;;264A|264A/264A\264A;
                      db $AB,$C6,$AA,$AB,$C6,$AA,$AB,$C6  ;;2652|2652/2652\2652;
                      db $AA,$A8,$C7,$A4,$30,$C6,$C7      ;;265A|265A/265A\265A;
                                                          ;;                   ;
MusicB3S01P20:        db $18,$C7,$08,$AD,$C6,$AC,$AD,$C6  ;;2661|2661/2661\2661;
                      db $B4,$C6,$C6,$AD,$AD,$C6,$AC,$AD  ;;2669|2669/2669\2669;
                      db $C6,$B4,$C6,$C6,$AD,$AF,$C6,$B1  ;;2671|2671/2671\2671;
                      db $18,$C7,$08,$AD,$C6,$AC,$AD,$C6  ;;2679|2679/2679\2679;
                      db $B2,$C6,$C6,$AD,$AD,$C6,$AC,$AD  ;;2681|2681/2681\2681;
                      db $C6,$B2,$30,$C6                  ;;2689|2689/2689\2689;
                                                          ;;                   ;
MusicB3S01P1E:        db $01,$C7,$18,$C7,$9F,$C7,$9F,$C7  ;;268D|268D/268D\268D;
                      db $9F,$C7,$9F,$C7,$9E,$C7,$9E,$C7  ;;2695|2695/2695\2695;
                      db $9E,$C7,$9E                      ;;269D|269D/269D\269D;
                                                          ;;                   ;
MusicB3S01P22:        db $18,$C7,$99,$C7,$99,$C7,$99,$C7  ;;26A0|26A0/26A0\26A0;
                      db $99,$C7,$98,$C7,$98,$C7,$98,$C7  ;;26A8|26A8/26A8\26A8;
                      db $98                              ;;26B0|26B0/26B0\26B0;
                                                          ;;                   ;
MusicB3S01P1F:        db $18,$95,$08,$C7,$C7,$95,$18,$90  ;;26B1|26B1/26B1\26B1;
                      db $08,$C7,$C7,$90,$18,$95,$08,$C7  ;;26B9|26B9/26B9\26B9;
                      db $C7,$95,$18,$95,$08,$95,$90,$8F  ;;26C1|26C1/26C1\26C1;
                      db $18,$8E,$08,$C7,$C7,$8E,$18,$95  ;;26C9|26C9/26C9\26C9;
                      db $08,$C7,$C7,$95,$18,$8E,$08,$C7  ;;26D1|26D1/26D1\26D1;
                      db $C7,$8E,$8E,$C7,$8E,$90,$C7,$92  ;;26D9|26D9/26D9\26D9;
                                                          ;;                   ;
MusicB3S01P23:        db $18,$D1,$08,$D2,$C7,$D1,$18,$D1  ;;26E1|26E1/26E1\26E1;
                      db $08,$D2,$C7,$D1,$18,$D1,$08,$D2  ;;26E9|26E9/26E9\26E9;
                      db $C7,$D1,$D1,$C7,$D1,$D2,$D1,$D1  ;;26F1|26F1/26F1\26F1;
                      db $18,$D1,$08,$D2,$C7,$D1,$18,$D1  ;;26F9|26F9/26F9\26F9;
                      db $08,$D2,$C7,$D1,$18,$D1,$08,$D2  ;;2701|2701/2701\2701;
                      db $C7,$D1,$D2,$C7,$D1,$D2,$C7,$D1  ;;2709|2709/2709\2709;
                                                          ;;                   ;
MusicB3S01P24:        db $18,$AB,$B2,$08,$B2,$C7,$B2,$B1  ;;2711|2711/2711\2711;
                      db $C7,$B2,$B4,$C6,$B2,$AF,$C7,$24  ;;2719|2719/2719\2719;
                      db $AB,$0C,$C7,$08,$B2,$18,$B0,$B0  ;;2721|2721/2721\2721;
                      db $10,$B0,$B2,$B3,$18,$B4,$C7,$AB  ;;2729|2729/2729\2729;
                      db $C6,$00                          ;;2731|2731/2731\2731;
                                                          ;;                   ;
MusicB3S01P28:        db $18,$A3,$A9,$08,$A9,$C7,$A9,$A8  ;;2733|2733/2733\2733;
                      db $C7,$A9,$AB,$C6,$A9,$A6,$C7,$24  ;;273B|273B/273B\273B;
                      db $A3,$0C,$C7,$08,$A9,$18,$A8,$A8  ;;2743|2743/2743\2743;
                      db $10,$A8,$A9,$AA,$18,$AB,$C7,$A3  ;;274B|274B/274B\274B;
                      db $C6                              ;;2753|2753/2753\2753;
                                                          ;;                   ;
MusicB3S01P27:        db $18,$C7,$08,$AB,$C6,$AA,$AB,$C6  ;;2754|2754/2754\2754;
                      db $B2,$C6,$C6,$AB,$AB,$C6,$AA,$AB  ;;275C|275C/275C\275C;
                      db $C6,$B2,$C6,$C6,$AB,$AD,$C6,$AF  ;;2764|2764/2764\2764;
                      db $30,$B0,$10,$B0,$AF,$AD,$AB,$06  ;;276C|276C/276C\276C;
                      db $AD,$AF,$B0,$B2,$B3,$B4,$B5,$B6  ;;2774|2774/2774\2774;
                      db $30,$B7                          ;;277C|277C/277C\277C;
                                                          ;;                   ;
MusicB3S01P25:        db $01,$C7,$18,$C7,$9D,$C7,$9D,$C7  ;;277E|277E/277E\277E;
                      db $9D,$C7,$9D,$C7,$9C,$10,$9C,$9D  ;;2786|2786/2786\2786;
                      db $9E,$18,$9F,$C7,$9B,$C6          ;;278E|278E/278E\278E;
                                                          ;;                   ;
MusicB3S01P29:        db $18,$C7,$97,$C7,$97,$C7,$97,$C7  ;;2794|2794/2794\2794;
                      db $97,$C7,$9F,$10,$9F,$A0,$A1,$18  ;;279C|279C/279C\279C;
                      db $A3,$C7,$A3,$C6                  ;;27A4|27A4/27A4\27A4;
                                                          ;;                   ;
MusicB3S01P26:        db $18,$93,$08,$C7,$C7,$93,$18,$8E  ;;27A8|27A8/27A8\27A8;
                      db $08,$C7,$C7,$8E,$18,$93,$08,$C7  ;;27B0|27B0/27B0\27B0;
                      db $C7,$93,$18,$93,$08,$93,$95,$97  ;;27B8|27B8/27B8\27B8;
                      db $18,$98,$08,$C7,$C7,$98,$10,$98  ;;27C0|27C0/27C0\27C0;
                      db $9A,$9B,$18,$9C,$C7,$93,$C6,$18  ;;27C8|27C8/27C8\27C8;
                      db $D1,$08,$D2,$C7,$D1,$18,$D1,$08  ;;27D0|27D0/27D0\27D0;
                      db $D2,$C7,$D1,$18,$D1,$08,$D2,$C7  ;;27D8|27D8/27D8\27D8;
                      db $D1,$D1,$C7,$D1,$D2,$D1,$D1,$18  ;;27E0|27E0/27E0\27E0;
                      db $D1,$08,$D2,$C7,$D1,$10,$D2,$D2  ;;27E8|27E8/27E8\27E8;
                      db $D2,$18,$D1,$08,$D2,$C7,$D1,$D2  ;;27F0|27F0/27F0\27F0;
                      db $C7,$D1,$D2,$D1,$D1              ;;27F8|27F8/27F8\27F8;
                                                          ;;                   ;
MusicB3S01P32:        db $08,$A9,$C7,$A9,$AD,$C7,$24,$AA  ;;27FD|27FD/27FD\27FD;
                      db $0C,$C7,$08,$A9,$A8,$C7,$A8,$A8  ;;2805|2805/2805\2805;
                      db $C7,$24,$AB,$0C,$C7,$08,$C7      ;;280D|280D/280D\280D;
                                                          ;;                   ;
MusicB3S01P2D:        db $08,$AD,$C7,$AF,$B0,$C7,$24,$AD  ;;2814|2814/2814\2814;
                      db $0C,$C7,$08,$AC,$AB,$C7,$AC,$AD  ;;281C|281C/281C\281C;
                      db $C7,$24,$B4,$0C,$C7,$08,$C7,$00  ;;2824|2824/2824\2824;
                                                          ;;                   ;
MusicB3S01P31:        db $DA,$04,$DB,$0C,$DE,$22,$18,$14  ;;282C|282C/282C\282C;
                      db $08,$5C,$A4,$C7,$A4,$A9,$C7,$24  ;;2834|2834/2834\2834;
                      db $A4,$0C,$C7,$08,$A4,$A4,$C7,$A4  ;;283C|283C/283C\283C;
                      db $A4,$C7,$24,$A5,$0C,$C7,$08,$C7  ;;2844|2844/2844\2844;
                                                          ;;                   ;
MusicB3S01P30:        db $48,$B0,$08,$AD,$C6,$B0,$60,$B4  ;;284C|284C/284C\284C;
                                                          ;;                   ;
MusicB3S01P2E:        db $01,$C7,$18,$C7,$9D,$C7,$9E,$C7  ;;2854|2854/2854\2854;
                      db $9F,$C7,$9F,$18,$9E,$08,$C7,$C7  ;;285C|285C/285C\285C;
                      db $9D,$18,$C6,$08,$C7,$C7,$AB      ;;2864|2864/2864\2864;
                                                          ;;                   ;
MusicB3S01P33:        db $18,$C7,$98,$C7,$98,$C7,$9A,$C7  ;;286B|286B/286B\286B;
                      db $99,$18,$A1,$08,$C7,$C7,$A3,$18  ;;2873|2873/2873\2873;
                      db $C6,$08,$C7,$C7,$A4              ;;287B|287B/287B\287B;
                                                          ;;                   ;
MusicB3S01P2F:        db $18,$91,$08,$C7,$C7,$91,$18,$92  ;;2880|2880/2880\2880;
                      db $08,$C7,$C7,$92,$18,$93,$08,$C7  ;;2888|2888/2888\2888;
                      db $C7,$93,$18,$95,$08,$95,$90,$8F  ;;2890|2890/2890\2890;
                      db $18,$8E,$08,$C6,$C7,$93,$18,$C6  ;;2898|2898/2898\2898;
                      db $08,$C7,$C7,$98                  ;;28A0|28A0/28A0\28A0;
                                                          ;;                   ;
MusicB3S01P34:        db $18,$D1,$08,$D2,$C7,$D1,$18,$D1  ;;28A4|28A4/28A4\28A4;
                      db $08,$D2,$C7,$D1,$18,$D1,$08,$D2  ;;28AC|28AC/28AC\28AC;
                      db $C7,$D1,$D1,$C7,$D1,$D2,$D1,$D1  ;;28B4|28B4/28B4\28B4;
                      db $18,$D2,$08,$C6,$C7,$D2,$18,$C6  ;;28BC|28BC/28BC\28BC;
                      db $08,$C7,$C7,$D2                  ;;28C4|28C4/28C4\28C4;
                                                          ;;                   ;
MusicB3S01P35:        db $DA,$04,$DB,$0A,$DE,$22,$19,$38  ;;28C8|28C8/28C8\28C8;
                      db $18,$4D,$B4,$08,$C7,$C7,$B4,$18  ;;28D0|28D0/28D0\28D0;
                      db $B4,$08,$C7,$C7,$B7,$18,$B7,$08  ;;28D8|28D8/28D8\28D8;
                      db $C7,$C7,$B7,$18,$B7,$C7,$00      ;;28E0|28E0/28E0\28E0;
                                                          ;;                   ;
MusicB3S01P36:        db $DA,$04,$DB,$08,$DE,$20,$18,$36  ;;28E7|28E7/28E7\28E7;
                      db $18,$4D,$A4,$08,$C7,$C7,$A4,$18  ;;28EF|28EF/28EF\28EF;
                      db $A4,$08,$C7,$C7,$A7,$18,$A7,$08  ;;28F7|28F7/28F7\28F7;
                      db $C7,$C7,$A7,$18,$A7,$C7          ;;28FF|28FF/28FF\28FF;
                                                          ;;                   ;
MusicB3S01P3B:        db $DA,$04,$DB,$0C,$DE,$21,$1A,$37  ;;2905|2905/2905\2905;
                      db $18,$4D,$AD,$08,$C7,$C7,$AD,$18  ;;290D|290D/290D\290D;
                      db $AD,$08,$C7,$C7,$AF,$18,$AF,$08  ;;2915|2915/2915\2915;
                      db $C7,$C7,$AF,$18,$AF,$C7          ;;291D|291D/291D\291D;
                                                          ;;                   ;
MusicB3S01P38:        db $DA,$04,$DB,$0A,$DE,$22,$18,$36  ;;2923|2923/2923\2923;
                      db $18,$4D,$A9,$08,$C7,$C7,$A9,$18  ;;292B|292B/292B\292B;
                      db $A9,$08,$C7,$C7,$AB,$18,$AB,$08  ;;2933|2933/2933\2933;
                      db $C7,$C7,$AB,$18,$AB,$C7          ;;293B|293B/293B\293B;
                                                          ;;                   ;
MusicB3S01P3A:        db $DA,$04,$DB,$0F,$08,$4D,$C7,$C7  ;;2941|2941/2941\2941;
                      db $9A,$18,$9A,$08,$C7,$C7,$9A,$18  ;;2949|2949/2949\2949;
                      db $9A,$08,$C7,$C7,$9F,$18,$9F,$08  ;;2951|2951/2951\2951;
                      db $C7,$C7,$C7,$18,$7D,$9F          ;;2959|2959/2959\2959;
                                                          ;;                   ;
MusicB3S01P39:        db $DA,$04,$DB,$0F,$08,$4C,$C7,$C7  ;;295F|295F/295F\295F;
                      db $8E,$18,$8E,$08,$C7,$C7,$8E,$18  ;;2967|2967/2967\2967;
                      db $8E,$08,$C7,$C7,$93,$18,$93,$08  ;;296F|296F/296F\296F;
                      db $C7,$C7,$C7,$18,$7E,$93          ;;2977|2977/2977\2977;
                                                          ;;                   ;
MusicB3S01P37:        db $DA,$08,$DB,$0A,$DE,$22,$19,$38  ;;297D|297D/297D\297D;
                      db $08,$5F,$C7,$C7,$8E,$18,$8E,$08  ;;2985|2985/2985\2985;
                      db $C7,$C7,$8E,$18,$8E,$08,$C7,$C7  ;;298D|298D/298D\298D;
                      db $93,$18,$93,$08,$C7,$C7,$C7,$18  ;;2995|2995/2995\2995;
                      db $7F,$93                          ;;299D|299D/299D\299D;
                                                          ;;                   ;
MusicB3S01P3C:        db $DA,$00,$DB,$0A,$08,$6C,$C7,$C7  ;;299F|299F/299F\299F;
                      db $D0,$18,$D0,$08,$C7,$C7,$D0,$18  ;;29A7|29A7/29A7\29A7;
                      db $D0,$08,$C7,$C7,$D0,$18,$D0,$C7  ;;29AF|29AF/29AF\29AF;
                      db $08,$D0,$DB,$14,$08,$D1,$D1      ;;29B7|29B7/29B7\29B7;
                                                          ;;                   ;
MusicB3S01P3D:        db $DA,$06,$DB,$0A,$DE,$22,$19,$38  ;;29BE|29BE/29BE\29BE;
                      db $08,$6F,$B4,$C7,$B7,$B9,$C7,$24  ;;29C6|29C6/29C6\29C6;
                      db $B7,$0C,$C7,$08,$B9,$BB,$C7,$BC  ;;29CE|29CE/29CE\29CE;
                      db $BB,$BA,$24,$B9,$0C,$C7,$08,$B3  ;;29D6|29D6/29D6\29D6;
                      db $B4,$C7,$B7,$B9,$C7,$24,$B7,$0C  ;;29DE|29DE/29DE\29DE;
                      db $C7,$08,$B8,$B9,$C7,$BA,$B9,$B8  ;;29E6|29E6/29E6\29E6;
                      db $24,$B7,$0C,$C7,$08,$B8,$00      ;;29EE|29EE/29EE\29EE;
                                                          ;;                   ;
MusicB3S01P3E:        db $08,$B9,$C7,$BB,$BC,$C7,$24,$B9  ;;29F5|29F5/29F5\29F5;
                      db $0C,$C7,$08,$B8,$B7,$C7,$B8,$B9  ;;29FD|29FD/29FD\29FD;
                      db $C7,$24,$C0,$0C,$C7,$08,$C7,$00  ;;2A05|2A05/2A05\2A05;
                                                          ;;                   ;
MusicB3S01P3F:        db $18,$91,$08,$C7,$C7,$91,$18,$92  ;;2A0D|2A0D/2A0D\2A0D;
                      db $08,$C7,$C7,$92,$18,$93,$08,$C7  ;;2A15|2A15/2A15\2A15;
                      db $C7,$93,$18,$95,$08,$C7,$C7,$95  ;;2A1D|2A1D/2A1D\2A1D;
                                                          ;;                   ;
MusicB3S01P50:        db $DA,$04,$DB,$0A,$DE,$22,$19,$38  ;;2A25|2A25/2A25\2A25;
                      db $18,$5D,$C0,$08,$C7,$C7,$C0,$E3  ;;2A2D|2A2D/2A2D\2A2D;
                      db $78,$18,$18,$C0,$08,$C7,$C7,$C3  ;;2A35|2A35/2A35\2A35;
                      db $18,$C3,$08,$C7,$C7,$C3,$18,$C3  ;;2A3D|2A3D/2A3D\2A3D;
                      db $C3,$00                          ;;2A45|2A45/2A45\2A45;
                                                          ;;                   ;
MusicB3S01P40:        db $DA,$04,$DB,$0A,$DE,$22,$19,$38  ;;2A47|2A47/2A47\2A47;
                      db $18,$5D,$C0,$08,$C7,$C7,$C0,$18  ;;2A4F|2A4F/2A4F\2A4F;
                      db $C0,$08,$C7,$C7,$C3,$18,$C3,$08  ;;2A57|2A57/2A57\2A57;
                      db $C7,$C7,$C3,$18,$C3,$C3,$00      ;;2A5F|2A5F/2A5F\2A5F;
                                                          ;;                   ;
MusicB3S01P41:        db $DA,$04,$DB,$08,$DE,$20,$18,$36  ;;2A66|2A66/2A66\2A66;
                      db $18,$5D,$A4,$08,$C7,$C7,$A4,$18  ;;2A6E|2A6E/2A6E\2A6E;
                      db $A4,$08,$C7,$C7,$A7,$18,$A7,$08  ;;2A76|2A76/2A76\2A76;
                      db $C7,$C7,$A7,$18,$A7,$A7          ;;2A7E|2A7E/2A7E\2A7E;
                                                          ;;                   ;
MusicB3S01P46:        db $DA,$04,$DB,$0C,$DE,$21,$1A,$37  ;;2A84|2A84/2A84\2A84;
                      db $18,$5D,$B9,$08,$C7,$C7,$B9,$18  ;;2A8C|2A8C/2A8C\2A8C;
                      db $B9,$08,$C7,$C7,$BB,$18,$BB,$08  ;;2A94|2A94/2A94\2A94;
                      db $C7,$C7,$BB,$18,$BB,$BB          ;;2A9C|2A9C/2A9C\2A9C;
                                                          ;;                   ;
MusicB3S01P43:        db $DA,$04,$DB,$0A,$DE,$22,$18,$36  ;;2AA2|2AA2/2AA2\2AA2;
                      db $18,$5D,$A9,$08,$C7,$C7,$A9,$18  ;;2AAA|2AAA/2AAA\2AAA;
                      db $A9,$08,$C7,$C7,$AB,$18,$AB,$08  ;;2AB2|2AB2/2AB2\2AB2;
                      db $C7,$C7,$AB,$18,$AB,$AB          ;;2ABA|2ABA/2ABA\2ABA;
                                                          ;;                   ;
MusicB3S01P45:        db $DA,$04,$DB,$0F,$08,$5D,$C7,$C7  ;;2AC0|2AC0/2AC0\2AC0;
                      db $9A,$18,$9A,$08,$C7,$C7,$9A,$18  ;;2AC8|2AC8/2AC8\2AC8;
                      db $9A,$08,$C7,$C7,$9F,$18,$9F,$08  ;;2AD0|2AD0/2AD0\2AD0;
                      db $C7,$C7,$9F,$08,$7D,$C7,$C7,$9F  ;;2AD8|2AD8/2AD8\2AD8;
                                                          ;;                   ;
MusicB3S01P44:        db $DA,$04,$DB,$0F,$08,$5C,$C7,$C7  ;;2AE0|2AE0/2AE0\2AE0;
                      db $8E,$18,$8E,$08,$C7,$C7,$8E,$18  ;;2AE8|2AE8/2AE8\2AE8;
                      db $8E,$08,$C7,$C7,$93,$18,$93,$08  ;;2AF0|2AF0/2AF0\2AF0;
                      db $C7,$C7,$93,$08,$7E,$C7,$C7,$93  ;;2AF8|2AF8/2AF8\2AF8;
                                                          ;;                   ;
MusicB3S01P42:        db $DA,$08,$DB,$0A,$DE,$22,$19,$38  ;;2B00|2B00/2B00\2B00;
                      db $08,$5F,$C7,$C7,$8E,$18,$8E,$08  ;;2B08|2B08/2B08\2B08;
                      db $C7,$C7,$8E,$18,$8E,$08,$C7,$C7  ;;2B10|2B10/2B10\2B10;
                      db $93,$18,$93,$08,$C7,$C7,$C7,$08  ;;2B18|2B18/2B18\2B18;
                      db $7F,$C7,$C7,$93                  ;;2B20|2B20/2B20\2B20;
                                                          ;;                   ;
MusicB3S01P47:        db $DA,$00,$DB,$0A,$08,$6C,$C7,$C7  ;;2B24|2B24/2B24\2B24;
                      db $D0,$18,$D0,$08,$C7,$C7,$D0,$18  ;;2B2C|2B2C/2B2C\2B2C;
                      db $D0,$08,$C7,$C7,$D0,$18,$D0,$C7  ;;2B34|2B34/2B34\2B34;
                      db $08,$D0,$DB,$14,$08,$D1,$D1      ;;2B3C|2B3C/2B3C\2B3C;
                                                          ;;                   ;
MusicB3S01P49:        db $DA,$04,$DE,$14,$19,$30,$DB,$0A  ;;2B43|2B43/2B43\2B43;
                      db $08,$4F,$B9,$C6,$B7,$B9,$C6,$24  ;;2B4B|2B4B/2B4B\2B4B;
                      db $B7,$0C,$C6,$08,$B9,$BB,$C6,$C7  ;;2B53|2B53/2B53\2B53;
                      db $BB,$C6,$24,$B9,$0C,$C6,$08,$C6  ;;2B5B|2B5B/2B5B\2B5B;
                      db $B9,$C6,$B7,$B9,$C6,$24,$B7,$0C  ;;2B63|2B63/2B63\2B63;
                      db $C6,$08,$B8,$B9,$C6,$C7,$B9,$C6  ;;2B6B|2B6B/2B6B\2B6B;
                      db $24,$B7,$0C,$C6,$08,$B8          ;;2B73|2B73/2B73\2B73;
                                                          ;;                   ;
MusicB3S01P48:        db $DE,$16,$18,$30,$DB,$0A,$08,$4E  ;;2B79|2B79/2B79\2B79;
                      db $AD,$C6,$AB,$AD,$C6,$24,$AB,$0C  ;;2B81|2B81/2B81\2B81;
                      db $C6,$08,$AD,$AF,$C6,$C7,$AF,$C6  ;;2B89|2B89/2B89\2B89;
                      db $24,$AD,$0C,$C6,$08,$C6,$AD,$C6  ;;2B91|2B91/2B91\2B91;
                      db $AB,$AD,$C6,$24,$AB,$0C,$C7,$08  ;;2B99|2B99/2B99\2B99;
                      db $AC,$AD,$C6,$C7,$AD,$C6,$24,$AB  ;;2BA1|2BA1/2BA1\2BA1;
                      db $0C,$C6,$08,$AC,$00              ;;2BA9|2BA9/2BA9\2BA9;
                                                          ;;                   ;
MusicB3S01P4B:        db $DE,$15,$19,$31,$DB,$08,$08,$4E  ;;2BAE|2BAE/2BAE\2BAE;
                      db $A8,$C6,$A4,$A8,$C6,$24,$A8,$0C  ;;2BB6|2BB6/2BB6\2BB6;
                      db $C6,$08,$A8,$AB,$C6,$C7,$AB,$C6  ;;2BBE|2BBE/2BBE\2BBE;
                      db $24,$A7,$0C,$C6,$08,$C6,$A6,$C6  ;;2BC6|2BC6/2BC6\2BC6;
                      db $A6,$A6,$C6,$24,$A6,$0C,$C6,$08  ;;2BCE|2BCE/2BCE\2BCE;
                      db $A6,$A8,$C6,$C7,$A8,$C6,$24,$A8  ;;2BD6|2BD6/2BD6\2BD6;
                      db $0C,$C6,$08,$A8                  ;;2BDE|2BDE/2BDE\2BDE;
                                                          ;;                   ;
MusicB3S01P4A:        db $DA,$06,$DB,$0C,$DE,$14,$1A,$30  ;;2BE2|2BE2/2BE2\2BE2;
                      db $08,$4E,$A4,$C6,$A4,$A4,$C6,$24  ;;2BEA|2BEA/2BEA\2BEA;
                      db $A4,$0C,$C6,$08,$A4,$A7,$C6,$C7  ;;2BF2|2BF2/2BF2\2BF2;
                      db $A7,$C6,$24,$A3,$0C,$C6,$08,$C6  ;;2BFA|2BFA/2BFA\2BFA;
                      db $A2,$C6,$A2,$A2,$C6,$24,$A2,$0C  ;;2C02|2C02/2C02\2C02;
                      db $C6,$08,$A2,$A5,$C6,$C7,$A5,$C6  ;;2C0A|2C0A/2C0A\2C0A;
                      db $24,$A5,$0C,$C6,$08,$A5          ;;2C12|2C12/2C12\2C12;
                                                          ;;                   ;
MusicB3S01P4D:        db $08,$B9,$C6,$BB,$BC,$C6,$24,$B9  ;;2C18|2C18/2C18\2C18;
                      db $0C,$C6,$08,$B8,$B7,$C6,$B8,$B9  ;;2C20|2C20/2C20\2C20;
                      db $C6,$24,$C0,$0C,$C6,$08,$C6,$00  ;;2C28|2C28/2C28\2C28;
                                                          ;;                   ;
MusicB3S01P4F:        db $08,$A9,$C6,$A9,$AD,$C6,$24,$AA  ;;2C30|2C30/2C30\2C30;
                      db $0C,$C6,$08,$A9,$A8,$C6,$A8,$A8  ;;2C38|2C38/2C38\2C38;
                      db $C6,$24,$AB,$0C,$C6,$08,$C6      ;;2C40|2C40/2C40\2C40;
                                                          ;;                   ;
MusicB3S01P4C:        db $08,$AD,$C6,$AF,$B0,$C6,$24,$AD  ;;2C47|2C47/2C47\2C47;
                      db $0C,$C6,$08,$AC,$AB,$C6,$AC,$AD  ;;2C4F|2C4F/2C4F\2C4F;
                      db $C6,$24,$B4,$0C,$C6,$08,$C6,$00  ;;2C57|2C57/2C57\2C57;
                                                          ;;                   ;
MusicB3S01P4E:        db $DA,$04,$DB,$0C,$DE,$22,$18,$14  ;;2C5F|2C5F/2C5F\2C5F;
                      db $08,$5C,$A4,$C6,$A4,$A9,$C6,$24  ;;2C67|2C67/2C67\2C67;
                      db $A4,$0C,$C6,$08,$A4,$A4,$C6,$A4  ;;2C6F|2C6F/2C6F\2C6F;
                      db $A4,$C6,$24,$A5,$0C,$C6,$08,$C6  ;;2C77|2C77/2C77\2C77;
                                                          ;;                   ;
MusicB3S01P51:        db $DA,$04,$DB,$0A,$DE,$22,$19,$38  ;;2C7F|2C7F/2C7F\2C7F;
                      db $60,$5E,$BC,$C6,$DA,$01,$10,$9F  ;;2C87|2C87/2C87\2C87;
                      db $C6,$C6,$C6,$AF,$C6,$60,$C6,$C6  ;;2C8F|2C8F/2C8F\2C8F;
                      db $00                              ;;2C97|2C97/2C97\2C97;
                                                          ;;                   ;
MusicB3S01P52:        db $DA,$04,$DB,$08,$DE,$20,$18,$36  ;;2C98|2C98/2C98\2C98;
                      db $60,$5D,$B4,$C6,$DA,$01,$10,$C7  ;;2CA0|2CA0/2CA0\2CA0;
                      db $A3,$C6,$C6,$C6,$B3,$60,$C6,$C6  ;;2CA8|2CA8/2CA8\2CA8;
                                                          ;;                   ;
MusicB3S01P57:        db $DA,$04,$DB,$0C,$DE,$21,$1A,$37  ;;2CB0|2CB0/2CB0\2CB0;
                      db $60,$5D,$AB,$C6,$DA,$01,$10,$C7  ;;2CB8|2CB8/2CB8\2CB8;
                      db $C7,$A7,$C6,$C6,$C6,$60,$B7,$C6  ;;2CC0|2CC0/2CC0\2CC0;
                                                          ;;                   ;
MusicB3S01P54:        db $DA,$04,$DB,$0A,$DE,$22,$18,$36  ;;2CC8|2CC8/2CC8\2CC8;
                      db $60,$5D,$A4,$C6,$DA,$01,$10,$C7  ;;2CD0|2CD0/2CD0\2CD0;
                      db $C7,$C7,$AB,$C6,$C6,$60,$C6,$C6  ;;2CD8|2CD8/2CD8\2CD8;
                                                          ;;                   ;
MusicB3S01P56:        db $DA,$04,$DB,$0F,$10,$5D,$A4,$C7  ;;2CE0|2CE0/2CE0\2CE0;
                      db $A4,$A2,$C7,$A2,$A1,$C7,$A1,$A0  ;;2CE8|2CE8/2CE8\2CE8;
                      db $C7,$A0,$60,$9F,$9B,$C6          ;;2CF0|2CF0/2CF0\2CF0;
                                                          ;;                   ;
MusicB3S01P55:        db $DA,$0D,$DB,$0F,$10,$5D,$9C,$C7  ;;2CF6|2CF6/2CF6\2CF6;
                      db $9C,$9C,$C7,$9C,$98,$C7,$98,$98  ;;2CFE|2CFE/2CFE\2CFE;
                      db $C7,$98,$60,$97,$97,$C6          ;;2D06|2D06/2D06\2D06;
                                                          ;;                   ;
MusicB3S01P53:        db $DA,$08,$DB,$0A,$DE,$22,$19,$38  ;;2D0C|2D0C/2D0C\2D0C;
                      db $10,$5D,$98,$C7,$98,$96,$C7,$96  ;;2D14|2D14/2D14\2D14;
                      db $95,$C7,$95,$94,$C7,$94,$60,$93  ;;2D1C|2D1C/2D1C\2D1C;
                      db $93,$C6                          ;;2D24|2D24/2D24\2D24;
                                                          ;;2D26|2D26/2D26\2D26;
                                                          ;;                   ;
                      base off                            ;;                   ;
                                                          ;;                   ;
MusicBank3_End:       dw $0000,!SPCEngine                 ;;FDCA|FDCA/FDCA\FDCA;
                                                          ;;                   ;
                      db $E8,$00,$00,$00,$00              ;;FDCE|FDCE/FDCE\FDCE;
                      db $00,$00,$00,$00,$00,$00,$00,$00  ;;FDD3|FDD3/FDD3\FDD3;
                      db $00,$00,$00,$00,$00              ;;FDDB|FDDB/FDDB\FDDB;
                                                          ;;                   ;
                      padbyte $FF : pad $048000           ;;FDE0|FDE0/FDE0\FDE0;
