# GTM Leakage Code Details
This file provides information on the code used in the following paper:
Daigneault, A., B. Sohngen, E. Belair, P.W. Ellis. (2024). A Global Assessment of Regional Forest Carbon Leakage. Preprint available at:  https://www.researchsquare.com

## Overview
The GitHub repository contains code for the Global Timber Model (GTM) programmed for the General Algebraic Modeling System (GAMS). Specifically, it contains the original model calibration, baseline, and scenario code (.gms files), the parameter sets used to run that code (.csv files), and code to generate model output.  The scenarios in this paper were run using GAMS 29.1.0 using a series of ‘save’ and ‘restart’ commands and solved using the MINOS solver. Note that running the code in other versions of GAMS might generate slightly different estimates. 

## Documentation
Details on GTM’s model framework and data can be found in the methods and supplemental materials sections of this paper, or at: https://u.osu.edu/forest/code-repository/ 

## System Requirements
### Hardware Requirements
GTM requires a standard computer with enough RAM to support the in-memory operations. 

### Software Requirements
The Global Timber Model (GTM) is programmed for the General Algebraic Modeling System (GAMS). The non-linear programming model is solved using the MINOS solver.  

### License Requirements
Both GAMS and the MINOS solver require licenses to run GTM, available at: www.gams.com  

## Running GTM
The GTM calibration, baseline, and scenarios are sequentially run via .gms and .csv files using a series of ‘save’ and ‘restart’ commands.

### Model Data
GTM forest area, growth, yield, and carbon data are collected at the regional and forest type level from a number of sources. They are input to the model as a series of .csv files. 

### Step 1: Initial Calibration
The model calibration can be run using the file: GTM_Leakage_Calibration.gms. 
Other required files include: param2_010722.csv, param3_010722.csv, param4_010722.csv, cparam_010722.csv, forinv2_010722.csv, and iforin2_010722.csv

This step should be run via the GAMS command and saved as s = GTM_Leakage_Calibration.g00

### Step 2: Baseline
The model baseline can be run using the file: GTM_Leakage_Base.gms. 

This step should be run via the GAMS command as a restart and save: r = GTM_Leakage_Calibration.g00 s = GTM_Leakage_Calibration.g00 

### Step 3: Forest Carbon Project Scenarios
The model’s forest carbon project scenarios can be run using the file: GTM_Leakage_ScenX.gms 

This step should be run via the GAMS command as a restart and save: r = GTM_Leakage_Calibration.g00 s = GTM_Leakage_ScenX.g00 
where ScenX represents the i) Forest carbon project scenario (ExtRot, SetAside), ii) Forest type enrolled in carbon project (e.g., AllForest), and iii) Project implementation rate (e.g., 10%) 

### Step 4: Model Output
Baseline model output can be generated using the file: GTM_Leakage_Base_output.gms. 
Other required files include: FOROUT_ScenX, cparam_012822.csv, ANNSLASHC.csv, QFPLC.csv, QFSLC.csv

This step should be run via the GAMS command as a restart: r = GTM_Leakage_Base.g00

Scenario model output can be generated using the file:  GTM_Leakage_Scen_output.gms. 
Other required files include: cparam_012822.csv, ANNSLASHC.csv, QFPLC.csv, QFSLC.csv 

This step should be run via the GAMS command as a restart: r = GTM_Leakage_ScenX.g00

## Leakage Analysis Data and Output
A summary of key input data and output estimates for the GTM leakage analysis can be found in: Leakage_AllOutput_Nov2024.xlsx

## Contact Info
Please refer all questions about the code to Adam Daigneault (adam.daigneault@maine.edu) or Brent Sohngen (Sohngen.1@osu.edu) 
