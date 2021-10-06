// Experiment for modelled cod physiology in a 12 week feeding experiment at different oxygen levels with condition factor determining parasite infestation
// Model file: Condition_ex.mlrj
// Output folder: result_condition_ex
// Duration example: 129 min


package org.sessl

object ExampleExperiment extends App {

  import sessl._
  import sessl.mlrules._

		 val before = System.currentTimeMillis()


  execute {
    new Experiment with Observation with ParallelExecution with CSVOutput {
	model = "./Condition_ex.mlrj" 
    simulator = StandardSimulator()
    parallelThreads = -1
	stopTime = 201600
    replications = 20
	
	
	scan("o" <~ (45,56,65,75,84,93))
	scan("t" <~ (10))
	scan("lop" <~ (0,1))
	    scan("group" <~ (
 "1 GM(442,605 ,30,150,1,1,0,'E',0,13,1002)[Stc(0,1,1002)[] + Liver(0,0,1002)]"
,"1 GM(442,691 ,30,150,1,1,0,'E',0,13,1003)[Stc(0,1,1003)[] + Liver(0,0,1003)]"
,"1 GM(442,777 ,30,150,1,1,0,'E',0,13,1004)[Stc(0,1,1004)[] + Liver(0,0,1004)]"
,"1 GM(442,864 ,30,150,1,1,0,'E',0,13,1005)[Stc(0,1,1005)[] + Liver(0,0,1005)]"
,"1 GM(442,950 ,30,150,1,1,0,'E',0,13,1006)[Stc(0,1,1006)[] + Liver(0,0,1006)]"
	))
	
	observeAt(range(0, 201600, 201600))
	
	observe("length" ~ attribute("*/GM",0))
	observe("weight" ~ attribute("*/GM",1))	
	observe("prey_parasitation" ~ attribute("*/Prey",6))	
	observe("Liver_oc_infest" ~ attribute("*/Liver",1))
	
	csvOutputDirectory(() => "result_condition_ex")
	
    withRunResult(writeCSV)  
    }
  }
		val after = System.currentTimeMillis()
		println( (after - before) / 1000)
}





//-> 1 hour = 100TU	-> 1 day = 2400TU	 -> 1 week = 16800TU  -> 1 month = 72800	-> 6 month = 436800	-> 1 year = 876000