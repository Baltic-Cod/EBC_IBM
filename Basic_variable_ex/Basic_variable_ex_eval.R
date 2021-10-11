# Evaluate results from the Basic_variable_ex_SESSL.txt (scala experiment run with SESSL) experiment (using the Basic_ex.mlrj model)
# Experiment simulates a 12 week feeding experiment with varying oxygenation
# Experiment result is named 'result_basic_variable_ex'
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
basic_variable_ex<- data.frame(
  "oxygen" = numeric(),
  "var"    = numeric(),
  "length" = numeric(),
  "weight" = numeric(),
  stringsAsFactors=FALSE)


# import data
p=0 # first configuration
q=0 # first result
r=0 # first result
while (p<=23) # number of configurations from 0
{
  while (r<=19) # number of replications from 0 (19)
  {input1 <- read.csv(paste("result_basic_variable_ex/config-",p,"/config.csv",sep=""),stringsAsFactors=FALSE);
  input2 <- read.csv(paste("result_basic_variable_ex/config-",p,"/run-",q,".csv",sep=""),stringsAsFactors=FALSE);
  l0<-(input2[2,2]);
  w0<-(input2[2,3]);
  o0<-as.integer(input1[1,2]);
  v0<-(input1[3,2]);
  
  l1<-gsub("\\]","",(gsub("\\[","",l0)));
  w1<-gsub("\\]","",(gsub("\\[","",w0)));
  
  l2<-scan(text =(l1), sep=",");
  w2<-scan(text =(w1), sep=",");
  
  l3<-as.list(l2);
  w3<-as.list(w2);
  
  basic_variable_ex[nrow(basic_variable_ex)+1,] <- c(o0,v0,l3[1],w3[1]);
  
  rm(l0,v0,w0,o0,l1,w1,l2,w2,l3,w3);
  
  r<-r+1;
  q<-q+1;
  }
  p<-p+1;
  r<-0;
}

rm(input1,input2,p,q,r)


# tidy up - round all values to 2 decimal places
basic_variable_ex<-round_df(basic_variable_ex, 2, rf = "round")


# prepare data frame for comparison with wet lab results (Chabot & Dutil 1999)
# add calculated columns
basic_variable_ex$condition_factor <- ((basic_variable_ex$weight)/((basic_variable_ex$length)^3))*100000
basic_variable_ex$length_gain <- (basic_variable_ex$length-442)
basic_variable_ex$weight_gain <- (basic_variable_ex$weight-715)
basic_variable_ex$cf_gain <- (basic_variable_ex$condition_factor-0.83)


# create subsets for different food intake levels
v1	<-	subset(basic_variable_ex	,(var ==	0.25	))
v2	<-	subset(basic_variable_ex	,(var	==	0.5	))
v3	<-	subset(basic_variable_ex	,(var	==	0.75	))
v4	<-	subset(basic_variable_ex	,(var	==	1	))



# create mega dataframe without wet-lab results
comp_basic_variable_ex <- data.frame(
  "oxygen" = numeric(),
  "mean_length" = numeric(),
  "sd_length" = numeric(),
  "mean_weight" = numeric(),
  "sd_weight" = numeric(),
  "mean_cf" = numeric(),
  "sd_cf" = numeric(),
  "var" = numeric(),
  "type" = character(),
  stringsAsFactors=FALSE)


