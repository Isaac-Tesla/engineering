# 1. Time Series [6 marks]
# 1.1 [1 mark] Request a NOAA web services token (link is available in the Week 7 Prac) and follow the example from the prac to download weather from JFK airport (Station ID: USW00094789) over the same time period as the flights data.
install.packages('nycflights13') #warning built with earlier version 3.4.4
library(nycflights13)
head(flights)
# combine separate day, month, year columns into date
flights$Date <- as.Date(with(flights, paste(day, month, year,sep="-")), "%d-%m-%Y")
# check type, confirm date
sapply(flights, class)
# get max and min dates to map JFK airport data to
max(flights$Date)
min(flights$Date)
# open library
#install.packages("rnoaa")
library(rnoaa)
# grab data for JFK airport based on dates in above flights$Date column
# use my token
options(noaakey = "kiaoHEHWDFliEpudzcehoosZYVKnQggC")
# use JFK ID
id <- "GHCND:USW00094789"
# confirming data is there
ncdc_datatypes(stationid = id, datasetid='GHCND')
ncdc_datasets(stationid = id)
ncdc_datacats(stationid = id)
JFK.dataset <- ncdc_stations(stationid = id)$data
# drill into dataset
JFK.weather <- ncdc(datasetid='GHCND', stationid=id, startdate = '2013-01-01', enddate = '2013-12-31', limit = 1000)$data                   
# as this only catches the first 1000 rows of data and we need to compare year against year, check date of final row and collect next 1000 entries until whole year captured.
# what is the last row date for JFK weather?
max(JFK.weather$date) # 2013-03-29
# capture another 1000 entries
JFK.weather2 <- ncdc(datasetid='GHCND', stationid=id, startdate = '2013-03-29', enddate = '2013-12-31', limit = 1000)$data     
# stack datasets
JFK.weather <- rbind(JFK.weather, JFK.weather2)
# check date and grab next 1000, max(date) = 2013-06-26
JFK.weather2 <- ncdc(datasetid='GHCND', stationid=id, startdate = '2013-06-26', enddate = '2013-12-31', limit = 1000)$data  
# rbind again and check max again, max date now 2013-09-24
JFK.weather2 <- ncdc(datasetid='GHCND', stationid=id, startdate = '2013-09-24', enddate = '2013-12-31', limit = 1000)$data  
# rbind again and check max date, max(date) = 2013-12-22...almost there
JFK.weather2 <- ncdc(datasetid='GHCND', stationid=id, startdate = '2013-12-22', enddate = '2013-12-31', limit = 1000)$data
# check max date
max(JFK.weather$date) # confirmed all entries captured. Now clean out any doubles as there is expected to be overlap with the dates
JFK.weather <- unique(JFK.weather) # row count drop from 4111 to 4088.
#==============================================================================================================================================================================
# 1.2 [2 marks] Use ggplot() to plot a time series of the snowfall over the given time-period. [You may need to use the lubridate package to ensure ggplot handles the date information correctly]
library(ggplot2)
# create subset
JFK.SNOW <- subset(JFK.weather, JFK.weather$datatype=="SNOW")
# check it worked
head(JFK.SNOW)
# look at the overall values with a histogram
hist(JFK.SNOW$value)
# plot values against time
ggplot(aes(x = JFK.SNOW$date, y = JFK.SNOW$value), data = JFK.SNOW) + geom_point()
#==============================================================================================================================================================================
# 1.3 [1 mark] Restrict the flights dataset to flights departing from JFK airport, then use the aggregate() function to determine the average departure delay. [The following provides an example of how to use the aggregate function. Note that you will need to deal with the NA values in order to calculate the mean.] aggregate(flights[, "distance"], list(flights$sched_dep_date), mean)
# Create subset for JFK flights
JFK.flights <- subset(flights, flights$origin=="JFK")
# determine average departure delay
# fix NA values first by setting to zero
JFK.flights[is.na(JFK.flights)] <- 0
mean(JFK.flights$dep_delay) # determines the average departure delay.
# determine it with the "aggregate function"
flight.average <-aggregate(flights, by=list(flights$dep_delay,flights$origin=="JFK"),
                                   FUN=mean, na.rm=TRUE)
