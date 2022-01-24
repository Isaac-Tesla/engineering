#install.packages("mice")
#install.packages("VIM")
#install.packages("SparseM")

library(VIM)
library(SparseM)
library(mice)

md.pattern(weather) #show rows with missing data and count them
mive_plot <- aggr(weather, col=c('navyblue', yellow),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(weather), cex.axis=.7,
                  gap=1, ylab=c("Missing data", "Pattern"))

# find 'm' different options for the value, 9 in the example below
imputed_Data <- mice(weather, m=9, maxit = 50, method = 'pmm', seed = 500)
summary(imputed_Data)

# check imputed variables
imputed_Data$imp$Events
imputed_Data$imp$Prec

# Get complete data
completeData_1 <- complete(imputed_Data, 1) # select the first of 9 items to use as the imputed value. A better method would be to use the median of the values.
head(completeData_1, n=15)

# quick optimisation for th best dataset
head(weather_orig, n=15)
a=(abs(weather_orig[,-9]-completeData_3[,-9]))
# how much is the error value?
sum(a$Dew.l)/sum(weather_orig$Dew.l)
sum(a$Temp.h)/sum(weather_orig$Temp.h)


#install.packages("Hmisc")
install.packages("survival")
install.packages("Formula")
library(survival)
library(Formula)
library(ggplot2)
library(Hmisc)

# impute with mean value
head(weather, n = 15)
weather$imputed_Dew_h <- with(weather, impute(Dew.h, mean))

# impute with random variable
weather$imputed_Temp.h <- with(weather, impute(Temp.h, 'random'))

install.packages("missForest")
library(missForest)

#impute missing values, using all parameters as default values
weather.imp <-missForest(weather)

# check imputed accuracy
weather.imp$ximp
head(weather.imp)
weather.imp$OOBerror

# comparing actual data accuracy
mixError(ximp, xmis, xtrue)
# ximp = imputed data matrix with variables in the columns and observations in the rows
# xmis = data matrix with missing values.
# xtrue = complete data matrix. Note there should not be any missing values.

view(weather.imp$ximp)
View(weather)
View(weather_orig)
weather.err <- mixError(weather.imp$ximp, weather, weather_orig)
weather.err