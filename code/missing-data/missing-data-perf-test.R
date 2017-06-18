
## Jeff - I've added this file as a little lesson on why you should use 'vectorized operations'
##        instead of for loops in R.  The performance difference is pretty incredible.


# Create a data frame with random data
rows <- 300 ; cols <- 500
x <- data.frame(matrix(runif(rows * cols), nrow = rows))
x[1:6, 1:8]  # Check x


# Add missing data to x
num.missing <- 10000
for (i in 1:num.missing) x[sample(1:nrow(x), 1), sample(1:ncol(x), 1)] <- NA


# Slow function using a loop
visualize_missing_slow <- function(x) {
  plot(1, 1, pch = '.', xlim = c(1, nrow(x)), ylim = c(1, ncol(x)), xlab = 'Row #', ylab = 'Col #')  # Cheesy
  for (r in 1:nrow(x)) for (c in 1:ncol(x))
    if (is.na(x[r, c])) points(r, c, pch = 19, cex = .1, col = 'blue')
}


visualize_missing_fast <- function(x) {
  v <- which(as.vector(is.na(x)))
  r <- v %% nrow(x)
  c <- v %/% nrow(x)
  plot(1, 1, pch = '.', xlim = c(1, nrow(x)), ylim = c(1, ncol(x)), xlab = 'Row #', ylab = 'Col #')
  points(r, c, pch = 19, cex = .1, col = 'blue')
}


## Performance Testing Results -----------------------------------------------------------------------

                                        #     user  system elapsed
system.time(visualize_missing_slow(x))  #   64.480   2.388  92.477 - 300x500 w/ 10K missing
system.time(visualize_missing_fast(x))  #    1.496   0.016   1.614 - 300x500 w/ 10K missing

