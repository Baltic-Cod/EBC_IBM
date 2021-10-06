# Growth experiment

This experiment reproduces the wet-lab experiments of:<br>
Chabot and Dutil - Reduced growth of Atlantic cod in non-lethal hypoxic conditions; <br>
DOI: 10.1111/j.1095-8649.1999.tb00693.x <br>
as a simulation experiment


**Purpose:**<br>
The purpose of the experiment is validation of the modelled cod for oxygen dependent growth.


**Model:** 'Basic_ex.mlrj'<br>
The model is the Basic physiology.


**Simulation Experiment:** 'Basic_ex.scala'<br>
The simulation experiment scans for six oxygen saturations (45,56,65,75,84,93)%. The experiment runs 20 replications for each setup. <br>
If you wish to run the experiment:
* download the folder, 
* rename or delete result folder (result_xxx - software is not authorised to write over exsting folder)
* double click on 'run.bat' (windwos) or 'run.sh' (linux). 
You will have to have Java installed.


**R-script:** 'Basic_ex_eval.R'<br>
Results of the wet-lab experiment are included in the R-script provided for evaluation of simulation experiments.


**Results:**<br>
Figure 'Basic_ex_weight.png' shows gain in weight for different treatments. <br>
Figure 'Basic_ex_length.png' shows gain in length for different treatments. <br>
Figure 'Basic_ex_cf.png' shows gain in condition for different treatments. 
