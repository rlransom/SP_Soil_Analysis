########################################################################
#NCDA&CS Agronomics Division Soil Report Data Tidying
#Horticultural Crops Research Stations
#Raw Data available at http://www.ncagr.gov/agronomi/PALS/Default.aspx
#Summer 2020 GRIPSI Sweet Apps - Shelly Ransom
########################################################################


#Clear Environment
remove(list = ls())

#Load necessary packages
install.packages("tidyverse")
library("tidyverse")
library("stringr")
library("readr")
library("lubridate")

########################################################################
#Step 1: Import raw data, add location column, and combine data
#from all stations into one large table
########################################################################

#Load all raw data files from the Clinton location
RAW_Clinton_SL021328 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL021328.csv")
RAW_Clinton_SL021327 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL021327.csv")
RAW_Clinton_SL023900 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023900.csv")
RAW_Clinton_SL023898 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023898.csv")
RAW_Clinton_SL023897 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023897.csv")
RAW_Clinton_SL023896 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023896.csv")
RAW_Clinton_SL023895 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023895.csv")
RAW_Clinton_SL023894 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023894.csv")
RAW_Clinton_SL024396 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL024396.csv")
RAW_Clinton_SL002947 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL002947.csv")
RAW_Clinton_SL017723 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL017723.csv")
RAW_Clinton_SL017637 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL017637.csv")
RAW_Clinton_SL022703 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL022703.csv")
RAW_Clinton_SL023393 <- read_csv("./Raw_Soil_Data/RAW_Clinton_SL023393.csv")

#Combine into one table
#Check if variables are equal
colnames(RAW_Clinton_SL021328)==colnames(RAW_Clinton_SL021327)
##bind
Clinton <- rbind(RAW_Clinton_SL021328, RAW_Clinton_SL021327, RAW_Clinton_SL023900, 
                 RAW_Clinton_SL023898, RAW_Clinton_SL023897, RAW_Clinton_SL023896, 
                 RAW_Clinton_SL023895, RAW_Clinton_SL023894, RAW_Clinton_SL024396, 
                 RAW_Clinton_SL002947, RAW_Clinton_SL017723, RAW_Clinton_SL017637, 
                 RAW_Clinton_SL022703, RAW_Clinton_SL023393)

#Create Location label
Location <- rep("Clinton", nrow(Clinton))
#Add the new location column to data
Clinton <- cbind(Clinton, Location)

#Load all raw data files from the Caswell location
RAW_Caswell_SL002875 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL002875.csv")
RAW_Caswell_SL003519 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL003519.csv")
RAW_Caswell_SL004600 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL004600.csv")
RAW_Caswell_SL005298 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL005298.csv")
RAW_Caswell_SL006155 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL006155.csv")
RAW_Caswell_SL007524 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL007524.csv")
RAW_Caswell_SL011784 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL011784.csv")
RAW_Caswell_SL014819 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL014819.csv")
RAW_Caswell_SL022679 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL022679.csv")
RAW_Caswell_SL022705 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL022705.csv")
RAW_Caswell_SL022828 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL022828.csv")
RAW_Caswell_SL023401 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL023401.csv")
RAW_Caswell_SL023903 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL023903.csv")
RAW_Caswell_SL025306 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL025306.csv")
RAW_Caswell_SL025330 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL025330.csv")
RAW_Caswell_SL026098 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL026098.csv")
RAW_Caswell_SL026796 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL026796.csv")
RAW_Caswell_SL029820 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL029820.csv")
RAW_Caswell_SL032219 <- read_csv("./Raw_Soil_Data/RAW_Caswell_SL032219.csv")


#Combine into one table
Caswell <- rbind(RAW_Caswell_SL002875, RAW_Caswell_SL003519, RAW_Caswell_SL004600, 
                 RAW_Caswell_SL005298, RAW_Caswell_SL006155, RAW_Caswell_SL007524, 
                 RAW_Caswell_SL011784, RAW_Caswell_SL014819, RAW_Caswell_SL022679, 
                 RAW_Caswell_SL022705, RAW_Caswell_SL022828, RAW_Caswell_SL023401, 
                 RAW_Caswell_SL023903, RAW_Caswell_SL025306, RAW_Caswell_SL025330,
                 RAW_Caswell_SL026098, RAW_Caswell_SL026796, RAW_Caswell_SL029820,
                 RAW_Caswell_SL032219
                 )

#Create Location label
Location <- rep("Caswell", nrow(Caswell))
#Add the new location column to data
Caswell <- cbind(Caswell, Location)


