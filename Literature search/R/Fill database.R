#########################################################
#Fill in data into database
#########################################################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)


library(openxlsx) #instalar primero
import.list <- lapply(xlsxfiles[2], read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


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
str(db.rep)#253 obs -> CCI

db.mam <- db[db$Class %in% c("MAMMALIA") & !is.na(db$male_body_mass_g) & !is.na(db$female_body_mass_g),]
str(db.mam)#1174 obs -> DIANA

db.amph <- db[db$Class %in% c("AMPHIBIA") & !is.na(db$male_svl_cm) & !is.na(db$female_svl_cm),]
str(db.amph)#661 obs -> MARIA PAULA
head(db.amph)

db.fish <- db[db$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI", "CHONDRICHTHYES","SARCOPTERYGII") & !is.na(db$male_svl_cm) & !is.na(db$female_svl_cm),]
str(db.fish)#96 obs -> OSCAR

db.birds <- db[db$Class %in% c("AVES") & !is.na(db$male_body_mass_g) & !is.na(db$female_body_mass_g),]
str(db.birds)#4544 obs -> Base de datos ALEX?


db.rep[1:5,"binomial"]
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
# [1] "Aspidites ramsayi"        No data available for ASR (CCI 04/07/2018)
# [2] "Aspidomorphus lineaticollis" found ASR (CCI 04/07/2018)
# [3] "Aspidomorphus muelleri"     found ASR (CCI 04/07/2018)
# [4] "Aspidomorphus schlegelii"   found ASR (CCI 04/07/2018)
# [5] "Atractus major" No data available (CCI 05/07/2018)

db.rep[31:35, "binomial"]
# [1] "Atractus resplendens"  No data available (CCI 05/07/2018)   
# [2] "Austrelaps labialis"    No data available (CCI 05/07/2018)  
# [3] "Basiliscus vittatus"   No data available (CCI 05/07/2018)
# [4] "Brachyurophis approximans" No data available (CCI 05/07/2018)
# [5] "Brachyurophis australis"   No data available (CCI 05/07/2018)

db.rep[36:40, "binomial"]
# [1] "Brachyurophis fasciolatus"  No data available (CCI 05/07/2018)
# [2] "Brachyurophis incinctus"    No data available (CCI 05/07/2018)
# [3] "Brachyurophis roperi"       No data available (CCI 05/07/2018)
# [4] "Brachyurophis semifasciatus" No data available (CCI 05/07/2018)
# [5] "Bradypodion caffer"  Added data for sex.dim (CCI 06/07/2018) 

db.rep[41:45, "binomial"]
# [1] "Bradypodion damaranum"    Added data for sex.dim (CCI 06/07/2018) 
# [2] "Bradypodion gutturale"    Added data for sex.dim (CCI 06/07/2018) 
# [3] "Bradypodion occidentale"   Added data for sex.dim (CCI 06/07/2018)
# [4] "Bradypodion pumilum"       Multiple patternity clutches so should be polygamous; ASR derived from study evaluating survival and immigrtaion, 37 fem and 60 males captured (CCI 06/07/2018)
# [5] "Bradypodion taeniabronchum"Added data for sex.dim (CCI 06/07/2018)

db.rep[46:50, "binomial"]
# [1] "Bradypodion transvaalense" Added data for sex.dim (CCI 06/07/2018)
# [2] "Bradypodion ventrale"     Added data for sex.dim (CCI 06/07/2018)
# [3] "Brookesia confidens"      No data available (CCI 06/07/2018)
# [4] "Brookesia desperata"      No data available (CCI 06/07/2018)
# [5] "Brookesia micra"   No data available (CCI 06/07/2018)

db.rep[51:60, "binomial"]
# [1] "Brookesia tristis"     No data available (CCI 09/07/2018)
# [2] "Caiman crocodilus"   No data available (CCI 09/07/2018)  
# [3] "Caiman yacare"       Added mating system (CCI 09/07/2018)  
# [4] "Calamaria gervaisi"    No data available (CCI 09/07/2018)
# [5] "Calamaria lumbricoidea" No data available (CCI 09/07/2018)
# [6] "Calamaria virgulata"   No data available (CCI 09/07/2018)
# [7] "Carphophis amoenus"    Added ASR (CCI 09/07/2018)
# [8] "Carphophis vermis"     No data available (CCI 09/07/2018)
# [9] "Cerberus australis"    No data available (CCI 09/07/2018)
# [10] "Cerberus rynchops"  No data available (CCI 09/07/2018)

db.rep[61:70, "binomial"]
# [1] "Chalcides bedriagai" No accurate asr available (CCI 10/07/2018)
# [2] "Chalcides striatus"  No data available (CCI 10/07/2018)    
# [3] "Chamaeleo dilepis"       Added data for sex.dim (CCI 10/07/2018)
# [4] "Chilomeniscus stramineus" No data available (CCI 10/07/2018)
# [5] "Chlamydosaurus kingii"  Added mating system, asr and sex.dim (CCI 10/07/2018) 
# [6] "Clonophis kirtlandii"    No data available (CCI 11/07/2018)
# [7] "Coluber constrictor"     No data available (CCI 11/07/2018)
# [8] "Coniophanes fissidens"   No data available (CCI 11/07/2018)
# [9] "Conopsis nasus"          No data available (CCI 11/07/2018)
#[10] "Coronella austriaca"  ASR for 18 years of surveys 0.41 (89 males and 127 females) Average of 18 years of surveys marks and recaptures of adults (CCI 31/07/2018)


db.rep[71:80, "binomial"]
# [1] "Crocodylus moreletii" Added ASR (CCI 11/07/2018)
# [2] "Crotalus atrox"      Added mating system, sex.dim and ASR (CCI 11/07/2018)
# [3] "Crotalus cerastes"   No data available (CCI 24/07/2018) 
# [4] "Crotalus durissus"  No data available (CCI 25/07/2018) 
# [5] "Crotalus enyo"       No data available (CCI 25/07/2018)
# [6] "Crotalus horridus"   Sex ratio dubious...unsure if I can use it: http://eherp.org/pdf/88639.pdf (CCI 25/07/2018)
# [7] "Crotalus lepidus"    Found info for colour dimorphism (CCI 25/07/2018)
# [8] "Crotalus molossus"   No data available (CCI 25/07/2018)
# [9] "Crotalus pricei"    Sex ratio available but it is unclear which are adults and which juveniles in: https://www.jstor.org/stable/pdf/23325733.pdf?casa_token=cxJdnwE8DuUAAAAA:89jou395feAO7TM4jMksYtIZ0bHwS1xr-NIGhogZhL2kuuaSNqMFW9z-9QZeyToCLXHYa7DibpsSpSlg7S8xgW7hmhAJUj7ZJhw44H6YoPN8ExpS-WcX0Q (CCI 27 jul 2018)
# [10] "Crotalus ruber"   No data available (CCI 31/07/2018)

db.rep[81:100, "binomial"]
# [1] "Crotalus scutulatus"   No data available (CCI 31/07/2018)  
# [2] "Crotalus tigris"         No data available (CCI 01/08/2018)
# [3] "Crotalus triseriatus"    No data available (CCI 01/08/2018)
# [4] "Crotalus viridis"        Adult male and female counts from a population of Crotalus viridis oreganus in Idaho, mark-recapture study: 195 adult males - 132 adult females (CCI 01/08/2018) 
# [5] "Cryptophis pallidiceps"  No data available (CCI 01/08/2018)
# [6] "Cyclocorus lineatus"     No data available (CCI 01/08/2018)
# [7] "Demansia calodera"       No data available (CCI 01/08/2018)
# [8] "Demansia olivacea"       No data available (CCI 01/08/2018)
# [9] "Demansia papuensis"      No data available (CCI 01/08/2018)
# [10] "Demansia psammophis"    No data available (CCI 01/08/2018) 
# [11] "Demansia rufescens"     No data available (CCI 01/08/2018) 
# [12] "Demansia torquata"       No data available (CCI 01/08/2018)
# [13] "Dendrelaphis calligastra" No data available (CCI 01/08/2018)
# [14] "Dendrelaphis punctulatus" No data available (CCI 01/08/2018)
# [15] "Denisonia maculata"      No data available (CCI 01/08/2018)
# [16] "Diadophis punctatus"     Found ASR but estimated it from figure: adult males 38, adult females 48 (Riedle 2014) (CCI 02/08/2018)
# [17] "Dipsas catesbyi"         No data available (CCI 02/08/2018)
# [18] "Drysdalia mastersii"     No data available (CCI 02/08/2018)
# [19] "Drysdalia rhodogaster"   No data available (CCI 02/08/2018)
# [20] "Echiopsis curta"          No data available (CCI 02/08/2018)

db.rep[101:120, "binomial"]
# [1] "Elaphe climacophora"     No data available (CCI 06/08/2018) 
# [2] "Elapognathus minor"       No data available (CCI 06/08/2018)
# [3] "Enhydrina schistosa"      Collection data available from a population in Malaysia: ASR = 0.56, 80 males and 62 females labeled as ADULTS explicitly (CCI 06/08/2018)
# [4] "Enhydris enhydris"        ASR based on collected individuals 351 males and 258 females (CCI 06/08/2018) 
# [5] "Farancia erytrogramma"    No data available (CCI 06/08/2018)
# [6] "Fordonia leucobalia"      ASR based on captured individuals 21 females and 14 males (CCI 06/08/2018)
# [7] "Geophis brachycephalus"   No data available (CCI 07/08/2018)
# [8] "Geophis nasalis"          No data available (CCI 07/08/2018)
# [9] "Gonatodes albogularis"     ASR based on captured and preserved individuals: adult males (69), and adult females (57) (CCI 07/08/2018)
# [10] "Gyalopion canum"          No data available (CCI 07/08/2018)
# [11] "Hemiaspis damelii"        No data available (CCI 07/08/2018)
# [12] "Hemidactylus turcicus"    ASR based on captured and preserved individuals: 75 adult males, 66 adult females (CCI 07/08/2018)
# [13] "Heterodon nasicus"        No reliable data found, found one reference but it is not clear whether individuals were marked or not and how [The sex ratio of the 75 H. nasicus captured on TSP was slightly male-biased, with males representing 52% of captures. Young-of-year snakes comprised 19 (52.7%) of the 36 female and 29 (74.4%) of the 39 male snakes http://thekeep.eiu.edu/cgi/viewcontent.cgi?article=1046&context=theses]
# [14] "Homalopsis buccata"       No data available (CCI 07/08/2018)
# [15] "Hoplocephalus bungaroides" Sexual dimorphism data added (CCI 07/08/2018)
# [16] "Hoplocephalus stephensii"  No data available (CCI 07/08/2018)
# [17] "Hydrophis elegans"        No reliable data available (CCI 07/08/2018)
# [18] "Hydrophis platurus"       No data available (CCI 07/08/2018)
# [19] "Iberolacerta aranica"     No data available (CCI 07/08/2018)
# [20] "Iberolacerta aurelioi"  Color dimorphism (CCI 07/08/2018)

db.rep[121:140, "binomial"]
# [1] "Iberolacerta bonnali"  No data available (CCI 08/08/2018)    
# [2] "Iberolacerta cyreni"   Mating system, all adult lizards seen were captured (43 males and 34 females in 2002 and 33 males and 30 females in 2003) (CCI 08/08/2018)
# [3] "Iberolacerta galani"      Color dimorphism (CCI 08/08/2018) 
# [4] "Iberolacerta horvathi"     No data available (CCI 08/08/2018)
# [5] "Iberolacerta martinezricai" Unreliable ASR as it is not clear whether individuals captured were marked or collected (http://www.podarcis.eu/AS/Bibliografie/BIB_7370.pdf) (CCI 08/08/2018)
# [6] "Iberolacerta monticola"    Color dimorphism (CCI 08/08/2018)
# [7] "Lacerta agilis"           Found mating system and sex.dim (CCI 08/08/2018) 
# [8] "Lacerta bilineata"         Sexes shaped differently (CCI 09/08/2018)
# [9] "Lacerta schreiberi"        Found mating system and sex.dim, but sex ratio was not given in desired format plus no info from how data was collected was given (CCI 09/08/2018)
# [10] "Lampropeltis calligaster"  No data available (CCI 09/08/2018)
# [11] "Lampropeltis getula"       No data available (CCI 09/08/2018)
# [12] "Lampropeltis zonata"       No data available (CCI 13/08/2018)
# [13] "Leptodeira frenata"        No data available (CCI 13/08/2018)
# [14] "Leptodeira maculata"       No data available (CCI 13/08/2018)
# [15] "Leptodeira nigrofasciata"  No data available (CCI 13/08/2018)
# [16] "Leptodeira septentrionalis" No data available (CCI 13/08/2018)
# [17] "Liasis fuscus"             Added mating system (CCI 13(08/2018))
# [18] "Liasis olivaceus"          No data available(CCI 13/08/2018)
# [19] "Masticophis flagellum"     No data available (CCI 13/08/2018)
# [20] "Masticophis lateralis"  No data available (CCI 13/08/2018)

db.rep[141:160, "binomial"]
# [1] "Micrurus fulvius"      No data available (CCI 13/08/2018) 
# [2] "Morelia amethistina"    ASR=0.77 derived from captures: 80 males and 24 females (CCI 13/08/2018)
# [3] "Morelia bredli"         No data available (CCI 13/08/2018)
# [4] "Morelia spilota"        Polygyny, data for morelia spilota spilota, 6 females 9 males (Slip & Shine 1988), (CCI 14/08/2018)  
# [5] "Morelia viridis"        captured adults: 56 males and 41 females (CCI 14/08/2018)
# [6] "Myron richardsonii"     No data available (CCI 14/08/2018)
# [7] "Natrix natrix"          Polygamous (multiple paternity in 27-91% of clutches), ASR based on captures of 58 females and 63 males
# [8] "Neelaps bimaculatus"    No data available (CCI 14/08/2018)
# [9] "Nerodia erythrogaster"  No data available (CCI 14/08/2018)
# [10] "Nerodia fasciata"       No reliable data available (CCI 14/08/2018)
# [11] "Nerodia sipedon"        Data already complete
# [12] "Nerodia taxispilota"    No reliable data available (CCI 14/08/2018)
# [13] "Notechis scutatus"      ASR derived from male and female adult captures: 214 males and 78 females, already in Pipoly
# [14] "Opheodrys aestivus"     Data already complete
# [15] "Oxyrhopus melanogenys"  No data available (CCI 15/08/2018)
# [16] "Paleosuchus palpebrosus" No data available (CCI 15/08/2018)
# [17] "Paleosuchus trigonatus" No data available (CCI 15/08/2018) 
# [18] "Parasuta flagellum"     No data availalbe (CCI 15/08/2018)
# [19] "Parasuta gouldii"       No data available (CCI 15/08/2018)
# [20] "Parasuta monachus"  No data available (CCI 15/08/2018)

db.rep[161:180, "binomial"]
# [1] "Parasuta nigriceps"       No data available (CCI 15/08/2018)
# [2] "Parasuta spectabilis"     No data available (CCI 15/08/2018)
# [3] "Phrynosoma douglasii"     No data available (CCI 15/08/2018)
# [4] "Phrynosoma hernandesi"    No data available (CCI 15/08/2018)
# [5] "Phyllorhynchus browni"    No data available (CCI 15/08/2018)
# [6] "Phyllorhynchus decurtatus" No data available (CCI 15/08/2018)
# [7] "Pituophis melanoleucus"   ASR estimated with 92 males and 45 females (CCI 15/08/2018)
# [8] "Podarcis bocagei"         sex.dim data added (CCI 15/08/2018)
# [9] "Podarcis carbonelli"      No data available (CCI 15/08/2018)
# [10] "Podarcis gaigeae"         No data available (CCI 16/08/2018)
# [11] "Podarcis hispanicus"      Added sex.dim (CCI 16/08/2018)
# [12] "Podarcis lilfordi"        ASR computed from captures of 113 males and 147 females (CCI 16/08/2018)
# [13] "Podarcis muralis"         Multiple paternity in at least 87% of clutches. This is a sexually dimorphic lizard, with adult males having, in the study population, orange throat and ventral coloration, which is usually whitish in juveniles and females. (CCI 16/08/2018) 
# [14] "Podarcis pityusensis"     Added sex.dim (CCI 17/08/2018)
# [15] "Podarcis siculus"         No data available (CCI 17/08/2018)
# [16] "Podarcis tiliguerta"      No data available (CCI 17/08/2018)
# [17] "Podarcis vaucheri"        No data available (CCI 17/08/2018)
# [18] "Psammodromus algirus"     Mating system and sex.dim added (CCI 17/08/2018)
# [19] "Psammodromus hispanicus"  Added sex.dim (CCI 17/08/2018)
# [20] "Pseudechis australis"     No data available (CCI 17/08/2018)

db.rep[181:200, "binomial"]
# [1] "Pseudechis butleri"      No data available (CCI 20/08/2018)
# [2] "Pseudechis papuanus"     No data available (CCI 20/08/2018)
# [3] "Pseudoferania polylepis" No data available (CCI 20/08/2018)
# [4] "Pseudoficimia frontalis" No data available (CCI 20/08/2018)
# [5] "Pseudonaja affinis"      No data available (CCI 20/08/2018)
# [6] "Pseudonaja modesta"      No data available (CCI 20/08/2018)
# [7] "Rankinia diemensis"      ASR 193 females and 123 males;based on average for: captures of 58 adults (20 females, 38 males) (Stuart-Smith et al. 2007) and N = 69 females, 22 males; N = 61 females, 58 males; N = 43 females, 5 males (Stuart-Smith et al., 2008)  (CCI 20/08/2018)
# [8] "Regina septemvittata"    ASR based on captures of 47 males and 17 females adults (CCI 20/08/2018)
# [9] "Rhadinaea flavilata"     No data available (CCI 20/08/2018)
# [10] "Rhinocheilus lecontei"   No data available (CCI 20/08/2018)
# [11] "Rhinoplocephalus bicolor" No data available (CCI 20/08/2018)
# [12] "Salvadora grahamiae"     No data available (CCI 20/08/2018)
# [13] "Salvadora lemniscata"    No data available (CCI 20/08/2018)
# [14] "Salvadora mexicana"      No data available (CCI 20/08/2018)
# [15] "Sauromalus hispidus"     Added mating system (CCI 21/08/2018)
# [16] "Simoselaps anomalus"     No data available (CCI 21/08/2018)
# [17] "Simoselaps bertholdi"    No reliable data available, How & Shine (1999) do not say whether individuals captured were marked. (CCI 22/08/2018) 
# [18] "Simoselaps littoralis"   No data available (CCI 22/08/2018) 
# [19] "Sistrurus catenatus"     Added mating system and ASR based on captures of 19 females, 20 males in one locality and 18 females and 20 males from a second locality (CCI 22/08/2018)
# [20] "Sonora semiannulata"      No data available (CCI 22/08/2018)

db.rep[201:220, "binomial"]
# [1] "Sphaerodactylus ariasae"     No data available (CCI 22/08/2018)
# [2] "Sphaerodactylus parthenopion"  No data available (CCI 22/08/2018)
# "Sphaerodactylus vincenti" Found svl and ASR for this spp. ASR based on captures of 48 males and 79 females (CCI 22/08/2018)
# [3] "Stellagama stellio"    No data available (CCI 22/08/2018)      
# [4] "Storeria dekayi"             ASR based on captures of adults 135 males and 138 females (CCI 23/08/2018)
# [5] "Storeria occipitomaculata"   
# [6] "Suta fasciata"               
# [7] "Suta punctata"               
# [8] "Suta suta"                   
# [9] "Tantilla coronata"           
# [10] "Tantilla gracilis"           
# [11] "Tantilla hobartsmithi"       
# [12] "Tantilla planiceps"          
# [13] "Tarentola mauritanica"       
# [14] "Teira dugesii"               
# [15] "Thamnophis butleri"          
# [16] "Thamnophis elegans"          
# [17] "Thamnophis hammondii"        
# [18] "Thamnophis ordinoides"       
# [19] "Thamnophis proximus"         
# [20] "Thamnophis sauritus"

db.rep[221:240, "binomial"]

db.rep[241:253, "binomial"]

