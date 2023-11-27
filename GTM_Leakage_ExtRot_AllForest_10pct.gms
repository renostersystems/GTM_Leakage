$ONTEXT;
Code originally written by B. Sohngen, sohngen.1@osu.edu
Code edited by A. Daigneault, adam.daigneault@maine.edu

Developed for leakage analysis, November 2023

This file runs the leakage model scenario for extended rotations
Need to restart from: GTM_Leakage_Calibration.g00

LEAKAGE SCENARIO: All accessible forests eligible with 10% implementation rate

$OFFTEXT;

****************************************
*Set forest carbon project implementation rate
Scalar ImpRate /0.1/;
****************************************

****************************************
*Specify Forest Types to Include in Forest Projects, and level of implementation
****************************************
PARAMETERS
FOROUTP(CTRY,LC1)                Aggregate forest types

*Tropical Plantations
FOROUTP_BrazPlant(CTRY,LC1)    Brazil Plantation
FOROUTP_SAsiaPlant(CTRY,LC1)    S Asia Plantation
FOROUTP_CAmerPlant(CTRY,LC1)    C. America Plantation
FOROUTP_RoSAPlant(CTRY,LC1)    R of S. America Plantation
FOROUTP_SSAFPlant(CTRY,LC1)    Sub Saharan Africa Plantation
FOROUTP_SEAsiaPlant(CTRY,LC1)    SE Asia Plantation
FOROUTP_AFMEPlant(CTRY,LC1)    Africa Middle East Plantation

*Temperate Plantations
FOROUTP_USPlant(CTRY,LC1)    USA Plantation
FOROUTP_ChinaPlant(CTRY,LC1)    China Plantation
FOROUTP_EUPlant(CTRY,LC1)    EU Plantation
FOROUTP_OceaniaPlant(CTRY,LC1)    Oceania Plantation
FOROUTP_JapanPlant(CTRY,LC1)    Japan Plantation

*Boreal Plantations
FOROUTP_EUNordPlant(CTRY,LC1)  EU Nordic Plantation

*Tropical Natural
FOROUTP_BrazNat(CTRY,LC1)    Brazil Natural
FOROUTP_SAsiaNat(CTRY,LC1)  South Asia Natural
FOROUTP_CAmerNat(CTRY,LC1)    Central America Natural
FOROUTP_RoSANat(CTRY,LC1)    Rest of S. America Natural
FOROUTP_SSAFNat(CTRY,LC1)    Sub Saharan Africa Natural
FOROUTP_SEAsiaNat(CTRY,LC1)    SE Asia Natural
FOROUTP_OceaniaTropNat(CTRY,LC1)    Oceania Natural
FOROUTP_AFMENat(CTRY,LC1)    Africa - Middle East Natural

*Temperate Natural
FOROUTP_USNat(CTRY,LC1)    USA Natural
FOROUTP_ChinaNat(CTRY,LC1)    China Natural
FOROUTP_CanTempNat(CTRY,LC1)    Canada Natural
FOROUTP_RusTempNat(CTRY,LC1)    Russia Natural
FOROUTP_EUNat(CTRY,LC1)    EU Annex I Natural
FOROUTP_EUNonNat(CTRY,LC1)    EU Non-annex Natural I
FOROUTP_OceaniaTempNat(CTRY,LC1)    Oceania Natural
FOROUTP_JapanNat(CTRY,LC1)    Japan Natural

*Boreal Natural
FOROUTP_CanBorealNat(CTRY,LC1)    Canada
FOROUTP_RusBorealNat(CTRY,LC1)    Russia
FOROUTP_EUBorealNat(CTRY,LC1)    EU Non-Annex I
;

*Country, forest type, and implementation rate
*Tropical Plantation
FOROUTP_BrazPlant (CTRY,LC1)$(ORD(CTRY) EQ 3) =   ImpRate$(ORD(LC1) EQ 1);
FOROUTP_SAsiaPlant (CTRY,LC1)$(ORD(CTRY) EQ 8) =   ImpRate$(ORD(LC1) EQ 1);
FOROUTP_CAmerPlant (CTRY,LC1)$(ORD(CTRY) EQ 9) =   ImpRate$(ORD(LC1) EQ 1);
FOROUTP_RoSAPlant (CTRY,LC1)$(ORD(CTRY) EQ 10) =  ImpRate$(ORD(LC1) EQ 1);
FOROUTP_SSAFPlant (CTRY,LC1)$(ORD(CTRY) EQ 11) =  ImpRate$(ORD(LC1) EQ 1);
FOROUTP_SEAsiaPlant (CTRY,LC1)$(ORD(CTRY) EQ 12) =  ImpRate$(ORD(LC1) EQ 1);
FOROUTP_AFMEPlant (CTRY,LC1)$(ORD(CTRY) EQ 15) =  ImpRate$(ORD(LC1) EQ 1);

*Temperate Plantation
FOROUTP_USPlant (CTRY,LC1)$(ORD(CTRY) EQ 1) =   ImpRate$(ORD(LC1) EQ 1) + ImpRate$(ORD(LC1) EQ 4)+ ImpRate$(ORD(LC1) EQ 15);
FOROUTP_ChinaPlant (CTRY,LC1)$(ORD(CTRY) EQ 2) =   ImpRate$(ORD(LC1) EQ 1) + ImpRate$(ORD(LC1) EQ 3);
FOROUTP_EUPlant (CTRY,LC1)$(ORD(CTRY) EQ 6) =   ImpRate$(ORD(LC1) EQ 2) + ImpRate$(ORD(LC1) EQ 3)+ ImpRate$(ORD(LC1) EQ 4)+ImpRate$(ORD(LC1) EQ 5);
FOROUTP_OceaniaPlant (CTRY,LC1)$(ORD(CTRY) EQ 13) =  ImpRate$(ORD(LC1) EQ 1);
FOROUTP_JapanPlant (CTRY,LC1)$(ORD(CTRY) EQ 14) =  ImpRate$(ORD(LC1) EQ 1);

*Boreal Plantation
FOROUTP_EUNordPlant(CTRY,LC1)$(ORD(CTRY) EQ 6) =  ImpRate$(ORD(LC1) EQ 1);

*Tropical Natural
FOROUTP_BrazNat(CTRY,LC1)$(ORD(CTRY) EQ 3) =   ImpRate$(ORD(LC1) EQ 3) + ImpRate$(ORD(LC1) EQ 4);
FOROUTP_SAsiaNat(CTRY,LC1)$(ORD(CTRY) EQ 8) =   ImpRate$(ORD(LC1) EQ 4);
FOROUTP_CAmerNat(CTRY,LC1)$(ORD(CTRY) EQ 9) =   ImpRate$(ORD(LC1) EQ 3) + ImpRate$(ORD(LC1) EQ 4) + ImpRate$(ORD(LC1) EQ 5);
FOROUTP_RoSANat(CTRY,LC1)$(ORD(CTRY) EQ 10) =  ImpRate$(ORD(LC1) EQ 3) + ImpRate$(ORD(LC1) EQ 4) + ImpRate$(ORD(LC1) EQ 5);
FOROUTP_SSAFNat(CTRY,LC1)$(ORD(CTRY) EQ 11) =  ImpRate$(ORD(LC1) EQ 3) + ImpRate$(ORD(LC1) EQ 4);
FOROUTP_SEAsiaNat(CTRY,LC1)$(ORD(CTRY) EQ 12) =  ImpRate$(ORD(LC1) EQ 3) + ImpRate$(ORD(LC1) EQ 4) + ImpRate$(ORD(LC1) EQ 5);
FOROUTP_OceaniaTropNat(CTRY,LC1)$(ORD(CTRY) EQ 13) =  ImpRate$(ORD(LC1) EQ 4) + ImpRate$(ORD(LC1) EQ 5);
FOROUTP_AFMENat(CTRY,LC1)$(ORD(CTRY) EQ 15) =  ImpRate$(ORD(LC1) EQ 3) + ImpRate$(ORD(LC1) EQ 4);

