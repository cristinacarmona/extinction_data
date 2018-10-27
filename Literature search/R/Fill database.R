#########################################################
#Fill in data into database
#########################################################
#Load datasets
setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)


library(openxlsx) #instalar primero
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames =
                        TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin
                                           dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list
names(working.list) <- c("db")

attach(working.list)

###########################################################
db2 <- db
names(db2)

#Work with fish--------------
#Choose Class to work with
table(db2$Class)

str(db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
"CHONDRICHTHYES","SARCOPTERYGII"),]) #16333 obs

str(db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
                         "CHONDRICHTHYES","SARCOPTERYGII") & !is.na(db2$mating_system),])#939

str(db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
                         "CHONDRICHTHYES","SARCOPTERYGII") & 
          ((!is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm)) | 
             (!is.na(db2$male_size_cm.fishbase) & !is.na(db2$female_size_cm.fishbase))),]) #594 sp with known size for male and female

db.fish1<-db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
                         "CHONDRICHTHYES","SARCOPTERYGII") & 
          (((!is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm)) | 
             (!is.na(db2$male_size_cm.fishbase) & !is.na(db2$female_size_cm.fishbase))) &
             !is.na(db2$mating_system)),] #164 species with known male and female size and Mating_system

db.fish2 <- db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
                                "CHONDRICHTHYES","SARCOPTERYGII") & 
                 ((!is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm)) | 
                    (!is.na(db2$male_size_cm.fishbase) & !is.na(db2$female_size_cm.fishbase))),] #updated CCI 21/Sept/2018

str(db.fish2)#594 obs
str(db.fish1)#154
head(db.fish)


#Start with 154 fish species with known size and mating system
db.fish1[1:20,"binomial"] 
# [1] "Agosia chrysogaster"  Mating system added (OGM 22/Ago/2018), no ASR found (CCI 08/10/2018)
# [2] "Albula vulpes"       ASR based on captures of 274 females and 192 males, no data for sex_dim (CCI 08/10/2018)    
# [3] "Alopias vulpinus"    No data (CCI 08/10/2018)    
# [4] "Alosa pseudoharengus"    No data available (CCI 09/10/2018)
# [5] "Alosa sapidissima"   ASR based on three studies from fisheries captures or baited hooks captures: males 1084, females 1248 (Celia, 2007); males 146, females 29 (Layzer, 1979); males 317, females 368 (Craigie, 1926). (CCI 09/10/2018)
# [6] "Amia calva"         ASR based on collected fish: 51 males, 24 females (considering only aged fish and fish > 0 years) (CCI 09/10/2018)     
# [7] "Anguilla anguilla"     Did not consider counts of males and females based on captures during downstream river migration: males 73, females 1145 (Vollestad & Jonsson, 1986); prefered data from captures in lagoons or basins and not during migration: males 737, females 1049 (CCI 10/10/2018)
# [7´] "Balistes capriscus"    ASR data from by-catch captures of 254 males and 444 females, Males were significantly larger than females and could be distinguished from females by size and dark charcoal coloration during the spawning season. (CCI 15/10/2018)
# [8] "Campostoma anomalum"     No data (CCI 10/10/2018)
# [10'] "Campostoma oligolepis"   Distinct tubercle pattern on the nape of nuptial males: Sexes shaped differently. No data available for ASR (CCI 15/10/2018)
# [11'] "Campostoma ornatum"      Distinct tubercle pattern on the nape of nuptial males: Sexes shaped differently. No data available for ASR (CCI 15/10/2018)
# # [9] "Carcharhinus falciformis" ASR based on bycatch captures of 103 males and 149 females (CCI 11/10/2018)
# # [10] "Carcharhinus plumbeus"   ASR based on bycatch: 12 males and 168 females (Saiumldi et al. 2005); based on tagged individuals trapped using longlines: 45 males, 27 females (Romine et al., 2006); tagged individuals trapped using longlines or nets: males 620, females 848 (Kohler et al., 2005) (CCI 15/10/2018).
# # [11] "Carcharias taurus"       ASR based on surveys with photo-id of individuals: 288 males, 271 females (Bansemer & Bennet, 2011) (CCI 15/10/2018)
# [15'] "Cheilinus undulatus"     Species with protogyny and sex change, ASR estimated from a census from unmarked individuals, 15 males and 100 females (CCI 15/10/2018)
# [16'] "Chrosomus eos"           No data available for ASR, added info for sex_dim (CCI 15/10/2018)
# [17'] "Chrosomus neogaeus"      No reliable data for ASR,  The males of these species attain bright red, pink, or yellow colors on their sides and bellies, patches of breeding tubercles at the bases of the pectora and anal fins, and large, modified pectoral fins during the breeding season (CCI 15/10/2018)
# [18'] "Chrosomus oreas"         ASR based on collected fish: 21 males and 13 females; added info for sex_dim (CCI 15/10/2018)
# # [12] "Clarias gariepinus"     No useful data available, most studies did not identify mature individuals from immature (CCI 15/10/2018)      
# [20'] "Clinostomus funduloides" ASR based on collected fish: Among 181 mature dace 102 (56%) were females (CCI 15/10/2018)
# [13] "Cobitis taenia"         ASR based on captured fish: 195 males and 196 females (Marconato & Rasotto, 1989) (CCI 15/10/2018) 
# [14] "Couesius plumbeus"    ASR based on captured and marked fish: 1,282 males, 839 females. These fish were captured in spawning sites so we assumed they were sexually mature as there was no mention of the age in text (Brown et al., 1970) (CCI 15/10/2018).     
# [15] "Cyprinus carpio"      ASR based on captured individuals, 180 males and 168 females of age class > II (according to Fernández-Delgado (1990), carps at this age class are sexually mature) (CCI 15/10/2018)   
# [16] "Dasyatis pastinaca"   No reliable data found, one study showed an ASR of 0.71, however individuals were not marked (Morey et al., 2006) (CCI 15/10/2018)   
# [17] "Engraulis mordax"     No reliable data found (CCI 15/10/2018)        
# [18] "Esox lucius"          ASR based on captured fish: 66 males and 94 females (CCI 15/10/2018)           
# [19] "Etheostoma juliae"    ASR based on captured fish: 53 males and 63 females (CCI 15/10/2018)   


