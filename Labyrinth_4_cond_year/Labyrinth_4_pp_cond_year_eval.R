# Evaluate results from the Labyrinth_4_year_SESSL.txt (scala experiment run with SESSL) experiment (using the Labyrinth_4.mlrj model)
# Experiment simulates a year at liberty in a 4 box environment
# Experiment result is named 'result_labyrinth_year_4'
# Evaluation shows course of one year for two individual cod at a time accumulated


library("ggplot2")
library("plotly")
library("dplyr")
library("readbitmap")
library("magick")
library("tidyverse")
library("lubridate")
library("here")
library("forestmangr")
library("readxl")

##############################
#This Part is for the Cod
##############################



# read table
# name of folder
fname<-"result_labyrinth_4_pp_cond_year"
# list of value in which lop was scanned (put lop scan first in SESSL experiment!!!)
lv<-c(0,0.2,0.8,1)

p=0 # first configuration
q=0 # first result
r=1 # first result
v=1 # # of first lop value in lv
vc=1 # counter for lop scan
laby_cp_4_year <- 0

while (p<=99) # Number of configuration from zero
{  while (r<=1) 
{    df1<- read.table(paste(fname,"/","config-",p,"/","run-",q,".csv",sep=""), header = TRUE,sep=",")
if (q>=1) {# removes box information from every but the first
  df1_r<--1
  df1_w<--1
  df1_r<-subset(df1,(df1$stc_identifyer!='NA'|df1$gonad_identifyer!='NA'|df1$liver_identifyer!='NA'))
  df1_w<-subset(df1,df1$identifyer!='NA')
  df1_r$lop<-lv[v]
  df1_w$lop<-lv[v]
  df2<-0
  df2<-rbind(df1_r,df1_w)
  rm(df1,df1_r,df1_w)
  laby_cp_4_year<-rbind(laby_cp_4_year,df2) 
  rm(df2)
}
else {
  df1_l<--1
  df1_r<--1
  df1_w<--1
  df1_l<-subset(df1,df1$boxnumber!='NA')
  df1_r<-subset(df1,(df1$identifyer!='NA'|df1$gonad_identifyer!='NA'|df1$liver_identifyer!='NA'))
  df1_w<-subset(df1,df1$stc_identifyer!='NA')
  df1_l$lop<-lv[v]
  df1_r$lop<-lv[v]
  df1_w$lop<-lv[v]
  
  df2<-0
  df2<-rbind(df1_l,df1_r,df1_w)
  rm(df1,df1_l,df1_r,df1_w)
  laby_cp_4_year<-rbind(laby_cp_4_year,df2) 
  rm(df2)
}
r=r+1;
q=q+1;
}
  if(vc<=24) # number of runs/number of elements in lv minus one
  {
    vc=vc+1
  }
  else{
    v=v+1;
    vc=1;
  }
  p=p+1;
  r=1;
}
rm(p,q,r,lv,v,vc)



# add initial condition to data frame
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1001]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1002]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1003]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1004]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1005]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1006]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1007]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1008]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1009]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1010]<-0.7
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1011]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1012]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1013]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1014]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1015]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1016]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1017]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1018]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1019]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1020]<-0.8
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1021]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1022]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1023]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1024]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1025]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1026]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1027]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1028]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1029]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1030]<-0.9
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1031]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1032]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1033]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1034]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1035]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1036]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1037]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1038]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1039]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1040]<-1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1041]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1042]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1043]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1044]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1045]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1046]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1047]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1048]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1049]<-1.1
laby_cp_4_year$init_cf[laby_cp_4_year$identifyer==1050]<-1.1



# merge information about organs with information about cod in dataframe
t<-laby_cp_4_year

stomach<-subset(t,stc_identifyer!='NA')
stomach$identifyer<-stomach$stc_identifyer
stomach$gonad_identifyer<-NULL
stomach$liver_identifyer<-NULL
stomach$stc_identifyer<-NULL
stomach<-arrange(stomach,identifyer)
liver<-subset(t,liver_identifyer!='NA')
liver$identifyer<-liver$liver_identifyer
liver$gonad_identifyer<-NULL
liver$stc_identifyer<-NULL
liver$liver_identifyer<-NULL
liver<-arrange(liver,identifyer)
gonad<-subset(t,gonad_identifyer!='NA')
gonad$identifyer<-gonad$gonad_identifyer
gonad$stc_identifyer<-NULL
gonad$liver_identifyer<-NULL
gonad$gonad_identifyer<-NULL
gonad<-arrange(gonad,identifyer)
cod<-subset(t,identifyer!='NA')
cod$gonad_identifyer<-NULL
cod$stc_identifyer<-NULL
cod$liver_identifyer<-NULL
cod<-arrange(cod,identifyer)
boxes<-subset(t,boxnumber!='NA')
boxes$gonad_identifyer<-NULL
boxes$stc_identifyer<-NULL
boxes$liver_identifyer<-NULL

