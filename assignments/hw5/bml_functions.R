#################################################################################
#### Functions for BML Simulation Study


#### Initialization function.
## Input : size of grid [r and c] and density [p]
## Output : A matrix [m] with entries 0 (no cars) 1 (red cars) or 2 (blue cars)
## that stores the state of the system (i.e. location of red and blue cars)

bml.init <- function(r, c, p){

  cars <- c("0", "1", "2")
  m <- matrix(sample(cars, size = r * c, replace = TRUE, prob = c(1-p, p/2, p/2)), nrow = r, ncol = c)
  return(m)
  
}

#### Function to move the system one step (east and north)
## Input : a matrix [m] of the same type as the output from bml.init()
## Output : TWO variables, the updated [m] and a logical variable
## [grid.new] which should be TRUE if the system changed, FALSE otherwise.

## NOTE : the function should move the red cars once and the blue cars once,
## you can write extra functions that do just a step north or just a step east.

bml.step <- function(m){

  original_m <- m
  
  for (i in 1:nrow(m)){
  for (j in 1:ncol(m)){
    #move right
    if (m[i, j] == 1 & m[i + 1, j] == 0){m[i + 1, j] == 1
                                           m[i, j] == 0}
    if (m[i, j] == 1 & m[i + 1, j] != 0){m[i, j] == 1}
    #move up
    if (m[i, j] == 2 & m[i, j + 1] == 0){m[i, j + 1] == 2
                                           m[i, j] == 0
    if (m[i, j] == 2 & m[i, j + 1] != 0){m[i, j] == 2
    #over edge horizontal
    if (m[i, j] == 1 & m[i, 1] == 0 & j == ncol(m)){m[i, 1] == 1
                                                      m[i, j] == 0
    #over edge vertical
    if (m[i, j] == 2 & m[nrow(m), j] == 0 & i == 1){m[nrow(m), j] == 2
                                                       m[i, j] == 0}
  }}

  grid.new <- if(any(m != original_m)){grid.new = TRUE}
            else{grid.new = FALSE}
  
  return(list(m, grid.new))
}

#### Function to do a simulation for a given set of input parameters
## Input : size of grid [r and c] and density [p]
## Output : *up to you* (e.g. number of steps taken, did you hit gridlock, ...)

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
