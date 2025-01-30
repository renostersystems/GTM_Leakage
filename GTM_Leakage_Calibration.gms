$ONTEXT;
Global Timber Model
Code originally written by B. Sohngen, sohngen.1@osu.edu
Code edited by A. Daigneault, adam.daigneault@maine.edu

Developed for leakage analysis, November 2024

$OFFTEXT;

*Initialize some sets
SETS T            time periods  / 1 * 20/
     A1          age classes of trees  /1 * 15/
     CTRY      regions  /1*16/
     LC1          forest land classes        /1*85/
     AA                        /1*15/
     T1                        /1 * 30/
     TT        set to help with yield  /1*10/
     TS set for soil carbon calculations /1*15/
     DATA number of data parameters /1 * 50/
     YEAR(T)
     YEAR2(T1)
     RSET1(LC1)     accessible regions
     RLAST1(LC1)
     TFIRST(T)    first period
     TLAST(T)     last period
     AFIRST1(A1)  first age
     ALAST1(A1)   last age
     AALAST(AA)
     FINT(T)
;


FINT(T) =YES$(ORD(T) EQ CARD(T));
YEAR(T) = YES$(ORD(T) LT CARD(T));


YEAR2(T1) = YES$(ORD(T1) LT (CARD(T) +1));
TFIRST(T)   = YES$(ORD(T) EQ 1);
TLAST(T)    = YES$(ORD(T) EQ CARD(T));
AFIRST1(A1)  = YES$(ORD(A1) EQ 1) ;
ALAST1(A1)   = YES$(ORD(A1) EQ CARD(A1)) ;
AALAST(AA) = YES$(ORD(AA) EQ CARD(AA));

$ONTEXT;
PARAM2 - PARAMETERS FOR FORESTRY MODEL
data    1       m yield function parameter
data    2       n yield function parameter
data    3       c not used
data    4       max proportion logs per ha harvested
data    5       not used
data    6       not used
data    7       not used
data    8       initial forest stocking density
data    9       elasticity of management intensity
data    10      harvesting cost and transport to mill $/m3
data    11      Faustmann SS rotation age calculated externally
data    12      temperate inaccessible harvesting cost parameter constant "a"
data    13      temperate inaccessible harvesting cost parameter elasticity "b"
data    14      tropical inaccessible harvesting cost parameter constant "a"
data    15      tropical inaccessible harvesting cost parameter elasticity "b"
data    16      rent parameter a constant
data    17      rent parameter b elasticity
data    18      rent parameter Z
data    19      trop initial hectares
data    20      not used
***********************************************************
$OFFTEXT;

TABLE PARAM2(CTRY,LC1,DATA)
$ondelim
$include param2_010722.csv
$offdelim
;

$ONTEXT;
PARAM3 - PARAMETERS FOR FORESTRY MODEL
data    1       fast growing plantation type/yield growth 1=yes
data    2       rental function shift parameter a
data    3       rental function shift parameter b
data    4       timber type quality adjustment factor
data    5       accessible forest type =1
data    6       temperate inaccessible forest type = 1
data    7       tropical inaccessible forest type = 1
data    8       tropical replanted low management intensity type =1
data    9       decadal increase in yield (% per decade) applies only to highly managed plantations
data    10      not used
data    11      not used
data    12      not used
data    13      not used
data    14      initial estimate of timber harvest used for pulp
data    15      not used
data    16     dedicated biomass (1,0)
data    17     dedicated biomass establishment costs
data    18     dedicated biomass transportation distance
data    19     dedicated biomass $/m3/mile
data    20     dedicated biomass pulp substitution quality adjustment factor
$OFFTEXT;


TABLE PARAM3(CTRY,LC1,DATA)
$ondelim
$include param3_010722.csv
$offdelim
;
;

*harvesting cost parameters
TABLE PARAM4(CTRY,LC1,DATA)
$ondelim
$include param4_010722.csv
$offdelim
;

PARAM2('3','6',DATA) = 0;
PARAM3('3','6',DATA) = 0;
PARAM4('3','6',DATA) = 0;


*define for later use
PARAMETER CSA(CTRY,LC1,DATA);
CSA(CTRY,LC1,DATA) = PARAM4(CTRY,LC1,DATA);

*CPARAM
*carbon estimation parameters
*some different parameters, including yield and cost data
*1 = growth parameter 1
*2 = growth parameter 2
*3 = Carbon conversion factor for standing stock (Mg C / m3)
*4=Carbon conversion factor for harvested timber (Mg C/m3)
*5=Steady state carbon storage in soils
*6=Initial soil C (Mg ha-1)
*7=Soil C Growth Rate
*8=Discounted Soil C Addition for new land (Mg ha-1)
*9 = slash decomposition
*10= proportion solidwood
*11= parameter F from Smith et al
*12= parameter G from Smith
*13= parameter H from Smith
*14= D for IPCC GPG
*15= BEF for IPCC GPG
*16= R for IPCC GPG
*17=C % for IPCC GPG
*18=Net IPCC GPG Equation
*19=init emission
*20=pulp turnover
*21 =sawtimber turnover

TABLE CPARAM2(CTRY,LC1,DATA)
$ondelim
$include cparam_010722.csv
$offdelim
;

*******************************************************************************
*sets the number of regions considered in this run - max is lt 17
*******************************************************************************
PARAMETER CTRYIN(CTRY,LC1);
CTRYIN(CTRY,LC1) =1$(ORD(CTRY) LT 17);

DISPLAY CTRYIN;

* Dedicated biofuel plantations in the US
PARAMETER DEDBIO(CTRY,LC1);
DEDBIO(CTRY,LC1) = 1$(PARAM3(CTRY,LC1,'16') EQ 1);

*set dedicated biofuel to 0
DEDBIO(CTRY,LC1) = 0;


*1 if accessible region
PARAMETER R1FOR(CTRY,LC1);
R1FOR(CTRY,LC1) = 1$(PARAM3(CTRY,LC1,'5') EQ 1);
R1FOR(CTRY,LC1)= R1FOR(CTRY,LC1)*CTRYIN(CTRY,LC1);

*1 if temperate inaccessible region
PARAMETER TEMPINAC(CTRY,LC1);
TEMPINAC(CTRY,LC1) = 1$(PARAM3(CTRY,LC1,'6') EQ 1);
TEMPINAC(CTRY,LC1)= TEMPINAC(CTRY,LC1)*CTRYIN(CTRY,LC1);


*1 if tropical inaccessible region
PARAMETER TROPINAC(CTRY,LC1);
TROPINAC(CTRY,LC1) = 1$(PARAM3(CTRY,LC1,'7') EQ 1);
TROPINAC(CTRY,LC1)= TROPINAC(CTRY,LC1)*CTRYIN(CTRY,LC1);


*1 if tropical low quality revegetated region
PARAMETER TROPLOW(CTRY,LC1);
TROPLOW(CTRY,LC1) = 1$(PARAM3(CTRY,LC1,'8') EQ 1);
TROPLOW(CTRY,LC1)= TROPLOW(CTRY,LC1)*CTRYIN(CTRY,LC1);

PARAMETER TROPALL(CTRY,LC1);
TROPALL(CTRY,LC1) = TROPINAC(CTRY,LC1)+TROPLOW(CTRY,LC1);

*this is for parameters
PARAMETER ALLIN(CTRY,LC1);
ALLIN(CTRY,LC1) = R1FOR(CTRY,LC1) + TEMPINAC(CTRY,LC1)+ TROPINAC(CTRY,LC1)+DEDBIO(CTRY,LC1);

*this is for harvest equation, cannot include biomass stuff
PARAMETER ALLIN2(CTRY,LC1);
ALLIN2(CTRY,LC1) = R1FOR(CTRY,LC1) + TEMPINAC(CTRY,LC1)+ TROPINAC(CTRY,LC1);


DISPLAY R1FOR,TEMPINAC,TROPINAC, ALLIN;


*adjusted growth change to reflect effects estimated in Davis et al. (2021)

*Accessible forest initial inventory
TABLE FORINV2(CTRY,LC1,A1)
$ondelim
$include forinv2_010722.csv
$offdelim
;

*inaceessible forest initial inventory
TABLE IFORIN2(CTRY,LC1,A1)
$ondelim
$include iforin2_010722.csv
$offdelim
;

*inaccessible forest types
PARAMETER INACI2(CTRY,LC1,A1);
INACI2(CTRY,LC1,A1) = IFORIN2(CTRY,LC1,A1);

*calculate average age of timber in inaccessible forest types
PARAMETER AVAGEINAC1(CTRY,LC1,A1);
LOOP(A1,AVAGEINAC1(CTRY,LC1,A1) = IFORIN2(CTRY,LC1,A1)*ORD(A1));

DISPLAY AVAGEINAC1;
PARAMETER AVAGEINAC(CTRY,LC1);

PARAMETER SUMIFORIN2(CTRY,LC1);
SUMIFORIN2(CTRY,LC1) =SUM(A1,IFORIN2(CTRY,LC1,A1));

DISPLAY SUMIFORIN2;

*AVAGEINAC(CTRY,LC1)$(TEMPINAC(CTRY,LC1) EQ 1) =
*        SUM(A1,AVAGEINAC1(CTRY,LC1,A1))/SUM(A1,IFORIN2(CTRY,LC1,A1));

*AVAGEINAC(CTRY,LC1) = ROUND(AVAGEINAC(CTRY,LC1))

*DISPLAY AVAGEINAC;

PARAMETER FORLIMIT(CTRY)
/       1       495.5   ,
        2       573.2   ,
        3       634.5   ,
        4       603.3   ,
        5       1056.1  ,
        6       432.4   ,
        7       170.2   ,
        8       89.0    ,
        9       94.7    ,
        10      440.6   ,
        11      593.2   ,
        12      438.0   ,
        13      210.0   ,
        14      33.0    ,
        15      70.4    ,
        16      22.9    /;


SCALARS
EPSILON small value for making derivatives work /1.0E-6/
CONSTFO demand function constant for integration /100/;

*discounting
SCALAR R /.05/;
PARAMETER  RHO(T)  discount factor ;
RHO(T) = (1/(1+R)**(((ORD(T)-1)*10)));

*Decadal discount factor
PARAMETER RHOYR(TT);
RHOYR(TT) = (1/(1+R)**(((ORD(TT)-1))));

PARAMETER DDISC;
DDISC = SUM(TT,RHOYR(TT));

$ONTEXT;
*******************************************************************************
DEMAND
Constant elasticity demand function
Q = A*[(Y/N)^h]*[P^e]
P = (Q/(A*[(Y/N)^h]))^(1/e)
IntQ = {(1/((1/e)+1))/(A*[(Y/N)^h])^(1/e))}*(Q)^((1/e)+1)

Y/N = GDP per capita
h = income elasticity = varies over time
e = price elasticity = -1.05
*******************************************************************************
$OFFTEXT;

PARAMETER POPGR(T)
/1      0.009163973     ,
2       0.007104386     ,
3       0.005126797     ,
4       0.003264293     ,
5       0.001521128     ,
6       0       ,
7       0       ,
8       0       ,
9       0       ,
10      0       ,
11      0       ,
12      0       ,
13      0       ,
14      0       ,
15      0       ,
16      0       ,
17      0       ,
18      0       ,
19      0       ,
20      0       /;

PARAMETER GDPGR(T)
/1      0.031995098     ,
2       0.022624196     ,
3       0.015858229     ,
4       0.012733157     ,
5       0.011829363     ,
6       0.011654103     ,
7       0.01138849      ,
8       0.011254309     ,
9       0.001083612     ,
10      0.001031035     ,
11      0.000957784     ,
12      0.000867033     ,
13      0.000749501     ,
14      0.000614056     ,
15      0.000481528     ,
16      0.000342517     ,
17      0.000187516     ,
18      4.99875E-05     ,
19      0       ,
20      0       /;

*GDPPC is consumption per capita in $/person

PARAMETER GDPPC(T);
GDPPC('1') =6158;
LOOP[T,GDPPC(T+1) = GDPPC(T)*(1+GDPGR(T))**10];

PARAMETER POPGR2(T);
POPGR2('1') = 1;
LOOP[T,POPGR2(T+1) = POPGR2(T)*(1+POPGR(T))**10];

*income elasticity
PARAMETER FINCELAS(T);
FINCELAS('1')=0.85;
LOOP(T,FINCELAS(T+1)=FINCELAS(T)*EXP(0.0001*10));
DISPLAY FINCELAS;


SCALARS
BF demand elasticity /1.1/;

*technical change parameter in timber processing sector
PARAMETER FORTCHG(T);
FORTCHG('1') = 1;
LOOP(T,FORTCHG(T+1) = FORTCHG(T)*(1+.015*EXP(-.013*ORD(T)*10))**(-10));

* US ONLY: USADJUST /0.15/;
*adjust for full market model = 0.5

SCALAR USADJUST adjustment for world demand /0.8/;

USADJUST =0.8;

PARAMETER AF(T);
AF(T) = USADJUST*POPGR2(T)*2300*FORTCHG(T)*(GDPPC(T)**FINCELAS(T));


PARAMETER AFP(T);
AFP(T) = AF(T)*.20;

PARAMETER AFS(T);
AFS(T) = AF(T) - AFP(T);

SCALAR PULPADJUST /1.0/
*0.4 if not using cost functions

DISPLAY GDPPC, FINCELAS,FORTCHG;

DISPLAY AF, AFP;

*****************************************************************
*Parameters for residue harvesting cost function
* cost = ca + cb*RESQ+ cc*(RESQ^2)
* RESQ = residue quantity
*****************************************************************
* original ca=0; cb=30; cc=0.05;
scalars
         ca /0/
         cb /30/
         cc /.05/
;
*****************************************************************

$ONTEXT;
This section calculates shifts in the rental functions to account for exogenous changes in demand for alternative uses of land
$OFFTEXT;

PARAMETER RNTSHFT(CTRY,LC1,T);
RNTSHFT(CTRY,LC1,'1') = 1;
LOOP[T, RNTSHFT(CTRY,LC1,T+1)=
        {RNTSHFT(CTRY,LC1,T)*(1+PARAM3(CTRY,LC1,'2')*
                ((1-PARAM3(CTRY,LC1,'3'))**{ORD(T)-1}))}$(PARAM3(CTRY,LC1,'2') NE 0)+

        RNTSHFT(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'2') EQ 0)];

DISPLAY RNTSHFT;

