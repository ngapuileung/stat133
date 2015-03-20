# Our data is in a matrix format (this is what the
# return value from table() might look like

otCounty
#                        1992 1996 2000 2004 2008
#Majority.of.Democrats     43   37   29   21   23
#Majority.of.Republicans   15   21   29   37   35

# The barplot is fixed
barplot(otCounty, beside = TRUE)

# Let's now add color
barplot(otCounty, beside = TRUE, col=c("blue", "red"))

#Let's add labels and a legend
barplot(otCounty, beside = TRUE, col = c("blue", "red"), 
        xlab = "Election Year", ylab = "Number of counties", 
        main = "California Counties\n Registered Voters Majority Party", 
        legend.text = c("Democrat", "Republican"))

barplot(otCounty, beside = TRUE, col = c("blue", "red"), 
        xlab = "Election Year", ylab = "Number of counties", 
        main = "California Counties\n Registered Voters Majority Party", 
        legend.text = c("Democrat", "Republican"), args.legend = list(x = "bottomright"))

# We will now switch to registration data rather than county data
voters = read.csv(url("http://www.stat.berkeley.edu/users/nolan/data/CAVoters.csv"),
header = TRUE)


# Matplot allows us to superpose plots, we could also use plot() and lines()
matplot(voters$year, voters[,4:7])
matplot(voters$year, voters[,4:7], type = "l", lwd = 3)

# To fix the tick mark locations, we do not plot the x axis in the call to matplot
matplot(voters$year, voters[,4:7], type = "l", lwd = 3, xaxt = "n", xlab = "Year")
# Now we plot it with ticks at 1992, 1996, ... 2008
axis(1, at = seq(1992, 2008, 4))

# To add color, we create a vector of colors, and a vector of labels
partyColor = c(dem = "blue", rep= "red", other = "green", decline = "black")
party = c(dem = "Democrat", rep = "Republican", other = "Other", decline = "Decline to state")

matplot(voters$year, 100*voters[,4:7], 
        type = "l", lwd = 3, xaxt = "n", xlab = "Year", lty = 1, 
        col = partyColor[names(voters)[4:7]], ylab = "Percent", 
        main = "Party Affiliation of Registered Voters in California")
axis(1, at = seq(1992, 2008, 4))
legend(1992, 28, legend = party, fill = partyColor[names(party)])
