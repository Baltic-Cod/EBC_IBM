# Growth experiment with variable food intake

This experiment is based on the wet-lab experiments of:<br>
Chabot and Dutil - Reduced growth of Atlantic cod in non-lethal hypoxic conditions; <br>
DOI: 10.1111/j.1095-8649.1999.tb00693.x


**Purpose:**<br>
The purpose of the experiment is investigating growth of the modelled cod for oxygen and food intake dependent growth.


**Model:** 'Basic_var_ex.mlrj'<br>
The model is the Basic physiology expanded for controll of food intake.


**Simulation Experiment:** 'Basic_var_ex.scala'<br>
The simulation experiment scans for six oxygen saturations (45,56,65,75,84,93)% and four levels of food intake level (0.25,0.5,0.75,1). The experiment runs 20 replications for each setup. <br>
If you wish to run the experiment:
* download the folder, 
* rename or delete result folder (result_xxx - software is not authorised to write over exsting folder)
* double click on 'run.bat' (windwos) or 'run.sh' (linux). 
You will have to have Java installed.


**R-script:** 'Basic_var_ex_eval.R'<br>
Results of the wet-lab experiment are included in the R-script provided for evaluation of simulation experiments.


**Results:**<br>
Figure 'Basic_variable_ex_weight.png' shows gain in weight for different treatments. <br>
Figure 'Basic_variable_ex_length.png' shows gain in length for different treatments. <br>
Figure 'Basic_variable_ex_cf.png' shows gain in condition for different treatments. <br>
Figure 'Basic_variable_ex_analysis.png' shows grid of all results. <br>
Figure 'Variable_ex_ind_weight.html' shows gain in weight of all individuals for different treatments. <br>
Figure 'Variable_ex_ind_length.html' shows gain in length of all individuals for different treatments. <br>
Figure 'Variable_ex_ind_cf.html' shows final condition of all individuals for different treatments. 
