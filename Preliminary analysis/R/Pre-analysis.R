#############################
#Preliminary analysis 21/Sept/2018

#Gave ordinal number to IUCN status 21/sept/2018
#Corrected mating.system categories 21/sept/2018

#############################
###########################
#Load datasets

# setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/input")
# 
# xlsxfiles <- list.files(path = ".", pattern='*\\.xlsx$', all.files=TRUE)
# xlsxfiles
# 
# library(openxlsx)
# import.list <- lapply(xlsxfiles, read.xlsx, sheet=1, colNames = TRUE, na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))
# 
# 
# #str(import.list)
# ls()
# 
# working.list <- import.list
# names(working.list) <- c("db")
# 
# attach(working.list)
# ###########################################################
# names(db)
# 
# 
# ##########################################################
# #Siguiendo la clasificación de Fisher y Owens (2004) transformar
# #las categorías en un índice ordinal del 1-6:
# #(1= "sin amenaza", 2 = "casi amenazado", 3 = "vulnerable", 4="en peligro", 5 = "en peligro crítico", 6 = "extinta")
# 
# table(db$Red.List.status)
# # EXTINCT (EX) ...6
# # EXTINCT IN THE WILD (EW) ...6
# # CRITICALLY ENDANGERED (CR) ...5
# # ENDANGERED (EN) ...4
# # VULNERABLE (VU) ...3
# # NEAR THREATENED (NT) ...2
# # LEAST CONCERN (LC) ...1
# # DATA DEFICIENT (DD)....NA
# # Lower risk /Conservation dependant (LR/cd)....2 "The category is part of the IUCN 1994 Categories & Criteria (version 2.3), which is no longer used in evaluation of taxa, but persists in the IUCN Red List for taxa evaluated prior to 2001, when version 3.1 was first used. Using the 2001 (v3.1) system these taxa are classed as near threatened, but those that have not been re-evaluated remain with the "Conservation Dependent" category. (wikipedia)"
# # Lower risk /least concern (LR/lc)...1
# # Lower risk /near threatened....2
# 
# #   CR    DD    EN    EW    EX    LC  LR/cd LR/lc 
# #1710  6701  2966    18   362 27865     9    52 
# #LR/nt    NT    VU 
# #61  2650  3698 
# 
# head(db)
# 
# db$rl.status.ordinal <- NA
# db$rl.status.ordinal[db$Red.List.status %in% c("LC","LR/lc")] <- 1
# db$rl.status.ordinal[db$Red.List.status %in% c("NT","LR/nt","LR/cd")] <- 2
# db$rl.status.ordinal[db$Red.List.status %in% c("VU")] <- 3
# db$rl.status.ordinal[db$Red.List.status %in% c("EN")] <- 4
# db$rl.status.ordinal[db$Red.List.status %in% c("CR")] <- 5
# db$rl.status.ordinal[db$Red.List.status %in% c("EW")] <- 6
# db$rl.status.ordinal[db$Red.List.status %in% c("EX")] <- 6
# 
# table(db$rl.status.ordinal)
# # 1     2     3     4     5     6 
# # 27917  2720  3698  2966  1710   380 
# 
# hist(db$rl.status.ordinal)
# 
# #------Check mating.system-------------
# db2<-db
# table(db2$mating_system, useNA = "always")#<NA>  43752
# 
# unique(db2$mating_system)
# 
# db2$mating_system[db2$mating_system %in% "Unknown, NA"] <- NA
# db2$mating_system.corrected[db2$mating_system %in% c("Polygyny", "polygyny",
#                                                      "Polygynous, promiscuity",
#                                                      "Polygynous, Cooperative breeder ",
#                                                      "Polygynous, Cooperative breeder",
#                                                      "Polygynous, Cooperative breeder, non-monogamy",
#                                                      "Polygynous, Cooperative breeder, non-monogamy ",
#                                                      "Polygynous, Polygynandrous (promiscuous), non-monogamy", 
#                                                      "Polygynous, Polygynandrous (promiscuous), non-monogamy ", 
#                                                      "Polygynous, Polygynandrous (promiscuous)", 
#                                                      "Polygynous, polyandry", 
#                                                      "Polygynous, non-monogamy",
#                                                      "Polygynous, non-monogamy ",
#                                                      "Polygynous, polygyny",
#                                                      "Polygynous, NA", 
#                                                      "promiscuity",
#                                                      "polygynous",
#                                                      "Polygynous",
#                                                      "scramble",
#                                                      "Polygynandrous (promiscuous), promiscuity",
#                                                      "Polygynandrous (promiscuous), polygyny",
#                                                      "Polygynandrous (promiscuous), polyandry",
#                                                      "Polygynandrous (promiscuous), non-monogamy",
#                                                      "Polygynandrous (promiscuous), non-monogamy ",
#                                                      "Polygynandrous (promiscuous), NA",
#                                                      "Polygynandrous (promiscuous), Cooperative breeder",
#                                                      "Polygynandrous (promiscuous)",
#                                                      "Polygynandrous",
#                                                      "Polygamous, polyandry",
#                                                      "Polygamous, NA",
#                                                      "Polygamous*",
#                                                      "Polygamous",
#                                                      "Polygamy",
#                                                      "polyandry",
#                                                      "Polyandrous, polygyny",
#                                                      "Polyandrous, Polygynous, Polygynandrous (promiscuous), Cooperative breeder",
#                                                      "Polyandrous, Polygynous, Polygynandrous (promiscuous)",
#                                                      "Polyandrous, Polygynous, NA",
#                                                      "Polyandrous, Polygynous",
#                                                      "Polyandrous, Polygynandrous (promiscuous)",
#                                                      "Polygynous, Polygynandrous (promiscuous), Cooperative breeder",
#                                                      "Polyandrous, NA",
#                                                      "Polyandrous, Eusocial",
#                                                      "Polyandrous, Cooperative breeder",
#                                                      "Polyandrous",
#                                                      "polyandous",
#                                                      "non-monogamy",
#                                                      "non-monogamy ",
#                                                      "Sequential polyandry",
#                                                      "Simultaneous polyandry"
#                                                      )] <- "Polygamous"
# 
# db2$mating_system.corrected[db2$mating_system %in% c("Monoandry",
#                                                      "Monogamous, Cooperative breeder",
#                                                      "Monogamous, Cooperative breeder, monogamy",
#                                                      "Monogamous, Cooperative breeder, monogamy ",
#                                                      "Monogamous, Monogamous, monogamy",
#                                                      "Monogamous, monogamy",
#                                                      "Monogamous, monogamy ",
#                                                      "Monogamous, NA",
#                                                      "Monogamous, Unknown, NA",
#                                                      "monogamy",
#                                                      "monogamy ",
#                                                      "monogamy, monogamy",
#                                                      "Monogamous"
#                                                      )] <- "Monogamous"
# 
# db2$mating_system.corrected[db2$mating_system %in% c("Polygynous, monogamy",
#                                                      "Polygynandrous (promiscuous), monogamy",
#                                                      "Polygynandrous (promiscuous), Monoandry",
#                                                      "Monogamous, Polygynous, Polygynandrous (promiscuous)",
#                                                      "Monogamous, Polygynous, non-monogamy",
#                                                      "Monogamous, Polygynous, non-monogamy ",
#                                                      "Monogamous, Polygynous, monogamy",
#                                                      "Monogamous, Polygynous, monogamy ",
#                                                      "Monogamous, Polygynous, Cooperative breeder",
#                                                      "Monogamous, Polygynous",
#                                                      "Monogamous, Polygynandrous (promiscuous), NA",
#                                                      "Monogamous, Polygynandrous (promiscuous), monogamy",
#                                                      "Monogamous, Polygynandrous (promiscuous), monogamy ",
#                                                      "Monogamous, Polygynandrous (promiscuous), Cooperative breeder, monogamy",
#                                                      "Monogamous, Polygynandrous (promiscuous), Cooperative breeder, monogamy ",
#                                                      "Monogamous, Polygynandrous (promiscuous), Cooperative breeder",
#                                                      "Monogamous, Polygynandrous (promiscuous)",
#                                                      "Monogamous, Polyandrous, Polygynous, Polygynandrous (promiscuous), Cooperative breeder",
#                                                      "Monogamous, Polyandrous, Polygynous, Polygynandrous (promiscuous)",
#                                                      "Monogamous, Polyandrous, Polygynous, NA",
#                                                      "Monogamous, Polyandrous, Polygynous, monogamy",
#                                                      "Monogamous, Polyandrous, Polygynous, monogamy ",
#                                                      "Monogamous, Polyandrous, Polygynous",
#                                                      "Monogamous, Polyandrous, monogamy",
#                                                      "Monogamous, Polyandrous, monogamy ",
#                                                      "Monogamous, Polyandrous, Cooperative breeder, NA",
#                                                      "Monogamous, Polyandrous, Cooperative breeder",
#                                                      "Monogamous, Polyandrous",
#                                                      "Monogamous, Cooperative breeder, non-monogamy ",
#                                                      "Monogamous, Cooperative breeder, non-monogamy")] <- "Monogamous or Polygamous"
#   
#   
# table(db2$mating_system.corrected, useNA = "always") #NA 43755
# # Monogamous           Monogamous or Polygamous 
# # 1307                      102 
# # Polygamous          <NA> 
# # 928                    43755 
# 
# unique(db2[is.na(db2$mating_system.corrected) & !is.na(db2$mating_system),"mating_system"])
# 
# 
# #------------------------
# #Check sizes and estimate sexual size dimorphism
# head(db2) #fish: male_size_cm.fishbase, female_size_cm.fishbase;
#                 #male_TLinfinity.fishbase, female_TLinfinity.fishbase
#                 #male_svl_cm, female_svl_cm
#           #Mammals: male_body_mass_g, female_body_mass_g
#           #Reptiles: male_svl_cm, female_svl_cm
#           #Aves: male_body_mass_g, female_body_mass_g
#           #Amphibia: male_svl_cm, female_svl_cm
# 
# names(db2)
# table(db2$ref.sex.size.dim)
# hist(db2$sex.size.dim)
# 
# 
# db2$sex.size.dim.2 <- NA
# db2$sex.size.dim.2[db2$Class %in% "MAMMALIA"] <- log(db2$male_body_mass_g[db2$Class %in% "MAMMALIA"]/db2$female_body_mass_g[db2$Class %in% "MAMMALIA"])
# db2$sex.size.dim.2[db2$Class %in% c("REPTILIA", "AMPHIBIA")] <- log(db2$male_svl_cm[db2$Class %in% c("REPTILIA", "AMPHIBIA")]/db2$female_svl_cm[db2$Class %in% c("REPTILIA", "AMPHIBIA")])
# db2$sex.size.dim.2[db2$Class %in% "AVES"] <- log(db2$male_body_mass_g[db2$Class %in% "AVES"]/db2$female_body_mass_g[db2$Class %in% "AVES"])
# 
# db2$sex.size.dim.2[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
#                                     "CHONDRICHTHYES","SARCOPTERYGII")] <- 
#   ifelse(!is.na(db2$male_svl_cm[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
#                                     "CHONDRICHTHYES","SARCOPTERYGII")]) &
#            !is.na(db2$female_svl_cm[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
#                                       "CHONDRICHTHYES","SARCOPTERYGII")]),
#     log(db2$male_svl_cm[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI", "CHONDRICHTHYES","SARCOPTERYGII")]
#         /db2$female_svl_cm[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI", "CHONDRICHTHYES","SARCOPTERYGII")]),
#     ifelse(!is.na(db2$male_size_cm.fishbase[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
#                                                              "CHONDRICHTHYES","SARCOPTERYGII")]) 
#            & !is.na(db2$female_size_cm.fishbase[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI", 
#                                                                  "CHONDRICHTHYES","SARCOPTERYGII")]),
#           log(db2$male_size_cm.fishbase[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
#                                                          "CHONDRICHTHYES","SARCOPTERYGII")]/
#                 db2$female_size_cm.fishbase[db2$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI"," MYXINI",
#                                                              "CHONDRICHTHYES","SARCOPTERYGII")]), 
#           ifelse(!is.na(db2$male_TLinfinity.fishbase) & !is.na(db2$female_TLinfinity.fishbase),
#                  log(db2$male_TLinfinity.fishbase/db2$female_TLinfinity.fishbase), NA)))
# 
# 
# #--------debug------------
# hist(db2$sex.size.dim.2)
# ind<-which(db2$sex.size.dim.2 < -1)
# db2[ind,] 
# 
# #Podarcis siculus female_svl_cm is 1664.03....should be: 6.206
# db2$female_svl_cm[db2$binomial %in% "Podarcis siculus"] <- 6.206
#  
# #----------------------
# #Check sex.dim
# head(db2)
# length(db2$binomial)
# categories<-as.data.frame(table(db2$sex_dim, useNA="always")) #161 categories
# 
# db2$sex_dim[db2$sex_dim %in% "Male larger than female"] <- "Male larger"
# db2$sex_dim[db2$sex_dim %in% "Sesex alike"] <- "Sexes alike"
# db2$sex_dim[db2$sex_dim %in% "Sexes alike, male larger"] <- "Sexes alike, Male larger"
# db2$sex_dim[db2$sex_dim %in% "other, Morph-NA, Color-NA"] <- NA
# db2$sex_dim[db2$sex_dim %in% "Males more colorful"] <- "Male more colorful"
# 
# cat_sex_dim<-unique(categories$Var1) #155 categories
# 
# ind<-grep("-males ", cat_sex_dim, perl=T)
# ind2<-grep("(?<!fe)male", cat_sex_dim, perl=T)
# ind<-grep("alike", cat_sex_dim, perl=T)
# ind<-grep("Male larger", cat_sex_dim, perl=T)
# cat_sex_dim[ind]
# 
# #Get rid of categories about size Male larger and female larger
# db2$sex_dim_simplified <- db2$sex_dim
# db2$sex_dim_simplified <- gsub("Male larger, ", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified <- gsub(", Male larger", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified <- gsub("Male larger", NA, db2$sex_dim_simplified)
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #132 categories
# 
# 
# ind<-grep("Female", cat_sex_dim, perl=T)
# ind2<-grep("(?<!fe)male", cat_sex_dim, perl=T)
# ind<-grep("alike", cat_sex_dim, perl=T)
# ind<-grep("Male larger", cat_sex_dim, perl=T)
# cat_sex_dim[ind]
# 
# db2$sex_dim_simplified <- gsub("Female larger, ", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified <- gsub("Female larger", NA, db2$sex_dim_simplified)
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #109 categories
# 
# #Get rid of NA in categories
# db2$sex_dim_simplified <- gsub("^NA, ", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified <- gsub("Color-NA", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified <- gsub("Morph-NA, ", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified <- gsub("NA, ", "", db2$sex_dim_simplified)
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #109 categories
# 
# #Get rid of Morph-males alike females turn it into Sexes alike and
# #Sexes alike, Color-males alike females
# db2$sex_dim_simplified <- gsub("Morph-males alike females, ", "Sexes alike, ", db2$sex_dim_simplified)
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #108 categories
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Color-males alike females"] <- "Sexes alike"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Color-males alike females"] <- "Sexes alike"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, "] <- "Sexes alike"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes alike, "] <- "Sexes alike"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes alike, Color-males alike females"] <- "Sexes alike"
# 
# 
# #Get rid of Color-different colors in juveniles and adults and
# # Morph-different morphology in juveniles and adults
# db2$sex_dim_simplified <- gsub(", Color-different colors in juveniles and adults", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified <- gsub("Morph-different morphology in juveniles and adults, ", "", db2$sex_dim_simplified)
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Color-different colors in juveniles and adults"] <- NA
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-different morphology in juveniles and adults"] <- NA
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #99 categories
# 
# #Get rid of other
# ind<-grep("other", cat_sex_dim, perl=T)
# cat_sex_dim[ind]
# db2$sex_dim_simplified <- gsub("other, ", "", db2$sex_dim_simplified)
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #93 categories
# 
# #Turn Morph-always different morphology between mature adults to Sexes shaped differently
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes shaped differently, Morph-always different morphology between mature adults, "] <- "Sexes shaped differently"
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #92 categories
# 
# #Get rid of no special organs
# ind<-grep("no special organs", cat_sex_dim, perl=T)
# cat_sex_dim[ind]
# db2$sex_dim_simplified <- gsub("no special organs, ", "", db2$sex_dim_simplified)
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "no special organs"] <- NA
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #74 categories
# 
# #Get rid of Male more colorful, Color-always different colors between mature adults
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% ""] <- NA
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Male more colorful, Color-always different colors between mature adults"] <- "Male more colorful"
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #72 categories
# 
# categories[order(categories$Freq),]
# 
# #Convert Morph-always different morphology between mature adults, to
# #Sexes shaped differently
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults, "] <- "Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-different morphology during breeding season only, Color-males alike females"] <- "Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-different morphology in juveniles and adults"] <- NA
#   
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Color-always different colors between mature adults"] <- "Sexes colored or patterned differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Color-different colors during breeding season only"] <- "Sexes colored or patterned differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Color-different colors in mature adults only"] <- "Sexes colored or patterned differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes colored or patterned differently, Male more colorful, Sexes alike, Color-males alike females"] <- "Male more colorful"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes colored or patterned differently, Female more colorful"] <- "Female more colorful"
# 
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #67 categories
# 
# #check color categories
# ind<-grep("color", cat_sex_dim, perl=T)
# cat_sex_dim[ind]
# 
# #Get rid of sexes alike when there is another observation of different colors
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Male more colorful"] <- "Male more colorful"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Female more colorful"] <- "Female more colorful"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes colored or patterned differently, Male more colorful"] <- "Male more colorful"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes colored or patterned differently, Ornamentation"] <- "Sexes colored or patterned differently, Ornamentation"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes shaped differently, Ornamentation"] <- "Sexes shaped differently, Ornamentation"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes shaped differently"] <- "Sexes shaped differently"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes colored or patterned differently, Male more colorful"] <- "Male more colorful"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes colored or patterned differently, Male more colorful, Sexes alike"] <- "Male more colorful"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes colored or patterned differently, Male more colorful, Sexes shaped differently"] <- "Male more colorful, Sexes shaped differently"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes colored or patterned differently, Male more colorful, Sexes shaped differently, Ornamentation"] <- "Male more colorful, Sexes shaped differently, Ornamentation"
# 
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% c("Morph-always different morphology between mature adults, Color-always different colors between mature adults",                              
#                                                      "Morph-always different morphology between mature adults, Color-different colors during breeding season only",                                   
#                                                      "Morph-always different morphology between mature adults, Color-different colors in mature adults only" )] <- "Sexes colored or patterned differently, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes colored or patterned differently, Sexes shaped differently, Morph-always different morphology between mature adults, "] <- "Sexes colored or patterned differently, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes shaped differently, Sexes alike, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "different shape of head (f,m), Morph-different morphology during breeding season only, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "genital papilla with tassels (m), Morph-always different morphology between mature adults, Color-always different colors between mature adults"] <- "Sexes colored or patterned differently, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "genital papilla with tassels (m), Morph-different morphology during breeding season only, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently, Sexes shaped differently"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-different morphology during breeding season only, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently, Sexes shaped differently"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults"] <- "Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-different morphology during breeding season only, "] <- "Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults"] <- "Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes shaped differently, Morph-always different morphology between mature adults, Color-males alike females"] <- "Sexes shaped differently"
# 
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Color-always different colors between mature adults"] <- "Sexes colored or patterned differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Sexes colored or patterned differently"] <- "Sexes colored or patterned differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults, Color-males alike females"] <- "Sexes colored or patterned differently"
# 
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Color-different colors in mature adults only"] <- "Sexes colored or patterned differently"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Female more colorful, Ornamentation"] <- "Female more colorful, Ornamentation"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Male more colorful, Ornamentation"] <- "Male more colorful, Ornamentation"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Male more colorful, Sexes shaped differently, Color-always different colors between mature adults"] <- "Male more colorful, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes colored or patterned differently, Male more colorful, Ornamentation"] <- "Male more colorful, Ornamentation"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, show little or no sexual body-size dimorphism"] <- "Sexes alike"
# 
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #40 categories
# 
# 
# #Shapes and claspers or genital papilla
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "different shape of head (f,m), Morph-always different morphology between mature adults, Color-males alike females"] <- "Sexes shaped differently"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "genital papilla with tassels (m), "] <- "Ornamentation"
# #ind <- grep("genital", db2$sex_dim, perl=T)
# #db2[ind,]
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "genital papilla with tassels (m), Sexes alike, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently, Ornamentation"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "gonopodium (m), Morph-always different morphology between mature adults, "] <- "Sexes shaped differently, Ornamentation"
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently"
# 
# 
# 
# ind <- grep("claspers", db2$sex_dim_simplified, perl=T)
# ind <- grep("protruding genital papilla \\(m\\),", db2$sex_dim_simplified, perl=T)
# db2[ind, c("binomial", "sex_dim_simplified")]
# db2$sex_dim_simplified <- gsub("protruding genital papilla \\(m\\), ", "", db2$sex_dim_simplified, perl=T)
# db2$sex_dim_simplified <- gsub("protruding genital papilla \\(am\\), ", "", db2$sex_dim_simplified, perl=T)
# db2$sex_dim_simplified <- gsub("claspers \\(m\\), ", "", db2$sex_dim_simplified, perl=T)
# 
# 
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults, "] <- "Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults, Color-different colors during breeding season only"] <- "Sexes colored or patterned differently, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults, Color-different colors in mature adults only"] <- "Sexes colored or patterned differently, Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Morph-always different morphology between mature adults, Color-males alike females"] <- "Sexes shaped differently"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Sexes alike, Color-males alike females"] <- "Sexes alike"
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% ""] <- NA
# db2$sex_dim_simplified[db2$sex_dim_simplified %in% "Color-different colors during breeding season only"] <- "Sexes colored or patterned differently"
# 
# 
# categories<-as.data.frame(table(db2$sex_dim_simplified, useNA="always")) #161 categories
# cat_sex_dim<-unique(categories$Var1) #16 categories
# 
# #-----------------------------------------------
# setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/output")
# write.csv(db2, "merged_iucn_pre-analysis_categories.csv")

