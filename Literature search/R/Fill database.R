#########################################################
#Fill in data into database
#########################################################
#Load datasets

#setwd("/Users/mariapaula/extinction_data/Literature search/input")

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input/")

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

str(db2[db2$Class %in% "AMPHIBIA",]) #6609 obs

db.amp <- db2[db2$Class %in% c("AMPHIBIA") & !is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm),]

str(db.amp)#661 obs

db.amp[!is.na(db.amp$ASR), "binomial"] #8
db.amp[!is.na(db.amp$mating_system), "binomial"] #51
db.amp[!is.na(db.amp$sex_dim), "binomial"] #38
db.amp[!is.na(db.amp$sex_dim) | !is.na(db.amp$mating_system), "binomial"] #58

amp <- db.amp[!is.na(db.amp$sex_dim) | !is.na(db.amp$mating_system), ] #58

head(db.amp)
amp[1:20,"binomial"]
# [1] "Acris gryllus"     No data available (CCI 29/10/2018)         
# [2] "Alytes cisternasii"  ASR based on marked individuals: 74 males (>= 1 year old), 12 females (>=2 year old) (CCI 29/10/2018)      
# [3] "Alytes obstetricans"   ASR based on marked individuals: 59 males (>=1 year old), 31 females (>=2 year old) (CCI 29/10/2018)
# [4] "Amolops lifanensis"    No data available (CCI 29/10/2018)    
# [5] "Amolops mantzorum"     ASR based on marked individuals trapped during breeding season: 30 males and 15 females (CCI 29/10/2018)     
# [6] "Anaxyrus americanus"   ASR based on marked individuals trapped during breeding aggregations: 624 males and 87 females (CCI 29/10/2018) 
# [7] "Anaxyrus quercicus"    ASR based on marked individuals trapped during breeding season: 132 males and 77 females (CCI 29/10/2018)    
# [8] "Ascaphus truei"        ASR based on collected adults: 201 males and 255 females (CCI 29/10/2018)    
# [9] "Bombina orientalis"    No data available (CCI 29/10/2018)   
# [10] "Brachycephalus ephippium" No data available (CCI 29/10/2018)
# [11] "Bufo andrewsi"         ASR based on collected and marked individuals: 1369 males and 478 females (CCI 29/10/2018)    
# [12] "Bufo bufo"             ASR known from Pipoly, added info for sex_dim (CCI 30/10/2018)
# [13] "Bufo gargarizans"      ASR known from Pipoly, added info for sex_dim (CCI 30/10/2018)    
# [14] "Chiromantis xerampelina"   No data available (CCI 30/10/2018)
# [15] "Conraua goliath"           No data available (CCI 30/10/2018)
# [16] "Dendrobates auratus"       No data available (CCI 30/10/2018)
# [17] "Dendrobates leucomelas"    No data available (CCI 30/10/2018)
# [18] "Dendrobates tinctorius"    No data available (CCI 30/10/2018)
# [19] "Duttaphrynus melanostictus" ASR based on collected individuals from two studies: 48 males and 35 females (Döring et al., 2017); 53 males and 56 females (Ngo & Ngo, 2013) (CCI 30/10/2018)
# [20] "Edalorhina perezi"        No data available (CCI 30/10/2018)

amp[21:40,"binomial"]
# [1] "Eleutherodactylus coqui"  ASR based on marked individuals on two areas and two seasons: 294 females and 310 males (CCI 30/10/2018)  
# [2] "Fejervarya limnocharis"   No data available (CCI 31/10/2018) 
# [3] "Hyla annectans"           ASR based on marked individuals from two populations of Hyla annectans chuanxiensis: 64 male adults and 33 female adults (CCI 31/10/2018) 
# [4] "Hyla arborea"             ASR known from Pipoly, added info for sex_dim (CCI 31/10/2018)
# [5] "Hyperolius marmoratus"    ASR based on marked individuals estimated from figure 1 (Telfrod & Dyson, 1988): 2651 males and 276 females (CCI 31/10/2018)
# [6] "Limnodynastes peronii"    No data available (CCI 31/10/2018)
# [7] "Lithobates catesbeianus"  No data available (CCI 31/10/2018) 
# [8] "Lithobates clamitans"     No data available (CCI 31/10/2018) 
# [9] "Lithobates pipiens"       No data available (CCI 31/10/2018) 
# [10] "Lithobates sylvaticus"   ASR based on marked individuals from two populations: 129 males and 63 females (CCI 31/10/2018)  
# [11] "Mantella aurantiaca"     No data available (CCI 30/10/2018)  
# [12] "Mixophyes fasciolatus"   No data available (CCI 31/10/2018)  
# [13] "Mixophyes fleayi"        No data available (CCI 31/10/2018)   
# [14] "Nanorana parkeri"        ASR based on marked individuals: 363 males and 143 females (CCI 31/10/2018)          
# [15] "Odorrana grahami"        ASR based on collected individuals: 189 males and 173 females (CCI 31/10/2018)  
# [16] "Oophaga histrionica"     No data available (CCI 31/10/2018)  
# [17] "Oophaga lehmanni"        No data available (CCI 31/10/2018)  
# [18] "Oophaga pumilio"         ASR based on 85 surveys from marked individuals: 658 males and 1645 females (CCI 31/10/2018) 
# [19] "Osteopilus septentrionalis" No data available (CCI 31/10/2018)
# [20] "Pelobates fuscus"         ASR based on data from two studies of marked frogs: 87 males and 29 females (Eggert & Guyétant, 1999); and from 4 years of pond surveys: 711 males and 429 females (Hels, 2002) (CCI 31/10/2018) 

