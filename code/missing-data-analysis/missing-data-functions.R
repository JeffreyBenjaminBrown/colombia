## A method for visualizing complete or non-missing data in the individual csv files

library(stringr)

visualize_data <- function(x, main = '', cex = .1) {
  v <- which(as.vector(!is.na(x)))
  r <- v %% nrow(x)
  c <- v %/% nrow(x)
  plot(1, 1, pch = '.', xlim = c(1, nrow(x)), ylim = c(1, ncol(x)),
       xlab = 'Row #', ylab = 'Col #', main = main)
  points(r, c, pch = 19, cex = cex, col = 'blue')
}



## Import and Plot the Non-Missing Data -------------------------------------------------------------------

csv_files <- c('conflict.csv', 'education.csv', 'general.csv', 'gov.csv', 'health.csv', 'land.csv')

for (i in 1:length(csv_files)) {
  file <- csv_files[i]
  x <- read.csv(str_c('data/in-file-refactored/', file), header = TRUE)
  x <- x[order(x$ano, x$codmpio), ]

  png(str_c('figures/missing-data/', file, '.png'))
  visualize_data(x, main = str_c('Complete Data in File: ', file), cex = .02)
  years <- unique(x$ano)
  years.len <- length(years)
  years.start <- sapply(years, function(year) min(which(x$ano == year)))
  abline(v = c(years.start, nrow(x)))

  years.offset <- as.integer((c(years.start[-1], nrow(x)) - years.start) / 2)
  years.x <- years.start + years.offset
  years.y <- as.integer(seq(from = 1, to = ncol(x), length.out = years.len + 2)[c(-1, -(years.len + 2))])
  text(x = years.x, y = years.y, labels = years, lwd = 1.3)
  dev.off()
}
