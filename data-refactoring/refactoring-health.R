# Refactoring the health.csv file from the Colombia data

health <- read.csv('csv/health and services.csv', header = TRUE)
health <- health[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(health)[1:2] <- c('municipality_code', 'year')

# Convert the ano column data to a year
library(lubridate)
health$year <- year(ymd(health$year))
table(health$year)

## Write the refactored data to the refactored-data directory
write.csv(health, file = 'refactored-data/health.csv', row.names = FALSE)
x <- read.csv('refactored-data/health.csv', header = T)

# Compare the values in the old and new files
x <- read.csv('refactored-data/health.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(health[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
