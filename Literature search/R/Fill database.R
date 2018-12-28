#########################################################
#Fill in data into database
#########################################################
#Load datasets
setwd("C:/Users/peepi_000/Documents/extinction_data_backup/extinction_data/Literature search/input")

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
# [1] "Aconaemys fuscus"    ASR ADD 28.06.2018  M3:F4
# [2]"Acrobates pygmaeus"    Di
# [3]"Addax nasomaculatus"  30.06
# [4] "Aepyceros melampus"    30.06
# [5]"Aepyprymnus rufescens" 30.06 dimo/mating sy/ M42:F31

db.mam[11:16, "binomial"]
#[1] "Aethomys chrysophilus" No ASR and mark dimo diferencia de peso, mating no encontredo ecepto un articulo que trabaja con sperma y suguiere un tipo de mating pero no lo menciona como tal
#[2] "Ailurus fulgens"      no ASR
#[3] "Akodon boliviensis"   Mating st no data NO asr### No data available
#[4] "Akodon cursor"     no mating sy ASR = 43M:30F, .589
#[5] "Alcelaphus buselaphus" asr and mating system no available  sex dim know from adw (PG 11/08/2018)
#[6] "Alces alces" sex dim and mating sys know from adw ASR  males "62" and females "65" from (Roönnega??rd et al., 2008)ASR's data from 1984 sex ratio in percentage in the article (PG 11/08/2018)

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


db.mam [25:31, "binomial"]
#[1] "Ammotragus lervia"    mating and sex dim know feom adw ASR Males "42" and females "51" Added (PG 19/08/2018)
#[2] "Anisomys imitator"    no data available (19/08/2018)   
#[3] "Anoura cultrata"      dimo sex found (PG 21/08/2018)
#[4] "Anoura geoffroyi"     sex di know from adw no mating dy ASR M106:F169 added (PG 23/08/2018)
#[5] "Anoura latidens"      no data available (PG 26/08/2018)
#[6] "Anourosorex squamipes" no data availabe (PG 26/08/2018)
#[7] "Antechinomys laniger" no data available (PG 26/08/2018)

db.mam[32:40, "binomial"]
#1] "Antechinus adustus"   Mating sy added sex dim no available ASR no available (PG 28/08/2018)
#[2] "Antechinus agilis"    Mating sy added (PG 28/08/2018)
#[3] "Antechinus bellus"    Sex dim added , added and coment AST mait no available (PG 01/09/2018)
#[4] "Antechinus flavipes"  mating sy and asr no available sex di added (PG 01/09/2018)
#[5] "Antechinus godmani"   No data available (PG 01/09/2018)
#[6] "Antechinus leo"       no data available (PG 02/09/2018)
#[7] "Antechinus minimus"   mating sy aded ASR and sex di no available (PG 03/09/2018)
#[8] "Antechinus stuartii"  matinh, ASR males "115" and famales "38", sex d added (PG  03/09/2018)
#[9] "Antechinus swainsonii" no data available (PG 03/09/2018)

sp.worked.pg <- db.mam[1:40, "binomial"]

#-----------Continúa trabajo PG con la nueva selección de especies (13/sept/2018):

sp.worked.pg <- db.mam[1:40, "binomial"] #Especies que PG trabajó previo al 12/sept/2018
db.mam2 <- db.mam[!is.na(db.mam$mating_system) & !db.mam$binomial %in% sp.worked.pg,]
str(db.mam2) #372 spp

db.mam2[1:10, "binomial"]
# [1] "Antilocapra americana" ASR based on captures from 41 males and 61 females (PG 08/10/2018) 
# [1']"Antilope cervicapra"   ASR based on captures from 42 males and 13 females (PG 08/10/2018)
# [2] "Antrozous pallidus"   ASR based on captures from 653 males and 988 females (PG 08/10/2018)       
# [3] "Aotus lemurinus"       no data available (PG 10/10/2018)     
# [4] "Aotus trivirgatus"     no data available (PG 14/10/2018)     
# [5] "Arctocebus calabarensis" no data available (PG 14/10/2018)  
# [6] "Arctocephalus australis" ASR based on captures from 337 males and 3215 females (PG 14/10/2018)
# [7] "Arctocephalus galapagoensis"  no data available (PG 14/10/2018) ASR only with pups 
# [8] "Arctocephalus gazella"   ASR based on captures from 464 males and 581 females (PG 18/10/2018)   
# [9] "Arctocephalus pusillus"  ASR based on captures from 9 males and 48 females (from Arctocephalus pusillus doriferus) (PG 18/10/2018) 
# [10] "Arctocephalus townsendi" ASR based on captures (from 1983 to 1993 ) from 4,996 males and 6,979 females (from Arctocephalus pusillus doriferus) (PG 24/10/2018) 

