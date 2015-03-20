Graphics
  Data cleaning: find error and what's going on; do not just delete them
  Plot and then add more arguments
  Rug plot: thick and thin tickmarks plotted on spectrum
  Histogram: areas of bars add up to 100%
    hist(infats$bwt, freq = FALSE) = histogram w/ relative frequency
    hist(infats$bwt, freq = TRUE) = number of babies plotted on y-axis
    xlab = customize x-axis
    main = "title name"
  Density plot: smoothed histogram
    plot(density(infants$bwt))
    bw = band width to adust amount of smoothing of plot
  Boxplot
    boxplot(infants$bwt)
    Half of data w/in box
  Barplot(table(infants$parity))
    Output of "table" is table of numbers
    "h" controls height; lwd controls width of band
  Dot chart
    dotchart(table(video$grade), pch = 19)
  Mosaic plot
    mosaicplot(table(video$sex, video$grade))
  %in%: looks at first entry in second entry
  boxplot(shousing$price ~ shousing$city, las = 2) = splits large boxplot by cities with equal scale

Graph contstruction
  jitter(x) #adds small amount to number

Use lappply if want o perform operation to each element of a list, to each vector in a data frame, or to individual dimensions of a matrix
Different apply commands
  sapply() works for lists and returns as vector or matrix
  lapply() works for lists and returns as list and data frames
  apply() works for matrices
  tapply () works for tables; apply function to subsets of vector
apply command(matrix or dataframe, operation/function, other arguments)
all() command checks and makes comparison in r

Anatomy of function:
  myFunction = function (arguments) body
  Body consists of expresions surrounded by {}
  If do not specify na.rm, then it will appear FALSE
  na.rm to remove empty values
  return expression hands control back to the caller of the function and returnes a given value
  return(list) for more than one thing

Control flow statements:
  Flow control structures allow us to control which statements are evaluated and in what order
  if/else statments and ifelse function
    whatever is after "if" is only executed if first expression is TRUE
    if(condition){statement 1}else{statement 2}
    if the result is numeric, 0 is treated as FALSE and other numbers are TRUE
    if the result is not logical or numeric or NA, you get error
    other constructions: if/any, if/all
    & (AND) and | (OR)
    if/else statements can be nested
    i.e. y = if (any(x<=0)) log(1+x) else log(x) is the same as if (any(x<=0)) y=log(1+x) else y=log(x)
    i.e. corplot = function(x, y, plotit = TRUE){if(plotit == TRUE) plot(x, y) cor(x,y)}
    i.e. if(!is.matrix(m))stop("m must be a matrix")
    i.e. ratio = if(x!=0) y/x else NA
    i.e. normt = function(n, dist){
          if(dist == "normal"){
            return(rnorm(n))
          }else if (dist == "t"){
            return(rt(n, df = 1, ncp = 0))
          }else stop("distribution not implemented")
        }
    i.e. plot(Income, Donations,
              col = ifelse(party == "Republican", "red", "blue"))
  for and while loops

sapply() applies function to everything in the list
mapply(distToPoint, 1:10, 10:1, MoreArgs = list(pt = c(1,0)))

installpackage() installs package once
library() command must be called for every time

Catching errors
  stop function to stop the code; always used with if statement
    if(any<x<0)) stop("x must be >=0")
    showstopifnot
  warning function to print message w/o stopping execution of function
  try function allows you to try the code; used when the execution of code is indefinite

Debugging strategies
  source("file name") to run code in R for errors
  traceback function prints the sequence of calls that led to the last error; shows where in your function sth is wrong
  loop function repeats function for as many times it takes to be TRUE

Bootstrap
Blow up population before taking bootstrap of data to eliminate effects of outliers b/c tail is too long
The variability of bootstrap is smaller when population blown up

Web Caching
  Cache500[[8]] #which day web updated
  length(Cache500[[8]]) #number of days updated
  diff(Cache500[[8]]) #legnth of time between each update
  If the # of events in a tgiven time interval is poisson (lambda), then the time between events is U(O, L)
  Comparing 2 distributions: have one dataset that you use to check against other distribtions
  Quantile-quantile plot (QQ-Plot) is better visual tool to see differences of distributions
  Kolmogorov-Smirnoff Test:
    Plot density function [f(x)] and empirical function [step function aka f_n(x)]
    Sup of difference of both functions gives the difference of y-values


