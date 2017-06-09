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

## Write the refactored data to the refactored-data directory
write.csv(land, file = 'refactored-data/land.csv', row.names = FALSE)


# Compare the values in the old and new files
x <- read.csv('refactored-data/land.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(land[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
