library(readxl)
library(broom)
census <- read_excel("census.xlsx")

census_lib <- census
lib_mrp <- lm(vote ~ age + province + gender,data = lib)
census_lib$estimate <- lib_mrp %>% predict(newdata = census_lib)
census_lib %>% mutate(voteTotal = estimate*number) %>% group_by(gender) %>% summarise(vt = sum(voteTotal))

census_con <- census
con_mrp <- lm(vote ~ age + province + gender,data = con)
census_con$estimate <- con_mrp %>% predict(newdata = census_con)
census_con %>% mutate(voteTotal = estimate*number) %>% group_by(gender) %>% summarise(vt = sum(voteTotal))

census_NDP <- census
NDP_mrp <- lm(vote ~ age + province + gender,data = NDP)
census_NDP$estimate <- NDP_mrp %>% predict(newdata = census_NDP)
census_NDP %>% mutate(voteTotal = estimate*number) %>% group_by(gender) %>% summarise(vt = sum(voteTotal))

