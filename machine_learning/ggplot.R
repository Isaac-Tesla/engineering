library(tibble)
library(tidyr)

name <- c("mike", "renee", "matt", "chris","ricky")
birthyear <- c(2000, 2001, 2002, 2003, 2004)
eyecolour <- c("blue", "green", "hazel", "brown", "orange")
people <- tibble(name, birthyear, eyecolour)

tibble(name, birthyear, eyecolour)

print(people)



library(ggplot2)

ggplot(data = pf, aes(x = dob_day)) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = 1:31) +
  facet_wrap(~dob_month)



qplot(x = friend_count, data = pf)

ggplot(aes(x = friend_count), data = pf) +
  geom_histogram()