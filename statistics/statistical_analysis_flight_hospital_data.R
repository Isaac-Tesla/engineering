# 1. Tasks
#===================================================================================================================
# 1.1 Use table() on the Species variable of the Iris dataset to count the instances of each level.
data(iris) # load built-in dataset
table(iris$Species) 

#===================================================================================================================
# 1.2 Use the hist() assignment (e.g. A <- hist(data$variable)) to determine counts automatically assigned to the bins of a histogram for the Petal.Width variable.
counts_of_histogram_bins <- hist(iris$Petal.Width)
counts_of_histogram_bins

#===================================================================================================================
# 1.3 Read in the weather data in the nycflights using the following code, and then change the variable origin to have the 'factor' data type.
nyc_weather <- read.csv("https://raw.githubusercontent.com/hadley/nycflights13/master/data-raw/weather.csv")
head(nyc_weather) # look at the attributes
nyc_weather$origin <- factor(nyc_weather$origin) # assign class as factor
typeof(nyc_weather$origin) #check this hasn't affected type
class(nyc_weather$origin) #confirm class has changed to 'factor'

#===================================================================================================================
# 1.4 Use the following code to install the nycflights13 dataset and then either using table() or otherwise, calculate the number of different carriers for each airport.
install.packages('nycflights13') #warning built with earlier version 3.4.4
library(nycflights13)

# number of different carriers for each airport
Lst <- list()
for(i in levels(factor(flights$origin))){
  Lst[[i]] <- table(flights$carrier[flights$origin == i])
}
Lst # displays all of the carriers for each of the 3 airports

#===================================================================================================================
#1.5 Create two dataframes from the flights data by taking two random samples of 100 entries and then merge them together (by row).
sample1 <- data.frame() # declare as dataframe
sample1 <- flights[sample(nrow(flights), 100), ] # collect 100 random rows from flights
sample1
sample2 <- data.frame()
sample2 <- flights[sample(nrow(flights), 100), ] # collect 100 random rows from flights
sample2
# merge sample 1 and 2 together
merged.flights <- merge(sample1, sample2, by="year") # new table is 100 * 100 in size, merge by row on row.
merged.flights
nrow(merged.flights) # confirm size from merge (100 x 100 = 10,000 rows).

#===================================================================================================================
#1.6 Using the airports dataset (included in nycflights13), create a plot that visualises the position of each of the airports (latitude and longitude) and colour them by timezone.
#install.packages('ggplot2')
library(ggplot2)
qplot(airports$lat, airports$lon, data=airports, colour=airports$tzone)

#===================================================================================================================
#1.7 Create a suitable barchart using ggplot to look at the relationship between airline (carrier) and which of three airports (origin) is used.
ggplot(flights,aes(carrier,fill=origin)) + geom_bar()

#===================================================================================================================
#1.8 Compare the arrival and departure delays for the three airports using box and violin plots.
#box plots of arrival delays
ggplot(flights) +
  geom_boxplot(mapping = aes(x = origin, y = arr_delay))
#box plots of departure delays
ggplot(flights) +
  geom_boxplot(mapping = aes(x = origin, y = dep_delay))

#violin plots of arrival delays
ggplot(flights) +
  geom_violin(mapping = aes(x = origin, y = arr_delay))
# violin plots of departure delays
ggplot(flights) +
  geom_violin(mapping = aes(x = origin, y = dep_delay))

#===================================================================================================================
#1.9 Briefly analyse the correlation between the departure delay and the arrival delay.
ggplot(flights) +
  geom_point(mapping = aes(x = arr_delay, y = dep_delay), alpha = 1/10) # modified alpha levels to allow density to show in plot
# note that 9430 are missing a delay value and can be assumed to leave on time.


#===================================================================================================================
#===================================================================================================================
#2. Data Wrangling
#2.1 Obtain the emergency departments data and the corresponding weather taken from the Bureau of Meteorology Website over the same time period. You will need to download the weather data from the SIT741 unit site and store it to the R working directory.
hospitals_csv <- read.csv("http://bit.ly/2nkCUEh")
weather_csv <- read.csv("~/data/Perth_Rainfall_Temp.csv")

#===================================================================================================================
#2.2 Merge together the information for 3 hospitals from the hospitals table. Then merge together with information in the weather table. Some R functions that might be useful are given below
head(hospitals_csv)