PARAMETER RENTA(CTRY,LC1,T);
RENTA(CTRY,LC1,T) =
        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(R1FOR(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(DEDBIO(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')$(TROPINAC(CTRY,LC1) EQ 1);

PARAMETER RENTB(CTRY,LC1);
RENTB(CTRY,LC1)=PARAM2(CTRY,LC1,'17');

SCALAR GRENTB /0.3/;
GRENTB = RENTB('1','1');

PARAMETER RENTAF(CTRY,LC1);
RENTAF(CTRY,LC1) = SUM[T$(FINT(T)),RENTA(CTRY,LC1,T)$(FINT(T))];

PARAMETER RENTZ(CTRY,LC1,T);
RENTZ(CTRY,LC1,T) = PARAM2(CTRY,LC1,'18')*(1/RNTSHFT(CTRY,LC1,T));

PARAMETER RENTHA(CTRY,LC1,T);
RENTHA(CTRY,LC1,T) =
{[RENTZ(CTRY,LC1,T)/RENTA(CTRY,LC1,T)]**RENTB(CTRY,LC1)}$(TROPINAC(CTRY,LC1) EQ 1);

DISPLAY RENTA,RENTZ,RENTHA;


$ONTEXT;
FINPTEL adjusts parameter that affects the elasticity of management inputs in forestry to account for technology change.  Currently assume 0.3% per decade growth in elasticity
$OFFTEXT;

PARAMETER FINPTEL(CTRY,LC1,T);
FINPTEL(CTRY,LC1,'1')$(R1FOR(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(R1FOR(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

FINPTEL(CTRY,LC1,'1')$(DEDBIO(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(DEDBIO(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

DISPLAY FINPTEL;

PARAMETER FINPTELF(CTRY,LC1);
FINPTELF(CTRY,LC1) = SUM[T$(FINT(T)),FINPTEL(CTRY,LC1,T)$(FINT(T))];

DISPLAY FINPTELF;


*adjusted growth change to reflect effects estimated in Davis et al. (2021)

PARAMETER CHG1(CTRY,LC1,T,DATA);

CHG1(CTRY,LC1,T,DATA)=0;

CHG1(CTRY,LC1,'1','1')=0.072;
*adjust down for Russia and Canada
CHG1('4',LC1,'1','1')=0.035;
CHG1('5',LC1,'1','1')=0.035;


LOOP(T,CHG1(CTRY,LC1,T+1,'1') = CHG1(CTRY,LC1,T,'1')+
CHG1(CTRY,LC1,'1','1')*(EXP(-.15*(ORD(T)))));

*CHG1(CTRY,LC1,'1','1')$(ORD(T) LT 5)

*Generate forest yield functions
* GINIT = decadal forest growth
* note that these include adjustments to forest growth to account for climate change through CHG1, but
* those parameters are set to 0 in the baseline.
PARAMETER GINIT1(CTRY,LC1,A1,T);
GINIT1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*

                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*Also decadal growth
PARAMETER GROWTH1(CTRY,LC1,A1,T);
GROWTH1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*
                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+
                                ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*initial age class growth in each time period
PARAMETER YINIT1(CTRY,LC1,A1,T);
YINIT1(CTRY,LC1,'1',T) = GINIT1(CTRY,LC1,'1',T);
LOOP(A1,YINIT1(CTRY,LC1,A1+1,T) = YINIT1(CTRY,LC1,A1,T) + GINIT1(CTRY,LC1,A1+1,T));

DISPLAY GINIT1,YINIT1;

*YIELD2 is growth function, summed over decadal growth
PARAMETER YIELD2(CTRY,LC1,A1,T) yield function;

YIELD2(CTRY,LC1,A1,T) = YINIT1(CTRY,LC1,A1,T)$TFIRST(T);
YIELD2(CTRY,LC1,A1,T)$AFIRST1(A1) = GROWTH1(CTRY,LC1,A1,T)$AFIRST1(A1);
LOOP(T,LOOP(A1,YIELD2(CTRY,LC1,A1+1,T+1)=YIELD2(CTRY,LC1,A1,T)+
        GROWTH1(CTRY,LC1,A1+1,T+1)));

*create YIELDORIG(CTRY,LC1,A1,T) which is used later for carbon calculations
* Use YIELD2 divided by quality adjustment parameter
PARAMETER YIELDORIG(CTRY,LC1,A1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

*Quality adjustment  accounts for value differences across logs from different regions.
YIELD2(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T)*PARAM3(CTRY,LC1,'4');


DISPLAY YIELD2;

*Add in underlying productivity changes in yields for productive species
*original method of shifting yields
*these are 6% per decade for many plantation types
PARAMETER YDGRTH(CTRY,LC1,T);
YDGRTH(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH(CTRY,LC1,T+1) = YDGRTH(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)*
       (.99**[(ORD(T)-1)*10]))$(PARAM3(CTRY,LC1,'1') EQ 1)+
(PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'1') EQ 0)
);

PARAMETER YDGRTH2(CTRY,LC1,T);
YDGRTH2(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH2(CTRY,LC1,T+1) = YDGRTH2(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH2(CTRY,LC1,T)*(.99**[(ORD(T)-1)*10])));


YIELD2(CTRY,LC1,A1,T)= YIELD2(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELDORIG(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);

DISPLAY YDGRTH, YIELD2;


*Technology change adjustment for merchantable timber out of biomass stock
*Not included in this version; assumed to be 0
PARAMETER TSWCHG(CTRY,LC1);
TSWCHG(CTRY,LC1) = 0;

PARAMETER MXSWTM(CTRY,LC1,T);
MXSWTM(CTRY,LC1,'1')$(ALLIN(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'4')$(ALLIN(CTRY,LC1) EQ 1);
LOOP[T,MXSWTM(CTRY,LC1,T+1) $(ALLIN(CTRY,LC1) EQ 1) =
        MXSWTM(CTRY,LC1,T)*(1+ TSWCHG(CTRY,LC1))];


$ONTEXT;
 The following routines adjust the yield function to account for the merchantable proportion of stock
 on each hectare.
The final result below takes the original yield function from above and multiplies by a factor that adjusts the biomass on site for the proportion that is merchantable, depending on the age class.

YIELD2 = YIELD2*SWPERC2A

$OFFTEXT;

PARAMETER SWGRTH(CTRY,LC1);
SWGRTH(CTRY,LC1) =2.0$(PARAM2(CTRY,LC1,'11') EQ 1)+
1.0$( PARAM2(CTRY,LC1,'11') EQ 2)+
0.9$( PARAM2(CTRY,LC1,'11') EQ 3)+
0.6$( PARAM2(CTRY,LC1,'11') EQ 4)+
0.5$( PARAM2(CTRY,LC1,'11') GT 4);


PARAMETER SWPERC2A(CTRY,LC1,A1,T);
SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=

{MXSWTM(CTRY,LC1,T)*[1-EXP((-0.4/(PARAM2(CTRY,LC1,'11')*10-ORD(A1)*10+10))*
(ORD(A1)*10))]**2}$(ORD(A1) LT PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*AGETR age to start counting sawtimber quantity
PARAMETER AGETR(CTRY,LC1);
AGETR(CTRY,LC1) = PARAM2(CTRY,LC1,'6');

*SWPC2A shifts SWPERC2A up by the number of decades in AGETR.
PARAMETER SWPC2A(CTRY,LC1,A1,T);
LOOP[A1,SWPC2A(CTRY,LC1,A1,T) = 0$(ORD(A1) LT AGETR(CTRY,LC1)) +
       0$(ORD(A1) EQ AGETR(CTRY,LC1))+
       SWPERC2A(CTRY,LC1,A1-AGETR(CTRY,LC1),T)$(ORD(A1) GT AGETR(CTRY,LC1))];

DISPLAY SWPC2A;

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=SWPC2A(CTRY,LC1,A1,T);

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = MIN[SWPERC2A(CTRY,LC1,A1,T),10];

YIELD2(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=YIELD2(CTRY,LC1,A1,T)*SWPERC2A(CTRY,LC1,A1,T);

DISPLAY SWPERC2A, YIELD2;

PARAMETER YIELD2F(CTRY,LC1,A1);
YIELD2F(CTRY,LC1,A1)=SUM[T$(FINT(T)),YIELD2(CTRY,LC1,A1,T)$(FINT(T))];

*create inaccessible yield functions  already adjusted for merch proportion
PARAMETER YLDINAC(CTRY,LC1,A1,T);
YLDINAC(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

execute_unload "GLOBALTIMBERMODEL_01_2022.gdx"

*Estimate terminal values
SCALAR PTERM terminal potential timber price /130/;
SCALAR MANT max management $perha /10000/;

*a discount factor
PARAMETER DELTA1(CTRY,LC1);
DELTA1(CTRY,LC1) = 1/[(1-EXP(-R*PARAM2(CTRY,LC1,'11')*10))$(ALLIN(CTRY,LC1) EQ 1) +
                                1$(ALLIN(CTRY,LC1) EQ 0)];

*Estimate terminal management values
PARAMETER MNG1(CTRY,LC1);
MNG1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
SUM(A1,{[{[(1/(1+R))**(-PARAM2(CTRY,LC1,'11')*10)]*

(1/((PTERM - PARAM2(CTRY,LC1,'10')$(ALLIN(CTRY,LC1) EQ 1))*
PARAM2(CTRY,LC1,'8')$(ALLIN(CTRY,LC1) EQ 1)*FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)*
        YIELD2F(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)+EPSILON))}**(1/( FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1))]
-1}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

MNG1(CTRY,LC1) = MAX[MNG1(CTRY,LC1),0];

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[MNG1(CTRY,LC1),MANT];

DISPLAY MNG1, MNG1A;


*alternate calculation of MNG1/A
PARAMETER ZIM1(CTRY,LC1);
ZIM1(CTRY,LC1)=0;
LOOP(CTRY,
LOOP[LC1$(ALLIN(CTRY,LC1) EQ 1),
WHILE(

SUM{A1,[(1+R)**(-10*ORD(A1))]*(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
        (ZIM1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))}


GT 1,

ZIM1(CTRY,LC1)= ZIM1(CTRY,LC1)+1);
]
)
;

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[ZIM1(CTRY,LC1),MANT];
MNG1(CTRY,LC1) = MNG1A(CTRY,LC1);

*determine rotation age and net present values

SETS
        AC1      age of trees for carbon calculation /1*15/;

PARAMETER NC1(CTRY,LC1,A1);
NC1(CTRY,LC1,A1)=0;
PARAMETER NPVCS1(CTRY,LC1,AC1);
NPVCS1(CTRY,LC1,AC1)=0;

PARAMETER NPVSS1(CTRY,LC1,A1);
NPVSS1(CTRY,LC1,A1) =
{(PTERM - PARAM2(CTRY,LC1,'10'))*
        {(PARAM2(CTRY,LC1,'8')*(MNG1A(CTRY,LC1)+1+EPSILON)** FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)*((1+R)**(-ORD(A1)*10))}+
        SUM(AC1,NPVCS1(CTRY,LC1,AC1)$(ORD(AC1) EQ ORD(A1)))
        - MNG1A(CTRY,LC1)}/{1-((1+R)**(-ORD(A1)*10))};

DISPLAY NPVSS1;

PARAMETER NPVT1;

PARAMETER NPVT2

PARAMETER TMAGE1(CTRY,LC1);
TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = 1;

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
LOOP(A1, NPVT1=NPVSS1(CTRY,LC1,A1);
        NPVT2 = NPVSS1(CTRY,LC1,A1+1);


IF (NPVT1<NPVT2, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSEIF (NPVT1=NPVT2), TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1));
        );
IF (NPVT1 <0, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) ;
        );
        );
      );

DISPLAY TMAGE1;
PARAM2(CTRY,LC1,'11')$(ALLIN(CTRY,LC1) EQ 1)=TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1);


*Determine SS area of accessible forests
*calculate decadal rental value
PARAMETER PVADDA1(CTRY,LC1);
PVADDA1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]-
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]/(1+R);

PARAMETER TFINAC1(CTRY,LC1);
TFINAC1(CTRY,LC1)$(R1FOR(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

TFINAC1(CTRY,LC1)$(TROPINAC(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

DISPLAY PVADDA1,TFINAC1;

TFINAC1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TFINAC1(CTRY,LC1)/PARAM2(CTRY,LC1,'11');

PARAMETER FINAC1(CTRY,LC1,A1);
FINAC1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        TFINAC1(CTRY,LC1)$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1));

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
       IF((PARAM2(CTRY,LC1,'11')) = 15,
       LOOP[A1, FINAC1(CTRY,LC1,A1) = 0$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')))+
       TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11')$(ORD(A1) EQ (PARAM2(CTRY,LC1,'11')))];
        ELSE LOOP(A1,
       IF (ORD(A1)< (PARAM2(CTRY,LC1,'11')+1),
                FINAC1(CTRY,LC1,A1) = TFINAC1(CTRY,LC1);
                ELSE FINAC1(CTRY,LC1,A1) =0;
       ););
        );
);
);

TFINAC1(CTRY,LC1)=TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11');

DISPLAY TFINAC1,FINAC1;

*Estimate Terminal Conditions
PARAMETER ALPHAK1(CTRY,LC1,A1);

ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);

PARAMETER ALPHA1(CTRY,LC1);
ALPHA1(CTRY,LC1)=SUM(A1,ALPHAK1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

DISPLAY ALPHAK1,ALPHA1;

PARAMETER ALPHAK1(CTRY,LC1,A1);
ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);


PARAMETER BETA1(CTRY,LC1);
BETA1(CTRY,LC1) = SUM(A1, [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));
DISPLAY BETA1;

BETA1(CTRY,LC1) =0;
LOOP{A1,

BETA1(CTRY,LC1) = BETA1(CTRY,LC1)+
        [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))
};


DISPLAY MNG1,BETA1;

*LAMBDA1 is actual terminal condition in $/ha for each age class
PARAMETER LAMBDA1(CTRY,LC1,A1);
LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) = {[(1/(1+R))**([PARAM2(CTRY,LC1,'11') - ORD(A1)]*10)]*
        DELTA1(CTRY,LC1)*ALPHA1(CTRY,LC1)}$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1)) +
       {(DELTA1(CTRY,LC1)-1)*ALPHA1(CTRY,LC1) + ALPHAK1(CTRY,LC1,A1)}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)=
LAMBDA1(CTRY,LC1,A1)$(ORD(A1) LT PARAM2(CTRY,LC1,'11')+1)+
0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*PSI1 is actual terminal condition for $ spent on management
PARAMETER PSI1(CTRY,LC1,A1);
PSI1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        {[(1/(1+R))**([PARAM2(CTRY,LC1,'11')-ORD(A1)]*10)]*BETA1(CTRY,LC1)}$(ORD(A1)
       LT (PARAM2(CTRY,LC1,'11')+1)) + 0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));


DISPLAY LAMBDA1,PSI1;

*adjust initial forest management
PARAMETER MTFIN1(CTRY,LC1,A1);
MTFIN1(CTRY,LC1,A1) = MNG1(CTRY,LC1);

PARAMETER MTINIT(CTRY,LC1,A1);
MTINIT(CTRY,LC1,A1) = MTFIN1(CTRY,LC1,A1)/2.5;

MTINIT('2',LC1,A1) = MTFIN1('2',LC1,A1)/3;

*adjust south inventories in US
MTINIT('1','1',A1) = MTFIN1('1','1',A1)/5;
MTINIT('1','4',A1) = MTFIN1('1','4',A1)/5;
MTINIT('1','26',A1) = MTFIN1('1','26',A1)/8.5;
MTINIT('1','27',A1) = MTFIN1('1','27',A1)/8.5;
MTINIT('1','28',A1) = MTFIN1('1','28',A1)/8.5;
MTINIT('1','29',A1) = MTFIN1('1','29',A1)/8.5;
MTINIT('1','30',A1) = MTFIN1('1','30',A1)/8.5;
MTINIT('1','31',A1) = MTFIN1('1','31',A1)/8.5;
MTINIT('1','32',A1) = MTFIN1('1','32',A1)/8.5;

$ONTEXT;

MODEL VARIABLES AND EQUATIONS

$OFFTEXT;

VARIABLES
                NPVFOR1;

POSITIVE VARIABLES
          PROPPULP(CTRY,LC1,T)
          PULPQ(T)
          SAWQ(T)
                CS(T)
          MC(T)
          MCOSTS(CTRY,LC1,T)
          MCOSTP(CTRY,LC1,T)
          RESCOST(CTRY,LC1,T)
          DEDBIOQUANT(CTRY,LC1,T)
          DEDBIOCOST(CTRY,LC1,T)
          PLANTC(T)
          RENTC(T)
          TC
                YACRE2(CTRY,LC1,A1,T)
                YACRE3(CTRY,LC1,A1,T) low quality types in tropics
                ACHR2(CTRY,LC1,A1,T)
                ACHR3(CTRY,LC1,A1,T)
                ACPL2(CTRY,LC1,T)
                MGMT1(CTRY,LC1,A1,T)  management intensity variable
                IMGMT1(CTRY,LC1,T) initial management intensity variable age class one only
                ACPL3(CTRY,LC1,T) replanting of TEMPERATE semi-accessible forests
                ACPL4(CTRY,LC1,T) replanting of tropical inaccessible into semi-accessible
                ACPL5(CTRY,LC1,T) replanting of tropical semi-accessible into tropical semi-accessible
                ACPL6(CTRY,LC1,T) planting of new tropical semi-accessible forests.

          NEWACPLBIO(CTRY,LC1,T)  brand new hectares planted to dedicated biofuel
          ACPLBIO(CTRY,LC1,T)  replanted hectares in biofuel

                YACRIN1(CTRY,LC1,A1,T) area of inaccessible forestland
                ACHRIN1(CTRY,LC1,A1,T) area of inaccessible forestland harvested
                CHQ1(CTRY,LC1,T)  cumulative hectares harvested in inaccessible regions
                CNAC1(CTRY,LC1,T)
         TOTALFOREST(T)
*******************************************************************************
* New Biomass Based Variables
*******************************************************************************
                BIOTIMBS(CTRY,LC1,A1,T) biomass timber
                BIOTIMBP(CTRY,LC1,A1,T) biomass timber
                PROPBIOS(CTRY,LC1,T) proportion of sawtimber harvest converted to biomass
                PROPBIOP(CTRY,LC1,T) proportion of pulpwood harvest converted to biomass
          RES(CTRY,LC1,A1,T) amount of residue harvested from sites
******************************************************************************
;

EQUATIONS
          COSTS2(T)
          PULPQUANT(T)
          SAWQUANT(T)
          CONSUMER(T)
          COSTS(CTRY,LC1,T)
          RENT(T)
          PLANT(T)
          COSTP(CTRY,LC1,T)
          RCOST(CTRY,LC1,T)
          TERMINAL
          BENFORX
                MOTION11(CTRY,LC1,A1,T)  equation of motion to move stock to new year
                MOTSIN11(CTRY,LC1,A1,T)       equation of motion for TEMPERATE semi-accessible timberland
                MOTIN11(CTRY,LC1,A1,T)         equation of motion for TEMPERATE inaccessible timberland
                MOTRPSIN1(CTRY,LC1,A1,T) equation of motion for semi-accessible timberland in tropical  zone
                MOTRPSIN2(CTRY,LC1,A1,T) equation of motion to move stock to new year for low quality types in trop
                MOTRPIN1(CTRY,LC1,A1,T) equation of motion for inaccessible timberland in tropical zone
                MOTION21(CTRY, LC1, A1,T)  equation of motion for management intensity var
                MOTION11BIO(CTRY,LC1,A1,T)
          MOTION21BIO(CTRY,LC1,A1,T)
          REPDEDBIO(CTRY,LC1,T) replanting dedicated biofuel plantations
          REPSLIN1(CTRY,LC1,T)  replanting for temperate semi-accessible timberland
                REPSLIN2(CTRY,LC1,T)  replanting for tropical semi-accessible timberland
                REPSLIN3(CTRY,LC1,T)  replanting for tropical semi-accessible timberland
                MAXFOR(CTRY,LC1,T) setting maximum forest area by type
          MAXFORCTRY(CTRY,T) setting max forest area by region
                HARVEST1(CTRY,LC1,A1,T)  harvest by age class
                HARVSIN1(CTRY,LC1,A1,T)  harvest from semi-accessible region
                HARVIN1(CTRY,LC1,A1,T)  harvest from inaccessible region
                HARVSIN2(CTRY,LC1,A1,T)  harvest from semi-accessible region
                HARVIN2(CTRY,LC1,A1,T)  harvest from inaccessible region
                HARVEST1BIO(CTRY,LC1,A1,T)
          DEDBIOEQ(CTRY,LC1,T)
          DEDBIOCOSTEQ(CTRY,LC1,T)
          CUMAC1(CTRY,LC1,T)  eqn for cumulative ha harvested from inac region in temperate
                CUMAC2(CTRY,LC1,T)  eqn for cumulative ha harvested from inac region in tropics
                TCHARV1(CTRY,LC1,A1,T)
                TCHARV2(CTRY,LC1,A1,T)
                CUNAC1(CTRY,LC1,T)
                BENFOR1
                BENEFC
                MAXPLT2(CTRY,LC1,T)
                MAXPLT3(CTRY,LC1,T)
          TFORESTAREA(T) equation for total forest area
;
*******************************************************************************
* equation for total forest area

TFORESTAREA(T).. TOTALFOREST(T)=E=
        SUM(CTRY,SUM(LC1,SUM(A1,
        YACRE2(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)+
         YACRE2(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRE2(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRE2(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1)+
         YACRE3(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRIN1(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRIN1(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1))

));

*equation of motion for accessible timberland
MOTION11(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)..
YACRE2(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1) =E= YACRE2(CTRY,LC1,A1-1,T-1) - ACHR2(CTRY,LC1,A1-1,T-1) +
ACPL2(CTRY,LC1,T-1)$AFIRST1(A1) +
FORINV2(CTRY,LC1,A1)$TFIRST(T) +
YACRE2(CTRY,LC1,A1,T-1)$ALAST1(A1) - ACHR2(CTRY,LC1,A1,T-1)$ALAST1(A1);

*equation of motion for management on accessible forests
MOTION21(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)..
MGMT1(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1) =E= MGMT1(CTRY,LC1,A1-1,T-1) +
IMGMT1(CTRY,LC1,T-1)$AFIRST1(A1) + MTINIT(CTRY,LC1,A1)$TFIRST(T);

*equation of motion for dedicated biofuel plantations
MOTION11BIO(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1)..
YACRE2(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1) =E= YACRE2(CTRY,LC1,A1-1,T-1) - ACHR2(CTRY,LC1,A1-1,T-1) +
NEWACPLBIO(CTRY,LC1,T-1)$AFIRST1(A1) +
ACPLBIO(CTRY,LC1,T-1)$AFIRST1(A1) +
FORINV2(CTRY,LC1,A1)$TFIRST(T) +
YACRE2(CTRY,LC1,A1,T-1)$ALAST1(A1) - ACHR2(CTRY,LC1,A1,T-1)$ALAST1(A1);

*equation of motion for management of dedicated biofuel plantations
MOTION21BIO(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1)..
MGMT1(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1) =E= MGMT1(CTRY,LC1,A1-1,T-1) +
IMGMT1(CTRY,LC1,T-1)$AFIRST1(A1) + MTINIT(CTRY,LC1,A1)$TFIRST(T);


*equation of motion for TEMPERATE semi-accessible timberland
MOTSIN11(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)..
YACRE2(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1) =E= YACRE2(CTRY,LC1,A1-1,T-1)-ACHR2(CTRY,LC1,A1-1,T-1) +
0$TFIRST(T) +ACPL3(CTRY,LC1,T-1)$AFIRST1(A1) +
YACRE2(CTRY,LC1,A1,T-1)$ALAST1(A1)-ACHR2(CTRY,LC1,A1,T-1)$ALAST1(A1);

*equation of motion for TEMPERATE inaccessible timberland
MOTIN11(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)..
YACRIN1(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)  =E=
        YACRIN1(CTRY,LC1,A1-1,T-1) -
        ACHRIN1(CTRY,LC1,A1-1,T-1)+INACI2(CTRY,LC1,A1)$TFIRST(T)+
YACRIN1(CTRY,LC1,A1,T-1)$ALAST1(A1)- ACHRIN1(CTRY,LC1,A1,T-1)$ALAST1(A1)
;

*equation of motion for TROPICAL semi-accessible timberland
*YACRE2 for tropical holds the higher value tropical forest types
MOTRPSIN1(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)..
YACRE2(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1) =E= YACRE2(CTRY,LC1,A1-1,T-1)-ACHR2(CTRY,LC1,A1-1,T-1) +
0$TFIRST(T)+ ACPL6(CTRY,LC1,T-1)$AFIRST1(A1)+
YACRE2(CTRY,LC1,A1,T-1)$ALAST1(A1)-ACHR2(CTRY,LC1,A1,T-1)$ALAST1(A1);

*YACRE3 for tropical holds the lower value replanted-regenerated forests.
MOTRPSIN2(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)..
YACRE3(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1) =E= YACRE3(CTRY,LC1,A1-1,T-1)- ACHR3(CTRY,LC1,A1-1,T-1) +
ACPL5(CTRY,LC1,T-1)$AFIRST1(A1)+
YACRE3(CTRY,LC1,A1,T-1)$ALAST1(A1)-ACHR3(CTRY,LC1,A1,T-1)$ALAST1(A1);

*equation of motion for TROPICAL inaccessible timberland
MOTRPIN1(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)..
YACRIN1(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)  =E=
        YACRIN1(CTRY,LC1,A1-1,T-1) -
        ACHRIN1(CTRY,LC1,A1-1,T-1)+INACI2(CTRY,LC1,A1)$TFIRST(T)+
YACRIN1(CTRY,LC1,A1,T-1)$ALAST1(A1)- ACHRIN1(CTRY,LC1,A1,T-1)$ALAST1(A1);

*replanting for TEMPERATE semi-accessible timberland
REPSLIN1(CTRY,LC1,T)$(TEMPINAC(CTRY,LC1) EQ 1)..
ACPL3(CTRY,LC1,T) $(TEMPINAC(CTRY,LC1) EQ 1) =E=
        SUM(A1,ACHRIN1(CTRY,LC1,A1,T)) + SUM(A1,ACHR2(CTRY,LC1,A1,T));

*replanting dedicated biofuel plantations
REPDEDBIO(CTRY,LC1,T)$(DEDBIO(CTRY,LC1) EQ 1)..
ACPLBIO(CTRY,LC1,T) =L= SUM(A1, ACHR2(CTRY,LC1,A1,T));

*MAXFOR sets the maximum forest area
*set to a high level so it is not constraining, but can be adjusted with exogenous information.
PARAMETER MXFORA;
MXFORA=10;

MAXFOR(CTRY,LC1,T)$(R1FOR(CTRY,LC1) EQ 1)..
SUM(A1,YACRE2(CTRY,LC1,A1,T))=L= SUM(A1,FORINV2(CTRY,LC1,A1))* MXFORA;

MAXFORCTRY(CTRY,T)..
SUM(LC1$(R1FOR(CTRY,LC1) EQ 1),SUM(A1,YACRE2(CTRY,LC1,A1,T)))+
SUM(LC1$(TEMPINAC(CTRY,LC1) EQ 1),SUM(A1,YACRE2(CTRY,LC1,A1,T)))+
SUM(LC1$(TROPINAC(CTRY,LC1) EQ 1),SUM(A1,YACRE2(CTRY,LC1,A1,T)))+
SUM(LC1$(TROPINAC(CTRY,LC1) EQ 1),SUM(A1,YACRE3(CTRY,LC1,A1,T)))+
SUM(LC1$(TEMPINAC(CTRY,LC1) EQ 1),SUM(A1,YACRIN1(CTRY,LC1,A1,T)))+
SUM(LC1$(TROPINAC(CTRY,LC1) EQ 1),SUM(A1,YACRIN1(CTRY,LC1,A1,T)))
        =L= FORLIMIT(CTRY);



*harvesting constraint, harvest must be less than total hectares available.
HARVEST1(CTRY,LC1,A1,T)$(ALLIN2(CTRY,LC1) EQ 1)..
ACHR2(CTRY,LC1,A1,T)$(ALLIN2(CTRY,LC1) EQ 1) =L= YACRE2(CTRY,LC1,A1,T);

HARVEST1BIO(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1)..
ACHR2(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1) =L= YACRE2(CTRY,LC1,A1,T);

*harvest constraint for inaccessible and semi-accessible timberland
HARVSIN1(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)..
ACHR2(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1) =L= YACRE2(CTRY,LC1,A1,T);

HARVIN1(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)..
ACHRIN1(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1) =L= YACRIN1(CTRY,LC1,A1,T);

HARVSIN2(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)..
ACHR2(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1) =L= YACRE2(CTRY,LC1,A1,T);

HARVIN2(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)..
ACHRIN1(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1) =L= YACRIN1(CTRY,LC1,A1,T);

*cumulative harvests in temperate zone inaccessible forests
CUMAC1(CTRY,LC1,T)$(TEMPINAC(CTRY,LC1) EQ 1)..
CHQ1(CTRY,LC1,T)$(TEMPINAC(CTRY,LC1) EQ 1) =E= CHQ1(CTRY,LC1,T-1)+ SUM(A1,ACHRIN1(CTRY,LC1,A1,T));

*harvest all hectares in last period to impose terminal condition.
TCHARV1(CTRY,LC1,A1,T)$TLAST(T)..
ACHR2(CTRY,LC1,A1,T) =E=
        YACRE2(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1);

TCHARV2(CTRY,LC1,A1,T)$TLAST(T)..
ACHR3(CTRY,LC1,A1,T) =E=
        YACRE3(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1);

*Calculating Net Surplus for the forestry only scenario
BENFOR1.. NPVFOR1 =E= SUM(T$YEAR(T),RHO(T)*[

*benefit from sawtimber production
[AFS(T)**(1/BF)]*[1/((-1/BF)+1)]*

{( SUM(CTRY,

*accessible timber - with proportion going to Biomass
SUM[LC1$(R1FOR(CTRY,LC1) EQ 1),
SUM(A1,
(1-PROPPULP(CTRY,LC1,T)+EPSILON)*
(ACHR2(CTRY,LC1,A1,T)+EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))]+

* Temperate semi-inaccessible
SUM[LC1$(TEMPINAC(CTRY,LC1) EQ 1),

SUM(A1, (1-PROPPULP(CTRY,LC1,T) +EPSILON)*
(ACHR2(CTRY,LC1,A1,T)+EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))]+
*******************************************************************************
*temperate inaccessible
* use merchantable yield functions less management effects.
SUM[LC1$(TEMPINAC(CTRY,LC1) EQ 1),
        (1-PROPPULP(CTRY,LC1,T) +EPSILON)*PARAM2(CTRY,LC1,'8')*
       SUM(A1,(ACHRIN1(CTRY,LC1,A1,T) +EPSILON)*
       YLDINAC(CTRY,LC1,A1,T))]+

*tropical semi-inaccessible
SUM[LC1$(TROPINAC(CTRY,LC1) EQ 1),
        SUM(A1, (1-PROPPULP(CTRY,LC1,T) +EPSILON)*
(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))]+

*tropical low harvest
SUM[LC1$(TROPINAC(CTRY,LC1) EQ 1),
        SUM(A1, (1-PROPPULP(CTRY,LC1,T) +EPSILON)*
(ACHR3(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*0.5*PARAM2(CTRY,LC1,'8'))]+

*tropical inacessible  harvest
SUM[LC1$(TROPINAC(CTRY,LC1) EQ 1),
        (1-PROPPULP(CTRY,LC1,T) +EPSILON)*PARAM2(CTRY,LC1,'8')*
SUM(A1,(ACHRIN1(CTRY,LC1,A1,T) +EPSILON)*YLDINAC(CTRY,LC1,A1,T))]+

EPSILON) + EPSILON)**((-1/BF)+1)}$YEAR(T)

-[AFS(T)**(1/BF)]*[1/((-1/BF)+1)]*{CONSTFO**((-1/BF)+1)}$YEAR(T)

+

*benefit from pulpwood production
[AFP(T)**(1/BF)]*[1/((-1/BF)+1)]*

{( SUM(CTRY,


*accessible timber - with proportion going to Biomass
SUM[LC1$(R1FOR(CTRY,LC1) EQ 1),
SUM(A1, (PROPPULP(CTRY,LC1 ,T) +EPSILON)*
(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))]+

*dedicated fastgrowing plantations - with proportion going to Biomass
SUM[LC1$(DEDBIO(CTRY,LC1) EQ 1),
 PARAM3(CTRY,LC1,'20')*{SUM(A1,((ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T))$(DEDBIO(CTRY,LC1) EQ 1)))}]


+

* Temperate semi-inaccessible
SUM[LC1$(TEMPINAC(CTRY,LC1) EQ 1),

SUM(A1, (PROPPULP(CTRY,LC1 ,T) +EPSILON)*
(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))]+
*******************************************************************************
*temperate inaccessible
* use merchantable yield functions less management effects.
SUM[LC1$(TEMPINAC(CTRY,LC1) EQ 1),
        (PROPPULP(CTRY,LC1 ,T) +EPSILON)*
        PARAM2(CTRY,LC1,'8')*SUM(A1,(ACHRIN1(CTRY,LC1,A1,T) +EPSILON)*
       YLDINAC(CTRY,LC1,A1,T))]

+

*tropical semi-inaccessible
SUM[LC1$(TROPINAC(CTRY,LC1) EQ 1),
        SUM(A1, (PROPPULP(CTRY,LC1 ,T) +EPSILON)*
(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))]+

*tropical low harvest
SUM[LC1$(TROPINAC(CTRY,LC1) EQ 1),
        SUM(A1, (PROPPULP(CTRY,LC1 ,T) +EPSILON)*
        (ACHR3(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*0.5*PARAM2(CTRY,LC1,'8'))]+

*tropical inacessible  harvest
SUM[LC1$(TROPINAC(CTRY,LC1) EQ 1),
        (PROPPULP(CTRY,LC1 ,T) +EPSILON)*PARAM2(CTRY,LC1,'8')*
       SUM(A1,(ACHRIN1(CTRY,LC1,A1,T) +EPSILON)*YLDINAC(CTRY,LC1,A1,T))]+

EPSILON) + EPSILON)**((-1/BF)+1)}$YEAR(T)

-[AFP(T)**(1/BF)]*[1/((-1/BF)+1)]*{CONSTFO**((-1/BF)+1)}$YEAR(T)

*costs of sawtimber production on accessible lands
-(
SUM(CTRY,SUM(LC1,

(1-PROPPULP(CTRY,LC1,T) +EPSILON)*
CSA(CTRY,LC1,'1')*SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON )*YIELD2(CTRY,LC1,A1,T)*
PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(R1FOR(CTRY,LC1) EQ 1)

+

[
{(1-PROPPULP(CTRY,LC1,T) +EPSILON)*SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*
PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))+EPSILON}** CSA(CTRY,LC1,'2')]$(R1FOR(CTRY,LC1) EQ 1)

*cost of sawtimber production on temperate semi-accessible lands
+
(1-PROPPULP(CTRY,LC1,T) +EPSILON)*
CSA(CTRY,LC1,'3')*SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*
     PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(TEMPINAC(CTRY,LC1) EQ 1)

+
[{(1-PROPPULP(CTRY,LC1,T) +EPSILON)*SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*
     PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))+EPSILON}** CSA(CTRY,LC1,'4')]$(TEMPINAC(CTRY,LC1) EQ 1)

*cost of sawtimber production on tropical semi-accessible lands
+
(1-PROPPULP(CTRY,LC1,T) +EPSILON)*
CSA(CTRY,LC1,'3')*SUM(A1,[ACHR2(CTRY,LC1,A1,T) +EPSILON]*
        YIELD2(CTRY,LC1,A1,T)*
        PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(TROPINAC(CTRY,LC1) EQ 1)

+

[
{(1-PROPPULP(CTRY,LC1,T) +EPSILON)*SUM(A1,[ACHR2(CTRY,LC1,A1,T) +EPSILON]*
        YIELD2(CTRY,LC1,A1,T)*
        PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))+EPSILON}** CSA(CTRY,LC1,'4')]$(TROPINAC(CTRY,LC1) EQ 1)


*cost of harvesting temperate inaccessible lands
+
(1-PROPPULP(CTRY,LC1,T) +EPSILON)*
SUM(A1,ACHRIN1(CTRY,LC1,A1,T) +EPSILON)*
PARAM2(CTRY,LC1,'12')*{CHQ1(CTRY,LC1,T)+EPSILON}**(1/PARAM2(CTRY,LC1,'13'))$(TEMPINAC(CTRY,LC1) EQ 1)


*cost of harvesting tropical inaccessible lands
+
(1-PROPPULP(CTRY,LC1,T) +EPSILON)*
{SUM(A1,ACHRIN1(CTRY,LC1,A1,T)+ ACHR3(CTRY,LC1,A1,T))+EPSILON}*
PARAM2(CTRY,LC1,'14')*
{SUM(A1,ACHRIN1(CTRY,LC1,A1,T)+ ACHR3(CTRY,LC1,A1,T))+EPSILON}**(1/PARAM2(CTRY,LC1,'15')) $(TROPINAC(CTRY,LC1) EQ 1)
))
*end of cost of sawtimber harvesting
)

-

*costs of pulpwood production
(
SUM(CTRY,SUM(LC1,
(PROPPULP(CTRY,LC1,T)+EPSILON)*
CSA(CTRY,LC1,'5')*SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*
PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(R1FOR(CTRY,LC1) EQ 1)

+
[
{(PROPPULP(CTRY,LC1,T)+EPSILON)*
SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON )*YIELD2(CTRY,LC1,A1,T)*
PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))+EPSILON}** CSA(CTRY,LC1,'6')]$(R1FOR(CTRY,LC1) EQ 1)

*cost of harvesting temperate semi-accessible lands
+
(PROPPULP(CTRY,LC1,T)+EPSILON)*
CSA(CTRY,LC1,'7')*SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON )*YIELD2(CTRY,LC1,A1,T)*
     PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(TEMPINAC(CTRY,LC1) EQ 1)

+
[
{(PROPPULP(CTRY,LC1,T) +EPSILON)*
SUM(A1,(ACHR2(CTRY,LC1,A1,T) +EPSILON )*YIELD2(CTRY,LC1,A1,T)*
     PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))+EPSILON}** CSA(CTRY,LC1,'8')]$(TEMPINAC(CTRY,LC1) EQ 1)

*cost of harvesting tropical semi-accessible lands
+
(PROPPULP(CTRY,LC1,T)+EPSILON)*
CSA(CTRY,LC1,'7')*SUM(A1,[ACHR2(CTRY,LC1,A1,T) +EPSILON]*
        YIELD2(CTRY,LC1,A1,T)*
        PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(TROPINAC(CTRY,LC1) EQ 1)
+

[
{(PROPPULP(CTRY,LC1,T)+EPSILON)*SUM(A1,[ACHR2(CTRY,LC1,A1,T) +EPSILON]*
        YIELD2(CTRY,LC1,A1,T)*
        PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))+EPSILON}** CSA(CTRY,LC1,'8')]$(TROPINAC(CTRY,LC1) EQ 1)


*cost of harvesting temperate inaccessible lands
+
(PROPPULP(CTRY,LC1,T)+EPSILON)*
SUM(A1,ACHRIN1(CTRY,LC1,A1,T) +EPSILON)*
PARAM2(CTRY,LC1,'12')*{CHQ1(CTRY,LC1,T)+EPSILON}**(1/PARAM2(CTRY,LC1,'13'))$(TEMPINAC(CTRY,LC1) EQ 1)

*cost of harvesting tropical inaccessible lands
+
(PROPPULP(CTRY,LC1,T)+EPSILON)*
{SUM(A1,ACHRIN1(CTRY,LC1,A1,T)+ ACHR3(CTRY,LC1,A1,T))+EPSILON}*
PARAM2(CTRY,LC1,'14')*
{SUM(A1,ACHRIN1(CTRY,LC1,A1,T)+ ACHR3(CTRY,LC1,A1,T))+EPSILON}**(1/PARAM2(CTRY,LC1,'15'))$(TROPINAC(CTRY,LC1) EQ 1)
*end of cost of pulpwood harvesting
))
)

-
(
SUM(CTRY,SUM(LC1,
*dedicated biofuel harvesting costs
CSA(CTRY,LC1,'5')*[ SUM(A1,((ACHR2(CTRY,LC1,A1,T) +EPSILON )*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T))$(DEDBIO(CTRY,LC1) EQ 1)))]+
(SUM(A1,((ACHR2(CTRY,LC1,A1,T) +EPSILON )*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T))$(DEDBIO(CTRY,LC1) EQ 1)))+EPSILON)**CSA(CTRY,LC1,'6')

