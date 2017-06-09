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

## Write the refactored data to the refactored-data directory
write.csv(conflict, file = 'refactored-data/conflict.csv', row.names = FALSE)


# Compare the values in the old and new files
x <- read.csv('refactored-data/conflict.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(conflict[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
