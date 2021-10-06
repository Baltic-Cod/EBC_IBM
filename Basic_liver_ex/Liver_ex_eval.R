# Evaluate results from the Liver_ex_SESSL.txt (scala experiment run with SESSL) experiment (using the Liver_ex.mlrj model)
# Experiment simulates a 12 week feeding experiment with varying oxygenation
# Experiment result is named 'result_liver_ex'
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
library("ggbeeswarm")


# initialise data.frame
liver_ex<- data.frame(
  "oxygen" = numeric(),
  "lop"    = numeric(),
  "liver"  = numeric(),
  "length" = numeric(),
  "weight" = numeric(),
  stringsAsFactors=FALSE)

# loop to read in data
p=0 # first configuration
q=0 # first result
r=0 # first result
while (p<=23) # number of configurations from 0
{
  while (r<=19) # number of replications per configurations from 0
  {input1 <- read.csv(paste("result_liver_ex/config-",p,"/config.csv",sep=""),stringsAsFactors=FALSE);
  input2 <- read.csv(paste("result_liver_ex/config-",p,"/run-",q,".csv",sep=""),stringsAsFactors=FALSE);
  f0<-(input2[3,2]);
  l0<-(input2[4,3]);
  w0<-(input2[4,5]);
  o0<-as.numeric(input1[1,2]);
  p0<-as.numeric(input1[3,2]);
  
  f1<-gsub("\\]","",(gsub("\\[","",f0)));
  l1<-gsub("\\]","",(gsub("\\[","",l0)));
  w1<-gsub("\\]","",(gsub("\\[","",w0)));
  
  f2<-scan(text =(f1), sep=",");
  l2<-scan(text =(l1), sep=",");
  w2<-scan(text =(w1), sep=",");
  
  f3<-as.list(f2);
  l3<-as.list(l2);
  w3<-as.list(w2);
  
  liver_ex[nrow(liver_ex)+1,] <- c(o0,p0,f3[1],l3[1],w3[1]);
  
  rm(p0,f0,l0,w0,o0,f1,l1,w1,f2,l2,w2,f3,l3,w3);
  
  r<-r+1;
  q<-q+1;
  }
  p<-p+1;
  r<-0;
}

rm(input1,input2,p,q,r)


# tidy up - round all values to 2 decimal places
liver_ex<-round_df(liver_ex, 2, rf = "round")


# add calculated columns
liver_ex$condition_factor <- ((liver_ex$weight)/((liver_ex$length)^3))*100000
liver_ex$length_gain <- (liver_ex$length-442)
liver_ex$weight_gain <- (liver_ex$weight-715)
liver_ex$cf_gain <- (liver_ex$condition_factor-0.83)



# create subsets for level of infestation
l1	<-	subset(liver_ex	,(lop ==	0	))
l2	<-	subset(liver_ex	,(lop	==	0.2	))
l3	<-	subset(liver_ex	,(lop	==	0.8	))
l4	<-	subset(liver_ex	,(lop	==	1	))



# create mega dataframe without wet-lab results
comp_liver_ex <- data.frame(
  "oxygen" = numeric(),
  "mean_length" = numeric(),
  "sd_length" = numeric(),
  "mean_weight" = numeric(),
  "sd_weight" = numeric(),
  "mean_cf" = numeric(),
  "sd_cf" = numeric(),
  "lop" = numeric(),
  "type" = character(),
  stringsAsFactors=FALSE)


