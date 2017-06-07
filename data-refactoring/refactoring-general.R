# Refactoring the general.csv file from the Colombia data

x <- read.csv('csv/general.csv', header = TRUE)
                #colClasses = c(rep('integer', 3), rep('factor', 3), 'double'))
x <- x[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(x)[1:7] <- c('dept_code', 'province_code', 'municipality_code', 'dept', 'province', 'municipality', 'year')

# Changing the first 3 columns to integer
x$dept_code <- as.integer(x$dept_code)
x$province_code <- as.integer(x$province_code)
x$municipality_code <- as.integer(x$municipality_code)

# Change the Stata time encoding to a year
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
x$year <- sapply(x$year, convert_timestamp)

# Do the dept and province have NA for the same rows?  YES!
    # there is no explicit set data type in base R
setdiff(which(is.na(x$dept_code)), which(is.na(x$province_code)))
setdiff(which(is.na(x$dept)), which(is.na(x$province_code)))
setdiff(which(is.na(x$dept)), which(is.na(x$province)))

# Which municipalities have NA values for the dept / province?
  # The table has one column named ""; none of the other strings were missing
muni.tbl <- table(x$municipality[is.na(x$dept_code)])
muni.tbl[muni.tbl > 0]

# The 1 bad value for muni_code 5001
x[x$municipality_code == 5001, 1:7]