a<-coalesce(cod,stomach)
b<-coalesce(a,liver)
c<-coalesce(b,gonad)
c<-arrange(c,time)

tt<-0
tt<-rbind(tt,boxes)
tt<-rbind(tt,c)
tt<-arrange(tt,time)
tt<-arrange(tt,identifyer)
tt<-tt[-c(1,2,3),]

laby_cp_4_year<-tt

rm(a,b,c,t,tt,boxes,cod,stomach,liver,gonad)


# set columntypes and indtroduce new columns
laby_cp_4_year$time <- as.numeric(laby_cp_4_year$time)
laby_cp_4_year$boxnumber <- as.numeric(laby_cp_4_year$boxnumber)
laby_cp_4_year$identifyer <- as.character(laby_cp_4_year$identifyer)
laby_cp_4_year$x <- 0
laby_cp_4_year$y <- 0
#laby_cp_4_year$month<--1
laby_cp_4_year$week<--1
laby_cp_4_year$boxname<-0
laby_cp_4_year$x_1<-0
laby_cp_4_year$y_1<-0
laby_cp_4_year$sex_l<-'NA'
laby_cp_4_year$sex_mat_l<-'NA'
laby_cp_4_year$ch_name<-'NA'
#laby_cp_4_year$cf <- 0



# calculate and enter month based on time units
#n<-1+(max(laby_cp_4_year$time))/72800
#count<-1
#units<-0
#monthmonth<-1

#while (count<=n) {
#  laby_cp_4_year$month[laby_cp_4_year$time==units]<-monthmonth

#  monthmonth<-monthmonth+1
#  units<-units+72800
#  count<-count+1
#}
#rm(n,count,units,monthmonth)



# calculate and enter week based on time unit 
n<-1+(max(laby_cp_4_year$time))/16800
count<-1
units<-0
weekweek<-0

while (count<=n+2) {
  laby_cp_4_year$week[laby_cp_4_year$time==units]<-weekweek
  
  weekweek<-weekweek+1
  units<-units+16800
  count<-count+1
}
rm(n,count,units,weekweek)



#calculate condition factor
laby_cp_4_year$cf <- ((100000* laby_cp_4_year$mass) / (laby_cp_4_year$length^3))


#calculate length growth
laby_cp_4_year$length_growth <- (laby_cp_4_year$length-442)


#calculate mass growth
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1001]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1002]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1003]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1004]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1005]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1006]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1007]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1008]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1009]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1010]<-(laby_cp_4_year$mass-605)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1011]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1012]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1013]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1014]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1015]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1016]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1017]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1018]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1019]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1020]<-(laby_cp_4_year$mass-691)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1021]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1022]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1023]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1024]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1025]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1026]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1027]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1028]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1029]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1030]<-(laby_cp_4_year$mass-777)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1031]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1032]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1033]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1034]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1035]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1036]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1037]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1038]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1039]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1040]<-(laby_cp_4_year$mass-864)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1041]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1042]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1043]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1044]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1045]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1046]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1047]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1048]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1049]<-(laby_cp_4_year$mass-950)
laby_cp_4_year$mass_growth[laby_cp_4_year$identifyer==1050]<-(laby_cp_4_year$mass-950)


# round all integers to 2 decimal places
laby_cp_4_year<-round_df(laby_cp_4_year, 2, rf = "round")


# delete unneeded entries
#laby_cp_4_year1<-subset(laby_cp_4_year,laby_cp_4_year$week>0)
#laby_cp_4_year<-rbind(laby_cp_4_year1)
#laby_cp_4_year1<-subset(laby_cp_4_year,laby_cp_4_year$month!=-1)
#laby_cp_4_year<-rbind(laby_cp_4_year1)
#laby_cp_4_year1<-subset(laby_cp_4_year,laby_cp_4_year$time!=0)
#laby_cp_4_year<-rbind(laby_cp_4_year1)
laby_cp_4_year<-laby_cp_4_year[-c(1),] 



# supply sex as word 
laby_cp_4_year$sex_l[laby_cp_4_year$sex==0]<-"female"
laby_cp_4_year$sex_l[laby_cp_4_year$sex==1]<-"male"


