# reporting script

# IMPORT REPORT FILES
views <- read.csv("D:/AllViews.csv", header = T)
likes <- read.csv("D:/AllLikes.csv", header = T)
content <- read.csv("D:/AllContent.csv", header = T)
events <- read.csv("D:/AllEvents.csv", header = T)
learningPlans <- read.csv("D:/AllLearningPlans.csv", header = T)
logFile <- read.csv("D:/LogFile.csv", header = T)
users <- read.csv("D:/AllUsers.csv", header = T)


# STAFF logins per month
logFile$Staff_Ctee <- ifelse(grepl("@stand",logFile$Login),'Staff','Non-Staff') # ADD COLUMN
logFile$Date <- as.Date(logFile$Old.date, format = "%d/%m/%Y") # MAP TO DATE FORMAT

logFile$year <- format(as.Date(logFile$Old.date, format = "%d/%m/%Y"), '%Y')
logFile$month <- format(as.Date(logFile$Old.date, format = "%d/%m/%Y"), '%m')


library(plyr)
# LOOP TO COLLECT MONTHS AND YEARS
loginVector <- 0
for(i_years in 2017:2019) {
  for(j_months in 1:12){
    loginVector[j] <- length(unique(c(ifelse(logFile$Staff_Ctee == "Staff"& logFile$month == j_months & logFile$year == i_years & logFile$Description == 'Successfully logged in', logFile$Login, 0))))
  }
}

loginVector[1] <- length(unique(c(ifelse(logFile$Staff_Ctee == "Staff"& logFile$month == 1 & logFile$year == 2017 & logFile$Description == 'Successfully logged in', logFile$Login, 0))))

JanStaff <- length(unique(c(ifelse(logFile$Staff_Ctee == "Staff"& (logFile$Date >= as.Date('2018-01-01')) & (logFile$Date < as.Date('2018-02-01') & logFile$Description == 'Successfully logged in'), logFile$Login, 0)))) # COUNT STAFF PER MONTH
FebStaff <- length(unique(c(ifelse(logFile$Staff_Ctee == "Staff"& (logFile$Date >= as.Date('2018-02-01')) & (logFile$Date < as.Date('2018-03-01') & logFile$Description == 'Successfully logged in'), logFile$Login, 0)))) # COUNT STAFF PER MONTH
AllStaff <- length(unique(c(ifelse(logFile$Staff_Ctee == "Staff"& (logFile$Date >= as.Date('2018-02-15')) & (logFile$Date < as.Date('2018-02-16')), logFile$Login, 0)))) # COUNT STAFF PER MONTH

mydf <- structure(list(ID = c(110L, 111L, 121L, 131L, 141L), 
                       MONTH.YEAR = c("JAN. 2012", "JAN. 2012", 
                                      "FEB. 2012", "FEB. 2012", 
                                      "MAR. 2012"), 
                       VALUE = c(1000L, 2000L, 3000L, 4000L, 5000L)), 
                  .Names = c("ID", "MONTH.YEAR", "VALUE"), 
                  class = "data.frame", row.names = c(NA, -5L))

countLogFileStaff <- sum(logFile$Staff_Ctee == "Staff") # ALL LOGINS
plot(countLogFileStaff ~ logFile$Date, ylab="Content ID", xlab="Date") #PLOT CHART FOR STAFF


# Create a vector filled with random normal values
u1 <- rnorm(30)

# Initialize `usq`
usq <- 0

for(i in 1:10) {
  # i-th element of `u1` squared into `i`-th position of `usq`
  usq[i] <- u1[i]*u1[i]
  print(usq[i])
}

print(i)
plot(likes$Content.ID ~ likes$Date, ylab="Content ID", xlab="Date")

# Month names
monthArray <- c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')
yearArray <- c(2016, 2017, 2018)

# MERGE TABLES ON USER.ID
mergedLikes = merge(likes,users,by="User.ID")

# Sankey diagram for jan - feb completion numbers
library(networkD3)
nodes = data.frame("name" = 
                     c("Jan Ctee Logins", # Node 0
                       "Jan - LP Complete", # Node 1
                       "Jan - LP Partial", # Node 2
                       "Jan TOTAL", # Node 3
                       "Feb Ctee Logins", #Node 4
                       "Feb - LP Complete", # Node 5
                       "Feb - LP Partial", # Node 6
                       "Feb TOTAL"))# Node 7
links = as.data.frame(matrix(c(
  0, 4, 119, # num1 = node from, num2 = node to, num3 = node size
  1, 3, 4, 
  2, 6, 30,
  1, 5, 4,
  3, 4, 68,
  3, 5, 7,
  3, 6, 36,
  4, 7, (68 - 36 - 7),
  5, 7, 7,
  6, 7, 36),
  byrow = TRUE, ncol = 3))
names(links) = c("source", "target", "value")
sankeyNetwork(Links = links, Nodes = nodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "name",
              fontSize= 15, nodeWidth = 20)