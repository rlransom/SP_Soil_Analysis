#Clear Environment
remove(list = ls())

#Load necessary packages
install.packages("tidyverse")
library("tidyverse")
library("stringr")
library("readr")
library("lubridate")

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


##Export large combined table to csv
#write_csv(Data, path = "Exported_Data/Combined.csv")


#Inspect data
summary(Data)
colnames(Data)

#Identify unneccesary columns
delete_columns <- c("ADDRESS","ADDRESS 2","CITY",
                   "STATE","ZIP","FARM",
                   "LAYERID","COUNTY","LAST CROP",
                   "LIME CROP1","NIT CROP1","PHO CROP1",
                   "POT CROP1","Mg CROP1","S CROP1",
                   "Cu CROP1","Zn CROP1","B CROP1",
                   "Mn CROP1","Comment Crop1","Note CROP1",
                   "LIME CROP2","NIT CROP2","PHO CROP2",
                   "POT CROP2","Mg CROP2","Cu CROP2",
                   "Zn CROP2","B CROP2","Mn CROP2",
                   "Comment Crop2","Note CROP2","Rpt CoverType (Rpt Soil Notes)",
                   "Narrative","Copy1","Copy2",
                   "Copy3","Copy4")
#Remove these columns
Data <- Data %>%
  select(-all_of(delete_columns))


#Combine Lime month and lime year into one column
Data <- Data %>%
  unite(`LIME MONTH`, `LIME YEAR`, col="Last_Lime_Date", sep="-")

#Replace 0 in Lime month and lime year with NA
Data$Last_Lime_Date[Data$Last_Lime_Date == '0-0'] <- NA
#Replace empty values in "

#Replace 0.0 in LIME IN TONNES with NA
Data$`LIME IN TONNES`[Data$`LIME IN TONNES` == '0'] <- NA

#Create a Crop 1 data table
crop1 <- Data %>%
  select(all_of(c("REPORT#", "GROWER", "SAMPLE ID", 
                  "Last_Lime_Date", "LIME IN TONNES", "SOIL CLASS",
                  "HMA RESULT", "VW RESULT", "CATION EXCHANGE",
                  "BASE SAT.", "AC", "pH",
                  "P", "K", "Ca", "Mg",  "Mn", "Mn Avail Crop1",
                  "Zn", "Zn Avail", "Cu", "S", "SS Result",   
                  "NN Result", "AM Result", "Na", "Crop 1",
                  "Complete Date"
                  )))

#Create a Crop 2 data table
crop2 <- Data %>%
  select(all_of(c("REPORT#", "GROWER", "SAMPLE ID", 
                  "Last_Lime_Date", "LIME IN TONNES", "SOIL CLASS",
                  "HMA RESULT", "VW RESULT", "CATION EXCHANGE",
                  "BASE SAT.", "AC", "pH",
                  "P", "K", "Ca", "Mg",  "Mn", "Mn Avail Crop2",
                  "Zn", "Zn Avail", "Cu", "S", "SS Result",   
                  "NN Result", "AM Result", "Na", "Crop 2",
                  "Complete Date"
  )))

#Change column names to prepare to combine these two tables
##crop 1 table
colnames(crop1)
#Rename columns
crop1 <- crop1 %>%
  rename(
    Crop = "Crop 1",
    Mn_Avail_Crop = "Mn Avail Crop1",
    )

##crop 2 table
colnames(crop2)
##Rename columns
crop2 <- crop2 %>%
  rename(
    Crop = "Crop 2",
    Mn_Avail_Crop = "Mn Avail Crop2",
  )

#Combine into one table
##Check if variables are equal
colnames(crop1)==colnames(crop2)
##bind
Data <- rbind(crop1, crop2)

#Filter out sweetpotato plots
SP <- Data[str_detect(Data$Crop, "Sweetpotato"),]

#Re-arrange columns into a more logical sequence
SP <- SP[,c(28, 1:2, 27, 3:26)]


#Change column names
colnames(SP)
SP <- SP %>%
  rename(
    Complete_Date = "Complete Date",
    Report = "REPORT#",
    Field_ID = "SAMPLE ID",
    Station = "GROWER",
    Last_Lime_Amount = "LIME IN TONNES",
    Soil_Class = "SOIL CLASS",
    Hma = "HMA RESULT",
    Vw = "VW RESULT",
    CEC = "CATION EXCHANGE",
    Base_Sat = "BASE SAT.",
    Zn_Avail_Crop = "Zn Avail",
    SS = "SS Result",
    AM = "AM Result"
  )

#Change Complete_Date to data type date
SP$Complete_Date <- SP$Complete_Date %>%
  as.Date("%m/%d/%Y")

###########################################
###Filter out tables by year and field
###########################################

##Growing Year 2018
#Filtering by date
Soil_18 <- SP %>%
  filter(Complete_Date >= as.Date("2018-01-01") & Complete_Date <= as.Date("2018-12-31"))



##Growing Year 2019
#Filtering by date
Soil_19 <- SP %>%
  filter(Complete_Date >= as.Date("2019-01-01") & Complete_Date <= as.Date("2019-12-31"))
#Define the field IDs that we are interested in
Fields_19 <- c("H03", "F10", "H02", 
               "F10","S02", "M01", 
               "M05", "F03", "S03",
               "F09", "M06")




############################

#Export sweetpotato soil analysis table as CSV
write_csv(SP18, path = "Exported_Data/Clinton18_Soil.csv")

