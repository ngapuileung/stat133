iris
summary(iris)
names(iris)
iris.sub<-subset(iris, Sepal.Length >5) #subset of row
iris.sub1<-subset(iris, select = Sepal.width) #subset of column
x<-rnorm(100)
hist(x)
y<-seq(1:100)
plot(y, x)
plot(x, y)
attach(mtcars)
plot(wt, mpg, main="Scatterplot Example"),
  xlab="Car Weight", ylab="Miles Per Gallon", pch=19