db.mam2[11:20, "binomial"]
# [1] "Arctocephalus tropicalis" No data available (PG 24/10/2018) only females... 
# [2] "Artibeus jamaicensis"    ASR based on captures from 1 male and 8 females (PG 24/10/2018)
# [3] "Atelerix frontalis"      no data available (PG 24/10/2018)..
# [4] "Ateles paniscus"        ASR based on captures from 3 male and 8 females (PG 28/10/2018)     
# [5] "Avahi laniger"       ASR  FROM : Avahi laniger occidentalis and Avahi laniger laniger. ASR based on captures from 6 male and 10 females (PG 28/10/2018)    
# [6] "Axis porcinus"     ASR based on captures from 2,945 male and 5,423 females (PG 02/11/2018)
# [7] "Bassaricyon gabbii"   no data available (PG 02/11/2018)    
# [8] "Bison bison"            no data available (pg 02/11/2018) 
# [9] "Bradypus torquatus"    ASR based on captures from 15 male and 21 female (PG 05/11/2018)  
# [10] "Bradypus variegatus" ASR based on captures from 59 male and 33 female (PG 05/11/2018)

db.mam2[21:30, "binomial"] 
#[1] "Callicebus cupreus"  no data available (PG 08/11/2018)   
#[2] "Callicebus moloch"   no data available (PG 14/11/2018)   
#[3] "Callicebus personatus"  ASR based on captures from 3 male and 3 female (PG 14/11/2018)
#[4] "Callicebus torquatus"   no data available (PG 14/11/2018)
#[5] "Callithrix geoffroyi"   ASR based on captures from 6 male and 8 female (PG 19/11/2018)
#[6] "Callithrix jacchus"     ASR based on captures from 5 male and 4 female (PG 19/11/2018)
#[7] "Callithrix penicillata" ASR based on captures from 13 male and 9 female (PG 19/11/2018)
#[8] "Callorhinus ursinus"    No data available (PG 19/11/2018)
#[9] "Callosciurus erythraeus" ASR based on captures from 360 male and 198 female (PG 20/11/2018)
#[10] "Callosciurus notatus" ASR based on captures from  15.98 male and 17.01 female (PG 20/11/2018)

db.mam2[31:40,"binomial"]
#[1] "Caluromys derbianus" no data available (PG 20/11/2018)
#[2] "Canis adustus"    no data available (PG 26/11/2018)
#[3] "Canis aureus"      no data available (PG 26/11/2018)       
#[4] "Canis latrans"      ASR based on captures from 17 male and 16 female (PG 26/11/2018)
#[5] "Canis lupus"         ASR based on captures from 11 male and 5 female (PG 27/11/2018)
#[6] "Canis mesomelas"     ASR based on captures from 123 male and 84 female (PG 03/12/2018)
#[7] "Canis rufus"         ASR based on captures from 11 male and 4 female (PG 03/12/2018)
#[8] "Capra ibex"          ASR based on captures from 45 male and 28 female (PG 03/12/2018)
#[9] "Capra sibirica"      ASR based on captures from 106.72 male and 103.04 female (PG 03/12/2018)
#[10] "Capricornis crispus" ASR based on captures from 14.11 male and 9.88 female (PG 18/12/2018)

db.mam2 [41:50, "binomial"]
#[1] "Caracal caracal"       ASR based on captures from 1 male and 6 female (PG 18/12/2018)
#[2] "Cardioderma cor"       no data available (PG 19/12/2018)
#[3] "Castor canadensis"     ASR based on captures from 38 male and 38 female. Thirty-eight pairs of adult beavers were studied (PG 19/12/2018)
#[4] "Castor fiber"          ASR based on captures from 6 male and 6 female. Which were the reproducing pairs (PG 19/12/2018)
#[5] "Cercocebus agilis"     no data available (PG 19/12/2018)
#[6] "Cercocebus atys"       no data available (PG 19/12/2018)
#[7] "Cercocebus galeritus"  ASR based on captures from 13 male and 40 female (PG 19/12/2018)
#[8] "Cercopithecus ascanius" no data available (PG 19/12/2018)
#[9] "Cercopithecus cephus"  no data available (PG 19/12/2018)
#[10] "Cercopithecus diana"  no data available (PG 19/12/2018)

