#2018 Soil Data Processing

#This is just a baby script for my own use that does not import all of the raw soil data and is not designed to be re-used. It will specifically only apply to Clinton 2018 Soil Analysis.

library("tidyverse")
library("stringr")
library("readr")

#Load raw file
Data <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL021327.csv")
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

#Remove columns with address and reccomended Fertilization amounds
delete_data <- c("ADDRESS",                     "CITY",                       
                 "STATE",                       "ZIP",                         "FARM",                       
                 "COUNTY",
                 "Lime_Crop",                   "Nit_Crop",                   "Pho_Crop",                   
                 "Pot_Crop",                    "Mg_Crop",                     "S_Crop",                     
                 "Cu_Crop",                     "Zn_Crop",                     "B_Crop",                     
                 "Mn_Crop",                     "Crop_Note",                   "Narrative")
Data <- Data %>%
  select(-all_of(delete_data))


#Rename Column Names
Data <- Data %>%
  rename(
    Complete_Date = "Complete Date",
    Report = "REPORT#",
    Field_ID = "SAMPLE ID",
    Station = "GROWER",
    Last_Lime_Date = "Last Known Lime Application",
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


#Filter out field of interest
Field <- readline(prompt="Enter Field ID: ")

Field_Table <- Data[str_detect(Data$Field_ID, Field),]

#Filter out Sweetpotatoes
Clinton_18_SP <- Field_Table[str_detect(Field_Table$Crop, "Sweetpotato"),]

#Export sweetpotato soil analysis table as CSV
write_csv(Clinton_18_SP, path = "Exported_Data/Clinton18_Soil.csv")