# merge 3 hospitals
hospital1.data <- data.frame(hospitals_csv[-1,c(1:8)])
hospital2.data <- data.frame(hospitals_csv[-1,c(1,9:15)])
hospital3.data <- data.frame(hospitals_csv[-1,c(1,16:22)])

# confirm new data frame
head(hospital1.data)
head(hospital2.data)
head(hospital3.data)

# check types
sapply(hospital1.data, class)
sapply(hospital2.data, class)
sapply(hospital3.data, class)

# as everything is a factor, change to numeric
hospital1.data[,2:9] <- lapply(hospital1.data, function(x) as.numeric(as.character(x)))
hospital2.data[,2:9] <- lapply(hospital2.data, function(x) as.numeric(as.character(x)))
hospital3.data[,2:9] <- lapply(hospital3.data, function(x) as.numeric(as.character(x)))

# set NA column to hospital name
hospital1.data$Royal.Perth.Hospital <- "Royal Perth Hospital"
hospital2.data$Fremantle.Hospital <- "Fremantle Hospital"
hospital3.data$Princess.Margaret.Hospital.For.Children <- "Princess Margaret Hospital"

# updating the names of the columns
colnames(hospital1.data)[1:9] <- c("Date", "Hospital Name", "Attendance","Admissions", "Tri_1", "Tri_2", "Tri_3", "Tri_4", "Tri_5")
colnames(hospital2.data)[1:9] <- c("Date", "Hospital Name", "Attendance","Admissions", "Tri_1", "Tri_2", "Tri_3", "Tri_4", "Tri_5")
colnames(hospital3.data)[1:9] <- c("Date", "Hospital Name", "Attendance","Admissions", "Tri_1", "Tri_2", "Tri_3", "Tri_4", "Tri_5")

# update date column to date
hospital1.data$Date <- as.Date(hospital1.data$Date, "%d-%b-%Y")
hospital2.data$Date <- as.Date(hospital2.data$Date, "%d-%b-%Y")
hospital3.data$Date <- as.Date(hospital3.data$Date, "%d-%b-%Y")

# confirm updated information for 3 hospitals
head(hospital1.data)
head(hospital2.data)
head(hospital3.data)

#===================================================================================================================
#2.2b Merge hospital and weather tables
head(weather_csv)

# combine columns into Date
weather_csv$Date <- as.Date(with(weather_csv, paste(Day, Month, Year,sep="-")), "%d-%m-%Y")

# check type change
sapply(weather_csv, class)

# remove erroneas day, month year columns
weather_csv <- data.frame(weather_csv[,c(4:6)])

# merge datasets based on date
hospital1.weather <- merge(hospital1.data, weather_csv, by="Date")
hospital2.weather <- merge(hospital2.data, weather_csv, by="Date")
hospital3.weather <- merge(hospital3.data, weather_csv, by="Date")

# confirm merge
head(hospital1.weather)
head(hospital2.weather)
head(hospital3.weather)

# merge all hospitals into 1 data frame for EDA
hospital.weather <- rbind(hospital1.weather, hospital2.weather)
hospital.weather <- rbind(hospital.weather, hospital3.weather)

# check to see if all 3 hospital's data came across with the merge
library(plyr)
count(hospital.weather$`Hospital Name`)
table(hospital.weather$`Hospital Name`) #confirming count was correct

#===================================================================================================================
#===================================================================================================================
#3. EDA

#3(i) Chart to compare the three hospitals in terms of the distribution of ED attendances
library(ggplot2)

# box and whisker plot overview to compare hospital ED attendance distributions
ggplot(hospital.weather) + geom_boxplot(mapping = aes(x = hospital.weather$`Hospital Name`, y = hospital.weather$Attendance))

# violin plot for a clearer view of attendance for each hospital to compare hospital ED attendance distributions
ggplot(hospital.weather) +  geom_violin(mapping = aes(x = hospital.weather$`Hospital Name`, y = hospital.weather$Attendance))

#===================================================================================================================
#3(ii) qq-plot to check whether one of the variables is normally distributed
# Temperature - Attendance
qplot(hospital.weather$Temp, hospital.weather$Attendance, data=hospital.weather, colour=hospital.weather$`Hospital Name`) + geom_smooth()
# Looking at the conditional smoothed mean, Royal Perth Hospital and Fremantle Hospital have some approximations towards a Gaussian distribution, whilst Princess Margaret Hospital has Kurtosis