*Temperate Natural
FOROUTP_USNat(CTRY,LC1)$(ORD(CTRY) EQ 1) =   ImpRate$(ORD(LC1) EQ 2) + ImpRate$(ORD(LC1) EQ 3) + ImpRate$(ORD(LC1) EQ 5)+ ImpRate$(ORD(LC1) EQ 6)+ ImpRate$(ORD(LC1) EQ 7)
                                          + ImpRate$(ORD(LC1) EQ 8)+ ImpRate$(ORD(LC1) EQ 9)+ ImpRate$(ORD(LC1) EQ 10)+ ImpRate$(ORD(LC1) EQ 11)+ ImpRate$(ORD(LC1) EQ 12)
                                          + ImpRate$(ORD(LC1) EQ 13)+ ImpRate$(ORD(LC1) EQ 14)+ ImpRate$(ORD(LC1) EQ 16)+ ImpRate$(ORD(LC1) EQ 17)+ ImpRate$(ORD(LC1) EQ 18)
                                          + ImpRate$(ORD(LC1) EQ 19)+ ImpRate$(ORD(LC1) EQ 20)+ ImpRate$(ORD(LC1) EQ 21)+ ImpRate$(ORD(LC1) EQ 22);
FOROUTP_ChinaNat(CTRY,LC1)$(ORD(CTRY) EQ 2) =   ImpRate$(ORD(LC1) EQ 2) + ImpRate$(ORD(LC1) EQ 4) +ImpRate$(ORD(LC1) EQ 5) +ImpRate$(ORD(LC1) EQ 6) ;
FOROUTP_CanTempNat(CTRY,LC1)$(ORD(CTRY) EQ 4) =   ImpRate$(ORD(LC1) EQ 1) + ImpRate$(ORD(LC1) EQ 2)+ ImpRate$(ORD(LC1) EQ 3)
                                                 + ImpRate$(ORD(LC1) EQ 16)+ ImpRate$(ORD(LC1) EQ 17)+ ImpRate$(ORD(LC1) EQ 18);
FOROUTP_RusTempNat(CTRY,LC1)$(ORD(CTRY) EQ 5) =   ImpRate$(ORD(LC1) EQ 6) + ImpRate$(ORD(LC1) EQ 7);
FOROUTP_EUNat(CTRY,LC1)$(ORD(CTRY) EQ 6) =   ImpRate$(ORD(LC1) EQ 7) + ImpRate$(ORD(LC1) EQ 8);
FOROUTP_EUNonNat(CTRY,LC1)$(ORD(CTRY) EQ 7) =   ImpRate$(ORD(LC1) EQ 1) + ImpRate$(ORD(LC1) EQ 2) + ImpRate$(ORD(LC1) EQ 3);
FOROUTP_OceaniaTempNat (CTRY,LC1)$(ORD(CTRY) EQ 13) =   ImpRate$(ORD(LC1) EQ 3);
FOROUTP_JapanNat(CTRY,LC1)$(ORD(CTRY) EQ 14) =   ImpRate$(ORD(LC1) EQ 2);

*Boreal Natural
FOROUTP_CanBorealNat(CTRY,LC1)$(ORD(CTRY) EQ 4) =   ImpRate$(ORD(LC1) EQ 4) + ImpRate$(ORD(LC1) EQ 5)+ ImpRate$(ORD(LC1) EQ 6)+ ImpRate$(ORD(LC1) EQ 7)+ ImpRate$(ORD(LC1) EQ 8)
                                         + ImpRate$(ORD(LC1) EQ 9)+ ImpRate$(ORD(LC1) EQ 10)+ ImpRate$(ORD(LC1) EQ 11)+ ImpRate$(ORD(LC1) EQ 12)
                                         + ImpRate$(ORD(LC1) EQ 13)+ ImpRate$(ORD(LC1) EQ 14)+ ImpRate$(ORD(LC1) EQ 15);
FOROUTP_RusBorealNat(CTRY,LC1)$(ORD(CTRY) EQ 5) =   ImpRate$(ORD(LC1) EQ 1) + ImpRate$(ORD(LC1) EQ 2) + ImpRate$(ORD(LC1) EQ 3)+ ImpRate$(ORD(LC1) EQ 4) + ImpRate$(ORD(LC1) EQ 5);
FOROUTP_EUBorealNat(CTRY,LC1)$(ORD(CTRY) EQ 7) =   ImpRate$(ORD(LC1) EQ 4) ;


*Aggregate all eligible forest types
FOROUTP(CTRY,LC1) =

*Tropical Plantation
FOROUTP_BrazPlant(CTRY,LC1)     +
FOROUTP_SAsiaPlant(CTRY,LC1)    +
FOROUTP_CAmerPlant(CTRY,LC1) +
FOROUTP_RoSAPlant(CTRY,LC1)  +
FOROUTP_SSAFPlant(CTRY,LC1)   +
FOROUTP_SEAsiaPlant(CTRY,LC1)  +
FOROUTP_AFMEPlant(CTRY,LC1)  +

*Temperate Plantation
FOROUTP_USPlant(CTRY,LC1)    +
FOROUTP_ChinaPlant(CTRY,LC1)    +
FOROUTP_EUPlant(CTRY,LC1)    +
FOROUTP_OceaniaPlant(CTRY,LC1)    +
FOROUTP_JapanPlant(CTRY,LC1)    +

*Boreal Plantation
FOROUTP_EUNordPlant(CTRY,LC1) +

*Tropical Natural
FOROUTP_BrazNat(CTRY,LC1)    +
FOROUTP_SAsiaNat(CTRY,LC1)   +
FOROUTP_CAmerNat(CTRY,LC1)   +
FOROUTP_RoSANat(CTRY,LC1)    +
FOROUTP_SSAFNat(CTRY,LC1)    +
FOROUTP_SEAsiaNat(CTRY,LC1)   +
FOROUTP_OceaniaTropNat(CTRY,LC1) +
FOROUTP_AFMENat(CTRY,LC1)    +

*Temperate Natural
FOROUTP_USNat(CTRY,LC1)    +
FOROUTP_ChinaNat(CTRY,LC1)    +
FOROUTP_CanTempNat(CTRY,LC1)    +
FOROUTP_RusTempNat(CTRY,LC1)    +
FOROUTP_EUNat(CTRY,LC1)    +
FOROUTP_EUNonNat(CTRY,LC1)    +
FOROUTP_OceaniaTempNat(CTRY,LC1)    +
FOROUTP_JapanNat(CTRY,LC1)    +

*Boreal Natural
FOROUTP_CanBorealNat(CTRY,LC1)    +
FOROUTP_RusBorealNat(CTRY,LC1)    +
FOROUTP_EUBorealNat(CTRY,LC1)
;
****************************************
*Specify eligible forest types
****************************************

PARAMETERS
FOROUT(CTRY,LC1)                Aggregate forest types

*Tropical Plantations
FOROUT_BrazPlant(CTRY,LC1)    Brazil Plantation
FOROUT_SAsiaPlant(CTRY,LC1)    S Asia Plantation
FOROUT_CAmerPlant(CTRY,LC1)    C. America Plantation
FOROUT_RoSAPlant(CTRY,LC1)    R of S. America Plantation
FOROUT_SSAFPlant(CTRY,LC1)    Sub Saharan Africa Plantation
FOROUT_SEAsiaPlant(CTRY,LC1)    SE Asia Plantation
FOROUT_AFMEPlant(CTRY,LC1)    Africa Middle East Plantation

