#Clear Environment
remove(list = ls())

#Load necessary packages
install.packages("tidyverse")
library("tidyverse")
library("stringr")

#Install all raw data files from the Clinton location
SL021328 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL021328.csv")
SL021327 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL021327.csv")
SL023900 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023900.csv")
SL023898 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023898.csv")
SL023897 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023897.csv")
SL023896 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023896.csv")
SL023895 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023895.csv")
SL023894 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023894.csv")
SL024396 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL024396.csv")
SL002947 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL002947.csv")
SL017723 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL017723.csv")
SL017637 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL017637.csv")
SL022703 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL022703.csv")
SL023393 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023393.csv")

#Combine into one table
##Check if variables are equal
colnames(SL021328)==colnames(SL021327)
##bind
Data <- rbind(SL021328, SL021327, SL023900, SL023898, SL023897, 
              SL023896, SL023895, SL023894, SL024396, SL002947, 
              SL017723, SL017637, SL022703, SL023393)


#Export large combined table to csv
write_csv(Data, path = "Exported_Data/Combined.csv")


#Inspect data
summary(Data)
colnames(Data)

#Identify all empty columns by summary
empty_columns <- c("ADDRESS 2", "LAYERID", "LAST CROP", 
                   "NN Result", "Comment Crop1", "Comment Crop2", 
                   "Rpt CoverType (Rpt Soil Notes)", "Copy1", 
                   "Copy2", "Copy3", "Copy4")
#Remove empty columns
Data <- Data %>%
  select(-all_of(empty_columns))

#Combine Lime month and lime year into one column
Data <- Data %>%
  unite(`LIME MONTH`, `LIME YEAR`, col="Last Known Lime Application", sep="-")

#Replace 0 in Lime month and lime year with NA
Data$`Last Known Lime Application`[Data$`Last Known Lime Application` == '0-0'] <- NA
#Replace empty values in "

#Replace 0.0 in LIME IN TONNES with NA
Data$`LIME IN TONNES`[Data$`LIME IN TONNES` == '0'] <- NA

#Create a Crop 1 data table
crop1 <- select(Data, 1:24, 26:44, 56:57)

#Create a Crop 2 data table
crop2 <- select(Data, 1:23, 25:32, 45:57)

#Change column names to prepare to combine these two tables
##crop 1 table
colnames(crop1)
crop1 <- crop1 %>%
  rename(
    Crop = `Crop 1`,
    Mn_Avail_Crop = `Mn Avail Crop1`,
    Lime_Crop = 'LIME CROP1',
    Nit_Crop = 'NIT CROP1',
    Pho_Crop = 'PHO CROP1',
    Pot_Crop = 'POT CROP1',
    Mg_Crop = 'Mg CROP1',
    S_Crop = 'S CROP1',
    Cu_Crop = 'Cu CROP1',
    Zn_Crop = 'Zn CROP1',
    B_Crop = 'B CROP1',
    Mn_Crop = 'Mn CROP1',
    Crop_Note = `Note CROP1`
    )
#rearrange columns
crop1 <- crop1[,c(45, 1, 9, 2:8, 10:44)]

##crop 2 table
#Add S crop column
S_Crop <- rep(NA, nrow(crop2))
crop2 <- cbind(S_Crop, crop2)
colnames(crop2)
##Rename columns
crop2 <- crop2 %>%
  rename(
    Crop = `Crop 2`,
    Mn_Avail_Crop = `Mn Avail Crop2`,
    Lime_Crop = 'LIME CROP2',
    Nit_Crop = 'NIT CROP2',
    Pho_Crop = 'PHO CROP2',
    Pot_Crop = 'POT CROP2',
    Mg_Crop = 'Mg CROP2',
    Cu_Crop = 'Cu CROP2',
    Zn_Crop = 'Zn CROP2',
    B_Crop = 'B CROP2',
    Mn_Crop = 'Mn CROP2',
    Crop_Note = `Note CROP2`
  )
#rearrange columns
crop2 <- crop2[,c(45, 2, 10, 3:9, 11:38, 1, 39:44)]

#Combine into one table
##Check if variables are equal
colnames(crop1)==colnames(crop2)
##bind
Data <- rbind(crop1, crop2)

colnames(Data)

#Filter out sweetpotato plots

sp <- Data[str_detect(Data$Crop, "Sweetpotato"),]

