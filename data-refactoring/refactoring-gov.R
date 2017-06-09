# Refactoring the gov.csv file from the Colombia data

gov <- read.csv('csv/gov.csv', header = TRUE)
gov <- gov[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(gov)[1:2] <- c('municipality_code', 'year')

# Convert year to an integer
gov$year <- as.integer(gov$year)

## Write the refactored data to the refactored-data directory
write.csv(gov, file = 'refactored-data/gov.csv', row.names = FALSE)
x <- read.csv('refactored-data/gov.csv', header = T)

# Compare the values in the old and new files
x <- read.csv('refactored-data/gov.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(gov[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
