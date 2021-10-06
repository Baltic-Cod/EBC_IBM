# Growth, reproduction and movement at liberty experiment with 12-fold fragmentation

This experiment simulates cod at liberty for one year moving through four environmental compartments each fragmented into twelve with slight variance in environmental conditions.

**Purpose:**<br>
The purpose of the experiment is to investigate interaction of growth, habitat, movement and reproduction.


**Model:** 'Labyrinth_48.mlrj'<br>
The model is the Variable physiology placed in a simulated Baltic environment.


**Simulation Experiment:** 'Labyrinth_48.scala'<br>
The simulation experiment scans properties of cod weekly through the course of a calendar year. <br>
If you wish to run the experiment:
* download the folder, 
* rename or delete result folder (result_xxx - software is not authorised to write over exsting folder)
* double click on 'run.bat' (windwos) or 'run.sh' (linux). 
You will have to have Java installed.


**R-script:** 'Labyrinth_48_eval.R'<br>
Results of the simulation experiment can be visualised with the R-script provided. (Check for correct working directory)


**Results:**<br>
Figure 'laby_48_year_analysis.png' shows grid of all results. <br>
Figure 'laby_48_year.html' visualises movement over the course of one year, additional information given in mouse-over. <br>
Figure 'laby_48_year_mass.html' shows gain in mass in weekly increments, additional information given in mouse-over. <br>
Figure 'laby_48_year_length' shows gain in length in weekly increments, additional information given in mouse-over. <br>
Figure 'laby_48_year_cf' shows gain in condition factor in weekly increments, additional information given in mouse-over. <br>
Figure 'laby_48_year_box' shows resident box in weekly increments, additional information given in mouse-over. <br>
