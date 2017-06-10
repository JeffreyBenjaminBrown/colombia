# why did the three codes need to be changed to integers?
# they look the same to me

# This is part of "in-file refactoring,code/general.R":
  # Changing the first 3 columns to integer
  general$dept_code <- as.integer(general$dept_code)
  general$province_code <- as.integer(general$province_code)
  general$municipality_code <- as.integer(general$municipality_code)

# But if I read the original data:
  library(foreign)
  general_dta <- read.dta13('data/general.dta')

# the entries all look identical
  table(general$coddepto)
  table(general_dta$coddepto)
  
  table(general$codprovincia)
  table(general_dta$codprovincia)
  
  table(general$codmpio)
  table(general_dta$codmpio)
  