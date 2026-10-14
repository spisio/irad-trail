10 REM THE IRAD TRAIL: MS-DOS EDITION
20 REM IRADI AMERICAN ASSOCIATION, CHICAGO 1990. GW-BASIC 3.2, EGA (SCREEN 7)
30 KEY OFF : SCREEN 7 : WIDTH 40 : COLOR 15, 0 : CLS
40 DEFINT I-K : RANDOMIZE TIMER : MUTE = 0 : ON ERROR GOTO 9900
50 DIM PARTY$(5), ALIVE(5), SICK(5), SICKDAYS(5), MARK(13), MARKTYPE(13), MARK$(13), QUOTE$(13), DISEASE$(12), MONTH$(12), MONTHSTART(12), MONTHTEMP(12)
55 DIM PRICE(6), ITEM$(6), ADVICE$(6), BUY(6), TEMPWORD$(4), PACE$(3), RATION$(3), MENU$(7), MAPX(13), MAPY(13), STDNAME$(5), BESTNAME$(10), BESTSCORE(10), BESTRANK$(10), GRAVEV(20), GRAVENAME$(20), GRAVEEPI$(20)
60 DIM CARA%(340), CARB%(340), HUNL%(172), HUNR%(172), ANIM%(1960), RAFT%(205), ROCK%(125), AKIND(2), AX(2), AY(2), AV(2), AW(4), AH(4), MEATOF(4), ANIMAL$(4), RKX(4), RKY(4)
70 FOR I = 1 TO 12 : READ MONTH$(I), MONTHSTART(I), MONTHTEMP(I) : NEXT
72 FOR I = 1 TO 13 : READ MARK(I), MARKTYPE(I), MARK$(I), MAPX(I), MAPY(I) : NEXT
74 FOR I = 1 TO 13 : READ QUOTE$(I) : NEXT
76 FOR I = 1 TO 12 : READ DISEASE$(I) : NEXT
78 FOR I = 1 TO 6 : READ ITEM$(I), PRICE(I), ADVICE$(I) : NEXT
80 FOR I = 0 TO 4 : READ TEMPWORD$(I) : NEXT
82 FOR I = 1 TO 3 : READ PACE$(I), RATION$(I) : NEXT
84 FOR I = 1 TO 7 : READ MENU$(I) : NEXT
86 FOR I = 1 TO 5 : READ STDNAME$(I) : NEXT
88 FOR I = 1 TO 4 : READ ANIMAL$(I), AW(I), AH(I), MEATOF(I) : NEXT
90 LOCATE 12, 15 : PRINT "Loading..." : GOSUB 9500 : GOSUB 8900
100 GOSUB 6000
110 IF MUTE = 0 THEN PLAY "MB T120 O3 L8 E G A4 G E D4 E G A B > D4 < B A G2"
120 LOCATE 25, 10 : COLOR 14 : PRINT "Press any key to begin"; : COLOR 15 : GOSUB 7400
200 CLS : GOSUB 7100 : LOCATE 3, 13 : COLOR 14 : PRINT "The Irad Trail" : COLOR 15
205 LOCATE 6, 5 : PRINT "You may:"
210 LOCATE 8, 7 : PRINT "1. Travel the road"
215 LOCATE 9, 7 : PRINT "2. Learn about the road"
220 LOCATE 10, 7 : PRINT "3. See the Irad Top Ten"
225 LOCATE 11, 7 : IF MUTE THEN PRINT "4. Turn sound on" ELSE PRINT "4. Turn sound off"
230 LOCATE 12, 7 : PRINT "5. Choose management options"
235 LOCATE 13, 7 : PRINT "6. End"
240 LOCATE 16, 5 : PRINT "What is your choice? "; : GOSUB 7450 : K = VAL(K$)
245 ON K GOTO 600, 300, 400, 260, 500, 270
250 GOTO 200
260 MUTE = 1 - MUTE : GOTO 200
270 SCREEN 0 : WIDTH 80 : CLS : PRINT "Jolung bolsun. May your road be open." : END
300 CLS : GOSUB 7100 : LOCATE 3, 4 : COLOR 14 : PRINT "The road south" : COLOR 15 : LOCATE 5, 1
305 S$ = "In 1876 the Russian army took/Kokand. Settlers followed, and many/Iradi clans lost their pastures on/the Chu./ /Your family will ride 690 versts"
306 S$ = S$ + "/south, over three high passes and/four rivers, to settle below the/Church of St. Janyl at Iyik Janyl./ /A verst is about two-thirds of a/mile. A funt is about a pound." : GOSUB 7700
310 GOSUB 7500 : CLS : GOSUB 7100 : LOCATE 3, 4 : COLOR 14 : PRINT "How to play" : COLOR 15 : LOCATE 5, 1
315 S$ = "Buy horses, food, felt coats, powder/and spare tack at Osmon's shop. You/can buy more at Rabat-i-Safed, the/Talas fort and Ketmen-Tobo./ "
316 S$ = S$ + "/On the road, press ENTER to size up/the situation. Change the pace and/rations, rest, trade, talk to people/or hunt." : GOSUB 7700
320 GOSUB 7500 : CLS : GOSUB 7100 : LOCATE 3, 4 : COLOR 14 : PRINT "Hunting and the Naryn" : COLOR 15 : LOCATE 5, 1
325 S$ = "To hunt, move with the arrow keys/and shoot with the space bar. You/can carry only 100 funt back to the/caravan./ /At the Naryn gorge you may raft down"
326 S$ = S$ + "/the river to Iyik Janyl. Steer with/the left and right arrow keys./ /Arrive by the Feast of St. Janyl, 24/August, for a bonus." : GOSUB 7700
330 GOSUB 7500 : GOTO 200
400 GOSUB 410 : GOTO 200
410 CLS : GOSUB 7100 : LOCATE 3, 12 : COLOR 14 : PRINT "The Irad Top Ten" : COLOR 15
415 LOCATE 5, 3 : PRINT "Name"; TAB(20); "Points"; TAB(29); "Rating"
420 FOR I = 1 TO 10 : LOCATE 6 + I, 3 : PRINT LEFT$(BESTNAME$(I), 16); TAB(20); BESTSCORE(I); TAB(29); BESTRANK$(I) : NEXT
425 LOCATE 18, 3 : PRINT "Trail guide: 4000 points or more" : LOCATE 19, 3 : PRINT "Rider: 2000 to 3999 points" : LOCATE 20, 3 : PRINT "Greenhorn: fewer than 2000 points"
430 GOSUB 7500 : RETURN
500 CLS : GOSUB 7100 : LOCATE 3, 10 : COLOR 14 : PRINT "Management options" : COLOR 15
505 LOCATE 6, 5 : PRINT "1. Reset the Top Ten" : LOCATE 7, 5 : PRINT "2. Erase the graves on the road" : LOCATE 8, 5 : PRINT "3. Return to the main menu"
510 LOCATE 11, 5 : PRINT "What is your choice? "; : GOSUB 7450 : K = VAL(K$)
515 IF K = 1 THEN GOSUB 8950 : GOSUB 8920 : LOCATE 14, 5 : PRINT "The Top Ten has been reset." : GOSUB 7500
520 IF K = 2 THEN NGRAVES = 0 : GOSUB 8930 : LOCATE 14, 5 : PRINT "The graves have been erased." : GOSUB 7500
525 GOTO 200
600 CLS : GOSUB 7100 : LOCATE 3, 4 : PRINT "Many kinds of people made the" : LOCATE 4, 4 : PRINT "journey south in 1877. You may:"
605 LOCATE 7, 5 : PRINT "1. Be a biy's son, with a good herd"
610 LOCATE 8, 5 : PRINT "2. Be a felt merchant"
615 LOCATE 9, 5 : PRINT "3. Be a herder with little silver"
620 LOCATE 10, 5 : PRINT "4. Find out the differences"
625 LOCATE 13, 4 : PRINT "What is your choice? "; : GOSUB 7450 : OCC = VAL(K$)
630 IF OCC = 4 THEN GOSUB 2800 : GOTO 600
635 IF OCC < 1 OR OCC > 3 THEN 600
640 MONEY = 800 : IF OCC = 2 THEN MONEY = 500 ELSE IF OCC = 3 THEN MONEY = 300
645 HORSES = 0 : FOOD = 0 : FELTS = 0 : SHOTS = 0 : SHOES = 0 : SADDLES = 0 : VERSTS = 0 : NXTMARK = 1 : PACE = 1 : RATIONS = 1 : HP = 0 : CURSE = 0 : MAREEATEN = 0 : OVER = 0 : ATLAND = 0 : MAREASKED = 0 : RESTING = 0
650 FOR I = 1 TO 5 : ALIVE(I) = 1 : SICK(I) = 0 : SICKDAYS(I) = 0 : NEXT
660 CLS : GOSUB 7100 : LOCATE 3, 4 : PRINT "What is the first name of the" : LOCATE 4, 4 : PRINT "caravan leader?"
665 LOCATE 6, 5 : LINE INPUT "> "; A$ : IF A$ = "" THEN A$ = STDNAME$(1)
670 PARTY$(1) = LEFT$(A$, 10) : LOCATE 6, 7 : PRINT PARTY$(1); SPACE$(10)
675 LOCATE 9, 4 : PRINT "What are the first names of the four" : LOCATE 10, 4 : PRINT "other members of your family?"
680 FOR I = 2 TO 5 : LOCATE 10 + I, 5 : PRINT MID$(STR$(I), 2); ". "; : LINE INPUT A$ : IF A$ = "" THEN A$ = STDNAME$(I)
685 PARTY$(I) = LEFT$(A$, 10) : LOCATE 10 + I, 8 : PRINT PARTY$(I); SPACE$(10) : NEXT I
690 LOCATE 17, 4 : PRINT "Are these names correct? (Y/N) "; : GOSUB 7450 : IF K$ = "N" OR K$ = "n" THEN 660
700 CLS : GOSUB 7100 : LOCATE 3, 4 : PRINT "It is 1877. The snow is melting on" : LOCATE 4, 4 : PRINT "the plains, but the high passes may" : LOCATE 5, 4 : PRINT "stay closed until late spring."
705 LOCATE 7, 4 : PRINT "You must decide which month to leave."
710 LOCATE 9, 5 : PRINT "1. March" : LOCATE 10, 5 : PRINT "2. April" : LOCATE 11, 5 : PRINT "3. May" : LOCATE 12, 5 : PRINT "4. June" : LOCATE 13, 5 : PRINT "5. July" : LOCATE 14, 5 : PRINT "6. Ask for advice"
715 LOCATE 17, 4 : PRINT "What is your choice? "; : GOSUB 7450 : K = VAL(K$)
720 IF K = 6 THEN GOSUB 2900 : GOTO 700
725 IF K < 1 OR K > 5 THEN 700
730 DAYNUM = MONTHSTART(K + 2) + 1
735 CLS : GOSUB 7100 : LOCATE 3, 4 : PRINT "Before leaving, visit Osmon's shop" : LOCATE 4, 4 : PRINT "by the Chu ford. You have"; MONEY; "rubles."
740 LOCATE 6, 1 : S$ = "You will need:/ - horses to ride and to carry the/   yurt. Six or more is wise./ - food for the road/ - felt coats and furs for the/   passes"
741 S$ = S$ + "/ - powder and shot for hunting, and/   for wolves and raiders/ - spare horseshoes and pack saddles" : GOSUB 7700
745 GOSUB 7500 : PF = 1 : SHOP$ = "Osmon's shop at the Chu ford" : GOSUB 800
750 IF HORSES >= 2 THEN 900
755 CLS : GOSUB 7100 : LOCATE 5, 4 : PRINT "You cannot leave with fewer than two" : LOCATE 6, 4 : PRINT "horses." : GOSUB 7500 : GOSUB 800 : GOTO 750
800 FOR I = 1 TO 6 : BUY(I) = 0 : NEXT : BILL = 0
805 CLS : GOSUB 7100 : COLOR 14 : LOCATE 3, 4 : PRINT SHOP$ : COLOR 15 : GOSUB 7000 : LOCATE 4, 4 : PRINT DT$ : LOCATE 5, 3 : PRINT STRING$(36, 196)
810 FOR I = 1 TO 6 : T = BUY(I) * INT(PRICE(I) * PF + .5) : LOCATE 6 + I, 4 : PRINT MID$(STR$(I), 2); ". "; ITEM$(I); : LOCATE 6 + I, 29 : PRINT RIGHT$("      " + STR$(T), 6); " r" : NEXT
815 LOCATE 13, 3 : PRINT STRING$(36, 196)
820 LOCATE 14, 4 : PRINT "Total bill:"; : LOCATE 14, 29 : PRINT RIGHT$("      " + STR$(BILL), 6); " r"
825 LOCATE 16, 4 : PRINT "Silver left:"; : LOCATE 16, 29 : PRINT RIGHT$("      " + STR$(MONEY - BILL), 6); " r"
830 LOCATE 19, 4 : PRINT "Which item would you like to buy?" : LOCATE 21, 4 : PRINT "Press SPACE BAR to leave the shop"
835 GOSUB 7400 : IF K$ = " " OR K$ = CHR$(13) THEN 860
840 K = VAL(K$) : IF K < 1 OR K > 6 THEN 835
845 GOSUB 870 : GOTO 805
860 MONEY = MONEY - BILL : HORSES = HORSES + BUY(1) : FOOD = FOOD + 10 * BUY(2) : FELTS = FELTS + BUY(3) : SHOTS = SHOTS + 20 * BUY(4) : SHOES = SHOES + BUY(5) : SADDLES = SADDLES + BUY(6) : RETURN
870 T = INT(PRICE(K) * PF + .5) : CLS : GOSUB 7100 : COLOR 14 : LOCATE 3, 4 : PRINT SHOP$ : COLOR 15 : LOCATE 5, 1
875 S$ = ADVICE$(K) : GOSUB 7700
880 LOCATE 13, 4 : PRINT ITEM$(K) : LOCATE 14, 4 : PRINT "cost"; T; "rubles each."
885 LOCATE 16, 4 : PRINT "How many would you like? "; : LINE INPUT A$ : Q = INT(VAL(A$)) : IF Q < 0 THEN Q = 0
890 IF BILL - BUY(K) * T + Q * T > MONEY THEN LOCATE 18, 4 : PRINT "You don't have enough silver." : GOSUB 7500 : RETURN
895 BILL = BILL - BUY(K) * T + Q * T : BUY(K) = Q : RETURN
900 NXTMARK = 1 : GOSUB 6100 : GOSUB 7000 : LOCATE 19, 3 : COLOR 14 : PRINT MARK$(1) : COLOR 15 : LOCATE 20, 3 : PRINT DT$
905 LOCATE 22, 3 : PRINT "The kashysh blesses the horses with" : LOCATE 23, 3 : PRINT "water, milk and juniper smoke."
910 IF MUTE = 0 THEN PLAY "MB T100 O3 L4 G A B > D2"
915 GOSUB 7500 : NXTMARK = 2 : LASTMARK = 0 : GOTO 1000
1000 REM *** ON THE ROAD ***
1002 GOSUB 1150 : GOSUB 6800 : GOSUB 5600 : GOSUB 7200 : OLDCX = -1 : PREVV = VERSTS : GOSUB 6900
1005 K$ = INKEY$ : IF K$ = CHR$(13) OR K$ = " " THEN 1500
1010 GOSUB 1100 : IF OVER THEN 8600
1015 IF VERSTS >= MARK(NXTMARK) THEN VERSTS = MARK(NXTMARK) : GOTO 3500
1020 GOSUB 2700 : T = TIMER : WHILE TIMER - T < .25 AND TIMER >= T : WEND : GOTO 1005
1100 V = 10 + 5 * PACE : T = HORSES / 6 : IF T > 1 THEN T = 1
1105 V = V * T : IF ZONE = 1 THEN V = V * .6
1110 IF PRECIP = 1 THEN V = V * .8 ELSE IF PRECIP = 2 THEN V = V * .5
1120 IF HORSES < 2 THEN OVER = 3 : RETURN
1125 IF ZONE = 1 AND DAYNUM > 288 THEN OVER = 2 : RETURN
1130 VERSTS = VERSTS + V : DAYNUM = DAYNUM + 1 : GOSUB 1150 : GOSUB 5600 : GOSUB 5000 : IF OVER THEN RETURN
1135 IF PACE = 3 AND RND < .02 THEN HORSES = HORSES - 1 : M1$ = "A horse dies of exhaustion." : GOSUB 7600
1140 GOSUB 6900 : GOSUB 7200
1145 IF RND < .06 THEN GOSUB 2000 : GOSUB 7200
1149 RETURN
1150 ZONE = 0 : IF (VERSTS >= 115 AND VERSTS < 165) OR (VERSTS >= 300 AND VERSTS < 350) OR (VERSTS >= 420 AND VERSTS < 470) THEN ZONE = 1
1155 IF VERSTS >= 600 AND VERSTS < 670 THEN ZONE = 2
1160 RETURN
1200 DAYNUM = DAYNUM + 1 : GOSUB 1150 : GOSUB 5600 : GOSUB 5000 : RETURN
1500 CLS : GOSUB 7100 : GOSUB 7000 : GOSUB 7300 : COLOR 14 : LOCATE 3, 4 : IF ATLAND THEN PRINT MARK$(NXTMARK - 1) ELSE PRINT "On the road"
1505 COLOR 15 : LOCATE 4, 4 : PRINT DT$ : LOCATE 6, 4 : PRINT "Weather: "; WEATHER$ : LOCATE 7, 4 : PRINT "Health: "; HEALTH$ : LOCATE 8, 4 : PRINT "Pace: "; PACE$(PACE) : LOCATE 9, 4 : PRINT "Rations: "; RATION$(RATIONS)
1510 LOCATE 11, 4 : PRINT "You may:"
1515 FOR I = 1 TO 7 : LOCATE 11 + I, 6 : PRINT MENU$(I) : NEXT
1520 LOCATE 19, 6 : IF ATLAND THEN PRINT "8. Talk to people" ELSE PRINT "8. Hunt for food"
1525 SHOPHERE = 0 : IF ATLAND THEN IF MARKTYPE(NXTMARK - 1) = 3 THEN SHOPHERE = 1 : LOCATE 20, 6 : PRINT "9. Buy supplies"
1530 LOCATE 22, 4 : PRINT "What is your choice? "; : GOSUB 7450 : K = VAL(K$)
1535 IF K = 9 AND SHOPHERE = 0 THEN 1500
1540 IF K < 1 OR K > 9 THEN 1500
1545 ON K GOTO 1600, 1650, 1700, 1750, 1800, 1850, 1900, 1950, 1990
1600 ATLAND = 0 : GOTO 1000
1650 CLS : GOSUB 7100 : COLOR 14 : LOCATE 3, 4 : PRINT "Your supplies" : COLOR 15
1655 LOCATE 5, 5 : PRINT "Horses"; TAB(30); HORSES : LOCATE 6, 5 : PRINT "Food (funt)"; TAB(30); INT(FOOD) : LOCATE 7, 5 : PRINT "Felt coats"; TAB(30); FELTS
1660 LOCATE 8, 5 : PRINT "Shots of powder"; TAB(30); SHOTS : LOCATE 9, 5 : PRINT "Spare horseshoes"; TAB(30); SHOES : LOCATE 10, 5 : PRINT "Pack saddles"; TAB(30); SADDLES : LOCATE 11, 5 : PRINT "Rubles"; TAB(30); INT(MONEY)
1665 COLOR 14 : LOCATE 13, 4 : PRINT "Your family" : COLOR 15
1670 FOR I = 1 TO 5 : S$ = "well" : IF SICK(I) THEN S$ = DISEASE$(SICK(I))
1675 IF ALIVE(I) = 0 THEN S$ = "dead"
1680 LOCATE 14 + I, 5 : PRINT PARTY$(I); TAB(17); S$ : NEXT I
1685 GOSUB 7500 : GOTO 1500
1700 GOSUB 4500 : GOTO 1500
1750 CLS : GOSUB 7100 : COLOR 14 : LOCATE 3, 4 : PRINT "Change the pace" : COLOR 15 : LOCATE 4, 4 : PRINT "(now "; PACE$(PACE); ")"
1755 LOCATE 6, 4 : PRINT "The pace is how hard you push the" : LOCATE 7, 4 : PRINT "horses and the family each day."
1760 LOCATE 9, 5 : PRINT "1. Steady: about 15 versts a day" : LOCATE 10, 5 : PRINT "2. Strenuous: about 20 versts" : LOCATE 11, 5 : PRINT "3. Grueling: about 25 versts, hard" : LOCATE 12, 5 : PRINT "   on people and horses"
1765 LOCATE 15, 4 : PRINT "What is your choice? "; : GOSUB 7450 : K = VAL(K$) : IF K >= 1 AND K <= 3 THEN PACE = K
1770 GOTO 1500
1800 CLS : GOSUB 7100 : COLOR 14 : LOCATE 3, 4 : PRINT "Change food rations" : COLOR 15 : LOCATE 4, 4 : PRINT "(now "; RATION$(RATIONS); ")"
1805 LOCATE 6, 5 : PRINT "1. Filling: 3 funt a person a day" : LOCATE 7, 5 : PRINT "2. Meager: 2 funt, not quite enough" : LOCATE 8, 5 : PRINT "3. Bare bones: 1 funt, very hungry"
1810 LOCATE 11, 4 : PRINT "What is your choice? "; : GOSUB 7450 : K = VAL(K$) : IF K >= 1 AND K <= 3 THEN RATIONS = K
1815 GOTO 1500
1850 CLS : GOSUB 7100 : LOCATE 5, 4 : PRINT "How many days will you rest? (1-9) "; : GOSUB 7450 : K = VAL(K$) : IF K < 1 THEN 1500
1855 RESTING = 1 : FOR J = 1 TO K : GOSUB 1200 : IF OVER THEN RESTING = 0 : GOTO 8600
1860 NEXT J : RESTING = 0 : GOTO 1500
1900 CLS : GOSUB 7100 : GOSUB 1200 : IF OVER THEN 8600
1905 CLS : GOSUB 7100 : LOCATE 5, 4 : K = INT(RND * 7) + 1 : ON K GOSUB 1910, 1915, 1920, 1925, 1930, 1935, 1940 : GOSUB 7500 : GOTO 1500
1910 PRINT "A herder will trade you a horse" : LOCATE 6, 4 : PRINT "for 100 funt of food." : IF FOOD < 100 THEN LOCATE 8, 4 : PRINT "You do not have enough food." : RETURN
1911 GOSUB 1945 : IF K$ = "Y" OR K$ = "y" THEN HORSES = HORSES + 1 : FOOD = FOOD - 100
1912 RETURN
1915 PRINT "A smith wants 40 shots of powder" : LOCATE 6, 4 : PRINT "for 3 spare horseshoes." : IF SHOTS < 40 THEN LOCATE 8, 4 : PRINT "You do not have enough powder." : RETURN
1916 GOSUB 1945 : IF K$ = "Y" OR K$ = "y" THEN SHOTS = SHOTS - 40 : SHOES = SHOES + 3
1917 RETURN
1920 PRINT "A feltmaker offers 2 felt coats" : LOCATE 6, 4 : PRINT "for 30 rubles." : IF MONEY < 30 THEN LOCATE 8, 4 : PRINT "You do not have enough silver." : RETURN
1921 GOSUB 1945 : IF K$ = "Y" OR K$ = "y" THEN MONEY = MONEY - 30 : FELTS = FELTS + 2
1922 RETURN
1925 PRINT "A kinsman needs a horse. He offers" : LOCATE 6, 4 : PRINT "150 funt of food for one." : IF HORSES < 3 THEN LOCATE 8, 4 : PRINT "You cannot spare a horse." : RETURN
1926 GOSUB 1945 : IF K$ = "Y" OR K$ = "y" THEN HORSES = HORSES - 1 : FOOD = FOOD + 150
1927 RETURN
1930 PRINT "A saddler offers a pack saddle" : LOCATE 6, 4 : PRINT "for 40 shots of powder." : IF SHOTS < 40 THEN LOCATE 8, 4 : PRINT "You do not have enough powder." : RETURN
1931 GOSUB 1945 : IF K$ = "Y" OR K$ = "y" THEN SHOTS = SHOTS - 40 : SADDLES = SADDLES + 1
1932 RETURN
1935 PRINT "A herder will sell you a horse" : LOCATE 6, 4 : PRINT "for 40 rubles." : IF MONEY < 40 THEN LOCATE 8, 4 : PRINT "You do not have enough silver." : RETURN
1936 GOSUB 1945 : IF K$ = "Y" OR K$ = "y" THEN MONEY = MONEY - 40 : HORSES = HORSES + 1
1937 RETURN
1940 PRINT "Nobody wants to trade today." : RETURN
1945 LOCATE 8, 4 : PRINT "Will you trade? (Y/N) "; : GOSUB 7450 : RETURN
1950 IF ATLAND THEN CLS : GOSUB 7100 : LOCATE 4, 1 : S$ = QUOTE$(NXTMARK - 1) : GOSUB 7700 : GOSUB 7500 : GOTO 1500
1955 GOSUB 4000 : IF OVER THEN 8600
1960 GOTO 1500
1990 SHOP$ = "Traders at " + MARK$(NXTMARK - 1) : PF = 1.25 : IF NXTMARK - 1 = 5 THEN PF = 1.5 ELSE IF NXTMARK - 1 = 11 THEN PF = 1.75
1995 GOSUB 800 : GOTO 1500
2000 REM *** WHAT HAPPENS ON THE ROAD ***
2002 R = INT(RND * 16) + 1 : IF CURSE AND R > 12 THEN R = R - 8
2005 IF ZONE = 2 AND RND < .3 THEN R = 17
2010 ON R GOTO 2020, 2030, 2040, 2050, 2060, 2070, 2080, 2090, 2100, 2110, 2120, 2130, 2140, 2150, 2160, 2170, 2180
2020 IF SHOES > 0 THEN SHOES = SHOES - 1 : M1$ = "A horse throws a shoe." : M2$ = "You fit a spare." : GOTO 2190
2025 M1$ = "A horse throws a shoe. With no spare," : M2$ = "you lose a day leading her." : GOSUB 7600 : GOTO 1200
2030 IF SADDLES > 0 THEN SADDLES = SADDLES - 1 : M1$ = "A pack saddle breaks." : M2$ = "You use a spare." : GOTO 2190
2035 FOOD = FOOD - 50 : M1$ = "A pack saddle breaks. You leave 50" : M2$ = "funt of food beside the road." : GOTO 2190
2040 IF RND < .3 THEN HORSES = HORSES - 1 : M1$ = "A horse strays in the night." : M2$ = "You never find her." : GOTO 2190
2045 M1$ = "A horse strays. You lose a day" : M2$ = "searching for her." : GOSUB 7600 : GOTO 1200
2050 IF SHOTS >= 5 THEN SHOTS = SHOTS - 5 : M1$ = "Wolves circle the herd at night." : M2$ = "Your shots drive them off." : GOTO 2190
2055 HORSES = HORSES - 1 : M1$ = "Wolves circle the herd. With no" : M2$ = "powder, you lose a horse." : GOTO 2190
2060 GOTO 2500
2070 GOTO 2600
2080 I = INT(RND * 5) + 1 : IF ALIVE(I) = 0 OR SICK(I) > 0 THEN RETURN
2085 K = 7 : GOTO 5250
2090 I = INT(RND * 5) + 1 : IF ALIVE(I) = 0 OR SICK(I) > 0 THEN RETURN
2095 K = 6 : GOTO 5250
2100 I = INT(RND * 5) + 1 : IF ALIVE(I) = 0 OR SICK(I) > 0 THEN RETURN
2105 K = 2 : GOTO 5250
2110 GOTO 2650
2120 M1$ = "Fog on the hills. You lose the trail" : M2$ = "and a day." : GOSUB 7600 : GOTO 1200
2130 FOOD = FOOD - 20 : M1$ = "Hailstones like walnuts!" : IF FELTS > 0 THEN FELTS = FELTS - 1 : M2$ = "A felt coat is torn to rags."
2135 GOTO 2190
2140 FOOD = FOOD + 40 : HP = HP * .7 : M1$ = "A kinsman's aul takes you in. They" : M2$ = "kill a sheep and pour kymyz." : GOTO 2190
2150 FOOD = FOOD + 15 : M1$ = "You find wild rhubarb and onions." : GOTO 2190
2160 CURSE = 0 : HP = HP * .8 : M1$ = "Pilgrims bound for Iyik Janyl ride" : M2$ = "with you. Their kashysh gives a bata." : M3$ = "All answer: oomin." : GOTO 2190
2170 IF MONEY > 20 AND RND < .5 THEN MONEY = MONEY - 20 : M1$ = "A thief in the night takes" : M2$ = "20 rubles." : GOTO 2190
2175 FOOD = FOOD - 40 : M1$ = "A thief in the night takes" : M2$ = "40 funt of food." : GOTO 2190
2180 M1$ = "Rockfall in the gorge! You lose a" : M2$ = "day clearing the trail." : IF RND < .2 THEN HORSES = HORSES - 1 : M3$ = "A packhorse falls into the Naryn."
2185 GOSUB 7600 : GOTO 1200
2190 IF FOOD < 0 THEN FOOD = 0
2191 IF HORSES < 0 THEN HORSES = 0
2192 IF MONEY < 0 THEN MONEY = 0
2195 GOSUB 7600 : RETURN
2500 HOSTILE = (RND < .7) : LOOKS = HOSTILE : IF RND < .2 THEN LOOKS = NOT LOOKS
2505 LINE (0, 136)-(319, 199), 0, BF : LOCATE 19, 3 : PRINT "Riders on the skyline!" : LOCATE 20, 3 : IF LOOKS THEN PRINT "They look like horse thieves." ELSE PRINT "They do not look hostile."
2510 LOCATE 22, 3 : PRINT "1 Run   2 Fight   3 Ring the herd" : LOCATE 23, 3 : PRINT "4 Ride out with gifts    Choice? ";
2515 GOSUB 7400 : K = VAL(K$) : IF K < 1 OR K > 4 THEN 2515
2520 IF HOSTILE = 0 AND K = 2 THEN MONEY = MONEY - 20 : M1$ = "You fired on Kokjal herders. Their" : M2$ = "biy demands kun: 20 rubles." : GOTO 2190
2522 IF HOSTILE = 0 THEN M1$ = "They were Kokjal herders looking" : M2$ = "for strays. They share their kymyz." : GOTO 2190
2525 ON K GOTO 2530, 2540, 2550, 2560
2530 FOOD = FOOD - 30 : M1$ = "You run. Packs are lost in the chase." : IF RND < .4 THEN HORSES = HORSES - 1 : M2$ = "They cut out one horse."
2535 GOTO 2190
2540 IF SHOTS < 10 THEN HORSES = HORSES - 2 : M1$ = "You have no powder! They take" : M2$ = "two horses." : GOTO 2190
2545 SHOTS = SHOTS - 10 : IF RND < .6 THEN M1$ = "Your shots scatter them." : GOTO 2190
2547 I = INT(RND * 5) + 1 : IF ALIVE(I) = 0 THEN 2547
2548 HORSES = HORSES - 1 : IF HORSES < 0 THEN HORSES = 0
2549 M1$ = "They take a horse, and there is" : M2$ = "blood." : GOSUB 7600 : K = 10 : GOTO 5250
2550 IF SHOTS < 10 THEN HORSES = HORSES - 2 : M1$ = "No powder. They take two horses." : GOTO 2190
2555 SHOTS = SHOTS - 10 : IF RND < .75 THEN M1$ = "The ring holds. They ride away." : GOTO 2190
2557 HORSES = HORSES - 1 : M1$ = "They break the ring and take a horse." : GOTO 2190
2560 IF MONEY >= 15 THEN MONEY = MONEY - 15 : M1$ = "You offer tea, kurut and silver." : M2$ = "They take 15 rubles and ride off." : GOTO 2190
2565 HORSES = HORSES - 1 : M1$ = "You have little to give. They take" : M2$ = "a horse instead." : GOTO 2190
2600 LINE (0, 136)-(319, 199), 0, BF : LOCATE 19, 3 : PRINT "At dusk a black bull stands on the" : LOCATE 20, 3 : PRINT "trail. The elders whisper: Morkhan." : LOCATE 22, 3 : PRINT "Burn juniper and pour milk? (Y/N) ";
2605 GOSUB 7450 : IF K$ = "Y" OR K$ = "y" THEN M1$ = "The smoke rises white. The bull" : M2$ = "wanders off into the dark." : GOTO 2190
2610 CURSE = 1 : M1$ = "The women will not look at you." : GOTO 2190
2650 LINE (0, 136)-(319, 199), 0, BF : LOCATE 19, 3 : PRINT "A Cossack post bars the road. The" : LOCATE 20, 3 : PRINT "officer wants 10 rubles for papers." : LOCATE 22, 3 : PRINT "Pay him? (Y/N) ";
2655 GOSUB 7450 : IF (K$ = "Y" OR K$ = "y") AND MONEY >= 10 THEN MONEY = MONEY - 10 : M1$ = "He stamps something in Russian." : GOTO 2190
2660 M1$ = "You take the long way round." : M2$ = "It costs two days." : GOSUB 7600 : GOSUB 1200 : IF OVER THEN RETURN
2665 GOTO 1200
2700 IF NGRAVES = 0 THEN PREVV = VERSTS : RETURN
2705 FOR J = 1 TO NGRAVES : IF GRAVEV(J) > PREVV AND GRAVEV(J) <= VERSTS THEN 2720
2710 NEXT J : PREVV = VERSTS : RETURN
2720 PREVV = VERSTS : GOSUB 6750 : LOCATE 19, 3 : PRINT "You pass a grave beside the road." : LOCATE 21, 5 : PRINT "Here lies "; GRAVENAME$(J) : LOCATE 22, 5 : PRINT GRAVEEPI$(J)
2725 GOSUB 7500 : GOSUB 6800 : GOSUB 7200 : OLDCX = -1 : GOSUB 6900 : RETURN
2800 CLS : GOSUB 7100 : LOCATE 4, 1 : S$ = "A biy's son starts with 800 rubles,/a felt merchant with 500, and a/herder with 300./ /The poorer you start, the more/points you earn for arriving: double"
2801 S$ = S$ + "/for the merchant, triple for the/herder." : GOSUB 7700 : GOSUB 7500 : RETURN
2900 CLS : GOSUB 7100 : LOCATE 4, 1 : S$ = "You visit the aksakal, the oldest/man in the aul. He says:/ /'Leave too early and snow will close/the passes in your face. Leave too/late and you will miss the Feast of"
2901 S$ = S$ + "/St. Janyl, and maybe meet the autumn/snow on the Ala-Bel. May is good.'" : GOSUB 7700 : GOSUB 7500 : RETURN
3000 REM *** RIVER CROSSING ***
3002 DEPTH = INT((1 + RND * 3) * 2) / 2 : WIDE = INT(RND * 50) + 30 : RIVERFEE = 5
3005 GOSUB 6100 : LOCATE 18, 3 : COLOR 14 : PRINT MARK$(NXTMARK) : COLOR 15 : LOCATE 19, 3 : PRINT "Width"; WIDE; "sazhen, depth"; DEPTH; "arshin"
3010 LOCATE 20, 4 : PRINT "1 Ford it          2 Skin raft" : LOCATE 21, 4 : PRINT "3 Rivermen ("; MID$(STR$(RIVERFEE), 2); " r)   4 Wait a day"
3015 LOCATE 22, 4 : PRINT "5 More information" : LOCATE 24, 4 : PRINT "What is your choice? ";
3020 GOSUB 7450 : K = VAL(K$)
3025 IF K = 5 THEN GOSUB 3300 : GOTO 3005
3030 IF K = 4 THEN GOSUB 1200 : IF OVER THEN RETURN
3035 IF K = 4 THEN DEPTH = DEPTH - INT(RND * 2) / 2 : IF DEPTH < 1 THEN DEPTH = 1
3040 IF K = 4 THEN 3005
3045 IF K < 1 OR K > 3 THEN 3005
3050 IF K = 3 AND MONEY < RIVERFEE THEN M1$ = "You cannot pay the rivermen." : GOSUB 7600 : GOTO 3005
3055 IF K = 3 THEN MONEY = MONEY - RIVERFEE
3060 IF K = 2 THEN GOSUB 1200 : IF OVER THEN RETURN
3065 RISK = 3 : IF K = 1 AND DEPTH > 1.5 THEN RISK = 25
3070 IF K = 1 AND DEPTH > 2.5 THEN RISK = 60
3075 IF K = 2 THEN RISK = 8 - 12 * (DEPTH > 3)
3080 GOSUB 3200
3085 IF RND * 100 >= RISK THEN M1$ = "You cross safely." : GOSUB 7600 : RETURN
3090 T = INT(RND * 60) + 20 : FOOD = FOOD - T : IF FOOD < 0 THEN FOOD = 0
3095 M1$ = "The current takes a packhorse." : M2$ = "You lose" + STR$(T) + " funt of food."
3100 IF RND < .5 THEN HORSES = HORSES - 1 : M3$ = "The horse drowns."
3105 IF FELTS > 0 AND RND < .5 THEN FELTS = FELTS - 1
3110 GOSUB 7600 : IF K = 1 AND DEPTH > 2.5 AND RND < .3 THEN GOSUB 3150
3115 RETURN
3150 I = INT(RND * 5) + 1 : IF ALIVE(I) = 0 THEN 3150
3155 K = 9 : GOSUB 5300 : RETURN
3200 LINE (0, 136)-(319, 199), 0, BF : FOR X = 230 TO 30 STEP -8 : LINE (X + 60, 115)-(X + 67, 135), 6, BF : PUT (X, 115), CARA%, PSET : IF MUTE = 0 THEN SOUND 60 + X, .5
3205 T = TIMER : WHILE TIMER = T : WEND : NEXT X : RETURN
3300 CLS : GOSUB 7100 : COLOR 14 : LOCATE 3, 4 : PRINT "River crossings" : COLOR 15 : LOCATE 5, 1
3305 S$ = "A ford is safe when the water is/less than 1.5 arshin deep. Deeper/than 2.5, the horses must swim and/the current can take them./ /A tursuk is a raft on blown-up"
3306 S$ = S$ + "/goatskins. It is safer, but building/one takes a day./ /The rivermen know every stone. They/want silver./ /(An arshin is 28 inches, a sazhen is/7 feet.)" : GOSUB 7700 : GOSUB 7500 : RETURN
3500 REM *** A LANDMARK ***
3502 IF MARKTYPE(NXTMARK) = 1 THEN GOSUB 3000 : IF OVER THEN 8600 ELSE 3530
3505 GOSUB 6100 : GOSUB 7000 : LOCATE 19, 3 : COLOR 14 : PRINT MARK$(NXTMARK) : COLOR 15 : LOCATE 20, 3 : PRINT DT$
3510 IF MUTE = 0 THEN PLAY "MB T140 O3 L16 C E G > C4"
3512 IF MARKTYPE(NXTMARK) = 5 THEN GOSUB 7500 : GOTO 8000
3514 IF MARKTYPE(NXTMARK) = 6 THEN 8050
3515 GOSUB 7500
3520 IF MARKTYPE(NXTMARK) = 2 THEN GOSUB 3600 : IF OVER THEN 8600
3525 IF MARKTYPE(NXTMARK) = 4 THEN FOOD = FOOD + 30 : HP = HP * .7 : M1$ = "Kinsmen on the zhayloo share kymyz" : M2$ = "and mutton. Everyone feels better." : GOSUB 7600
3530 LASTMARK = MARK(NXTMARK) : NXTMARK = NXTMARK + 1 : ATLAND = 1 : GOTO 1500
3600 IF DAYNUM > 288 THEN OVER = 2 : RETURN
3605 IF DAYNUM >= 125 AND DAYNUM <= 263 THEN RETURN
3610 T = INT(RND * 3) + 2 : M1$ = "Snow lies deep on the pass. You lose" : M2$ = MID$(STR$(T), 2) + " days breaking a trail." : GOSUB 7600
3615 FOR J = 1 TO T : GOSUB 1200 : IF OVER THEN RETURN
3620 NEXT J : RETURN
4000 REM *** HUNTING ***
4002 CLS : LINE (0, 0)-(319, 175), 2, BF : FOR I = 1 TO 9 : X = I * 34 - 20 : LINE (X + 3, 10)-(X + 5, 22), 6, BF : CIRCLE (X + 4, 8), 8, 10 : PAINT (X + 4, 8), 10, 10 : NEXT
4005 FOR I = 1 TO 40 : X = INT(RND * 316) + 1 : Y = INT(RND * 145) + 28 : LINE (X, Y)-(X + 2, Y - 2), 10 : NEXT
4010 LOCATE 24, 2 : PRINT "Arrows move, SPACE shoots, ESC stops"; : HUX = 150 : HUY = 140 : FACE = 1 : DX = 0 : DY = -1 : BON = 0 : MEAT = 0
4015 FOR I = 1 TO 2 : AKIND(I) = 0 : NEXT : PUT (HUX, HUY), HUNR%, PSET : GOSUB 4380 : HUNTEND = TIMER + 30 : IF HUNTEND > 86370 THEN HUNTEND = 86370
4020 T = TIMER : IF T > HUNTEND OR T < HUNTEND - 40 THEN 4400
4025 K$ = INKEY$ : IF K$ = CHR$(27) THEN 4400
4030 IF LEN(K$) = 2 THEN GOSUB 4300
4035 IF K$ = " " THEN GOSUB 4350
4040 FOR I = 1 TO 2 : IF AKIND(I) = 0 THEN IF RND < .04 THEN GOSUB 4200
4045 IF AKIND(I) > 0 THEN GOSUB 4250
4050 NEXT I
4055 IF BON THEN GOSUB 4270
4060 WHILE TIMER = T : WEND : GOTO 4020
4200 KD = INT(RND * 3) + 1 : IF RND < .15 + .25 * (ZONE = 1) THEN KD = 4
4205 AKIND(I) = KD : AY(I) = 28 + INT(RND * 4) * 24 : AV(I) = 4 - (KD = 1) * 2 + (KD = 2) : IF RND < .5 THEN AX(I) = 1 ELSE AX(I) = 318 - AW(KD) : AV(I) = -AV(I)
4210 RETURN
4250 AX(I) = AX(I) + AV(I) : KD = AKIND(I) : IF AX(I) < 0 OR AX(I) > 319 - AW(KD) THEN LINE (AX(I) - AV(I), AY(I))-(AX(I) - AV(I) + AW(KD) - 1, AY(I) + AH(KD) - 1), 2, BF : AKIND(I) = 0 : RETURN
4255 IF AV(I) > 0 THEN SLOT = (KD - 1) * 2 ELSE SLOT = (KD - 1) * 2 + 1
4260 PUT (AX(I), AY(I)), ANIM%(SLOT * 245), PSET : RETURN
4270 LINE (BX, BY)-(BX + 1, BY + 1), 2, BF : BX = BX + DX * 9 : BY = BY + DY * 9 : BLIFE = BLIFE - 1
4272 IF BLIFE <= 0 OR BX < 0 OR BX > 317 OR BY < 25 OR BY > 173 THEN BON = 0 : RETURN
4275 FOR J = 1 TO 2 : KD = AKIND(J) : IF KD = 0 THEN 4285
4280 IF BX >= AX(J) + 4 AND BX <= AX(J) + AW(KD) - 4 AND BY >= AY(J) AND BY <= AY(J) + AH(KD) THEN 4290
4285 NEXT J : LINE (BX, BY)-(BX + 1, BY + 1), 0, BF : RETURN
4290 LINE (AX(J), AY(J))-(AX(J) + AW(KD) - 1, AY(J) + AH(KD) - 1), 2, BF : AKIND(J) = 0 : BON = 0 : MEAT = MEAT + MEATOF(KD) : IF MUTE = 0 THEN SOUND 120, 1
4295 LOCATE 23, 2 : PRINT "You shot "; ANIMAL$(KD); "!"; SPACE$(16); : GOSUB 4380 : RETURN
4300 C$ = RIGHT$(K$, 1) : NX = 0 : NY = 0
4305 IF C$ = "H" THEN NY = -1 ELSE IF C$ = "P" THEN NY = 1 ELSE IF C$ = "K" THEN NX = -1 ELSE IF C$ = "M" THEN NX = 1
4310 IF C$ = "G" THEN NX = -1 : NY = -1 ELSE IF C$ = "I" THEN NX = 1 : NY = -1 ELSE IF C$ = "O" THEN NX = -1 : NY = 1 ELSE IF C$ = "Q" THEN NX = 1 : NY = 1
4315 IF NX = 0 AND NY = 0 THEN RETURN
4320 DX = NX : DY = NY : IF NX <> 0 THEN FACE = NX
4325 HUX = HUX + NX * 4 : HUY = HUY + NY * 4 : IF HUX < 1 THEN HUX = 1
4330 IF HUX > 296 THEN HUX = 296
4335 IF HUY < 104 THEN HUY = 104
4340 IF HUY > 146 THEN HUY = 146
4345 IF FACE > 0 THEN PUT (HUX, HUY), HUNR%, PSET : RETURN ELSE PUT (HUX, HUY), HUNL%, PSET : RETURN
4350 IF BON THEN RETURN
4355 IF SHOTS <= 0 THEN LOCATE 23, 2 : PRINT "You have no powder left.          "; : RETURN
4360 SHOTS = SHOTS - 1 : BON = 1 : BLIFE = 28 : BX = HUX + 11 + DX * 10 : BY = HUY + 12 + DY * 10 : IF MUTE = 0 THEN SOUND 80, .5
4365 GOSUB 4380 : RETURN
4380 LOCATE 25, 2 : PRINT "Shots:"; SHOTS; "  Meat:"; MEAT; "funt   "; : RETURN
4400 CLS : GOSUB 7100 : LOCATE 5, 4 : IF MEAT = 0 THEN PRINT "You return with nothing." : GOTO 4415
4405 PRINT "You shot"; MEAT; "funt of meat."
4410 IF MEAT > 100 THEN LOCATE 7, 4 : PRINT "You can carry only 100 funt back" : LOCATE 8, 4 : PRINT "to the caravan." : MEAT = 100
4415 FOOD = FOOD + MEAT : GOSUB 7500 : GOSUB 1200 : RETURN
4500 REM *** MAP ***
4502 CLS : LINE (0, 0)-(319, 183), 6, BF : LINE (2, 2)-(317, 181), 14, B
4505 LINE (8, 34)-(140, 30), 9 : LINE -(258, 26), 9 : LINE -(312, 22), 9 : LINE (8, 84)-(70, 80), 9 : LINE -(136, 80), 9 : LINE -(224, 72), 9
4510 LINE (240, 116)-(214, 140), 9 : LINE -(202, 156), 9 : LINE (312, 142)-(258, 147), 9 : LINE -(202, 156), 9 : LINE -(146, 162), 9 : LINE -(112, 171), 9 : LINE -(60, 176), 9
4515 FOR I = 0 TO 8 : X = 22 + I * 32 : LINE (X, 52)-(X + 9, 40), 7 : LINE -(X + 18, 52), 7 : NEXT
4520 FOR I = 0 TO 6 : X = 44 + I * 29 : LINE (X, 102)-(X + 9, 90), 7 : LINE -(X + 18, 102), 7 : NEXT
4525 FOR I = 0 TO 4 : X = 178 + I * 25 : LINE (X, 130)-(X + 9, 118), 15 : LINE -(X + 18, 130), 15 : NEXT
4530 FOR I = 1 TO 12 : LINE (MAPX(I), MAPY(I))-(MAPX(I + 1), MAPY(I + 1)), 14 : NEXT
4535 FOR I = 1 TO 13 : LINE (MAPX(I) - 2, MAPY(I) - 2)-(MAPX(I) + 2, MAPY(I) + 2), 15, BF : NEXT
4540 LINE (20, 8)-(20, 20), 15 : LINE (14, 14)-(26, 14), 15
4545 J = NXTMARK : IF J > 13 THEN J = 13
4550 T = (VERSTS - MARK(J - 1)) / (MARK(J) - MARK(J - 1)) : X = MAPX(J - 1) + T * (MAPX(J) - MAPX(J - 1)) : Y = MAPY(J - 1) + T * (MAPY(J) - MAPY(J - 1))
4555 CIRCLE (X, Y), 6, 12 : CIRCLE (X, Y), 5, 12
4560 LOCATE 24, 2 : PRINT "The road from the Chu to Iyik Janyl"; : LOCATE 25, 2 : PRINT "Next: "; MARK$(J); : GOSUB 7400 : RETURN
5000 REM *** EACH DAY: FOOD AND HEALTH ***
5002 LIVING = 0 : FOR I = 1 TO 5 : LIVING = LIVING + ALIVE(I) : NEXT
5005 FOOD = FOOD - (4 - RATIONS) * LIVING : IF FOOD < 0 THEN FOOD = 0
5010 T = 1.5 + (PACE - 1) * 4 + (RATIONS - 1) * 4 + CURSE * 2 : IF RESTING THEN T = 0
5015 IF FOOD = 0 THEN T = T + 12 : IF MAREASKED = 0 THEN GOSUB 5400
5020 IF TEMPIDX < 2 AND FELTS < LIVING THEN T = T + (LIVING - FELTS) * (2 - TEMPIDX) * 2
5025 IF TEMPIDX = 4 THEN T = T + 2
5030 IF PRECIP THEN T = T + 1
5035 HP = HP * (.88 - RESTING * .2) + T
5040 FOR I = 1 TO 5 : IF ALIVE(I) = 0 OR SICK(I) = 0 THEN 5060
5045 HP = HP + 1.5 : SICKDAYS(I) = SICKDAYS(I) - 1 - RESTING
5050 IF RND < .008 + HP / 1500 THEN K = SICK(I) : GOSUB 5300 : IF OVER THEN RETURN
5055 IF ALIVE(I) = 1 AND SICKDAYS(I) <= 0 THEN SICK(I) = 0 : M1$ = PARTY$(I) + " is well again." : GOSUB 7600
5060 NEXT I
5065 IF RND < .012 + HP / 800 THEN GOSUB 5200
5070 RETURN
5200 I = INT(RND * 5) + 1 : IF ALIVE(I) = 0 OR SICK(I) > 0 THEN RETURN
5205 K = INT(RND * 4) + 1 : IF K = 4 THEN K = 8
5210 IF ZONE = 1 AND RND < .4 THEN K = 4
5215 IF TEMPIDX < 2 AND FELTS < LIVING AND RND < .5 THEN K = 5
5250 SICK(I) = K : SICKDAYS(I) = 6 + INT(RND * 8)
5255 M1$ = PARTY$(I) + " has " + DISEASE$(K) + "." : GOSUB 7600 : RETURN
5300 ALIVE(I) = 0 : SICK(I) = 0 : IF I = 1 THEN OVER = 1 : DEADCAUSE$ = DISEASE$(K) : RETURN
5305 M1$ = PARTY$(I) + " has died of" : M2$ = DISEASE$(K) + ". The family buries them" : M3$ = "beside the road. Their horse follows."
5310 IF MUTE = 0 THEN PLAY "MB T70 O2 L4 E D C2"
5315 GOSUB 7600 : RETURN
5400 MAREASKED = 1 : IF HORSES < 3 THEN RETURN
5405 LINE (0, 136)-(319, 199), 0, BF : LOCATE 19, 3 : PRINT "The food is gone. A cousin looks at" : LOCATE 20, 3 : PRINT "the lame grey mare and says nothing." : LOCATE 22, 3 : PRINT "Slaughter the mare? (Y/N) ";
5410 GOSUB 7450 : IF K$ <> "Y" AND K$ <> "y" THEN M1$ = "No. The family goes hungry." : GOSUB 7600 : RETURN
5415 HORSES = HORSES - 1 : FOOD = FOOD + 60 : CURSE = 1 : MAREEATEN = 1
5420 M1$ = "It is done. The elders will not eat," : M2$ = "and the women cover their faces. No" : M3$ = "blessing will follow this caravan." : GOSUB 7600 : RETURN
5600 REM *** WEATHER ***
5602 GOSUB 7000 : TEMPIDX = MONTHTEMP(MM) + INT(RND * 3) - 1 : IF ZONE = 1 THEN TEMPIDX = TEMPIDX - 2
5605 IF TEMPIDX < 0 THEN TEMPIDX = 0
5610 IF TEMPIDX > 4 THEN TEMPIDX = 4
5615 PRECIP = 0 : IF RND < .12 THEN IF TEMPIDX < 2 THEN PRECIP = 2 ELSE PRECIP = 1
5620 IF ZONE = 1 AND (DAYNUM < 125 OR DAYNUM > 263) AND RND < .5 THEN PRECIP = 2
5625 WEATHER$ = TEMPWORD$(TEMPIDX) : IF PRECIP = 1 THEN WEATHER$ = "rain" ELSE IF PRECIP = 2 THEN WEATHER$ = "snow"
5630 RETURN
6000 REM *** TITLE PICTURE ***
6002 CLS : HZ = 112 : GOSUB 6850 : FOR I = 1 TO 30 : PSET (INT(RND * 319), INT(RND * 30)), 15 : NEXT
6005 LINE (160, 4)-(160, 20), 15 : LINE (152, 12)-(168, 12), 15 : LINE (155, 7)-(165, 17), 7 : LINE (155, 17)-(165, 7), 7
6010 PX = 70 : PY = 40 : BW = 70 : MC = 8 : SN = 10 : GOSUB 6880 : PX = 240 : PY = 34 : BW = 79 : MC = 7 : SN = 12 : GOSUB 6880 : PX = 160 : PY = 58 : BW = 62 : MC = 1 : SN = 8 : GOSUB 6880
6015 LINE (0, 113)-(319, 135), 2, BF : FOR I = 1 TO 60 : PSET (INT(RND * 319), 114 + INT(RND * 21)), 10 : NEXT
6020 GL = 0 : GX = 130 : GY = 132 : GC = 15 : GR = 1 : GOSUB 9600 : GX = 150 : GC = 7 : GR = 2 : GOSUB 9600 : GX = 170 : GC = 8 : GOSUB 9600
6025 LOCATE 19, 14 : COLOR 14 : PRINT "THE IRAD TRAIL" : COLOR 11 : LOCATE 21, 5 : PRINT "From the Chu to Iyik Janyl, 1877" : COLOR 7 : LOCATE 23, 5 : PRINT "Iradi American Association, 1990" : COLOR 15 : RETURN
6100 CLS : HZ = 100 : GOSUB 6850 : ON NXTMARK GOSUB 6200, 6300, 6400, 6450, 6500, 6300, 6400, 6550, 6400, 6300, 6600, 6650, 6700 : RETURN
6200 PX = 60 : PY = 52 : BW = 60 : MC = 8 : SN = 8 : GOSUB 6880 : PX = 170 : PY = 44 : BW = 80 : MC = 7 : SN = 10 : GOSUB 6880 : PX = 280 : PY = 60 : BW = 39 : MC = 8 : SN = 6 : GOSUB 6880
6205 LINE (0, 101)-(319, 135), 2, BF : LINE (0, 108)-(319, 113), 9, BF : LINE (0, 110)-(319, 110), 11, , &HF0F0
6210 YX = 26 : YY = 128 : GOSUB 6940 : YX = 64 : YY = 132 : GOSUB 6940 : YX = 102 : YY = 127 : GOSUB 6940
6215 LINE (224, 100)-(278, 124), 6, BF : LINE (220, 98)-(282, 100), 4, BF : LINE (246, 110)-(254, 124), 0, BF : LINE (230, 106)-(238, 112), 14, BF : LINE (262, 106)-(270, 112), 14, BF
6220 GL = 0 : GY = 134 : GR = 0 : GX = 150 : GC = 15 : GOSUB 9600 : GX = 176 : GC = 6 : GOSUB 9600 : GX = 196 : GC = 8 : GOSUB 9600 : RETURN
6300 PX = 70 : PY = 48 : BW = 70 : MC = 8 : SN = 8 : GOSUB 6880 : PX = 230 : PY = 40 : BW = 89 : MC = 7 : SN = 10 : GOSUB 6880
6305 LINE (0, 101)-(319, 103), 2, BF : LINE (0, 104)-(319, 114), 1, BF : FOR Y = 106 TO 114 STEP 4 : LINE (0, Y)-(319, Y), 9, , &HF00F : NEXT
6310 LINE (0, 115)-(319, 135), 6, BF : FOR I = 1 TO 14 : X = INT(RND * 300) + 8 : LINE (X, 115)-(X - 2, 110), 10 : LINE (X, 115)-(X + 2, 111), 10 : NEXT
6315 GL = 0 : GY = 134 : GR = 1 : GX = 120 : GC = 15 : GOSUB 9600 : GR = 2 : GX = 140 : GC = 7 : GOSUB 9600 : GX = 160 : GC = 8 : GOSUB 9600 : RETURN
6400 SN = 10 : IF NXTMARK = 9 THEN SN = 24
6405 PX = 60 : PY = 28 : BW = 60 : MC = 8 : GOSUB 6880 : PX = 250 : PY = 24 : BW = 69 : MC = 8 : GOSUB 6880 : PX = 160 : PY = 12 : BW = 100 : MC = 7 : GOSUB 6880
6410 LINE (0, 101)-(319, 135), 8, BF : FOR I = 1 TO 50 : PSET (INT(RND * 319), 102 + INT(RND * 33)), 7 : NEXT
6415 IF NXTMARK = 9 THEN FOR Y = 101 TO 135 STEP 3 : LINE (0, Y)-(319, Y), 15, , &HCCCC : NEXT
6420 LINE (30, 135)-(120, 120), 6 : LINE -(90, 110), 6 : LINE -(150, 101), 6 : CIRCLE (160, 96), 5, 7 : PAINT (160, 96), 7, 7 : CIRCLE (160, 90), 3, 7 : PAINT (160, 90), 7, 7
6425 GL = 1 : GY = 132 : GR = 1 : GX = 180 : GC = 15 : GOSUB 9600 : GR = 2 : GX = 200 : GC = 7 : GOSUB 9600 : RETURN
6450 PX = 60 : PY = 56 : BW = 60 : MC = 8 : SN = 6 : GOSUB 6880 : PX = 250 : PY = 52 : BW = 69 : MC = 8 : SN = 6 : GOSUB 6880
6452 LINE (0, 101)-(319, 135), 6, BF : FOR I = 1 TO 40 : PSET (INT(RND * 319), 102 + INT(RND * 33)), 14 : NEXT
6455 LINE (70, 70)-(250, 120), 7, BF : LINE (58, 60)-(80, 120), 15, BF : LINE (240, 60)-(262, 120), 15, BF : CIRCLE (69, 60), 11, 15, 0, 3.1416 : PAINT (69, 56), 15, 15 : CIRCLE (251, 60), 11, 15, 0, 3.1416 : PAINT (251, 56), 15, 15
6460 FOR X = 84 TO 232 STEP 10 : LINE (X, 68)-(X + 4, 72), 0, BF : NEXT : FOR Y = 80 TO 114 STEP 8 : LINE (82, Y)-(140, Y), 8 : LINE (180, Y)-(238, Y), 8 : NEXT
6465 LINE (140, 66)-(180, 120), 15, BF : LINE (148, 86)-(172, 120), 0, BF : CIRCLE (160, 86), 12, 0, 0, 3.1416 : PAINT (160, 82), 0, 0
6470 GL = 0 : GY = 134 : GR = 1 : GX = 100 : GC = 15 : GOSUB 9600 : GR = 2 : GX = 120 : GC = 7 : GOSUB 9600 : RETURN
6500 PX = 80 : PY = 40 : BW = 80 : MC = 8 : SN = 12 : GOSUB 6880 : PX = 240 : PY = 46 : BW = 79 : MC = 7 : SN = 12 : GOSUB 6880
6502 LINE (0, 101)-(319, 135), 2, BF
6505 LINE (40, 76)-(280, 122), 6, BF : FOR X = 40 TO 276 STEP 12 : LINE (X, 70)-(X + 6, 76), 6, BF : NEXT : LINE (34, 62)-(54, 122), 6, BF : LINE (266, 62)-(286, 122), 6, BF
6510 LINE (148, 98)-(172, 122), 0, BF : FOR Y = 84 TO 116 STEP 8 : LINE (40, Y)-(280, Y), 4, , &HF0F0 : NEXT
6515 LINE (160, 76)-(160, 40), 15 : LINE (161, 40)-(186, 44), 15, BF : LINE (161, 45)-(186, 49), 1, BF : LINE (161, 50)-(186, 54), 4, BF
6520 GL = 0 : GY = 134 : GR = 1 : GX = 200 : GC = 15 : GOSUB 9600 : GR = 2 : GX = 220 : GC = 7 : GOSUB 9600 : RETURN
6550 PX = 80 : PY = 36 : BW = 80 : MC = 7 : SN = 14 : GOSUB 6880 : PX = 240 : PY = 30 : BW = 79 : MC = 8 : SN = 14 : GOSUB 6880
6555 LINE (0, 101)-(319, 135), 10, BF : FOR I = 1 TO 70 : PSET (INT(RND * 319), 102 + INT(RND * 33)), 14 + (I MOD 3 = 0) : NEXT
6560 YX = 30 : YY = 120 : GOSUB 6940 : YX = 72 : YY = 126 : GOSUB 6940 : YX = 250 : YY = 122 : GOSUB 6940
6565 GL = 0 : GR = 0 : GY = 132 : GX = 130 : GC = 15 : GOSUB 9600 : GX = 165 : GC = 6 : GOSUB 9600 : GY = 116 : GX = 190 : GC = 8 : GOSUB 9600 : RETURN
6600 LINE (0, 100)-(60, 84), 6 : LINE -(130, 92), 6 : LINE -(200, 78), 6 : LINE -(270, 90), 6 : LINE -(319, 82), 6 : LINE -(319, 100), 6 : LINE -(0, 100), 6 : PAINT (100, 96), 6, 6
6605 LINE (0, 101)-(319, 135), 14, BF : FOR I = 1 TO 50 : PSET (INT(RND * 319), 102 + INT(RND * 33)), 6 : NEXT
6610 FOR I = 0 TO 3 : SX = 12 + I * 76 : C = 4 + 5 * (I MOD 2) : LINE (SX, 96)-(SX + 56, 104), C, BF : LINE (SX, 96)-(SX + 56, 104), 15, , &HF0F0 : LINE (SX + 2, 105)-(SX + 2, 126), 6 : LINE (SX + 54, 105)-(SX + 54, 126), 6
6615 LINE (SX + 6, 118)-(SX + 50, 126), 6, BF : CIRCLE (SX + 16, 115), 4, 10 : PAINT (SX + 16, 115), 10, 10 : CIRCLE (SX + 30, 115), 4, 14 : PAINT (SX + 30, 115), 14, 14 : CIRCLE (SX + 42, 115), 4, 10 : PAINT (SX + 42, 115), 10, 10 : NEXT I
6620 FOR I = 0 TO 5 : X = 30 + I * 48 : LINE (X, 134)-(X, 128), 1 : LINE (X - 2, 129)-(X + 2, 133), 1, BF : LINE (X - 1, 125)-(X + 1, 127), 14, BF : NEXT : RETURN
6650 FOR Y = 0 TO 135 STEP 2 : X = 70 + 18 * SIN(Y / 9) : LINE (0, Y)-(X, Y + 1), 6, BF : LINE (X - 6, Y)-(X, Y + 1), 4, BF : X = 250 + 18 * COS(Y / 11) : LINE (X, Y)-(319, Y + 1), 4, BF : LINE (X, Y)-(X + 6, Y + 1), 6, BF : NEXT
6655 LINE (96, 112)-(226, 135), 1, BF : FOR Y = 114 TO 134 STEP 4 : LINE (96, Y)-(226, Y), 9, , &HE0E0 : NEXT : FOR I = 1 TO 8 : X = 100 + INT(RND * 120) : LINE (X, 113)-(X + 6, 113), 15 : NEXT
6660 LINE (90, 110)-(232, 104), 7 : GL = 0 : GY = 108 : GR = 1 : GX = 130 : GC = 15 : GOSUB 9600 : GR = 2 : GX = 150 : GC = 7 : GOSUB 9600 : RETURN
6700 LINE (0, 0)-(319, 100), 1, BF : FOR Y = 30 TO 100 STEP 2 : LINE (0, Y)-(319, Y), 13, , &H8888 : NEXT : LINE (160, 6)-(160, 16), 15 : LINE (155, 11)-(165, 11), 15
6705 LINE (60, 116)-(160, 46), 2 : LINE -(260, 116), 2 : LINE -(60, 116), 2 : PAINT (160, 90), 2, 2 : FOR I = 1 TO 30 : PSET (90 + INT(RND * 140), 70 + INT(RND * 44)), 10 : NEXT
6710 LINE (146, 34)-(174, 50), 15, BF : CIRCLE (160, 34), 9, 7, 0, 3.1416 : LINE (151, 34)-(169, 34), 7 : PAINT (160, 30), 7, 7 : LINE (160, 25)-(160, 14), 14 : LINE (155, 18)-(165, 18), 14 : LINE (157, 40)-(163, 50), 0, BF
6715 LINE (180, 44)-(184, 36), 8 : LINE -(181, 28), 8 : LINE -(186, 20), 8
6720 LINE (0, 117)-(319, 135), 9, BF : FOR Y = 119 TO 134 STEP 3 : LINE (0, Y)-(319, Y), 1, , &HF0F0 : NEXT
6725 FOR I = 0 TO 4 : X = 4 + I * 12 : LINE (X, 104)-(X + 9, 115), 6, BF : LINE (X + 3, 109)-(X + 5, 115), 0, BF : X = 262 + I * 11 : LINE (X, 104)-(X + 8, 115), 6, BF : NEXT : RETURN
6750 REM *** GRAVE ***
6752 CLS : HZ = 100 : GOSUB 6850 : PX = 160 : PY = 50 : BW = 120 : MC = 8 : SN = 8 : GOSUB 6880 : LINE (0, 101)-(319, 135), 2, BF
6755 CIRCLE (130, 128), 40, 6, 0, 3.1416, .35 : LINE (90, 128)-(170, 128), 6 : PAINT (130, 124), 6, 6
6760 LINE (130, 116)-(130, 84), 15 : LINE (120, 94)-(140, 94), 15 : LINE (124, 116)-(130, 110), 15 : LINE -(136, 116), 15 : LINE (120, 114)-(126, 108), 15 : LINE (140, 114)-(134, 108), 15
6765 GL = 0 : GY = 132 : GR = 2 : GX = 200 : GC = 15 : GOSUB 9600 : RETURN
6800 REM *** THE ROAD AHEAD ***
6802 CLS : HZ = 96 : GOSUB 6850 : LINE (160, 6)-(160, 14), 15 : LINE (156, 10)-(164, 10), 15 : T = MARKTYPE(NXTMARK) : SN = 6
6805 IF T = 2 THEN PX = 80 : PY = 24 : BW = 80 : MC = 8 : SN = 12 : GOSUB 6880 : PX = 220 : PY = 30 : BW = 99 : MC = 7 : SN = 12 : GOSUB 6880
6810 IF T <> 2 AND T <> 5 THEN PX = 120 : PY = 60 : BW = 90 : MC = 8 : GOSUB 6880 : PX = 250 : PY = 54 : BW = 69 : MC = 7 : GOSUB 6880
6815 IF T = 5 THEN FOR Y = 10 TO 96 STEP 2 : X = 40 + 10 * SIN(Y / 7) : LINE (0, Y)-(X, Y + 1), 6, BF : X = 280 + 10 * COS(Y / 9) : LINE (X, Y)-(319, Y + 1), 4, BF : NEXT
6820 LINE (0, 97)-(319, 105), 2, BF : IF ZONE = 1 THEN LINE (0, 97)-(319, 105), 8, BF
6825 LINE (0, 106)-(319, 135), 6, BF : LINE (0, 108)-(319, 108), 8, , &HF0F0 : LINE (0, 133)-(319, 133), 8, , &HF0F0
6830 ON T GOSUB 6831, 6832, 6833, 6834, 6835, 6836 : RETURN
6831 LINE (0, 97)-(16, 135), 9, BF : LINE (0, 100)-(16, 135), 1, , &HAAAA : RETURN
6832 LINE (2, 105)-(14, 80), 15 : LINE -(26, 105), 15 : RETURN
6833 LINE (0, 90)-(22, 105), 15, BF : LINE (8, 96)-(14, 105), 0, BF : RETURN
6834 YX = 2 : YY = 104 : GOSUB 6940 : RETURN
6835 RETURN
6836 LINE (0, 105)-(14, 86), 10 : LINE -(28, 105), 10 : LINE -(0, 105), 10 : PAINT (14, 100), 10, 10 : LINE (12, 86)-(16, 80), 15, BF : LINE (14, 79)-(14, 74), 14 : RETURN
6850 LINE (0, 0)-(319, HZ), 9, BF : LINE (0, 0)-(319, 9), 1, BF : FOR Y = 10 TO 25 : IF Y MOD 2 THEN LINE (0, Y)-(319, Y), 1, , &H5555 ELSE LINE (0, Y)-(319, Y), 1, , &HAAAA
6855 NEXT Y : FOR Y = 26 TO 40 STEP 2 : LINE (0, Y)-(319, Y), 1, , &H8888 : NEXT : RETURN
6880 LINE (PX - BW, HZ)-(PX, PY), MC : LINE -(PX + BW, HZ), MC : LINE -(PX - BW, HZ), MC : PAINT (PX, HZ - 1), MC, MC
6885 SW = BW * SN / (HZ - PY) : LINE (PX - SW, PY + SN)-(PX, PY), 15 : LINE -(PX + SW, PY + SN), 15 : LINE -(PX + SW / 3, PY + SN - 3), 15 : LINE -(PX, PY + SN), 15 : LINE -(PX - SW / 3, PY + SN - 3), 15 : LINE -(PX - SW, PY + SN), 15
6890 PAINT (PX, PY + 2), 15, 15 : RETURN
6900 X = 30 + INT(220 * (MARK(NXTMARK) - VERSTS) / (MARK(NXTMARK) - LASTMARK)) : IF X < 30 THEN X = 30
6905 IF X > 250 THEN X = 250
6910 IF OLDCX >= 0 THEN LINE (OLDCX, 112)-(OLDCX + 59, 132), 6, BF
6915 LEGF = 1 - LEGF : IF LEGF THEN PUT (X, 112), CARA%, PSET ELSE PUT (X, 112), CARB%, PSET
6920 OLDCX = X : RETURN
6940 CIRCLE (YX + 8, YY - 8), 9, 15, 0, 3.1416, .7 : LINE (YX, YY - 8)-(YX + 16, YY), 15, BF : PAINT (YX + 8, YY - 10), 15, 15
6945 LINE (YX + 6, YY - 5)-(YX + 10, YY), 4, BF : LINE (YX, YY - 8)-(YX + 16, YY - 8), 6 : LINE (YX + 6, YY - 14)-(YX + 10, YY - 14), 6 : RETURN
7000 MM = 12
7005 IF DAYNUM <= MONTHSTART(MM) THEN MM = MM - 1 : GOTO 7005
7010 DT$ = MONTH$(MM) + STR$(DAYNUM - MONTHSTART(MM)) + ", 1877" : RETURN
7100 LINE (2, 2)-(317, 189), 9, B : LINE (5, 5)-(314, 186), 1, B : RETURN
7200 LINE (0, 136)-(319, 199), 0, BF : LINE (2, 138)-(317, 189), 7, B : GOSUB 7000 : GOSUB 7300
7205 LOCATE 19, 3 : PRINT "Date: "; DT$ : LOCATE 19, 28 : PRINT "Food:"; INT(FOOD)
7210 LOCATE 20, 3 : PRINT "Weather: "; WEATHER$ : LOCATE 20, 28 : PRINT "Horses:"; HORSES
7215 LOCATE 21, 3 : PRINT "Health: "; HEALTH$
7220 LOCATE 22, 3 : PRINT "Next landmark:"; INT(MARK(NXTMARK) - VERSTS); "versts"
7225 LOCATE 23, 3 : PRINT "Versts traveled:"; INT(VERSTS)
7230 LOCATE 25, 3 : COLOR 14 : PRINT "Press ENTER to size up the situation"; : COLOR 15 : RETURN
7300 HEALTH$ = "good" : IF HP > 25 THEN HEALTH$ = "fair"
7305 IF HP > 50 THEN HEALTH$ = "poor"
7310 IF HP > 80 THEN HEALTH$ = "very poor"
7315 RETURN
7400 K$ = "" : WHILE K$ = "" : K$ = INKEY$ : WEND : RETURN
7450 GOSUB 7400 : IF LEN(K$) = 1 THEN IF K$ >= " " THEN PRINT K$;
7455 RETURN
7500 LOCATE 25, 9 : COLOR 14 : PRINT "Press ENTER to continue"; : COLOR 15
7505 GOSUB 7400 : IF K$ <> CHR$(13) AND K$ <> " " THEN 7505
7510 LOCATE 25, 1 : PRINT SPACE$(39); : RETURN
7600 LINE (0, 136)-(319, 199), 0, BF : LOCATE 19, 3 : PRINT LEFT$(M1$, 37) : IF M2$ <> "" THEN LOCATE 20, 3 : PRINT LEFT$(M2$, 37)
7605 IF M3$ <> "" THEN LOCATE 21, 3 : PRINT LEFT$(M3$, 37)
7610 M1$ = "" : M2$ = "" : M3$ = "" : GOSUB 7500 : RETURN
7700 T$ = "" : FOR J = 1 TO LEN(S$) : C$ = MID$(S$, J, 1) : IF C$ = "/" THEN PRINT TAB(4); T$ : T$ = "" ELSE T$ = T$ + C$
7705 NEXT J : PRINT TAB(4); T$ : RETURN
8000 REM *** THE NARYN GORGE ***
8002 LINE (0, 136)-(319, 199), 0, BF : LOCATE 19, 3 : PRINT "The road ends at the Naryn gorge." : LOCATE 20, 3 : PRINT "You may:"
8005 LOCATE 21, 4 : PRINT "1. Raft down the Naryn to Iyik Janyl" : LOCATE 22, 4 : PRINT "2. Take the Kara-Kol mountain road" : LOCATE 23, 4 : PRINT "   (30 rubles to the herders)"
8010 LOCATE 25, 4 : PRINT "What is your choice? "; : GOSUB 7450 : K = VAL(K$) : IF K < 1 OR K > 2 THEN 8000
8015 IF K = 2 AND MONEY < 30 THEN M1$ = "You cannot pay the herders. The" : M2$ = "river is the only way." : GOSUB 7600 : K = 1
8020 IF K = 1 THEN GOSUB 8100 : IF OVER THEN 8600 ELSE 8300
8025 MONEY = MONEY - 30 : LASTMARK = MARK(NXTMARK) : NXTMARK = NXTMARK + 1 : ATLAND = 0 : M1$ = "The herders lead you up the" : M2$ = "Kara-Kol road toward Iyik Janyl." : GOSUB 7600 : GOTO 1000
8050 LINE (0, 136)-(319, 199), 0, BF : LOCATE 19, 3 : PRINT "Iyik Janyl! The Naryn runs below" : LOCATE 20, 3 : PRINT "Cathedral Hill."
8052 LOCATE 22, 4 : PRINT "1. Ford the Naryn" : LOCATE 23, 4 : PRINT "2. Pay the ferry, 10 rubles" : LOCATE 25, 4 : PRINT "What is your choice? ";
8055 GOSUB 7450 : K = VAL(K$) : IF K < 1 OR K > 2 THEN 8055
8060 IF K = 2 AND MONEY < 10 THEN K = 1
8065 IF K = 2 THEN MONEY = MONEY - 10 : M1$ = "The ferry creaks across." : GOSUB 7600 : GOTO 8300
8070 IF RND < .75 THEN M1$ = "Cold and wet, but across." : GOSUB 7600 : GOTO 8300
8075 HORSES = HORSES - 2 : FOOD = FOOD - 50 : IF HORSES < 0 THEN HORSES = 0
8080 IF FOOD < 0 THEN FOOD = 0
8085 M1$ = "The Naryn takes two packhorses." : GOSUB 7600 : IF RND < .2 THEN GOSUB 3150 : IF OVER THEN 8600
8090 GOTO 8300
8100 REM *** RAFTING THE NARYN ***
8102 GOSUB 8250
8110 RX = 140 : RY = 150 : RDIST = 70 : HITS = 0 : FR = 0 : FOR I = 1 TO 4 : RKY(I) = -1 : NEXT
8115 PUT (RX, RY), RAFT%, PSET : GOSUB 8290
8120 T = TIMER : K$ = INKEY$ : IF K$ = CHR$(0) + "K" THEN RX = RX - 6 ELSE IF K$ = CHR$(0) + "M" THEN RX = RX + 6
8125 IF RX < 54 THEN RX = 54
8130 IF RX > 226 THEN RX = 226
8135 PUT (RX, RY), RAFT%, PSET
8140 FOR I = 1 TO 4 : IF RKY(I) < 0 THEN IF RND < .07 THEN RKX(I) = 62 + INT(RND * 176) : RKY(I) = 0 : GOTO 8150
8145 IF RKY(I) >= 0 THEN RKY(I) = RKY(I) + 6 : IF RKY(I) > 162 THEN LINE (RKX(I), RKY(I) - 6)-(RKX(I) + 19, RKY(I) + 13), 1, BF : RKY(I) = -1
8150 IF RKY(I) >= 0 THEN PUT (RKX(I), RKY(I)), ROCK%, PSET : IF RKY(I) + 19 > RY + 3 AND RKY(I) + 6 < RY + 17 AND RKX(I) + 17 > RX + 7 AND RKX(I) + 3 < RX + 33 THEN GOSUB 8200
8155 NEXT I
8160 FR = FR + 1 : RDIST = RDIST - .25 : IF FR MOD 8 = 0 THEN GOSUB 8290
8165 IF OVER THEN RETURN
8170 IF RDIST <= 0 THEN 8180
8175 WHILE TIMER = T : WEND : GOTO 8120
8180 VERSTS = 690 : DAYNUM = DAYNUM + 2 : M1$ = "You land on the flats below" : M2$ = "Cathedral Hill." : GOSUB 7600 : RETURN
8200 LINE (RKX(I), RKY(I))-(RKX(I) + 19, RKY(I) + 19), 1, BF : RKY(I) = -1 : HITS = HITS + 1 : PUT (RX, RY), RAFT%, PSET : IF MUTE = 0 THEN SOUND 50, 2
8205 R = RND : LOCATE 23, 2
8210 IF R < .55 THEN T = INT(RND * 40) + 20 : FOOD = FOOD - T : IF FOOD < 0 THEN FOOD = 0
8215 IF R < .55 THEN PRINT "Rock! You lose"; T; "funt of food.     "; : RETURN
8220 IF R < .8 THEN IF FELTS > 0 THEN FELTS = FELTS - 1 : PRINT "Rock! A felt coat goes overboard.  "; : RETURN
8225 IF R < .8 THEN PRINT "Rock! The raft holds together.    "; : RETURN
8230 J = INT(RND * 5) + 1 : IF ALIVE(J) = 0 THEN PRINT "Rock! The raft spins and holds.   "; : RETURN
8235 PRINT PARTY$(J); " is thrown into the river!  "; : IF RND < .5 THEN RETURN
8240 I0 = I : I = J : K = 9 : GOSUB 5300 : I = I0 : IF OVER THEN RETURN
8245 GOSUB 8250 : FOR I1 = 1 TO 4 : RKY(I1) = -1 : NEXT : PUT (RX, RY), RAFT%, PSET : RETURN
8250 CLS : LINE (0, 0)-(319, 183), 2, BF : LINE (60, 0)-(259, 183), 1, BF : LINE (56, 0)-(59, 183), 6, BF : LINE (260, 0)-(263, 183), 6, BF
8255 FOR I1 = 1 TO 24 : X = INT(RND * 50) + 2 : Y = INT(RND * 170) + 6 : CIRCLE (X, Y), 4, 10 : X = INT(RND * 46) + 270 : CIRCLE (X, Y), 4, 10 : NEXT
8260 LOCATE 24, 2 : PRINT "Steer with LEFT and RIGHT arrows"; : RETURN
8290 LOCATE 25, 2 : PRINT "Versts to Iyik Janyl:"; INT(RDIST); "  "; : RETURN
8300 REM *** ARRIVAL ***
8302 NXTMARK = 13 : GOSUB 6100 : LOCATE 19, 3 : COLOR 14 : PRINT "You have reached Iyik Janyl!" : COLOR 15 : GOSUB 7000 : LOCATE 20, 3 : PRINT DT$
8305 IF MUTE = 0 THEN PLAY "MB T110 O3 L8 G A B > D4 < B > D E4 D < B A G2"
8310 IF DAYNUM <= 236 THEN LOCATE 21, 3 : PRINT "In time for the Feast of St. Janyl!"
8315 LOCATE 22, 3 : PRINT "Juniper smoke rises over the hill." : LOCATE 23, 3 : PRINT "The kashysh blesses your household."
8320 GOSUB 7500 : IF MAREEATEN THEN M1$ = "But the elders do not forget the" : M2$ = "grey mare." : GOSUB 7600
8330 CLS : GOSUB 7100 : GOSUB 7300 : T = 500 - 100 * (-(HP > 25) - (HP > 50) - (HP > 80)) : LIVING = 0 : FOR I = 1 TO 5 : LIVING = LIVING + ALIVE(I) : NEXT
8335 COLOR 14 : LOCATE 3, 4 : PRINT "Points for arriving" : COLOR 15
8340 LOCATE 5, 4 : PRINT LIVING; "in "; HEALTH$; " health"; TAB(32); LIVING * T
8345 LOCATE 6, 4 : PRINT HORSES; "horses"; TAB(32); HORSES * 4 : LOCATE 7, 4 : PRINT INT(FOOD); "funt of food"; TAB(32); INT(FOOD / 25)
8350 LOCATE 8, 4 : PRINT FELTS; "felt coats"; TAB(32); FELTS * 2 : LOCATE 9, 4 : PRINT SHOTS; "shots of powder"; TAB(32); INT(SHOTS / 20)
8355 LOCATE 10, 4 : PRINT SHOES + SADDLES; "spare tack"; TAB(32); (SHOES + SADDLES) * 2 : LOCATE 11, 4 : PRINT INT(MONEY); "rubles"; TAB(32); INT(MONEY / 5)
8360 SCORE = LIVING * T + HORSES * 4 + INT(FOOD / 25) + FELTS * 2 + INT(SHOTS / 20) + (SHOES + SADDLES) * 2 + INT(MONEY / 5)
8365 IF DAYNUM <= 236 THEN LOCATE 12, 4 : PRINT "Feast of St. Janyl"; TAB(32); 500 : SCORE = SCORE + 500
8370 LOCATE 14, 4 : PRINT "Total"; TAB(32); SCORE
8375 IF OCC = 2 THEN LOCATE 16, 4 : PRINT "As a felt merchant, your points" : LOCATE 17, 4 : PRINT "are doubled." : SCORE = SCORE * 2
8380 IF OCC = 3 THEN LOCATE 16, 4 : PRINT "As a herder, your points are" : LOCATE 17, 4 : PRINT "tripled." : SCORE = SCORE * 3
8385 LOCATE 19, 4 : COLOR 14 : PRINT "Final score"; TAB(32); SCORE : COLOR 15
8390 RANK$ = "Greenhorn" : IF SCORE >= 2000 THEN RANK$ = "Rider"
8392 IF SCORE >= 4000 THEN RANK$ = "Trail guide"
8395 GOSUB 7500 : GOTO 8800
8600 REM *** THE END OF THE ROAD ***
8602 IF OVER = 1 THEN 8650
8605 CLS : GOSUB 7100 : LOCATE 5, 1
8610 IF OVER = 2 THEN S$ = "Snow closes the pass in front of/you. The family turns back to winter/in the valleys. Perhaps next spring." : GOSUB 7700
8615 IF OVER = 3 THEN S$ = "With one horse left, the caravan/cannot go on. You winter with/strangers and pray for spring." : GOSUB 7700
8620 GOSUB 7500 : GOTO 8700
8650 GOSUB 6750 : LOCATE 19, 3 : PRINT PARTY$(1); " has died of" : LOCATE 20, 3 : PRINT DEADCAUSE$; "."
8655 IF MUTE = 0 THEN PLAY "T70 O2 L4 E D C2 P4 E D C2"
8660 LOCATE 22, 3 : PRINT "What words for the grave?" : LOCATE 23, 3 : LINE INPUT "> "; A$ : A$ = LEFT$(A$, 34)
8665 IF NGRAVES = 20 THEN FOR I = 1 TO 19 : GRAVEV(I) = GRAVEV(I + 1) : GRAVENAME$(I) = GRAVENAME$(I + 1) : GRAVEEPI$(I) = GRAVEEPI$(I + 1) : NEXT : NGRAVES = 19
8670 NGRAVES = NGRAVES + 1 : GRAVEV(NGRAVES) = INT(VERSTS) : GRAVENAME$(NGRAVES) = PARTY$(1) : GRAVEEPI$(NGRAVES) = A$ : GOSUB 8930
8675 CLS : GOSUB 7100 : LOCATE 5, 4 : PRINT "The women sing the koshok for" : LOCATE 6, 4 : PRINT PARTY$(1); "." : LOCATE 8, 4 : PRINT "Without its leader, the family" : LOCATE 9, 4 : PRINT "turns back toward the Chu."
8680 GOSUB 7500
8700 CLS : GOSUB 7100 : LOCATE 10, 4 : PRINT "Would you like to play again? (Y/N) "; : GOSUB 7450
8705 IF K$ = "Y" OR K$ = "y" THEN 200
8710 GOTO 270
8800 REM *** THE TOP TEN ***
8802 IF SCORE <= BESTSCORE(10) THEN GOSUB 410 : GOTO 8700
8805 CLS : GOSUB 7100 : LOCATE 4, 4 : PRINT "Your score is one of the ten best!" : LOCATE 6, 4 : PRINT "Enter a name for the Top Ten:" : LOCATE 8, 5 : LINE INPUT "> "; A$ : IF A$ = "" THEN A$ = PARTY$(1)
8810 A$ = LEFT$(A$, 16) : I = 10
8815 IF I > 1 THEN IF BESTSCORE(I - 1) < SCORE THEN BESTNAME$(I) = BESTNAME$(I - 1) : BESTSCORE(I) = BESTSCORE(I - 1) : BESTRANK$(I) = BESTRANK$(I - 1) : I = I - 1 : GOTO 8815
8820 BESTNAME$(I) = A$ : BESTSCORE(I) = SCORE : BESTRANK$(I) = RANK$ : GOSUB 8920 : GOSUB 410 : GOTO 8700
8900 REM *** LOAD THE TOP TEN AND THE GRAVES ***
8902 GOSUB 8950 : FILEOK = 1 : OPEN "IRADTOP.DAT" FOR INPUT AS #1 : IF FILEOK = 0 THEN 8910
8905 FOR I = 1 TO 10 : INPUT #1, BESTNAME$(I), BESTSCORE(I), BESTRANK$(I) : NEXT : CLOSE #1
8910 NGRAVES = 0 : FILEOK = 1 : OPEN "IRADGRV.DAT" FOR INPUT AS #1 : IF FILEOK = 0 THEN RETURN
8915 INPUT #1, NGRAVES : FOR I = 1 TO NGRAVES : INPUT #1, GRAVEV(I), GRAVENAME$(I), GRAVEEPI$(I) : NEXT : CLOSE #1 : RETURN
8920 FILEOK = 1 : OPEN "IRADTOP.DAT" FOR OUTPUT AS #1 : IF FILEOK = 0 THEN RETURN
8925 FOR I = 1 TO 10 : WRITE #1, BESTNAME$(I), BESTSCORE(I), BESTRANK$(I) : NEXT : CLOSE #1 : RETURN
8930 FILEOK = 1 : OPEN "IRADGRV.DAT" FOR OUTPUT AS #1 : IF FILEOK = 0 THEN RETURN
8935 PRINT #1, NGRAVES : FOR I = 1 TO NGRAVES : WRITE #1, GRAVEV(I), GRAVENAME$(I), GRAVEEPI$(I) : NEXT : CLOSE #1 : RETURN
8950 RESTORE 9300 : FOR I = 1 TO 10 : READ BESTNAME$(I), BESTSCORE(I), BESTRANK$(I) : NEXT : RETURN
9000 DATA January,0,0,February,31,0,March,59,1,April,90,2,May,120,2,June,151,3
9005 DATA July,181,4,August,212,4,September,243,3,October,273,1,November,304,0,December,334,0
9010 DATA 0,0,"The lower Chu",282,12,25,1,"The Chu River",262,27,140,2,"The Kok-Bel Pass",238,47,215,3,"Rabat-i-Safed",182,64
9015 DATA 240,3,"The Talas fort",146,69,255,1,"The Talas River",136,80,330,2,"The Otmek Pass",160,98,400,4,"The Suusamyr Valley",194,111
9020 DATA 450,2,"The Ala-Bel Pass",222,124,500,1,"The Chychkan River",216,140,570,3,"Ketmen-Tobo",188,151,620,5,"The Naryn gorge",146,162,690,6,"Iyik Janyl",112,171
9030 DATA "Osmon the shopkeeper:/ /'Take more felts than you think you/need. Even in June the Kok-Bel/bites.'"
9031 DATA "A riverman:/ /'We blow up goatskins and lash them/under a frame. A tursuk raft will/carry a whole yurt across.'"
9032 DATA "A shepherd:/ /'When the cairn on top shows black,/the pass is open. When it is white,/wait a week.'"
9033 DATA "The keeper of the caravanserai:/ /'Sogdian merchants built these/walls. Three hundred horses once/slept in these stables. Now it is/quiet.'"
9034 DATA "A Russian clerk:/ /'Your papers. The Governor-General/wants every herd counted and every/head taxed.'"
9035 DATA "An old woman at the well:/ /'Do not drink below the camps. The/flux lives in still water.'"
9036 DATA "A hunter with a berkut:/ /'The arkhar come down to graze at/dawn. Walk slowly, and shoot only/when you see horns.'"
9037 DATA "An aksakal of the zhayloo:/ /'Sit, drink. A guest is a gift from/God. The Ala-Bel will still be there/tomorrow.'"
9038 DATA "A pilgrim at the cairn:/ /'From here the road runs downhill to/St. Janyl. Say a bata for those who/did not arrive.'"
9039 DATA "A boy with a fishing line:/ /'The river is lowest at first light./Cross early.'"
9040 DATA "A merchant from Kokand:/ /'My prices? The road is long, and/the Tsar's tax is longer.'"
9041 DATA "A raftsman:/ /'Keep to the middle of the Naryn and/watch for white water. White water/means a rock.'"
9042 DATA "The kashysh:/ /'Welcome home.'"
9050 DATA camp fever,the flux,typhus,mountain sickness,frostbite,a broken arm,a viper bite,exhaustion,drowning,a sabre wound,hunger,cold
9060 DATA "Horses",20,"Osmon says:/ /'You'll want one horse for each/rider and two or three for the yurt/and packs. Six is the least I'd/take.'"
9062 DATA "Food (10-funt sacks)",1,"Osmon says:/ /'Flour, kurut, mutton and tea. Five/people eat 15 funt a day. Take at/least 50 sacks.'"
9064 DATA "Felt coats",5,"Osmon says:/ /'The passes are cold even in summer./Take a felt coat for every person.'"
9066 DATA "Powder (box of 20)",2,"Osmon says:/ /'For hunting, and for wolves and/thieves. Three or four boxes will/do.'"
9068 DATA "Spare horseshoes",2,"Osmon says:/ /'Stony roads cost shoes. A few/spares will save you days.'"
9069 DATA "Pack saddles",5,"Osmon says:/ /'A broken pack saddle means leaving/your goods by the road. Take two.'"
9070 DATA very cold,cold,cool,warm,hot
9080 DATA steady,filling,strenuous,meager,grueling,bare bones
9085 DATA "1. Continue on the road","2. Check supplies","3. Look at the map","4. Change the pace","5. Change food rations","6. Stop to rest","7. Attempt to trade"
9090 DATA Asan,Saira,Temir,Kanykei,Bolot
9095 DATA "a hare",26,12,4,"a marmot",22,14,8,"a roe deer",36,22,50,"an arkhar",36,24,150
9300 DATA "Esen Bakyt uulu",7200,"Trail guide","Jyldyz Omor kyzy",5480,"Trail guide","Temir Sali uulu",4310,"Trail guide"
9305 DATA "Altynai Bek kyzy",3020,"Rider","Omur Kasym uulu",2210,"Rider","Bubu Isa kyzy",1540,"Greenhorn","Nurlan Osmon uulu",980,"Greenhorn"
9310 DATA "Gulaim Talap kyzy",640,"Greenhorn","Aibek Doolot uulu",410,"Greenhorn","Cholpon Adyl kyzy",260,"Greenhorn"
9500 REM *** DRAW THE SPRITES AND STORE THEM WITH GET ***
9505 FOR K = 0 TO 1 : LINE (0, 0)-(59, 20), 6, BF : GL = K : GY = 20 : GR = 1 : GX = 4 : GC = 15 : GOSUB 9600 : GR = 2 : GX = 23 : GC = 7 : GOSUB 9600 : GX = 42 : GC = 8 : GOSUB 9600
9510 IF K = 0 THEN GET (0, 0)-(59, 20), CARA% ELSE GET (0, 0)-(59, 20), CARB%
9515 NEXT K
9520 FOR K = 0 TO 1 : LINE (0, 0)-(21, 27), 2, BF : GX = 0 : GY = 0 : GD = 1 - 2 * K : GOSUB 9700
9525 IF K = 0 THEN GET (0, 0)-(21, 27), HUNR% ELSE GET (0, 0)-(21, 27), HUNL%
9530 NEXT K
9535 FOR KD = 1 TO 4 : FOR K = 0 TO 1 : LINE (0, 0)-(AW(KD) - 1, AH(KD) - 1), 2, BF : GD = 1 - 2 * K : GX = 0 : GY = 0 : GOSUB 9750
9540 GET (0, 0)-(AW(KD) - 1, AH(KD) - 1), ANIM%(((KD - 1) * 2 + K) * 245) : NEXT K : NEXT KD
9545 LINE (0, 0)-(39, 19), 1, BF : GOSUB 9800 : GET (0, 0)-(39, 19), RAFT%
9550 LINE (0, 0)-(19, 19), 1, BF : GOSUB 9820 : GET (0, 0)-(19, 19), ROCK%
9555 CLS : RETURN
9600 REM HORSE FACING LEFT. GX LEFT EDGE, GY GROUND, GC COAT, GL LEGS, GR 1 RIDER 2 PACKS
9602 LINE (GX + 4, GY - 9)-(GX + 13, GY - 5), GC, BF : LINE (GX + 2, GY - 12)-(GX + 4, GY - 7), GC, BF : LINE (GX, GY - 13)-(GX + 3, GY - 11), GC, BF : LINE (GX + 3, GY - 15)-(GX + 3, GY - 13), GC
9604 LINE (GX + 14, GY - 9)-(GX + 16, GY - 4), 8 : PSET (GX + 1, GY - 12), 0
9606 IF GL = 0 THEN LINE (GX + 5, GY - 5)-(GX + 5, GY), GC : LINE (GX + 12, GY - 5)-(GX + 12, GY), GC ELSE LINE (GX + 5, GY - 5)-(GX + 3, GY), GC : LINE (GX + 12, GY - 5)-(GX + 14, GY), GC
9608 IF GR = 1 THEN LINE (GX + 8, GY - 16)-(GX + 10, GY - 10), 4, BF : LINE (GX + 8, GY - 18)-(GX + 10, GY - 17), 14, BF : LINE (GX + 7, GY - 19)-(GX + 11, GY - 19), 15 : LINE (GX + 8, GY - 20)-(GX + 10, GY - 20), 15
9610 IF GR = 2 THEN LINE (GX + 6, GY - 14)-(GX + 12, GY - 10), 14, BF : LINE (GX + 6, GY - 12)-(GX + 12, GY - 12), 5
9612 RETURN
9700 REM HUNTER. GD 1 FACES RIGHT, -1 LEFT
9702 C0 = GX + 11 - GD * 2 : LINE (C0 - 2, GY + 5)-(C0 + 2, GY + 6), 15, BF : PSET (C0, GY + 4), 15 : LINE (C0 - 1, GY + 7)-(C0 + 1, GY + 9), 14, BF
9704 LINE (C0 - 3, GY + 10)-(C0 + 3, GY + 18), 4, BF : LINE (C0 - 3, GY + 14)-(C0 + 3, GY + 14), 14
9706 LINE (C0 - 2, GY + 19)-(C0 - 1, GY + 23), 0, BF : LINE (C0 + 1, GY + 19)-(C0 + 2, GY + 23), 0, BF
9708 LINE (C0, GY + 12)-(C0 + GD * 7, GY + 10), 8 : LINE (C0 + GD, GY + 11)-(C0 + GD * 4, GY + 12), 4 : RETURN
9750 REM ANIMAL KD, FACING GD, CELL AT GX,GY
9752 CX = GX + AW(KD) \ 2 : B = GY + AH(KD) - 1 : ON KD GOTO 9755, 9760, 9765, 9770
9755 LINE (CX - 5, B - 5)-(CX + 4, B - 2), 7, BF : LINE (CX + GD * 4, B - 6)-(CX + GD * 7, B - 3), 7, BF : LINE (CX + GD * 5, B - 10)-(CX + GD * 5, B - 6), 7 : LINE (CX + GD * 6, B - 10)-(CX + GD * 6, B - 6), 15
9757 PSET (CX - GD * 6, B - 5), 15 : LINE (CX - 4, B - 1)-(CX + 3, B - 1), 7 : RETURN
9760 LINE (CX - 5, B - 7)-(CX + 4, B - 1), 6, BF : LINE (CX + GD * 4, B - 7)-(CX + GD * 7, B - 3), 6, BF : PSET (CX + GD * 6, B - 6), 0 : LINE (CX - GD * 7, B - 5)-(CX - GD * 5, B - 4), 8, BF : RETURN
9765 LINE (CX - 8, B - 12)-(CX + 6, B - 7), 6, BF : LINE (CX + GD * 5, B - 16)-(CX + GD * 7, B - 10), 6, BF : LINE (CX + GD * 6, B - 18)-(CX + GD * 10, B - 15), 6, BF : LINE (CX + GD * 7, B - 21)-(CX + GD * 7, B - 18), 14
9767 LINE (CX - GD * 9, B - 12)-(CX - GD * 8, B - 9), 15, BF : FOR J = -6 TO 5 STEP 3 : LINE (CX + J, B - 7)-(CX + J, B), 6 : NEXT : RETURN
9770 LINE (CX - 9, B - 14)-(CX + 6, B - 8), 7, BF : LINE (CX - 8, B - 9)-(CX + 5, B - 8), 15 : LINE (CX + GD * 5, B - 17)-(CX + GD * 9, B - 11), 7, BF : CIRCLE (CX + GD * 4, B - 17), 4, 14
9772 FOR J = -7 TO 5 STEP 4 : LINE (CX + J, B - 8)-(CX + J, B), 15 : NEXT : RETURN
9800 LINE (6, 2)-(33, 17), 6, BF : FOR X = 9 TO 30 STEP 4 : LINE (X, 2)-(X, 17), 0 : NEXT : LINE (6, 6)-(33, 6), 14 : LINE (6, 13)-(33, 13), 14
9805 CIRCLE (19, 10), 5, 15 : PAINT (19, 10), 15, 15 : PSET (11, 4), 4 : PSET (28, 15), 14 : PSET (27, 4), 13 : RETURN
9820 CIRCLE (10, 13), 8, 8, , , .7 : PAINT (10, 13), 8, 8 : LINE (6, 11)-(9, 10), 7 : LINE (2, 6)-(17, 6), 15, , &HCCCC : RETURN
9900 REM *** ERRORS ***
9905 IF ERR = 52 OR ERR = 53 OR ERR = 61 OR ERR = 62 OR ERR = 64 OR ERR = 70 OR ERR = 71 OR ERR = 75 OR ERR = 76 THEN FILEOK = 0 : RESUME NEXT
9910 ON ERROR GOTO 0
