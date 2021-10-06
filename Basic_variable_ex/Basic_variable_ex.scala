// Experiment for modelled cod physiology in a 12 week feeding experiment at different oxygen levels with varied food intake levels
// Model file: Basic_variable_ex.mlrj
// Output folder: result_basic_variable_ex
// Duration example: 37 min


package org.sessl

object ExampleExperiment extends App {

  import sessl._
  import sessl.mlrules._

		 val before = System.currentTimeMillis()


  execute {
   new Experiment with Observation with ParallelExecution with CSVOutput {
	model = "./Basic_variable_ex.mlrj"  
    simulator = StandardSimulator()
    parallelThreads = -1
	
	stopTime = 201600
    replications = 20
	
	observeAt(range(0, 201600, 201600))  	
	scan("o" <~ (45,56,65,75,84,93))
	scan("t" <~ (10))
	scan("va" <~ (0.25,0.5,0.75,1))
	
	observe("length" ~ attribute("*/GM",0))
	observe("weight" ~ attribute("*/GM",1))
	
	csvOutputDirectory(() => "result_basic_variable_ex")
	
    withRunResult(writeCSV)  
    }
  }
		val after = System.currentTimeMillis()
		println( (after - before) / 1000)
}





//-> 1 hour = 100TU	-> 1 day = 2400TU	 -> 1 week = 16800TU  -> 1 month = 72800	-> 6 month = 436800	-> 1 year = 876000

