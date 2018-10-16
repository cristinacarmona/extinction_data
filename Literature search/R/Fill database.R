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
# [2] "Cyprinella camura"     
# [3] "Cyprinella galactura"  
# [4] "Cyprinella lutrensis"  
# [5] "Cyprinella spiloptera" 
# [6] "Cyprinella venusta"    
# [7] "Cyprinella whipplei"   
# [8] "Cyprinus carpio"     ,/  
# [9] "Dasyatis pastinaca"    ,/
# [10] "Dionda episcopa"       
# [11] "Engraulis mordax"      
# [12] "Ericymba buccata"      
# [13] "Erimystax dissimilis"  
# [14] "Esox lucius"           ,/
# [15] "Etheostoma juliae"     ,/
# [16] "Gadus morhua"          
# [17] "Gambusia affinis"      
# [18] "Gasterosteus aculeatus"
# [19] "Gila atraria"          
# [20] "Gila coerulea" 