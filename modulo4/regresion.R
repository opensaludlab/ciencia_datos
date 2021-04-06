library(tidyverse)
library(caret)
library(broom)


# Partamos por algo simple

cars <- mtcars
plot(cars[, c(1:7)])

cars_cor <- cars %>%
  select_if(is.numeric) %>%
  cor()

corrplot::corrplot(cars_cor)

cars %>% ggplot(aes(wt, mpg)) +
  geom_point()

# Modelo lm
model <- lm(formula = mpg ~ wt, data = cars)
model
summary(model)
broom::glance(model)

plot(model)

pred <- predict(object = model , newdata = cars)

cars <- cars %>% mutate(pred = pred)

cars %>% ggplot(aes(wt, mpg)) +
  geom_point() +
  geom_point(aes(y = pred), color = "red")
  #geom_line(aes(y = pred), color = "red")

cars %>% ggplot(aes(wt, mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

cars %>% ggplot(aes(wt, mpg)) +
  geom_point() +
  geom_abline(intercept = 37.285, slope = -5.344)

# Podemos crear una función
pred_mpg <- function(x){
  
  37.285 - 5.344 * x
  
}

pred_mpg(2.620)


## Veamos algo más sobre aprendizaje supervisado (regresión)

# Puedes ver mas del dataset en https://github.com/allisonhorst/palmerpenguins 
# Vamos a tratar de predecir el peso (body_mass_g) de los pinguinos

library(palmerpenguins)
penguins <- palmerpenguins::penguins


# Análisis inicial EDA
summary(penguins)
glimpse(penguins)
str(penguins)
skimr::skim(penguins)

penguins <- penguins %>% na.omit()


penguins %>% 
  group_by(species) %>% 
  summarize(across(where(is.numeric), mean)) %>% 
  ungroup()

penguins %>%
  count(species) %>%
  ggplot() + 
  geom_col(aes(species, n, fill = species)) +
  geom_label(aes(species, n, label = n)) +
  theme_minimal() 

penguins %>%
  count(sex, species) %>%
  ggplot() + 
  geom_col(aes(species, n, fill = species)) +
  geom_label(aes(species, n, label = n)) +
  theme_minimal() +
  facet_wrap(~ sex)


# Revisemos si hay outliers
library(extremevalues)

C <- getOutliers(penguins$body_mass_g)
C$nOut
outlierPlot(penguins$body_mass_g, C)


# Matriz de correlación 
cor <- penguins %>%
  select_if(is.numeric) %>%
  cor()

corrplot::corrplot(cor)

# Veamos unas gráficas para analizar el peso
penguins %>% ggplot(aes(flipper_length_mm, body_mass_g)) +
  geom_jitter(aes(color = species, shape = species), size = 3, alpha = 0.7) +
  theme_minimal()

penguins %>% ggplot(aes(body_mass_g, ..density..)) + 
  geom_freqpoly(aes(colour = species), binwidth = 100) +
  theme_minimal()

penguins %>% ggplot(aes(species, body_mass_g)) +
  geom_boxplot()



# Separamos la data en train y test
set.seed(123)
index <- createDataPartition(penguins$body_mass_g, list = FALSE, p = 0.8)
penguins_train <- penguins[index, ]
penguins_test <- penguins[-index, ]


# Revisemos que las particiones estén balanceadas
penguins %>% group_by(species) %>%
  summarise(n = n()) %>% 
  mutate(prop = n / sum(n) * 100)

penguins_train %>% group_by(species) %>%
  summarise(n = n()) %>% 
  mutate(prop = n / sum(n) * 100)

penguins_test %>% group_by(species) %>%
  summarise(n = n()) %>% 
  mutate(prop = n / sum(n) * 100)



# Resampleo con cross-validation
set.seed(1234)
fitControl <- trainControl(method = "repeatedcv", number = 10, repeats = 10)


# Creemos distintos modelos
set.seed(2345)

# Modelo lineal LM
model_lm <- train(body_mass_g ~ ., data = penguins_train, method = "lm", trControl = fitControl)
model_lm
plot(varImp(model_lm))

# Modelo de RF
model_rf <- train(body_mass_g ~ ., data = penguins_train, method = "rf", trControl = fitControl)
model_rf
plot(varImp(model_rf))

# Modelo de GBM
model_gbm <- train(body_mass_g ~ ., data = penguins_train, method = "gbm", trControl = fitControl)
model_gbm


# Hagamos las predicciones y calculemos algunas métricas

postResample(pred = predict(model_lm, penguins_train), obs = penguins_train$body_mass_g)
postResample(pred = predict(model_rf, penguins_train), obs = penguins_train$body_mass_g)
postResample(pred = predict(model_gbm, penguins_train), obs = penguins_train$body_mass_g)


# Veamos en el dataset las predicciones
penguins_train_rf <- penguins_train %>% 
  select(body_mass_g) %>% 
  mutate(predicted = predict(model_rf, penguins_train),
         error = body_mass_g - predicted)


# Revisemos algunos supuestos: normalidad de residuos y homocedastacidad de la varianza
hist(penguins_train_rf$error)
mean(penguins_train_rf$error)
plot(penguins_train_rf$error)
qqnorm(penguins_train_rf$error)


# Apliquemos los modelos en test
postResample(pred = predict(model_lm, penguins_test), obs = penguins_test$body_mass_g)
postResample(pred = predict(model_rf, penguins_test), obs = penguins_test$body_mass_g)
postResample(pred = predict(model_gbm, penguins_test), obs = penguins_test$body_mass_g)



# Veamos en un gráfico las predicciones y su linealidad

# Modelo lm
penguins_test_lm <- penguins_test %>% 
  select(body_mass_g) %>% 
  mutate(predicted = predict(model_lm, penguins_test),
         error = body_mass_g - predicted)


max_val_lm <- max(penguins_test_lm$body_mass_g, penguins_test_lm$predicted)
penguins_test_lm %>% ggplot(aes(body_mass_g, predicted)) +
  geom_point() +
  geom_abline() +
  xlim(c(0, max_val_lm)) + 
  ylim(c(0, max_val_lm))


# Modelo RF
penguins_test_rf <- penguins_test %>% 
  select(body_mass_g) %>% 
  mutate(predicted = predict(model_rf, penguins_test),
         error = body_mass_g - predicted)


max_val_rf <- max(penguins_test_rf$body_mass_g, penguins_test_rf$predicted)
penguins_test_rf %>% ggplot(aes(body_mass_g, predicted)) +
  geom_point() +
  geom_abline() +
  xlim(c(0, max_val_rf)) + 
  ylim(c(0, max_val_rf))


# Modelo GBM
penguins_test_gbm <- penguins_test %>% 
  select(body_mass_g) %>% 
  mutate(predicted = predict(model_gbm, penguins_test),
         error = body_mass_g - predicted)


max_val_gbm <- max(penguins_test_gbm$body_mass_g, penguins_test_gbm$predicted)
penguins_test_gbm %>% ggplot(aes(body_mass_g, predicted)) +
  geom_point() +
  geom_abline() +
  xlim(c(0, max_val_gbm)) + 
  ylim(c(0, max_val_gbm))

