#Week 9 homework
#Sebastian Gonzales
#12/4/24

surveys = read.csv("data/portal_data_joined.csv")
library(tidyverse)

#Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.

head(surveys)
unique(surveys$taxa)

for(i in unique(surveys$taxa)){ #look at each taxa independently
  tax = surveys[surveys$taxa == i,] #setting 'i'
  longestnames = tax[nchar(tax$species) == max(nchar(tax$species)),] %>% select(species)
  print(paste0(i, "="))
  print(unique(longestnames$species)) #how we want output presented
}


#Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.

mloa = read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mycols = mloa %>% select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")
mycols %>% map(max, na.rm = T) #was using 'max' before as the name of my output but was messing up with the 'max'function, switch to 'mycols' in class


#Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”.

C_to_F <- function(x){
  x * 1.8 + 32
}

mloa$temp_F_2m = C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m = C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop = C_to_F(mloa$temp_C_towertop)
View(mloa)