mean(flight.average$dep_delay)
#==============================================================================================================================================================================
# 1.4 [1 mark] Create a scatterplot of snowfall against the daily average departure-delay.
# merge SNOW data and flight data on date
JFK.SNOW$Date2 <- as.Date(JFK.SNOW$date, "%Y-%m-%d") #create reduced date column
head(JFK.SNOW) # check it worked
# merge the tables together
# check class
class(JFK.SNOW)
class(JFK.flights)
# add package for inner join if required
#install.packages("data.table")
library(data.table)
# change type from dataframe to data.table
setDT(JFK.SNOW)
setDT(JFK.flights)
# set the ON clause as keys of the tables:
setkey(JFK.SNOW, Date2)
setkey(JFK.flights, Date)
# perform the join, adding matched SNOW values for every flight entry.
flight.snow <- JFK.flights[JFK.SNOW, nomatch=0]
# plot the daily delays against snowfall
library(ggplot2)
ggplot(flight.snow, aes(x=flight.snow$dep_delay, y=flight.snow$value)) + geom_point() # shows all flight delays against snowfall
# Now Build flight table with average daily departure-delay
# install.packages("tidyverse")
library(tidyverse)
library(lubridate)
JFK.flights$Date <- as.POSIXlt(JFK.flights$Date)  
ave.daily.delay <- JFK.flights %>% group_by(Date) %>% summarize(ave_delay =mean(dep_delay))
# check the table
head(ave.daily.delay)
class(ave.daily.delay) #confirm it is a dataframe to work with
# set the ON clause as keys of the tables:
setkey(JFK.SNOW, Date2)
setkey(ave.daily.delay, Date)
setDT(ave.daily.delay)
# perform the join, adding matched SNOW values for every flight entry.
flight.snow <- ave.daily.delay[JFK.SNOW, nomatch=0]
head(flight.snow)
#plot scatter using ggplot2
ggplot(flight.snow, aes(x=flight.snow$ave_delay, y=flight.snow$value)) + geom_point() + geom_smooth()
# See what this looks like if all days where it hasn't snowed are dropped.
snow.only.days <- subset(flight.snow , value > 0)
count(snow.only.days) # a huge 16 days with snow for the whole year.
ggplot(snow.only.days, aes(x=snow.only.days$ave_delay, y=snow.only.days$value)) + geom_point() + geom_smooth()
#==============================================================================================================================================================================
# 1.5 [1 mark] Comment briefly on any features of the scatterplot.
# There appears to be some relationship between the amount of snow and the departure delay, although this relationship appears to be weak as departure delays also happen without snow indicating snow is not a direct cause of delays. Noting also 2 outliers where the average snow fall is significantly high (75-85) and the departure delay is less than 10 minutes.

#==============================================================================================================================================================================
#==============================================================================================================================================================================
# 2. Statistical Tests [9 marks]
#install.packages("datasets")
data("ChickWeight")
head(ChickWeight)
#==============================================================================================================================================================================
# 2.1 [1 mark] Summarise the dataset. What are the variables data has been collected on? How many chickens, diets, ages were there?
head(ChickWeight)
# how many diets?
levels(ChickWeight$Diet) # 4
# how many chicks?
max(ChickWeight$Chick) # 48
# What are all of the maximum ages?
# generate list of maximum ages
max.age <- list()
for(i in levels(factor(ChickWeight$Chick))){
  max.age[[i]] <- max(ChickWeight$Time[ChickWeight$Chick == i])
}
max.age
# count maximum ages
table(unlist(max.age)) # 45 of 48 chicks lived to 21 days
#==============================================================================================================================================================================
# 2.2 [3 marks] Is the difference in mean weight of chicks on diets 1 and 2 statistically significant? Perform the appropriate statistical tests (you may need to check the distribution of the data as well as considering the data type). You can restrict your comparison to chicks at a particular age.