amp[41:60,"binomial"]
# [1] "Phyllobates terribilis"   No data available (CCI 01/11/2018)
# [2] "Phyllomedusa burmeisteri" No data available (CCI 01/11/2018)
# [3] "Pseudacris brachyphona"   ASR based on newly marked individuals from 5 years: 1018 males and 171 females (CCI 01/11/2018)
# [4] "Pseudacris crucifer"      No data available (CCI 02/11/2018)
# [5] "Pseudacris regilla"       No data available (CCI 05/11/2018)
# [6] "Pseudacris streckeri"     ASR based on marked individuals: 91 males and 62 females (estimated from figure 11, Tucker & Philipp, 1995) (CCI 05/11/2018)
# [7] "Pseudacris triseriata"    ASR based on marked individuals from a 3 year study: 1145 males and 1144 females (CCI 05/11/2018)
# [8] "Rana boylii"              ASR based on captured and marked adults during breeding season and post-reproductive months: 31 males and 21 females (CCI 05/11/2018)
# [9] "Rana chensinensis"        ASR based on captured adults from 3 different elevations: 73 males, 61 females (CCI 05/11/2018)
# [10] "Rana luteiventris"       ASR based on marked adults: 93 males and 45 females (CCI 05/11/2018)
# [11] "Rana omeimontis"         No data available (CCI 05/11/2018)
# [12] "Rana temporaria"         ASR based on marked adults from 2 studies: 546 males and 195 females newly marked throughout 8 years(Elmberg, 1990); 78 males and 19 females (Guarino et al., 2008)(CCI 05/11/2018)
# [13] "Rhacophorus omeimontis"  ASR based on marked adults from 2 ponds: 230 males and 82 females (CCI 05/11/2018)
# [14] "Rhinella marina"         No data available (CCI 05/11/2018)
# [15] "Scaphiopus couchii"      No data available (CCI 05/11/2018)
# [16] "Spea bombifrons"         No data available (CCI 05/11/2018)
# [17] "Spea intermontana"       No data available (CCI 05/11/2018)
# [18] "Xenopus laevis"          No data available (CCI 05/11/2018)



######################################################################################
#Add species from Pipoly for which ASR was not added due to difference in sp names (use synonyms)

#Load pipoly dataset

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/Analysis/Bases de datos originales/")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)


library(openxlsx) #instalar primero
import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames =
                        TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin
                                           dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list[10]
names(working.list) <- c("pipoly")

attach(working.list)
###########################################################

names(pipoly)
pip.noaves <- pipoly[pipoly$Taxon %in% c("mammal","amphibian", "reptile"),]
str(pip.noaves) #157 obs
str(pip.noaves[pip.noaves$Taxon %in% "amphibian",]) #39


trim.trailing <- function (x) sub("\\s+$", "", x)
db$Synonyms_nospace<-trim.trailing(db$Synonyms)

intersect(pip.noaves$Scientific.name, db$binomial[db$Class %in% "AMPHIBIA"])#21 amphibians from pipoly in binomial sp
pip.names.not.in.binomial<-setdiff(pip.noaves$Scientific.name[pip.noaves$Taxon %in% "amphibian"], db$binomial[db$Class %in% "AMPHIBIA"]) #18 sp from pipoly not in binomial sp


c<-match.arg(pip.names.not.in.binomial, db$Synonyms_nospace, several.ok=T) #7 from the 18 not found in binomial are found in synonyms

x<-pmatch(pip.names.not.in.binomial, db$Synonyms_nospace)#7
db$Synonyms_nospace[x[!is.na(x)]]#7
syn.inpip<-pip.names.not.in.binomial[!is.na(x)]

#------debug, species that should appear using pmatch or match.arg:-------
pip.names.not.in.binomial[!pip.names.not.in.binomial %in% syn.inpip]
# [1] "Bufo marinus"          si
# [2] "Bufo melanostictus"    si
# [3] "Bufo viridis"          si
# [4] "Hydromantes ambrosii"  no está
# [5] "Hydromantes imperialis" no está 
# [6] "Hydromantes italicus"  no está
# [7] "Rana catesbeiana"      si
# [8] "Rana nigromaculata"    si
# [9] "Rana ridibunda"        si
# [10] "Rana sphenocephala"   si
# [11] "Triturus alpestris"   si

#trial:
trial<- "Ansonia kamblei  | Bufo melanostictus  |Bufo tienhoensis  "
match.arg(pip.names.not.in.binomial, trial, several.ok=T)
pmatch(pip.names.not.in.binomial, trial)

