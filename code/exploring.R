setwd('colombia')
colombia <- read.csv('data/merged.csv')

colombia$nacimientos_per_kp <- 1000 * colombia$nacimientos / colombia$pobl_tot
summary( colombia[c('nacimientos_per_kp','nacimientos','pobl_tot') ] )

colombia$pib_pb_derived <- colombia$pib_total / colombia$pobl_tot
summary( colombia[c('pib_pb_derived','pib_total', 'pobl_tot')])

colombia$prestadores_pk_derived <- 1000 * colombia$prestadores / colombia$pobl_tot
summary( colombia[c('prestadores_pk_derived','prestadores', 'pobl_tot')])

colombia$pobl_log <- log( colombia$pobl_tot ) / log(10)

# handy is a more easily human-grokkable subset of colombia
handy <-  colombia[c('ano', 'municipio', 'pobl_tot', 'pobl_log', 'nacimientos_per_kp', 'prestadores', 'prestadores_pk_derived', 'pib_percapita', 'ipm_hacinam_p', 'ipm_templeof_p', 'gpc', 'gini', 'ipm_analf_p', 'minorias', 'parques', 'religioso', 'estado', 'otras', 'pib_precapita_cons', 'pib_agricola', 'pib_industria', 'pib_servicios', 'pib_total', 'indrural', 'discapital', 'dismdo', 'disbogota')]


# Pictures
cols_to_show <- c('pobl_log','nacimientos_per_kp')
x <- colombia[ c( 'ano', cols_to_show ) ] # c() always produces a flat list
x <- na.omit(x)
x <- x[  sapply( x[ cols_to_show[1] ], is.finite  )
       & sapply( x[ cols_to_show[2] ], is.finite  ), ]
  # ? why must I use sapply( x[cols_to_show[2]], is.finite )
    # instead of is.finite( x[ cols_to_show[2] ]  )
plot( x[ x['ano']==2010, cols_to_show] )

cols_to_show <- c('pobl_log','prestadores_pk_derived')
x <- colombia[ c( 'ano', cols_to_show ) ]
x <- na.omit(x)
x <- x[  sapply( x[ cols_to_show[1] ], is.finite  )
       & sapply( x[ cols_to_show[2] ], is.finite  ), ]
plot( x[ x['ano']==2010, cols_to_show] )
# ? Why are there two paths for the relationship
  # they are easily distinguished visually, but no math yet describes that
  # see figure, "hospitals per k capita X population.png"

# GPC: mostly zeroes?
cols_to_show <- c('pobl_log','gpc')
x <- colombia[ c( 'ano', cols_to_show ) ]
x <- na.omit(x)
x <- x[  sapply( x[ cols_to_show[1] ], is.finite  )
       & sapply( x[ cols_to_show[2] ], is.finite  ), ]
plot( x[ x['ano']==2010, cols_to_show] )


ano
mpio
pobl_tot
pobl_log
prestadores
ipm_hacinam_p
gpc
ipm_analf_p
parques
estado
pib_precapita_cons
pib_industria
pib_total
discapital
disbogota
nacimientos_per_kp
pib_percapita
ipm_templeof_p
gini
minorias
religioso
otras
pib_agricola
pib_servicios
indrural
dismdo