*transportation costs
+
[SUM(A1,((ACHR2(CTRY,LC1,A1,T) +EPSILON )*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
       ((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T))$(DEDBIO(CTRY,LC1) EQ 1)))]*PARAM3(CTRY,LC1,'18')*PARAM3(CTRY,LC1,'19')
))
*end of dedicated biofuel harvesting costs
)

-
(
*planting costs accessible lands
+SUM(CTRY,SUM(LC1$(R1FOR(CTRY,LC1) EQ 1),(IMGMT1(CTRY,LC1,T) +EPSILON)*(ACPL2(CTRY,LC1,T) +EPSILON)))$YEAR(T)

*planting costs dedicated biofuels
+SUM(CTRY,SUM(LC1$(DEDBIO(CTRY,LC1) EQ 1),
(IMGMT1(CTRY,LC1,T) +EPSILON)*[ACPLBIO(CTRY,LC1,T)+NEWACPLBIO(CTRY,LC1,T) +EPSILON]))$YEAR(T)

*planting costs dedicated biofuels
+SUM(CTRY,SUM(LC1$(DEDBIO(CTRY,LC1) EQ 1),PARAM3(CTRY,LC1,'17')*(NEWACPLBIO(CTRY,LC1,T) +EPSILON)))$YEAR(T)

*planting costs TEMPERATE ZONE inaccessible
+SUM(CTRY, SUM(LC1$(TEMPINAC(CTRY,LC1) EQ 1),(IMGMT1(CTRY,LC1,T) +EPSILON)*(ACPL3(CTRY,LC1,T) +EPSILON)))$YEAR(T)

*planting costs TROPICAL ZONE inaccessible original with ACPL6 only
+SUM(CTRY, SUM(LC1$(TROPINAC(CTRY,LC1) EQ 1),[IMGMT1(CTRY,LC1,T)+2000]*
        [ACPL6(CTRY,LC1,T) +EPSILON]
        ))$YEAR(T)
*end of planting costs
)

