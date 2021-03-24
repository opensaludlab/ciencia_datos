#### Academia OpenSALud LAB
#### Programa de formación en Ciencia de Datos para salud
#### www.opensaludlab.org


## Correlaciones

library(tidyverse)
library(corrr)
library(DataExplorer)
library(rpart)
library(rpart.plot)
library(readxl)
library(rattle)
library(caret)

# Revisemos algo en el dataset iris
iris <- iris

plot(iris)

model <- cor(iris$Petal.Length, iris$Petal.Width)
model

iris %>% 
  ggplot(aes(Petal.Length, Petal.Width)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) #Acá utilizamos un modelo de regresión lineal 

cor <- iris %>% 
  select_if(is.numeric) %>% 
  correlate()

cor_pares <- cor %>% stretch()

cor_pares <- cor_pares %>% mutate(r2 = r * r)


## Correlaciones en dataset heart

# Metadatos base heart_disease https://archive.ics.uci.edu/ml/datasets/heart+disease

heart_disease <- read.csv("https://raw.githubusercontent.com/opensaludlab/ciencia_datos/main/modulo4/heart.csv")
heart_disease <- rename(heart_disease, "age" = "ï..age")
heart_disease2 <- heart_disease %>%
  mutate(target = ifelse(target == 0, "no", "yes"))

heart_num <- heart_disease2 %>% select_if(is.numeric)

heart_cor <- correlate(heart_num)


### Ok, ahora vamos a lo que vinimos. Veamos los modelos de clasificación 
## Árboles de decisión

tenis <- read.csv("https://raw.githubusercontent.com/opensaludlab/ciencia_datos/main/modulo4/tennis.csv")
tenis_tree <- rpart(formula = jugar_tenis ~.,
      data = tenis,
      method = "class",
      control = rpart.control(
        cp = 0.001,
        minbucket = 2
        )
      )

rpart.plot(x = tenis_tree, yesno = 2, type = 5, extra = 106, fallen.leaves = TRUE)
fancyRpartPlot(tenis_tree)
asRules(tenis_tree)


salud <- read_excel("modulo4/salud.xlsx")

salud_tree <- rpart(formula = SEXO ~ ., 
               data = salud, 
               method = "class",
               control = rpart.control(
                 cp = 0.001,
                 minbucket = 40
                 )
               )

rpart.plot(x = salud_tree, yesno = 2, type = 5, extra = 106, fallen.leaves = TRUE)
asRules(salud_tree)
fancyRpartPlot(salud_tree)



####  Usemos nuevamente la base de heart disease para clasificar, pero esta vez entremos el modelo


heart_disease <- read.csv("https://raw.githubusercontent.com/opensaludlab/ciencia_datos/main/modulo4/heart.csv")

heart_disease <- rename(heart_disease, "age" = "ï..age")
heart_disease <- heart_disease %>% 
  mutate(target = ifelse(target == 0, "no", "yes"))

# Ajustar las variables
heart_disease$target <- as.factor(heart_disease$target)

heart_disease <- heart_disease %>% mutate(across(.cols = c("sex", "cp", "fbs", "restecg", "exang", "slope", "ca", "thal"),
                                .fns = factor))


# Generar particiones para entrenamiento y testeo
set.seed(1234)
index <- createDataPartition(heart_disease$target, list = FALSE, p = 0.8)
heart_train <- heart_disease[index, ]
heart_test <- heart_disease[-index, ]


# Veamos si los samples están balanceados
heart_disease$target %>% table()
heart_train$target %>% table()
heart_test$target %>% table()


# Cross-validation
# Este fit aplica para todos los próximos modelos
fitControl <- trainControl(method = "repeatedcv", number = 10, repeats = 10)
?trainControl



# Rpart Árboles de decisión
set.seed(1234)
class1 <- train(target ~ ., data = heart_train, method = "rpart", trControl = fitControl)
class1$results
class1$bestTune
class1$finalModel
class1$resample

postResample(pred = predict(class1, heart_train), obs = heart_train$target)
postResample(pred = predict(class1, heart_test), obs = heart_test$target)

confusionMatrix(data = predict(class1, heart_train), reference = heart_train$target)
confusionMatrix(data = predict(class1, heart_test), reference = heart_test$target)


plot(varImp(class1))
plot(class1)
rpart.plot(class1$finalModel, yesno = 2, type = 5, extra = 106, fallen.leaves = TRUE)
asRules(class1$finalModel)



# Cómo controlar el CP (complexity parameter)?
rpartGrid <- expand.grid(cp = seq(0.01, 1, by = 0.01))
model <- train(target ~ ., data = heart_train, method = "rpart", trControl = fitControl, 
                tuneGrid = rpartGrid)
model$bestTune

plot(model)
model$finalModel
asRules(model$finalModel)
rpart.plot(model$finalModel)
fancyRpartPlot(model$finalModel)
plot(varImp(model))


# Pero podemos hacer otros ajustes en el árbol de decisión

heart_tree <- rpart(formula = target ~.,
                    data = heart_disease,
                    method = "class",
                    control = rpart.control(
                      cp = 0.001, # Prueba con distintos valores de cp
                      minbucket = 20) # Prueba con distintos valores
                    )

rpart.plot(x = heart_tree, yesno = 2, type = 5, extra = 106, fallen.leaves = TRUE)



## Random Forest
set.seed(1234)
class2 <- train(target ~ ., data = heart_train, method = "rf", trControl = fitControl)
plot(class2)
class2$results
class2$bestTune
class2$finalModel
class2$resample


postResample(pred = predict(class2, heart_train), obs = heart_train$target)
postResample(pred = predict(class2, heart_test), obs = heart_test$target)

confusionMatrix(data = predict(class2, heart_train), reference = heart_train$target)
confusionMatrix(data = predict(class2, heart_test), reference = heart_test$target)

plot(varImp(class2))
plot(class2)



# GBM Gradient Boosting 
set.seed(1234)
class3 <- train(target ~ ., data = heart_train, method = "gbm", trControl = fitControl)
plot(class3)
class3$results
class3$bestTune
class3$finalModel

postResample(pred = predict(class3, heart_train), obs = heart_train$target)
postResample(pred = predict(class3, heart_test), obs = heart_test$target)

confusionMatrix(data = predict(class3, heart_train), reference = heart_train$target)
confusionMatrix(data = predict(class3, heart_test), reference = heart_test$target)



# Comparar modelos

postResample(pred = predict(class1, heart_test), obs = heart_test$target)
postResample(pred = predict(class2, heart_test), obs = heart_test$target)
postResample(pred = predict(class3, heart_test), obs = heart_test$target)


comp <- resamples(list(Rpart = class1, RF = class2, GBM = class3))
summary(comp)
bwplot(comp)
dotplot(comp)

diffs <- diff(comp)
summary(diffs)
bwplot(diffs)
dotplot(diffs)



# Podemos agregar la variable predicha al dataset
# Modelo RF

mod_rf <- heart_test %>% 
  mutate(predicted = predict(class2, heart_test))

mod_rf2 <- heart_test %>% 
  mutate(predicted = predict(class2, heart_test, type = "prob"))