db.mam2 [51:60, "binomial"]
#[1] "Cercopithecus mitis"    no data available (PG 19/12/2018)
#[2] "Cercopithecus mona"     no data available (PG 19/12/2018)
#[3] "Cercopithecus neglectus" no data available (PG 19/12/2018)
#[4] "Cercopithecus nictitans" no data available (PG 20/12/2018)
#[5] "Cercopithecus sclateri"  no data available (PG 20/12/2018)
#[6] "Cervus elaphus"          data available by pipoly (PG 20/12/2018) ASR encontrado .368
#[7] "Cervus nippon"           data available by pipoly (PG 20/12/2018)
#[8] "Cheirogaleus medius"     ASR based on captures from 22 male and 14 female (PG 20/12/2018)
#[9] "Chiropotes satanas"      ASR based on captures from 12 male and 9 female (PG 20/12/2018)
#[10] "Chlorocebus aethiops"   no data available (PG 20/12/2018)

db.mam2 [61:70, "binomial"]
#[1] "Chlorocebus sabaeus"    no data available (PG 20/12/2018)
#[2] "Choloepus hoffmanni"    no data available (PG 20/12/2018)
#[3] "Chrysocyon brachyurus"  no data available (PG 21/12/2018)
#[4] "Chrysospalax trevelyani" no data available (PG 21/12/2018)
#[5] "Coendou prehensilis"    no data available (PG 21/12/2018)
#[6] "Colobus angolensis"     ASR based on captures from 12 male and 16 female (PG 21/12/2018)
#[7] "Colobus guereza"        ASR based on captures from 7 male and 9 female (PG 21/12/2018)
#[8] "Colobus polykomos"      no data available (PG 21/12/2018)
#[9] "Colobus satanas"        no data available (PG 21/12/2018) inf en un artículo de 1999 pero no es clara, N no definida
#[10] "Colobus vellerosus"    ASR based on captures from 2 male and 12 female (PG 21/12/2018)

db.mam2[71:80, "binomial"]
#[1] "Condylura cristata"     no data available (PG 25/12/2018)  
#[2] "Conepatus chinga"       ASR based on captures from 6 male and 10 female (PG 25/12/2018)   
#[3] "Connochaetes taurinus"  ASR based on captures from 14 male and 138 female (PG 25/12/2018)
#[4] "Corynorhinus townsendii"no data available (PG 25/12/2018)
#[5] "Cricetomys gambianus"   ASR based on captures from 23 male and 13 female. (Cricetomys gambianus Waterhouse) (PG 25/12/2018) 
#[6] "Crocuta crocuta"        ASR by pipoly ASR found (.774 Frank 1986)
#[7] "Cryptotis parva"        no data available (PG 25/12/2018)
#[8] "Ctenomys talarum"       ASR by pipoly
#[9] "Cynomys leucurus"       ASR based on captures from 9 male and 6 female (PG 25/12/2018)
#[10] "Cynomys ludovicianus"  no data available (PG 25/12/2018)

db.mam2 [81:90, "binomial"]
#[1] "Cynopterus brachyotis"  ASR based on captures from 11 male and 23 female (PG 25/12/2018)   
#[2] "Cystophora cristata"    ASR based on captures from 64 male and 57 female (PG 25/12/2018)      
#[3] "Dama dama"              ASR from pipoly     
#[4] "Dasypus novemcinctus"   ASR based on captures from 58 male and 41 female (PG 25/12/2018)     
#[5] "Dasyurus hallucatus"    ASR based on captures from 26 male and 11 female (PG 25/12/2018)     
#[6] "Dasyurus maculatus"     ASR based on captures from 19 male and 12 female (PG 26/12/2018)    
#[7] "Daubentonia madagascariensis" no data available (PG 26/12/2018)
#[8] "Dendrolagus lumholtzi"  no data available (PG 26/12/2018)     
#[9] "Desmodus rotundus"      ASR based on captures from 132 male and 113 female (PG 26/12/2018)      
#[10] "Diaemus youngi"        no data available (PG 26/12/2018)

