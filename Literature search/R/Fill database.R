#########################################################
#Fill in data into database
#########################################################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")

csvfiles <- list.files(path = ".", pattern='*\\.csv$', all.files=TRUE)
csvfiles

import.list <- lapply(csvfiles, read.csv, header = TRUE, as.is=TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list[2]
names(working.list) <- c("db2")

attach(working.list)
###########################################################

names(db2)

#Example with reptiles--------------
#Choose Class to work with
table(db2$Class)

str(db2[db2$Class %in% "REPTILIA",]) #6278 obs

db.rep <- db2[db2$Class %in% c("REPTILIA") & !is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm),]

str(db.rep)#161 obs

db.rep[1:5,"binomial"]
