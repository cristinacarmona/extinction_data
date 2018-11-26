#Análisis para reporte DGAPA renovación
#23 Nov 2018
#

############################################################
#Load new dataset: merged_iucn_pre-analysis_categories.csv-----------------------

setwd("C:/Users/cris.carmona/Documents/MEGAsync/Projects/Post-doc/Riesgo de extinción y selección sexual/extinction_data/Preliminary analysis/output")

csvfiles <- list.files(path = ".", pattern='*\\.csv$', all.files=TRUE)
csvfiles

import.list <- lapply(csvfiles, read.csv, header = T , na.strings=c("NA", "NA ","na","N","-","---"," ","",".","sin dato","SD","sd","Sin Dato", -999,"-999"))


#str(import.list)
ls()

working.list <- import.list[2]
names(working.list) <- c("db5")

attach(working.list)


#----------------------------------------------
#Transform asr
db4 <- db5

db4$ASR <- as.numeric(as.character(db4$ASR))
db4$ASR_arcsinSQRT <- 57.295 * asin(sqrt(db4$ASR))
57.295 * asin(sqrt(0.5))
asin(sqrt(0.5))
db4$ASR_arcsinSQRT2 <- asin(sqrt(db4$ASR))
summary(db4$ASR_arcsinSQRT)
summary(db4$ASR_arcsinSQRT2)

#Create new rl category: 1 in danger (3,4,5,6), 0 not in danger (1,2 & NA)
# # # EXTINCT (EX) ...6
# # # EXTINCT IN THE WILD (EW) ...6
# # # CRITICALLY ENDANGERED (CR) ...5
# # # ENDANGERED (EN) ...4
# # # VULNERABLE (VU) ...3
# # # NEAR THREATENED (NT) ...2
# # # LEAST CONCERN (LC) ...1
# # # DATA DEFICIENT (DD)....NA
# # # Lower risk /Conservation dependant (LR/cd)....2 "The category is part of the IUCN 1994 Categories & Criteria (version 2.3), which is no longer used in evaluation of taxa, but persists in the IUCN Red List for taxa evaluated prior to 2001, when version 3.1 was first used. Using the 2001 (v3.1) system these taxa are classed as near threatened, but those that have not been re-evaluated remain with the "Conservation Dependent" category. (wikipedia)"
# # # Lower risk /least concern (LR/lc)...1
# # # Lower risk /near threatened....2
db4$rl.status.binomial <- ifelse(db4$rl.status.ordinal %in% c(1,2)|is.na(db4$rl.status.ordinal), 0, 1)
db4[,c("rl.status.binomial","rl.status.ordinal")]


#-----------------------------------
#Create scores for sex_dim categories-----------


ind <- grep("Ornamentation", db4$sex_dim_simplified, perl=T)
str(db4[ind, c("binomial","sex_dim_simplified")]) #184 obs
####created new categories in protocol: Female with ornaments and Male with ornaments

db4[db4$sex_dim_simplified %in% "Sexes alike, Ornamentation",]

# 
categories<-as.data.frame(table(db4$sex_dim_simplified, useNA="always")) #161 categories
cat_sex_dim<-unique(categories$Var1) #15 categories



#Check categories that have only 1 obs-----

db4[db4$sex_dim_simplified %in% "Female more colorful, Ornamentation",]
#Podiceps auritus - female is not more colorful....updated info in sex_dim_simplified and added comments
str(db4$comments)
db4$comments <- as.character(db4$comments)
db4$comments[db4$binomial %in% "Podiceps auritus"] <- "Female is not more colorful, sexes look alike, updated info in sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Podiceps auritus"] <- "Sexes alike, Ornamentation"

db4$sex_dim_simplified <- factor(db4$sex_dim_simplified)

categories<-as.data.frame(table(db4$sex_dim_simplified, useNA="always")) #161 categories
cat_sex_dim<-unique(categories$Var1) #14 categories

db4[db4$sex_dim_simplified %in% "Male with weapons",]
db4$comments[db4$binomial %in% "Ammodorcas clarkei"] <- "Male with weapons, category was simplified to Ornaments (CCI 27/09/2018)"
#db4$sex_dim_simplified[db4$binomial %in% "Ammodorcas clarkei"] <- "Ornamentation"


db4[db4$sex_dim_simplified %in% "Sexes colored or patterned differently, Sexes shaped differently, Ornamentation",]
db4$comments[db4$binomial %in% "Callorhinus ursinus"] <- "Male does not have ornaments nor weapons, updated sex_dim_simplified (CCI 27/09/2018)"
db4$sex_dim_simplified[db4$binomial %in% "Callorhinus ursinus"] <- "Sexes colored or patterned differently, Sexes shaped differently"

#db4[db4$sex_dim_simplified %in% "Male more colorful, Sexes shaped diiferently",]
#db4$sex_dim_simplified[db4$sex_dim_simplified %in% "Male more colorful, Sexes shaped diiferently "] <- "Male more colorful, Sexes shaped differently"


categories<-as.data.frame(table(db4$sex_dim_simplified, useNA="always")) #161 categories
cat_sex_dim<-unique(categories$Var1) #14 categories



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
cat_sex_dim<-unique(categories$Var1) #12 categories


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