# counting only those chicks which lasted the full 21 days of the experiment / create subset
chick.table <- ChickWeight[which(ChickWeight$Time == 21), ]
head(chick.table) # check subset worked
# subset for diet type
chick.table <- chick.table[which(chick.table$Diet == 1 | chick.table$Diet == 2), ]
# check distribution of data in each subset (diet)
temp <- chick.table[which(chick.table$Diet ==1), ]
hist(temp$weight)
# diet 1 mean = 177.75
mean(temp$weight)
# diet 1 standard deviation = 58.70207
sd(temp$weight)
# diet 2
temp <- chick.table[which(chick.table$Diet ==2), ]
hist(temp$weight)
# diet 2 mean = 214.7
mean(temp$weight)
# diet 1 standard deviation = 78.13813
sd(temp$weight)
# side-by-side box plot
library(ggplot2)
ggplot(chick.table) +
  geom_boxplot(mapping = aes(x = Diet, y = weight))
# how many of each diet in the subset?
table(chick.table$Diet) # diet 1 = 16, diet 2 = 10.

# comparing different chicks (between subjects), note that statistical power will be diminished due to the difference in size (16:10)
# Question requires to compare the means, we will first use a Shapiro test to check normality, then use a paired t-test if the results on the Shapiro test are favourable.

# create subset to work with
diet1 <- chick.table[which(chick.table$Diet ==1), ]
diet2 <- chick.table[which(chick.table$Diet ==2), ]

# check the normality of the datasets
shapiro.test(as.numeric(diet1$weight)) # W = 0.956, p-value = 0.5905
shapiro.test(as.numeric(diet2$weight)) # W = 0.977, p-value = 0.9488
hist(diet1$weight)
hist(diet2$weight)

# the Shapiro test does not indicate that the data comes from a population with a non-normal distribution
# Therefore we shall proceed with a t-test
diet1_2 <- chick.table[which(chick.table$Diet ==2 | chick.table$Diet ==1), ]
with(diet1_2, t.test(diet1_2$weight~diet1_2$Diet))
# t = -1.2857, df = 15.325, p-value = 0.2176
# RESULT: p-value > 0.05, we do not reject the null hypothesis.
# Conclusion: There is insufficient evidence to suggest the difference in the mean weights of diets 1 and 2 is statistically significant.


#==============================================================================================================================================================================
# 2.3 [1 mark] Without performing the test(s), explain how you could tell whether the chicks on each diet experienced growth (considered to be statistically significant) between days 20 and 21.

# A paired t-test where each set of chicks on each diet is compared on days 20 and 21 measuring weight. The weight difference would then be computed: the mean difference over the standard deviation over the square root of the sample size. The t-value would then be compared to the t-score to see if it is above the critical level, based on which the null hypothesis would be either rejected or accepted.


#==============================================================================================================================================================================
# 2.4 [2 marks] Conduct a one-way ANOVA analysis to determine whether the weights of the chicks differ significnatly across all the diets (not just diets 1 and 2) at the age of 21 days.

# box plot of diets to get a visual idea of the diet-to-weight distributions
ggplot(chick.table) +
  geom_boxplot(mapping = aes(x = Diet, y = weight))

# subset with dependent variable and levels
chick.anova <- chick.table[, c(1, 4)]
# Compute the analysis of variance
res.aov <- aov(weight ~ chick.anova$Diet, data = chick.anova)
# Summary of the analysis
summary(res.aov)

# conclusion, reject H0 [F-value = 4.655, P-value = 0.00686], there is a difference in the means.


#==============================================================================================================================================================================
# 2.5 [2 marks] Now conduct a two-way ANOVA analysis by incorporating the age of the chicks at different stages. Use the measurements at 10 days and 20 days (these will be the two levels of the `age' factor).

# create table for 2-way ANOVA
chick.2WayANOVA <- ChickWeight[which(ChickWeight$Time == 10 | ChickWeight$Time == 20), ]
# check it worked
summary(chick.2WayANOVA)

