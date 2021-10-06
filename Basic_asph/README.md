# Asphyxiation experiment with the Basic physiology

This experiment reproduces the wet-lab experiments of:<br>
Plante et al. - Hypoxia Tolerace in Atlandic Cod; <br>
DOI:10.1111/j.1095-8649.1998.tb00253.x<br>
as a simulation experiment.

**Purpose:**<br>
The purpose of the experiment is validation of the modelled cod for death by asphyxiation.

**Model:** 'Basic_asph.mlrj'<br>
The model is the the Basic physiology placed in an experimental tank to controll ambient temperature and oxygen saturation

**Simulation Experiment:** 'Basic_asph.scala'<br>
The simulation experiment scans for six oxygen saturations (13.8,17.8,23.7,29.5,36.5,42.5)% placing 20 cod of four length and weight classes in each, two at 2°C and two at 6°C. <br>
If you wish to run the experiment:
* download the folder, 
* rename or delete result folder (result_xxx - software is not authorised to write over exsting folder)
* double click on 'run.bat' (windwos) or 'run.sh' (linux). 
You will have to have Java installed.

**R-script:** 'Basic_asph_eval.R'<br>
Results of the wet-lab experiment are included in the R-script provided for evaluation of simulation experiments. (Check for correct working directory)

**Results:**<br>
Figure (Basic_asph.png) shows comparison of cummulative mortality for wet-lab and simulation experiments.