# Rain - Attendance
qplot(hospital.weather$Rainfall, hospital.weather$Attendance, data=hospital.weather, colour=hospital.weather$`Hospital Name`) + geom_smooth()
# all 3 hospitals have a reduction in attendance for rainfall of 0-20, from this point the mean increases but only achieves equivalent attendance rates compared to zero rainfall at 50mm for Princess Margaret Hospital, whilst the other two Hospitals' mean did not achieve parity with the zero-rain mean.


#===================================================================================================================
#3(iii) 2 plots showing whether there seems to be a correlation between weather and ED demands
# looking at combined information for Temp - Attenance correlation
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Temp, y = hospital.weather$Attendance), alpha = 3/10)

# Looking at combined information for Rainfall - Attendance correlation
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Rainfall, y = hospital.weather$Attendance), alpha = 3/10)

# separating the data out to see if there is a correlation between individual hospitals and weather
ggplot(hospital1.weather) + geom_point(mapping = aes(x = hospital1.weather$Temp, y = hospital1.weather$Attendance), alpha = 4/10)
ggplot(hospital2.weather) + geom_point(mapping = aes(x = hospital2.weather$Temp, y = hospital2.weather$Attendance), alpha = 4/10)
ggplot(hospital3.weather) + geom_point(mapping = aes(x = hospital3.weather$Temp, y = hospital3.weather$Attendance), alpha = 4/10)

ggplot(hospital1.weather) + geom_point(mapping = aes(x = hospital1.weather$Rainfall, y = hospital1.weather$Attendance), alpha = 3/10)
ggplot(hospital2.weather) + geom_point(mapping = aes(x = hospital2.weather$Rainfall, y = hospital2.weather$Attendance), alpha = 3/10)
ggplot(hospital3.weather) + geom_point(mapping = aes(x = hospital3.weather$Rainfall, y = hospital3.weather$Attendance), alpha = 3/10)

# Check overall distributions with a histogram and binned quantities
hist(hospital1.weather$Attendance) # Attendance approximates a normal distribution
hist(hospital1.weather$Rainfall) # Rainfall does not approximate a normal distribution, rainfall is the same for all 3 hospitals
hist(hospital1.weather$Temp) # Temp does appoximate a normal distribution, with Kurtosis to the left
hist(hospital2.weather$Attendance) # Attendance approximates a normal distribution
hist(hospital3.weather$Attendance) # Attendance approximates a normal distribution

# As there appears to be no correlation between weather and attendance, what about the Tri_ categories?
# looking at Tri_ categories with temp
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Temp, y = hospital.weather$Tri_1), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Temp, y = hospital.weather$Tri_2), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Temp, y = hospital.weather$Tri_3), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Temp, y = hospital.weather$Tri_4), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Temp, y = hospital.weather$Tri_5), alpha = 3/10)

# looking at Tri_ categories with rain
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Rainfall, y = hospital.weather$Tri_1), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Rainfall, y = hospital.weather$Tri_2), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Rainfall, y = hospital.weather$Tri_3), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Rainfall, y = hospital.weather$Tri_4), alpha = 3/10)
ggplot(hospital.weather) + geom_point(mapping = aes(x = hospital.weather$Rainfall, y = hospital.weather$Tri_5), alpha = 3/10)

# There appears to be something here with rates dropping off with rainfall, perhaps a relationship can be more clearly seen with a histogram on each hospital?
hist(hospital1.weather$Tri_1) # Attendance is skewed and appears to drop off, is there a relationship between this and weather at hospital1?
hist(hospital1.weather$Rainfall) # Rainfall appears to be heavily skewed
#drilling into the relationship a bit more for hospital 1...
ggplot(hospital1.weather) + geom_point(mapping = aes(x = hospital1.weather$Rainfall, y = hospital1.weather$Tri_1), alpha = 3/10)
# using a smoothed qplot doesn't help, but we can see the area under the curve is asymtotic to the right. As rainfall increases there is definitely a reduction in attendance.
qplot(hospital1.weather$Rainfall, hospital1.weather$Tri_1, data=hospital1.weather, colour=hospital1.weather$`Hospital Name`) + geom_smooth()

#1. State hypotheses
# H0 = Rainfall and Tri_1 are related
# HA = Rainfall and Tri_1 are NOT related

#2. Alpha level ?? = 0.05

