# Refactoring the conflict.csv file from the Colombia data

conflict <- read.csv('csv/conflict.csv', header = TRUE)
conflict <- conflict[ , -1]   # Remove the index column

# Convert the ano column data to a year
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
#conflict$ano
conflict$ano <- sapply(conflict$ano, convert_timestamp)
table(conflict$ano)

## Write the refactored data to the data,in-file-refactored directory
write.csv(conflict, file = 'data,in-file-refactored/conflict.csv', row.names = FALSE)

# Compare the values in the old and new files
x <- read.csv('data,in-file-refactored/conflict.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(conflict[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