db.fish1[22:41,"binomial"]
# [1] "Couesius plumbeus"   ,/  
# [2] "Cyprinella camura"    ASR based on collected fish: 342 males and 445 females;  The breeding males of both N. galacturus and N. camurus have greatly enlarged dorsal fins and red pigment in both dorsal and anal fin (CCI 16/10/2018).
# [3] "Cyprinella galactura"  The breeding males of both N. galacturus and N. camurus have greatly enlarged dorsal fins and red pigment in both dorsal and anal fin (CCI 16/10/2018).
# [4] "Cyprinella lutrensis"  No data for ASR, added info for sex_dim (CCI 16/10/2018)
# [5] "Cyprinella spiloptera" Breeding adults of N. spilopterus and N. whipplii exhibit a high degree of sexual dimorphism. The back and sides of breeding males are a brilliant steel blue, and the dark crosshatch markings on the sides are much more prominent than in immature specimens and females (CCI 16/10/2018).
# [6] "Cyprinella venusta"    No reliable data for ASR (CCI 16/10/2018)
# [7] "Cyprinella whipplei" No data for ASR, Breeding adults of N. spilopterus and N. whipplii exhibit a high degree of sexual dimorphism. The back and sides of breeding males are a brilliant steel blue, and the dark crosshatch markings on the sides are much more prominent than in immature specimens and females (CCI 16/10/2018)   
# [8] "Cyprinus carpio"     ,/  
# [9] "Dasyatis pastinaca"    ,/
# [10] "Dionda episcopa"     No data available (CCI 17/10/2018)  
# [11] "Engraulis mordax"    ,/  
# [12] "Ericymba buccata"      External sexual dimorphism was not apparent on any mature silverjaw minnows in this study, no reliable data for ASR found (CCI 17/10/2018)
# [13] "Erimystax dissimilis" No data available (CCI 17/10/2018) 
# [14] "Esox lucius"           ,/
# [15] "Etheostoma juliae"     ,/
# [16] "Gadus morhua"         No reliable data (CCI 17/10/2018) 
# [17] "Gambusia affinis"       ASR based on collected fish from two studies: 464 females and 499 males (Milton & Arthington, 1983); 392 males and 746 females (Krumholz, 1948) (CCI 17/10/2018)     
# [18] "Gasterosteus aculeatus" No reliable data for ASR (CCI 17/10/2018)
# [19] "Gila atraria"           ASR based on collected fish: 21 males and 16 females (CCI 17/10/2018)     
# [20] "Gila coerulea"      No data available (CCI 17/10/2018) 