#3. State decision rule --> chi-square test for independence = ??? (fobserved - fexpected)2 / fexpected

#4. Calculate
library(MASS)
hospital1.table <- table(hospital1.weather$Rainfall, hospital1.weather$Tri_1)
hospital1.table
chisq.test(hospital1.table)
# warning message and X-squared = NaN...most likely due to the large amount of categories.
# bin to 2 categories, "rain" and "not rain" and count attendance when raining or not
# add column to hospital.weather table where 1 = rain, 0 = not rain
hospital.weather$RAINED <- ifelse(hospital.weather$Rainfall == 0, hospital.weather$Rainfall,
                               ifelse(hospital.weather$Rainfall > 0, 1, 0))

# check the function worked...
head(hospital.weather)
typeof(hospital.weather$RAINED)
#change to numeric type
hospital.weather$RAINED <- lapply(hospital.weather$RAINED, function(x) as.numeric(as.character(x)))


# set NA values to zero as there was no measurement. Alternatively these 13 rows can be removed.
hospital.weather$RAINED[is.na(hospital.weather$RAINED)] <- 0

# try again
hospital1.table <- table(hospital.weather$Tri_1, hospital.weather$RAINED)
hospital1.table
chisq.test(hospital1.table)

#5. State results
# x-squared = 6.1807, df = 9, p= 0.7217
# we do not reject the null hypothesis

#6. Conclusion
# There is insufficient evidence that rainfall and Tri_1 are related [x-squared = 6.1807, df = 9, p= 0.7217]

#================================================================
# Looking at Tri_2
#1. State hypotheses
# H0 = Rainfall and Tri_2 are related
# HA = Rainfall and Tri_2 are NOT related

#2. Alpha level ?? = 0.05

#3. State decision rule --> chi-square test for independence = ??? (fobserved - fexpected)2 / fexpected

#4. Calculate
library(MASS)
# bin to 2 categories, "rain" and "not rain" and count attendance when raining or not
# add column to hospital.weather table where 1 = rain, 0 = not rain
hospital.weather$RAINED <- ifelse(hospital.weather$Rainfall == 0, hospital.weather$Rainfall,
                                  ifelse(hospital.weather$Rainfall > 0, 1, 0))

# check the function worked...
head(hospital.weather)
typeof(hospital.weather$RAINED)
#change to numeric type
hospital.weather$RAINED <- lapply(hospital.weather$RAINED, function(x) as.numeric(as.character(x)))


# set NA values to zero as there was no measurement. Alternatively these 13 rows can be removed.
hospital.weather$RAINED[is.na(hospital.weather$RAINED)] <- 0

# try again
hospital1.table <- table(hospital.weather$Tri_2, hospital.weather$RAINED)
hospital1.table
chisq.test(hospital1.table)

#5. State results
# x-squared = 68.315, df = 55, p= 0.1071
# we do not reject the null hypothesis

#6. Conclusion
# There is insufficient evidence that rainfall and Tri_2 are related [x-squared = 68.315, df = 55, p= 0.1071]

#================================================================
# Looking at Tri_3
#1. State hypotheses
# H0 = Rainfall and Tri_3 are related
# HA = Rainfall and Tri_3 are NOT related

#2. Alpha level ?? = 0.05

#3. State decision rule --> chi-square test for independence = ??? (fobserved - fexpected)2 / fexpected

#4. Calculate
library(MASS)
# bin to 2 categories, "rain" and "not rain" and count attendance when raining or not
# add column to hospital.weather table where 1 = rain, 0 = not rain
hospital.weather$RAINED <- ifelse(hospital.weather$Rainfall == 0, hospital.weather$Rainfall,
                                  ifelse(hospital.weather$Rainfall > 0, 1, 0))

# check the function worked...
head(hospital.weather)
typeof(hospital.weather$RAINED)
#change to numeric type
hospital.weather$RAINED <- lapply(hospital.weather$RAINED, function(x) as.numeric(as.character(x)))


# set NA values to zero as there was no measurement. Alternatively these 13 rows can be removed.
hospital.weather$RAINED[is.na(hospital.weather$RAINED)] <- 0

# try again
hospital1.table <- table(hospital.weather$Tri_3, hospital.weather$RAINED)
hospital1.table
chisq.test(hospital1.table)

#5. State results
# x-squared = 64.721, df = 84, p= 0.9414
# we do not reject the null hypothesis

