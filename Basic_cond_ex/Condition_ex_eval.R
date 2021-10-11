# Evaluate results from the Condition_ex_SESSL.txt (scala experiment run with SESSL) experiment (using the Condition_ex.mlrj model)
# Experiment simulates a 12 week feeding experiment with varying oxygenation
# Experiment result is named 'result_condition_ex'
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
condition_ex<- data.frame(
  "initial_weight" = numeric(),
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
while (p<=1199) # number of configurations from 0
{
  while (r<=19) # results per configurations from 0
  {input1 <- read.csv(paste("result_condition_ex/config-",p,"/config.csv",sep=""),stringsAsFactors=FALSE);
  input2 <- read.csv(paste("result_condition_ex/config-",p,"/run-",q,".csv",sep=""),stringsAsFactors=FALSE);
  f0<-(input2[3,2]);
  l0<-(input2[4,3]);
  w0<-(input2[4,5]);
  iw0<-as.numeric(input2[2,5]);
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
  
  condition_ex[nrow(condition_ex)+1,] <- c(iw0,o0,p0,f3[1],l3[1],w3[1]);
  
  rm(p0,f0,l0,w0,o0,f1,l1,w1,f2,l2,w2,f3,l3,w3,iw0);
  
  r<-r+1;
  q<-q+1;
  }
  p<-p+1;
  r<-0;
}

rm(input1,input2,p,q,r)



# add calculated columns
condition_ex$initial_cf <- ((condition_ex$initial_weight)/((450)^3))*100000
condition_ex$condition_factor <- ((condition_ex$weight)/((condition_ex$length)^3))*100000
condition_ex$length_gain <- (condition_ex$length-442)
condition_ex$weight_gain <- (condition_ex$weight-715)
condition_ex$cf_gain <- (condition_ex$condition_factor-0.83)


# tidy up - round all values to 2 decimal places
condition_ex<-round_df(condition_ex, 2, rf = "round")


# crate and fill data frame for comparison with wet-lab experiment

# create subsets for level of infestation
l1	<-	subset(condition_ex	,(lop ==	0	))
l2	<-	subset(condition_ex	,(lop	==	1	))

# create subsets for initial condition factor
cf1  <- subset(l1, (initial_cf == 0.66))
cf2  <- subset(l1, (initial_cf == 0.76))
cf3  <- subset(l1, (initial_cf == 0.85))
cf4  <- subset(l1, (initial_cf == 0.95))
cf5  <- subset(l1, (initial_cf == 1.04))
cf6  <- subset(l2, (initial_cf == 0.66))
cf7  <- subset(l2, (initial_cf == 0.76))
cf8  <- subset(l2, (initial_cf == 0.85))
cf9  <- subset(l2, (initial_cf == 0.95))
cf10  <- subset(l2, (initial_cf == 1.04))




# create mega dataframe without wet-lab results
comp_condition_ex <- data.frame(
  "oxygen" = numeric(),
  "initial_cf" = numeric(),
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
while (p<=10) # number of configurations from 0
{
  
  condition_sort <- eval(parse(text = paste("cf",p,sep="")))
  
  o45 <- subset(condition_sort,(oxygen == 45))
  o56 <- subset(condition_sort,(oxygen == 56))
  o65 <- subset(condition_sort,(oxygen == 65))
  o75 <- subset(condition_sort,(oxygen == 75))
  o84 <- subset(condition_sort,(oxygen == 84))
  o93 <- subset(condition_sort,(oxygen == 93))
  
  
  # input mean and sd for each value and experiment
  ox <- c(45,56,65,75,84,93)
  a <- 1
  while(a<=6){
    o <- as.integer(ox[a]);
    comp_condition_ex[nrow(comp_condition_ex)+1,] <- list(eval(parse(text=(paste("o",o,"$oxygen[1]",sep="")))),
eval(parse(text=(paste("mean(o",o,"$initial_cf)",sep="")))),
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

rm(p,l1,l2,condition_sort,cf1,cf2,cf3,cf4,cf5,cf6,cf7,cf8,cf9,cf10)


short<-comp_condition_ex
short$type<-NULL
plot(condition_ex)




# assign names to level of parasitation
comp_condition_ex$parasitation<-
comp_condition_ex$parasitation[comp_condition_ex$lop==0]<-"none"
comp_condition_ex$parasitation[comp_condition_ex$lop==1]<-"all"
comp_condition_ex$parasitation[is.na(comp_condition_ex$lop)]<-NA


# assign qualitative descriptions to initial condition factor
comp_condition_ex$icf<-
  comp_condition_ex$icf[comp_condition_ex$initial_cf==0.66]<-"min"
comp_condition_ex$icf[comp_condition_ex$initial_cf==0.76]<-"low"
comp_condition_ex$icf[comp_condition_ex$initial_cf==0.85]<-"medium"
comp_condition_ex$icf[comp_condition_ex$initial_cf==0.95]<-"high"
comp_condition_ex$icf[comp_condition_ex$initial_cf==1.04]<-"max"
comp_condition_ex$icf[is.na(comp_condition_ex$initial_cf)]<-NA

# divide into with and without parasitation
comp_condition_ex_00	<-	subset(comp_condition_ex	,(lop ==	0	))
comp_condition_ex_10	<-	subset(comp_condition_ex	,(lop ==	1	))



# round to 4 decimal places
condition_ex<-round_df(condition_ex, 4, rf = "round")


# add name for simulation/wet-lab


 
#oxygen	mean_lenght	sd_length	mean_weight	sd_weight	mean_cf	sd_cf
# add wet-lab results from (Chabot & Dutil 1999)
comp_condition_ex_10[nrow(comp_condition_ex_10)+1,] <- list(45,0.84,40.66,4.66,331.5,47.25,0.095,0.045,0,"wet-lab","none","wet-lab/medium") 
comp_condition_ex_10[nrow(comp_condition_ex_10)+1,] <- list(56,0.84,52.66,5.66,500,73.5,0.1675,0.04,0,"wet-lab","none","wet-lab/medium") 
comp_condition_ex_10[nrow(comp_condition_ex_10)+1,] <- list(65,0.84,63,5,631.5,94.5,0.22,0.04,0,"wet-lab","none","wet-lab/medium") 
comp_condition_ex_10[nrow(comp_condition_ex_10)+1,] <- list(75,0.84,60.33,5,589.25,99.75,0.2,0.0425,0,"wet-lab","none","wet-lab/medium") 
comp_condition_ex_10[nrow(comp_condition_ex_10)+1,] <- list(84,0.84,66.33,8.33,784,120.75,0.275,0.05,0,"wet-lab","none","wet-lab/medium") 
comp_condition_ex_10[nrow(comp_condition_ex_10)+1,] <- list(93,0.84,60,6.33,721,120.75,0.265,0.05,0,"wet-lab","none","wet-lab/medium") 



# plots comparing to wet lab results
Condition_length_gain <- ggplot(data = comp_condition_ex_10, 
                                aes(x=oxygen, 
                                    y=mean_length,
                                    color=type,
                                    shape=icf)) + 
  geom_errorbar(aes(ymin=mean_length-sd_length, ymax=mean_length+sd_length), width=0.7, position=position_dodge(width = 6)) +
  geom_point(size=3, position=position_dodge(width = 6)) +
  xlim(40,100) +
  ylim(20,110) +
  scale_shape_manual(values=c(15,18,17,19,16,20),name  ="Initial condition factor") +
  scale_color_manual(values=c("black", "darkslategray3"), name  ="Experiment type") +
  xlab("Oxygen saturation (%)") + 
  ylab("Length gain [mm]") + 	
  ggtitle("Length gain at differnt oxygen saturations\n for low condition factor leading to parasitation") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Condition_length_gain


Condition_weight_gain <- ggplot(data=comp_condition_ex_10, 
                                aes(x=oxygen, 
                                    y=mean_weight,
                                    color=type,
                                    shape=icf)) + 
  geom_errorbar(aes(ymin=mean_weight-sd_weight, ymax=mean_weight+sd_weight), width=.7, position=position_dodge(width = 5)) +
  geom_point(size=3, position=position_dodge(width = 5)) +
  xlim(40,100) +
  ylim(150,1400) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(15,18,17,19,16,20),name  ="Initial condition factor") +
  xlab("Oxygen saturation [%]") + 
  ylab("Gain in weight") + 	
  ggtitle("Gain in weight at different oxygen saturations\n for low condition factor leading to parasitation") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Condition_weight_gain


Condition_cf_gain <- ggplot(data=comp_condition_ex_10, 
                            aes(x=oxygen, 
                                y=mean_cf,
                                color=type,
                                shape=icf)) + 
  geom_errorbar(aes(ymin=mean_cf-sd_cf, ymax=mean_cf+sd_cf), width=.7, position=position_dodge(width = 5)) +
  geom_point(size=3, position=position_dodge(width = 5)) +
  xlim(40,100) +
  ylim(0,0.5) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(15,18,17,19,16,20),name  ="Initial condition factor") +
  xlab("Oxygen saturation [%]") + 
  ylab("Gain in condition factor") + 	
  ggtitle("Gain in condition factor at different oxygen saturations\n for low condition factor leading to parasitation") + 	
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Condition_cf_gain



# display plot
plot(condition_ex)




# assign names to level of parasitation
condition_ex$parasitation<-
  condition_ex$parasitation[condition_ex$lop==0]<-"none"
condition_ex$parasitation[condition_ex$lop==1]<-"all"
condition_ex$parasitation[is.na(condition_ex$lop)]<-NA


# assign qualitative descriptions to initial condition factor
condition_ex$icf<-
  condition_ex$icf[condition_ex$initial_cf==0.66]<-"min"
condition_ex$icf[condition_ex$initial_cf==0.76]<-"low"
condition_ex$icf[condition_ex$initial_cf==0.85]<-"medium"
condition_ex$icf[condition_ex$initial_cf==0.95]<-"high"
condition_ex$icf[condition_ex$initial_cf==1.04]<-"max"
condition_ex$icf[is.na(condition_ex$initial_cf)]<-NA


# divide into with and without parasitation
condition_ex_00	<-	subset(condition_ex	,(lop ==	0	))
condition_ex_10	<-	subset(condition_ex	,(lop ==	1	))



#plot additional results
p_condition_length <- 0
p_condition_length <- condition_ex_10 %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~length,
          color = ~icf,
          colors = c("firebrick","darkviolet","royalblue","forestgreen","yellow"),
          hoverinfo = "text",
          hovertext = paste
          ("Liver infestation level :",condition_ex_10$liver,"[0-20]<br>",
            "Prey infestation level :",condition_ex_10$lop,"[0-1]<br>",
            "Weight                        :",condition_ex_10$weight,"[mm]<br>",
            "Initial ondition factor          :",condition_ex_10$initial_cf,"<br>",
            "Condition factor          :",condition_ex_10$condition_factor,"<br>"
          ))%>% layout(title = "Weight at different oxygen levels <br> with parasite infestation dependent on condition factor",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Length [mm]"))

p_condition_length




p_condition_weight <- 0
p_condition_weight <- condition_ex_10 %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~weight,
          color = ~icf,
          colors = c("firebrick","darkviolet","royalblue","forestgreen"),
          hoverinfo = "text",
          hovertext = paste
          (" Liver infestation level :",condition_ex_10$liver,"[0-20]<br>",
            "Prey infestation level :",condition_ex_10$lop,"[0-1]<br>",
            "Weight                       :",condition_ex_10$weight,"[g]<br>",
            "Initial ondition factor          :",condition_ex_10$initial_cf,"<br>",
            "Condition factor        :",condition_ex_10$condition_factor,"<br>"
          ))%>% layout(title = "Weight at different oxygen levels <br> with parasite infestation dependent on condition factor",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Weight[g]"))

p_condition_weight




#plot a result
p_condition_cf <- 0
p_condition_cf <- condition_ex_10 %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~condition_factor,
          color = ~icf,
          colors = c("firebrick","darkviolet","royalblue","forestgreen"),
          hoverinfo = "text",
          hovertext = paste
          (" Prey parasitation level :",condition_ex_10$lop,"[0-1]<br>",
            "Cod infestation level    :",condition_ex_10$liver,"[0-20]<br>",
            "Weight                       :",condition_ex_10$weight,"[g]<br>",
            "Length                       :",condition_ex_10$length,"[mm]<br>",
            "Initial ondition factor          :",condition_ex_10$initial_cf,"<br>",
            "Condition factor        :",condition_ex_10$condition_factor,"<br>"
          ))%>% layout(title = "Weight at different oxygen levels <br> with parasite infestation dependent on condition factor",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Condition factor"))

p_condition_cf







pp_comp_condition_ex <- subset(comp_condition_ex,comp_condition_ex$type=="simulation")


# assign names to level of food intake level
pp_comp_condition_ex$infestation<-
  pp_comp_condition_ex$infestation[pp_comp_condition_ex$lop==0.0]<-"0.0 none"
pp_comp_condition_ex$infestation[pp_comp_condition_ex$lop==1.0]<-"1.0 all"
pp_comp_condition_ex$infestation[is.na(pp_comp_condition_ex$var)]<-NA



pp_comp_condition_ex$condition<-
  pp_comp_condition_ex$condition[pp_comp_condition_ex$initial_cf==0.7]<-"0.7 min"
pp_comp_condition_ex$condition[pp_comp_condition_ex$initial_cf==0.8]<-"0.8 low"
pp_comp_condition_ex$condition[pp_comp_condition_ex$initial_cf==0.9]<-"0.9 medium"
pp_comp_condition_ex$condition[pp_comp_condition_ex$initial_cf==1.0]<-"1.0 high"
pp_comp_condition_ex$condition[pp_comp_condition_ex$initial_cf==1.1]<-"1.1 max"
pp_comp_condition_ex$condition[is.na(pp_comp_condition_ex$initial_cf)]<-NA




#plot a result for publication
pp_condition_length <- 0
pp_condition_length <- pp_comp_condition_ex %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~mean_length+442,
          symbol = ~infestation,
          #symbols = c(21,23,24,25),
          color = ~condition,
          colors = gray,
          marker = list(
            size = 18,
            opacity = 0.8,
            line = list(
              color = 'rgb(0, 0, 0)',
              width = 1),
          showlegend=T))%>% 
  layout(
    margin = list(t=50),
    
    title = list(
      text="Growth for different oxygen and prey infestation levels H2",
      font= list(size = 25)),
    
    xaxis = list(title = list(
      text="Oxygen Saturation [%]",
      font= list(size = 20)),
      tickfont = list(size = 15)),
    
    yaxis = list(title = list(
      text="Average Final Length [mm]",
      font= list(size = 20)),
      tickfont = list(size = 15)),
    
    legend = list(
      title = list(text="<b> Food intake level </b>",font= list(size = 18)),
      font = list(size = 15),
      x = 0.02, y = 0.98))


pp_condition_length





