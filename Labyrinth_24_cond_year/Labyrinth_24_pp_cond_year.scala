// Experiment for modelled cod physiology at liberty in 4 envrionmental boxes for one year (876000 time units) 25 pairs of male and female parasitation based on condition
// Model file: Labyrinth_24_pp_cond.mlrj"
// Output folder: result_labyrinth_24_pp_cond_year
// Duration example: 37h 11min


package org.sessl

object ExampleExperiment extends App {

  import sessl._
  import sessl.mlrules._

		 val before = System.currentTimeMillis()


  execute {
    new Experiment with Observation with ParallelExecution with CSVOutput {
	model = "./Labyrinth_24_pp_cond.mlrj" 
    simulator = StandardSimulator()
    parallelThreads = -1
	stopTime = 876000
    replications = 1


	observeAt(range(0,16800,876000))
	
	scan("lop" <~ (0,0.2,0.8,1))
	
    scan("group" <~ (
   "GM(442,605,30,150,1,1,0,'E',0,13,1001)[Stc(0,1,1001)[] + Liver(0,0,1001) + Gon(1,0,0,0,0,1001)]+ GM(442,605,30,150,0,1,0,'E',0,13,1002)[Stc(0,1,1002)[] + Liver(0,0,1002) + Gon(0,0,0,0,0,1002)]" 
,"1 GM(442,605,30,150,1,1,0,'E',0,13,1003)[Stc(0,1,1003)[] + Liver(0,0,1003) + Gon(1,0,0,0,0,1003)]+ GM(442,605,30,150,0,1,0,'E',0,13,1004)[Stc(0,1,1004)[] + Liver(0,0,1004) + Gon(0,0,0,0,0,1004)]"
,"1 GM(442,605,30,150,1,1,0,'E',0,13,1005)[Stc(0,1,1005)[] + Liver(0,0,1005) + Gon(1,0,0,0,0,1005)]+ GM(442,605,30,150,0,1,0,'E',0,13,1006)[Stc(0,1,1006)[] + Liver(0,0,1006) + Gon(0,0,0,0,0,1006)]"
,"1 GM(442,605,30,150,1,1,0,'E',0,13,1007)[Stc(0,1,1007)[] + Liver(0,0,1007) + Gon(1,0,0,0,0,1007)]+ GM(442,605,30,150,0,1,0,'E',0,13,1008)[Stc(0,1,1008)[] + Liver(0,0,1008) + Gon(0,0,0,0,0,1008)]"
,"1 GM(442,605,30,150,1,1,0,'E',0,13,1009)[Stc(0,1,1009)[] + Liver(0,0,1009) + Gon(1,0,0,0,0,1009)]+ GM(442,605,30,150,0,1,0,'E',0,13,1010)[Stc(0,1,1010)[] + Liver(0,0,1010) + Gon(0,0,0,0,0,1010)]"
,"1 GM(442,691,30,150,1,1,0,'E',0,13,1011)[Stc(0,1,1011)[] + Liver(0,0,1011) + Gon(1,0,0,0,0,1011)]+ GM(442,691,30,150,0,1,0,'E',0,13,1012)[Stc(0,1,1012)[] + Liver(0,0,1012) + Gon(0,0,0,0,0,1012)]"
,"1 GM(442,691,30,150,1,1,0,'E',0,13,1013)[Stc(0,1,1013)[] + Liver(0,0,1013) + Gon(1,0,0,0,0,1013)]+ GM(442,691,30,150,0,1,0,'E',0,13,1014)[Stc(0,1,1014)[] + Liver(0,0,1014) + Gon(0,0,0,0,0,1014)]"
,"1 GM(442,691,30,150,1,1,0,'E',0,13,1015)[Stc(0,1,1015)[] + Liver(0,0,1015) + Gon(1,0,0,0,0,1015)]+ GM(442,691,30,150,0,1,0,'E',0,13,1016)[Stc(0,1,1016)[] + Liver(0,0,1016) + Gon(0,0,0,0,0,1016)]"
,"1 GM(442,691,30,150,1,1,0,'E',0,13,1017)[Stc(0,1,1017)[] + Liver(0,0,1017) + Gon(1,0,0,0,0,1017)]+ GM(442,691,30,150,0,1,0,'E',0,13,1018)[Stc(0,1,1018)[] + Liver(0,0,1018) + Gon(0,0,0,0,0,1018)]"
,"1 GM(442,691,30,150,1,1,0,'E',0,13,1019)[Stc(0,1,1019)[] + Liver(0,0,1019) + Gon(1,0,0,0,0,1019)]+ GM(442,691,30,150,0,1,0,'E',0,13,1020)[Stc(0,1,1020)[] + Liver(0,0,1020) + Gon(0,0,0,0,0,1020)]"
,"1 GM(442,777,30,150,1,1,0,'E',0,13,1021)[Stc(0,1,1021)[] + Liver(0,0,1021) + Gon(1,0,0,0,0,1021)]+ GM(442,777,30,150,0,1,0,'E',0,13,1022)[Stc(0,1,1022)[] + Liver(0,0,1022) + Gon(0,0,0,0,0,1022)]"
,"1 GM(442,777,30,150,1,1,0,'E',0,13,1023)[Stc(0,1,1023)[] + Liver(0,0,1023) + Gon(1,0,0,0,0,1023)]+ GM(442,777,30,150,0,1,0,'E',0,13,1024)[Stc(0,1,1024)[] + Liver(0,0,1024) + Gon(0,0,0,0,0,1024)]"
,"1 GM(442,777,30,150,1,1,0,'E',0,13,1025)[Stc(0,1,1025)[] + Liver(0,0,1025) + Gon(1,0,0,0,0,1025)]+ GM(442,777,30,150,0,1,0,'E',0,13,1026)[Stc(0,1,1026)[] + Liver(0,0,1026) + Gon(0,0,0,0,0,1026)]"
,"1 GM(442,777,30,150,1,1,0,'E',0,13,1027)[Stc(0,1,1027)[] + Liver(0,0,1027) + Gon(1,0,0,0,0,1027)]+ GM(442,777,30,150,0,1,0,'E',0,13,1028)[Stc(0,1,1028)[] + Liver(0,0,1028) + Gon(0,0,0,0,0,1028)]"
,"1 GM(442,777,30,150,1,1,0,'E',0,13,1029)[Stc(0,1,1029)[] + Liver(0,0,1029) + Gon(1,0,0,0,0,1029)]+ GM(442,777,30,150,0,1,0,'E',0,13,1030)[Stc(0,1,1030)[] + Liver(0,0,1030) + Gon(0,0,0,0,0,1030)]"
,"1 GM(442,864,30,150,1,1,0,'E',0,13,1031)[Stc(0,1,1031)[] + Liver(0,0,1031) + Gon(1,0,0,0,0,1031)]+ GM(442,864,30,150,0,1,0,'E',0,13,1032)[Stc(0,1,1032)[] + Liver(0,0,1032) + Gon(0,0,0,0,0,1032)]"
,"1 GM(442,864,30,150,1,1,0,'E',0,13,1033)[Stc(0,1,1033)[] + Liver(0,0,1033) + Gon(1,0,0,0,0,1033)]+ GM(442,864,30,150,0,1,0,'E',0,13,1034)[Stc(0,1,1034)[] + Liver(0,0,1034) + Gon(0,0,0,0,0,1034)]"
,"1 GM(442,864,30,150,1,1,0,'E',0,13,1035)[Stc(0,1,1035)[] + Liver(0,0,1035) + Gon(1,0,0,0,0,1035)]+ GM(442,864,30,150,0,1,0,'E',0,13,1036)[Stc(0,1,1036)[] + Liver(0,0,1036) + Gon(0,0,0,0,0,1036)]"
,"1 GM(442,864,30,150,1,1,0,'E',0,13,1037)[Stc(0,1,1037)[] + Liver(0,0,1037) + Gon(1,0,0,0,0,1037)]+ GM(442,864,30,150,0,1,0,'E',0,13,1038)[Stc(0,1,1038)[] + Liver(0,0,1038) + Gon(0,0,0,0,0,1038)]"
,"1 GM(442,864,30,150,1,1,0,'E',0,13,1039)[Stc(0,1,1039)[] + Liver(0,0,1039) + Gon(1,0,0,0,0,1039)]+ GM(442,864,30,150,0,1,0,'E',0,13,1040)[Stc(0,1,1040)[] + Liver(0,0,1040) + Gon(0,0,0,0,0,1040)]"
,"1 GM(442,950,30,150,1,1,0,'E',0,13,1041)[Stc(0,1,1041)[] + Liver(0,0,1041) + Gon(1,0,0,0,0,1041)]+ GM(442,950,30,150,0,1,0,'E',0,13,1042)[Stc(0,1,1042)[] + Liver(0,0,1042) + Gon(0,0,0,0,0,1042)]"
,"1 GM(442,950,30,150,1,1,0,'E',0,13,1043)[Stc(0,1,1043)[] + Liver(0,0,1043) + Gon(1,0,0,0,0,1043)]+ GM(442,950,30,150,0,1,0,'E',0,13,1044)[Stc(0,1,1044)[] + Liver(0,0,1044) + Gon(0,0,0,0,0,1044)]"
,"1 GM(442,950,30,150,1,1,0,'E',0,13,1045)[Stc(0,1,1045)[] + Liver(0,0,1045) + Gon(1,0,0,0,0,1045)]+ GM(442,950,30,150,0,1,0,'E',0,13,1046)[Stc(0,1,1046)[] + Liver(0,0,1046) + Gon(0,0,0,0,0,1046)]"
,"1 GM(442,950,30,150,1,1,0,'E',0,13,1047)[Stc(0,1,1047)[] + Liver(0,0,1047) + Gon(1,0,0,0,0,1047)]+ GM(442,950,30,150,0,1,0,'E',0,13,1048)[Stc(0,1,1048)[] + Liver(0,0,1048) + Gon(0,0,0,0,0,1048)]"
,"1 GM(442,950,30,150,1,1,0,'E',0,13,1049)[Stc(0,1,1049)[] + Liver(0,0,1049) + Gon(1,0,0,0,0,1049)]+ GM(442,950,30,150,0,1,0,'E',0,13,1050)[Stc(0,1,1050)[] + Liver(0,0,1050) + Gon(0,0,0,0,0,1050)]"
	))
	
	
	//observe("N_Box" ~ count("*/Box"))
	observe("boxnumber" ~ attribute("*/Box",0))
	observe("temperature" ~ attribute("*/Box",1))
	observe("oxygen" ~ attribute("*/Box",2))
	//observe("salinity" ~ attribute("*/Box",3))
	observe("day" ~ attribute("*/Box",4))
	//observe("zone" ~ attribute("*/Box",5))
	//observe("substrate" ~ attribute("*/Box",6))
	observe("prey_availability" ~ attribute("*/Box",7))
	//observe("area" ~ attribute("*/Box",8))
	//observe("min_depth" ~ attribute("*/Box",9))
	//observe("max_depth" ~ attribute("*/Box",10))
	
	//observe("N_GM" ~ count("*/GM"))
	observe("length" ~ attribute("*/GM",0))
	observe("mass" ~ attribute("*/GM",1))
	//observe("ox" ~ attribute("*/GM",2))
	//observe("jpo" ~ attribute("*/GM",3))
	observe("sex" ~ attribute("*/GM",4))
	observe("rep_cyc" ~ attribute("*/GM",5))
	//observe("hs" ~ attribute("*/GM",6))
	//observe("stock_affiliation" ~ attribute("*/GM",7))
	//observe("sta" ~ attribute("*/GM",8))
	observe("res_box" ~ attribute("*/GM",9))
	observe("identifyer" ~ attribute("*/GM",10))
	
	//observe("N_Stc" ~ count("*/Stc"))
	observe("stc_prey_count" ~ attribute("*/Stc",0))
	observe("stc_variable" ~ attribute("*/Stc",1))
	observe("stc_identifyer" ~ attribute("*/Stc",2))
	
	//observe("N_Liv" ~ count("*/Liver"))
	//observe("liver_as" ~ attribute("*/Liver",0))
	observe("liver_co" ~ attribute("*/Liver",1))
	observe("liver_identifyer" ~ attribute("*/Liver",2))

	//observe("N_Gon" ~ count("*/Gon"))
	observe("sex_gon" ~ attribute("*/Gon",0))
	observe("eggnumber" ~ attribute("*/Gon",1))
	observe("gonad_maturity" ~ attribute("*/Gon",2))
	observe("JPO_egg_counter" ~ attribute("*/Gon",3))
	observe("gonad_weight" ~ attribute("*/Gon",4))
	observe("gonad_identifyer" ~ attribute("*/Gon",5))
	
	observe("Eggs" ~ count("*/GME"))
	
	//observe("N_Prey" ~ count("*/Prey"))
	//observe("prey_name" ~ attribute("*/Prey",0))
	//observe("prey_size" ~ attribute("*/Prey",1))
	//observe("prey_ox" ~ attribute("*/Prey",2))
	//observe("prey_jpo" ~ attribute("*/Prey",3))
	//observe("prey_df" ~ attribute("*/Prey",4))
	//observe("prey_as" ~ attribute("*/Prey",5))
	//observe("prey_co" ~ attribute("*/Prey",6))
	
	observe("Swimming" ~ count("*/ACT"))
	observe("Hunting" ~ count("*/HUNT"))
	observe("Eating" ~ count("*/EAT"))
	observe("Mating" ~ count("*/MATE"))


	csvOutputDirectory(() => "result_labyrinth_24_pp_cond_year")
    withRunResult(writeCSV)  
    }
  }
		val after = System.currentTimeMillis()
		println( (after - before) / 1000)
}



//-> 1 hour = 100TU	-> 1 day = 2400TU	 -> 1 week = 16800TU  -> 1 month = 72800	-> 6 month = 436800	-> 1 year = 876000


