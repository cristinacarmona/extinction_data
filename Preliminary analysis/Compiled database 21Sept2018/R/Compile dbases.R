#########################################################
#Compile new data into new dbase for preliminary analysis
#21/Sept/2018
###########################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/Compiled database 21Sept2018/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

csvfiles <- list.files(path = ".", pattern='*\\.csv$', all.files=TRUE)
csvfiles

library(openxlsx)
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))
import.list2 <- lapply(csvfiles, read.csv, header=T, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))

#str(import.list)
ls()

working.list <- import.list[2:6]
working.list2 <- import.list2
names(working.list) <- c("mam", "av","fi", "rep", "pip")
names(working.list2) <- "amph"

attach(working.list)
attach(working.list2)
###########################################################
table(fi$Class)

str(amph) #661 useful ones
amph <- amph[amph$Class %in% "AMPHIBIA",]
mam <- mam[mam$Class %in% "MAMMALIA",]
av <- av[av$Class %in% "AVES",]
rep <- rep[rep$Class %in% c("REPTILIA") | (rep$Class %in% "AMPHIBIA" & !rep$binomial %in% amph$binomial),]
str(rep)
fi <- fi[fi$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI","MYXINI",
                         "CHONDRICHTHYES","SARCOPTERYGII"),]

#Merge db 
db.mam.av <- merge(mam, av, all=T)
length(db.mam.av$binomial) #16796
db.mam.av.rep <- merge(db.mam.av, rep, all=T)
length(db.mam.av.rep$binomial) #29022
db.mam.av.rep.fi <- merge(db.mam.av.rep, fi, all=T)
length(db.mam.av.rep.fi$binomial) #45431
db.mam.av.rep.fi.amp <- merge(db.mam.av.rep.fi, amph, all=T)
length(db.mam.av.rep.fi.amp$binomial) #46092

db <- db.mam.av.rep.fi.amp

#Add missing data species from Pipoly to Mammals and Reptiles
length(pip$Scientific.name)#348
pip$Scientific.name <- gsub("\\_", " ", pip$Scientific.name)

trim.trailing <- function (x) sub("\\s+$", "", x)
db$Synonyms_nospace<-trim.trailing(db$Synonyms)

x <- intersect(pip$Scientific.name, db$binomial) #264
c <- match.arg(pip$Scientific.name, db$Synonyms_nospace, several.ok=T) #44
c.1 <- pmatch(pip$Scientific.name, db$Synonyms_nospace)
db[which(!is.na(c.1)), "binomial"]

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/Compiled database 21Sept2018/output")
write.csv(db.mam.av.rep.fi, "merged_iucn_pre-analysis.csv")
