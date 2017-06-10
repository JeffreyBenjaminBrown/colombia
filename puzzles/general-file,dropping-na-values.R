# This code comes from (in order, but not contiguously) general.R

## query?
# Every 23rd row in the data sense is filled with NA values;  Dropping them for now

# Checking that the regions are all NA on the same rows.  Yes.
colnames(general)[10]
gandina.col <- 10
sapply(1:4, function(n) setdiff(which(is.na(general[ , gandina.col])), which(is.na(general[ , gandina.col + n]))))

# All of these rows are completely blank;  Dropping them for now
general <- general[!is.na(general$gandina), ]
