library(stringr)

# We'll merge the six data sets pairwise, using this
merge_df <- function(x, y) {
  merge(x, y,
  by = c('ano', 'codmpio'),
  all.x = TRUE, all.y = TRUE)
}

# List files in the data/in-file-refactored directory / Read all of them into a list
csv_files <- list.files('data/in-file-refactored'
                        , pattern='.csv$') # excludes the .csv.bz2 files
data <- lapply(csv_files, function(file) 
  read.csv(file = str_c('data/in-file-refactored', file, sep = '/'), header = TRUE))

# Start with general.csv since I want that data on the left
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

# Derive a few variables
acc$pobl_log <- log( acc$pobl_tot ) / log(10)
acc$nacimientos_per_kp <- 1000 * acc$nacimientos / acc$pobl_tot
acc$pib_percapita_derived <- acc$pib_total / acc$pobl_tot
acc$prestadores_pk_derived <- 1000 * acc$prestadores / acc$pobl_tot

# Write
system.time(write.csv(acc, file = 'data/merged.csv', row.names = FALSE))
