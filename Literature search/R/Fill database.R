#########################################################
#Fill in data into database
#########################################################
#Load datasets
setwd("C:/Users/peepi_000/Documents/extinction_data/Literature search/input")

#setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")


xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx) #CERRAR ARCHIVO "merged_iucn" en excel antes de correr codigo
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))
#import.list <- read.xlsx("merged_iucn_and_db_v4.xlsx", sheet=1, colNames=TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list
names(working.list) <- c("db")

attach(working.list)
###########################################################

names(db)

#Example with mammals--------------
#Choose Class to work with
table(db$Class)

str(db[db$Class %in% "MAMMALIA",]) #5674 obs

db.mam <- db[db$Class %in% c("MAMMALIA") & !is.na(db$male_body_mass_g) & !is.na(db$female_body_mass_g),]

str(db.mam)#1174 obs

#------------------------Trabajo PG:
db.mam[1:5,"binomial"]
# [1] "Acomys cahirinus"  #no data  27 06 2018 PG added a comment
# [2] "Acomys russatus"     #no data
# [3] "Acomys spinosissimus" #no data
# [4] "Acomys subspinosus"  #no data
# [5] "Acomys wilsoni"  #no data

db.mam[6:10,"binomial"]
# [1] "Aconaemys fuscus"    ASR ADD 28.06.2018  
# [2]"Acrobates pygmaeus"    Di
# [3]"Addax nasomaculatus"  30.06
# [4] "Aepyceros melampus"    30.06
# [5]"Aepyprymnus rufescens" 30.06 dimo/mating sy/

db.mam[11:16, "binomial"]
#[1] "Aethomys chrysophilus" No ASR and mark dimo diferencia de peso, mating no encontredo ecepto un articulo que trabaja con sperma y suguiere un tipo de mating pero no lo menciona como tal
#[2] "Ailurus fulgens"      no ASR
#[3] "Akodon boliviensis"   Mating st no data NO asr### No data available
#[4] "Akodon cursor"     no mating sy ASR = 43M:30F, .589
#[5] "Alcelaphus buselaphus" asr and mating system no available  sex dim know from adw (PG 11/08/2019)
#[6] "Alces alces" sex dim and mating sys know from adw ASR from (Roönnega??rd et al., 2008)ASR's data from 1984 sex ratio in percentage in the article (PG 11/08/2018)

str(db.mam)
db.mam[17:24, "binomial"]
#[1] "Allactaga elater"      no data available (PG 11/08/2018)     
#[2] "Allenopithecus nigroviridis" Mating sysstem (Fuentes, 1998) dim sex weight (no registrado en excel)(nowark, 1999) ASR available (13/08/2018)
#[3] "Alouatta belzebul"    mating sy and sex di know from adw asr no available (PG 14/08/2018)      
#[4] "Alouatta caraya"      mating sy and sex di know from adw ASR know from pipoly (PG 16/08/2018)      
#[5] "Alouatta palliata"       mating sy and sex di know from adw ASR know from pipoly (PG 16/08/2018)    
#[6] "Amblysomus hottentotus"      sex di know from adw mating sy and ASR no available (PG 16/08/2018)
#[7] "Ametrida centurio"          sex di "exhibits the greatest female-biased sexual size dimorphism" no added to data in excel,  mating sy no available, no ASR (19/08/2018)
#[8] "Ammodorcas clarkei"   sex di added ASR nad mating sis no available (PG 19/08/2018)

db.mam[25:31, "binomial"]
#[1] "Ammotragus lervia"    mating and sex dim know feom adw ASR Added (PG 19/08/2018)
#[2] "Anisomys imitator"    no data available (19/08/2018)   
#[3] "Anoura cultrata"      dimo sex found (PG 21/08/2018)
#[4] "Anoura geoffroyi"     sex di know from adw no mating dy ASR added (PG 23/08/2018)
#[5] "Anoura latidens"      no data available (PG 26/08/2018)
#[6] "Anourosorex squamipes" no data availabe (PG 26/08/2018)
#[7] "Antechinomys laniger" no data available (PG 26/08/2018)

db.mam[32:40, "binomial"]
#1] "Antechinus adustus"   Mating sy added sex dim no available ASR no available (PG 28/08/2018)
#[2] "Antechinus agilis"    Mating sy added (PG 28/08/2018)
#[3] "Antechinus bellus"    Sex dim added , added and coment AST mait no available (PG 01/09/2018)
#[4] "Antechinus flavipes"  mating sy and asr no available sex di added (PG 01/09/2018)
#[5] "Antechinus godmani"   No data available (PG 01/09/2018)
#[6] "Antechinus leo"       
#[7] "Antechinus minimus"   
#[8] "Antechinus stuartii"  
#[9] "Antechinus swainsonii"





#--------------------Trabajo CCI:
str(db.mam[!is.na(db.mam$ASR),"binomial"]) #44

db.mam[1165:1174, "binomial"]
# [1] "Zaglossus bruijnii"       This suggestion also fits with the observation that there is no obvious sexual dimorphism between male and female echidnas (Griffiths 1978) (CCI 03/09/2018)
# [2] "Zalophus californianus"
# [3] "Zalophus japonicus"    
# [4] "Zalophus wollebaeki"   
# [5] "Zapus hudsonius"       
# [6] "Zapus princeps"        
# [7] "Zelotomys woosnami"    
# [8] "Ziphius cavirostris"   
# [9] "Zyzomys argurus"       
# [10] "Zyzomys woodwardi

db.mam[1155:1164, "binomial"]