# produce data frame containing means and sd per level of parasitation and oxygen
p=1
while (p<=4) # number of configurations from 0
{
  
  basic_variable_sort <- eval(parse(text = paste("v",p,sep="")))
  
  o45 <- subset(basic_variable_sort,(oxygen == 45))
  o56 <- subset(basic_variable_sort,(oxygen == 56))
  o65 <- subset(basic_variable_sort,(oxygen == 65))
  o75 <- subset(basic_variable_sort,(oxygen == 75))
  o84 <- subset(basic_variable_sort,(oxygen == 84))
  o93 <- subset(basic_variable_sort,(oxygen == 93))
  
  
  # input mean and sd for each value and experiment
  ox <- c(45,56,65,75,84,93)
  a <- 1
  while(a<=6){
    o <- as.integer(ox[a]);
    comp_basic_variable_ex[nrow(comp_basic_variable_ex)+1,] <- list(eval(parse(text=(paste("o",o,"$oxygen[1]",sep="")))),
                                                  eval(parse(text=(paste("mean(o",o,"$length_gain)",sep="")))), 
                                                  eval(parse(text=(paste("sd(o",o,"$length_gain)",sep="")))),
                                                  eval(parse(text=(paste("mean(o",o,"$weight_gain)",sep="")))),
                                                  eval(parse(text=(paste("sd(o",o,"$weight_gain)",sep="")))),
                                                  eval(parse(text=(paste("mean(o",o,"$cf_gain)",sep="")))),
                                                  eval(parse(text=(paste("sd(o",o,"$cf_gain)",sep="")))),
                                                  eval(parse(text=(paste("mean(o",o,"$var)",sep="")))),
                                                  "simulation");
    a<-a+1;
  }
  
  rm(o45,o56,o65,o75,o84,o93,a,o,ox)
  
  p <- p+1
}

rm(p,v1,v2,v3,v4,basic_variable_sort)


#oxygen	mean_lenght	sd_length	mean_weight	sd_weight	mean_cf	sd_cf
# add wet-lab results from (Chabot & Dutil 1999)
comp_basic_variable_ex[nrow(comp_basic_variable_ex)+1,] <- list(45,40.66,4.66,331.5,47.25,0.095,0.045,1,"wet-lab") 
comp_basic_variable_ex[nrow(comp_basic_variable_ex)+1,] <- list(56,52.66,5.66,500,73.5,0.1675,0.04,1,"wet-lab") 
comp_basic_variable_ex[nrow(comp_basic_variable_ex)+1,] <- list(65,63,5,631.5,94.5,0.22,0.04,1,"wet-lab") 
comp_basic_variable_ex[nrow(comp_basic_variable_ex)+1,] <- list(75,60.33,5,589.25,99.75,0.2,0.0425,1,"wet-lab") 
comp_basic_variable_ex[nrow(comp_basic_variable_ex)+1,] <- list(84,66.33,8.33,784,120.75,0.275,0.05,1,"wet-lab") 
comp_basic_variable_ex[nrow(comp_basic_variable_ex)+1,] <- list(93,60,6.33,721,120.75,0.265,0.05,1,"wet-lab") 



# assign names to level of food intake level
comp_basic_variable_ex$food_intake_level<-
  comp_basic_variable_ex$food_intake_level[comp_basic_variable_ex$var==0]<-"low"
comp_basic_variable_ex$food_intake_level[comp_basic_variable_ex$var==0.25]<-"medium"
comp_basic_variable_ex$food_intake_level[comp_basic_variable_ex$var==0.75]<-"high"
comp_basic_variable_ex$food_intake_level[comp_basic_variable_ex$var==1]<-"max"
comp_basic_variable_ex$food_intake_level[is.na(comp_basic_variable_ex$var)]<-NA





# plot results
Basic_variable_length_gain <- ggplot(data = comp_basic_variable_ex, 
                            aes(x=oxygen, 
                                y=mean_length,
                                color=type,
                                shape=food_intake_level)) + 
  geom_errorbar(aes(ymin=mean_length-sd_length, ymax=mean_length+sd_length), width=0.7) +
  geom_point(size=3) +
  xlim(40,100) +
  ylim(20,90) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(15,18,17,19),name  ="Food intake level") +
  xlab("Oxygen saturation (%)") + 
  ylab("Length gain [mm]") + 	
  ggtitle("Length gain at differnt oxygen saturations\n for variable physiology") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Basic_variable_length_gain



Basic_variable_weight_gain <- ggplot(data=comp_basic_variable_ex, 
                            aes(x=oxygen, 
                                y=mean_weight,
                                color=type,
                                shape=food_intake_level)) + 
  geom_errorbar(aes(ymin=mean_weight-sd_weight, ymax=mean_weight+sd_weight), width=.7) +
  geom_point(size=3) +
  xlim(40,100) +
  ylim(0,900) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(15,18,17,19),name  ="Food intake level") +
  xlab("Oxygen saturation [%]") + 
  ylab("Weight gain [g]") + 	
  ggtitle("Gain in weight at different oxygen saturations\n for variable physiology") + 
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")