db.fish1[42:61,"binomial"]
# [1] "Haemulon plumierii"      ASR based on collected fish: 117 males (larger than 271 mm, size classes considered from 280-400) and 203 females (larger than 213 mm, size classes considered from 220-400) (Palazón-Fernández, 2007); no sexual dimorphism in body shape or colour was observed (CCI 17/10/2018)
# [2] "Heterodontus portusjacksoni" ASR based on by-catch data: 141 females and 206 males, considered individuals that were mature according to their gonad index in Table 3 (Tovar-Ávila, 2007) (CCI 17/10/2018)
# [3] "Hippocampus reidi"       ASR based on marked-identified individuals: 322 males and 283 females (CCI 17/10/2018)         
# [4] "Hippocampus whitei"      ASR based on marked individuals: 47 adult males and 51 adult females (CCI 17/10/2018)     
# [5] "Huso huso"                No data available (CCI 17/10/2018)  
# [6] "Hybognathus hankinsoni" No data available (CCI 17/10/2018)     
# [7] "Hybognathus nuchalis"   No data available (CCI 17/10/2018)     
# [8] "Hybognathus placitus"   ASR based on collected fish: 30 males and 32 females, although it did not state they were adults, as they examined sexual dimorphism I assumed they were adults (CCI 18/10/2018)
# [9] "Hybognathus regius"     No data available on ASR, sex_dim added (CCI 17/10/2018)    
# [10] "Hybopsis amblops"       No data available (CCI 18/10/2018)    
# [11] "Hybopsis hypsinotus"    No data available (CCI 18/10/2018)
# [12] "Hypophthalmichthys molitrix" No reliable data available (CCI 18/10/2018)
# [13] "Istiophorus platypterus" ASR based on collected fish from fisheries: 699 males and 436 females (CCI 18/10/2018)
# [14] "Isurus oxyrinchus"       ASR based on collected sharks from fisheries: 6 mature males and 11 mature females (CCI 18/10/2018)   
# [15] "Lamna ditropis"         No reliable data available (CCI 18/10/2018)    
# [16] "Lamna nasus"            No reliable data available (CCI 18/10/2018)   
# [17] "Lavinia exilicauda"       No data available (CCI 18/10/2018)  
# [18] "Lepidomeda vittata"     Sexual dimorphism is not marked. The most obvious morphological difference between the sexes involves the pectoral fin, which is noticeably larger in the male; no data for ASR available (CCI 18/10/2018)     
# [19] "Lepisosteus osseus"     ASR based on two studies: collected fish from lake 13 mature males and 11 mature females (Kelley, 2012); tagged fish durng spawning migration 87 males and 42 females (Johnson & Noltie, 1996) (CCI 18/10/2018)    
# [20] "Lepisosteus platyrhincus" No data available (CCI 18/10/2018)


db.fish1[62:81,"binomial"]
# [1] "Lepomis megalotis"      No data available on ASR, added sex_dim (CCI 18/10/2018)
# [2] "Lethrinus nebulosus"    ASR based on collected fish: males > 37.7 cm = 553, females > 43.4 cm = 405 (CCI 19/10/2018)
# [3] "Luxilus albeolus"       No data available (CCI 19/10/2018)
# [4] "Luxilus cardinalis"     No data available (CCI 19/10/2018)
# [5] "Luxilus chrysocephalus" No data available (CCI 19/10/2018)
# [6] "Luxilus coccogenis"     No data available (CCI 19/10/2018)
# [7] "Luxilus cornutus"       Added info for sex_dim (CCI 19/10/2018)
# [8] "Luxilus pilsbryi"       No data available (CCI 19/10/2018)
# [9] "Luxilus zonistius"      No data available (CCI 19/10/2018)
# [10] "Lythrurus ardens"      No data available (CCI 22/10/2018)
# [11] "Lythrurus bellus"      No data available (CCI 22/10/2018)  
# [12] "Lythrurus fasciolaris"  ASR based on collected fish: 169 males and 197 females (CCI 22/10/2018)
# [13] "Lythrurus fumeus"     No data available (CCI 22/10/2018)       
# [14] "Lythrurus matutinus"   No data available (CCI 22/10/2018) 
# [15] "Lythrurus umbratilis"   Added info for sex_dim (CCI 22/10/2018)
# [16] "Macrhybopsis storeriana" No data available (CCI 22/10/2018) 
# [17] "Margariscus margarita"  ASR based on collected fish > 1 year old estimated from figure 3 page 82 (Felts, 2013): 67 females and 46 males (CCI 22/10/2018)
# [18] "Megalops atlanticus"    ASR based on collected fish > 102 cm (males) and > 130 cm (females) from table 4 (Crabtree et al., 1995): 90 males and 222 females (CCI 22/10/2018)
# [19] "Morone americana"       No reliable data available (CCI 22/10/2018)
# [20] "Morone chrysops"        No reliable data available (CCI 22/10/2018)