# supply sexual cycle as word
laby_cp_4_year$sex_mat_l[laby_cp_4_year$rep_cyc==1]<-"spent"
laby_cp_4_year$sex_mat_l[laby_cp_4_year$rep_cyc==2]<-"preparing"
laby_cp_4_year$sex_mat_l[laby_cp_4_year$rep_cyc==3]<-"ready"
laby_cp_4_year$sex_mat_l[laby_cp_4_year$rep_cyc==4]<-"spawning"

# name the cod
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1001]<-"Archie"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1002]<-"Anna"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1003]<-"Ben"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1004]<-"Barbara"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1005]<-"Chris"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1006]<-"Celine"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1007]<-"Danny"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1008]<-"Doris"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1009]<-"Erech"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1010]<-"Evelin"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1011]<-"Fred"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1012]<-"Fraja"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1013]<-"George"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1014]<-"Giselle"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1015]<-"Henry"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1016]<-"Helen"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1017]<-"Ismael"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1018]<-"Ingrid"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1019]<-"John"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1020]<-"Jesse"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1021]<-"Kevin"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1022]<-"Kate"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1023]<-"Leslie"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1024]<-"Lesley"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1025]<-"Marc"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1026]<-"Marie"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1027]<-"Norbert"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1028]<-"Nancy"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1029]<-"Otto"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1030]<-"Olivia"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1031]<-"Paul"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1032]<-"Pat"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1033]<-"Quinn"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1034]<-"Qiana"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1035]<-"Raphael"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1036]<-"Rachel"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1037]<-"Steven"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1038]<-"Stella"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1039]<-"Timm"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1040]<-"Tiffany"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1041]<-"Uwe"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1042]<-"Ursula"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1043]<-"Victor"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1044]<-"Victoria"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1045]<-"Winston"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1046]<-"Wendy"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1047]<-"Yusuf"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1048]<-"Yelena"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1049]<-"Zachary"
laby_cp_4_year$ch_name[laby_cp_4_year$identifyer==1050]<-"Zoe"




# add coordinates for rapid prototyping
for(i in 1:nrow(laby_cp_4_year)) {
  row <- laby_cp_4_year[i,]
  row$x[row$res_box==1]<-sample(342:355,1)
  row$x[row$res_box==2]<-sample(342:355,1)
  row$x[row$res_box==3]<-sample(342:355,1)
  row$x[row$res_box==4]<-sample(342:355,1)
  row$x[row$res_box==5]<-sample(342:355,1)
  row$x[row$res_box==6]<-sample(342:355,1)
  row$x[row$res_box==7]<-sample(342:355,1)
  row$x[row$res_box==8]<-sample(342:355,1)
  row$x[row$res_box==9]<-sample(342:355,1)
  row$x[row$res_box==10]<-sample(342:355,1)
  row$x[row$res_box==11]<-sample(342:355,1)
  row$x[row$res_box==12]<-sample(342:355,1)
  row$x[row$res_box==13]<-sample(360:380,1)
  row$x[row$res_box==14]<-sample(360:380,1)
  row$x[row$res_box==15]<-sample(360:380,1)
  row$x[row$res_box==16]<-sample(360:380,1)
  row$x[row$res_box==17]<-sample(360:380,1)
  row$x[row$res_box==18]<-sample(360:380,1)
  row$x[row$res_box==19]<-sample(360:380,1)
  row$x[row$res_box==20]<-sample(360:380,1)
  row$x[row$res_box==21]<-sample(360:380,1)
  row$x[row$res_box==22]<-sample(360:380,1)
  row$x[row$res_box==23]<-sample(360:380,1)
  row$x[row$res_box==24]<-sample(360:380,1)
  row$x[row$res_box==25]<-sample(400:417,1)
  row$x[row$res_box==26]<-sample(400:417,1)
  row$x[row$res_box==27]<-sample(400:417,1)
  row$x[row$res_box==28]<-sample(400:417,1)
  row$x[row$res_box==29]<-sample(400:417,1)
  row$x[row$res_box==30]<-sample(400:417,1)
  row$x[row$res_box==31]<-sample(400:417,1)
  row$x[row$res_box==32]<-sample(400:417,1)
  row$x[row$res_box==33]<-sample(400:417,1)
  row$x[row$res_box==34]<-sample(400:417,1)
  row$x[row$res_box==35]<-sample(400:417,1)
  row$x[row$res_box==36]<-sample(400:417,1)
  row$x[row$res_box==37]<-sample(332:340,1)
  row$x[row$res_box==38]<-sample(332:340,1)
  row$x[row$res_box==39]<-sample(332:340,1)
  row$x[row$res_box==40]<-sample(332:340,1)
  row$x[row$res_box==41]<-sample(332:340,1)
  row$x[row$res_box==42]<-sample(332:340,1)
  row$x[row$res_box==43]<-sample(332:340,1)
  row$x[row$res_box==44]<-sample(332:340,1)
  row$x[row$res_box==45]<-sample(332:340,1)
  row$x[row$res_box==46]<-sample(332:340,1)
  row$x[row$res_box==47]<-sample(332:340,1)
  row$x[row$res_box==48]<-sample(332:340,1)
  row$x[is.na(row$res_box)]<-NA
  laby_cp_4_year[i,]<-row
}

