# Refactoring the general.csv file from the Colombia data

general <- read.csv('data/csv/general.csv', header = TRUE)  #colClasses = c(rep('integer', 3), rep('factor', 3), 'double'))
general <- general[ , -1]   # Remove the index column

# Changing the first 3 columns to integer
general$coddepto <- as.integer(general$coddepto)
general$codprovincia <- as.integer(general$codprovincia)
general$codmpio <- as.integer(general$codmpio)

# Convert 'ano' to a 4-digit year (from a weird long time format)
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
general$ano <- sapply(general$ano, convert_timestamp)

# Replace the "" in municipio with NA values
general$municipio[general$municipio == ""] <- NA

# Add to the 5 region columns a region column that contains a factor w/ the region values
  # The redundancy is useful -- a regression could use 4 of the 5 region dummies
region.names <- c('gandina', 'gcaribe', 'gpacifica', 'gorinoquia', 'gamazonia')
regions <- colSums(t(general[ , colnames(general) %in% region.names]) * 1:length(region.names))
general$region_factor <- factor(regions, levels = 1:5, labels = c('Andina', 'Caribe', 'Pacifica', 'Orinoquia', 'Amazonia'))

## Write the refactored data to the data/in-file-refactored directory
write.csv(general, file = 'data/in-file-refactored/general.csv', row.names = FALSE)
