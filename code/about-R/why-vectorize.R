## This file demosntrates why you should use 'vectorized operations'
## instead of for loops in R.


# Create a data frame with random data
rows <- 300 ; cols <- 500
theData <- data.frame(matrix(runif(rows * cols), nrow = rows))
theData[1:6, 1:8]  # Check theData


# Add missing data to theData
num.missing <- 10000
for (i in 1:num.missing)
    theData[sample(1:nrow(theData), 1)
     , sample(1:ncol(theData), 1)
     ] <- NA


# Slow function using a loop
visualize_missing_slow <- function(theData) {
    plot(1, 1 # just to start, plot a dot
        , pch = '.'
        , xlim = c(1, nrow(theData)), ylim = c(1, ncol(theData))
        , xlab = 'Row #', ylab = 'Col #')
    for (r in 1:nrow(theData))
        for (c in 1:ncol(theData))
            if (is.na(theData[r, c]))
                points(r, c, pch = 19, cex = .1, col = 'blue')
}


visualize_missing_fast <- function(theData) {
  v <- which(as.vector(is.na(theData)))
  r <- v %% nrow(theData)
  c <- v %/% nrow(theData)
  plot(1, 1, pch = '.', xlim = c(1, nrow(theData)), ylim = c(1, ncol(theData)), xlab = 'Row #', ylab = 'Col #')
  points(r, c, pch = 19, cex = .1, col = 'blue')
}


## Performance Test Results ----------------------------------------

                                        #     user  system elapsed
system.time(visualize_missing_slow(theData))  #   64.480   2.388  92.477 - 300x500 w/ 10K missing
system.time(visualize_missing_fast(theData))  #    1.496   0.016   1.614 - 300x500 w/ 10K missing
