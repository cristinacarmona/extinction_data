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
          ((!is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm)) | 
             (!is.na(db2$male_size_cm.fishbase) & !is.na(db2$female_size_cm.fishbase)) &
             !is.na(db2$mating_system)),] #164 species with known male and female size and Mating_system

db.fish2 <- db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
                                "CHONDRICHTHYES","SARCOPTERYGII") & 
                 ((!is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm)) | 
                    (!is.na(db2$male_size_cm.fishbase) & !is.na(db2$female_size_cm.fishbase))),] #updated CCI 21/Sept/2018

str(db.fish2)#594 obs
str(db.fish1)#164
head(db.fish)


#Start with 164 fish species with known size and mating system
db.fish1[1:20,"binomial"] 
# [1] "Agosia chrysogaster"     
# [2] "Albula vulpes"           
# [3] "Alopias vulpinus"        
# [4] "Alosa pseudoharengus"    
# [5] "Alosa sapidissima"       
# [6] "Amia calva"              
# [7] "Anguilla anguilla"       
# [8] "Campostoma anomalum"     
# [9] "Campostoma oligolepis"   
# [10] "Campostoma ornatum"      
# [11] "Carcharhinus falciformis"
# [12] "Carcharhinus plumbeus"   
# [13] "Carcharias taurus"       
# [14] "Clarias gariepinus"      
# [15] "Clinostomus funduloides" 
# [16] "Cobitis taenia"          
# [17] "Couesius plumbeus"       
# [18] "Cyprinella camura"       
# [19] "Cyprinella galactura"    
# [20] "Cyprinella lutrensis" 