-
*land rental costs
(
DDISC*{SUM[CTRY,

*accessible forests
SUM(LC1$(R1FOR(CTRY,LC1) EQ 1),
SUM(A1,YACRE2(CTRY,LC1,A1,T)+EPSILON)*
RENTA(CTRY,LC1,T)*
[(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)]*
         {SUM(A1,YACRE2(CTRY,LC1,A1,T)+EPSILON)**(1/RENTB(CTRY,LC1))}
)

+
*accessible forests
SUM(LC1$(DEDBIO(CTRY,LC1) EQ 1),
SUM(A1,YACRE2(CTRY,LC1,A1,T)+EPSILON)*
[RENTZ(CTRY,LC1,T)*(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)+

RENTA(CTRY,LC1,T)*
[(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)]*
         {SUM(A1,YACRE2(CTRY,LC1,A1,T)+EPSILON)**(1/RENTB(CTRY,LC1))}
]
)

*+YACRE3(CTRY,LC1,A1,T)

*use alternative for tropical forests
+
*inaccessible forests tropical zone
SUM(LC1$(TROPINAC(CTRY,LC1) EQ 1),
-RENTZ(CTRY,LC1,T)*
[(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)]*
[SUM(A1,YACRE2(CTRY,LC1,A1,T) +YACRE3(CTRY,LC1,A1,T) +YACRIN1(CTRY,LC1,A1,T))+EPSILON]+
{1/((1/RENTB(CTRY,LC1))+1)}*
RENTA(CTRY,LC1,T)*
[(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)]*
[SUM(A1,YACRE2(CTRY,LC1,A1,T) +YACRE3(CTRY,LC1,A1,T) +YACRIN1(CTRY,LC1,A1,T))+EPSILON]**{(1/RENTB(CTRY,LC1))+1}
)

-
*subtract out negative part
SUM(LC1$(TROPINAC(CTRY,LC1) EQ 1),
-RENTZ(CTRY,LC1,T)*[RENTHA(CTRY,LC1,T)]+
{1/((1/RENTB(CTRY,LC1))+1)}*
RENTA(CTRY,LC1,T)*
[(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)]*
        [RENTHA(CTRY,LC1,T)+EPSILON]**{(1/RENTB(CTRY,LC1))+1}
)

]}$YEAR(T)
*end of rental costs
)

* ]end of country sum
]
* )end of time sum
)

*terminal conditions

