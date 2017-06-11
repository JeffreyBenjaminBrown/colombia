library(stringr)

## We'll merge the six data sets pairwise with this
merge_df <- function(x, y) {
  merge(x, y,
  by = c('ano', 'codmpio'),
  all.x = TRUE, all.y = TRUE)
}

## -----------------------------------------------------------------------------------
## Merge general and health; keep the merged result in acc ("accumulator")

# List files in the data/in-file-refactored directory / Read all of them into a list
csv_files <- list.files('data/in-file-refactored'
                        , pattern='.csv$') # excludes the .csv.bz2 files
data <- lapply(csv_files, function(file) 
  read.csv(file = str_c('data/in-file-refactored', file, sep = '/'), header = TRUE))

# Name the data list and initialize acc with general.csv since I want that data on the left
names(data) <- str_sub(csv_files, end = -5)
acc <- data[['general']]
data[['general']] <- NULL  # Remove the general df from the list
  # in R, can refer to list content by name

# Merge all of the data into acc
while (length(data) > 0) {
  acc <- merge_df(acc, data[[1]])
  data[[1]] <- NULL
}

# Remove the now empty data list
rm(data, merge_df, csv_files)

# Just curious...
nrow(acc)
ncol(acc)

# Identify mostly-missing rows
missing_row_data <- table(apply(acc, 1, function(row) round(sum(is.na(row)) / ncol(acc), 2)))
plot(missing_row_data, type = 'l', col = 'blue', main = 'Missing Row Data',
     xlab = 'Fraction Missing', sub = '(0 = no missing data)', ylab = '# of Rows')

system.time(write.csv(acc, file = 'data/merged.csv', row.names = FALSE))