# change ages to factors, 10 days = young, 20 days = old
chick.2WayANOVA$Time <- as.character(chick.2WayANOVA$Time)
chick.2WayANOVA$Time[chick.2WayANOVA$Time == 10] <- "Young"
chick.2WayANOVA$Time[chick.2WayANOVA$Time == 20] <- "Old"
# check it worked
table(chick.2WayANOVA$Time) # 2 levels
head(chick.2WayANOVA)
library(ggplot2)
ggplot(chick.2WayANOVA) +
  geom_boxplot(mapping = aes(x = Time, y = weight))
summary(chick.2WayANOVA)
# Drop attribute "chick"
chick.2WayANOVA <- data.frame(chick.2WayANOVA[,c(1:2,4)])
# 2 categorical variables, Time and Diet.
C2wayANOVA <- aov(weight ~ Time + Diet, data=chick.2WayANOVA)
# check model
summary(C2wayANOVA)
# 2 categorical variables, Time and Diet + interaction effect
C2wayANOVA_2 <- aov(weight ~ Time + Diet + Time:Diet, data=chick.2WayANOVA)
summary(C2wayANOVA_2)

# Results: Time:Diet, close to the F-value and not significant enough, further analysis on the data is required to see if there is an interaction effect. Time is significant. Diet is significant. Based on the p-values in both instances of 2-way ANOVA Time is the most significant effect on weight.

#==============================================================================================================================================================================
#==============================================================================================================================================================================
# 3. Regression [5 marks]
# 3.1 [3 marks] Using the gapminder dataset, select a country other than Australia and follow the example given in the Week 9 practical to fit a linear model to Life Expectancy over time. Assess the model fit by looking at the variance, normality of error and quality metrics.

#install.packages("gapminder")
library(gapminder)
# look at list of countries
View(gapminder_unfiltered)
# filter dataframe  for chosen country Israel
israel <- filter(gapminder, country == "Israel") #code returns an error - 'country not found'
# subset dataframe 
israel <- gapminder_unfiltered[ which(gapminder_unfiltered$country =='Israel'), ]
# create linear model from subset.
israel_mod <- lm(pop ~ year, data = israel)
# plot the model
install.packages("mosaic")
library(mosaic)
plotModel(israel_mod, system = "g")
# assess the fit of the model
library(broom)
israel_mod_df <- augment(israel_mod)
# constant variance
israel_mod_df %>% 
  ggplot(aes(x = year, y = .resid)) + 
  geom_hline(yintercept = 0, colour = "steelblue") +
  geom_point()
# linearity
israel_mod_df %>% 
  ggplot(aes(x = .fitted, y = .resid)) + 
  geom_hline(yintercept = 0, colour = "steelblue") +
  geom_point() +
  geom_smooth(se = FALSE)
# normality of error
israel_mod_df %>% 
  ggplot(aes(sample = .std.resid)) +
  stat_qq() +
  geom_abline(colour = "steelblue")
# numeric summary of model fit
glance(israel_mod)


#==============================================================================================================================================================================
# 3.2 [2 marks] In the Week 9 practical an example of multiple linear regression on the gapminder dataset was given. Restrict the dataset to 3 continents and repeat the analysis (show the resulting graphs). Then set up a GAM by using a spline-based smoothed transformation (see s()) of the GDP per Capita variable and note how this changes (improves or doesn't improve) the model.

# 3.2 a.
# multiple regression
life_expectancy <- gapminder_unfiltered[ which(gapminder_unfiltered$continent =='Asia' | gapminder_unfiltered$continent == 'Europe' | gapminder_unfiltered$continent == 'Oceania'), ]
library(tidyverse) # for %>%
life_expectancy_2007 <- life_expectancy %>% filter(year == 2007)
# simple linear model
life_mod1 <- lm(lifeExp ~ gdpPercap, data = life_expectancy_2007)
plotModel(life_mod1)
# linear model with continent
life_mod2 <- update(life_mod1, . ~ . + continent)
plotModel(life_mod2)
# adding an interaction term
life_mod3 <- update(life_mod2, . ~ . + continent*gdpPercap)
plotModel(life_mod3)

# 3.2 b.
library(mgcv)
library(dplyr)
# using 'k' as degrees of freedom
life_gam <- gam(lifeExp~s(gdpPercap) ,data = life_expectancy)
plotModel(life_gam)