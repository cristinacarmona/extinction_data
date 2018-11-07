#########################################################
#Compile new data into new dbase for preliminary analysis
#21/Sept/2018 Created file

#07/Nov/2018 Added new files for amphibians and fish
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

working.list <- import.list[c(2,3,5,6,7)]
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
#db2 <- db.mam.av.rep.fi.amp

#Add missing data species from Pipoly to Mammals and Reptiles
length(pip$Scientific.name)#348
pip$Scientific.name <- gsub("\\_", " ", pip$Scientific.name)

trim.trailing <- function (x) sub("\\s+$", "", x)
db$Synonyms_nospace<-trim.trailing(db$Synonyms)

x <- intersect(pip$Scientific.name, db$binomial) #264
c <- match.arg(pip$Scientific.name, db$Synonyms_nospace, several.ok=T) #44
bin.syn <- db$binomial[db$Synonyms_nospace %in% c]

options(warn=-1) 
pip$binomial <- NA

for(i in 1:length(pip$Scientific.name)){
  #sra$binomial[i] <- db$binomial[pmatch(sra$species[i], db$Synonyms, nomatch= "NA")]
  if(any(grepl(pip$Scientific.name[i], db$Synonyms_nospace, fixed=T))){
    pip$binomial[i] <- db$binomial[which(grepl(pip$Scientific.name[i], db$Synonyms_nospace, fixed=T))]
  }
  if(!any(grepl(pip$Scientific.name[i], db$Synonyms, fixed=T))){
    pip$binomial[i] <- "no synonym match"  
  }
}

pip[!pip$binomial %in% "no synonym match" & pip$Taxon %in% c("reptile","mammal"), c("binomial","Scientific.name")]#23


#Total mammal and reptile species in Pipoly = 118
a <- pip$Scientific.name[pip$Taxon %in% c("reptile","mammal")] #118
#Species from pipoly in Database binomial name = 83
x <- intersect(a, db$binomial[db$Class %in% c("MAMMALIA","REPTILIA")]) #83
#Species from pipoly in Database synonyms = 23
b <- pip[!pip$binomial %in% "no synonym match" & pip$Taxon %in% c("reptile","mammal"), c("Scientific.name")]#23

c <- setdiff(a, x) #35 sp not found in binomial names
d <- intersect(c,b) #11 sp were found in synonyms
e <- setdiff(c, d) #24 sp still missing, check in synonyms ,/ NOT PRESENT IN IUCN FILE


#Merge data from pip to db, only if there is no data in db:-----------
which(db$binomial %in% "Pholidoscelis erythrocephalus")
pip[pip$Scientific.name %in% "Ameiva erythrocephala",]

names(db)

#i<-32693
for(i in 1:length(db$binomial)){
  if(db$Class[i] %in% c("REPTILIA", "MAMMALIA")){
    sp<-pip[match(db$binomial[i], pip$binomial),]
    
    
    db$body.size.pip[i] <- sp$`Body.size.???`
    db$latitude.pip[i] <- sp$`abs(Latitude)`
    
    
    if(is.na(db$ASR[i]) & !is.na(sp$`Adult.sex.ratio.*`)){
      db$ASR[i] <- sp$`Adult.sex.ratio.*`
      db$ref.asr[i] <- "pipoly"
    }
    if(is.na(db$sex.size.dim[i]) & !is.na(sp$`Sexual.size.dimorphism.???`)){
      db$sex.size.dim[i] <- sp$`Sexual.size.dimorphism.???`
      db$ref.sex.size.dim[i] <- "pipoly"
    }
  }
}


db$ref.asr[db$ref.asr %in% "pipoly" & db$Class %in% c("REPTILIA","MAMMALIA")]#103
#db2$ref.asr[db2$ref.asr %in% "pipoly" & db2$Class %in% c("REPTILIA","MAMMALIA")]#83


setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/Compiled database 21Sept2018/output")
write.csv(db, "merged_iucn_pre-analysis2.csv")
