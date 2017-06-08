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

# Replace the "" in municipality with NA values
  # >> todo: make into a togglable assumption
x$municipality[x$municipality == ""] <- NA

# Row 23 is missing is the muni_code == 5001 with missing dept and prov data
tail(x[x$municipality_code == 5001, 1:7])
x$dept_code[23] <- 5
x$province_code[23] <- 595
x$dept[23] <- 'Antioquia'
x$province[23] <- 'Valle del aburra'
x$municipality <- 'Medellín'
tail(x[x$municipality_code == 5001, 1:7])

# What percentage of data is found in each column of the file?
col_fraction_missing <- apply(x, 2, function(col) sum(is.na(col)) / nrow(x))
plot(1:ncol(x), col_fraction_missing
    , type = 'l', col = 'blue', xlab = 'Col #', ylab = 'Percentage')

fraction_order <- order(col_fraction_missing)
cbind(colnames(x)[fraction_order], col_fraction_missing[fraction_order])
# todo: the last many columns are 95%-ish missing
# was that a single extremely-informative year?

# Remove columns where > 50% of the data is NA
cols.rm <- apply(x, 2, function(col) sum(is.na(col)) / nrow(x) >= .5)
colnames(x)[cols.rm]  # These cols are going to be removed
colnames(x)[!cols.rm] # These cols are going to be kept
x <- x[ , !cols.rm]


## Jeff - We're going to need translations for these names!
#> colnames(x)
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


cor(x[ , 10:14], use = 'complete.obs')

# Plot the cors to find interesting ones
tbl <- cor(x[ , 10:ncol(x)], use = 'complete.obs')
for (i in 1:nrow(tbl)) tbl[i, i] <- 0    # Set the diagonal to 0
for (i in 1:nrow(tbl)) plot(1:nrow(tbl), tbl[ , i], type = 'l', col = 'blue', main = rownames(tbl)[i])