#Load all raw data files from the Cunningham location
RAW_Cunningham_SL002862 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL002862.csv")
RAW_Cunningham_SL002863 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL002863.csv")
RAW_Cunningham_SL004601 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL004601.csv")
RAW_Cunningham_SL006173 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL006173.csv")
RAW_Cunningham_SL007405 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL007405.csv")
RAW_Cunningham_SL007525 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL007525.csv")
RAW_Cunningham_SL011785 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL011785.csv")
RAW_Cunningham_SL014820 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL014820.csv")
RAW_Cunningham_SL022821 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL022821.csv")
RAW_Cunningham_SL023400 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL023400.csv")
RAW_Cunningham_SL023904 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL023904.csv")
RAW_Cunningham_SL025329 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL025329.csv")
RAW_Cunningham_SL026797 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL026797.csv")
RAW_Cunningham_SL028566 <- read_csv("Raw_Soil_Data/RAW_Cunningham_SL028566.csv")

#Combine into one table
Cunningham <- rbind(RAW_Cunningham_SL002862, RAW_Cunningham_SL002863, RAW_Cunningham_SL004601,
                 RAW_Cunningham_SL006173, RAW_Cunningham_SL007405, RAW_Cunningham_SL007525,
                 RAW_Cunningham_SL011785, RAW_Cunningham_SL014820, RAW_Cunningham_SL022821,
                 RAW_Cunningham_SL023400, RAW_Cunningham_SL023904, RAW_Cunningham_SL025329,
                 RAW_Cunningham_SL026797, RAW_Cunningham_SL028566)

#Create Location label
Location <- rep("Cunningham", nrow(Cunningham))
#Add the new location column to data
Cunningham <- cbind(Cunningham, Location) 
 
##Combine all three locations into one comprehensive table
#Check if variables are equal
colnames(Clinton)==colnames(Caswell)
colnames(Clinton)==colnames(Cunningham)
#Bind together
Data <- rbind(Clinton, Caswell, Cunningham)

#inspect data table
colnames(Data)
summary(Data)

#Export combined raw data as CSV
write_csv(Data, path = "Exported_Data/Combined_Raw_Soil_Data.csv")




########################################################################
#Part 2: Tidy Data
########################################################################