#---------------------------------------------
############################################################
############################################################
#Load new dataset: merged_iucn_pre-analysis_categories.csv-----------------------

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/output")

csvfiles <- list.files(path = ".", pattern='*\\.csv$', all.files=TRUE)
csvfiles

import.list <- lapply(csvfiles, read.csv, header = T , na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list
names(working.list) <- c("db3")

attach(working.list)


#----------------------------------------------

#Create scores for sex_dim categories
db4<-db3

ind <- grep("Ornamentation", db4$sex_dim_simplified, perl=T)
str(db4[ind, c("binomial","sex_dim_simplified")]) #181 obs
####created new categories in protocol: Female with ornaments and Male with ornaments

db4[db4$sex_dim_simplified %in% "Sexes alike, Ornamentation",]

# 
categories<-as.data.frame(table(db4$sex_dim_simplified, useNA="always")) #161 categories
cat_sex_dim<-unique(categories$Var1) #16 categories



#Check categories that have only 1 obs-----

db4[db4$sex_dim_simplified %in% "Female more colorful, Ornamentation",]
#Podiceps auritus - female is not more colorful....updated info in sex_dim_simplified and added comments
str(db4$comments)
db4$comments <- as.character(db4$comments)
db4$comments[db4$binomial %in% "Podiceps auritus"] <- "Female is not more colorful, sexes look alike, updated info in sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Podiceps auritus"] <- "Sexes alike, Ornamentation"

