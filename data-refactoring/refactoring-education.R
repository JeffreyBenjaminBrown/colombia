# Refactoring the education.csv file from the Colombia data

x <- read.csv('csv/education.csv', header = TRUE)
x <- x[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(x)[1:2] <- c('municipality_code', 'year')

# The year to a single year
library(lubridate)
x$year <- year(ymd(x$year))
table(x$year)

# What percentage of data is found in each column of the file?
col_fraction_missing <- 100 * apply(x, 2, function(col) sum(is.na(col)) / nrow(x))
plot(1:ncol(x), col_fraction_missing, type = 'l', col = 'blue', 
     main = 'Missing Data Percentage', xlab = 'Col #', ylab = 'Percentage')

fraction_order <- order(col_fraction_missing)
cbind(colnames(x)[fraction_order], col_fraction_missing[fraction_order])


# Remove columns where > 50% of the data is NA
#cols.rm <- apply(x, 2, function(col) sum(is.na(col)) / nrow(x) >= .5)
#colnames(x)[cols.rm]  # These cols are going to be removed
#colnames(x)[!cols.rm] # These cols are going to be kept
#x <- x[ , !cols.rm]

