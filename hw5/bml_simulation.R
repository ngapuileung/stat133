#################################################################################
#### BML Simulation Study

#### Put in this file the code to run the BML simulation study for a set of input parameters.
#### Save some of the output data into an R object and use save() to save it to disk for reference
#### when you write up your results.
#### The output can e.g. be how many steps the system took until it hit gridlock or
#### how many steps you observered before concluding that it is in a free flowing state.

#### Initialization function.

bml.init <- function(r, c, p){

  cars <- c("0", "1", "2")
  m <- matrix(sample(cars, size = r * c, replace = TRUE, prob = c(1-p, p/2, p/2)), nrow = r, ncol = c)
  return(m)
  
}


#### Function to move the system one step (east and north)

bml.step <- function(m){

  original_m <- m
  
  for (i in 1:nrow(m)){
  for (j in 1:ncol(m)){
    #move right
    if (m[i, j] == 1 && m[i + 1, j] == 0){m[i + 1, j] == 1
                                           m[i, j] == 0}
    if (m[i, j] == 1 && m[i + 1, j] != 0){m[i, j] == 1}
    #move up
    if (m[i, j] == 2 && m[i, j + 1] == 0){m[i, j + 1] == 2
                                           m[i, j] == 0
    if (m[i, j] == 2 && m[i, j + 1] != 0){m[i, j] == 2
    #over edge horizontal
    if (m[i, j] == 1 && m[i, 1] == 0 && j == ncol(m)){m[i, 1] == 1
                                                      m[i, j] == 0
    #over edge vertical
    if (m[i, j] == 2 && m[nrow(m), j] == 0 && i == 1){m[nrow(m), j] == 2
                                                       m[i, j] == 0}
  }}

  grid.new <- if(any(m != original_m)){grid.new = TRUE}
            else{grid.new = FALSE}
  
  return(list(m, grid.new))
}


#### Function to do a simulation for a given set of input parameters

bml.sim <- function(r, c, p){
  m = bml.init(r, c, p)
  image(t(apply(m, 2, rev)), axes = FALSE, col = c("white", "red", "blue"))
  for (i in 1:2000) {
    n = bml.step(m)
    if (n[[2]]) {
      m = n[[1]]
      image(t(apply(m, 2, rev)), axes = FALSE, col = c("white", "red", "blue"))}
    else {
      image(t(apply(m, 2, rev)), axes = FALSE, col = c("white", "red", "blue"))
      return (list(i, T))}
  }
  return (list(i, F))
}

#### Simulation Samples
source("bml_functions.r")

rep((bml.sim(10, 10, 0.1)), times = 5)
rep((bml.sim(50, 50, 0.1)), times = 5)
rep((bml.sim(100, 100, 0.1)), times = 5)

rep((bml.sim(10, 10, 0.4)), times = 5)
rep((bml.sim(50, 50, 0.4)), times = 5)
rep((bml.sim(100, 100, 0.4)), times = 5)

rep((bml.sim(10, 10, 0.6)), times = 5)
rep((bml.sim(50, 50, 0.6)), times = 5)
rep((bml.sim(100, 100, 0.6)), times = 5)

rep((bml.sim(10, 10, 0.9)), times = 5)
rep((bml.sim(50, 50, 0.9)), times = 5)
rep((bml.sim(100, 100, 0.9)), times = 5)