db.mam2[91:100, "binomial"]
#[1] "Diceros bicornis"       ASR based on captures from 20 male and 24 female (PG 26/12/2018)    
#[2] "Diclidurus albus"       no data available (PG 26/12/2018)
#[3] "Didelphis aurita"       no data available (PG 26/12/2018)
#[4] "Didelphis marsupialis"  no data available (PG 26/12/2018
#[5] "Didelphis virginiana"   ASR based on captures from 8 male and 9 female (PG 26/12/2018)
#[6] "Dipodomys merriami"     ASR based on captures from 943 male and 631 female (PG 25/12/2018)
#[7] "Dipodomys microps"      no data available (PG 26/12/2018)
#[8] "Dipodomys stephensi"    ASR based on captures from 616 male and 491 female (PG 25/12/2018)
#[9] "Dolichotis patagonum"   no data available (PG 26/12/2018)
#[10] "Elephantulus intufi"   no data available (PG 26/12/2018)

db.mam2 [101:110, "binomial"]
#[1] "Elephantulus myurus"    no data available (PG 26/12/2018) 
#[2] "Elephantulus rufescens" no data available (PG 26/12/2018) 
#[3] "Enhydra lutris"         ASR by pipoly
#[4] "Epomophorus gambianus"  ASR based on captures from 14 male and 17 female (PG 26/12/2018)
#[5] "Equus hemionus"         ASR based on captures from 8 male and 6 female (PG 26/12/2018) 
#[6] "Equus kiang"            no data available (PG 26/12/2018)
#[7] "Equus zebra"            ASR based on captures from 9 male and 22 female (PG 26/12/2018)
#[8] "Eremitalpa granti"      ASR based on captures from 6 male and 9 female (PG 26/12/2018)
#[9] "Erignathus barbatus"    no data available (PG 27/12/2018)
#[10] "Erinaceus europaeus"   ASR by pipoly

db.mam2 [111:120, "binomial"]
#[1] "Erophylla sezekorni"    no data available (PG 27/12/2018) un artículo pero no es claro
#[2] "Erythrocebus patas"     ASR bades on captures from 11 male and 23 female (PG 27/12/2018)
#[3] "Eumetopias jubatus"     no data available (PG 27/12/2018) info no clara
#[4] "Eumops glaucinus"       ASR based on captures from 1 male and 7 female (PG 27/12/2018) based on Eumops glaucinus Floridanus colony
#[5] "Felis chaus"            no data available (PG 27/12/2018)
#[6] "Felis nigripes"         no data available (PG 27/12/2018)
#[7] "Felis silvestris"       ASR based on captures from 30 male and 22 female (PG 27/12/2018) 
#[8] "Funambulus pennantii"   ASR based on captures from 23 male and 17 female (PG 27/12/2018) 
#[9] "Galago senegalensis"    no data available (PG 27/12/2018)
#[10] "Gazella subgutturosa"  ASR based on captures from 4, 705.16 male and 4, 992.06 female (PG 27/12/2018) 

db.mam2 [121:130,"binomial"]
#[1] "Geomys arenarius"       no data available (PG 27/12/2018) 
#[2] "Giraffa camelopardalis" ASR based on captures from 27 male and 46 female (PG 27/12/2018) from Giraffa camelopardalis tippelskirchi
#[3] "Glaucomys volans"       ASR based on captures from 13 male and 8 female (PG 27/12/2018) 
#[4] "Glis glis"              ASR based on captures from 109 male and 82 female (PG 27/12/2018) 
#[5] "Gorilla gorilla"        ASR by pipoly
#[6] "Gulo gulo"              no data available (PG 27/12/2018) 
#[7] "Halichoerus grypus"     no data available (PG 27/12/2018)
#[8] "Hapalemur griseus"      no data available (PG 27/12/2018) 
#[9] "Hemibelideus lemuroides"no data available (PG 27/12/2018)
#[10] "Hemitragus jemlahicus" ASR based on captures from 20 male and 163 female (PG 27/12/2018)

db.mam2 [131:140, "binomial"]
#[1] "Hippopotamus amphibius"  ASR based on captures from 19 male and 26 female (PG 27/12/2018)
#[2] "Hipposideros commersoni" ASR based on captures from 2 male and 20 female (PG 27/12/2018)
#[3] "Hippotragus niger"       no data available (PG 27/12/2018) 
#[4] "Homo sapiens"            no data available (PG 27/12/2018) 
#[5] "Hydrurga leptonyx"       no data available (PG 27/12/2018)
#[6] "Hylobates agilis"        no data available (PG 27/12/2018)
#[7] "Hylobates klossii"       no data available (PG 27/12/2018)
#[8] "Hylobates moloch"        no data available (PG 27/12/2018)
#[9] "Hyperoodon ampullatus"   no data available (PG 27/12/2018) 
#[10] "Hypogeomys antimena"    ASR based on captures from 7 male and 3 female (PG 27/12/2018)

  db.mam2 [141:150, "binomial"]