for(i in 1:nrow(laby_cp_4_year)) {
  row <- laby_cp_4_year[i,]
  row$y[row$res_box==1]<-sample(187:213,1)
  row$y[row$res_box==2]<-sample(187:213,1)
  row$y[row$res_box==3]<-sample(187:213,1)
  row$y[row$res_box==4]<-sample(187:213,1)
  row$y[row$res_box==5]<-sample(187:213,1)
  row$y[row$res_box==6]<-sample(187:213,1)
  row$y[row$res_box==7]<-sample(187:213,1)
  row$y[row$res_box==8]<-sample(187:213,1)
  row$y[row$res_box==9]<-sample(187:213,1)
  row$y[row$res_box==10]<-sample(187:213,1)
  row$y[row$res_box==11]<-sample(187:213,1)
  row$y[row$res_box==12]<-sample(187:213,1)
  row$y[row$res_box==13]<-sample(198:224,1)
  row$y[row$res_box==14]<-sample(198:224,1)
  row$y[row$res_box==15]<-sample(198:224,1)
  row$y[row$res_box==16]<-sample(198:224,1)
  row$y[row$res_box==17]<-sample(198:224,1)
  row$y[row$res_box==18]<-sample(198:224,1)
  row$y[row$res_box==19]<-sample(198:224,1)
  row$y[row$res_box==20]<-sample(198:224,1)
  row$y[row$res_box==21]<-sample(198:224,1)
  row$y[row$res_box==22]<-sample(198:224,1)
  row$y[row$res_box==23]<-sample(198:224,1)
  row$y[row$res_box==24]<-sample(198:224,1)
  row$y[row$res_box==25]<-sample(175:210,1)
  row$y[row$res_box==26]<-sample(175:210,1)
  row$y[row$res_box==27]<-sample(175:210,1)
  row$y[row$res_box==28]<-sample(175:210,1)
  row$y[row$res_box==29]<-sample(175:210,1)
  row$y[row$res_box==30]<-sample(175:210,1)
  row$y[row$res_box==31]<-sample(175:210,1)
  row$y[row$res_box==32]<-sample(175:210,1)
  row$y[row$res_box==33]<-sample(175:210,1)
  row$y[row$res_box==34]<-sample(175:210,1)
  row$y[row$res_box==35]<-sample(175:210,1)
  row$y[row$res_box==36]<-sample(175:210,1)
  row$y[row$res_box==37]<-sample(190:216,1)
  row$y[row$res_box==38]<-sample(190:216,1)
  row$y[row$res_box==39]<-sample(190:216,1)
  row$y[row$res_box==40]<-sample(190:216,1)
  row$y[row$res_box==41]<-sample(190:216,1)
  row$y[row$res_box==42]<-sample(190:216,1)
  row$y[row$res_box==43]<-sample(190:216,1)
  row$y[row$res_box==44]<-sample(190:216,1)
  row$y[row$res_box==45]<-sample(190:216,1)
  row$y[row$res_box==46]<-sample(190:216,1)
  row$y[row$res_box==47]<-sample(190:216,1)
  row$y[row$res_box==48]<-sample(190:216,1)
  row$y[is.na(row$res_box)]<-NA
  
  laby_cp_4_year[i,]<-row
}
rm(i,row)


# assign boxnames
laby_cp_4_year$boxname<-
  laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==1]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==2]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==3]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==4]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==5]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==6]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==7]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==8]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==9]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==10]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==11]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==12]<-"bornholm pelagic"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==13]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==14]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==15]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==16]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==17]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==18]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==19]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==20]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==21]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==22]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==23]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==24]<-"bornholm basin slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==25]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==26]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==27]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==28]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==29]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==30]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==31]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==32]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==33]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==34]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==35]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==36]<-"bornholm basin deep"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==37]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==38]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==39]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==40]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==41]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==42]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==43]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==44]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==45]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==46]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==47]<-"bornholm slope"
