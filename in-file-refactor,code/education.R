# Refactoring the education.csv file from the Colombia data

education <- read.csv('csv/education.csv', header = TRUE)
education <- education[ , -1]   # Remove the index column

# Convert the ano column data to a year
library(lubridate)
table(education$ano) # uniquely in these files, the ano variable in the edu file is readable.
  # still, let's make it be like the others
education$ano <- year(ymd(education$ano))
table(education$ano)

## Write the refactored data to the data,in-file-refactored directory
write.csv(education, file = 'data,in-file-refactored/education.csv', row.names = FALSE)


# Compare the values in the old and new files
new_file <- read.csv('data,in-file-refactored/education.csv', header = T)
diff <- sapply(1:ncol(new_file), function(n) max(abs(education[ , n] - new_file[ , n]), na.rm = TRUE))
max(diff)
