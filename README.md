# Objects for reproducibility of EBC IBM study

Reproducibility for Eastern Baltic Cod - Individual Based models in ML-Rules,
(supporting information for the publication DOI:...........): <br>
Corresponding author: maria.pierce@thuenen.de

**Here you will find:**

* Example Results:  a folder per experiment which contains: <br>									
		- Model:  model used for the experiment written in ML-Rules (.mlrj) <br>
		- Experiment:  experiment using the ML-Rule model, to be used with [SESSL](https://git.informatik.uni-rostock.de/mosi/sessl/-/wikis/home) <br>
		- Simulation Results:  a folder containing results of a simulation run of the experiment <br>
		- R-script:  script to visualise the results of the experiments in R <br>
		- Figures:  images and interactive figures produced with the R-script using the given simulation results <br>
										
* Documentation: TRACE_EBC_IBM - extensive description following the TRACE protocol
										
* Additional files such as: .mvn/wrapper; mvnw; mvnw.cmd; pom.xml these provide easy execution of experiments and can be ignored
										
										

**What you can do with these artefacts:**

* you can run the experiments to reproduce their results. <br>
		You will not need to install any additional software for this.
		The only software requirement is a Java installation.
		
* you can edit the models to see how changes in the model affect the results. <br>
		- the .mlrj files can be edited in any text editor <br>
		- if you want syntax highlighting you can use the [Sandbox-Version of ML-Rules](https://git.informatik.uni-rostock.de/mosi/mlrules2-quickstart).

* you can visualise results: <br>
		- use the example results if you do not want to rerun experiments <br>
		- if you have rerun results you can evaluate the new results with the available R-scripts <br>
		- if you have augmented experiments you can augment the R-scripts accordingly to evaluate the results <br>
		
* you can simply look at the visualisations of the examples