*Temperate Plantations
FOROUT_USPlant(CTRY,LC1)    USA Plantation
FOROUT_ChinaPlant(CTRY,LC1)    China Plantation
FOROUT_EUPlant(CTRY,LC1)    EU Plantation
FOROUT_OceaniaPlant(CTRY,LC1)    Oceania Plantation
FOROUT_JapanPlant(CTRY,LC1)    Japan Plantation

*Boreal Plantations
FOROUT_EUNordPlant(CTRY,LC1)  EU Nordic Plantation

*Tropical Natural
FOROUT_BrazNat(CTRY,LC1)    Brazil Natural
FOROUT_SAsiaNat(CTRY,LC1)  South Asia Natural
FOROUT_CAmerNat(CTRY,LC1)    Central America Natural
FOROUT_RoSANat(CTRY,LC1)    Rest of S. America Natural
FOROUT_SSAFNat(CTRY,LC1)    Sub Saharan Africa Natural
FOROUT_SEAsiaNat(CTRY,LC1)    SE Asia Natural
FOROUT_OceaniaTropNat(CTRY,LC1)    Oceania Natural
FOROUT_AFMENat(CTRY,LC1)    Africa - Middle East Natural

*Temperate Natural
FOROUT_USNat(CTRY,LC1)    USA Natural
FOROUT_ChinaNat(CTRY,LC1)    China Natural
FOROUT_CanTempNat(CTRY,LC1)    Canada Natural
FOROUT_RusTempNat(CTRY,LC1)    Russia Natural
FOROUT_EUNat(CTRY,LC1)    EU Annex I Natural
FOROUT_EUNonNat(CTRY,LC1)    EU Non-annex Natural I
FOROUT_OceaniaTempNat(CTRY,LC1)    Oceania Natural
FOROUT_JapanNat(CTRY,LC1)    Japan Natural

*Boreal Natural
FOROUT_CanBorealNat(CTRY,LC1)    Canada
FOROUT_RusBorealNat(CTRY,LC1)    Russia
FOROUT_EUBorealNat(CTRY,LC1)    EU Non-Annex I
;

*Tropical Plantation
FOROUT_BrazPlant (CTRY,LC1)$(ORD(CTRY) EQ 3) =   1$(ORD(LC1) EQ 1);
FOROUT_SAsiaPlant (CTRY,LC1)$(ORD(CTRY) EQ 8) =   1$(ORD(LC1) EQ 1);
FOROUT_CAmerPlant (CTRY,LC1)$(ORD(CTRY) EQ 9) =   1$(ORD(LC1) EQ 1);
FOROUT_RoSAPlant (CTRY,LC1)$(ORD(CTRY) EQ 10) =  1$(ORD(LC1) EQ 1);
FOROUT_SSAFPlant (CTRY,LC1)$(ORD(CTRY) EQ 11) =  1$(ORD(LC1) EQ 1);
FOROUT_SEAsiaPlant (CTRY,LC1)$(ORD(CTRY) EQ 12) =  1$(ORD(LC1) EQ 1);
FOROUT_AFMEPlant (CTRY,LC1)$(ORD(CTRY) EQ 15) =  1$(ORD(LC1) EQ 1);

*Temperate Plantation
FOROUT_USPlant (CTRY,LC1)$(ORD(CTRY) EQ 1) =   1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 4)+ 1$(ORD(LC1) EQ 15);
FOROUT_ChinaPlant (CTRY,LC1)$(ORD(CTRY) EQ 2) =   1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 3);
FOROUT_EUPlant (CTRY,LC1)$(ORD(CTRY) EQ 6) =   1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 3)+ 1$(ORD(LC1) EQ 4)+1$(ORD(LC1) EQ 5);
FOROUT_OceaniaPlant (CTRY,LC1)$(ORD(CTRY) EQ 13) =  1$(ORD(LC1) EQ 1);
FOROUT_JapanPlant (CTRY,LC1)$(ORD(CTRY) EQ 14) =  1$(ORD(LC1) EQ 1);

*Boreal Plantation
FOROUT_EUNordPlant(CTRY,LC1)$(ORD(CTRY) EQ 6) =  1$(ORD(LC1) EQ 1);

*Tropical Natural
FOROUT_BrazNat(CTRY,LC1)$(ORD(CTRY) EQ 3) =   1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 4);
FOROUT_SAsiaNat(CTRY,LC1)$(ORD(CTRY) EQ 8) =   1$(ORD(LC1) EQ 4);
FOROUT_CAmerNat (CTRY,LC1)$(ORD(CTRY) EQ 9) =   1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 5);
FOROUT_RoSANat (CTRY,LC1)$(ORD(CTRY) EQ 10) =  1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 5);
FOROUT_SSAFNat (CTRY,LC1)$(ORD(CTRY) EQ 11) =  1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 4);
FOROUT_SEAsiaNat (CTRY,LC1)$(ORD(CTRY) EQ 12) =  1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 5);
FOROUT_OceaniaTropNat (CTRY,LC1)$(ORD(CTRY) EQ 13) =  1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 5);
FOROUT_AFMENat (CTRY,LC1)$(ORD(CTRY) EQ 15) =  1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 4);

*Temperate Natural
FOROUT_USNat(CTRY,LC1)$(ORD(CTRY) EQ 1) =   1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 5)+ 1$(ORD(LC1) EQ 6)+ 1$(ORD(LC1) EQ 7)
                                          + 1$(ORD(LC1) EQ 8)+ 1$(ORD(LC1) EQ 9)+ 1$(ORD(LC1) EQ 10)+ 1$(ORD(LC1) EQ 11)+ 1$(ORD(LC1) EQ 12)
                                          + 1$(ORD(LC1) EQ 13)+ 1$(ORD(LC1) EQ 14)+ 1$(ORD(LC1) EQ 16)+ 1$(ORD(LC1) EQ 17)+ 1$(ORD(LC1) EQ 18)
                                          + 1$(ORD(LC1) EQ 19)+ 1$(ORD(LC1) EQ 20)+ 1$(ORD(LC1) EQ 21)+ 1$(ORD(LC1) EQ 22);

FOROUT_ChinaNat(CTRY,LC1)$(ORD(CTRY) EQ 2) =   1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 4) +1$(ORD(LC1) EQ 5) +1$(ORD(LC1) EQ 6) ;
FOROUT_CanTempNat(CTRY,LC1)$(ORD(CTRY) EQ 4) =   1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 2)+ 1$(ORD(LC1) EQ 3)
                                          + 1$(ORD(LC1) EQ 16)+ 1$(ORD(LC1) EQ 17)+ 1$(ORD(LC1) EQ 18);
FOROUT_RusTempNat(CTRY,LC1)$(ORD(CTRY) EQ 5) =   1$(ORD(LC1) EQ 6) + 1$(ORD(LC1) EQ 7);
FOROUT_EUNat(CTRY,LC1)$(ORD(CTRY) EQ 6) =   1$(ORD(LC1) EQ 7) + 1$(ORD(LC1) EQ 8);
FOROUT_EUNonNat(CTRY,LC1)$(ORD(CTRY) EQ 7) =   1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 3);
FOROUT_OceaniaTempNat (CTRY,LC1)$(ORD(CTRY) EQ 13) =   1$(ORD(LC1) EQ 3);
FOROUT_JapanNat(CTRY,LC1)$(ORD(CTRY) EQ 14) =   1$(ORD(LC1) EQ 2);

*Boreal Natural
FOROUT_CanBorealNat(CTRY,LC1)$(ORD(CTRY) EQ 4) =   1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 5)+ 1$(ORD(LC1) EQ 6)+ 1$(ORD(LC1) EQ 7)+ 1$(ORD(LC1) EQ 8)
                                         + 1$(ORD(LC1) EQ 9)+ 1$(ORD(LC1) EQ 10)+ 1$(ORD(LC1) EQ 11)+ 1$(ORD(LC1) EQ 12)
                                         + 1$(ORD(LC1) EQ 13)+ 1$(ORD(LC1) EQ 14)+ 1$(ORD(LC1) EQ 15);
