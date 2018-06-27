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
# [1] "Acomys cahirinus"  #no data  27 06 2018 PG
# [2] "Acomys russatus"     #no data
# [3] "Acomys spinosissimus" #no data
# [4] "Acomys subspinosus"  #no data
# [5] "Acomys wilsoni"  #no data

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




