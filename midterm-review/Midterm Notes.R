basic R subseting
plot
  histogram or scatter plot
  add red line
  add title
simple function
simulation: generate 5000 random numbers

Hank Ibser Webcasts:
  Youtube UCB
  Stat 133 Fall 2013
Phil Spector Notes

[[]] indicates vector
[] indicates matrix

for, while + if to create loops
replicate
apply
sapply
lapply: returns list
  replicate(1000, rnorm(1000)) #simple and does not depend on i
  for(i in 1000) x[, i] <- rnorm()
  apply mechanism allows you to do same operation to each element in list
    or each column or row in each matrix