#########################################################
#Compile new data into new dbase for preliminary analysis
#21/Sept/2018
###########################
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