FOROUT_RusBorealNat(CTRY,LC1)$(ORD(CTRY) EQ 5) =   1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 3)+ 1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 5);
FOROUT_EUBorealNat(CTRY,LC1)$(ORD(CTRY) EQ 7) =   1$(ORD(LC1) EQ 4) ;

*Aggregate all eligible forest types
FOROUT(CTRY,LC1) =

*Tropical Plantation
FOROUT_BrazPlant(CTRY,LC1)     +
FOROUT_SAsiaPlant(CTRY,LC1)    +
FOROUT_CAmerPlant(CTRY,LC1) +
FOROUT_RoSAPlant(CTRY,LC1)  +
FOROUT_SSAFPlant(CTRY,LC1)   +
FOROUT_SEAsiaPlant(CTRY,LC1)  +
FOROUT_AFMEPlant(CTRY,LC1)  +

*Temperate Plantation
FOROUT_USPlant(CTRY,LC1)    +
FOROUT_ChinaPlant(CTRY,LC1)    +
FOROUT_EUPlant(CTRY,LC1)    +
FOROUT_OceaniaPlant(CTRY,LC1)    +
FOROUT_JapanPlant(CTRY,LC1)    +

*Boreal Plantation
FOROUT_EUNordPlant(CTRY,LC1) +

*Tropical Natural
FOROUT_BrazNat(CTRY,LC1)    +
FOROUT_SAsiaNat(CTRY,LC1)   +
FOROUT_CAmerNat(CTRY,LC1)   +
FOROUT_RoSANat(CTRY,LC1)    +
FOROUT_SSAFNat(CTRY,LC1)    +
FOROUT_SEAsiaNat(CTRY,LC1)   +
FOROUT_OceaniaTropNat(CTRY,LC1) +
FOROUT_AFMENat(CTRY,LC1)    +

*Temperate Natural
FOROUT_USNat(CTRY,LC1)    +
FOROUT_ChinaNat(CTRY,LC1)    +
FOROUT_CanTempNat(CTRY,LC1)    +
FOROUT_RusTempNat(CTRY,LC1)    +
FOROUT_EUNat(CTRY,LC1)    +
FOROUT_EUNonNat(CTRY,LC1)    +
FOROUT_OceaniaTempNat(CTRY,LC1)    +
FOROUT_JapanNat(CTRY,LC1)    +

*Boreal Natural
FOROUT_CanBorealNat(CTRY,LC1)    +
FOROUT_RusBorealNat(CTRY,LC1)    +
FOROUT_EUBorealNat(CTRY,LC1)
;




$ONTEXT;
This section calculates shifts in the rental functions to account for exogenous changes in demand for alternative uses of land
$OFFTEXT;

*Bringing in baseline estimates of management investment
PARAMETER MTINITX(CTRY,LC1,A1);
MTINITX(CTRY,LC1,A1) = MTINIT(CTRY,LC1,A1);

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

GRENTB =0.3;
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

*Quality adjustment – accounts for value differences across logs from different regions.
YIELD2(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T)*PARAM3(CTRY,LC1,'4');


DISPLAY YIELD2;

*Add in underlying productivity changes in yields for productive species
*original method of shifting yields
*these are 6% per decade for many plantation types, and 3% per decade for others following
* estimates in Scholze et al. (2006)
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

*create inaccessible yield functions – already adjusted for merch proportion
PARAMETER YLDINAC(CTRY,LC1,A1,T);
YLDINAC(CTRY,LC1,A1,T) = YIELD2(CTRY,LC1,A1,T);

execute_unload "GTM_EPA2021_LEAKAGE_Rot10pct_AllForestt1.gdx";

*Estimate terminal values
PTERM =130;
MANT=10000;

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

PARAMETER CPOLICY(CTRY,LC1,A1);
CPOLICY(CTRY,LC1,A1)= FORINV2(CTRY,LC1,A1)*FOROUTP(CTRY,LC1);

FORINV2(CTRY,LC1,A1)= FORINV2(CTRY,LC1,A1)-CPOLICY(CTRY,LC1,A1);


POSITIVE VARIABLES
        YACRE2L(CTRY,LC1,A1,T)
        ACHR2L(CTRY,LC1,A1,T)
        ACPL2L(CTRY,LC1,T);

EQUATIONS
        MOTION11L(CTRY,LC1,A1,T)
        LEAKLIMIT(CTRY,LC1,A1,T)
        LEAKAREA(CTRY,LC1,T)
        TFORESTAREA2(T)
        BENFOR2;



*equation of motion for accessible timberland
MOTION11L(CTRY,LC1,A1,T)$(FOROUT(CTRY,LC1) EQ 1)..
YACRE2L(CTRY,LC1,A1,T)$(FOROUT(CTRY,LC1) EQ 1) =E= YACRE2L(CTRY,LC1,A1-1,T-1) - ACHR2L(CTRY,LC1,A1-1,T-1) +
ACPL2L(CTRY,LC1,T-1)$AFIRST1(A1) +
CPOLICY(CTRY,LC1,A1)$TFIRST(T) +
YACRE2L(CTRY,LC1,A1,T-1)$ALAST1(A1) - ACHR2L(CTRY,LC1,A1,T-1)$ALAST1(A1);

LEAKLIMIT(CTRY,LC1,A1,T)$(FOROUT(CTRY,LC1) EQ 1)..
ACHR2L(CTRY,LC1,A1,T)$(ORD(A1) LT 8) =E= 0;

LEAKAREA(CTRY,LC1,T) $(FOROUT(CTRY,LC1) EQ 1).. SUM(A1,YACRE2L(CTRY,LC1,A1,T)) =E= SUM(A1,CPOLICY(CTRY,LC1,A1));