db.fish1[82:101,"binomial"]
# [1] "Morone saxatilis"      No reliable data available (CCI 22/10/2018)    
# [2] "Mugil cephalus"        ASR based on collected fish: 208 males and 303 females (CCI 22/10/2018) 
# [3] "Mustelus henlei"       ASR based on collected sharks: 168 mature males, 246 mature females (CCI 22/10/2018) 
# [4] "Mylopharyngodon piceus" No data available (CCI 22/10/2018)
# [5] "Neogobius melanostomus" No data from natural range available, could not get copy of (Kovtun, 1979) (CCI 23/10/2018)
# [6] "Nocomis asper"          No data available (CCI 23/10/2018)
# [7] "Nocomis biguttatus"     No data available (CCI 23/10/2018) 
# [8] "Nocomis leptocephalus"  No data available (CCI 23/10/2018)
# [9] "Nocomis micropogon"     No data available (CCI 23/10/2018)
# [10] "Notemigonus crysoleucas" ASR based on marked fish, average for 8 years: 1190 males and 1190 females (CCI 23/10/2018)
# [11] "Notropis ammophilus"   No data available (CCI 23/10/2018)
# [12] "Notropis amoenus"      Added info for sex_dim (CCI 23/10/2018)
# [13] "Notropis atherinoides" ASR based on collected fish: 328 males and 121 females (CCI 23/10/2018) 
# [14] "Notropis bairdi"        No data available (CCI 23/10/2018)
# [15] "Notropis bifrenatus"    Added info for sex_dim (CCI 23/10/2018)
# [16] "Notropis blennius"      No data available (CCI 23/10/2018)
# [17] "Notropis chalybaeus"    No data available (CCI 23/10/2018)
# [18] "Notropis chiliticus"    Added info for sex_dim (CCI 23/10/2018)
# [19] "Notropis cummingsae"    No data available (CCI 23/10/2018)
# [20] "Notropis heterodon"     No data available (CCI 23/10/2018)

db.fish1[102:121,"binomial"]
# [1] "Notropis heterolepis"    No data available (CCI 23/10/2018)   
# [2] "Notropis lutipinnis"     No data available (CCI 23/10/2018) 
# [3] "Notropis nubilus"        No reliable data available (CCI 24/10/2018) 
# [4] "Notropis rubellus"       ASR based on fish collected for two studies: 322 males and 308 females (Pfeiffer, 1955); 1589 males and 1427 females (Reed, 1957) (CCI 24/10/2018) 
# [5] "Notropis stilbius"       No data available (CCI 24/10/2018) 
# [6] "Notropis stramineus"     Added info for sex_dim (CCI 24/10/2018)      
# [7] "Notropis texanus"        No data available (CCI 24/10/2018) 
# [8] "Notropis volucellus"     ASR based on collected fish: 549 males and 335 females (CCI 24/10/2018)   
# [9] "Opsanus beta"            No data available (CCI 24/10/2018)           
# [10] "Opsopoeodus emiliae"    No data available (CCI 24/10/2018)  
# [11] "Paralichthys californicus"  No reliable data available (CCI 24/10/2018)
# [12] "Perca fluviatilis"       ASR based on collected fish: 52 females and 62 males (CCI 24/10/2018) 
# [13] "Phenacobius crassilabrum" No data available (CCI 24/10/2018)
# [14] "Phenacobius mirabilis"    No data available (CCI 24/10/2018)
# [15] "Pimephales notatus"       Added info for sex_dim (CCI 24/10/2018)
# [16] "Pimephales promelas"      No data available (CCI 24/10/2018)
# [17] "Pimephales vigilax"       Added info for sex_dim (CCI 24/10/2018)
# [18] "Polyodon spathula"        ASR based on collected fish: males >= 10 y - 29, females >= 15 y - 15, added info for sex_dim (CCI 24/10/2018)
# [19] "Potamotrygon motoro"      No data available (CCI 24/10/2018)      
# [20] "Prionace glauca"          ASR based on collected sharks small adults and large adults based on fig. 3 (Montealegre-Quijano & Vooren, 2010): 698 males and 208 females (CCI 24/10/2018)


