#########################################################
#Fill in data into database
#########################################################
#Load datasets
setwd("C:/Users/peepi_000/Documents/extinction_data/Literature search/input")

#setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")


xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx) #CERRAR ARCHIVO "merged_iucn" en excel antes de correr codigo
import.list <- lapply(xlsxfiles[2], read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))
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

#----------merge Lindenfors 2002 database for pinnipeds mating systems
# setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/Analysis/Merge databases/input")
# 
# csvfiles <- list.files(path = ".", pattern='*\\.csv$', all.files=TRUE)
# csvfiles
# 
# import.list <- lapply(csvfiles[11], read.csv, header = TRUE, as.is=TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))
# 
# 
# #str(import.list)
# ls()
# 
# working.list <- import.list
# names(working.list) <- c("Lindenfors")
# 
# attach(working.list)
# #----------------------------------
# names(Lindenfors)
# str(Lindenfors)
# # Data on average male harem sizes were
# #collected with species classified as monogamous or serially
# #monogamous denoted as having a harem size of one
# 
# for (i in 1:length(Lindenfors$Species)){
#   if(Lindenfors$Harem.size[i] != 1){
#     Lindenfors$Mating_system[i] <- "Polygamous" 
#     } else {
#       Lindenfors$Mating_system[i] <-"Monogamous"
#     }
#   }
# #ADD NA to spp with no harem size: Arctocephalus philippii
# Lindenfors$Mating_system[29] <- NA
# Lindenfors[29,]  
# 
# #Check spp names
# Lindenfors[!Lindenfors$Species %in% db.mam$binomial,"Species"]
# db.mam[db.mam$binomial %in% "Ommatophoca",]
# 
# Lindenfors$Species[5]<-"Leptonychotes weddellii"
# Lindenfors$Species[6]<-"Ommatophoca rossii"
# Lindenfors[6,] #Male and female body weight in grams
# 
# #Merge Lindenfors to general db manually
# Lindenfors[,c("Species", "Mating_system", "Female.weight", "Male.weight")]

#                              Species      Mating_system Female.weight(kg) Male.weight (kg)
# 1                Monachus schauinslandi    Monogamous        265.00      173.00 ,/
# 2                     Monachus monachus    Monogamous        301.00      260.00 ,/
# 3               Mirounga angustirostris    Polygamous        513.00     2275.00 ,/
# 4                      Mirounga leonina    Polygamous        503.00     3510.00 ,/
# 5               Leptonychotes weddellii    Polygamous        376.00      360.00 ,/
# 6                    Ommatophoca rossii    Monogamous        185.00      173.80 ,/
# 7                 Lobodon carcinophagus    Monogamous        224.00      220.50 ,/
# 8                     Hydrurga leptonyx    Monogamous        367.00      324.00 ,/
# 9                   Cystophora cristata    Monogamous        222.50      343.18 ,/
# 10                  Erignathus barbatus    Monogamous        276.36      265.00 ,/
# 11                   Halichoerus grypus    Polygamous        155.00      233.00 ,/
# 12                   Phoca groenlandica    Monogamous        129.50      135.00 ,/
# 13                       Phoca fasciata    Monogamous         80.36       94.80 ,/
# 14                         Phoca largha    Monogamous         86.00       97.00 ,/
# 15                        Phoca caspica    Monogamous         55.00       70.50 ,/
# 16                       Phoca sibirica    Monogamous         89.50       89.50 ,/
# 17                        Phoca hispida    Monogamous         66.50       71.67 ,/
# 18              Phoca vitulina vitulina    Monogamous         66.00       80.00 ,/
# 19             Phoca vitulina richardsi    Monogamous         64.80       87.60  x
# 20            Phoca vitulina stejnegeri    Monogamous        101.00      128.50  x
# 21 Zalophus californianus californianus    Polygamous         86.00      289.00 ,/
# 22    Zalophus californianus wollebaeki    Polygamous         78.00      200.00 ,/
# 23                   Eumetopias jubatus    Polygamous        287.55     1000.00 ,/
# 24            Otaria byronia/flavescens    Polygamous        144.00      300.00 ,/
# 25                     Neophoca cinerea    Polygamous         78.55      300.00 ,/
# 26                    Phocartos hookeri    Polygamous        183.00      364.00 ,/
# 27                  Callorhinus ursinus    Polygamous         44.75      227.00 ,/
# 28              Arctocephalus townsendi    Polygamous         49.55      145.00 ,/
# 29              Arctocephalus philippii          <NA>         50.00      140.00 ,/
# 30          Arctocephalus galapagoensis    Monogamous         27.40       64.50 ,/
# 31              Arctocephalus australis    Monogamous         48.50      159.00 ,/
# 32               Arctocephalus forsteri    Monogamous         55.00      164.38 ,/
# 33                Arctocephalus gazella    Monogamous         38.20      155.00 ,/
# 34             Arctocephalus tropicalis    Monogamous         50.00      152.50 ,/
# 35      Arctocephalus pusillus pusillus    Monogamous         71.00      278.00 ,/
# 36     Arctocephalus pusillus doriferus    Monogamous         84.00      307.00 x
# 37           Odobenus rosmarus rosmarus    Monogamous        655.00     1050.00 ,/
# 38          Odobenus rosmarus divergens    Monogamous        738.00     1353.00 x
# 

#Mammals stats
db.mam[!is.na(db.mam$ASR), c("binomial","mating_system")] #44
db.mam[!is.na(db.mam$ASR) & is.na(db.mam$mating_system), c("binomial","mating_system")] #10
db.mam[is.na(db.mam$ASR) & !is.na(db.mam$mating_system), c("binomial")] #360


#------------------------------------
db.mam[1165:1174, "binomial"]
# [1] "Zaglossus bruijnii"       This suggestion also fits with the observation that there is no obvious sexual dimorphism between male and female echidnas (Griffiths 1978) (CCI 03/09/2018)
# [2] "Zalophus californianus"    No ASR, added mating system
# [3] "Zalophus japonicus"    
# [4] "Zalophus wollebaeki"   
# [5] "Zapus hudsonius"       
# [6] "Zapus princeps"        
# [7] "Zelotomys woosnami"    
# [8] "Ziphius cavirostris"   
# [9] "Zyzomys argurus"       
# [10] "Zyzomys woodwardi

db.mam[1155:1164, "binomial"]
