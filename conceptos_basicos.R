## Academia OpenSalud LAB Ciencia de Datos


# Cargar librerias --------------------------------------------------------

library(tidyverse)
library(knitr)

# Cargar data -------------------------------------------------------------

data(iris)

# Aproximacion inicial a los datos ----------------------------------------

dim(iris) # n filas y columnas
str(iris)
names(iris)
head(iris)
tail(iris)
summary(iris)
glimpse(iris)
min(iris$Sepal.Length)
max(iris$Sepal.Length)
unique(iris$Species) # listar valores unicos
table(iris$Species) # conteo de variables


# Visualizaciones basicas -------------------------------------------------

# Ver algunas cosas de los datos

plot(iris)
hist(iris$Sepal.Length, 
     main = "Histogram Sepal Length",
     xlab = "Length (cms)",
     col = "red")

hist(iris$Sepal.Width, 
     main = "Histogram Sepal Width",
     xlab = "Width (cms)", 
     col = "blue")

iris %>% 
  group_by(Species) %>% 
  summarise(avg = mean(Sepal.Length)) %>% 
  arrange(avg)

iris %>%
  group_by(Species) %>%
  summarise(avg.sepal.width = mean(Sepal.Width), avg.sepal.length = mean(Sepal.Length)) %>%
  arrange(Species)

# Ver tipo de variables
data_frame(variable = names(iris)) %>% 
  mutate(class = map(iris, typeof)) %>% 
  kable()


# Formas de segmentar
setosa <- iris %>% 
  filter(Species == "setosa")
setosa2 <- iris[iris$Species == "setosa", ]


# Cambiar nombres de variables --------------------------------------------

#FORMA 1
colnames(setosa) <-  c("Largo.Sepalo", "Ancho.Sepalo", "Largo.Petalo", "Ancho.Petalo", "Especie")

#FORMA 2
colnames(setosa)[colnames(setosa)=="Largo.Sepalo"] <- "Largo2"

#FORMA 3
names(setosa)[3] <- "Petalo2"


# Separar campos

iris %>% 
  tidyr::pivot_longer(cols = -Species, names_to = c("part", "dimension"),
                      names_pattern = "(.*)\\.(.*)", values_to = "value")


# Graficos
plot(iris$Sepal.Length)
plot(iris$Sepal.Length, iris$Sepal.Width)
plot(iris$Sepal.Length, iris$Sepal.Width,col = iris$Species, pch = 19)
plot(iris$Petal.Length, iris$Petal.Width,
     col = iris$Species, pch = 19,
     xlab = 'Longitud del pétalo', ylab = 'Ancho del pétalo')
title(main = 'IRIS', sub = 'Exploración de los pétalos según especie',
      col.main = 'blue', col.sub = 'blue')
legend("bottomright", legend = levels(iris$Species),
       col = unique(iris$Species), ncol = 3, pch = 19, bty = "n")

boxplot(Petal.Length ~ Species, data = iris, notch = T,
        range = 1.25, width = c(1.0, 2.0, 2.0))

