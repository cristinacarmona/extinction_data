#############################
#Preliminary analysis 21/Sept/2018
#############################
###########################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx)
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list
names(working.list) <- c("db")

attach(working.list)
###########################################################
names(db)


##########################################################
#Siguiendo la clasificación de Fisher y Owens (2004) transformar
#las categorías en un índice ordinal del 1-6:
#(1= "sin amenaza", 2 = "casi amenazado", 3 = "vulnerable", 4="en peligro", 5 = "en peligro crítico", 6 = "extinta")

table(db$Red.List.status)
# EXTINCT (EX) ...6
# EXTINCT IN THE WILD (EW) ...6
# CRITICALLY ENDANGERED (CR) ...5
# ENDANGERED (EN) ...4
# VULNERABLE (VU) ...3
# NEAR THREATENED (NT) ...2
# LEAST CONCERN (LC) ...1
# DATA DEFICIENT (DD)....NA
# Lower risk /Conservation dependant (LR/cd)....2 "The category is part of the IUCN 1994 Categories & Criteria (version 2.3), which is no longer used in evaluation of taxa, but persists in the IUCN Red List for taxa evaluated prior to 2001, when version 3.1 was first used. Using the 2001 (v3.1) system these taxa are classed as near threatened, but those that have not been re-evaluated remain with the "Conservation Dependent" category. (wikipedia)"
# Lower risk /least concern (LR/lc)...1
# Lower risk /near threatened....2

#   CR    DD    EN    EW    EX    LC  LR/cd LR/lc 
#1710  6701  2966    18   362 27865     9    52 
#LR/nt    NT    VU 
#61  2650  3698 

head(db)

db$rl.status.ordinal <- NA
db$rl.status.ordinal[db$Red.List.status %in% c("LC","LR/lc")] <- 1
db$rl.status.ordinal[db$Red.List.status %in% c("NT","LR/nt","LR/cd")] <- 2
db$rl.status.ordinal[db$Red.List.status %in% c("VU")] <- 3
db$rl.status.ordinal[db$Red.List.status %in% c("EN")] <- 4
db$rl.status.ordinal[db$Red.List.status %in% c("CR")] <- 5
db$rl.status.ordinal[db$Red.List.status %in% c("EW")] <- 6
db$rl.status.ordinal[db$Red.List.status %in% c("EX")] <- 6

table(db$rl.status.ordinal)