# display plot
Basic_variable_weight_gain


Basic_variable_cf_gain <- ggplot(data=comp_basic_variable_ex, 
                        aes(x=oxygen, 
                            y=mean_cf,
                            color=type,
                            shape=food_intake_level)) + 
  geom_errorbar(aes(ymin=mean_cf-sd_cf, ymax=mean_cf+sd_cf), width=.7) +
  geom_point(size=3) +
  xlim(40,100) +
  ylim(0,0.35) +
  scale_color_manual(values=c("black", "darkslategray3"),name  ="Experiment type") +
  scale_shape_manual(values=c(15,18,17,19),name  ="Food intake level") +
  xlab("Oxygen saturation [%]") + 
  ylab("Gain in condition factor") + 	
  ggtitle("Gain in condition factor at different oxygen saturations\n for Variable physiology") + 	
  theme_bw() +
  theme(legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left")


# display plot
Basic_variable_cf_gain







# additional plots
plot(basic_variable_ex)



# Plot results - additional views

# assign names to level of food intake level
basic_variable_ex$food_intake_level<-
  basic_variable_ex$food_intake_level[basic_variable_ex$var==0.25]<-"low"
basic_variable_ex$food_intake_level[basic_variable_ex$var==0.5]<-"medium"
basic_variable_ex$food_intake_level[basic_variable_ex$var==0.75]<-"high"
basic_variable_ex$food_intake_level[basic_variable_ex$var==1]<-"max"
basic_variable_ex$food_intake_level[is.na(basic_variable_ex$var)]<-NA

# round to 4 decimal places
basic_variable_ex<-round_df(basic_variable_ex, 4, rf = "round")



#plot a result
p_basic_variable_length <- 0
p_basic_variable_length <- basic_variable_ex %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~length,
          color = ~food_intake_level,
          colors = c("firebrick","darkviolet","royalblue","forestgreen"),
          hoverinfo = "text",
          hovertext = paste
          (" Food intake level:",basic_variable_ex$var,"[0-1]<br>",
            "Length                :",basic_variable_ex$length,"[mm]<br>",
            "Condition factor  :",basic_variable_ex$condition_factor,"<br>"
          ))%>% layout(title = "Length at different oxygen levels <br> with variable food intake levels",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Length [mm]"))

p_basic_variable_length




p_basic_variable_weight <- 0
p_basic_variable_weight <- basic_variable_ex %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~weight,
          color = ~food_intake_level,
          colors = c("firebrick","darkviolet","royalblue","forestgreen"),
          hoverinfo = "text",
          hovertext = paste
          ("Food intake level :",basic_variable_ex$var,"[0-1]<br>",
            "Weight                       :",basic_variable_ex$weight,"[g]<br>",
            "Condition factor           :",basic_variable_ex$condition_factor,"<br>"
          ))%>% layout(title = "Weight at different oxygen levels <br> with variable food intake levels",
                       xaxis = list(title = "Oxygen Saturation [%]"),
                       yaxis = list(title = "Weight [g]"))

p_basic_variable_weight




#plot a result for paper
pp_basic_variable_length <- 0
pp_basic_variable_length <- basic_variable_ex %>%
  plot_ly(type = 'scatter',mode = 'markers',
          x = ~oxygen,
          y = ~length,
          color = ~Food,
          colors = c("white","grey84","grey45","black"),
          marker = list(
            size = 18,
            opacity = 0.8,
            line = list(
              color = 'rgb(0, 0, 0)',
              width = 1)),
          showlegend=TRUE)%>% 
  layout(
    margin = list(t=50),
    
    title = list(
      text="Growth for different oxygen and food intake levels",
      font= list(size = 25)),
    
    xaxis = list(title = list(
      text="Oxygen Saturation [%]",
      font= list(size = 20)),
      tickfont = list(size = 15)),
    
    yaxis = list(title = list(
      text="Final Length [mm]",
      font= list(size = 20)),
      tickfont = list(size = 15)),
    
    legend = list(
      title = list(text="<b>Food intake level</b>",font= list(size = 18)),
      font = list(size = 20),
      x = 0.04, 
      y = 0.98
      ))


pp_basic_variable_length