#Identify unneccesary columns
delete_columns <- c("GROWER", "ADDRESS","ADDRESS 2","CITY",
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
  select(all_of(c("Complete Date", "REPORT#","Location", "SAMPLE ID", 
                  "Crop 1", "Last_Lime_Date", "LIME IN TONNES", "SOIL CLASS",
                  "HMA RESULT", "VW RESULT", "CATION EXCHANGE",
                  "BASE SAT.", "AC", "pH",
                  "P", "K", "Ca", "Mg",  "Mn", "Mn Avail Crop1",
                  "Zn", "Zn Avail", "Cu", "S", "SS Result",   
                  "NN Result", "AM Result", "Na"
                  )))

#Create a Crop 2 data table
crop2 <- Data %>%
  select(all_of(c("Complete Date", "REPORT#","Location", "SAMPLE ID", 
                  "Crop 2", "Last_Lime_Date", "LIME IN TONNES", "SOIL CLASS",
                  "HMA RESULT", "VW RESULT", "CATION EXCHANGE",
                  "BASE SAT.", "AC", "pH",
                  "P", "K", "Ca", "Mg",  "Mn", "Mn Avail Crop2",
                  "Zn", "Zn Avail", "Cu", "S", "SS Result",   
                  "NN Result", "AM Result", "Na"
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

#Change column names
colnames(Data)
Data <- Data %>%
  rename(
    Complete_Date = "Complete Date",
    Report = "REPORT#",
    Sample_ID = "SAMPLE ID",
    Last_Lime_Amount = "LIME IN TONNES",
    Soil_Class = "SOIL CLASS",
    Hma = "HMA RESULT",
    Vw = "VW RESULT",
    CEC = "CATION EXCHANGE",
    Base_Sat = "BASE SAT.",
    Zn_Avail_Crop = "Zn Avail",
    SS = "SS Result",
    NN = "NN Result",
    AM = "AM Result"
  )

#Change Complete_Date to data type date
Data$Complete_Date <- Data$Complete_Date %>%
  as.Date("%m/%d/%Y")

########################################################################
#Part 3: Subset data table and export desired CSV files
########################################################################

#############################
##Growing Year 2018
#Filtering by date
Soil_18 <- Data %>%
  filter(Complete_Date >= as.Date("2018-01-01") & Complete_Date <= as.Date("2018-12-31"))
#Filtering by Field ID
Soil_18 <- Soil_18 %>%
  filter(Sample_ID == "B5"| Sample_ID == "BB")
#Remove any crops that are not Sweetpotatoes
Soil_18 <- Soil_18 %>%
  filter(Crop == "Sweetpotato")

#Add Trial # Column
Trial <- c("18NCGT0014HCR", "18NCGT0014KIN ")
Soil_18 <- cbind(Soil_18, Trial)

Soil_18 <- Soil_18[,c(1:4, 29, 5:28)]


#Export 2018 sweetpotato soil analysis table as CSV
write_csv(Soil_18, path = "Exported_Data/Soil_Report_2018.csv")


#############################
##Growing Year 2019
#Filtering by date
Soil_19 <- Data %>%
  filter(Complete_Date >= as.Date("2019-01-01") & Complete_Date <= as.Date("2019-12-31"))
#Issue: Sample_ID M1 in cunningham has a "NA" for crop where sweetpotato should be
#Filtering by Field ID
Soil_19 <- Soil_19 %>%
  filter(
      Sample_ID == "F09" | Sample_ID == "F10" | Sample_ID == "F11" |
      Sample_ID == "HB" | Sample_ID == "S02" | Sample_ID == "M1" |
      Sample_ID == "M06" | Sample_ID == "S03" | Sample_ID == "HC" |
      Sample_ID == "F03")

#Remove any crops that are not Sweetpotatoes
Soil_19 <- Soil_19 %>%
  filter(Crop == "Sweetpotato")

##Add Trial # Column
#Some fields hosted multiple trials.
#Duplicate rows to account for multiple trials
#####!!Temporary fix, I need to come back and re-work this code to make it less labor-intensive on the user's end

#Number of trials in field S02
S02_Trials <- 2
#Number of trials in field S03
S03_Trials <- 1
#Number of trials in field M06
M06_Trials <- 1
#Number of trials in field F03
F03_Trials <- 1
#Number of trials in field F09
F09_Trials <- 1
#Number of trials in field F10
F10_Trials <- 3
#Number of trials in field F11
F11_Trials <- 1
#Number of trials in field H02
H02_Trials <- 8
#Number of trials in field H03
H03_Trials <- 5


rep_rows <- c(rep("1", S02_Trials), rep("2", S03_Trials),
              rep("3", M06_Trials), rep("4", F03_Trials),
              rep("5", F09_Trials), rep("6", F10_Trials),
              rep("7", F11_Trials), rep("8", H02_Trials),
              rep("9", H03_Trials)
              )

Soil_19 <- Soil_19[rep_rows,]

#Determine the trial names in each plot
#Work in progress
#This required me to look at the table of 2019 trials and assign each to the plot. Ideally I will upload the spreadsheet correlating trial #s and field IDs and the script would handle it
S02_Trial_Names <- c("19MCY30061HCRS02", "19SPEC0052HCRS02")
S03_Trial_Names <- c("19PURS0036HCRS03")
M06_Trial_Names <- c("19Y2GS_HCR")
F03_Trial_Names <- c("19PRE2HCRSF030159")
F09_Trial_Names <- c("19Y1GS_HCR")
F10_Trial_Names <- c("19ADYT0008HCR", "19CHIP0036HCRF10", "19PRE10032HCRF10")
F11_Trial_Names <- c("19MCY30036HCRF11")
H02_Trial_Names <- c("19CHIP0036KINH02", "19MCY10036CUNH02", "19MCY30036CUNH02", "19PRE20032CUNH02", "19PURS0036CUNH02", "19SPEC0024CUNH02", "19Y1GS_KIN", "19Y2GS_KIN")
H03_Trial_Names <- c("19ADYT0008CUNH03", "19NCGT0016CUNH03", "19NMER0020CUNH03", "19PRE10032CUNH03", "19PRE30046CUNH03")

Trial <- c(S02_Trial_Names, S03_Trial_Names, M06_Trial_Names, F03_Trial_Names, F09_Trial_Names, F10_Trial_Names, F11_Trial_Names, H02_Trial_Names, H03_Trial_Names)
Soil_19 <- cbind(Soil_19, Trial)

Soil_19 <- Soil_19[,c(1:4, 29, 5:28)]

#Export 2018 sweetpotato soil analysis table as CSV
write_csv(Soil_19, path = "Exported_Data/Soil_Report_2019.csv")


