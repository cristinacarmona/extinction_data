#########################################################
#Fill in data into database
#########################################################
#Load datasets
setwd("C:/Users/peepi_000/Documents/extinction_data/Literature search/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx) #CERRAR ARCHIVO "merged_iucn" en excel antes de correr codigo
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))
#import.list <- read.xlsx("merged_iucn_and_db_v4.xlsx", sheet=1, colNames=TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


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

str(db[db$Class %in% "MAMMALIA",]) #5674 obs

db.mam <- db[db$Class %in% c("MAMMALIA") & !is.na(db$male_body_mass_g) & !is.na(db$female_body_mass_g),]

str(db.mam)#1174 obs

db.mam[1:5,"binomial"]
db.rep[1:5,]
# [1] "Acomys cahirinus"  #no data  27 06 2018 PG added a comment
# [2] "Acomys russatus"     #no data
# [3] "Acomys spinosissimus" #no data
# [4] "Acomys subspinosus"  #no data
# [5] "Acomys wilsoni"  #no data

db.mam[6:10,"binomial"]
db.mam[6:10,]
# [1] "Aconaemys fuscus"    ASR ADD 28.06.2018  
# [2]"Acrobates pygmaeus"    Di
# [3]"Addax nasomaculatus"  30.06
# [4] "Aepyceros melampus"    30.06
# [5]"Aepyprymnus rufescens" 30.06 dimo/mating sy/

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

str(db[db$Class %in% "MAMMALIA",])
#5674 obs

db.mam <- db[db$Class %in% c("MAMMALIA") & !is.na(db$male_body_mass_g) & !is.na(db$female_body_mass_g),]

str(db.mam)

db.mam [11:16, "binomial"]
#[1] "Aethomys chrysophilus" No ASR and mark dimo diferencia de peso, mating no encontredo ecepto un articulo que trabaja con sperma y suguiere un tipo de mating pero no lo menciona como tal
#[2] "Ailurus fulgens"      no ASR
#[3] "Akodon boliviensis"   Mating st no data NO asr### No data available
#[4] "Akodon cursor"     no mating sy ASR = 43M:30F, .589
#[5] "Alcelaphus buselaphus" asr and mating system no available  sex dim know from adw (PG 11/08/2019)
#[6] "Alces alces" sex dim and mating sys know from adw ASR from (Roönnega??rd et al., 2008)ASR's data from 1984 sex ratio in percentage in the article (PG 11/08/2018)
db .mam [17:22, "binomial"]
str(db.mam)
db.mam [17:24, "binomial"]
#[1] "Allactaga elater"           
#[2] "Allenopithecus nigroviridis"
#[3] "Alouatta belzebul"          
#[4] "Alouatta caraya"            
#[5] "Alouatta palliata"          
#[6] "Amblysomus hottentotus"     
#[7] "Ametrida centurio"          
#[8] "Ammodorcas clarkei"   





