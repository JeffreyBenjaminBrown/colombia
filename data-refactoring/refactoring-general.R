# Refactoring the general.csv file from the Colombia data

general <- read.csv('csv/general.csv', header = TRUE)  #colClasses = c(rep('integer', 3), rep('factor', 3), 'double'))
general <- general[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(general)[1:7] <- c('dept_code', 'province_code', 'municipality_code', 'dept', 'province', 'municipality', 'year')

# Changing the first 3 columns to integer
general$dept_code <- as.integer(general$dept_code)
general$province_code <- as.integer(general$province_code)
general$municipality_code <- as.integer(general$municipality_code)

# Change the Stata time encoding to a year
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
general$year <- sapply(general$year, convert_timestamp)

# Replace the "" in municipality with NA values
general$municipality[general$municipality == ""] <- NA

# Every 23rd row in the data sense is filled with NA values;  Dropping them for now

# Region names are used in a few places below
region.names <- c('gandina', 'gcaribe', 'gpacifica', 'gorinoquia', 'gamazonia')

# Checking that the regions are all NA on the same rows.  Yes.
colnames(general)[10]
gandina.col <- 10
sapply(1:4, function(n) setdiff(which(is.na(general[ , gandina.col])), which(is.na(general[ , gandina.col + n]))))

# All of these rows are completely blank;  Dropping them for now
general <- general[!is.na(general$gandina), ]

# Replacing the 5 region columns with a region column that contains a factor w/ the region values
regions <- colSums(t(general[ , colnames(general) %in% region.names]) * 1:length(region.names))
general[ , gandina.col] <- factor(regions, levels = 1:5, labels = c('Andina', 'Caribe', 'Pacifica', 'Orinoquia', 'Amazonia'))
colnames(general)[gandina.col] <- "region"
general <- general[ , -11:-14]
general[1:4, 1:15]


## Write the refactored data to the refactored-data directory
write.csv(general, file = 'refactored-data/general.csv', row.names = FALSE)
