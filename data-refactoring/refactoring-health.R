# Refactoring the health.csv file from the Colombia data

health <- read.csv('csv/health and services.csv', header = TRUE)
health <- health[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(health)[1:2] <- c('municipality_code', 'year')

# Convert the ano column data to a year
library(lubridate)
health$year <- year(ymd(health$year))
table(health$year)

# What percentage of data is found in each column of the file?
col_fraction_missing <- 100 * apply(health, 2, function(col) sum(is.na(col)) / nrow(health))
plot(1:ncol(health), col_fraction_missing, type = 'l', col = 'blue', 
     main = 'Health - Missing Data', xlab = 'Col #', ylab = 'Percent Missing')
abline(h = 50, col = 'red')

#fraction_order <- order(col_fraction_missing)
#cbind(colnames(health)[fraction_order], col_fraction_missing[fraction_order])


# Remove columns where > 50% of the data is NA
#cols.rm <- apply(health, 2, function(col) sum(is.na(col)) / nrow(health) >= .5)
#colnames(health)[cols.rm]  # These cols are going to be removed
#colnames(health)[!cols.rm] # These cols are going to be kept
#health <- health[ , !cols.rm]

