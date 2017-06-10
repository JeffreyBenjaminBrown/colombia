# Refactoring the land.csv file from the Colombia data

land <- read.csv('csv/land.csv', header = TRUE)
land <- land[ , -1]   # Remove the index column

# Convert the ano column data to a year
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
land$ano <- sapply(land$ano, convert_timestamp)
table(land$ano)

## Write the refactored data to the data,in-file-refactored directory
write.csv(land, file = 'data,in-file-refactored/land.csv', row.names = FALSE)


# Compare the values in the old and new files
x <- read.csv('data,in-file-refactored/land.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(land[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
