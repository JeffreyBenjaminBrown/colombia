# Functions that create plots to visualize missing and non-missing data
# Note - The data frame is rotated to the left by 90 degrees
# The default dot_size value of .10 can be adjusted appears to have as much blank space as is expected
visualize_data <- function(x, dot_size = .10) {
  v <- which(as.vector(!is.na(x)))
  visualize_vector(v, nrow(x), ncol(x), dot_size)
}

visualize_missing_data <- function(x, dot_size = .10) {
  v <- which(as.vector(is.na(x)))
  visualize_vector(v, nrow(x), ncol(x), dot_size)
}

visualize_vector <- function(v, num_rows, num_cols, dot_size = .1) {
  r <- v %% num_rows
  c <- v %/% num_rows
  plot(1, 1, pch = '.', xlim = c(1, num_rows), ylim = c(1, num_cols), xlab = 'Row #', ylab = 'Col #')
  points(r, c, pch = 19, cex = dot_size, col = 'blue')
}


visualize_data <- function(x) {
  v <- which(as.vector(!is.na(x)))
  r <- v %% nrow(x)
  c <- v %/% nrow(x)
  plot(1, 1, pch = '.', xlim = c(1, nrow(x)), ylim = c(1, ncol(x)), xlab = 'Row #', ylab = 'Col #', main = 'Non-Missing Data Plot')
  points(r, c, pch = 19, cex = .1, col = 'blue')
}


## Missing Data Analysis -----------------------------------------------------------------------

x <- read.csv('csv/merged.csv', header = TRUE)
dim(x)

x2 <- x[1:8000, 1:500]

## Jeff - It doesn't look like I will be able to visualize the entire data set in one go
## I'm curious if you have enough RAM to complete it and save the plot as a png
visualize_data(x)