laby_cp_4_year$boxname[laby_cp_4_year$boxnumber==48]<-"bornholm slope"
laby_cp_4_year$boxname[is.na(laby_cp_4_year$boxnumber)]<-NA


laby_cp_4_year$boxname_res<-
  laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==1]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==2]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==3]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==4]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==5]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==6]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==7]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==8]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==9]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==10]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==11]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==12]<-"bornholm pelagic"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==13]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==14]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==15]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==16]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==17]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==18]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==19]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==20]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==21]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==22]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==23]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==24]<-"bornholm basin slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==25]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==26]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==27]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==28]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==29]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==30]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==31]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==32]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==33]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==34]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==35]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==36]<-"bornholm basin deep"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==37]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==38]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==39]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==40]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==41]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==42]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==43]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==44]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==45]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==46]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==47]<-"bornholm slope"
laby_cp_4_year$boxname_res[laby_cp_4_year$res_box==48]<-"bornholm slope"
laby_cp_4_year$boxname[is.na(laby_cp_4_year$boxnumber)]<-NA


#laby_cp_4_year$zonename<-
#laby_cp_4_year$zonename[laby_cp_4_year$zone==1]<-"shore"
#laby_cp_4_year$zonename[laby_cp_4_year$zone==2]<-"slope"
#laby_cp_4_year$zonename[laby_cp_4_year$zone==3]<-"trench"
#laby_cp_4_year$zonename[laby_cp_4_year$zone==4]<-"pelagic"
#laby_cp_4_year$zonename[laby_cp_4_year$zone==5]<-"basin_midwater"
#laby_cp_4_year$zonename[laby_cp_4_year$zone==6]<-"basin_deep"
#laby_cp_4_year$zonename[is.na(laby_cp_4_year$boxnumber)]<-NA


laby_cp_4_year$x_1<-
  laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==1]<-340
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==2]<-344
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==3]<-348
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==4]<-352
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==5]<-356
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==6]<-360
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==7]<-364
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==8]<-368
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==9]<-372
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==10]<-376
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==11]<-380
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==12]<-384
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==13]<-358
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==14]<-363
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==15]<-368
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==16]<-373
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==17]<-378
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==18]<-383
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==19]<-388
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==20]<-393
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==21]<-398
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==22]<-403
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==23]<-408
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==24]<-413
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==25]<-380
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==26]<-384
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==27]<-388
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==28]<-392
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==29]<-396
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==30]<-400
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==31]<-404
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==32]<-408
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==33]<-412
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==34]<-416
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==35]<-420
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==36]<-424
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==37]<-274
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==38]<-279
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==39]<-284
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==40]<-289
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==41]<-294
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==42]<-299
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==43]<-304
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==44]<-309
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==45]<-314
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==46]<-319
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==47]<-324
laby_cp_4_year$x_1[laby_cp_4_year$boxnumber==48]<-329
laby_cp_4_year$x_1[is.na(laby_cp_4_year$boxnumber)]<-NA


laby_cp_4_year$y_1<-
  laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==1]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==2]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==3]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==4]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==5]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==6]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==7]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==8]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==9]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==10]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==11]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==12]<-252
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==13]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==14]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==15]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==16]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==17]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==18]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==19]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==20]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==21]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==22]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==23]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==24]<-235
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==25]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==26]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==27]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==28]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==29]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==30]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==31]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==32]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==33]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==34]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==35]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==36]<-170
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==37]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==38]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==39]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==40]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==41]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==42]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==43]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==44]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==45]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==46]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==47]<-180
laby_cp_4_year$y_1[laby_cp_4_year$boxnumber==48]<-180
laby_cp_4_year$y_1[is.na(laby_cp_4_year$boxnumber)]<-NA

# save results file
write.csv(laby_cp_4_year,here("SESSL",paste(fname,"_acc.csv",sep="")))
rm(fname)


# load result file
# laby_cp_4_year<- read.table(here("SESSL","4_forage_low_10_acc.csv"),header = TRUE,sep=",")
# laby_cp_4_year$identifyer <- as.character(laby_cp_4_year$identifyer)
# laby_cp_4_year$length<-as.numeric(laby_cp_4_year$length)
# laby_cp_4_year$mass<-as.numeric(laby_cp_4_year$mass)



