#' @title Check if Roots of a Polynomial Lie Outside the Unit Circle
#' @description This function outputs the roots of a given polynomial. It also checks whether they lie outside the unit circle and creates a plot to illustrate the results in an intuitive way.
#' @param pol_ the vector of polynomial coefficients in increasing order.
#' @param plot_output Logical that defines whether to create a plot.
#' @param print_output Logical that defines whether to print the results.
#' @export
#' @return NULL
#' @examples
#' uc.check(pol_ = c(1,0,0.999999999), plot_output = FALSE)
#'
#' uc.check(pol_ = c(2,0,2.2,-3), plot_output = TRUE)


uc.check <- function(pol_, plot_output = T, print_output = T){
  # Calculate roots and save them in a dataframe
  res<- data.frame(real = round(Re(polyroot(pol_)),6),
                   complex = round(Im(polyroot(pol_)),6))
  # Check if outside the unit circle
  res <- data.frame(res, outside = c(sqrt(Re(polyroot(pol_))^2+Im(polyroot(pol_))^2) > 1))
  # print results
  if(print_output == T){
    print(res)
    cat("*Results are rounded to 6 digits.")
  }
  # create a plot
  if(plot_output == T){
    plot(x = res$real, y = res$complex,
         asp = 1,
         xlim = if(any(abs(res$real) > 1)){NULL}else{c(-1, 1)},
         ylim = if(any(abs(res$complex) > 1)){NULL}else{c(-1, 1)},
         pch = 16, cex = 1.2,
         col = ifelse(res$outside == TRUE, "forestgreen", "firebrick2"),
         xlab = "Real part",
         ylab = "Complex part",
         main = "Roots outside the Unit Circle?")
    abline(h = 0, lty = 3, col = "darkgrey")
    abline(v = 0, lty = 3, col = "darkgrey")
    lines(x = 1 * cos(seq(0, 2 * pi, length = 1000)),
          y = 1 * sin(seq(0, 2 * pi, length = 1000)),
          lwd = 1.5)
    text(res$real, res$complex, labels= res$outside, cex= 0.8, pos=3)
  }
  # return results
  invisible(res)
}

# Dummy commit
