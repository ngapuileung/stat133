# Homework 6
# Stat 133, Lec 2, Spring 2015
# Due : Friday March 20th by 5 pm

# Review the slides on simulations for this assignment.

# Consider the following model on use of a new drug:
# We have a population of doctors, population size : <n.doctors>
# Every doctor has either adopted the use of a new drug, or not (0/1 status)
# Now write a function that runs a simulation for a period of :
# <n.days> where
# - every day exactly two _random_ doctors meet
# - if one has adopted but the other one has not then the
#   holdout adopts the use of the drug with probability p
# Return a matrix that shows for each day which doctors have adopted
# the use of the drug.

# Input variables are
# <n.days> : the number of days the simulation should be run for
# <n.doctors> : total number of doctors 
# <initial.doctors> : a 0/1 vector of length <n.doctors>, 1 for adopters
# <p> : the probability that the non-adopter adopts the drug.

# Ouput variable
# <has_adopted> : matrix with <n.doctors> rows and <n.days> columns
#                 i.e. one row for each doctor
#                 the entries are 0 for days where the doctor is a
#                 non-adopter, else 1 (so once a row turns to 1 it stays as 1).

init.doc <- sample(0:1, size = n.doc, replace = TRUE, p = c(0.9, 0.1))

sim.doc <- function(initial.doctors, n.doctors, n.days, p){
    
    # Set up the output variable, define it as a matrix then use initial.doctors
    # to set the first column (day)
    
    # Run a simulation for <n.days> (use a for loop).  In the loop:
    # 1) pick two random doctors
    # 2) check if one has adopted the other hasn't
    # 3) convert the non-adopter with probability p
    # return the output
    
sim.doc <- function(initial.doctors, n.doctors, n.days, p) {
  vector.doc <- c()
  doc <- initial.doctors
  for (i in 1:n.days) {
    sample.doc <- sample(1:n.doctors, size = 2)
    doc1 <- doc[sample.doc[1]]
    doc2 <- doc[sample.doc[2]]
    if(doc1 == 1 & doc2 == 0){
      doc[sample.doc[2]] <- sample(0:1, 1, replace = FALSE, prob = c(1-p, p))
    }
    if(doc2 == 1 & doc1 == 0){
      doc[sample.doc[1]] <- sample(0:1, 1, replace = FALSE, prob = c(1-p, p))  
        }    
      }
  vector.doc <- c(doc, vector.doc)
  has_adopted <- matrix(vector.doc, nrow = n.doctors)
  return(has_adopted)
    }
  
  # When you test your function you have to generate <initial.doctors> and
  # pick values for the other input parameters.
  
  set.seed(42)
  # Generate a value for <initial.doctors> that has 10% 1s and 90% 0s.
  # Run your function for at least 5 different values of <p> and plot
  # on x-axis: days,
  # on y-axis : the number of doctors that have already adopted the drug, on that day
  # Put all 5 lines in one figure (e.g. use first plot() then lines() for the subsequent lines)

init.doc <- sample(0:1, size = 25, replace = TRUE, p = c(0.9, 0.1))

sim1 <- sim.doc(init.doc, 25, 50, 0.2)
sim2 <- sim.doc(init.doc, 25, 50, 0.3)
sim3 <- sim.doc(init.doc, 25, 50, 0.5)
sim4 <- sim.doc(init.doc, 25, 50, 0.7)
sim5 <- sim.doc(init.doc, 25, 50, 0.9)

plot(c(1:50), sim1, col = "red")
title(main = "Number of Doctors Adopting with Respect to Probability", xlab = "Days", ylab = "Number of Doctors")
lines(c(1:50), sim2, col = "orange")
lines(c(1:50), sim3, col = "yellow")
lines(c(1:50), sim4, col = "green")
lines(c(1:50), sim5, col = "blue")