#########################################################
#Fill in data into database
#########################################################
#Load datasets
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

str(db2[db2$Class %in% "ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
"CHONDRICHTHYES","SARCOPTERYGII",]) #6278 obs


db.fish <- db2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
"CHONDRICHTHYES","SARCOPTERYGII") & !is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm),]

str(db.fish)#161 obs
head(db.fish)

db.fish[1:3,"binomial"] 
# "Agosia chrysogaster" Faltan comentarios y sex.dim y ASR(OGM 22/08/2018)  
# "Campostoma anomalum"   
# "Campostoma oligolepis"