#6. Conclusion
# There is insufficient evidence that rainfall and Tri_3 are related [x-squared = 64.721, df = 84, p= 0.9414]



#================================================================
# Looking at Tri_4
#1. State hypotheses
# H0 = Rainfall and Tri_4 are related
# HA = Rainfall and Tri_4 are NOT related

#2. Alpha level ?? = 0.05

#3. State decision rule --> chi-square test for independence = ??? (fobserved - fexpected)2 / fexpected

#4. Calculate
library(MASS)
# bin to 2 categories, "rain" and "not rain" and count attendance when raining or not
# add column to hospital.weather table where 1 = rain, 0 = not rain
hospital.weather$RAINED <- ifelse(hospital.weather$Rainfall == 0, hospital.weather$Rainfall,
                                  ifelse(hospital.weather$Rainfall > 0, 1, 0))

# check the function worked...
head(hospital.weather)
typeof(hospital.weather$RAINED)
#change to numeric type
hospital.weather$RAINED <- lapply(hospital.weather$RAINED, function(x) as.numeric(as.character(x)))


# set NA values to zero as there was no measurement. Alternatively these 13 rows can be removed.
hospital.weather$RAINED[is.na(hospital.weather$RAINED)] <- 0

# try again
hospital1.table <- table(hospital.weather$Tri_4, hospital.weather$RAINED)
hospital1.table
chisq.test(hospital1.table)

#5. State results
# x-squared = 166.78, df = 143, p= 0.08474
# we do not reject the null hypothesis

#6. Conclusion
# There is insufficient evidence that rainfall and Tri_4 are related [x-squared = 166.78, df = 143, p= 0.08474]


#================================================================
# Looking at Tri_5
#1. State hypotheses
# H0 = Rainfall and Tri_5 are related
# HA = Rainfall and Tri_5 are NOT related

#2. Alpha level ?? = 0.05

#3. State decision rule --> chi-square test for independence = ??? (fobserved - fexpected)2 / fexpected

#4. Calculate
library(MASS)
# bin to 2 categories, "rain" and "not rain" and count attendance when raining or not
# add column to hospital.weather table where 1 = rain, 0 = not rain
hospital.weather$RAINED <- ifelse(hospital.weather$Rainfall == 0, hospital.weather$Rainfall,
                                  ifelse(hospital.weather$Rainfall > 0, 1, 0))

# check the function worked...
head(hospital.weather)
typeof(hospital.weather$RAINED)
#change to numeric type
hospital.weather$RAINED <- lapply(hospital.weather$RAINED, function(x) as.numeric(as.character(x)))


# set NA values to zero as there was no measurement. Alternatively these 13 rows can be removed.
hospital.weather$RAINED[is.na(hospital.weather$RAINED)] <- 0

# try again
hospital1.table <- table(hospital.weather$Tri_5, hospital.weather$RAINED)
hospital1.table
chisq.test(hospital1.table)

#5. State results
# x-squared = 46.069, df = 32, p= 0.05128
# we do not reject the null hypothesis

#6. Conclusion
# There is insufficient evidence that rainfall and Tri_5 are related [x-squared = 46.069, df = 32, p= 0.05128].


#===================================================================================================================
#3 (iii) A brief summary of your Analysis of the data (for part 3) - this only needs to be about half a page, highlighting the main features of your plots and what it indicates about the data.

# Even separating out the data, there appears to be no correlation between weather (rain/temp) and attendance to any of the 3 chosen hospitals. Looking at the conditional smoothed mean for Temperature - Attendance, Royal Perth Hospital and Fremantle Hospital have some approximations towards a Gaussian distribution, whilst Princess Margaret Hospital has Kurtosis.
# All 3 hospitals have a reduction in attendance for rainfall of 0-20, from this point the mean increases but only achieves equivalent attendance rates compared to zero rainfall at 50mm for Princess Margaret Hospital, whilst the other two Hospital's mean did not achieve parity with the zero-rain mean.
# Whilst the approximations for a normal distribution appear for Temp and Attendance, this could simply be due to temperatures sitting around certain means for a specific season, and attendance rates keeping steady.Princess Margaret Hospital's increased attendance for lower temperatures in this period could easily be attributed to a longer set of days with cooler temperatures as the distribution of values is not statistically significant.

#===================================================================================================================
#===================================================================================================================