db4$sex_dim_simplified <- factor(db4$sex_dim_simplified)

categories<-as.data.frame(table(db4$sex_dim_simplified, useNA="always")) #161 categories
cat_sex_dim<-unique(categories$Var1) #15 categories

db4[db4$sex_dim_simplified %in% "Male with weapons",]
db4$comments[db4$binomial %in% "Ammodorcas clarkei"] <- "Male with weapons, category was simplified to Ornaments (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Ammodorcas clarkei"] <- "Ornamentation"


db4[db4$sex_dim_simplified %in% "Sexes colored or patterned differently, Sexes shaped differently, Ornamentation",]
db4$comments[db4$binomial %in% "Callorhinus ursinus"] <- "Male does not have ornaments nor weapons, updated sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Callorhinus ursinus"] <- "Sexes colored or patterned differently, Sexes shaped differently"

categories<-as.data.frame(table(db4$sex_dim_simplified, useNA="always")) #161 categories
cat_sex_dim<-unique(categories$Var1) #13 categories



#Check categories with few observations------------------

db4[db4$sex_dim_simplified %in% "Male more colorful, Sexes shaped differently, Ornamentation",]
# Archilochus colubris - Male more colorful, adult male has a gorget (throat patch) of iridescent ruby red bordered narrowly with velvety black on the upper margin and a forked black tail with a faint violet sheen.   
# Bycanistes subcylindricus - Males and females have horns although males' is larger and more colorful
# Centrocercus minimus - Males have air sacks and large tail feathers and more colorful than females
# Epomophorus gambianus - Males have pouches on their shoulders that contain large patches of white fur. During courtship, males flash these showly white patches to attract mates. Air sacs are also present on the necks of males.
  