+ SUM(T,

RHO(T)*[SUM(CTRY, SUM(LC1$(R1FOR(CTRY,LC1) EQ 1),SUM(A1,LAMBDA1(CTRY,LC1,A1)*
        ACHR2(CTRY,LC1,A1,T) -
        LAMBDA1(CTRY,LC1,A1)*(ACHR2(CTRY,LC1,A1,T) -
        FINAC1(CTRY,LC1,A1)+EPSILON)*(ACHR2(CTRY,LC1,A1,T)-
        FINAC1(CTRY,LC1,A1)+EPSILON))))]$FINT(T)

+
RHO(T)*[SUM(CTRY, SUM(LC1$(TEMPINAC(CTRY,LC1) EQ 1),SUM(A1,LAMBDA1(CTRY,LC1,A1)*
        [ACHR2(CTRY,LC1,A1,T)+ACHR3(CTRY,LC1,A1,T)])))]$FINT(T)

+
RHO(T)*[SUM(CTRY, SUM(LC1$(R1FOR(CTRY,LC1) EQ 1),SUM(A1,PSI1(CTRY,LC1,A1)*
        FINAC1(CTRY,LC1,A1)*(MGMT1(CTRY,LC1,A1,T) -
        (MGMT1(CTRY,LC1,A1,T) -
        MTFIN1(CTRY,LC1,A1)+EPSILON)*(MGMT1(CTRY,LC1,A1,T)-
        MTFIN1(CTRY,LC1,A1)+EPSILON)))))]$FINT(T)
+
RHO(T)*[SUM(CTRY, SUM(LC1$(TROPINAC(CTRY,LC1) EQ 1), SUM(A1,LAMBDA1(CTRY,LC1,A1)*
        YACRIN1(CTRY,LC1,A1,T))))]$FINT(T)

)
;


*******************************************************************************
* CHANGED LIMROW AND LIMCOL TO SHOW EQUATIONS IN LIST FILE (PRIOR, BOTH = 0)
*******************************************************************************
OPTION LIMROW = 5,
      LIMCOL =  3 ;

OPTION ITERLIM = 50000000;
OPTION RESLIM = 50000000;
*OPTION BRATIO=1;

* Can solve using either MINOS or CONOPT but recommend MINOS for this formulation
OPTION NLP= MINOS;
OPTION DOMLIM=1000000;
*OPTION SYSOUT = ON;
*OPTION PROFILE =3;
*OPTION DMPSYM;


MODEL DYNFONLYM / MOTION11, MOTSIN11, MOTIN11, MOTRPSIN1, MOTRPSIN2,MOTRPIN1,
MOTION21, MOTION11BIO, MOTION21BIO, REPSLIN1, REPDEDBIO, MAXFOR, MAXFORCTRY,  HARVEST1,HARVSIN1,HARVIN1,
HARVSIN2,HARVIN2, HARVEST1BIO , CUMAC1 ,TCHARV1,TCHARV2, BENFOR1, TFORESTAREA
/;


*initialize some variables for solve
PARAMETER YACRE2ZERO(CTRY,LC1);
YACRE2ZERO(CTRY,LC1) = 1-R1FOR(CTRY,LC1) - TEMPINAC(CTRY,LC1) -TROPINAC(CTRY,LC1)- DEDBIO(CTRY,LC1);

YACRE2.L(CTRY,LC1,A1,T) = FORINV2(CTRY,LC1,A1)*0;
ACHR2.L(CTRY,LC1,A1,T) = YACRE2.L(CTRY,LC1,A1,T)/2;

YACRIN1.L(CTRY,LC1,A1,T) = INACI2(CTRY,LC1,A1);
ACHRIN1.L(CTRY,LC1,A1,T) =0;