db.nona.asr<-db4[!is.na(db4$ASR) & !is.na(db4$mating_system.corrected),]

#Explorative plots-------------
par(mfrow=c(1,1))

boxplot(ASR_arcsinSQRT~rl.status.ordinal, data=db.nona.asr)
boxplot(ASR~rl.status.ordinal, data=db.nona.asr)
boxplot(ASR_arcsinSQRT~rl.status.binomial, data=db.nona.asr)

boxplot(colordimscr~rl.status.ordinal, data=db.nona.asr)
boxplot(colordimscr~rl.status.binomial, data=db.nona.asr)


boxplot(orndimscr~rl.status.ordinal, data=db.nona.asr)
boxplot(orndimscr~rl.status.binomial, data=db.nona.asr)

boxplot(sex.size.dim.2~rl.status.ordinal, data=db.nona.asr)
boxplot(sex.size.dim.2~rl.status.binomial, data=db.nona.asr)

#
#fit logit model------
xtabs(~rl.status.binomial + mating_system.corrected, data = db.nona.asr)

glm.1 <- glm(rl.status.binomial ~ ASR_arcsinSQRT2 + ASR_arcsinSQRT2:mating_system.corrected + ASR_arcsinSQRT2:sex.size.dim.2 + mating_system.corrected + sex.size.dim.2, data = db.nona.asr, family = binomial)
summary(glm.1)

# Check linearity assumption: 
#Predict the probability (p) of rl.status.binomial, If the scatter plot shows non-linearity, you need other methods to build the model such as including 2 or 3-power terms, fractional polynomials and spline function (Chapter @ref(polynomial-and-spline-regression)).
library(tidyverse)
library(tidyr)
library(dplyr)
library(magrittr)
library(broom)
probabilities <- predict(glm.1, type = "response")
str(probabilities)
predicted.classes <- ifelse(probabilities > 0.5, "pos", "neg")
head(predicted.classes)
predictors <- colnames(db.nona.asr[, c("ASR_arcsinSQRT2", "rl.status.binomial")])
logit <- log(probabilities/(1-probabilities))


mydata <- db.nona.asr[,c("ASR_arcsinSQRT2", "rl.status.binomial")]
str(mydata)
mydata$probabilities <- predict(glm.1, type = "response")
mydata$logit <- log(probabilities/(1-probabilities))
head(mydata)

par(mfrow=c(1,1))
plot(mydata$logit, mydata$ASR_arcsinSQRT2)
abline()

plot(glm.1, which = 4, id.n = 3)

#binomial plots-----
plot(rl.status.binomial ~ ASR_arcsinSQRT2, data = db.nona.asr)
glm.2 <- glm(rl.status.binomial ~ ASR_arcsinSQRT2, family = binomial, data =db.nona.asr)
xv <- seq(0.3, 1.3, 0.1)
yv <- predict(glm.2, list(ASR_arcsinSQRT2=xv), type="response")
lines(xv,yv)

plot(rl.status.binomial ~ sex.size.dim.2, data = db.nona.asr)
glm.2 <- glm(rl.status.binomial ~ sex.size.dim.2, family = binomial, data =db.nona.asr)
xv <- seq(-0.5, 1.5, 0.1)
yv <- predict(glm.2, list(sex.size.dim.2 = xv), type= "response")
lines(xv, yv)



library(popbio)
logi.hist.plot(db.nona.asr$ASR_arcsinSQRT2, db.nona.asr$rl.status.binomial, boxp=FALSE, type="hist", col="gray")


#asses model fit-----
plot(rl.status.binomial ~ ASR_arcsinSQRT2, type="n", data = db.nona.asr)
rug(jitter(db.nona.asr$ASR_arcsinSQRT2[db.nona.asr$rl.status.binomial==0])) 
rug(jitter(db.nona.asr$ASR_arcsinSQRT2[db.nona.asr$rl.status.binomial==1]),side=3) 
model<-glm(rl.status.binomial~ASR_arcsinSQRT2,binomial, data=db.nona.asr) 
xv<-0.4:1.3
yv<-predict(model,list(ASR_arcsinSQRT2=xv),type="response") 
lines(xv,yv)
cutr<-cut(db.nona.asr$ASR_arcsinSQRT2,5) 
tapply(db.nona.asr$rl.status.binomial,cutr,sum)
table(cutr) 
cutr
probs<-tapply(db.nona.asr$rl.status.binomial,cutr,sum)/table(cutr) 
probs
probs<-as.vector(probs) 
resmeans<-tapply(db.nona.asr$ASR_arcsinSQRT2,cutr,mean) 
resmeans<-as.vector(resmeans)
points(resmeans,probs,pch=16,cex=2)
se<-sqrt(probs*(1-probs)/table(cutr))
up<-probs+as.vector(se) 
down<-probs-as.vector(se) 
for (i in 1:5){ 
  lines(c(resmeans[i],resmeans[i]),c(up[i],down[i]))}


xv <- seq(0.3, 1.3, 0.1)
yv <- predict(glm.1, list(ASR_arcsinSQRT2=xv), type="response")
lines(xv,yv)


######################################
