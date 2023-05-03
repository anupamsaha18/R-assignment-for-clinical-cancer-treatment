library(tidyverse)
library(dplyr)

# read the Datasets 
tab1 <- read.csv("D:/moleculer cannection/Patient_Diagnosis.csv")

tab2 <- read.csv("D:/moleculer cannection/Patient_Treatment.csv")


#Cleaning the Date column by putting up the corrct format #yyy-mm--dd
tab1$diagnosis_date <-mdy(tab1$diagnosis_date)
tab2$treatment_date <- mdy(tab2$treatment_date)





#the distribution of cancer types across their patients.- Q1
c<- tab1 %>%  group_by(diagnosis) %>% reframe(count =sum(duplicated(diagnosis)))
view(c)

#The clinic wants to know how long it takes for patients to start
#therapy after being diagnosed,. How long after being diagnosed do patients start treatment?-Q2

#Step 1 : create a dataframe with treatment_date or diagnosis_date(here treatment_date)
l <-tab1%>%select(1,2)
tab1$patient_id[duplicated(tab1$patient_id)]
diagnosis <-l[!duplicated(l$patient_id), ]

m <- tab2%>%select(1,2)
tab2$patient_id[duplicated(tab2$patient_id)]
treatment <- m[!duplicated(m$patient_id), ]

#Step 2 : Create another dateframe with other date column and merge it with previous and the final table
min_day <-  diagnosis%>% left_join(treatment,by = 'patient_id')%>%mutate(Day = treatment_date - diagnosis_date)
view(min_day)

#3.	Which treatment regimens [i.e., drug(s)] are typically prescribed for the initial treatment -Q3
x <- merge(tab1,tab2, by = 'patient_id')
#for breast cancer
e <- x%>%filter(diagnosis == 'Breast Cancer')%>% group_by(diagnosis,drug_code)%>% reframe(count = sum(duplicated(drug_code)))
view(e)

#for colon cancer
f <- x%>%filter(diagnosis == 'Colon Cancer')%>% group_by(diagnosis,drug_code)%>% reframe(count = sum(duplicated(drug_code)))
view(f)

