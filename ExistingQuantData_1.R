##install.packages('tidyverse')
##install.packages('epiDisplay')

library('tidyverse')
library('haven')
library('ggplot2')
library('epiDisplay')

setwd('/Users/temery/Desktop/ExistingQuantData')

ess6 <- read_dta('/Users/temery/Desktop/ExistingQuantData/ESS6.dta')

View(ess6)

## SO HOW MANY OBSERVATIONS DO WE HAVE?

nrow(ess6)

## CREATING A HISTOGRAM TO VIEW A CONTINUOUS VARIABLE [TRUST IN PEOPLE]
ggplot(ess6, aes(x = ppltrst)) +
  geom_histogram(bins = 11)

## IS THE MEASURE VALID? LETS SEE IF ITS CORRELATED WITH FAIRNESS
cor(ess6$ppltrst, ess6$pplfair)

## MAYBE A NICE HEATMAP WILL HELP US SEE THIS BETTER?
ggplot(ess6, aes(x = ppltrst, y = pplfair)) +
  geom_bin2d() +
  scale_fill_gradient(low = "white", high = "blue")

## MAYBE WE WANT TO COLLAPSE THE VARIABLE TRUST INTO A DICHOTOMOUS VARIABLE?
ess6$binary_ppltrst <- ifelse(ess6$ppltrst < 5, 0, 1)

## LETS SEE WHAT THESE THREE VARIABLES LOOK LIKE IN A SUMMARY TABLE?
summary(ess6[, c("ppltrst", "pplfair", "binary_ppltrst")])

## WHAT ABOUT CATEGORICAL VARIABLES LIKE EDUCATION (eisced)?

tab1(ess6$eisced, cum.percent = TRUE)