db.fish1[122:141,"binomial"]
# [1] "Pteronotropis hubbsi"       Added info for sex_dim, ASR data not reliable, could not find original source (CCI 25/10/2018)
# [2] "Pteronotropis signipinnis"  ASR based on collected fish: males >= 33 mm - 172, females >= 26 mm - 254 (according to table 2 and 4 Albanese, 2000) (CCI 25/10/2018)
# [3] "Pteronotropis welaka"       Added info for sex_dim, no reliable data for ASR found (CCI 25/10/2018)
# [4] "Ptychocheilus grandis"      No data available (CCI 25/10/2018)
# [5] "Rhinichthys atratulus"      ASR based on collected fish (mature >= age group 1): males 576, females 492 (CCI 25/10/2018)
# [6] "Rhinichthys cataractae"     ASR based on collected fish >= age II: 311 males and 492 females (CCI 25/10/2018)
# [7] "Rhinichthys cobitis"        Added info for sex_dim (CCI 25/10/2018)
# [8] "Rhinichthys osculus"        No data available (CCI 25/10/2018)
# [9] "Richardsonius balteatus"    Added info for sex_dim (CCI 25/10/2018)
# [10] "Salmo trutta"              ASR based on collected fish > 2y from two studies: 103 females and 65 males( Treasurer, 1976); 74 females and 35 males (Ahmet et al., 2005) (CCI 25/10/2018)
# [11] "Sander lucioperca"         ASR based on collected mature fish during spawning run: 101 males and 65 females (CCI 25/10/2018) 
# [12] "Sander vitreus"            No reliable data found (CCI 25/10/2018)
# [13] "Scaphirhynchus platorynchus" No reliable data found (CCI 25/10/2018)
# [14] "Semotilus atromaculatus"     ASR based on collected or marked fish: 385 males and 540 females (CCI 26/10/2018)
# [15] "Semotilus corporalis"       Added info for sex_dim (CCI 26/10/2018)
# [16] "Semotilus lumbee"           No data available (CCI 26/10/2018)
# [17] "Siganus canaliculatus"      Added info for sex_dim (CCI 26/10/2018)
# [18] "Silurus glanis"             No data available (CCI 26/10/2018)
# [19] "Sphyrna lewini"             ASR based on collected sharks: 36 male adults, 44 female adults (CCI 26/10/2018)
# [20] "Squalus acanthias"          ASR based on by-catch sharks: 88 mature females, 34 mature males (CCI 26/10/2018)

db.fish1[142:154,"binomial"]
# [1] "Squalus suckleyi"         ASR based on collected sharks: 520 mature males, 675 mature females (CCI 26/10/2018)
# [2] "Symphodus cinereus"       No data available (CCI 26/10/2018)
# [3] "Symphodus roissali"       Added info for sex_dim (CCI 26/10/2018)
# [4] "Symphodus rostratus"      No data available (CCI 26/10/2018) 
# [5] "Symphodus tinca"          ASR based on collected fish: 327 females > 11 cm, 542 males > 10 cm (CCI 26/10/2018)
# [6] "Takifugu rubripes"        No data available (CCI 26/10/2018)
# [7] "Tautogolabrus adspersus"  ASR based on collected fish: 47 males and 28 females (CCI 26/10/2018)
# [8] "Thunnus alalunga"         ASR based on collected fish: 93 males (stage 3-5, Table III), 76 females (stage 2-8, Table V) (CCI 26/10/2018)
# [9] "Thunnus thynnus"          No reliable data found (CCI 26/10/2018)
# [10] "Trachinotus falcatus"    ASR based on collected fish: 104 males (>= 486mm), 98 females (>=547mm) (CCI 26/10/2018)
# [11] "Triakis semifasciata"    No data available (CCI 26/10/2018)
# [12] "Tropheus moorii"         Added info for sex_dim (CCI 26/10/2018)
# [13] "Zebrasoma flavescens"    No data available (CCI 26/10/2018)

