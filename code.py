import pandas as pd
dataGen = pd.read_stata("data/general.dta")
dataHealth = pd.read_stata("data/health and services.dta")

# list column names
list(dataGen.columns.values)

# list unique values in a column
dataGen.gandina.unique()

# strip rows with NaN values
a = np.array([[1,2,3], [4,5,np.nan], [7,8,9]]);
a[~np.isnan(a).any(axis=1)]
  # ~ is the not operator
  # axis=1 means "rows"


