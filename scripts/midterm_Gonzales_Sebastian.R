#Sebastian Gonzales
#Midterm
#10/30/24

#Read in the file tyler_activity_laps_10-24.csv from the class github page. This file is at url https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.
dat = read.csv('https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv')
head(dat)
dim(dat)
summary(dat)

#Filter out any non-running activities.
library(tidyverse)
unique(dat$sport)
dat1 = filter(dat, sport == 'running')

#Next, Tyler often has to take walk breaks between laps right now because trying to change how you’ve run for 25 years is hard. You can assume that any lap with a pace above 10 minute-per-mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute-per-mile pace) and abnormally short records where the total elapsed time is one minute or less.  
dat2 = dat1 %>% 
  filter(!minutes_per_mile>10.0 & !minutes_per_mile<5.0 & !total_elapsed_time_s<=60)

#Create a new categorical variable, pace, that categorizes laps by pace: “fast” (< 6 minutes-per-mile), “medium” (6:00 to 8:00), and “slow” ( > 8:00). Create a second categorical variable, form that distinguishes between laps run in the year 2024 (“new”, as Tyler started his rehab in January 2024) and all prior years (“old”).
dat3 = dat2 %>% 
  mutate(pace = case_when(
    minutes_per_mile < 6.00 ~ 'fast', 
    minutes_per_mile >= 6.00 & minutes_per_mile <= 8.00 ~ 'medium',
    minutes_per_mile > 8.00 ~ 'slow'
    )) %>% 
  mutate(form = case_when(
    year == 2023 ~ 'new', 
    TRUE ~ 'old'))

#Identify the average steps per minute for laps by form and pace, and generate a table showing these values with old and new as separate rows and pace categories as columns. Make sure that slow speed is the second column, medium speed is the third column, and fast speed is the fourth column (hint: think about what the select() function does).  
dat3 %>% 
  group_by(form, pace) %>% 
  summarise(avg = mean(steps_per_minute)) %>% 
  pivot_wider(names_from = pace, values_from = avg) %>% 
  select(form, slow, medium, fast)

#Finally, Tyler thinks he’s been doing better since July after the doctors filmed him running again and provided new advice. Summarize the minimum, mean, median, and maximum steps per minute results for all laps (regardless of pace category) run between January - June 2024 and July - October 2024 for comparison.
dat4 = dat1 %>% 
  mutate(summary = case_when(
    month >= 1 & month <= 6 & year == 2024 ~ 'early',
    month >= 7 & month <= 10 & year == 2024 ~ 'late', 
    TRUE ~ NA)) %>% 
  group_by(summary) %>% 
  summarize(min = min(steps_per_minute),
            max = max(steps_per_minute),
            med = median(steps_per_minute),
            mean = mean(steps_per_minute))

#Took me about 90 mins but felt like I was able to work through everything (not the most efficiently but successfully?) Felt like I had initial baseline answers for all of the questions, just took me a bit to work out the kinks for each one. To my surprise, I've come to enjoy solving these puzzles. 