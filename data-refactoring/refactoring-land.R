# Refactoring the land.csv file from the Colombia data

land <- read.csv('csv/land.csv', header = TRUE)
land <- land[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(land)[1:2] <- c('municipality_code', 'year')

# Convert the ano column data to a year
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
land$year <- sapply(land$year, convert_timestamp)
table(land$year)

# What percentage of data is found in each column of the file?
col_fraction_missing <- 100 * apply(land, 2, function(col) sum(is.na(col)) / nrow(land))
plot(1:ncol(land), col_fraction_missing, type = 'l', col = 'blue', 
     main = 'Land - Missing Data', xlab = 'Col #', ylab = 'Percent Missing')
abline(h = 50, col = 'red')

#fraction_order <- order(col_fraction_missing)
#cbind(colnames(land)[fraction_order], col_fraction_missing[fraction_order])


# Remove columns where > 50% of the data is NA
#cols.rm <- apply(land, 2, function(col) sum(is.na(col)) / nrow(land) >= .5)
#colnames(land)[cols.rm]  # These cols are going to be removed
#colnames(land)[!cols.rm] # These cols are going to be kept
#land <- land[ , !cols.rm]