laby_cp_4_year_movement <- 0
laby_cp_4_year_movement <- laby_cp_4_year %>%
  plot_ly(type = 'scatter', mode = 'markers',
          x = ~x,
          y = ~y,
          color = ~identifyer,
          symbol = ~sex,
          frame = ~week,
          hoverinfo = "text",
          hovertext = paste("<b>",laby_cp_4_year$identifyer," aka ",laby_cp_4_year$ch_name,"</b><br>",
                            "in Box Nr.",laby_cp_4_year$res_box,"(",laby_cp_4_year$boxname_res,")","<br><br>",
                            "Length     :",laby_cp_4_year$length,"mm<br>",
                            "Mass       :",laby_cp_4_year$mass,"g<br>",
                            "Gonads   :",laby_cp_4_year$gonad_weight,"g<br>",
                            "Condition :",laby_cp_4_year$cf,"<br>",
                            "Sex           :",laby_cp_4_year$sex_l,"-",laby_cp_4_year$sex_mat_l,"<br>",
                            "Prey paristation  :",laby_cp_4_year$lop,"<br>",
                            "Liver parasitation:",laby_cp_4_year$liver_co,"<br>"
          ),
          layout.hoverlabel = "left") %>%
  add_trace(laby_cp_4_year_movement,
            type = 'scatter',
            mode = 'markers',
            x = ~x_1,
            y = ~y_1,
            marker = list(size = 10, sizeref = 4000, sizemode = 'area'),
            color = ~boxname,
            frame = ~week,
            hoverinfo = "text",
            hovertext = paste("<b>",laby_cp_4_year$boxname,"</b><br>",
                              "Box number :", laby_cp_4_year$boxnumber, "<br><br>",
                              "Oxygen         :", laby_cp_4_year$oxygen,"%<br>",
                              "Temperature :", laby_cp_4_year$temperature,"°C<br>"#,
                              # "Prey availability:", laby_cp_4_year$prey_availability
            )) %>% 
  animation_opts(frame = 500,transition=0) %>%
  layout(xaxis = list(range = c(150,450),title = "", showticklabels = FALSE, showgrid=FALSE), yaxis = list(range = c(30,350), title = "", showticklabels = FALSE, showgrid=FALSE), 
         images = list(source =  "https://raw.githubusercontent.com/Baltic-Cod/visualisation_bet/master/map.png", xref = "x", yref = "y", x = -50, y = 460, sizex = 715.6, sizey = 510, sizing = "stretch", opacity = 0.7, layer = "below"),
         hoverlabel=list(align ="left"))


laby_cp_4_year_movement



laby_cp_4_year_box <- 0
laby_cp_4_year_box <- laby_cp_4_year %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~week,
          y = ~res_box,
          color = ~identifyer,
          symbol = ~sex,
          hoverinfo = "text",
          hovertext = paste("<b>",laby_cp_4_year$identifyer," aka ",laby_cp_4_year$ch_name,"</b><br>",
                            "in Box Nr.",laby_cp_4_year$res_box,"(",laby_cp_4_year$boxname_res,")","<br><br>",
                            "Length     :",laby_cp_4_year$length,"mm<br>",
                            "Mass       :",laby_cp_4_year$mass,"g<br>",
                            "Gonads   :",laby_cp_4_year$gonad_weight,"g<br>",
                            "Condition :",laby_cp_4_year$cf,"<br>",
                            "Sex           :",laby_cp_4_year$sex_l,"-",laby_cp_4_year$sex_mat_l,"<br>",
                            "Prey paristation  :",laby_cp_4_year$lop,"<br>",
                            "Liver parasitation:",laby_cp_4_year$liver_co,"<br>"
          ),layout.hoverlabel = "left")%>%
  layout(legend=list(title=list(text='<b> Trend </b>')),
         xaxis = list(range = c(0,54),title = "Week [#]", showticklabels = TRUE, showgrid=TRUE), 
         yaxis = list(
           #range = c(0,150), 
           title = "Residing Box [1,13,25,37]", showticklabels = TRUE, showgrid=TRUE),
         title = "Residing Box (4 boxes)",
         hoverlabel=list(align ="left")
  )

laby_cp_4_year_box



