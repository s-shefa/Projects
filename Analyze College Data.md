### title: "Assignment 1"
### author: "Sumaiya Shefa"

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
```{r}
library(readr)
```

## Q.8
```{r}
college <- read.csv("College.csv")

rownames (college )=college [,1]
fix(college)
```
```{r}
college =college [,-1]
fix(college)
```
```{r}
summary(college)
```
```{r}
college$Private = as.factor(college$Private)
pairs(college[,1:10])
```
```{r}
attach(college)
Private = as.factor(Private)
boxplot(Outstate ~ Private, col="skyblue")
```
```{r}
Elite=rep("No",nrow(college))
Elite[college$Top10perc >50]=" Yes"
Elite=as.factor(Elite)
college=data.frame(college , Elite)
summary(Elite)
```
```{r}
boxplot(Outstate ~ Elite, col="lavenderblush3")
```
After exploring this data I noticed that not everyone that gets accepted enrolls in the college. Out of 777 people only 78 are elites.So chances of getting into the college even if they are not an elite is high.

## Q.9
```{r}
Auto <- read.csv("Auto.csv", header=T,na.strings="?")
Auto = na.omit(Auto)
```
The quantitative predictors in this data are mpg, cylinders, displacement, horsepower, weight, acceleration, year, and origin.The qualitative predictor is name.
```{r, message=FALSE}
attach(Auto)
Auto2 = Auto[,c(1:8)]
```
The range of each quantitative  predictor is:
```{r}
sapply(Auto2, range)
```
The mean of each quantitative  predictor is:
```{r}
sapply(Auto2, mean)
```
The standard deviation of each quantitative  predictor is:
```{r}
sapply(Auto2, sd)
```
```{r}
Auto3 = Auto2[-c(10:85),]
```
The range of each quantitative  predictor of the new data is:
```{r}
sapply(Auto3, range)
```
The mean of each quantitative  predictor of the new data is:
```{r}
sapply(Auto3, mean)
```
The standard deviation of each quantitative  predictor of the new data is:
```{r}
sapply(Auto3, sd)
```
```{r}
pairs(~., Auto2)
```
## Q.10

```{r}
library(MASS)
fix(Boston)
```
The Boston data frame has 506 rows and 14 columns.
This data frame contains the following columns:

crim =per capita crime rate by town.
zn = proportion of residential land zoned for lots over 25,000 sq.ft.
indus = proportion of non-retail business acres per town.
chas = Charles River dummy variable (= 1 if tract bounds river; 0 otherwise).
nox = nitrogen oxides concentration (parts per 10 million).
rm = average number of rooms per dwelling.
age = proportion of owner-occupied units built prior to 1940.
dis = weighted mean of distances to five Boston employment centers.
rad = index of accessibility to radial highways.
tax = full-value property-tax rate per \$10,000.
ptratio = pupil-teacher ratio by town.
black = 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town.
lstat = lower status of the population (percent).
medv = median value of owner-occupied homes in \$1000s.
```{r, message=FALSE}
attach(Boston)
pairs(~., Boston)
```
The range of each quantitative  predictor is:
```{r}
sapply(Boston, range)
```
The mean of each quantitative  predictor is:
```{r}
sapply(Boston, mean)
```
The median of each quantitative  predictor is:
```{r}
sapply(Boston, median)
```
```{r}
sum(chas)
```
35 suburbs in this data set bound the Charles river.
```{r}
median(ptratio)
```
The median pupil-teacher ratio among the towns in this data set is 19.05.

```{r}
Minimum= sapply(Boston, min)
Median=sapply(Boston, median)
data.frame(Minimum, Median)
```
```{r}
sum(rm>7)
```
64 suburbs average more than seven rooms per dwelling.
```{r}
sum(rm>8)
```
13 suburbs average more than seven rooms per dwelling.


