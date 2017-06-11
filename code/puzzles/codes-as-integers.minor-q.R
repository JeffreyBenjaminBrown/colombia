# why did the three codes need to be changed to integers?
# they look the same to me

# Without supplying the colClasses argument to read.csv() these cols
# are being read into R as a double.  All of the values are integral
# (ie., there isn't a single case of 500.1 or something similar).
#
# Initially, I converted them to integer because I wanted to make sure
# I wouldn't come across anything strange.  I kept the code there because
# my laptop keeps printing the doubles as 5.0, 10.0, etc

general <- read.csv('data/csv/general.csv', header = TRUE)
typeof(general$coddepto)  # Output:  [1] "double"


# This is part of "in-file refactoring,code/general.R":
  # Changing the first 3 columns to integer
  general$dept_code <- as.integer(general$dept_code)
  general$province_code <- as.integer(general$province_code)
  general$municipality_code <- as.integer(general$municipality_code)

# But if I read the original data:
  library(foreign)
  general_dta <- read.dta13('original-dta/general.dta')

# the entries all look identical
  table(general$coddepto)
  table(general_dta$coddepto)
  
  table(general$codprovincia)
  table(general_dta$codprovincia)
  
  table(general$codmpio)
  table(general_dta$codmpio)
  