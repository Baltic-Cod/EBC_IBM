// Experiment for modelled cod physiology in a 4 day asphyxiation experiment at different weight classes
// Model file: Basic_asphyx.mlrj
// Output folder: result_basic_asphyx
// Duration example: 3 min


package org.sessl

object ExampleExperiment extends App {

  import sessl._
  import sessl.mlrules._

		 val before = System.currentTimeMillis()


  execute {
   new Experiment with Observation with ParallelExecution with CSVOutput {
	model = "./Basic_asphyx.mlrj"  
    simulator = StandardSimulator()
    parallelThreads = -1
	
    stopTime = 9600
    replications = 1
	
	observeAt(range(0, 9600, 9600)) 
	scan("init" <~ (
	"20 GM(385,570 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]",
	"20 GM(560,1740,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]",
	"20 GM(445,890 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]",
	"20 GM(560,1790,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]")) 	
	scan("o" <~ (13.8,17.8,23.7,29.5,36.5,42.5))
	scan("t" <~ (2,6))
	
    observe("N_GM" ~ count("GM"))
	
	csvOutputDirectory(() => "result_basic_asphyx")
	
    withRunResult(writeCSV)  
    }
  }
		val after = System.currentTimeMillis()
		println( (after - before) / 1000)
}





//-> 1 hour = 100TU	-> 1 day = 2400TU	 -> 1 week = 16800TU  -> 1 month = 72800	-> 6 month = 436800	-> 1 year = 876000

