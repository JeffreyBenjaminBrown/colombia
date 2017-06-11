# Larry had this in merge.R
# Jeff didn't understand it, moved it here

# Because of the size of the data frame, I've begun using a data table
require(data.table)                                 #    user  system elapsed 
system.time(acc <- data.table(acc))                     #   1.408   0.392  15.773 
system.time(setkey(acc, codmpio, ano))     #   0.004   0.000   0.003 
system.time(write.csv(acc, file = 'data,in-file-refactored/merged2.csv', row.names = FALSE))

system.time(acc <- read.csv('data,in-file-refactored/merged.csv', header = TRUE))
system.time(acc <- fread('data,in-file-refactored/merged2.csv'))

# Method       Action   Time    user  system elapsed        Size
# ----------   ------   ----------------------------      ------
# data frame    write         84.300   2.696 232.910      172 MB
# data table    write         82.608   1.608  84.628      181 MB
# data frame     read         54.036   0.548  55.317          NA
# data table     read          7.708   0.152  10.369          NA

# TODO - The version of data.table that I'm using is a bit dated, so the new fwrite() function
#        is missing.  I'll test the performance of this function after upgrading my laptop.