# produce data frame containing means and sd per level of parasitation and oxygen
p=1
while (p<=4) # number of configurations from 0
{
  
  liver_sort <- eval(parse(text = paste("l",p,sep="")))
  
  o45 <- subset(liver_sort,(oxygen == 45))
  o56 <- subset(liver_sort,(oxygen == 56))
  o65 <- subset(liver_sort,(oxygen == 65))
  o75 <- subset(liver_sort,(oxygen == 75))
  o84 <- subset(liver_sort,(oxygen == 84))
  o93 <- subset(liver_sort,(oxygen == 93))
  
  
# input mean and sd for each value and experiment
  ox <- c(45,56,65,75,84,93)
  a <- 1
  while(a<=6){
    o <- as.integer(ox[a]);
    comp_liver_ex[nrow(comp_liver_ex)+1,] <- list(eval(parse(text=(paste("o",o,"$oxygen[1]",sep="")))),
eval(parse(text=(paste("mean(o",o,"$length_gain)",sep="")))), 
eval(parse(text=(paste("sd(o",o,"$length_gain)",sep="")))),
eval(parse(text=(paste("mean(o",o,"$weight_gain)",sep="")))),
eval(parse(text=(paste("sd(o",o,"$weight_gain)",sep="")))),
eval(parse(text=(paste("mean(o",o,"$cf_gain)",sep="")))),
eval(parse(text=(paste("sd(o",o,"$cf_gain)",sep="")))),
eval(parse(text=(paste("mean(o",o,"$lop)",sep="")))),
"simulation");
    a<-a+1;
  }
  
  rm(o45,o56,o65,o75,o84,o93,a,o,ox)
  
  p <- p+1
}

rm(p,l1,l2,l3,l4,liver_sort)


#oxygen	mean_lenght	sd_length	mean_weight	sd_weight	mean_cf	sd_cf
# add wet-lab results from (Chabot & Dutil 1999)
comp_liver_ex[nrow(comp_liver_ex)+1,] <- list(45,40.66,4.66,331.5,47.25,0.095,0.045,0,"wet-lab") 
comp_liver_ex[nrow(comp_liver_ex)+1,] <- list(56,52.66,5.66,500,73.5,0.1675,0.04,0,"wet-lab") 
comp_liver_ex[nrow(comp_liver_ex)+1,] <- list(65,63,5,631.5,94.5,0.22,0.04,0,"wet-lab") 
comp_liver_ex[nrow(comp_liver_ex)+1,] <- list(75,60.33,5,589.25,99.75,0.2,0.0425,0,"wet-lab") 
comp_liver_ex[nrow(comp_liver_ex)+1,] <- list(84,66.33,8.33,784,120.75,0.275,0.05,0,"wet-lab") 
comp_liver_ex[nrow(comp_liver_ex)+1,] <- list(93,60,6.33,721,120.75,0.265,0.05,0,"wet-lab") 



# assign names to level of parasitation
comp_liver_ex$parasitation<-
  comp_liver_ex$parasitation[comp_liver_ex$lop==0]<-"none"
comp_liver_ex$parasitation[comp_liver_ex$lop==0.2]<-"low"
comp_liver_ex$parasitation[comp_liver_ex$lop==0.8]<-"high"
comp_liver_ex$parasitation[comp_liver_ex$lop==1]<-"all"
comp_liver_ex$parasitation[is.na(comp_liver_ex$lop)]<-NA





# plot results -> export at 750!
Liver_length_gain <- ggplot(data = comp_liver_ex, 
                            aes(x=oxygen, 
                                y=mean_length,
                                color=type,
                                shape=parasitation)) + 
  geom_errorbar(aes(ymin=mean_length-sd_length, ymax=mean_length+sd_length), width=0.7, position=position_dodge(width = 6)) +
  geom_point(size=3, position=position_dodge(width = 6)) +
  xlim(40,100) +
  ylim(30,105) +
  scale_shape_manual(values=c(15,18,17,19),name  ="Level of Parasitation") +
  scale_color_manual(values=c("black", "darkslategray3"), name  ="Experiment type") +
  xlab("Oxygen saturation (%)") + 
  ylab("Length gain [mm]") + 	
  ggtitle("Length gain at differnt oxygen saturations\n for decreased physiological performance with parasitation") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Liver_length_gain


