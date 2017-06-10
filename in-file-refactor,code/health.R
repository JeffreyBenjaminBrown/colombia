# Refactoring the health.csv file from the Colombia data

health <- read.csv('csv/health and services.csv', header = TRUE)
health <- health[ , -1]   # Remove the index column

# Convert the ano column data to a year
library(lubridate)
health$ano <- year(ymd(health$ano))
table(health$ano)

## Write the refactored data to the data,in-file-refactored directory
write.csv(health, file = 'data,in-file-refactored/health.csv', row.names = FALSE)


# Compare the values in the old and new files
x <- read.csv('data,in-file-refactored/health.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(health[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
