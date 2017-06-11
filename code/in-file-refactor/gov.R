# Refactoring the gov.csv file from the Colombia data

gov <- read.csv('data/csv/gov.csv', header = TRUE)
gov <- gov[ , -1]   # Remove the index column

# Convert year to an integer
gov$ano <- as.integer(gov$ano)
table(gov$ano)

## Write the refactored data to the data/in-file-refactored directory
write.csv(gov, file = 'data/in-file-refactored/gov.csv', row.names = FALSE)


# Compare the values in the old and new files
x <- read.csv('data/in-file-refactored/gov.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(gov[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
