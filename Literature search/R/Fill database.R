#########################################################
#Fill in data into database
#########################################################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles

library(openxlsx) #instalar primero
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


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

str(db[db$Class %in% "REPTILIA",]) #6278 obs

db.rep <- db[db$Class %in% c("REPTILIA") & !is.na(db$male_svl_cm) & !is.na(db$female_svl_cm),]

str(db.rep)#253 obs

db.rep[1:5,"binomial"]
#db.rep[1:5,]
# [1] "Acanthodactylus erythrurus" ASR and mating system (CCI 26/06/18)
# [2] "Acanthophis laevis"        no data available (CCI 26/06/28)
# [3] "Acanthophis rugosus"       no data available (CCI 13/06/2018)
# [4] "Acrochordus arafurae"      scrambling mating system (CCI 27/06/2018)
# [5] "Acrochordus granulatus"    no data available (CCI 27/06/2018)

db.rep[6:10,"binomial"]
# [1] "Agkistrodon contortrix"  Added ASR (CCI 29 jun 2018)
# [2] "Agkistrodon piscivorus"  data already known
# [3] "Aipysurus laevis"       Added ASR and sex dimorphism (CCI 29 jun 2018)
# [4] "Ameiva atrigularis"   no data available (CCI 13/06/2018) 
# [5] "Ameiva praesignis"   no data available (CCI 13/06/2018)


db.rep[11:15,"binomial"]
# [1] "Anilios ammodytes" no data available (CCI 13/06/2018) 
# [2]"Anilios australis"     no data available (CCI 13/06/2018) 
# [3] "Anilios bituberculatus"  no data available (CCI 13/06/2018) 
# [4]"Anilios diversus"      no data available (CCI 13/06/2018) 
# [5] "Anilios endoterus"   no data available (CCI 13/06/2018) 

db.rep[16:20,"binomial"]
#[1] "Anilios ligatus"     no data available (CCI 13/06/2018) 
#"Anilios pinguis"    no data available (CCI 13/06/2018) 
#[3] "Anolis carolinensis"  ASR and Mating system already known from adw
#"Antaresia childreni"  no data available(CCI 13/06/2018)
#[5] "Antaresia maculosa"  no data available (CCI 13/06/2018)

db.rep[21:25,"binomial"]
# [1] "Antaresia perthensis"  no data available (CCI 03/07/2018)  
# [2] "Antaresia stimsoni"    found derived ASR from pythons encountered on road and marked (CCI 03/07/2018)
# [3] "Archaeolacerta bedriagae" no data available (CCI 03/07/2018)
# [4] "Arizona elegans"         no data available for ASR (CCI 03/07/2018)
# [5] "Aspidites melanocephalus" no data available for ASR (CCI 03/07/2018)

db.rep[26:30, "binomial"]
# [1] "Aspidites ramsayi"          
# [2] "Aspidomorphus lineaticollis"
# [3] "Aspidomorphus muelleri"     
# [4] "Aspidomorphus schlegelii"   
# [5] "Atractus major"
