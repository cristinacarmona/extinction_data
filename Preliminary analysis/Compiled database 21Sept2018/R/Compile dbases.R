#########################################################
#Compile new data into new dbase for preliminary analysis
#21/Sept/2018
###########################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/Compiled database 21Sept2018/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx)
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list
names(working.list) <- c("mam", "av","fi", "rep")

attach(working.list)
###########################################################
table(fi$Class)

mam <- mam[mam$Class %in% "MAMMALIA",]
av <- av[av$Class %in% "AVES",]
rep <- rep[rep$Class %in% c("REPTILIA", "AMPHIBIA"),]
fi <- fi[fi$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI","MYXINI",
                         "CHONDRICHTHYES","SARCOPTERYGII"),]

#Merge db 

db.mam.av <- merge(mam, av, all=T)
str(db.mam.av) #16796
db.mam.av.rep <- merge(db.mam.av, rep, all=T)
str(db.mam.av.rep) #29683
db.mam.av.rep.fi <- merge(db.mam.av.rep, fi, all=T)
str(db.mam.av.rep.fi) #46092

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/Compiled database 21Sept2018/output")
write.csv(db.mam.av.rep.fi, "merged_iucn_pre-analysis.csv")
