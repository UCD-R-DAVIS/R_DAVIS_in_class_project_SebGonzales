#Week 3 homework
#Sebastian Gonzales
#10/16/24

surveys = read.csv("data/portal_data_joined.csv")
surveys_base = surveys[c("species_id", "weight", "plot_type")]
surveys_base = head(surveys_base, n=5000)
surveys_base$plot_type = factor(surveys_base$plot_type)
surveys_base$plot_type = factor(surveys_base$plot_type)
surveys_base = surveys_base[!is.na(surveys_base$"weight"),]
surveys_base$weight = as.numeric(surveys_base$weight)
library(dplyr)
challenge_base = filter(surveys_base, weight>150) #I may have cheated using this function but I had experience using it before with my own data.

