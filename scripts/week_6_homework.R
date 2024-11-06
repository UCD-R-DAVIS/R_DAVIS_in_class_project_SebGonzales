#Week 6 homework
#Sebastian Gonzales
#11/5/24

library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

# 1. First calculate mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

gapminder %>% #pulling from df 'gapminder'
  group_by(continent, year) %>% #grouping by unique variables in the 'continent' column for each year
  summarise(mean_life_exp = mean(lifeExp)) %>% #calculate value for mean life expectancy called 'mean_life_exp' from each continent
  ggplot(aes(x = year, y = mean_life_exp, group = continent)) +
    geom_line(aes(color = continent)) + #plot a line graph with a different colored line for each continent, data coming from mean life expectancy value calculated previously, showing change through time. 
  theme_bw()

# 2. Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#I think the scale_x_log10() line of code is converting the x axis of the plot to a log scale. This will make the plot more visually appealing and easier to digest by condensing the x - axis, adjsuting for significantly outlier values in per capita gdp.
#I think the geom_smooth line of code smooths the line of fit connecting the scatter points for gdpPercap/lifeExp. This allows it act more as a trend line, or line of best fit, than a direct line between each point. 

# Challenge! Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# 3. Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

ggplot(gapminder[gapminder$country%in%c('Brazil', 'China', 'El Salvador', 'Niger', 'United States'),], #selecting only 5 of the countries
       mapping = aes(x = country, y = lifeExp)) + #setting x and y axis data
  geom_boxplot(aes(color = country), show.legend = F) +#boxplot + details
  geom_point(alpha = 0.3) + #adding points to boxplot and jittering
  geom_jitter(alpha = 0.3) +
  ylab('Life Expectancy') +
  xlab('Country') + 
  ggtitle('Life Expectancy of Five Countries') + #labeling axis and title
  theme_bw()

