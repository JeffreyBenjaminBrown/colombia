import pandas as pd
import functools as functools

# import, combine datax
dataGen = pd.read_stata("data/general.dta")
dataHealth = pd.read_stata("data/health and services.dta")

## common column names
list(dataGen.columns.values)
set(dataGen.columns.values).intersection( # common values: ano, codmpio
    set(dataHealth.columns.values))

dataAll = functools.reduce(
    lambda left,right: pd.merge(left,right,how='inner'
             ,on=['ano','codmpio'])
    , [dataGen,dataHealth]) # can add datasets here

# list unique values in a column
dataGen.gandina.unique()

# strip rows with NaN values
a = np.array([[1,2,3], [4,5,np.nan], [7,8,9]]);
a[~np.isnan(a).any(axis=1)]
  # ~ is the not operator
  # axis=1 means "rows"

