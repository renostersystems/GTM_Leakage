# GTM_Leakage
This file provides information on the code used in the following paper:
Daigneault, A., B. Sohngen, E. Belair, P.W. Ellis. (2023). A Global Assessment of Regional Forest Carbon Leakage. Preprint available at:  https://www.researchsquare.com/article/rs-3596881/v1 

Please refer all questions about the code to Adam Daigneault (adam.daigneault@maine.edu) or Brent Sohngen (Sohngen.1@osu.edu) 

The GitHub repository contains code for the Global Timber Model (GTM) programmed for the General Algebraic Modeling System (GAMS). Specifically, it contains the original model calibration, baseline, and scenario code (.gms files), the parameter sets used to run that code (.csv files), and code to generate model output.  The scenarios in this paper were run using GAMS 29.1.0 using a series of ‘save’ and ‘restart’ commands. Note that running the code in other version of GAMS might generate slightly different estimates. 

The model calibration, baseline, and scenarios can be run using the following steps:
1.  GTM_Leakage_Calibration.gms (save as GTM_Leakage_Calibration.g00)
2. GTM_Leakage_Base.gms (restart GTM_Leakage_Calibration.g00, save as GTM_Leakage_Base.g00)
3. GTM_Leakage_ScenX.gms (restart GTM_Leakage_Calibration.g00, save as GTM_Leakage_ScenX.g00)

Model output can be generated using the following steps:
1. GTM_Leakage_Base_output.gms (restart GTM_Leakage_Base.g00)
2. GTM_Leakage_Scen_output.gms (restart GTM_Leakage_ScenX.g00)
