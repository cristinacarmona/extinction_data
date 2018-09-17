#########################################################
#Fill in data into database
#########################################################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx) #CERRAR ARCHIVO "merged_iucn" en excel antes de correr codigo
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))
#import.list <- read.xlsx("merged_iucn_and_db_v4.xlsx", sheet=1, colNames=TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))

csvfiles <- list.files(path = ".", pattern='*\\.csv$', all.files=TRUE)
csvfiles

import.list2 <- lapply(csvfiles[2], read.csv, header = TRUE, as.is=TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))



#str(import.list)
ls()

working.list <- import.list
working.list2<- import.list2
names(working.list) <- c("db")
names(working.list2) <- c("sra")

attach(working.list)
attach(working.list2)
###########################################################

names(db)
head(db)

names(sra)
head(sra)

#change species names from sra
library(stringr)
sra$species <- str_replace(sra$species, "_", " ")
str(sra) #10377 sp
table(sra$mating.system)
table(sra$malmor.a)

sra.withdata <- sra[!is.na(sra$mating.system)|(!is.na(sra$f.mass)&!is.na(sra$m.mass)) | !is.na(sra$fpg.scr) | !is.na(sra$mpg.scr) | !is.na(sra$asr),]
str(sra.withdata) #5131 sp

head(sra.withdata)

#AVES--------------
#Choose Class to work with
table(db$Class)

str(db[db$Class %in% "AVES",]) #11122 obs

db.av <- db[db$Class %in% c("AVES") & !is.na(db$male_body_mass_g) & !is.na(db$female_body_mass_g),]

str(db.av)#4544 obs

#Check if all species from sra are present in db.av-------
setdiff(sra$species, db.av$binomial) #6446sp
intersect(sra$species, db.av$binomial) #3931 sp
intersect(sra$species, db.av$Synonyms) #362

setdiff(sra$species, db$binomial[db$Class %in% "AVES"]) #2025
setdiff(db$binomial[db$Class %in% "AVES"], sra$species) #2770
a<-intersect(sra$species, db$binomial[db$Class %in% "AVES"]) #8352
b<-intersect(sra$species, db$Synonyms[db$Class %in% "AVES"]) #1283

c<-match.arg(sra$species, db$Synonyms[db$Class %in% "AVES"], several.ok=T) #1515 spp
bin.syn <- db$binomial[db$Synonyms %in% c]#1517 includes b (intersect between sp and synonyms)


db[db$binomial %in% bin.syn | db$binomial %in% a, "binomial"] #9774
db.aves.all <- db[db$Class %in% "AVES",]
str(db.aves.all)#11122
aves.available<-db.aves.all[db.aves.all$binomial %in% bin.syn | db.aves.all$binomial %in% a, "binomial"] #9774
db.aves.all[!db.aves.all$binomial %in% aves.available, "binomial"] #1348

#In total: 9774 species from sra found in db
db.av[!db.av$binomial %in% a | !db.av$Synonyms %in% b, "binomial"] #4502


setdiff(sra.withdata$species, db.av$binomial) #1794
sra.withdata[sra.withdata$species %in% "Merops pusillus",]
db.av[db.av$binomial %in% "Merops pusillus",]

setdiff(sra.withdata$species, db$binomial[db$Class %in% "AVES"]) #912
setdiff(db$binomial[db$Class %in% "AVES"], sra.withdata$species) #6903

db.av[db.av$Synonyms %in% "Mesophoyx intermedia",]




#Add binomial name from db of synonyms that match with species from sra:---------

sra[sra$species %in% "Ochthoeca diadema",]
sra[6404,]

c<-match.arg(sra$species, db$Synonyms[db$Class %in% "AVES"], several.ok=T) #1515 spp
bin.syn <- db$binomial[db$Synonyms %in% c]#1517 includes b (intersect between sp and synonyms)

d<-match.arg(db$Synonyms[db$Class %in% "AVES"], sra$species,several.ok=T)#1286

i=6404
options(warn=-1) 
for(i in 1:length(sra$species)){
  sra$binomial[i] <- db$binomial[pmatch(sra$species[i], db$Synonyms, nomatch= "NA")]
}

sra$binomial <- ifelse(is.na(sra$binomial), sra$species, sra$binomial)

no.na<-sra[!is.na(sra$binomial), c("binomial","species")]
no.na[1:30,]
head(sra)
tail(sra)

#-----------------------------------------------------
#Merge relevant data from sra to dba-------------
names(sra) #asr, dev.mod, fpg, fpg.scr, f.mass, m.mass, m_displ, mating.system, mortality, mpg, mpg.scr, pl.total, unsexed.mass, unsexed.tarsus, unsexed.wing

sra.merge <- sra[,c("binomial", "asr","dev.mod", "f.mass","fpg","fpg.scr","m.mass", "m_displ", "mating.system","mortality","mpg","mpg.scr","pl.total", "unsexed.mass","unsexed.tarsus","unsexed.wing")]
names(sra.merge)
db.merge <- db

#Merge data which is already a variable in db:-----------

for(i in 1:length(db.merge$binomial)){
  if(db.merge$Class[i] %in% "AVES"){
    sp<-sra.merge[match(db.merge$binomial[i], sra.merge$binomial),]
    
    if(is.na(db.merge$ASR[i]) & !is.na(sp$asr)){
      db.merge$ASR[i] <- sp$asr
      db.merge$ref.asr[i] <- "TS_sexroles"
    }
  }
  }


