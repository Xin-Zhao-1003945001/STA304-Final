library(haven)
library(dplyr)

X2019_Canadian_Election_Study_Online_Survey_v1_0 <- read_dta("https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/DUS88V/RZFNOV")
survey_result <- X2019_Canadian_Election_Study_Online_Survey_v1_0
survey_result <- filter(survey_result, cps19_citizenship == 4,!is.na(cps19_votechoice), cps19_yob <82, cps19_votechoice!=9, cps19_votechoice!=4)
survey_result <- subset(survey_result, select = c(cps19_yob, cps19_province,cps19_gender, cps19_votechoice))
survey_result <- survey_result %>% rename(age = cps19_yob, province = cps19_province,  vote = cps19_votechoice, gender = cps19_gender)
survey_result <- survey_result  %>% mutate(gender = ifelse(gender == 1, "male", gender))
survey_result <- survey_result  %>% mutate(gender = ifelse(gender == 2, "female", gender))
survey_result <- survey_result  %>% mutate(gender = ifelse(gender == 1, "trans", gender))
survey_result <- survey_result  %>% mutate(province = ifelse(province == 14, "AB", province), province = ifelse(province == 15, "BC", province), province = ifelse(province == 16, "MAN&SAS", province),province = ifelse(province == 17, "NS&PEI&NB&NFL", province),province = ifelse(province == 18, "NS&PEI&NB&NFL", province),province = ifelse(province == 19, "OTHER", province),province = ifelse(province == 20, "NS&PEI&NB&NFL", province),province = ifelse(province == 21, "OTHER", province),province = ifelse(province == 22, "ON", province),province = ifelse(province == 23, "NS&PEI&NB&NFL", province), province = ifelse(province == 24, "QUEB", province),province = ifelse(province == 25, "MAN&SAS", province),province = ifelse(province == 26, "OTHER", province))
survey_result <- survey_result %>% mutate(age = ifelse(age %in% seq(1,50), "50+", age),age = ifelse(age %in% seq(51,75), "35-50", age),age = ifelse(age %in% seq(76,82), "18-35", age))

lib <- survey_result %>% mutate(vote = ifelse(vote != 1, 0, vote),vote = ifelse(vote == 1, 1, vote))
con <- survey_result %>% mutate(vote = ifelse(vote != 2, 0, vote),vote = ifelse(vote == 2, 1, vote))
NDP <- survey_result %>% mutate(vote = ifelse(vote != 3, 0, vote),vote = ifelse(vote == 3, 1, vote))

