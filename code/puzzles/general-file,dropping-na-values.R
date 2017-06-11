# This code comes from (in order, but not contiguously) general.R

## query?
# Every 23rd row in the data sense is filled with NA values;  Dropping them for now

# It turned out that quite a few other rows were missing nearly all of the data.  I
# just noticed that every 23rd row was missing data because that is the pattern near
# the beginning of the file
#
# > ncol(general)
# [1] 81
# > sum.na <- apply(general, 1, function(row) sum(is.na(row)))
# > table(sum.na)
# sum.na
#    0    1    2    3    4    5    7    8   12   17   20   40   41   42   44   45 
#  884   40   30   13    1  126    3    1    1   12    2 3708  919 4061    1  504 
#   46   47   48   49   50   51   52   53   54   55   75 
#  130 1548  988 1152   24 1058 6878  179 2309  112 1102 
# > 
# > head(which(sum.na == 75), 12)
#  [1]  23  46  69  92 115 138 161 184 207 230 253 276
# > 
# > head(which(sum.na == 75), 12) / 23
#  [1]  1  2  3  4  5  6  7  8  9 10 11 12
# 


# Checking that the regions are all NA on the same rows.  Yes.
colnames(general)[10]
gandina.col <- 10
sapply(1:4, function(n) setdiff(
	      which(is.na(general[ , gandina.col]))
	    , which(is.na(general[ , gandina.col + n]))
	    ))

# All of these rows are completely blank;  Dropping them for now
general <- general[!is.na(general$gandina), ]


# Ah, I forgot that I had noticed this while attempting to replace the region codes...
# > tmp <- general[is.na(general$gandina), ]
# > rownames(tmp)[1:10]
#  [1] "23"  "46"  "69"  "92"  "115" "138" "161" "184" "207" "230"
# > 