db4$comments[db4$binomial %in% "Archilochus colubris"] <- "Male has ornaments and is more colorful but shapes are not different, updated sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Archilochus colubris"] <- "Male more colorful, Ornamentation"

db4$comments[db4$binomial %in% "Bycanistes subcylindricus"] <- "Male and female have ornaments males' is more colofrul and a bit larger, updated sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Bycanistes subcylindricus"] <- "Male more colorful, Ornamentation"

db4$comments[db4$binomial %in% "Centrocercus minimus"] <- "Male has ornaments and is more colofrul, updated sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Centrocercus minimus"] <- "Male more colorful, Ornamentation"

db4$comments[db4$binomial %in% "Epomophorus gambianus"] <- "Male has ornaments, updated sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Epomophorus gambianus"] <- "Ornamentation"


categories<-as.data.frame(table(db4$sex_dim_simplified, useNA="always")) #161 categories
cat_sex_dim<-unique(categories$Var1) #13 categories


#SCORES for sex_dim------------------
db4$colordimscr <- NA
db4$colordimscr[db4$sex_dim_simplified %in% "Male more colorful"] <- 1
db4$colordimscr[db4$sex_dim_simplified %in% "Female more colorful"] <- -1
db4$colordimscr[db4$sex_dim_simplified %in% "Sexes alike"] <- 0

