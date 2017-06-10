# Refactoring the education.csv file from the Colombia data

education <- read.csv('csv/education.csv', header = TRUE)
education <- education[ , -1]   # Remove the index column

# Convert the ano column data to a year
library(lubridate)
education$year <- year(ymd(education$ano))
table(education$year)

## Write the refactored data to the refactored-data directory
write.csv(education, file = 'data,in-file-refactored/education.csv', row.names = FALSE)


# Compare the values in the old and new files
x <- read.csv('refactored-data/education.csv', header = T)
diff <- sapply(1:ncol(x), function(n) max(abs(education[ , n] - x[ , n]), na.rm = TRUE))
max(diff)
