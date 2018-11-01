#31/10/2018
#Load dataset Oophaga pumilio
#Count males and females

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/Analysis/Amphibia")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)


library(openxlsx) #instalar primero
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames =
                        TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin
                                           dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list
names(working.list) <- c("pum")

attach(working.list)
###########################################################

names(pum)
head(pum)

pum.num <- aggregate(pum$Sex, by = as.list(pum$Date), function(x) length(which(x =="F")))


table(pum$Sex, pum$Date)
# F    M 
# 1645  658

# 29992 29993 29994 29995 29997 29999
# F     8     6     4    14    14    19
# M     4     2     2     7     5     4
# 
# 30000 30005 30006 30007 30008 30009
# F    13    15    10    16     3     1
# M     7     7     4     6     1     0
# 
# 30015 30016 30018 30019 30033 30034
# F     9    12     7    12    10     8
# M     5     5     3     5     8     7
# 
# 30035 30039 30041 30047 30048 30049
# F     9     7    26    35    36    27
# M     1     5    14    11    16    26
# 
# 30050 30053 30054 30056 30057 30058
# F    31    20    12     7     5    26
# M    22    12     5     6     4    24
# 
# 30064 30068 30071 30081 30088 30120
# F    40    37    34    37    22    33
# M    10    14    18    20    11    16
# 
# 30124 30141 30156 30172 30179 30186
# F    35    20    23    26    29    16
# M    11     7     8     5     6     6
# 
# 30193 30201 30207 30214 30228 30229
# F    12    13    15    23    18     3
# M     5     3     6    10     5     1
# 
# 30235 30236 30266 30270 30277 30284
# F    10    15    21    10    15    13
# M     1     4     4     5     5     2
# 
# 30291 30306 30312 30319 30326 30333
# F    19    12    16    12    15     5
# M     3     5     4     2     3     0
# 
# 30340 30347 30354 30361 30368 30375
# F    16     7     6     4    23    32
# M     2     3     5     4    10    11
# 
# 30382 30389 30396 30411 30417 30418
# F    33    45    39    38    28     8
# M    14    11    18    17    12     4
# 
# 30452 30459 30460 30466 30474 30487
# F    45    32    20    40    40    19
# M    20    14     6    16    20     7
# 
# 30488 30494 30508 30522 30537 30550
# F    14    36    17    21    21    17
# M     5     9     6     4     6     2
# 
# 30558
# F    23
# M     4