db4$orndimscr <- NA
db4$orndimscr[db4$sex_dim_simplified %in% "Sexes alike"] <- 0
db4$orndimscr[db4$sex_dim_simplified %in% "Sexes shaped differently"] <- 1
db4$orndimscr[db4$sex_dim_simplified %in% c("Sexes colored or patterned differently", "Female more colorful","Male more colorful")] <- 2
db4$orndimscr[db4$sex_dim_simplified %in% c("Sexes colored or patterned differently, Sexes shaped differently", "Male more colorful, Sexes shaped differently")] <- 3
db4$orndimscr[db4$sex_dim_simplified %in% "Sexes alike, Ornamentation"] <- 4
db4$orndimscr[db4$sex_dim_simplified %in% "Ornamentation"] <- 5
db4$orndimscr[db4$sex_dim_simplified %in% "Sexes shaped differently, Ornamentation"] <- 6
db4$orndimscr[db4$sex_dim_simplified %in% "Sexes colored or patterned differently, Ornamentation"] <- 7

#-------------------------------------
#Count species with data for sex_dimorphism
str(which(!is.na(db4$sex_dim_simplified[db4$Class %in% c("ACTINOPTERYGII","CEPHALASPIDOMORPHI","MYXINI",
                                                         "CHONDRICHTHYES","SARCOPTERYGII")])))

#-----------------------------------------
#
hist(db4$colordimscr)
hist(db4$orndimscr)
hist(db4$rl.status.ordinal)


load("~/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/input/.RData")
