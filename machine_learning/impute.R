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
completeData_1 <- complete(imputed_Data, 1)
head(completeData_1, n=15)

# quick optimisation for th best dataset
head(weather_orig, n=15)
a=(abs(weather_orig[,-9]-completeData_3[,-9]))
# how much is the error value?
sum(a$Dew.l)/sum(weather_orig$Dew.l)
sum(a$Temp.h)/sum(weather_orig$Temp.h)