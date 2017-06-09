# Refactoring the education.csv file from the Colombia data

education <- read.csv('csv/education.csv', header = TRUE)
education <- education[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(education)[1:2] <- c('municipality_code', 'year')

# The year to a single year
library(lubridate)
education$year <- year(ymd(education$year))
table(education$year)

# What percentage of data is found in each column of the file?
col_fraction_missing <- 100 * apply(education, 2, function(col) sum(is.na(col)) / nrow(education))
plot(1:ncol(education), col_fraction_missing, type = 'l', col = 'blue', 
     main = 'Missing Data Percentage', xlab = 'Col #', ylab = 'Percentage')
abline(h = 50, col = 'red')

fraction_order <- order(col_fraction_missing)
cbind(colnames(education)[fraction_order], col_fraction_missing[fraction_order])


# Remove columns where > 50% of the data is NA
#cols.rm <- apply(education, 2, function(col) sum(is.na(col)) / nrow(education) >= .5)
#colnames(education)[cols.rm]  # These cols are going to be removed
#colnames(education)[!cols.rm] # These cols are going to be kept
#education <- education[ , !cols.rm]

