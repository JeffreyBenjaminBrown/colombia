# boxplots: gini by year
varsWithNans=dataAll[['ano','codmpio','gini']];
vars = varsWithNans[ ~dataAll['gini'].isnull() ]

b_vals = vars.ano.unique()
slices = []
for i in b_vals: slices.append(vars[vars['ano']==i])

plt.figure()
plt.boxplot(
    #slices[1]['gini']
    [ s['gini'] for s in slices ]
    ,labels=b_vals
)
plt.show()