laby_cp_4_year_mass <- 0
laby_cp_4_year_mass <- laby_cp_4_year %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~week,
          y = ~mass_growth,
          color = ~identifyer,
          symbol = ~sex,
          hoverinfo = "text",
          hovertext = paste("<b>",laby_cp_4_year$identifyer," aka ",laby_cp_4_year$ch_name,"</b><br>",
                            "in Box Nr.",laby_cp_4_year$res_box,"(",laby_cp_4_year$boxname_res,")","<br><br>",
                            "Length     :",laby_cp_4_year$length,"mm<br>",
                            "Mass       :",laby_cp_4_year$mass,"g<br>",
                            "Gonads   :",laby_cp_4_year$gonad_weight,"g<br>",
                            "Condition :",laby_cp_4_year$cf,"<br>",
                            "Sex           :",laby_cp_4_year$sex_l,"-",laby_cp_4_year$sex_mat_l,"<br>",
                            "Prey paristation  :",laby_cp_4_year$lop,"<br>",
                            "Liver parasitation:",laby_cp_4_year$liver_co,"<br>"
          ),layout.hoverlabel = "left")%>%
  layout(legend=list(title=list(text='<b> Trend </b>')),
         xaxis = list(range = c(0,54),title = "Week [#]", showticklabels = TRUE, showgrid=TRUE), 
         yaxis = list(
           #range = c(0,150), 
           title = "Mass growth [g]", showticklabels = TRUE, showgrid=TRUE),
         title = "Mass growth (4 boxes with Parasites (CB))",
         hoverlabel=list(align ="left")
  )

laby_cp_4_year_mass



laby_cp_4_year_length <- 0
laby_cp_4_year_length <- laby_cp_4_year %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~week,
          y = ~length_growth,
          color = ~identifyer,
          symbol = ~sex,
          hoverinfo = "text",
          hovertext = paste("<b>",laby_cp_4_year$identifyer," aka ",laby_cp_4_year$ch_name,"</b><br>",
                            "in Box Nr.",laby_cp_4_year$res_box,"(",laby_cp_4_year$boxname_res,")","<br><br>",
                            "Length     :",laby_cp_4_year$length,"mm<br>",
                            "Mass       :",laby_cp_4_year$mass,"g<br>",
                            "Gonads   :",laby_cp_4_year$gonad_weight,"g<br>",
                            "Condition :",laby_cp_4_year$cf,"<br>",
                            "Sex           :",laby_cp_4_year$sex_l,"-",laby_cp_4_year$sex_mat_l,"<br>",
                            "Prey paristation  :",laby_cp_4_year$lop,"<br>",
                            "Liver parasitation:",laby_cp_4_year$liver_co,"<br>"
          ),layout.hoverlabel = "left")%>%
  layout(legend=list(title=list(text='<b> Trend </b>')),
         xaxis = list(range = c(0,54),title = "Week [#]", showticklabels = TRUE, showgrid=TRUE), 
         yaxis = list(
           #range = c(0,150), 
           title = "Length growth [mm]", showticklabels = TRUE, showgrid=TRUE),
         title = "Length growth (4 boxes with Parasites (CB))",
         hoverlabel=list(align ="left")
  )

laby_cp_4_year_length



laby_cp_4_year_cf <- 0
laby_cp_4_year_cf <- laby_cp_4_year %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~week,
          y = ~cf,
          color = ~identifyer,
          symbol = ~sex,
          hoverinfo = "text",
          hovertext = paste("<b>",laby_cp_4_year$identifyer," aka ",laby_cp_4_year$ch_name,"</b><br>",
                            "in Box Nr.",laby_cp_4_year$res_box,"(",laby_cp_4_year$boxname_res,")","<br><br>",
                            "Length     :",laby_cp_4_year$length,"mm<br>",
                            "Mass       :",laby_cp_4_year$mass,"g<br>",
                            "Gonads   :",laby_cp_4_year$gonad_weight,"g<br>",
                            "Condition :",laby_cp_4_year$cf,"<br>",
                            "Sex         :",laby_cp_4_year$sex_l,"-",laby_cp_4_year$sex_mat_l,"<br>",
                            "Prey paristation  :",laby_cp_4_year$lop,"<br>",
                            "Liver parasitation:",laby_cp_4_year$liver_co,"<br>"
          ))%>%
  layout(legend=list(title=list(text='<b> Trend </b>')),
         xaxis = list(range = c(0,54),title = "Week [#]", showticklabels = TRUE, showgrid=TRUE), 
         yaxis = list(
           #range = c(0,150), 
           title = "Condition factor", showticklabels = TRUE, showgrid=TRUE),
         title = "Condition factor (4 boxes with Parasites (CB))",
         hoverlabel=list(align ="left")
  )

laby_cp_4_year_cf



