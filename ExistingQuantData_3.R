##install.packages('tidyverse')
##install.packages('epiDisplay')
##install.packages('gridExtra')

library('tidyverse')
library('haven')
library('ggplot2')
library('epiDisplay')
library('gridExtra')

setwd('/Users/temery/Desktop/ExistingQuantData')

ess6 <- read_dta('/Users/temery/Desktop/ExistingQuantData/ESS6.dta')

ess6 <- na.omit(model_data)

# RECODE ISCED INTO 3 CATEGORIES USING CUT function
ess6$edu <- cut(ess6$eisced, breaks = c(-0.1, 2.9, 5.9, 7), labels = c("low education", "medium education", "high education"))

## NOW LETS RUN A REGRESSION

ols_model_1 <- lm(ppltrst ~ gndr + edu, data = ess6)

summary(ols_model_1)

## NOW WITH AN INTERACTION EFFECT

ols_model_2 <- lm(ppltrst ~ gndr * edu, data = ess6)

summary(ols_model_2)


## NOW LETS LOOK AT SOME PREDICTED VALUES 

pred_df <- expand.grid(gndr = unique(ess6$gndr),
                       edu = unique(ess6$edu))

# Add a column for predicted values
pred_df$pred_ppltrst <- predict(ols_model_2, newdata = pred_df, type = "response")

# Plot predicted values over interaction effects
ggplot(pred_df, aes(x = gndr, y = pred_ppltrst, color = factor(edu))) +
  geom_point(size = 3) +
  geom_line(aes(group = edu), size = 1) +
  labs(x = "Gender", y = "Predicted Trust", title = "Predicted Trust by Gender and Education") +
  scale_color_discrete(name = "Education") +
  theme_minimal() +
  ylim(0, 10)
