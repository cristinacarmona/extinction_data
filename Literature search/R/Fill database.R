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
# [1] "Eleutherodactylus coqui"   
# [2] "Fejervarya limnocharis"    
# [3] "Hyla annectans"            
# [4] "Hyla arborea"              
# [5] "Hyperolius marmoratus"     
# [6] "Limnodynastes peronii"     
# [7] "Lithobates catesbeianus"   
# [8] "Lithobates clamitans"      
# [9] "Lithobates pipiens"        
# [10] "Lithobates sylvaticus"     
# [11] "Mantella aurantiaca"       
# [12] "Mixophyes fasciolatus"     
# [13] "Mixophyes fleayi"          
# [14] "Nanorana parkeri"          
# [15] "Odorrana grahami"          
# [16] "Oophaga histrionica"       
# [17] "Oophaga lehmanni"          
# [18] "Oophaga pumilio"           
# [19] "Osteopilus septentrionalis"
# [20] "Pelobates fuscus" 

amp[41:60,"binomial"]
# [1] "Phyllobates terribilis"  
# [2] "Phyllomedusa burmeisteri"
# [3] "Pseudacris brachyphona"  
# [4] "Pseudacris crucifer"     
# [5] "Pseudacris regilla"      
# [6] "Pseudacris streckeri"    
# [7] "Pseudacris triseriata"   
# [8] "Rana boylii"             
# [9] "Rana chensinensis"       
# [10] "Rana luteiventris"       
# [11] "Rana omeimontis"         
# [12] "Rana temporaria"         
# [13] "Rhacophorus omeimontis"  
# [14] "Rhinella marina"         
# [15] "Scaphiopus couchii"      
# [16] "Spea bombifrons"         
# [17] "Spea intermontana"       
# [18] "Xenopus laevis"