laby_cp_4_year_co <- 0
laby_cp_4_year_co <- laby_cp_4_year %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~week,
          y = ~liver_co,
          color = ~identifyer,
          symbol = ~sex,
          hoverinfo = "text",
          hovertext = paste("<b>",laby_cp_4_year$identifyer," aka ",laby_cp_4_year$ch_name,"</b><br>",
                            "in Box Nr.",laby_cp_4_year$res_box,"(",laby_cp_4_year$boxname_res,")","<br><br>",
                            "Length     :",laby_cp_4_year$length,"mm<br>",
                            "Mass       :",laby_cp_4_year$mass,"g<br>",
                            "Gonads   :",laby_cp_4_year$gonad_weight,"g<br>",
                            "Condition :",laby_cp_4_year$cf,"<br>",
                            "Sex         :",laby_cp_4_year$sex_l,"-",laby_cp_4_year$sex_mat_l,"<br>",
                            "Prey paristation  :",laby_cp_4_year$lop,"<br>",
                            "Liver parasitation:",laby_cp_4_year$liver_co,"<br>"
          ))%>%
  layout(legend=list(title=list(text='<b> Trend </b>')),
         xaxis = list(range = c(0,54),title = "Week [#]", showticklabels = TRUE, showgrid=TRUE), 
         yaxis = list(
           #range = c(0,150), 
           title = "Liver infestation with C.O.", showticklabels = TRUE, showgrid=TRUE),
         title = "Liver parasitation (4 boxes with Parasites (CB))",
         hoverlabel=list(align ="left")
  )

laby_cp_4_year_co



# Analyse some things
end <- subset(laby_cp_4_year,(week == 52))
end <- subset(end, identifyer!='NA')
end <- arrange(end,identifyer)

Analysis_laby_cp_4 <- end

rm(end)

Analysis_laby_cp_4$Hunts_pDay <- ((Analysis_laby_cp_4$Hunting/2)/365)
Analysis_laby_cp_4$Conv_Efficiency <- ((Analysis_laby_cp_4$mass_growth+Analysis_laby_cp_4$gonad_weight)/Analysis_laby_cp_4$stc_prey_count)
#Analysis_laby_cp_4$Swimming_Expenditure_Joule <- ((Analysis_laby_cp_4$Swimming)*2.7)
Analysis_laby_cp_4$Swimming_Mass_Eq <- ((Analysis_laby_cp_4$Swimming)*0.00587/6)


Analysis_laby_cp_4$time<-NULL
Analysis_laby_cp_4$Eating<-NULL
Analysis_laby_cp_4$Hunting<-NULL
Analysis_laby_cp_4$JPO_egg_counter<-NULL
Analysis_laby_cp_4$Swimming<-NULL
Analysis_laby_cp_4$boxnumber<-NULL
Analysis_laby_cp_4$gonad_maturity<-NULL
Analysis_laby_cp_4$oxygen<-NULL
Analysis_laby_cp_4$prey_availability<-NULL
Analysis_laby_cp_4$sex_gon<-NULL
Analysis_laby_cp_4$x<-NULL
Analysis_laby_cp_4$y<-NULL
Analysis_laby_cp_4$boxname<-NULL
Analysis_laby_cp_4$x_1<-NULL
Analysis_laby_cp_4$y_1<-NULL
Analysis_laby_cp_4$sex_l<-NULL
Analysis_laby_cp_4$sex_mat_l<-NULL
Analysis_laby_cp_4$ch_name<-NULL
Analysis_laby_cp_4$boxname_res<-NULL
Analysis_laby_cp_4$day<-NULL
Analysis_laby_cp_4$temperature<-NULL
Analysis_laby_cp_4$eggnumber<-NULL
Analysis_laby_cp_4$identifyer<-NULL
Analysis_laby_cp_4$length_growth<-NULL
Analysis_laby_cp_4$mass_growth<-NULL
Analysis_laby_cp_4$Eggs<-NULL
#Analysis_laby_cp_4$liver_co<-NULL
Analysis_laby_cp_4$rep_cyc<-NULL
Analysis_laby_cp_4$res_box<-NULL
Analysis_laby_cp_4$sex<-NULL
Analysis_laby_cp_4$stc_variable<-NULL
Analysis_laby_cp_4$week<-NULL
Analysis_laby_cp_4$Mating<-NULL
Analysis_laby_cp_4$gonad_weight<-NULL


plot(Analysis_laby_cp_4,main = "Analysis (4 Boxes with Parasites (CB))")
