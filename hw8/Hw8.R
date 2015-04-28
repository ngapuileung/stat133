xUnique = 1:5
trueCoeff = c(0, 1, 1)

getData = function(coefs = c(0, 1, 1), xs = 1:5, dupl = 10,
                   sd = 5, seed=2222){
  ### This function creates the artificial data
  set.seed(seed)
  x = rep(xs, each = dupl)
  y = coefs[1] + coefs[2]*x + coefs[3] * x^2 + 
    rnorm(length(x), 0, sd)
  return(data.frame(x, y))
}

### 
genBootY = function(x, y, rep = TRUE){
  ### For each unique x value, take a sample of the
  ### corresponding y values, with replacement.
  ### Return a vector of random y values the same length as y
  ### You can assume that the xs are sorted
  ### Hint use tapply here!
  return(apply(x, y, sample(y, length(y), replace = TRUE)))
}

genBootR = function(fit, err, rep = TRUE){
  ### Sample the errors 
  ### Add the errors to the fit to create a y vector
  ### Return a vector of y values the same length as fit
  ### HINT: It can be easier to sample the indices than the values
  ### "fit" can be found with mylm$fitted or with predict() function on our lm in fitModel;
  ###  predicted y values
  ### "err" are the residuals from the lm in fitModel.
  return(fit + sample(err, length(err), replace = FALSE))
}

fitModel = function(x, y, degree = 1){
  ### use the lm function to fit a line of a quadratic 
  ### e.g. y ~ x or y ~ x + I(x^2)
  ### y and x are numeric vectors of the same length
  ### Return the coefficients as a vector 
  ### HINT: Take a look at the repBoot function to see how to use lm()
  if(degree == 1){
    coeff = lm(formula = y ~ x)
  }
  else{
    coeff = lm(formula = y ~ x + I(x^2))   
  }
  return(coeff)
}

oneBoot = function(data, fit = NULL, degree = 1){
  ###  data are either your data (from call to getData)
  ###  OR fit and errors from fit of line to data
  ###  OR fit and errors from fit of quadratic to data
  ### Use fitModel to fit a model to this bootstrap Y
  if (is.null(fit)){
    values = genBootY(data$x, data$y)
  }
  else{
    values = genBootR(fit[ , 1], fit[ , 2])
  }
  return(fitModel(data$x, values, degree))
}

repBoot = function(data, B = 1000){
  
  ### Set up the inputs you need for oneBoot, i.e.,
  ### create errors and fits for line and quadratic
  
  ### replicate a call to oneBoot B times
  ### format the return value so that you have a list of
  ### length 4, one for each set of coefficients
  ### each element will contain a data frame with B rows
  ### and one or two columns, depending on whether the 
  ### fit is for a line or a quadratic
  ### Return this list
  
  ### Replicate a call to oneBoot B times for 
  ### each of the four conditions
  
  ### Format the return value so that you have a list of
  ### length 4, one for each set of coefficients
  ### each element will contain a matrix with B columns
  ### and two or three rows, depending on whether the 
  ### fit is for a line or a quadratic
  ### Return this list
  
  y <- data$y
  x <- data$x
  line <- lm(y~x)$fitted.values
  quad <- lm(y ~ x + I(x^2))$fitted.values
  
  res_line <- lm(y ~ x)$residuals
  res_quad <- lm(y ~ x + I(x^2))$residuals
  
  fit_line <- data.frame(line, res_line)
  fit_quad <- data.frame(quad, res_quad)
  
  a <- replicate(n = B, oneBoot(data, fit = NULL, degree = 1))
  b <- replicate(n = B, oneBoot(data, fit = NULL, degree = 2))
  c <- replicate(n = B, oneBoot(data, fit = fit_line, degree = 1))
  d <- replicate(n = B, oneBoot(data, fit = fit_quad, degree = 2))
  
  coeff <- list(a, b, c, d)
  return(coeff)
} 

bootPlot = function(x, y, coeff, trueCoeff){
  ### x and y are the original data
  ### coeff is a matrix from repBoot
  ### trueCoeff contains the true coefficients 
  ### that generated the data
  
  ### Make a scatter plot of data
  
  ### Add lines or curves for each row in coeff
  ### Use transparency
  ### You should use mapply to construct all 
  ### 1000 of the bootstrapped lines of best fit 
  ### Have a look at ?mapply for details.
  ### This can be done in ggplot2 or base graphics.
  
  ### Use trueCoeff to add true line/curve - 
  ###  Make the true line/curve stand out
  plot(y ~ x)
  if (nrow(coeff) == 2){
    mapply(abline, coeff[1, ], coeff[2, ], col = rgb(0, 0.7, 0.4, 0.5))
  }
  if (nrow(coeff) == 3){
    mapply(function(a, b, c){curve(a + b * x + c * (x^2), col = rgb(0, 0.7, 0.4, 0.5), add = TRUE)}, a = coeff[1, ], b = coeff[2, ], c = coeff[3, ])
  }
  curve(trueCoeff[1] + trueCoeff[2] * x + trueCoeff[3] * (x^2), col = "navy", add = TRUE, lwd = 3)
}

### Run your simulation by calling this function
### This function doesn't need any changing
runSim = function() {
  xUnique = 1:5
  trueCoeff = c(0, 1, 1)
  myData = getData(coefs = trueCoeff, xs = xUnique)
  expt = repBoot(data = myData)
  par(mfrow = c(2, 2))
  for (i in 1:4){
    bootPlot(myData$x, myData$y, 
             coeff = expt[[i]], trueCoeff) 
  }
  return(expt)
}