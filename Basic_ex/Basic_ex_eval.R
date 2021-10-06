# Evaluate results from the Basic_ex_SESSL.txt (scala experiment run with SESSL) experiment (using the Basic_ex.mlrj model)
# Experiment simulates a 12 week feeding experiment with varying oxygenation
# Experiment result is named 'result_basic_ex'
# Evaluation compares simulation with wet-lab data from (Chabot & Dutil 1999)


# load necessary packages
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


# initialise data.frame
basic_ex<- data.frame(
  "oxygen" = numeric(),
  "length" = numeric(),
  "weight" = numeric(),
  stringsAsFactors=FALSE)


# import data
p=0 # first configuration
q=0 # first result
r=0 # first result
while (p<=5) # number of configurations from 0
{
  while (r<=19) # number of replications from 0 (19)
  {input1 <- read.csv(paste("result_basic_ex/config-",p,"/config.csv",sep=""),stringsAsFactors=FALSE);
  input2 <- read.csv(paste("result_basic_ex/config-",p,"/run-",q,".csv",sep=""),stringsAsFactors=FALSE);
  l0<-(input2[2,2]);
  w0<-(input2[2,3]);
  o0<-as.integer(input1[1,2]);
  
  l1<-gsub("\\]","",(gsub("\\[","",l0)));
  w1<-gsub("\\]","",(gsub("\\[","",w0)));
  
  l2<-scan(text =(l1), sep=",");
  w2<-scan(text =(w1), sep=",");
  
  l3<-as.list(l2);
  w3<-as.list(w2);
  
  basic_ex[nrow(basic_ex)+1,] <- c(o0,l3[1],w3[1]);
  
  rm(l0,w0,o0,l1,w1,l2,w2,l3,w3);
  
  r<-r+1;
  q<-q+1;
  }
  p<-p+1;
  r<-0;
}

rm(input1,input2,p,q,r)


# tidy up - round all values to 2 decimal places
basic_ex<-round_df(basic_ex, 2, rf = "round")


# prepare data frame for comparison with wet lab results (Chabot & Dutil 1999)
# add calculated columns
basic_ex$condition_factor <- ((basic_ex$weight)/((basic_ex$length)^3))*100000
basic_ex$length_gain <- (basic_ex$length-442)
basic_ex$weight_gain <- (basic_ex$weight-715)
basic_ex$cf_gain <- (basic_ex$condition_factor-0.83)

o45 <- subset(basic_ex,(oxygen == 45))
o56 <- subset(basic_ex,(oxygen == 56))
o65 <- subset(basic_ex,(oxygen == 65))
o75 <- subset(basic_ex,(oxygen == 75))
o84 <- subset(basic_ex,(oxygen == 84))
o93 <- subset(basic_ex,(oxygen == 93))

comp_basic_ex <- data.frame(
  "oxygen" = numeric(),
  "mean_length" = numeric(),
  "sd_length" = numeric(),
  "mean_weight" = numeric(),
  "sd_weight" = numeric(),
  "mean_cf" = numeric(),
  "sd_cf" = numeric(),
  "type" = character(),
  stringsAsFactors=FALSE)


# input mean and sd for each value and experiment
ox <- c(45,56,65,75,84,93)
a <- 1
while(a<=6){
  o <- as.integer(ox[a]);
  comp_basic_ex[nrow(comp_basic_ex)+1,] <- list(eval(parse(text=(paste("o",o,"$oxygen[1]",sep="")))),
                            eval(parse(text=(paste("mean(o",o,"$length_gain)",sep="")))), 
                            eval(parse(text=(paste("sd(o",o,"$length_gain)",sep="")))),
                            eval(parse(text=(paste("mean(o",o,"$weight_gain)",sep="")))),
                            eval(parse(text=(paste("sd(o",o,"$weight_gain)",sep="")))),
                            eval(parse(text=(paste("mean(o",o,"$cf_gain)",sep="")))),
                            eval(parse(text=(paste("sd(o",o,"$cf_gain)",sep="")))),
                            "simulation");
  a<-a+1;
}

rm(o45,o56,o65,o75,o84,o93,a,o,ox)

#oxygen	mean_lenght	sd_length	mean_weight	sd_weight	mean_cf	sd_cf
# add wet-lab results from (Chabot & Dutil 1999)
comp_basic_ex[nrow(comp_basic_ex)+1,] <- list(45,40.66,4.66,331.5,47.25,0.095,0.045,"wet-lab") 
comp_basic_ex[nrow(comp_basic_ex)+1,] <- list(56,52.66,5.66,500,73.5,0.1675,0.04,"wet-lab") 
comp_basic_ex[nrow(comp_basic_ex)+1,] <- list(65,63,5,631.5,94.5,0.22,0.04,"wet-lab") 
comp_basic_ex[nrow(comp_basic_ex)+1,] <- list(75,60.33,5,589.25,99.75,0.2,0.0425,"wet-lab") 
comp_basic_ex[nrow(comp_basic_ex)+1,] <- list(84,66.33,8.33,784,120.75,0.275,0.05,"wet-lab") 
comp_basic_ex[nrow(comp_basic_ex)+1,] <- list(93,60,6.33,721,120.75,0.265,0.05,"wet-lab") 



# plot results
Basic_length_gain <- ggplot(data = comp_basic_ex, 
        aes(x=oxygen, 
            y=mean_length,
            color=type,
            shape=type)) + 
  geom_errorbar(aes(ymin=mean_length-sd_length, ymax=mean_length+sd_length), width=0.7) +
  geom_point(size=3) +
  xlim(40,100) +
  ylim(20,90) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(17,19),name  ="Experiment type") +
  xlab("Oxygen saturation (%)") + 
  ylab("Length gain [mm]") + 	
  ggtitle("Length gain at differnt oxygen saturations\n for Basic physiology") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Basic_length_gain



Basic_weight_gain <- ggplot(data=comp_basic_ex, 
        aes(x=oxygen, 
            y=mean_weight,
            color=type,
            shape=type)) + 
  geom_errorbar(aes(ymin=mean_weight-sd_weight, ymax=mean_weight+sd_weight), width=.7) +
  geom_point(size=3) +
  xlim(40,100) +
  ylim(200,1050) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(17,19),name  ="Experiment type") +
  xlab("Oxygen saturation [%]") + 
  ylab("Weight gain [g]") + 	
  ggtitle("Gain in weight at different oxygen saturations\n for Basic physiology") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Basic_weight_gain


Basic_cf_gain <- ggplot(data=comp_basic_ex, 
        aes(x=oxygen, 
            y=mean_cf,
            color=type,
            shape=type)) + 
  geom_errorbar(aes(ymin=mean_cf-sd_cf, ymax=mean_cf+sd_cf), width=.7) +
  geom_point(size=3) +
  xlim(40,100) +
  ylim(0,0.35) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(17,19),name  ="Experiment type") +
  xlab("Oxygen saturation [%]") + 
  ylab("Gain in condition factor") + 	
  ggtitle("Gain in condition factor at different oxygen saturations\n for Basic physiology") + 	
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")


# display plot
Basic_cf_gain

