#########################################################
#Fill in data into database
#########################################################
#Load datasets

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Literature search/input")

xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
xlsxfiles[2]

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
# [16] "Diadophis punctatus"     
# [17] "Dipsas catesbyi"         
# [18] "Drysdalia mastersii"     
# [19] "Drysdalia rhodogaster"   
# [20] "Echiopsis curta"   