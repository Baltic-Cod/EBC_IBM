# Evaluate results from the Basic_asphyx_SESSL.txt (scala experiment run with SESSL) experiment (using the Basic_asphyx.mlrj model)
# Experiment simulates a 12 week feeding experiment with varying oxygenation
# Experiment result is named 'result_basic_asphyx'
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
df_asph<- data.frame(
  "initial_state" =  character(),
  "temperature" = numeric(),
  "oxygen" = numeric(),
  "final_number_of_cod" = numeric(),
  stringsAsFactors=FALSE)




p=0 # first configuration
q=0 # first result
r=0 # fist result
while (p<=47) # number of configurations from 0
{co<-read.csv(paste("result_basic_asphyx/config-",p,"/config.csv",sep=""),stringsAsFactors=FALSE);
ci<-co[1,2];
ct<-as.double(scan(text = co[3,2]));
co<-as.double(scan(text = co[2,2]));
while (r<=0) # number of results from 0
{re<-read.csv(paste("result_basic_asphyx/config-",p,"/run-",q,".csv",sep=""),stringsAsFactors=FALSE);
rf<-re[2,2];
r<-r+1;
q<-q+1;
}
p<-p+1;
r<-0;
df_asph[nrow(df_asph)+1,] <- list(ci,ct,co,rf)
}


# remove surplus objects
rm(ci,co,ct,p,q,r,rf,re);


# get subset for conducted wet-lab experiments 
res <- subset(df_asph,
                (initial_state == "20 GM(560,1790,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]" & temperature == 2) | 
                (initial_state == "20 GM(560,1740,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]" & temperature == 6) | 
                (initial_state == "20 GM(445,890 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]" & temperature == 2) | 
                (initial_state == "20 GM(385,570 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]" & temperature == 6))

# add cumulative mortality and weight to data frame

res$cumulative_mortality <- (20-res$final_number_of_cod)*5

res$weight <- ifelse(res$initial_state=="20 GM(560,1790,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]",1790,
              ifelse(res$initial_state=="20 GM(560,1740,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]",1740,
              ifelse(res$initial_state=="20 GM(445,890 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]",890,
              ifelse(res$initial_state=="20 GM(385,570 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]",570,0))))


res$treatment <- ifelse(res$initial_state=="20 GM(560,1790,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]","1790g at 2°C",
                 ifelse(res$initial_state=="20 GM(560,1740,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]","1740g at 6°C",
                 ifelse(res$initial_state=="20 GM(445,890 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]","890g at 2°C",
                 ifelse(res$initial_state=="20 GM(385,570 ,30,50,1,0,1,'E',0,1,1001)[Stc(0,1,1001)[]]","570g at 6°C","0g"))))

# distinguish simulation results
res$type <- "simulation" 

# add wet-lab results
res[nrow(res)+1,] <- list(NA,6,13.8,NA,100,571,"small at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,17.8,NA,90,571,"small at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,23.7,NA,0,571,"small at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,29.5,NA,0,571,"small at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,36.5,NA,0,571,"small at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,42.5,NA,0,571,"small at 6°C","wet-lab") 

res[nrow(res)+1,] <- list(NA,2,13.8,NA,100,891,"small at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,17.8,NA,90,891,"small at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,23.7,NA,0,891,"small at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,29.5,NA,0,891,"small at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,36.5,NA,0,891,"small at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,42.5,NA,0,891,"small at 2°C","wet-lab") 

res[nrow(res)+1,] <- list(NA,6,13.8,NA,100,1741,"large at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,17.8,NA,100,1741,"large at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,23.7,NA,90,1741,"large at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,29.5,NA,20,1741,"large at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,36.5,NA,0,1741,"large at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,42.5,NA,0,1741,"large at 6°C","wet-lab") 

res[nrow(res)+1,] <- list(NA,2,13.8,NA,100,1791,"large at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,17.8,NA,85,1791,"large at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,23.7,NA,10,1791,"large at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,29.5,NA,20,1791,"large at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,36.5,NA,0,1791,"large at 2°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,2,42.5,NA,0,1791,"large at 2°C","wet-lab") 

res[nrow(res)+1,] <- list(NA,6,13.8,NA,100,1742,"large-r at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,17.8,NA,85,1742,"large-r at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,23.7,NA,10,1742,"large-r at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,29.5,NA,10,1742,"large-r at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,36.5,NA,0,1742,"large-r at 6°C","wet-lab") 
res[nrow(res)+1,] <- list(NA,6,42.5,NA,0,1742,"large-r at 6°C","wet-lab")



# plot results
ggplot(data=res,														# data source
       aes(x=oxygen, 														# x axes values
           y=cumulative_mortality, 											# y axes values
           group=weight, 														# group data by this values
           colour=type,														# assign colour by value of type
           shape=treatment)) +													# assign shape by value of type
  geom_line() +														# draw lines
  geom_point(size=3,fill="white") + 									# draw points
  scale_color_manual(
    values=c("black", "darkslategray3"),name  ="Experiment type") +	    # set colours manually
  scale_shape_manual(
    values=c(0,1,2,5,15,16,17,18,19,20),name  ="Treatment group") +     # set shapes manually
  xlab("Oxygen saturation (%)") + 									# label x axes
  ylab("Cumulative mortality (%)") + 									# label y axes
  ggtitle(
    "Cumulative mortality of modelled and real Cod after 96 hours") + 	# title of plot
  theme_bw() +                                                        # background theme
  theme(legend.justification=c(1,1), legend.position=c(.95,.95))  	# position of legend





