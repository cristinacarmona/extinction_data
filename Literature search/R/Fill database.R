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


