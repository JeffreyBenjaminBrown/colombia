# Refactoring the general.csv file from the Colombia data

general <- read.csv('csv/general.csv', header = TRUE)  #colClasses = c(rep('integer', 3), rep('factor', 3), 'double'))
general <- general[ , -1]   # Remove the index column

# Working on the first seven columns; rename them into English
colnames(general)[1:7] <- c('dept_code', 'province_code', 'municipality_code', 'dept', 'province', 'municipality', 'year')

# Changing the first 3 columns to integer
general$dept_code <- as.integer(general$dept_code)
general$province_code <- as.integer(general$province_code)
general$municipality_code <- as.integer(general$municipality_code)

# TODO - The mapping between codes and names isn't 1 to 1
sapply(colnames(general)[1:6], function(col) length(unique(general[ , col])))

# TODO - Merge the 5 regions columns into a single region with the value
regions <- c('gandina', 'gcaribe', 'gpacifica', 'gorinoquia', 'gamazonia')


# Change the Stata time encoding to a year
library(lubridate)
convert_timestamp <- function(x) year(as.POSIXct(x/1000000000, origin = '1970-01-01')) + 1
general$year <- sapply(general$year, convert_timestamp)

# Replace the "" in municipality with NA values
  # >> todo: make into a togglable assumption
general$municipality[general$municipality == ""] <- NA

# Row 23 is missing is the muni_code == 5001 with missing dept and prov data
tail(general[general$municipality_code == 5001, 1:7])
general$dept_code[23] <- 5
general$province_code[23] <- 595
general$dept[23] <- 'Antioquia'
general$province[23] <- 'Valle del aburra'
general$municipality <- 'Medellín'
tail(general[general$municipality_code == 5001, 1:7])

# Do the dept and province have NA for the same rows?  YES!
# there is no explicit set data type in base R
# 2015 is the only year for which this data is missing
setdiff(which(is.na(general$dept_code)), which(is.na(general$province_code)))
setdiff(which(is.na(general$dept)), which(is.na(general$province_code)))
setdiff(which(is.na(general$dept)), which(is.na(general$province)))
table(general$year[is.na(general$dept)])

# What percentage of data is found in each column of the file?
col_fraction_missing <- apply(general, 2, function(col) sum(is.na(col)) / nrow(general))
plot(1:ncol(general), col_fraction_missing
    , type = 'l', col = 'blue', xlab = 'Col #', ylab = 'Percentage')

fraction_order <- order(col_fraction_missing)
cbind(colnames(general)[fraction_order], col_fraction_missing[fraction_order])
# todo: the last many columns are 95%-ish missing
# was that a single extremely-informative year?

# Remove columns where > 50% of the data is NA
#cols.rm <- apply(general, 2, function(col) sum(is.na(col)) / nrow(general) >= .5)
#colnames(general)[cols.rm]  # These cols are going to be removed
#colnames(general)[!cols.rm] # These cols are going to be kept
#general <- general[ , !cols.rm]


## Jeff - We're going to need translations for these names!
#> colnames(general)
# [1] "dept_code"         "province_code"     "municipality_code"
# [4] "dept"              "province"          "municipality"
# [7] "year"              "ao_crea"           "act_adm"
#[10] "gandina"           "gcaribe"           "gpacifica"
#[13] "gorinoquia"        "gamazonia"         "pobl_rur"
#[16] "pobl_urb"          "pobl_tot"          "indrural"
#[19] "areaoficialkm2"    "areaoficialhm2"    "altura"
#[22] "discapital"        "dismdo"            "disbogota"
#[25] "codmdo"            "mercado_cercano"   "distancia_mercado"
#[28] "gpc"               "gini"


# Plot the cors to find interesting ones
#tbl <- cor(general[ , 10:ncol(general)], use = 'complete.obs')
#for (i in 1:nrow(tbl)) tbl[i, i] <- 0    # Set the diagonal to 0
#for (i in 1:nrow(tbl)) plot(1:nrow(tbl), tbl[ , i], type = 'l', col = 'blue', main = rownames(tbl)[i])
