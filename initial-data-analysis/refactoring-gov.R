# Refactoring the gov.csv file from the Colombia data

gov <- read.csv('csv/gov.csv', header = TRUE)
gov <- gov[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(gov)[1:2] <- c('municipality_code', 'year')

# Convert year to an integer
gov$year <- as.integer(gov$year)

# What percentage of data is found in each column of the file?
col_fraction_missing <- 100 * apply(gov, 2, function(col) sum(is.na(col)) / nrow(gov))
plot(1:ncol(gov), col_fraction_missing, type = 'l', col = 'blue', 
     main = 'Gov - Missing Data', xlab = 'Col #', ylab = 'Percent Missing')
abline(h = 50, col = 'red')

#fraction_order <- order(col_fraction_missing)
#cbind(colnames(gov)[fraction_order], col_fraction_missing[fraction_order])

# Remove columns where > 50% of the data is NA
#cols.rm <- apply(gov, 2, function(col) sum(is.na(col)) / nrow(gov) >= .5)
#colnames(gov)[cols.rm]  # These cols are going to be removed
#colnames(gov)[!cols.rm] # These cols are going to be kept
#gov <- gov[ , !cols.rm]

