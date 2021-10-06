# Growth, reproduction, movement and ingestion based infestation with *Contracaecum osculatum* at liberty experiment

This experiment simulates cod at liberty for one year moving through four environmental compartments.

**Purpose:**<br>
The purpose of the experiment is to investigate interaction of growth, habitat, movement, reproduction and infestation with *Contracaecum osculatum*.


**Model:** 'Labyrinth_4_pp_liver.mlrj'<br>
The model is the Liver physiology placed in a simulated Baltic environment.


**Simulation Experiment:** 'Labyrinth_4_pp_liver.scala'<br>
The simulation experiment scans properties of cod weekly through the course of a calendar year. <br>
If you wish to run the experiment:
* download the folder, 
* rename or delete result folder (result_xxx - software is not authorised to write over exsting folder)
* double click on 'run.bat' (windwos) or 'run.sh' (linux). 
You will have to have Java installed.


**R-script:** 'Labyrinth_4_pp_liver_eval.R'<br>
Results of the simulation experiment can be visualised with the R-script provided. (Check for correct working directory)


**Results:**<br>
Figure 'laby_4_liver_year_analysis.png' shows grid of all results. <br>
Figure 'laby_4_liver_year.html' visualises movement over the course of one year, additional information given in mouse-over. <br>
Figure 'laby_4_liver_year_mass.html' shows gain in mass in weekly increments, additional information given in mouse-over. <br>
Figure 'laby_4_liver_year_length' shows gain in length in weekly increments, additional information given in mouse-over. <br>
Figure 'laby_4_liver_year_cf' shows gain in condition factor in weekly increments, additional information given in mouse-over. <br>
Figure 'laby_4_liver_year_box' shows resident box in weekly increments, additional information given in mouse-over. <br>
Figure 'laby_4_liver_year_parasitation' shows parasitation in weekly increments, additional information given in mouse-over.