MGMT1.L(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,A1)/1.4;
IMGMT1.L(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')/1.4;

*set upper and lower bounds on management intensity
IMGMT1.LO(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*0;
IMGMT1.UP(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*4;
MGMT1.LO(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*0;
MGMT1.UP(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*4;

YACRE2.LO(CTRY,LC1,A1,T) = FORINV2(CTRY,LC1,A1)*0;
YACRE2.UP(CTRY,LC1,A1,T) = 10000;

YACRE2.LO(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;
YACRE2.UP(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;

PROPPULP.L(CTRY,LC1 ,T) = PARAM3(CTRY,LC1,'14');

MXFORA=10;

YACRE3.L(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)=0;

TOTALFOREST.L(T) = SUM(CTRY,SUM(LC1,SUM(A1,
         YACRE2.L(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)+
         YACRE2.L(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRE2.L(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRE3.L(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRIN1.L(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRIN1.L(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1))
));

PROPPULP.UP(CTRY,LC1 ,T) =1;

*create option file
FILE BBBM /MINOS.OPT/;
  PUT BBBM;
          PUT 'superbasics limit = 10000'/;
  PUTCLOSE BBBM;

DYNFONLYM.WORKSPACE = 900;

DYNFONLYM.OPTFILE = 1;
DYNFONLYM.SCALEOPT= 1;

MGMT1.SCALE(CTRY,LC1,A1,T)=10;

BENFOR1.SCALE =1000000;
NPVFOR1.SCALE =1000000;

SOLVE DYNFONLYM USING NLP MAXIMIZING NPVFOR1;

******************************************
*SECOND ITERATION OF BASELINE CALIBRATION
******************************************

*harvesting cost parameters
TABLE PARAM4_N1(CTRY,LC1,DATA)
$ondelim
$include param4_010722.csv
$offdelim
;

PARAM4(CTRY,LC1,DATA) = PARAM4_N1(CTRY,LC1,DATA);

*define for later use
PARAMETER CSA(CTRY,LC1,DATA);
CSA(CTRY,LC1,DATA) = PARAM4(CTRY,LC1,DATA);


TABLE PARAM2_N1(CTRY,LC1,DATA)
$ondelim
$include param2_010722.csv
$offdelim
;

TABLE PARAM3_N1(CTRY,LC1,DATA)
$ondelim
$include param3_010722.csv
$offdelim
;

PARAM2(CTRY,LC1,DATA) = PARAM2_N1(CTRY,LC1,DATA);
PARAM3(CTRY,LC1,DATA) = PARAM3_N1(CTRY,LC1,DATA);


$ONTEXT;
This section calculates shifts in the rental functions to account for exogenous changes in demand for alternative uses of land
$OFFTEXT;

PARAMETER RNTSHFT(CTRY,LC1,T);
RNTSHFT(CTRY,LC1,'1') = 1;
LOOP[T, RNTSHFT(CTRY,LC1,T+1)=
        {RNTSHFT(CTRY,LC1,T)*(1+PARAM3(CTRY,LC1,'2')*
                ((1-PARAM3(CTRY,LC1,'3'))**{ORD(T)-1}))}$(PARAM3(CTRY,LC1,'2') NE 0)+

        RNTSHFT(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'2') EQ 0)];

DISPLAY RNTSHFT;

PARAMETER RENTA(CTRY,LC1,T);
RENTA(CTRY,LC1,T) =
        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(R1FOR(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(DEDBIO(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')$(TROPINAC(CTRY,LC1) EQ 1);

PARAMETER RENTB(CTRY,LC1);
RENTB(CTRY,LC1)=PARAM2(CTRY,LC1,'17');

PARAMETER RENTAF(CTRY,LC1);
RENTAF(CTRY,LC1) = SUM[T$(FINT(T)),RENTA(CTRY,LC1,T)$(FINT(T))];

PARAMETER RENTZ(CTRY,LC1,T);
RENTZ(CTRY,LC1,T) = PARAM2(CTRY,LC1,'18')*(1/RNTSHFT(CTRY,LC1,T));

PARAMETER RENTHA(CTRY,LC1,T);
RENTHA(CTRY,LC1,T) =
{[RENTZ(CTRY,LC1,T)/RENTA(CTRY,LC1,T)]**RENTB(CTRY,LC1)}$(TROPINAC(CTRY,LC1) EQ 1);

DISPLAY RENTA,RENTZ,RENTHA;


$ONTEXT;
FINPTEL adjusts parameter that affects the elasticity of management inputs in forestry to account for technology change.  Currently assume 0.3% per decade growth in elasticity
$OFFTEXT;

PARAMETER FINPTEL(CTRY,LC1,T);
FINPTEL(CTRY,LC1,'1')$(R1FOR(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(R1FOR(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

FINPTEL(CTRY,LC1,'1')$(DEDBIO(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(DEDBIO(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

DISPLAY FINPTEL;

PARAMETER FINPTELF(CTRY,LC1);
FINPTELF(CTRY,LC1) = SUM[T$(FINT(T)),FINPTEL(CTRY,LC1,T)$(FINT(T))];

DISPLAY FINPTELF;


*adjusted growth change to reflect effects estimated in Davis et al. (2021)

PARAMETER CHG1(CTRY,LC1,T,DATA);

CHG1(CTRY,LC1,T,DATA)=0;

CHG1(CTRY,LC1,'1','1')=0.072;
*adjust down for Russia and Canada
CHG1('4',LC1,'1','1')=0.035;
CHG1('5',LC1,'1','1')=0.035;


LOOP(T,CHG1(CTRY,LC1,T+1,'1') = CHG1(CTRY,LC1,T,'1')+
CHG1(CTRY,LC1,'1','1')*(EXP(-.15*(ORD(T)))));

*CHG1(CTRY,LC1,'1','1')$(ORD(T) LT 5)

*Generate forest yield functions
* GINIT = decadal forest growth
* note that these include adjustments to forest growth to account for climate change through CHG1, but
* those parameters are set to 0 in the baseline.
PARAMETER GINIT1(CTRY,LC1,A1,T);
GINIT1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*

                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*Also decadal growth
PARAMETER GROWTH1(CTRY,LC1,A1,T);
GROWTH1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*
                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+
                                ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*initial age class growth in each time period
PARAMETER YINIT1(CTRY,LC1,A1,T);
YINIT1(CTRY,LC1,'1',T) = GINIT1(CTRY,LC1,'1',T);
LOOP(A1,YINIT1(CTRY,LC1,A1+1,T) = YINIT1(CTRY,LC1,A1,T) + GINIT1(CTRY,LC1,A1+1,T));

DISPLAY GINIT1,YINIT1;

*YIELD2 is growth function, summed over decadal growth
PARAMETER YIELD2(CTRY,LC1,A1,T) yield function;

YIELD2(CTRY,LC1,A1,T) = YINIT1(CTRY,LC1,A1,T)$TFIRST(T);
YIELD2(CTRY,LC1,A1,T)$AFIRST1(A1) = GROWTH1(CTRY,LC1,A1,T)$AFIRST1(A1);
LOOP(T,LOOP(A1,YIELD2(CTRY,LC1,A1+1,T+1)=YIELD2(CTRY,LC1,A1,T)+
        GROWTH1(CTRY,LC1,A1+1,T+1)));

*create YIELDORIG(CTRY,LC1,A1,T) which is used later for carbon calculations
* Use YIELD2 divided by quality adjustment parameter
PARAMETER YIELDORIG(CTRY,LC1,A1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

*Quality adjustment  accounts for value differences across logs from different regions.
YIELD2(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T)*PARAM3(CTRY,LC1,'4');


DISPLAY YIELD2;

*Add in underlying productivity changes in yields for productive species
*original method of shifting yields
*these are 6% per decade for many plantation types
PARAMETER YDGRTH(CTRY,LC1,T);
YDGRTH(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH(CTRY,LC1,T+1) = YDGRTH(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)*
       (.99**[(ORD(T)-1)*10]))$(PARAM3(CTRY,LC1,'1') EQ 1)+
(PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'1') EQ 0)
);

PARAMETER YDGRTH2(CTRY,LC1,T);
YDGRTH2(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH2(CTRY,LC1,T+1) = YDGRTH2(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH2(CTRY,LC1,T)*(.99**[(ORD(T)-1)*10])));


YIELD2(CTRY,LC1,A1,T)= YIELD2(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELDORIG(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);

DISPLAY YDGRTH, YIELD2;


*Technology change adjustment for merchantable timber out of biomass stock
*Not included in this version; assumed to be 0
PARAMETER TSWCHG(CTRY,LC1);
TSWCHG(CTRY,LC1) = 0;

PARAMETER MXSWTM(CTRY,LC1,T);
MXSWTM(CTRY,LC1,'1')$(ALLIN(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'4')$(ALLIN(CTRY,LC1) EQ 1);
LOOP[T,MXSWTM(CTRY,LC1,T+1) $(ALLIN(CTRY,LC1) EQ 1) =
        MXSWTM(CTRY,LC1,T)*(1+ TSWCHG(CTRY,LC1))];


$ONTEXT;
 The following routines adjust the yield function to account for the merchantable proportion of stock
 on each hectare.
The final result below takes the original yield function from above and multiplies by a factor that adjusts the biomass on site for the proportion that is merchantable, depending on the age class.

YIELD2 = YIELD2*SWPERC2A

$OFFTEXT;

PARAMETER SWGRTH(CTRY,LC1);
SWGRTH(CTRY,LC1) =2.0$(PARAM2(CTRY,LC1,'11') EQ 1)+
1.0$( PARAM2(CTRY,LC1,'11') EQ 2)+
0.9$( PARAM2(CTRY,LC1,'11') EQ 3)+
0.6$( PARAM2(CTRY,LC1,'11') EQ 4)+
0.5$( PARAM2(CTRY,LC1,'11') GT 4);


PARAMETER SWPERC2A(CTRY,LC1,A1,T);
SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=

{MXSWTM(CTRY,LC1,T)*[1-EXP((-0.4/(PARAM2(CTRY,LC1,'11')*10-ORD(A1)*10+10))*
(ORD(A1)*10))]**2}$(ORD(A1) LT PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*AGETR age to start counting sawtimber quantity
PARAMETER AGETR(CTRY,LC1);
AGETR(CTRY,LC1) = PARAM2(CTRY,LC1,'6');

*SWPC2A shifts SWPERC2A up by the number of decades in AGETR.
PARAMETER SWPC2A(CTRY,LC1,A1,T);
LOOP[A1,SWPC2A(CTRY,LC1,A1,T) = 0$(ORD(A1) LT AGETR(CTRY,LC1)) +
       0$(ORD(A1) EQ AGETR(CTRY,LC1))+
       SWPERC2A(CTRY,LC1,A1-AGETR(CTRY,LC1),T)$(ORD(A1) GT AGETR(CTRY,LC1))];

DISPLAY SWPC2A;

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=SWPC2A(CTRY,LC1,A1,T);

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = MIN[SWPERC2A(CTRY,LC1,A1,T),10];

YIELD2(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=YIELD2(CTRY,LC1,A1,T)*SWPERC2A(CTRY,LC1,A1,T);

DISPLAY SWPERC2A, YIELD2;

PARAMETER YIELD2F(CTRY,LC1,A1);
YIELD2F(CTRY,LC1,A1)=SUM[T$(FINT(T)),YIELD2(CTRY,LC1,A1,T)$(FINT(T))];

*create inaccessible yield functions  already adjusted for merch proportion
PARAMETER YLDINAC(CTRY,LC1,A1,T);
YLDINAC(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

execute_unload "GLOBALTIMBERMODEL_01_2022.gdx"

*Estimate terminal values

*a discount factor
PARAMETER DELTA1(CTRY,LC1);
DELTA1(CTRY,LC1) = 1/[(1-EXP(-R*PARAM2(CTRY,LC1,'11')*10))$(ALLIN(CTRY,LC1) EQ 1) +
                                1$(ALLIN(CTRY,LC1) EQ 0)];

*Estimate terminal management values
PARAMETER MNG1(CTRY,LC1);
MNG1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
SUM(A1,{[{[(1/(1+R))**(-PARAM2(CTRY,LC1,'11')*10)]*

(1/((PTERM - PARAM2(CTRY,LC1,'10')$(ALLIN(CTRY,LC1) EQ 1))*
PARAM2(CTRY,LC1,'8')$(ALLIN(CTRY,LC1) EQ 1)*FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)*
        YIELD2F(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)+EPSILON))}**(1/( FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1))]
-1}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

MNG1(CTRY,LC1) = MAX[MNG1(CTRY,LC1),0];

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[MNG1(CTRY,LC1),MANT];

DISPLAY MNG1, MNG1A;


*alternate calculation of MNG1/A
PARAMETER ZIM1(CTRY,LC1);
ZIM1(CTRY,LC1)=0;
LOOP(CTRY,
LOOP[LC1$(ALLIN(CTRY,LC1) EQ 1),
WHILE(

SUM{A1,[(1+R)**(-10*ORD(A1))]*(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
        (ZIM1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))}


GT 1,

ZIM1(CTRY,LC1)= ZIM1(CTRY,LC1)+1);
]
)
;

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[ZIM1(CTRY,LC1),MANT];
MNG1(CTRY,LC1) = MNG1A(CTRY,LC1);

*determine rotation age and net present values

PARAMETER NC1(CTRY,LC1,A1);
NC1(CTRY,LC1,A1)=0;
PARAMETER NPVCS1(CTRY,LC1,AC1);
NPVCS1(CTRY,LC1,AC1)=0;

PARAMETER NPVSS1(CTRY,LC1,A1);
NPVSS1(CTRY,LC1,A1) =
{(PTERM - PARAM2(CTRY,LC1,'10'))*
        {(PARAM2(CTRY,LC1,'8')*(MNG1A(CTRY,LC1)+1+EPSILON)** FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)*((1+R)**(-ORD(A1)*10))}+
        SUM(AC1,NPVCS1(CTRY,LC1,AC1)$(ORD(AC1) EQ ORD(A1)))
        - MNG1A(CTRY,LC1)}/{1-((1+R)**(-ORD(A1)*10))};

DISPLAY NPVSS1;

PARAMETER NPVT1;

PARAMETER NPVT2

PARAMETER TMAGE1(CTRY,LC1);
TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = 1;

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
LOOP(A1, NPVT1=NPVSS1(CTRY,LC1,A1);
        NPVT2 = NPVSS1(CTRY,LC1,A1+1);


IF (NPVT1<NPVT2, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSEIF (NPVT1=NPVT2), TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1));
        );
IF (NPVT1 <0, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) ;
        );
        );
      );

DISPLAY TMAGE1;
PARAM2(CTRY,LC1,'11')$(ALLIN(CTRY,LC1) EQ 1)=TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1);


*Determine SS area of accessible forests
*calculate decadal rental value
PARAMETER PVADDA1(CTRY,LC1);
PVADDA1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]-
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]/(1+R);

PARAMETER TFINAC1(CTRY,LC1);
TFINAC1(CTRY,LC1)$(R1FOR(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

TFINAC1(CTRY,LC1)$(TROPINAC(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

DISPLAY PVADDA1,TFINAC1;

TFINAC1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TFINAC1(CTRY,LC1)/PARAM2(CTRY,LC1,'11');

PARAMETER FINAC1(CTRY,LC1,A1);
FINAC1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        TFINAC1(CTRY,LC1)$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1));

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
       IF((PARAM2(CTRY,LC1,'11')) = 15,
       LOOP[A1, FINAC1(CTRY,LC1,A1) = 0$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')))+
       TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11')$(ORD(A1) EQ (PARAM2(CTRY,LC1,'11')))];
        ELSE LOOP(A1,
       IF (ORD(A1)< (PARAM2(CTRY,LC1,'11')+1),
                FINAC1(CTRY,LC1,A1) = TFINAC1(CTRY,LC1);
                ELSE FINAC1(CTRY,LC1,A1) =0;
       ););
        );
);
);

TFINAC1(CTRY,LC1)=TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11');

DISPLAY TFINAC1,FINAC1;

*Estimate Terminal Conditions
PARAMETER ALPHAK1(CTRY,LC1,A1);

ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);

PARAMETER ALPHA1(CTRY,LC1);
ALPHA1(CTRY,LC1)=SUM(A1,ALPHAK1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

DISPLAY ALPHAK1,ALPHA1;

PARAMETER ALPHAK1(CTRY,LC1,A1);
ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);


PARAMETER BETA1(CTRY,LC1);
BETA1(CTRY,LC1) = SUM(A1, [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));
DISPLAY BETA1;

BETA1(CTRY,LC1) =0;
LOOP{A1,

BETA1(CTRY,LC1) = BETA1(CTRY,LC1)+
        [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))
};


DISPLAY MNG1,BETA1;

*LAMBDA1 is actual terminal condition in $/ha for each age class
PARAMETER LAMBDA1(CTRY,LC1,A1);
LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) = {[(1/(1+R))**([PARAM2(CTRY,LC1,'11') - ORD(A1)]*10)]*
        DELTA1(CTRY,LC1)*ALPHA1(CTRY,LC1)}$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1)) +
       {(DELTA1(CTRY,LC1)-1)*ALPHA1(CTRY,LC1) + ALPHAK1(CTRY,LC1,A1)}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)=
LAMBDA1(CTRY,LC1,A1)$(ORD(A1) LT PARAM2(CTRY,LC1,'11')+1)+
0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*PSI1 is actual terminal condition for $ spent on management
PARAMETER PSI1(CTRY,LC1,A1);
PSI1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        {[(1/(1+R))**([PARAM2(CTRY,LC1,'11')-ORD(A1)]*10)]*BETA1(CTRY,LC1)}$(ORD(A1)
       LT (PARAM2(CTRY,LC1,'11')+1)) + 0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));


DISPLAY LAMBDA1,PSI1;

*set upper and lower bounds on management intensity
IMGMT1.LO(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*0;
IMGMT1.UP(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*4;
MGMT1.LO(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*0;
MGMT1.UP(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*4;

YACRE2.LO(CTRY,LC1,A1,T) = FORINV2(CTRY,LC1,A1)*0;
YACRE2.UP(CTRY,LC1,A1,T) = 10000;

YACRE2.LO(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;
YACRE2.UP(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;

MXFORA=10;

PROPPULP.UP(CTRY,LC1 ,T) =1;

*create option file
FILE BBBM2 /MINOS.OPT/;
  PUT BBBM2;
          PUT 'superbasics limit = 10000'/;
  PUTCLOSE BBBM2;

DYNFONLYM.WORKSPACE = 900;

DYNFONLYM.OPTFILE = 1;
DYNFONLYM.SCALEOPT= 1;

MGMT1.SCALE(CTRY,LC1,A1,T)=10;

BENFOR1.SCALE =100000000;
NPVFOR1.SCALE =100000000;

SOLVE DYNFONLYM USING NLP MAXIMIZING NPVFOR1;

******************************************
*THIRD ITERATION OF BASELINE CALIBRATION
******************************************
*harvesting cost parameters
TABLE PARAM4_N2(CTRY,LC1,DATA)
$ondelim
$include param4_010722.csv
$offdelim
;

PARAM4(CTRY,LC1,DATA) = PARAM4_N2(CTRY,LC1,DATA);

*define for later use
PARAMETER CSA(CTRY,LC1,DATA);
CSA(CTRY,LC1,DATA) = PARAM4(CTRY,LC1,DATA);


TABLE PARAM2_N2(CTRY,LC1,DATA)
$ondelim
$include param2_010722.csv
$offdelim
;

TABLE PARAM3_N2(CTRY,LC1,DATA)
$ondelim
$include param3_010722.csv
$offdelim
;

PARAM2(CTRY,LC1,DATA) = PARAM2_N2(CTRY,LC1,DATA);
PARAM3(CTRY,LC1,DATA) = PARAM3_N2(CTRY,LC1,DATA);


$ONTEXT;
This section calculates shifts in the rental functions to account for exogenous changes in demand for alternative uses of land
$OFFTEXT;

PARAMETER RNTSHFT(CTRY,LC1,T);
RNTSHFT(CTRY,LC1,'1') = 1;
LOOP[T, RNTSHFT(CTRY,LC1,T+1)=
        {RNTSHFT(CTRY,LC1,T)*(1+PARAM3(CTRY,LC1,'2')*
                ((1-PARAM3(CTRY,LC1,'3'))**{ORD(T)-1}))}$(PARAM3(CTRY,LC1,'2') NE 0)+

        RNTSHFT(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'2') EQ 0)];

DISPLAY RNTSHFT;

PARAMETER RENTA(CTRY,LC1,T);
RENTA(CTRY,LC1,T) =
        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(R1FOR(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(DEDBIO(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')$(TROPINAC(CTRY,LC1) EQ 1);

PARAMETER RENTB(CTRY,LC1);
RENTB(CTRY,LC1)=PARAM2(CTRY,LC1,'17');

PARAMETER RENTAF(CTRY,LC1);
RENTAF(CTRY,LC1) = SUM[T$(FINT(T)),RENTA(CTRY,LC1,T)$(FINT(T))];

PARAMETER RENTZ(CTRY,LC1,T);
RENTZ(CTRY,LC1,T) = PARAM2(CTRY,LC1,'18')*(1/RNTSHFT(CTRY,LC1,T));

PARAMETER RENTHA(CTRY,LC1,T);
RENTHA(CTRY,LC1,T) =
{[RENTZ(CTRY,LC1,T)/RENTA(CTRY,LC1,T)]**RENTB(CTRY,LC1)}$(TROPINAC(CTRY,LC1) EQ 1);

DISPLAY RENTA,RENTZ,RENTHA;


$ONTEXT;
FINPTEL adjusts parameter that affects the elasticity of management inputs in forestry to account for technology change.  Currently assume 0.3% per decade growth in elasticity
$OFFTEXT;

PARAMETER FINPTEL(CTRY,LC1,T);
FINPTEL(CTRY,LC1,'1')$(R1FOR(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(R1FOR(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

FINPTEL(CTRY,LC1,'1')$(DEDBIO(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(DEDBIO(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

DISPLAY FINPTEL;

PARAMETER FINPTELF(CTRY,LC1);
FINPTELF(CTRY,LC1) = SUM[T$(FINT(T)),FINPTEL(CTRY,LC1,T)$(FINT(T))];

DISPLAY FINPTELF;


*adjusted growth change to reflect effects estimated in Davis et al. (2021)

PARAMETER CHG1(CTRY,LC1,T,DATA);

CHG1(CTRY,LC1,T,DATA)=0;

CHG1(CTRY,LC1,'1','1')=0.072;
*adjust down for Russia and Canada
CHG1('4',LC1,'1','1')=0.035;
CHG1('5',LC1,'1','1')=0.035;


LOOP(T,CHG1(CTRY,LC1,T+1,'1') = CHG1(CTRY,LC1,T,'1')+
CHG1(CTRY,LC1,'1','1')*(EXP(-.15*(ORD(T)))));

*CHG1(CTRY,LC1,'1','1')$(ORD(T) LT 5)

*Generate forest yield functions
* GINIT = decadal forest growth
* note that these include adjustments to forest growth to account for climate change through CHG1, but
* those parameters are set to 0 in the baseline.
PARAMETER GINIT1(CTRY,LC1,A1,T);
GINIT1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*

                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*Also decadal growth
PARAMETER GROWTH1(CTRY,LC1,A1,T);
GROWTH1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*
                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+
                                ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*initial age class growth in each time period
PARAMETER YINIT1(CTRY,LC1,A1,T);
YINIT1(CTRY,LC1,'1',T) = GINIT1(CTRY,LC1,'1',T);
LOOP(A1,YINIT1(CTRY,LC1,A1+1,T) = YINIT1(CTRY,LC1,A1,T) + GINIT1(CTRY,LC1,A1+1,T));

DISPLAY GINIT1,YINIT1;

*YIELD2 is growth function, summed over decadal growth
PARAMETER YIELD2(CTRY,LC1,A1,T) yield function;

YIELD2(CTRY,LC1,A1,T) = YINIT1(CTRY,LC1,A1,T)$TFIRST(T);
YIELD2(CTRY,LC1,A1,T)$AFIRST1(A1) = GROWTH1(CTRY,LC1,A1,T)$AFIRST1(A1);
LOOP(T,LOOP(A1,YIELD2(CTRY,LC1,A1+1,T+1)=YIELD2(CTRY,LC1,A1,T)+
        GROWTH1(CTRY,LC1,A1+1,T+1)));

*create YIELDORIG(CTRY,LC1,A1,T) which is used later for carbon calculations
* Use YIELD2 divided by quality adjustment parameter
PARAMETER YIELDORIG(CTRY,LC1,A1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

*Quality adjustment  accounts for value differences across logs from different regions.
YIELD2(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T)*PARAM3(CTRY,LC1,'4');


DISPLAY YIELD2;

*Add in underlying productivity changes in yields for productive species
*original method of shifting yields
*these are 6% per decade for many plantation types
PARAMETER YDGRTH(CTRY,LC1,T);
YDGRTH(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH(CTRY,LC1,T+1) = YDGRTH(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)*
       (.99**[(ORD(T)-1)*10]))$(PARAM3(CTRY,LC1,'1') EQ 1)+
(PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'1') EQ 0)
);

PARAMETER YDGRTH2(CTRY,LC1,T);
YDGRTH2(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH2(CTRY,LC1,T+1) = YDGRTH2(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH2(CTRY,LC1,T)*(.99**[(ORD(T)-1)*10])));


YIELD2(CTRY,LC1,A1,T)= YIELD2(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELDORIG(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);

DISPLAY YDGRTH, YIELD2;


*Technology change adjustment for merchantable timber out of biomass stock
*Not included in this version; assumed to be 0
PARAMETER TSWCHG(CTRY,LC1);
TSWCHG(CTRY,LC1) = 0;

PARAMETER MXSWTM(CTRY,LC1,T);
MXSWTM(CTRY,LC1,'1')$(ALLIN(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'4')$(ALLIN(CTRY,LC1) EQ 1);
LOOP[T,MXSWTM(CTRY,LC1,T+1) $(ALLIN(CTRY,LC1) EQ 1) =
        MXSWTM(CTRY,LC1,T)*(1+ TSWCHG(CTRY,LC1))];


$ONTEXT;
 The following routines adjust the yield function to account for the merchantable proportion of stock
 on each hectare.
The final result below takes the original yield function from above and multiplies by a factor that adjusts the biomass on site for the proportion that is merchantable, depending on the age class.

YIELD2 = YIELD2*SWPERC2A

$OFFTEXT;

PARAMETER SWGRTH(CTRY,LC1);
SWGRTH(CTRY,LC1) =2.0$(PARAM2(CTRY,LC1,'11') EQ 1)+
1.0$( PARAM2(CTRY,LC1,'11') EQ 2)+
0.9$( PARAM2(CTRY,LC1,'11') EQ 3)+
0.6$( PARAM2(CTRY,LC1,'11') EQ 4)+
0.5$( PARAM2(CTRY,LC1,'11') GT 4);


PARAMETER SWPERC2A(CTRY,LC1,A1,T);
SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=

{MXSWTM(CTRY,LC1,T)*[1-EXP((-0.4/(PARAM2(CTRY,LC1,'11')*10-ORD(A1)*10+10))*
(ORD(A1)*10))]**2}$(ORD(A1) LT PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*AGETR age to start counting sawtimber quantity
PARAMETER AGETR(CTRY,LC1);
AGETR(CTRY,LC1) = PARAM2(CTRY,LC1,'6');

*SWPC2A shifts SWPERC2A up by the number of decades in AGETR.
PARAMETER SWPC2A(CTRY,LC1,A1,T);
LOOP[A1,SWPC2A(CTRY,LC1,A1,T) = 0$(ORD(A1) LT AGETR(CTRY,LC1)) +
       0$(ORD(A1) EQ AGETR(CTRY,LC1))+
       SWPERC2A(CTRY,LC1,A1-AGETR(CTRY,LC1),T)$(ORD(A1) GT AGETR(CTRY,LC1))];

DISPLAY SWPC2A;

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=SWPC2A(CTRY,LC1,A1,T);

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = MIN[SWPERC2A(CTRY,LC1,A1,T),10];

YIELD2(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=YIELD2(CTRY,LC1,A1,T)*SWPERC2A(CTRY,LC1,A1,T);

DISPLAY SWPERC2A, YIELD2;

PARAMETER YIELD2F(CTRY,LC1,A1);
YIELD2F(CTRY,LC1,A1)=SUM[T$(FINT(T)),YIELD2(CTRY,LC1,A1,T)$(FINT(T))];

*create inaccessible yield functions  already adjusted for merch proportion
PARAMETER YLDINAC(CTRY,LC1,A1,T);
YLDINAC(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

execute_unload "GLOBALTIMBERMODEL_01_2022.gdx"

*Estimate terminal values

*a discount factor
PARAMETER DELTA1(CTRY,LC1);
DELTA1(CTRY,LC1) = 1/[(1-EXP(-R*PARAM2(CTRY,LC1,'11')*10))$(ALLIN(CTRY,LC1) EQ 1) +
                                1$(ALLIN(CTRY,LC1) EQ 0)];

*Estimate terminal management values
PARAMETER MNG1(CTRY,LC1);
MNG1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
SUM(A1,{[{[(1/(1+R))**(-PARAM2(CTRY,LC1,'11')*10)]*

(1/((PTERM - PARAM2(CTRY,LC1,'10')$(ALLIN(CTRY,LC1) EQ 1))*
PARAM2(CTRY,LC1,'8')$(ALLIN(CTRY,LC1) EQ 1)*FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)*
        YIELD2F(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)+EPSILON))}**(1/( FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1))]
-1}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

MNG1(CTRY,LC1) = MAX[MNG1(CTRY,LC1),0];

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[MNG1(CTRY,LC1),MANT];

DISPLAY MNG1, MNG1A;


*alternate calculation of MNG1/A
PARAMETER ZIM1(CTRY,LC1);
ZIM1(CTRY,LC1)=0;
LOOP(CTRY,
LOOP[LC1$(ALLIN(CTRY,LC1) EQ 1),
WHILE(

SUM{A1,[(1+R)**(-10*ORD(A1))]*(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
        (ZIM1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))}


GT 1,

ZIM1(CTRY,LC1)= ZIM1(CTRY,LC1)+1);
]
)
;

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[ZIM1(CTRY,LC1),MANT];
MNG1(CTRY,LC1) = MNG1A(CTRY,LC1);

*determine rotation age and net present values

PARAMETER NC1(CTRY,LC1,A1);
NC1(CTRY,LC1,A1)=0;
PARAMETER NPVCS1(CTRY,LC1,AC1);
NPVCS1(CTRY,LC1,AC1)=0;

PARAMETER NPVSS1(CTRY,LC1,A1);
NPVSS1(CTRY,LC1,A1) =
{(PTERM - PARAM2(CTRY,LC1,'10'))*
        {(PARAM2(CTRY,LC1,'8')*(MNG1A(CTRY,LC1)+1+EPSILON)** FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)*((1+R)**(-ORD(A1)*10))}+
        SUM(AC1,NPVCS1(CTRY,LC1,AC1)$(ORD(AC1) EQ ORD(A1)))
        - MNG1A(CTRY,LC1)}/{1-((1+R)**(-ORD(A1)*10))};

DISPLAY NPVSS1;

PARAMETER NPVT1;

PARAMETER NPVT2

PARAMETER TMAGE1(CTRY,LC1);
TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = 1;

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
LOOP(A1, NPVT1=NPVSS1(CTRY,LC1,A1);
        NPVT2 = NPVSS1(CTRY,LC1,A1+1);


IF (NPVT1<NPVT2, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSEIF (NPVT1=NPVT2), TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1));
        );
IF (NPVT1 <0, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) ;
        );
        );
      );

DISPLAY TMAGE1;
PARAM2(CTRY,LC1,'11')$(ALLIN(CTRY,LC1) EQ 1)=TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1);


*Determine SS area of accessible forests
*calculate decadal rental value
PARAMETER PVADDA1(CTRY,LC1);
PVADDA1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]-
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]/(1+R);

PARAMETER TFINAC1(CTRY,LC1);
TFINAC1(CTRY,LC1)$(R1FOR(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

TFINAC1(CTRY,LC1)$(TROPINAC(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

DISPLAY PVADDA1,TFINAC1;

TFINAC1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TFINAC1(CTRY,LC1)/PARAM2(CTRY,LC1,'11');

PARAMETER FINAC1(CTRY,LC1,A1);
FINAC1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        TFINAC1(CTRY,LC1)$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1));

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
       IF((PARAM2(CTRY,LC1,'11')) = 15,
       LOOP[A1, FINAC1(CTRY,LC1,A1) = 0$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')))+
       TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11')$(ORD(A1) EQ (PARAM2(CTRY,LC1,'11')))];
        ELSE LOOP(A1,
       IF (ORD(A1)< (PARAM2(CTRY,LC1,'11')+1),
                FINAC1(CTRY,LC1,A1) = TFINAC1(CTRY,LC1);
                ELSE FINAC1(CTRY,LC1,A1) =0;
       ););
        );
);
);

TFINAC1(CTRY,LC1)=TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11');

DISPLAY TFINAC1,FINAC1;

*Estimate Terminal Conditions
PARAMETER ALPHAK1(CTRY,LC1,A1);

ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);

PARAMETER ALPHA1(CTRY,LC1);
ALPHA1(CTRY,LC1)=SUM(A1,ALPHAK1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

DISPLAY ALPHAK1,ALPHA1;

PARAMETER ALPHAK1(CTRY,LC1,A1);
ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);


PARAMETER BETA1(CTRY,LC1);
BETA1(CTRY,LC1) = SUM(A1, [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));
DISPLAY BETA1;

BETA1(CTRY,LC1) =0;
LOOP{A1,

BETA1(CTRY,LC1) = BETA1(CTRY,LC1)+
        [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))
};


DISPLAY MNG1,BETA1;

*LAMBDA1 is actual terminal condition in $/ha for each age class
PARAMETER LAMBDA1(CTRY,LC1,A1);
LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) = {[(1/(1+R))**([PARAM2(CTRY,LC1,'11') - ORD(A1)]*10)]*
        DELTA1(CTRY,LC1)*ALPHA1(CTRY,LC1)}$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1)) +
       {(DELTA1(CTRY,LC1)-1)*ALPHA1(CTRY,LC1) + ALPHAK1(CTRY,LC1,A1)}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)=
LAMBDA1(CTRY,LC1,A1)$(ORD(A1) LT PARAM2(CTRY,LC1,'11')+1)+
0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*PSI1 is actual terminal condition for $ spent on management
PARAMETER PSI1(CTRY,LC1,A1);
PSI1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        {[(1/(1+R))**([PARAM2(CTRY,LC1,'11')-ORD(A1)]*10)]*BETA1(CTRY,LC1)}$(ORD(A1)
       LT (PARAM2(CTRY,LC1,'11')+1)) + 0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));


DISPLAY LAMBDA1,PSI1;

*set upper and lower bounds on management intensity
IMGMT1.LO(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*0;
IMGMT1.UP(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*4;
MGMT1.LO(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*0;
MGMT1.UP(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*4;

YACRE2.LO(CTRY,LC1,A1,T) = FORINV2(CTRY,LC1,A1)*0;
YACRE2.UP(CTRY,LC1,A1,T) = 10000;

YACRE2.LO(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;
YACRE2.UP(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;

MXFORA=10;

PROPPULP.UP(CTRY,LC1 ,T) =1;

*create option file
FILE BBBM3 /MINOS.OPT/;
  PUT BBBM3;
          PUT 'superbasics limit = 10000'/;
  PUTCLOSE BBBM3;

DYNFONLYM.WORKSPACE = 900;

DYNFONLYM.OPTFILE = 1;
DYNFONLYM.SCALEOPT= 1;

MGMT1.SCALE(CTRY,LC1,A1,T)=10;

BENFOR1.SCALE =1000000;
NPVFOR1.SCALE =1000000;

SOLVE DYNFONLYM USING NLP MAXIMIZING NPVFOR1;

******************************************
*FOURTH ITERATION OF BASELINE CALIBRATION
******************************************
*harvesting cost parameters
TABLE PARAM4_N3(CTRY,LC1,DATA)
$ondelim
$include param4_010722.csv
$offdelim
;

PARAM4(CTRY,LC1,DATA) = PARAM4_N3(CTRY,LC1,DATA);

*define for later use
PARAMETER CSA(CTRY,LC1,DATA);
CSA(CTRY,LC1,DATA) = PARAM4(CTRY,LC1,DATA);


TABLE PARAM2_N3(CTRY,LC1,DATA)
$ondelim
$include param2_010722.csv
$offdelim
;

TABLE PARAM3_N3(CTRY,LC1,DATA)
$ondelim
$include param3_010722.csv
$offdelim
;

PARAM2(CTRY,LC1,DATA) = PARAM2_N3(CTRY,LC1,DATA);
PARAM3(CTRY,LC1,DATA) = PARAM3_N3(CTRY,LC1,DATA);


$ONTEXT;
This section calculates shifts in the rental functions to account for exogenous changes in demand for alternative uses of land
$OFFTEXT;

PARAMETER RNTSHFT(CTRY,LC1,T);
RNTSHFT(CTRY,LC1,'1') = 1;
LOOP[T, RNTSHFT(CTRY,LC1,T+1)=
        {RNTSHFT(CTRY,LC1,T)*(1+PARAM3(CTRY,LC1,'2')*
                ((1-PARAM3(CTRY,LC1,'3'))**{ORD(T)-1}))}$(PARAM3(CTRY,LC1,'2') NE 0)+

        RNTSHFT(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'2') EQ 0)];

DISPLAY RNTSHFT;

PARAMETER RENTA(CTRY,LC1,T);
RENTA(CTRY,LC1,T) =
        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(R1FOR(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')*RNTSHFT(CTRY,LC1,T)$(DEDBIO(CTRY,LC1) EQ 1)+

        PARAM2(CTRY,LC1,'16')$(TROPINAC(CTRY,LC1) EQ 1);

PARAMETER RENTB(CTRY,LC1);
RENTB(CTRY,LC1)=PARAM2(CTRY,LC1,'17');

PARAMETER RENTAF(CTRY,LC1);
RENTAF(CTRY,LC1) = SUM[T$(FINT(T)),RENTA(CTRY,LC1,T)$(FINT(T))];

PARAMETER RENTZ(CTRY,LC1,T);
RENTZ(CTRY,LC1,T) = PARAM2(CTRY,LC1,'18')*(1/RNTSHFT(CTRY,LC1,T));

PARAMETER RENTHA(CTRY,LC1,T);
RENTHA(CTRY,LC1,T) =
{[RENTZ(CTRY,LC1,T)/RENTA(CTRY,LC1,T)]**RENTB(CTRY,LC1)}$(TROPINAC(CTRY,LC1) EQ 1);

DISPLAY RENTA,RENTZ,RENTHA;


$ONTEXT;
FINPTEL adjusts parameter that affects the elasticity of management inputs in forestry to account for technology change.  Currently assume 0.3% per decade growth in elasticity
$OFFTEXT;

PARAMETER FINPTEL(CTRY,LC1,T);
FINPTEL(CTRY,LC1,'1')$(R1FOR(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(R1FOR(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

FINPTEL(CTRY,LC1,'1')$(DEDBIO(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'9');
LOOP[T,FINPTEL(CTRY,LC1,T+1)$(DEDBIO(CTRY,LC1) EQ 1)=
                FINPTEL(CTRY,LC1,T)*(1.003)];

DISPLAY FINPTEL;

PARAMETER FINPTELF(CTRY,LC1);
FINPTELF(CTRY,LC1) = SUM[T$(FINT(T)),FINPTEL(CTRY,LC1,T)$(FINT(T))];

DISPLAY FINPTELF;


*adjusted growth change to reflect effects estimated in Davis et al. (2021)

PARAMETER CHG1(CTRY,LC1,T,DATA);

CHG1(CTRY,LC1,T,DATA)=0;

CHG1(CTRY,LC1,'1','1')=0.072;
*adjust down for Russia and Canada
CHG1('4',LC1,'1','1')=0.035;
CHG1('5',LC1,'1','1')=0.035;


LOOP(T,CHG1(CTRY,LC1,T+1,'1') = CHG1(CTRY,LC1,T,'1')+
CHG1(CTRY,LC1,'1','1')*(EXP(-.15*(ORD(T)))));

*CHG1(CTRY,LC1,'1','1')$(ORD(T) LT 5)

*Generate forest yield functions
* GINIT = decadal forest growth
* note that these include adjustments to forest growth to account for climate change through CHG1, but
* those parameters are set to 0 in the baseline.
PARAMETER GINIT1(CTRY,LC1,A1,T);
GINIT1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*

                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*Also decadal growth
PARAMETER GROWTH1(CTRY,LC1,A1,T);
GROWTH1(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = 0$(ORD(A1) LT PARAM2(CTRY,LC1,'3')) +
                0$(ORD(A1) EQ PARAM2(CTRY,LC1,'3')) +

                SUM(TT,(1+CHG1(CTRY,LC1,T,'1'))*
                ((PARAM2(CTRY,LC1,'2')/(((ORD(A1)-PARAM2(CTRY,LC1,'3')-1)*10+
                                ORD(TT)-.5)**2))*
                EXP(PARAM2(CTRY,LC1,'1')-PARAM2(CTRY,LC1,'2')/((ORD(A1) -
                                PARAM2(CTRY,LC1,'3')-1)*10 +
                ORD(TT)-.5))))$(ORD(A1) GT PARAM2(CTRY,LC1,'3'));

*initial age class growth in each time period
PARAMETER YINIT1(CTRY,LC1,A1,T);
YINIT1(CTRY,LC1,'1',T) = GINIT1(CTRY,LC1,'1',T);
LOOP(A1,YINIT1(CTRY,LC1,A1+1,T) = YINIT1(CTRY,LC1,A1,T) + GINIT1(CTRY,LC1,A1+1,T));

DISPLAY GINIT1,YINIT1;

*YIELD2 is growth function, summed over decadal growth
PARAMETER YIELD2(CTRY,LC1,A1,T) yield function;

YIELD2(CTRY,LC1,A1,T) = YINIT1(CTRY,LC1,A1,T)$TFIRST(T);
YIELD2(CTRY,LC1,A1,T)$AFIRST1(A1) = GROWTH1(CTRY,LC1,A1,T)$AFIRST1(A1);
LOOP(T,LOOP(A1,YIELD2(CTRY,LC1,A1+1,T+1)=YIELD2(CTRY,LC1,A1,T)+
        GROWTH1(CTRY,LC1,A1+1,T+1)));

*create YIELDORIG(CTRY,LC1,A1,T) which is used later for carbon calculations
* Use YIELD2 divided by quality adjustment parameter
PARAMETER YIELDORIG(CTRY,LC1,A1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

*Quality adjustment  accounts for value differences across logs from different regions.
YIELD2(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T)*PARAM3(CTRY,LC1,'4');


DISPLAY YIELD2;

*Add in underlying productivity changes in yields for productive species
*original method of shifting yields
*these are 6% per decade for many plantation types
PARAMETER YDGRTH(CTRY,LC1,T);
YDGRTH(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH(CTRY,LC1,T+1) = YDGRTH(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)*
       (.99**[(ORD(T)-1)*10]))$(PARAM3(CTRY,LC1,'1') EQ 1)+
(PARAM3(CTRY,LC1,'9'))*YDGRTH(CTRY,LC1,T)$(PARAM3(CTRY,LC1,'1') EQ 0)
);

PARAMETER YDGRTH2(CTRY,LC1,T);
YDGRTH2(CTRY,LC1,'1') = 1;

LOOP(T,YDGRTH2(CTRY,LC1,T+1) = YDGRTH2(CTRY,LC1,T) +
((PARAM3(CTRY,LC1,'9'))*YDGRTH2(CTRY,LC1,T)*(.99**[(ORD(T)-1)*10])));


YIELD2(CTRY,LC1,A1,T)= YIELD2(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);
YIELDORIG(CTRY,LC1,A1,T) = YIELDORIG(CTRY,LC1,A1,T)*YDGRTH(CTRY,LC1,T);

DISPLAY YDGRTH, YIELD2;


*Technology change adjustment for merchantable timber out of biomass stock
*Not included in this version; assumed to be 0
PARAMETER TSWCHG(CTRY,LC1);
TSWCHG(CTRY,LC1) = 0;

PARAMETER MXSWTM(CTRY,LC1,T);
MXSWTM(CTRY,LC1,'1')$(ALLIN(CTRY,LC1) EQ 1)=
        PARAM2(CTRY,LC1,'4')$(ALLIN(CTRY,LC1) EQ 1);
LOOP[T,MXSWTM(CTRY,LC1,T+1) $(ALLIN(CTRY,LC1) EQ 1) =
        MXSWTM(CTRY,LC1,T)*(1+ TSWCHG(CTRY,LC1))];


$ONTEXT;
 The following routines adjust the yield function to account for the merchantable proportion of stock
 on each hectare.
The final result below takes the original yield function from above and multiplies by a factor that adjusts the biomass on site for the proportion that is merchantable, depending on the age class.

YIELD2 = YIELD2*SWPERC2A

$OFFTEXT;

PARAMETER SWGRTH(CTRY,LC1);
SWGRTH(CTRY,LC1) =2.0$(PARAM2(CTRY,LC1,'11') EQ 1)+
1.0$( PARAM2(CTRY,LC1,'11') EQ 2)+
0.9$( PARAM2(CTRY,LC1,'11') EQ 3)+
0.6$( PARAM2(CTRY,LC1,'11') EQ 4)+
0.5$( PARAM2(CTRY,LC1,'11') GT 4);


PARAMETER SWPERC2A(CTRY,LC1,A1,T);
SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=

{MXSWTM(CTRY,LC1,T)*[1-EXP((-0.4/(PARAM2(CTRY,LC1,'11')*10-ORD(A1)*10+10))*
(ORD(A1)*10))]**2}$(ORD(A1) LT PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))+

{MXSWTM(CTRY,LC1,T)*[1-EXP((-SWGRTH(CTRY,LC1)/10)*
(ORD(A1)*10))]**2}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*AGETR age to start counting sawtimber quantity
PARAMETER AGETR(CTRY,LC1);
AGETR(CTRY,LC1) = PARAM2(CTRY,LC1,'6');

*SWPC2A shifts SWPERC2A up by the number of decades in AGETR.
PARAMETER SWPC2A(CTRY,LC1,A1,T);
LOOP[A1,SWPC2A(CTRY,LC1,A1,T) = 0$(ORD(A1) LT AGETR(CTRY,LC1)) +
       0$(ORD(A1) EQ AGETR(CTRY,LC1))+
       SWPERC2A(CTRY,LC1,A1-AGETR(CTRY,LC1),T)$(ORD(A1) GT AGETR(CTRY,LC1))];

DISPLAY SWPC2A;

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=SWPC2A(CTRY,LC1,A1,T);

SWPERC2A(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1) = MIN[SWPERC2A(CTRY,LC1,A1,T),10];

YIELD2(CTRY,LC1,A1,T)$(ALLIN(CTRY,LC1) EQ 1)=YIELD2(CTRY,LC1,A1,T)*SWPERC2A(CTRY,LC1,A1,T);

DISPLAY SWPERC2A, YIELD2;

PARAMETER YIELD2F(CTRY,LC1,A1);
YIELD2F(CTRY,LC1,A1)=SUM[T$(FINT(T)),YIELD2(CTRY,LC1,A1,T)$(FINT(T))];

*create inaccessible yield functions  already adjusted for merch proportion
PARAMETER YLDINAC(CTRY,LC1,A1,T);
YLDINAC(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

execute_unload "GLOBALTIMBERMODEL_01_2022.gdx"

*Estimate terminal values

*a discount factor
PARAMETER DELTA1(CTRY,LC1);
DELTA1(CTRY,LC1) = 1/[(1-EXP(-R*PARAM2(CTRY,LC1,'11')*10))$(ALLIN(CTRY,LC1) EQ 1) +
                                1$(ALLIN(CTRY,LC1) EQ 0)];

*Estimate terminal management values
PARAMETER MNG1(CTRY,LC1);
MNG1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
SUM(A1,{[{[(1/(1+R))**(-PARAM2(CTRY,LC1,'11')*10)]*

(1/((PTERM - PARAM2(CTRY,LC1,'10')$(ALLIN(CTRY,LC1) EQ 1))*
PARAM2(CTRY,LC1,'8')$(ALLIN(CTRY,LC1) EQ 1)*FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)*
        YIELD2F(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)+EPSILON))}**(1/( FINPTELF(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1))]
-1}$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

MNG1(CTRY,LC1) = MAX[MNG1(CTRY,LC1),0];

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[MNG1(CTRY,LC1),MANT];

DISPLAY MNG1, MNG1A;


*alternate calculation of MNG1/A
PARAMETER ZIM1(CTRY,LC1);
ZIM1(CTRY,LC1)=0;
LOOP(CTRY,
LOOP[LC1$(ALLIN(CTRY,LC1) EQ 1),
WHILE(

SUM{A1,[(1+R)**(-10*ORD(A1))]*(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
        (ZIM1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))}


GT 1,

ZIM1(CTRY,LC1)= ZIM1(CTRY,LC1)+1);
]
)
;

PARAMETER MNG1A(CTRY,LC1);
MNG1A(CTRY,LC1)=MIN[ZIM1(CTRY,LC1),MANT];
MNG1(CTRY,LC1) = MNG1A(CTRY,LC1);

*determine rotation age and net present values

PARAMETER NC1(CTRY,LC1,A1);
NC1(CTRY,LC1,A1)=0;
PARAMETER NPVCS1(CTRY,LC1,AC1);
NPVCS1(CTRY,LC1,AC1)=0;

PARAMETER NPVSS1(CTRY,LC1,A1);
NPVSS1(CTRY,LC1,A1) =
{(PTERM - PARAM2(CTRY,LC1,'10'))*
        {(PARAM2(CTRY,LC1,'8')*(MNG1A(CTRY,LC1)+1+EPSILON)** FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)*((1+R)**(-ORD(A1)*10))}+
        SUM(AC1,NPVCS1(CTRY,LC1,AC1)$(ORD(AC1) EQ ORD(A1)))
        - MNG1A(CTRY,LC1)}/{1-((1+R)**(-ORD(A1)*10))};

DISPLAY NPVSS1;

PARAMETER NPVT1;

PARAMETER NPVT2

PARAMETER TMAGE1(CTRY,LC1);
TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = 1;

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
LOOP(A1, NPVT1=NPVSS1(CTRY,LC1,A1);
        NPVT2 = NPVSS1(CTRY,LC1,A1+1);


IF (NPVT1<NPVT2, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSEIF (NPVT1=NPVT2), TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)+1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1));
        );
IF (NPVT1 <0, TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1)-1;
        ELSE TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) ;
        );
        );
      );

DISPLAY TMAGE1;
PARAM2(CTRY,LC1,'11')$(ALLIN(CTRY,LC1) EQ 1)=TMAGE1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1);


*Determine SS area of accessible forests
*calculate decadal rental value
PARAMETER PVADDA1(CTRY,LC1);
PVADDA1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) =
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]-
        SUM[A1,NPVSS1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))]/(1+R);

PARAMETER TFINAC1(CTRY,LC1);
TFINAC1(CTRY,LC1)$(R1FOR(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

TFINAC1(CTRY,LC1)$(TROPINAC(CTRY,LC1) EQ 1) =
        [PVADDA1(CTRY,LC1)/RENTAF(CTRY,LC1)]**RENTB(CTRY,LC1);

DISPLAY PVADDA1,TFINAC1;

TFINAC1(CTRY,LC1)$(ALLIN(CTRY,LC1) EQ 1) = TFINAC1(CTRY,LC1)/PARAM2(CTRY,LC1,'11');

PARAMETER FINAC1(CTRY,LC1,A1);
FINAC1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        TFINAC1(CTRY,LC1)$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1));

LOOP(CTRY,
LOOP(LC1$(ALLIN(CTRY,LC1) EQ 1),
       IF((PARAM2(CTRY,LC1,'11')) = 15,
       LOOP[A1, FINAC1(CTRY,LC1,A1) = 0$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')))+
       TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11')$(ORD(A1) EQ (PARAM2(CTRY,LC1,'11')))];
        ELSE LOOP(A1,
       IF (ORD(A1)< (PARAM2(CTRY,LC1,'11')+1),
                FINAC1(CTRY,LC1,A1) = TFINAC1(CTRY,LC1);
                ELSE FINAC1(CTRY,LC1,A1) =0;
       ););
        );
);
);

TFINAC1(CTRY,LC1)=TFINAC1(CTRY,LC1)*PARAM2(CTRY,LC1,'11');

DISPLAY TFINAC1,FINAC1;

*Estimate Terminal Conditions
PARAMETER ALPHAK1(CTRY,LC1,A1);

ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);

PARAMETER ALPHA1(CTRY,LC1);
ALPHA1(CTRY,LC1)=SUM(A1,ALPHAK1(CTRY,LC1,A1)$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));

DISPLAY ALPHAK1,ALPHA1;

PARAMETER ALPHAK1(CTRY,LC1,A1);
ALPHAK1(CTRY,LC1,A1) = (PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*(MNG1(CTRY,LC1)+1+EPSILON)**FINPTELF(CTRY,LC1))*
        YIELD2F(CTRY,LC1,A1)-MNG1A(CTRY,LC1);


PARAMETER BETA1(CTRY,LC1);
BETA1(CTRY,LC1) = SUM(A1, [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11')));
DISPLAY BETA1;

BETA1(CTRY,LC1) =0;
LOOP{A1,

BETA1(CTRY,LC1) = BETA1(CTRY,LC1)+
        [(PTERM - PARAM2(CTRY,LC1,'10'))*
        (PARAM2(CTRY,LC1,'8')*FINPTELF(CTRY,LC1)*
       (MNG1(CTRY,LC1)+1+EPSILON)**(FINPTELF(CTRY,LC1)-1))*
        YIELD2F(CTRY,LC1,A1)]$(ORD(A1) EQ PARAM2(CTRY,LC1,'11'))
};


DISPLAY MNG1,BETA1;

*LAMBDA1 is actual terminal condition in $/ha for each age class
PARAMETER LAMBDA1(CTRY,LC1,A1);
LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) = {[(1/(1+R))**([PARAM2(CTRY,LC1,'11') - ORD(A1)]*10)]*
        DELTA1(CTRY,LC1)*ALPHA1(CTRY,LC1)}$(ORD(A1) LT (PARAM2(CTRY,LC1,'11')+1)) +
       {(DELTA1(CTRY,LC1)-1)*ALPHA1(CTRY,LC1) + ALPHAK1(CTRY,LC1,A1)}$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

LAMBDA1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1)=
LAMBDA1(CTRY,LC1,A1)$(ORD(A1) LT PARAM2(CTRY,LC1,'11')+1)+
0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));

*PSI1 is actual terminal condition for $ spent on management
PARAMETER PSI1(CTRY,LC1,A1);
PSI1(CTRY,LC1,A1)$(ALLIN(CTRY,LC1) EQ 1) =
        {[(1/(1+R))**([PARAM2(CTRY,LC1,'11')-ORD(A1)]*10)]*BETA1(CTRY,LC1)}$(ORD(A1)
       LT (PARAM2(CTRY,LC1,'11')+1)) + 0$(ORD(A1) GT PARAM2(CTRY,LC1,'11'));


DISPLAY LAMBDA1,PSI1;

*set upper and lower bounds on management intensity
IMGMT1.LO(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*0;
IMGMT1.UP(CTRY,LC1,T) = MTFIN1(CTRY,LC1,'1')*4;
MGMT1.LO(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*0;
MGMT1.UP(CTRY,LC1,A1,T) = MTFIN1(CTRY,LC1,'1')*4;

YACRE2.LO(CTRY,LC1,A1,T) = FORINV2(CTRY,LC1,A1)*0;
YACRE2.UP(CTRY,LC1,A1,T) = 10000;

YACRE2.LO(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;
YACRE2.UP(CTRY,LC1,A1,T)$(YACRE2ZERO(CTRY,LC1) EQ 1) = 0;

MXFORA=10;

PROPPULP.UP(CTRY,LC1 ,T) =1;

*create option file
FILE BBBM4 /MINOS.OPT/;
  PUT BBBM4;
          PUT 'superbasics limit = 10000'/;
  PUTCLOSE BBBM4;

DYNFONLYM.WORKSPACE = 900;

DYNFONLYM.OPTFILE = 1;
DYNFONLYM.SCALEOPT= 1;

MGMT1.SCALE(CTRY,LC1,A1,T)=10;

BENFOR1.SCALE =1000000;
NPVFOR1.SCALE =1000000;

SOLVE DYNFONLYM USING NLP MAXIMIZING NPVFOR1;

* PLACES ALL OUTPUT TO A GDX FILE
execute_unload "GTM_Leakage_Calibration.gdx";






