#########################################################
#Fill in data into database
#########################################################
#Load datasets

setwd("/Users/mariapaula/extinction_data/Literature search/input")

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

names(db)
db2 <- db
#Example with reptiles--------------
#Choose Class to work with
table(db2$Class)

str(db2[db2$Class %in% "REPTILIA",]) #6278 obs

db.amp <- db2[db2$Class %in% c("AMPHIBIA") & !is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm),]

str(db.amp)#161 obs
head(db.amp)
db.amp[1:3,"binomial"]
# [1] "Acris crepitans"
# [2] "Acris gryllus"  
# [3] "Adelotus brevis"
