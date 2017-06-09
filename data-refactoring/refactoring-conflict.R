# Refactoring the conflict.csv file from the Colombia data

conflict <- read.csv('csv/conflict.csv', header = TRUE)
conflict <- conflict[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(conflict)[1:2] <- c('municipality_code', 'year')

# Convert the ano column data to a year
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
conflict$year <- sapply(conflict$year, convert_timestamp)
table(conflict$year)

# What percentage of data is found in each column of the file?
col_fraction_missing <- 100 * apply(conflict, 2, function(col) sum(is.na(col)) / nrow(conflict))
plot(1:ncol(conflict), col_fraction_missing, type = 'l', col = 'blue', 
     main = 'Conflict - Missing Data', xlab = 'Col #', ylab = 'Percent Missing')
abline(h = 50, col = 'red')

#fraction_order <- order(col_fraction_missing)
#cbind(colnames(conflict)[fraction_order], col_fraction_missing[fraction_order])


# Remove columns where > 50% of the data is NA
#cols.rm <- apply(conflict, 2, function(col) sum(is.na(col)) / nrow(conflict) >= .5)
#colnames(conflict)[cols.rm]  # These cols are going to be removed
#colnames(conflict)[!cols.rm] # These cols are going to be kept
#conflict <- conflict[ , !cols.rm]

