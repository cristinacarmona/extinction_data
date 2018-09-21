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

#Example with reptiles--------------
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

str(db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
                         "CHONDRICHTHYES","SARCOPTERYGII") & 
          ((!is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm)) | 
             (!is.na(db2$male_size_cm.fishbase) & !is.na(db2$female_size_cm.fishbase)) &
             !is.na(db2$mating_system)),]) #164 species with known male and female size and Mating_system

db.fish <- db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
                                "CHONDRICHTHYES","SARCOPTERYGII") & 
                 ((!is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm)) | 
                    (!is.na(db2$male_size_cm.fishbase) & !is.na(db2$female_size_cm.fishbase))),] #updated CCI 21/Sept/2018

str(db.fish)#594 obs
head(db.fish)

db.fish[1:20,"binomial"] 
# [1] "Abramis brama"            
# [2] "Acanthobrama marmid"      
# [3] "Acanthopagrus bifasciatus"
# [4] "Acanthopagrus butcheri"   
# [5] "Acanthopagrus schlegelii" 
# [6] "Achoerodus gouldii"       
# [7] "Acipenser oxyrinchus"     
# [8] "Acipenser stellatus"      
# [9] "Agosia chrysogaster"      
# [10] "Albula vulpes"            
# [11] "Alburnoides eichwaldii"   
# [12] "Alburnus alburnus"        
# [13] "Alburnus belvica"         
# [14] "Alburnus chalcoides"      
# [15] "Alepocephalus rostratus"  
# [16] "Alestes baremoze"         
# [17] "Alestes dentex"           
# [18] "Alopias pelagicus"        
# [19] "Alopias superciliosus"    
# [20] "Alopias vulpinus"