#--------------------------------
#Do it one by one for the 18 species not found in binomial names (4,5 and 6 not in db)-----
db[grep(pip.names.not.in.binomial[1], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% "Bufo marinus"] <- "Rhinella marina"

db[grep(pip.names.not.in.binomial[2], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[2]] <- db[grep(pip.names.not.in.binomial[2], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[3], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% "Bufo viridis"] <- "Bufotes viridis"

db[grep(pip.names.not.in.binomial[7], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[7]] <- db[grep(pip.names.not.in.binomial[7], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[8], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[8]] <- db[grep(pip.names.not.in.binomial[8], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[9], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[9]] <- db[grep(pip.names.not.in.binomial[9], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[10], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[10]] <- db[grep(pip.names.not.in.binomial[10], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[11], db$Synonyms_nospace), c("binomial","Synonyms")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[11]] <- "Pelophylax nigromaculatus"

db[grep(pip.names.not.in.binomial[12], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[12]] <- db[grep(pip.names.not.in.binomial[12], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[13], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[13]] <- db[grep(pip.names.not.in.binomial[13], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[14], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[14]] <- db[grep(pip.names.not.in.binomial[14], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[15], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[15]] <- db[grep(pip.names.not.in.binomial[15], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[16], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[16]] <- db[grep(pip.names.not.in.binomial[16], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[17], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[17]] <- db[grep(pip.names.not.in.binomial[17], db$Synonyms_nospace), c("binomial")]

db[grep(pip.names.not.in.binomial[18], db$Synonyms_nospace), c("binomial")]
pipoly$binomial[pipoly$Scientific.name %in% pip.names.not.in.binomial[18]] <- db[grep(pip.names.not.in.binomial[18], db$Synonyms_nospace), c("binomial")]


#----------------------------
#Add ASR to those 18 sp from pipoly with no ASR in db-----
names(pipoly)
add.asr <- pipoly[!is.na(pipoly$binomial), c("binomial","Adult.sex.ratio.*")]
add.asr$ref.asr <- "pipoly"
colnames(add.asr)<-c("binomial","ASR","ref.asr")

db.pip <- merge(db, add.asr, by="binomial", all.x=T)
head(db.pip)

#merge ASR.x and ASR.y, ref.asr.x and ref.asr.y----
db.pip[db.pip$ref.asr.x %in% "pipoly" | db.pip$ref.asr.y %in% "pipoly", c("binomial","ASR.x","ASR.y", "ref.asr.x", "ref.asr.y")]
db.pip[db.pip$binomial %in% "Duttaphrynus melanostictus",]

db.pip$ASR <- ifelse(is.na(db.pip$ASR.x) & !is.na(db.pip$ASR.y), db.pip$ASR.y, db.pip$ASR.x)
db.pip[db.pip$ref.asr.x %in% "pipoly" | db.pip$ref.asr.y %in% "pipoly", c("ASR.x","ASR.y","ASR")]

db.pip$ref.asr <- ifelse(is.na(db.pip$ref.asr.x) & !is.na(db.pip$ref.asr.y), db.pip$ref.asr.y, db.pip$ref.asr.x)
db.pip[db.pip$ref.asr.x %in% "pipoly" | db.pip$ref.asr.y %in% "pipoly", c("ref.asr.x","ref.asr.y","ref.asr")]

#get rid of extra columns
names(db.pip)
db.pip <- db.pip[,-c(55,56,62,63,64,65)]

#-------------------------------------

#check numbers of amphibians with data:
db2 <- db.pip
str(db2[db2$Class %in% "AMPHIBIA",]) #6609 obs

db.amp <- db2[db2$Class %in% c("AMPHIBIA") & !is.na(db2$male_svl_cm) & !is.na(db2$female_svl_cm),]

str(db.amp)#661 obs

db.amp[!is.na(db.amp$ASR), "binomial"] #37
db.amp[db.amp$ref.asr %in% "pipoly", "binomial"] #13
db.amp[!db.amp$ref.asr %in% "pipoly" & !is.na(db.amp$ASR), "binomial"] #24

db.amp[!is.na(db.amp$mating_system), "binomial"] #51
db.amp[!is.na(db.amp$sex_dim), "binomial"] #47
db.amp[!is.na(db.amp$sex_dim) | !is.na(db.amp$mating_system), "binomial"] #58
db.amp[!is.na(db.amp$comments), "comments"] #58

db.amp[!is.na(db.amp$sex_dim) | !is.na(db.amp$mating_system), c("comments","binomial") ] #58

db2[c(40690, 40692, 35601, 23193),c("comments","binomial")]
db2$comments[40690] <- "No data available (CCI 05/11/2018)"
db2$comments[40692] <- "No data available (CCI 05/11/2018)"
db2$comments[23193] <- "No data available (CCI 31/10/2018)"
db2$comments[35601] <-  "No data available (CCI 05/11/2018)"

#---------------------------
#Save db.amp in excel file:--------
setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/output/")
write.csv(db.amp, "merged_iucn_and_db_v4_amphibians.csv")
