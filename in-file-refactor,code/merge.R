library(stringr)

## Helper function to make sure that all of the data frames are merged consistently
merge_df <- function(x, y) {
  merge(x, y, by = c('ano', 'codmpio'), all.x = TRUE, all.y = TRUE)
}


## -----------------------------------------------------------------------------------
## Merging general and health;  Keeping the merged result in x

# List files in the refactored-data directory / Read all of them into a list
files <- list.files('refactored-data')
data <- lapply(files, function(file) 
  read.csv(file = str_c('refactored-data', file, sep = '/'), header = TRUE))

# Name the data list and initialize x with general since I want that data on the left
names(data) <- str_sub(files, end = -5)
x <- data[['general']]
data[['general']] <- NULL  # Remove the general df from the list

# Merge all of the data into x
while (length(data) > 0) {
  x <- merge_df(x, data[[1]])
  data[[1]] <- NULL
}

# Remove the now empty data list
rm(data, merge_df, files)

# Just curious...
nrow(x)
ncol(x)

# CHECK FOR ROWS THAT ARE MOSTLY NA AND REMOVE THEM!!!
(missing_row_data <- table(apply(x, 1, function(row) round(sum(is.na(row)) / ncol(x), 2))))
plot(missing_row_data, type = 'l', col = 'blue', main = 'Missing Row Data',
     xlab = 'Fraction Missing', sub = '(0 = no missing data)', ylab = '# of Rows')


# Because of the size of the data frame, I've begun using a data table
system.time(write.csv(x, file = 'refactored-data/merged.csv', row.names = FALSE))

require(data.table)                                 #    user  system elapsed 
system.time(x <- data.table(x))                     #   1.408   0.392  15.773 
system.time(setkey(x, municipality_code, year))     #   0.004   0.000   0.003 
system.time(write.csv(x, file = 'refactored-data/merged2.csv', row.names = FALSE))

system.time(x <- read.csv('refactored-data/merged.csv', header = TRUE))
system.time(x <- fread('refactored-data/merged2.csv'))

# Method       Action   Time    user  system elapsed        Size
# ----------   ------   ----------------------------      ------
# data frame    write         84.300   2.696 232.910      172 MB
# data table    write         82.608   1.608  84.628      181 MB
# data frame     read         54.036   0.548  55.317          NA
# data table     read          7.708   0.152  10.369          NA

# TODO - The version of data.table that I'm using is a bit dated, so the new fwrite() function
#        is missing.  I'll test the performance of this function after upgrading my laptop.
