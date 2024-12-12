#Save as final_[Gonzales]_[Sebastian]

#Sebastian Gonzales
#R_Davis Final
#12/11/24

library(tidyverse)

#Read in the file tyler_activity_laps_12-6.csv
dat = read_csv('https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv') #Reading in df and naming it 'dat'
head(dat)
summary(dat) 

#Filter out any non-running activities
dat1 = dat %>% 
  filter(sport=='running') #Filtering out non-running activities from 'dat', calling new df 'dat1'
unique(dat1$sport) #confirming we got the desired result

#Remove any lap with a pace above 10 minutes_per_mile. Remove any laps < 5 minute_per_mile pace and abnormally short records where the total elapsed time is one minute or less.
dat2 = dat1 %>% 
  filter(minutes_per_mile<10.0, minutes_per_mile>5.0 & total_elapsed_time_s>=60.0) 
#Filtering out undesired laps from 'dat1', calling new df 'dat2'
summary(dat2) #checking the outcome

#Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.
dat3 = dat2 %>%
  mutate(time_period = case_when(
    year!=2024 ~ '1_pre_inj',
    month>=1 & month<=6 ~ '2_rehab',
    T ~'3_present'))
#adding column called 'mutate' new df called 'dat3' which came from 'dat2', everything not from the year 2024 gets labeled 'pre_inj', everything in 2024 from Jan to June gets labeled 'rehab', everything else gets labeled 'present'.
unique(dat3$time_period) #check work and make sure no NA's

#Make a scatter plot that graphs SPM over speed by lap.
ggplot(dat3, aes(x = total_elapsed_time_s, y = steps_per_minute)) +
  geom_point() #basic scatterplot

#Make 5 aesthetic changes to the plot to improve the visual.
#Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth())
ggplot(dat3, aes(x = total_elapsed_time_s, y = steps_per_minute, color = time_period)) +
  geom_point(alpha = 0.4, show.legend = F) +
  facet_wrap(~time_period, scale = 'free_x') +
  geom_smooth(method= 'loess', col = 1, show.legend = F) + #swap 'loess' with 'lm' for straight line
  xlab('Time per Lap (seconds)') +
  ylab('Steps per Minute') +
  theme_bw()

#Does this relationship maintain or break down as Tyler gets tired? Focus just on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap numbers, assuming that all laps on a given day correspond to the same run (hint: check out the rank() function). Select only laps 1-3 (Tyler never runs more than three miles these days). Make a plot that shows SPM, speed, and lap number (pick a visualization that you think best shows these three variables).

dat4 = dat3 %>%
  filter(time_period == '3_present') %>% 
  mutate(date = as.Date(timestamp)) %>% 
  group_by(date) %>% 
  mutate(lap_number = rank(timestamp, ties.method = 'first')) %>% 
  filter(lap_number >= 1 & lap_number <= 3) 

ggplot(dat4, aes(x = total_elapsed_time_s, y = steps_per_minute)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~lap_number) +
  geom_smooth(method= 'lm', col = 1, show.legend = F) +
  theme_bw()
#Not the prettiest plot but I kindof got there I think?
