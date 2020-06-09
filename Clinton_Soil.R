#Clear Environment
remove(list = ls())

#Load necessary packages
#install.packages("tidyverse")
#install.packages("xlsx")
library("tidyverse")
library("xlsx")

#Install all raw data files from the Clinton location
SL021328 <- read_csv("./Soil Data/RAW_Clinton_SL021328.csv")
SL021327 <- read_csv("./Soil Data/RAW_Clinton_SL021327.csv")
SL023900 <- read_csv("./Soil Data/RAW_Clinton_SL023900.csv")
SL023898 <- read_csv("./Soil Data/RAW_Clinton_SL023898.csv")
SL023897 <- read_csv("./Soil Data/RAW_Clinton_SL023897.csv")
SL023896 <- read_csv("./Soil Data/RAW_Clinton_SL023896.csv")
SL023895 <- read_csv("./Soil Data/RAW_Clinton_SL023895.csv")
SL023894 <- read_csv("./Soil Data/RAW_Clinton_SL023894.csv")
SL024396 <- read_csv("./Soil Data/RAW_Clinton_SL024396.csv")
SL002947 <- read_csv("./Soil Data/RAW_Clinton_SL002947.csv")
SL017723 <- read_csv("./Soil Data/RAW_Clinton_SL017723.csv")
SL017637 <- read_csv("./Soil Data/RAW_Clinton_SL017637.csv")
SL022703 <- read_csv("./Soil Data/RAW_Clinton_SL022703.csv")
SL023393 <- read_csv("./Soil Data/RAW_Clinton_SL023393.csv")

#Combine into one table
##Check if variables are equal
colnames(SL021328)==colnames(SL021327)

Data <- rbind(SL021328, SL021327, SL023900, SL023898, SL023897, 
              SL023896, SL023895, SL023894, SL024396, SL002947, 
              SL017723, SL017637, SL022703, SL023393)


#Inspect data
summary(Data)

#Export large combined table to csv
write_csv(Data, path = "Exported_Data/Combined.csv")


