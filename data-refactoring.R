# Jeff's Colombia data

x <- read.csv('~/Github-Jeff/colombia/csv/general.csv', header = TRUE)
x <- x[ , -1]   # Remove the index column

# Working on the first seven columns
colnames(x)[1:7] <- c('dept_code',' province_code',' municipality_code',' dept',' province',' municipality','year')

# Change the ano to a date
library(lubridate)