*Calculating Net Surplus for the forestry only scenario
BENFOR2.. NPVFOR1 =E= SUM(T$YEAR(T),RHO(T)*[

*benefit from sawtimber production
[AFS(T)**(1/BF)]*[1/((-1/BF)+1)]*

{( SUM(CTRY,

*accessible timber - with proportion going to Biomass
SUM[LC1$(R1FOR(CTRY,LC1) EQ 1),
SUM(A1,
(1-PROPPULP(CTRY,LC1,T)+EPSILON)*
(ACHR2(CTRY,LC1,A1,T)+ ACHR2L(CTRY,LC1,A1,T)+EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
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

*tropical inacessible – harvest
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
(ACHR2(CTRY,LC1,A1,T)+ACHR2L(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*PARAM2(CTRY,LC1,'8')*
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

*tropical inacessible – harvest
SUM[LC1$(TROPINAC(CTRY,LC1) EQ 1),
        (PROPPULP(CTRY,LC1 ,T) +EPSILON)*PARAM2(CTRY,LC1,'8')*
       SUM(A1,(ACHRIN1(CTRY,LC1,A1,T) +EPSILON)*YLDINAC(CTRY,LC1,A1,T))]+

EPSILON) + EPSILON)**((-1/BF)+1)}$YEAR(T)

-[AFP(T)**(1/BF)]*[1/((-1/BF)+1)]*{CONSTFO**((-1/BF)+1)}$YEAR(T)

*costs of sawtimber production on accessible lands
-(
SUM(CTRY,SUM(LC1,

(1-PROPPULP(CTRY,LC1,T) +EPSILON)*
CSA(CTRY,LC1,'1')*SUM(A1,(ACHR2(CTRY,LC1,A1,T) + ACHR2L(CTRY,LC1,A1,T)+EPSILON )*YIELD2(CTRY,LC1,A1,T)*
PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(R1FOR(CTRY,LC1) EQ 1)

+

[
{(1-PROPPULP(CTRY,LC1,T) +EPSILON)*SUM(A1,(ACHR2(CTRY,LC1,A1,T) + ACHR2L(CTRY,LC1,A1,T)+EPSILON)*YIELD2(CTRY,LC1,A1,T)*
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
CSA(CTRY,LC1,'5')*SUM(A1,(ACHR2(CTRY,LC1,A1,T) + ACHR2L(CTRY,LC1,A1,T) +EPSILON)*YIELD2(CTRY,LC1,A1,T)*
PARAM2(CTRY,LC1,'8')*((1+MGMT1(CTRY,LC1,A1,T))**FINPTEL(CTRY,LC1,T)))$(R1FOR(CTRY,LC1) EQ 1)

+
[
{(PROPPULP(CTRY,LC1,T)+EPSILON)*
SUM(A1,(ACHR2(CTRY,LC1,A1,T) + ACHR2L(CTRY,LC1,A1,T)  +EPSILON )*YIELD2(CTRY,LC1,A1,T)*
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
+SUM(CTRY,SUM(LC1$(R1FOR(CTRY,LC1) EQ 1),(IMGMT1(CTRY,LC1,T) +EPSILON)*(ACPL2(CTRY,LC1,T) + ACPL2L(CTRY,LC1,T)+EPSILON)))$YEAR(T)

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
SUM(A1,YACRE2(CTRY,LC1,A1,T)+ YACRE2L(CTRY,LC1,A1,T)+EPSILON)*
RENTA(CTRY,LC1,T)*
[(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)]*
         {SUM(A1,YACRE2(CTRY,LC1,A1,T) + YACRE2L(CTRY,LC1,A1,T)+ EPSILON)**(1/RENTB(CTRY,LC1))}
)

+
*accessible forests
SUM(LC1$(DEDBIO(CTRY,LC1) EQ 1),
SUM(A1,YACRE2(CTRY,LC1,A1,T) + YACRE2L(CTRY,LC1,A1,T)+EPSILON)*
[RENTZ(CTRY,LC1,T)*(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)+

RENTA(CTRY,LC1,T)*
[(EPSILON+(TOTALFOREST(T)/TOTALFOREST('1')))**(1/GRENTB)]*
         {SUM(A1,YACRE2(CTRY,LC1,A1,T) + YACRE2L(CTRY,LC1,A1,T)+EPSILON)**(1/RENTB(CTRY,LC1))}
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

TFORESTAREA2(T).. TOTALFOREST(T)=E=
        SUM(CTRY,SUM(LC1,SUM(A1,
        YACRE2(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)+
        YACRE2L(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)+
         YACRE2(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRE2(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRE2(CTRY,LC1,A1,T)$(DEDBIO(CTRY,LC1) EQ 1)+
         YACRE3(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRIN1(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRIN1(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1))

));

MTINIT(CTRY,LC1,A1) = MTINITX(CTRY,LC1,A1);


MODEL DYNFONLYMLEAK / MOTION11, MOTION11L, MOTSIN11, MOTIN11, MOTRPSIN1, MOTRPSIN2,MOTRPIN1,
MOTION21, MOTION11BIO, MOTION21BIO, REPSLIN1, REPDEDBIO, MAXFOR, MAXFORCTRY,  HARVEST1,HARVSIN1,HARVIN1,
HARVSIN2,HARVIN2, HARVEST1BIO , CUMAC1 ,TCHARV1,TCHARV2, BENFOR2, TFORESTAREA2, LEAKAREA
/;


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


****************************************
*Assigning Optimal Rotation Ages
****************************************
PARAMETERS

*Tropical Plantation
FORROT_BRA30(CTRY,LC1)
FORROT_SASIA60(CTRY,LC1)
FORROT_CAMER20(CTRY,LC1)
FORROT_RSAM20(CTRY,LC1)
FORROT_SSAF30(CTRY,LC1)
FORROT_SEASIA60(CTRY,LC1)
FORROT_AFME20(CTRY,LC1)

*Temperate and Boreal Plantation
FORROT_US30(CTRY,LC1)
FORROT_US50(CTRY,LC1)
FORROT_CHN30(CTRY,LC1)
FORROT_CHN40(CTRY,LC1)
FORROT_EU80(CTRY,LC1)   Also includes EU Nordic Plantation
FORROT_EU90(CTRY,LC1)
FORROT_EU110(CTRY,LC1)
FORROT_OCEANIA30(CTRY,LC1)
FORROT_JAPAN30(CTRY,LC1)

*Tropical Natural
FORROT_BRAZIL60(CTRY,LC1)
FORROT_BRAZIL70(CTRY,LC1)
FORROT_SASIA50(CTRY,LC1)
FORROT_CAMER60(CTRY,LC1)
FORROT_CAMER70(CTRY,LC1)
FORROT_RSAM60(CTRY,LC1)
FORROT_RSAM70(CTRY,LC1)
FORROT_SSAF60(CTRY,LC1)
FORROT_SEASIA50(CTRY,LC1)
FORROT_SEASIA60(CTRY,LC1)
FORROT_OCEANIA50(CTRY,LC1)
FORROT_AFME60(CTRY,LC1)

*Temperate Natural
FORROT_US60(CTRY,LC1)
FORROT_US70(CTRY,LC1)
FORROT_US80(CTRY,LC1)
FORROT_CHN50(CTRY,LC1)
FORROT_CHN80(CTRY,LC1)
FORROT_CHN90(CTRY,LC1)
FORROT_CAN60(CTRY,LC1)
FORROT_CAN70(CTRY,LC1)
FORROT_CAN80(CTRY,LC1)
FORROT_RUS110(CTRY,LC1)
FORROT_EU90(CTRY,LC1)
FORROT_EU100(CTRY,LC1)
FORROT_EUN80(CTRY,LC1)
FORROT_EUN90(CTRY,LC1)
FORROT_OCEANIA30(CTRY,LC1)
FORROT_JAPAN50(CTRY,LC1)

*Boreal Natural
FORROT_CAN70(CTRY,LC1)
FORROT_CAN80(CTRY,LC1)
FORROT_RUS100(CTRY,LC1)
FORROT_EUN50(CTRY,LC1)
;

*Assigning values
*Tropical Plantation Forests
FORROT_BRA30(CTRY,LC1)$(ORD(CTRY) EQ 3)     = 1$(ORD(LC1) EQ 1);
FORROT_SASIA60(CTRY,LC1)$(ORD(CTRY) EQ 8)   = 1$(ORD(LC1) EQ 1);
FORROT_CAMER20(CTRY,LC1)$(ORD(CTRY) EQ 9)   = 1$(ORD(LC1) EQ 1);
FORROT_RSAM20(CTRY,LC1)$(ORD(CTRY) EQ 10)   = 1$(ORD(LC1) EQ 1);
FORROT_SSAF30(CTRY,LC1)$(ORD(CTRY) EQ 11)   = 1$(ORD(LC1) EQ 1);
FORROT_SEASIA60(CTRY,LC1)$(ORD(CTRY) EQ 12) = 1$(ORD(LC1) EQ 1);
FORROT_AFME20(CTRY,LC1)$(ORD(CTRY) EQ 15)   = 1$(ORD(LC1) EQ 1);

*Temperate and Boreal Plantation Forests
FORROT_US30(CTRY,LC1)$(ORD(CTRY) EQ 1) = 1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 4);
FORROT_US50(CTRY,LC1)$(ORD(CTRY) EQ 1) = 1$(ORD(LC1) EQ 15);
FORROT_CHN30(CTRY,LC1)$(ORD(CTRY) EQ 2) = 1$(ORD(LC1) EQ 1);
FORROT_CHN40(CTRY,LC1)$(ORD(CTRY) EQ 2) = 1$(ORD(LC1) EQ 3);
FORROT_EU80(CTRY,LC1)$(ORD(CTRY) EQ 6) = 1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 5)  ;
FORROT_EU90(CTRY,LC1)$(ORD(CTRY) EQ 6) = 1$(ORD(LC1) EQ 4);
FORROT_EU110(CTRY,LC1)$(ORD(CTRY) EQ 6) = 1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 3);
FORROT_OCEANIA30(CTRY,LC1)$(ORD(CTRY) EQ 13) = 1$(ORD(LC1) EQ 1);
FORROT_JAPAN30(CTRY,LC1)$(ORD(CTRY) EQ 14) = 1$(ORD(LC1) EQ 1);

*Tropical Natural Forests
FORROT_BRAZIL60(CTRY,LC1)$(ORD(CTRY) EQ 3) = 1$(ORD(LC1) EQ 3);
FORROT_BRAZIL70(CTRY,LC1)$(ORD(CTRY) EQ 3) = 1$(ORD(LC1) EQ 4);
FORROT_SASIA50(CTRY,LC1)$(ORD(CTRY) EQ 8)   = 1$(ORD(LC1) EQ 4);
FORROT_CAMER60(CTRY,LC1)$(ORD(CTRY) EQ 9) = 1$(ORD(LC1) EQ 5);
FORROT_CAMER70(CTRY,LC1)$(ORD(CTRY) EQ 9) = 1$(ORD(LC1) EQ 3)+ 1$(ORD(LC1) EQ 4);
FORROT_RSAM60(CTRY,LC1)$(ORD(CTRY) EQ 10) = 1$(ORD(LC1) EQ 3);
FORROT_RSAM70(CTRY,LC1)$(ORD(CTRY) EQ 10) = 1$(ORD(LC1) EQ 4)+ 1$(ORD(LC1) EQ 5);
FORROT_SSAF60(CTRY,LC1)$(ORD(CTRY) EQ 11) = 1$(ORD(LC1) EQ 3)+ 1$(ORD(LC1) EQ 4);
FORROT_SEASIA50(CTRY,LC1)$(ORD(CTRY) EQ 12) = 1$(ORD(LC1) EQ 3);
FORROT_SEASIA60(CTRY,LC1)$(ORD(CTRY) EQ 12) = 1$(ORD(LC1) EQ 4)+ 1$(ORD(LC1) EQ 5);
FORROT_OCEANIA50(CTRY,LC1)$(ORD(CTRY) EQ 13) = 1$(ORD(LC1) EQ 4)+ 1$(ORD(LC1) EQ 5);
FORROT_AFME60(CTRY,LC1)$(ORD(CTRY) EQ 15) = 1$(ORD(LC1) EQ 3)+ 1$(ORD(LC1) EQ 4);

*Temperate Natural
FORROT_US60(CTRY,LC1)$(ORD(CTRY) EQ 1) = 1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 3) + 1$(ORD(LC1) EQ 5) + 1$(ORD(LC1) EQ 6);
FORROT_US70(CTRY,LC1)$(ORD(CTRY) EQ 1) = 1$(ORD(LC1) EQ 7)+ 1$(ORD(LC1) EQ 8) + 1$(ORD(LC1) EQ 9) + 1$(ORD(LC1) EQ 11)
                                         + 1$(ORD(LC1) EQ 12) + 1$(ORD(LC1) EQ 13)+ 1$(ORD(LC1) EQ 20)+ 1$(ORD(LC1) EQ 21)+ 1$(ORD(LC1) EQ 22);
FORROT_US80(CTRY,LC1)$(ORD(CTRY) EQ 1) = 1$(ORD(LC1) EQ 10)  + 1$(ORD(LC1) EQ 14)+ 1$(ORD(LC1) EQ 16)+ 1$(ORD(LC1) EQ 17)+ 1$(ORD(LC1) EQ 18)
                                          + 1$(ORD(LC1) EQ 19);
FORROT_CHN50(CTRY,LC1)$(ORD(CTRY) EQ 2) = 1$(ORD(LC1) EQ 2);
FORROT_CHN80(CTRY,LC1)$(ORD(CTRY) EQ 2) = 1$(ORD(LC1) EQ 4);
FORROT_CHN90(CTRY,LC1)$(ORD(CTRY) EQ 2) = 1$(ORD(LC1) EQ 5)+ 1$(ORD(LC1) EQ 6);

FORROT_CAN60(CTRY,LC1)$(ORD(CTRY) EQ 4) = 1$(ORD(LC1) EQ 2)  + 1$(ORD(LC1) EQ 17);
FORROT_CAN70(CTRY,LC1)$(ORD(CTRY) EQ 4) = 1$(ORD(LC1) EQ 16) + 1$(ORD(LC1) EQ 18);
FORROT_CAN80(CTRY,LC1)$(ORD(CTRY) EQ 4) = 1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 3);
FORROT_RUS110(CTRY,LC1)$(ORD(CTRY) EQ 5) = 1$(ORD(LC1) EQ 6) + 1$(ORD(LC1) EQ 7);
FORROT_EU90(CTRY,LC1)$(ORD(CTRY) EQ 6) =  1$(ORD(LC1) EQ 7);
FORROT_EU100(CTRY,LC1)$(ORD(CTRY) EQ 6) = 1$(ORD(LC1) EQ 8);
FORROT_EUN80(CTRY,LC1)$(ORD(CTRY) EQ 7) = 1$(ORD(LC1) EQ 2);
FORROT_EUN90(CTRY,LC1)$(ORD(CTRY) EQ 7) = 1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 3);
FORROT_OCEANIA30(CTRY,LC1)$(ORD(CTRY) EQ 13) = 1$(ORD(LC1) EQ 3);
FORROT_JAPAN50(CTRY,LC1)$(ORD(CTRY) EQ 14) = 1$(ORD(LC1) EQ 2);

*Boreal Natural
FORROT_CAN70(CTRY,LC1)$(ORD(CTRY) EQ 4) = 1$(ORD(LC1) EQ 5);
FORROT_CAN80(CTRY,LC1)$(ORD(CTRY) EQ 4) =  1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 6)+ 1$(ORD(LC1) EQ 7)+ 1$(ORD(LC1) EQ 8)
                                         + 1$(ORD(LC1) EQ 9)+ 1$(ORD(LC1) EQ 10)+ 1$(ORD(LC1) EQ 11)+ 1$(ORD(LC1) EQ 12)
                                         + 1$(ORD(LC1) EQ 13)+ 1$(ORD(LC1) EQ 14)+ 1$(ORD(LC1) EQ 15);
FORROT_RUS100(CTRY,LC1)$(ORD(CTRY) EQ 5) = 1$(ORD(LC1) EQ 1) + 1$(ORD(LC1) EQ 2) + 1$(ORD(LC1) EQ 3)+ 1$(ORD(LC1) EQ 4) + 1$(ORD(LC1) EQ 5);
FORROT_EUN50(CTRY,LC1)$(ORD(CTRY) EQ 7) =  1$(ORD(LC1) EQ 4) ;

***************************
*Set Project Implementation Rate
***************************
*Tropical Plantations
***************************
YACRE2L.L('3','1',A1,T)  = ImpRate*YACRE2.L('3','1',A1,T);
YACRE2L.L('8','1',A1,T)  = ImpRate*YACRE2.L('8','1',A1,T);
YACRE2L.L('9','1',A1,T)  = ImpRate*YACRE2.L('9','1',A1,T);
YACRE2L.L('10','1',A1,T) = ImpRate*YACRE2.L('10','1',A1,T);
YACRE2L.L('11','1',A1,T) = ImpRate*YACRE2.L('11','1',A1,T);
YACRE2L.L('12','1',A1,T) = ImpRate*YACRE2.L('12','1',A1,T);
YACRE2L.L('15','1',A1,T) = ImpRate*YACRE2.L('15','1',A1,T);
***************************
*Temperate Plantations
***************************
YACRE2L.L('1','1',A1,T) = ImpRate*YACRE2.L('1','1',A1,T);
YACRE2L.L('1','4',A1,T) = ImpRate*YACRE2.L('1','4',A1,T);
YACRE2L.L('1','15',A1,T)= ImpRate*YACRE2.L('1','15',A1,T);
YACRE2L.L('2','1',A1,T) = ImpRate*YACRE2.L('2','1',A1,T);
YACRE2L.L('2','3',A1,T) = ImpRate*YACRE2.L('2','3',A1,T);
YACRE2L.L('6','2',A1,T) = ImpRate*YACRE2.L('6','2',A1,T);
YACRE2L.L('6','3',A1,T) = ImpRate*YACRE2.L('6','3',A1,T);
YACRE2L.L('6','4',A1,T) = ImpRate*YACRE2.L('6','4',A1,T);
YACRE2L.L('6','5',A1,T) = ImpRate*YACRE2.L('6','5',A1,T);
YACRE2L.L('13','1',A1,T)= ImpRate*YACRE2.L('13','1',A1,T);
YACRE2L.L('14','1',A1,T)= ImpRate*YACRE2.L('14','1',A1,T);
***************************
*Boreal Plantations
***************************
YACRE2L.L('6','1',A1,T) = ImpRate*YACRE2.L('6','1',A1,T);
***************************
*Tropical Natural
***************************
YACRE2L.L('3','3',A1,T) = ImpRate*YACRE2.L('3','3',A1,T);
YACRE2L.L('3','4',A1,T) = ImpRate*YACRE2.L('3','4',A1,T);
YACRE2L.L('8','4',A1,T) = ImpRate*YACRE2.L('8','4',A1,T);
YACRE2L.L('9','3',A1,T) = ImpRate*YACRE2.L('9','3',A1,T);
YACRE2L.L('9','4',A1,T) = ImpRate*YACRE2.L('9','4',A1,T);
YACRE2L.L('9','5',A1,T) = ImpRate*YACRE2.L('9','5',A1,T);
YACRE2L.L('10','3',A1,T) = ImpRate*YACRE2.L('10','3',A1,T);
YACRE2L.L('10','4',A1,T) = ImpRate*YACRE2.L('10','4',A1,T);
YACRE2L.L('10','5',A1,T) = ImpRate*YACRE2.L('10','5',A1,T);
YACRE2L.L('11','3',A1,T) = ImpRate*YACRE2.L('11','3',A1,T);
YACRE2L.L('11','4',A1,T) = ImpRate*YACRE2.L('11','4',A1,T);
YACRE2L.L('12','3',A1,T) = ImpRate*YACRE2.L('12','3',A1,T);
YACRE2L.L('12','4',A1,T) = ImpRate*YACRE2.L('12','4',A1,T);
YACRE2L.L('12','5',A1,T) = ImpRate*YACRE2.L('12','5',A1,T);
YACRE2L.L('13','4',A1,T) = ImpRate*YACRE2.L('13','4',A1,T);
YACRE2L.L('13','5',A1,T) = ImpRate*YACRE2.L('13','5',A1,T);
YACRE2L.L('15','3',A1,T) = ImpRate*YACRE2.L('15','3',A1,T);
YACRE2L.L('15','4',A1,T) = ImpRate*YACRE2.L('15','4',A1,T);
***************************
*Temperate Natural
***************************
YACRE2L.L('1','2',A1,T) = ImpRate*YACRE2.L('1','2',A1,T);
YACRE2L.L('1','3',A1,T) = ImpRate*YACRE2.L('1','3',A1,T);
YACRE2L.L('1','5',A1,T) = ImpRate*YACRE2.L('1','5',A1,T);
YACRE2L.L('1','6',A1,T) = ImpRate*YACRE2.L('1','6',A1,T);
YACRE2L.L('1','7',A1,T) = ImpRate*YACRE2.L('1','7',A1,T);
YACRE2L.L('1','8',A1,T) = ImpRate*YACRE2.L('1','8',A1,T);
YACRE2L.L('1','9',A1,T) = ImpRate*YACRE2.L('1','9',A1,T);
YACRE2L.L('1','10',A1,T) = ImpRate*YACRE2.L('1','10',A1,T);
YACRE2L.L('1','11',A1,T) = ImpRate*YACRE2.L('1','11',A1,T);
YACRE2L.L('1','12',A1,T) = ImpRate*YACRE2.L('1','12',A1,T);
YACRE2L.L('1','13',A1,T) = ImpRate*YACRE2.L('1','13',A1,T);
YACRE2L.L('1','14',A1,T) = ImpRate*YACRE2.L('1','14',A1,T);
YACRE2L.L('1','16',A1,T) = ImpRate*YACRE2.L('1','16',A1,T);
YACRE2L.L('1','17',A1,T) = ImpRate*YACRE2.L('1','17',A1,T);
YACRE2L.L('1','18',A1,T) = ImpRate*YACRE2.L('1','18',A1,T);
YACRE2L.L('1','19',A1,T) = ImpRate*YACRE2.L('1','19',A1,T);
YACRE2L.L('1','20',A1,T) = ImpRate*YACRE2.L('1','20',A1,T);
YACRE2L.L('1','21',A1,T) = ImpRate*YACRE2.L('1','21',A1,T);
YACRE2L.L('1','22',A1,T) = ImpRate*YACRE2.L('1','22',A1,T);

YACRE2L.L('2','2',A1,T) = ImpRate*YACRE2.L('2','2',A1,T);
YACRE2L.L('2','4',A1,T) = ImpRate*YACRE2.L('2','4',A1,T);
YACRE2L.L('2','5',A1,T) = ImpRate*YACRE2.L('2','5',A1,T);
YACRE2L.L('2','6',A1,T) = ImpRate*YACRE2.L('2','6',A1,T);

YACRE2L.L('4','1',A1,T) = ImpRate*YACRE2.L('4','1',A1,T);
YACRE2L.L('4','2',A1,T) = ImpRate*YACRE2.L('4','2',A1,T);
YACRE2L.L('4','3',A1,T) = ImpRate*YACRE2.L('4','3',A1,T);
YACRE2L.L('4','16',A1,T) = ImpRate*YACRE2.L('4','16',A1,T);
YACRE2L.L('4','17',A1,T) = ImpRate*YACRE2.L('4','17',A1,T);
YACRE2L.L('4','18',A1,T) = ImpRate*YACRE2.L('4','18',A1,T);

YACRE2L.L('5','6',A1,T) = ImpRate*YACRE2.L('5','6',A1,T);
YACRE2L.L('5','7',A1,T) = ImpRate*YACRE2.L('5','7',A1,T);

YACRE2L.L('6','7',A1,T) = ImpRate*YACRE2.L('6','7',A1,T);
YACRE2L.L('6','8',A1,T) = ImpRate*YACRE2.L('6','8',A1,T);

YACRE2L.L('7','1',A1,T) = ImpRate*YACRE2.L('7','1',A1,T);
YACRE2L.L('7','2',A1,T) = ImpRate*YACRE2.L('7','2',A1,T);
YACRE2L.L('7','3',A1,T) = ImpRate*YACRE2.L('7','3',A1,T);

YACRE2L.L('13','3',A1,T) = ImpRate*YACRE2.L('13','3',A1,T);

YACRE2L.L('14','2',A1,T) = ImpRate*YACRE2.L('14','2',A1,T);
***************************
*Boreal Natural
***************************
YACRE2L.L('4','4',A1,T) = ImpRate*YACRE2.L('4','4',A1,T);
YACRE2L.L('4','5',A1,T) = ImpRate*YACRE2.L('4','5',A1,T);
YACRE2L.L('4','6',A1,T) = ImpRate*YACRE2.L('4','6',A1,T);
YACRE2L.L('4','7',A1,T) = ImpRate*YACRE2.L('4','7',A1,T);
YACRE2L.L('4','8',A1,T) = ImpRate*YACRE2.L('4','8',A1,T);
YACRE2L.L('4','9',A1,T) = ImpRate*YACRE2.L('4','9',A1,T);
YACRE2L.L('4','10',A1,T) = ImpRate*YACRE2.L('4','10',A1,T);
YACRE2L.L('4','11',A1,T) = ImpRate*YACRE2.L('4','11',A1,T);
YACRE2L.L('4','12',A1,T) = ImpRate*YACRE2.L('4','12',A1,T);
YACRE2L.L('4','13',A1,T) = ImpRate*YACRE2.L('4','13',A1,T);
YACRE2L.L('4','14',A1,T) = ImpRate*YACRE2.L('4','14',A1,T);
YACRE2L.L('4','15',A1,T) = ImpRate*YACRE2.L('4','15',A1,T);

YACRE2L.L('5','1',A1,T) = ImpRate*YACRE2.L('5','1',A1,T);
YACRE2L.L('5','2',A1,T) = ImpRate*YACRE2.L('5','2',A1,T);
YACRE2L.L('5','3',A1,T) = ImpRate*YACRE2.L('5','3',A1,T);
YACRE2L.L('5','4',A1,T) = ImpRate*YACRE2.L('5','4',A1,T);
YACRE2L.L('5','5',A1,T) = ImpRate*YACRE2.L('5','5',A1,T);

YACRE2L.L('7','4',A1,T) = ImpRate*YACRE2.L('7','4',A1,T);

***************************

***************************
ACHR2L.L(CTRY,LC1,A1,T) = 0;

YACRE2L.FX(CTRY,LC1,A1,T)$(FOROUT(CTRY,LC1) EQ 0)=0;
ACHR2L.FX(CTRY,LC1,A1,T)$(FOROUT(CTRY,LC1) EQ 0) = 0;
***************************

***************************
*Setting all project land to be in set-asides (no harvest area regardless of age)
*ACHR2L.UP(CTRY,LC1,A1,T)$(FOROUT(CTRY,LC1) EQ 1) = 0;
***************************

*Setting rotation age constraints - don't need to do for set asides
*$ontext
*Tropical Plantations
ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_BRA30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_BRA30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_BRA30(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_SASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_SASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_SASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_SASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_SASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_SASIA60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAMER20(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAMER20(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_RSAM20(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_RSAM20(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_SSAF30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_SSAF30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_SSAF30(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_AFME20(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_AFME20(CTRY,LC1) EQ 1) = 0;

*Temperate Plantations
ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_US30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_US30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_US30(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_US50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_US50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_US50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_US50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_US50(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CHN30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CHN30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CHN30(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CHN40(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CHN40(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CHN40(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CHN40(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_EU80(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'10',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'11',T)$(FORROT_EU110(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_OCEANIA30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_OCEANIA30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_OCEANIA30(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_JAPAN30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_JAPAN30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_JAPAN30(CTRY,LC1) EQ 1) = 0;

*Boreal Plantations
ACHR2L.UP(CTRY,LC1,'1',T)$(FOROUT_EUNordPlant(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FOROUT_EUNordPlant (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FOROUT_EUNordPlant (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FOROUT_EUNordPlant(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FOROUT_EUNordPlant(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FOROUT_EUNordPlant(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FOROUT_EUNordPlant(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FOROUT_EUNordPlant(CTRY,LC1) EQ 1) = 0;

*Tropical Natural
ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_BRAZIL60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_BRAZIL60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_BRAZIL60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_BRAZIL60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_BRAZIL60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_BRAZIL60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_BRAZIL70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_BRAZIL70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_BRAZIL70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_BRAZIL70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_BRAZIL70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_BRAZIL70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_BRAZIL70(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_SASIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_SASIA50 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_SASIA50 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_SASIA50 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_SASIA50 (CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAMER60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAMER60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CAMER60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CAMER60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CAMER60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CAMER60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAMER70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAMER70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CAMER70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CAMER70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CAMER70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CAMER70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_CAMER70(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_RSAM60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_RSAM60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_RSAM60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_RSAM60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_RSAM60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_RSAM60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_RSAM70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_RSAM70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_RSAM70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_RSAM70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_RSAM70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_RSAM70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_RSAM70(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_SSAF60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_SSAF60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_SSAF60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_SSAF60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_SSAF60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_SSAF60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_SEASIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_SEASIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_SEASIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_SEASIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_SEASIA50(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_SEASIA60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_OCEANIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_OCEANIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_OCEANIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_OCEANIA50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_OCEANIA50(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_AFME60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_AFME60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_AFME60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_AFME60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_AFME60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_AFME60(CTRY,LC1) EQ 1) = 0;

*Temperate Natural
ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_US60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_US60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_US60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_US60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_US60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_US60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_US70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_US70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_US70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_US70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_US70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_US70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_US70(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_US80(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CHN50 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CHN50 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CHN50 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CHN50 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CHN50 (CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_CHN80 (CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_CHN90 (CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAN60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAN60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CAN60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CAN60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CAN60(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CAN60(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'10',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'11',T)$(FORROT_RUS110 (CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_EU90(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'10',T)$(FORROT_EU100(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_EUN80(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_EUN90(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_OCEANIA30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_OCEANIA30(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_OCEANIA30(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_JAPAN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_JAPAN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_JAPAN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_JAPAN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_JAPAN50(CTRY,LC1) EQ 1) = 0;

*Boreal Natural
ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_CAN70(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_CAN80(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'6',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'7',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'8',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'9',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'10',T)$(FORROT_RUS100(CTRY,LC1) EQ 1) = 0;

ACHR2L.UP(CTRY,LC1,'1',T)$(FORROT_EUN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'2',T)$(FORROT_EUN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'3',T)$(FORROT_EUN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'4',T)$(FORROT_EUN50(CTRY,LC1) EQ 1) = 0;
ACHR2L.UP(CTRY,LC1,'5',T)$(FORROT_EUN50(CTRY,LC1) EQ 1) = 0;
*$offtext



TOTALFOREST.L(T) = SUM(CTRY,SUM(LC1,SUM(A1,
         YACRE2.L(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)+
         YACRE2L.L(CTRY,LC1,A1,T)$(R1FOR(CTRY,LC1) EQ 1)+
         YACRE2.L(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRE2.L(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRE3.L(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1)+
         YACRIN1.L(CTRY,LC1,A1,T)$(TEMPINAC(CTRY,LC1) EQ 1)+
         YACRIN1.L(CTRY,LC1,A1,T)$(TROPINAC(CTRY,LC1) EQ 1))
));

PROPPULP.UP(CTRY,LC1 ,T) =1;

$ontext;
*create option file
FILE BBBM2 /MINOS.OPT/;
  PUT BBBM2;
          PUT 'superbasics limit = 20000'/;
  PUTCLOSE BBBM2;
$offtext;

DYNFONLYMLEAK.WORKSPACE = 2000;

DYNFONLYMLEAK.OPTFILE = 1;
DYNFONLYMLEAK.SCALEOPT= 1;

MGMT1.SCALE(CTRY,LC1,A1,T)=10;

BENFOR2.SCALE =1000000;
NPVFOR1.SCALE =1000000;

*NPVFOR1.UP = 1E10;

SOLVE DYNFONLYMLEAK USING NLP MAXIMIZING NPVFOR1;

* PLACES ALL OUTPUT TO A GDX FILE
execute_unload "GTM_Leakage_ExtRot_AllForest_10pct.gdx";

