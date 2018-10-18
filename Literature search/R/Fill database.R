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


#Start with 164 fish species with known size and mating system
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
# [2] "Lethrinus nebulosus"    
# [3] "Luxilus albeolus"       
# [4] "Luxilus cardinalis"     
# [5] "Luxilus chrysocephalus" 
# [6] "Luxilus coccogenis"     
# [7] "Luxilus cornutus"       
# [8] "Luxilus pilsbryi"       
# [9] "Luxilus zonistius"      
# [10] "Lythrurus ardens"       
# [11] "Lythrurus bellus"       
# [12] "Lythrurus fasciolaris"  
# [13] "Lythrurus fumeus"       
# [14] "Lythrurus matutinus"    
# [15] "Lythrurus umbratilis"   
# [16] "Macrhybopsis storeriana"
# [17] "Margariscus margarita"  
# [18] "Megalops atlanticus"    
# [19] "Morone americana"       
# [20] "Morone chrysops"


db.fish1[82:101,"binomial"]
# [1] "Morone saxatilis"       
# [2] "Mugil cephalus"         
# [3] "Mustelus henlei"        
# [4] "Mylopharyngodon piceus" 
# [5] "Neogobius melanostomus" 
# [6] "Nocomis asper"          
# [7] "Nocomis biguttatus"     
# [8] "Nocomis leptocephalus"  
# [9] "Nocomis micropogon"     
# [10] "Notemigonus crysoleucas"
# [11] "Notropis ammophilus"    
# [12] "Notropis amoenus"       
# [13] "Notropis atherinoides"  
# [14] "Notropis bairdi"        
# [15] "Notropis bifrenatus"    
# [16] "Notropis blennius"      
# [17] "Notropis chalybaeus"    
# [18] "Notropis chiliticus"    
# [19] "Notropis cummingsae"    
# [20] "Notropis heterodon" 


