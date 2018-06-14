#########################################################
#Fill in data into database
#########################################################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx)
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list
names(working.list) <- c("db")

attach(working.list)
###########################################################

names(db)

#Example with reptiles--------------
#Choose Class to work with
table(db$Class)

str(db[db$Class %in% "REPTILIA",]) #6278 obs

db.rep <- db[db$Class %in% c("REPTILIA") & !is.na(db$male_svl_cm) & !is.na(db$female_svl_cm),]

str(db.rep)#161 obs

db.rep[1:5,"binomial"]
db.rep[1:5,]
#[1] "Acanthodactylus erythrurus" 13-jun-2018  mating system and ASR
#"Acanthophis laevis"   no data available (CCI 13/06/2018)
#[3] "Acanthophis rugosus"        no data available (CCI 13/06/2018)
#"Ameiva atrigularis"        no data available (CCI 13/06/2018)
#[5] "Ameiva praesignis" no data available (CCI 13/06/2018)

db.rep[6:10,"binomial"]
#[1] "Anilios ammodytes" no data available (CCI 13/06/2018) 
#"Anilios australis"     no data available (CCI 13/06/2018) 
#[3] "Anilios bituberculatus"  no data available (CCI 13/06/2018) 
#"Anilios diversus"      no data available (CCI 13/06/2018) 
#[5] "Anilios endoterus"   no data available (CCI 13/06/2018) 

db.rep[11:15,"binomial"]
#[1] "Anilios ligatus"     no data available (CCI 13/06/2018) 
#"Anilios pinguis"    no data available (CCI 13/06/2018) 
#[3] "Anolis carolinensis"  ASR and Mating system already known from adw
#"Antaresia childreni"  no data available(CCI 13/06/2018)
#[5] "Antaresia maculosa"  no data available (CCI 13/06/2018)



