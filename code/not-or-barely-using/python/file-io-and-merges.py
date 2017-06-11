import numpy as np
import scipy as sp
import pandas as pd
import functools as functools

# Read dta
dataGen = pd.read_stata("original-dta/general.dta");
dataHealth = pd.read_stata("original-dta/health.dta");
dataEdu = pd.read_stata("original-dta/education.dta");
dataLand = pd.read_stata("original-dta/land.dta")
dataConflict = pd.read_stata("original-dta/conflict.dta")
dataGov = pd.read_stata("original-dta/governance.dta")

# Save as csv
dataGen.to_csv('general.csv')
dataHealth.to_csv('health.csv')
dataEdu.to_csv('education.csv')
dataLand.to_csv("land.csv")
dataConflict.to_csv("%configlict.csv")
dataGov.to_csv("gov.csv")

# Merge all (on year and municipality)
dataAll = functools.reduce( # a fold (haskell sense)
    lambda left,right: pd.merge(left,right,how='inner'
             ,on=['ano','codmpio'])
    , [dataGen,dataHealth,dataEdu]) # can add datasets here

## export that
dataAll.to_csv("csv/all.csv")
