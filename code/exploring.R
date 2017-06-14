# ==== ==== Load & refactor data
setwd('colombia')
colombia <- read.csv('data/merged.csv')

colombia$pobl_log <- log( colombia$pobl_tot ) / log(10)

colombia$nacimientos_per_kp <- 1000 * colombia$nacimientos / colombia$pobl_tot
summary( colombia[c('nacimientos_per_kp','nacimientos','pobl_tot') ] )

colombia$pib_pb_derived <- colombia$pib_total / colombia$pobl_tot
summary( colombia[c('pib_pb_derived','pib_total', 'pobl_tot')])

colombia$prestadores_pk_derived <- 1000 * colombia$prestadores / colombia$pobl_tot
summary( colombia[c('prestadores_pk_derived','prestadores', 'pobl_tot')])


# ==== ==== Pictures
# log of population X births per thousand persons
cols_to_show <- c('pobl_log','nacimientos_per_kp')
x <- colombia[ c( 'ano', cols_to_show ) ] # c() always produces a flat list
x <- na.omit(x)
x <- x[  sapply( x[ cols_to_show[1] ], is.finite  )
       & sapply( x[ cols_to_show[2] ], is.finite  ), ]
  # ? why must I use sapply( x[cols_to_show[2]], is.finite )
    # instead of is.finite( x[ cols_to_show[2] ]  )
    # (Someone online said you could check if it had|was that kind of method.)
plot( x[ x['ano']==2010, cols_to_show] )


# log of population X healthcare providers per thousand persons
cols_to_show <- c('pobl_log','prestadores_pk_derived')
x <- colombia[ c( 'ano', cols_to_show ) ]
x <- na.omit(x)
x <- x[  sapply( x[ cols_to_show[1] ], is.finite  )
       & sapply( x[ cols_to_show[2] ], is.finite  ), ]
plot( x[ x['ano']==2010, cols_to_show] )
# ? Why are there two paths for the relationship
  # they are easily distinguished visually, but no math yet describes that
  # see figure, "hospitals per k capita X population.png"


# log of population X government spending per person
cols_to_show <- c('pobl_log','gpc')
x <- colombia[ c( 'ano', cols_to_show ) ]
x <- na.omit(x)
x <- x[  sapply( x[ cols_to_show[1] ], is.finite  )
       & sapply( x[ cols_to_show[2] ], is.finite  ), ]
plot( x[ x['ano']==2010, cols_to_show] )
  # ? GPC: mostly zeroes


# log of population X illiteracy in 1985
var1 <- 'pobl_log'
var2 <- 'per_alfa1985'
x <- colombia[ c( 'ano', var1, var2 ) ]
x <- na.omit(x)
x <- x[  sapply( x[ var1 ], is.finite  )
       & sapply( x[ var2 ], is.finite  ), ]
plot( x[ x['ano']==2010, c(var1,var2)] )


# log of population X overcrowding
var1 <- 'pobl_log'
var2 <- 'ipm_hacinam_p'
x <- colombia[ c( 'ano', var1, var2 ) ]
x <- na.omit(x)
x <- x[  sapply( x[ var1 ], is.finite  )
       & sapply( x[ var2 ], is.finite  ), ]
plot( x[ x['ano']==2010, c(var1,var2)] )
# ? Why does this draw no picture?
  # I get "Error in plot.window(...) : need finite 'xlim' values".
summary( x[ x['ano']==2010] )
# !? Why is this giving me year 2005?


# ==== ==== a function for those, doesn't work
plotColombia2010 <- function (colName1,colName2) {
    x <- colombia[c('ano',colName1,colName2)]
    x <- na.omit(x)
    x <- x[  sapply( x[ colName1 ], is.finite  )
           & sapply( x[ colName2 ], is.finite  ), ]
    plot( x[ x['ano']==2010, colName1, colName2] )
    }