Liver_weight_gain <- ggplot(data=comp_liver_ex, 
                            aes(x=oxygen, 
                                y=mean_weight,
                                color=type,
                                shape=parasitation)) + 
  geom_errorbar(aes(ymin=mean_weight-sd_weight, ymax=mean_weight+sd_weight), width=.7, position=position_dodge(width = 5)) +
  geom_point(size=3, position=position_dodge(width = 5)) +
  xlim(40,100) +
  ylim(250,1000) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(15,18,17,19),name  ="Level of Parasitation") +
  xlab("Oxygen saturation [%]") + 
  ylab("Gain in weight") + 	
  ggtitle("Gain in weight at different oxygen saturations\n for decreased physiological performance with parasitation") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Liver_weight_gain


Liver_cf_gain <- ggplot(data=comp_liver_ex, 
                        aes(x=oxygen, 
                            y=mean_cf,
                            color=type,
                            shape=parasitation)) + 
  geom_errorbar(aes(ymin=mean_cf-sd_cf, ymax=mean_cf+sd_cf), width=.7, position=position_dodge(width = 5)) +
  geom_point(size=3, position=position_dodge(width = 5)) +
  xlim(40,100) +
  ylim(0.05,0.35) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(15,18,17,19),name  ="Level of Parasitation") +
  xlab("Oxygen saturation [%]") + 
  ylab("Gain in condition factor") + 	
  ggtitle("Gain in condition factor at different oxygen saturations\n for decreased physiological performance with parasitation") + 	
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")


# display plot
Liver_cf_gain


# additional plots
plot(liver_ex)



# Plot results - additional views

# assign names to level of parasitation
liver_ex$parasitation<-
  liver_ex$parasitation[liver_ex$lop==0]<-"none"
liver_ex$parasitation[liver_ex$lop==0.2]<-"low"
liver_ex$parasitation[liver_ex$lop==0.8]<-"high"
liver_ex$parasitation[liver_ex$lop==1]<-"all"
liver_ex$parasitation[is.na(liver_ex$lop)]<-NA

# round to 4 decimal places
liver_ex<-round_df(liver_ex, 4, rf = "round")


#plot a result
p_liver_length <- 0
p_liver_length <- liver_ex %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~length,
          color = ~parasitation,
          colors = c("firebrick","darkviolet","royalblue","forestgreen"),
          hoverinfo = "text",
          hovertext = paste
          ("Prey parasitation level :",liver_ex$lop,"[0-1]<br>",
           "Cod infestation level    :",liver_ex$liver,"[0-20]<br>",
           "Length                       :",liver_ex$length,"[mm]<br>",
           "Condition factor          :",liver_ex$condition_factor,"<br>"
          ))%>% layout(title = "Length at different oxygen levels <br> with variable parasitation",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Length [mm]"))

p_liver_length




p_liver_weight <- 0
p_liver_weight <- liver_ex %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~weight,
          color = ~parasitation,
          colors = c("firebrick","darkviolet","royalblue","forestgreen"),
          hoverinfo = "text",
          hovertext = paste
          ("Prey parasitation level :",liver_ex$lop,"[0-1]<br>",
           "Cod infestation level    :",liver_ex$liver,"[0-20]<br>",
           "Weight                       :",liver_ex$weight,"[g]<br>",
           "Condition factor           :",liver_ex$condition_factor,"<br>"
          ))%>% layout(title = "Weight at different oxygen levels <br> with variable parasitation",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Weight [g]"))

p_liver_weight



#plot a result
p_liver_cond <- 0
p_liver_cond <- liver_ex %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~condition_factor,
          color = ~parasitation,
          colors = c("firebrick","darkviolet","royalblue","forestgreen"),
          hoverinfo = "text",
          hovertext = paste
          ("Prey parasitation level :",liver_ex$lop,"[0-1]<br>",
           "Cod infestation level    :",liver_ex$liver,"[0-20]<br>",
           "Weight                       :",liver_ex$weight,"[g]<br>",
           "Length                       :",liver_ex$length,"[mm]<br>"
          ))%>% layout(title = "Codnition factor at different oxygen levels <br> with variable parasitation",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Condition factor"))

p_liver_cond