#[1] "Hypsignathus monstrosus"   
#[2] "Ichneumia albicauda"       
#[3] "Jaculus jaculus"           
#[4] "Jaculus orientalis"        
#[5] "Kobus vardonii"            
#[6] "Lagorchestes hirsutus"     
#[7] "Lavia frons"               
#[8] "Lemur catta"               
#[9] "Leontopithecus chrysomelas"
#[10] "Leontopithecus rosalia"
###########################################################
#-----------------------------------------------
#--------------------Trabajo CCI (10/sept/2018)
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
# [2] "Zalophus californianus"    No ASR, added mating system (06/08/2018)
# [3] "Zalophus japonicus"    
# [4] "Zalophus wollebaeki"   
# [5] "Zapus hudsonius"       
# [6] "Zapus princeps"        
# [7] "Zelotomys woosnami"    
# [8] "Ziphius cavirostris"   
# [9] "Zyzomys argurus"       
# [10] "Zyzomys woodwardi

db.mam[1:114, "binomial"]
     
#[42] "Antilocapra americana"   ASR based on captures from 41 males and 61 females (PG 08/10/2018) 
#[43] "Antilope cervicapra"      
#[44] "Antrozous pallidus"         
#[45] "Aonyx capensis"             
#[46] "Aotus lemurinus"            
#[47] "Aotus trivirgatus"          
#[48] "Aplodontia rufa"            
#[49] "Apodemus agrarius"          
#[50] "Apodemus draco"             
#[51] "Apodemus flavicollis"       
#[52] "Apodemus sylvaticus"        
#[53] "Arctocebus calabarensis"    
#[54] "Arctocephalus australis"    
#[55] "Arctocephalus galapagoensis"
#[56] "Arctocephalus gazella"      
#[57] "Arctocephalus pusillus"     
#[58] "Arctocephalus townsendi"    
#[59] "Arctocephalus tropicalis"   
#[60] "Ardops nichollsi"           
#[61] "Ariteus flavescens"         
#[62] "Artibeus concolor"          
#[63] "Artibeus hirsutus"          
#[64] "Artibeus jamaicensis"       
#[65] "Artibeus lituratus"         
#[66] "Artibeus obscurus"          
#[67] "Arvicanthis niloticus"      
#[68] "Asellia tridens"            
#[69] "Atelerix frontalis"         
#[70] "Ateles geoffroyi"           
#[71] "Ateles paniscus"            
#[72] "Atherurus africanus"        
#[73] "Atilax paludinosus"         
#[74] "Auliscomys pictus"          
#[75] "Avahi laniger"              
#[76] "Axis axis"                  
#[77] "Axis porcinus"              
#[78] "Balaenoptera acutorostrata" 
#[79] "Balantiopteryx io"          
#[80] "Bandicota bengalensis"      
#[81] "Bandicota indica"           
#[82] "Barbastella barbastellus"   
#[83] "Bassaricyon alleni"         
#[84] "Bassaricyon gabbii"         
#[85] "Bassariscus astutus"        
#[86] "Bathyergus janetta"         
#[87] "Bathyergus suillus"         
#[88] "Beamys hindei"              
#[89] "Berylmys bowersi"           
#[90] "Bison bison"                
#[91] "Blarina carolinensis"       
#[92] "Bos gaurus"                 
#[93] "Bos primigenius"            
#[94] "Boselaphus tragocamelus"    
#[95] "Bradypus torquatus"         
#[96] "Bradypus tridactylus"       
#[97] "Bradypus variegatus"        
#[98] "Burramys parvus"            
#[99] "Calcochloris obtusirostris" 
#[100] "Callicebus brunneus"        
#[101] "Callicebus cupreus"         
#[102] "Callicebus moloch"          
#[103] "Callicebus personatus"      
#[104] "Callicebus torquatus"       
#[105] "Callithrix geoffroyi"       
#[106] "Callithrix jacchus"         
#[107] "Callithrix penicillata"     
#[108] "Callorhinus ursinus"        
#[109] "Callosciurus erythraeus"    
#[110] "Callosciurus notatus"       
#[111] "Calomys callosus"           
#[112] "Calomys musculinus"         
#[113] "Calomys sorellus"           
#[114] "Caloprymnus campestris" 
