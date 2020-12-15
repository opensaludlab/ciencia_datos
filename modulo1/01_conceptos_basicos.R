## Academia OpenSalud LAB Ciencia de Datos
## Sesión inicial para revisar funcionalidades básicas de R y RStudio

# Formas de escribir nombres de variables u objetos
comunas.santiago
comunasSantiago
comunas_santiago

# No iniciar con números o símbolos. Tampoco usar acentos ni espacios
03 <- "casa"
tipo casa <- "chilena"
%casas <- c(10, 20, 44)


# Cargar librerias --------------------------------------------------------
install.packages("tidyverse")
library(tidyverse)
library(knitr)

# Cargar data -------------------------------------------------------------

data(iris)
View(iris)

# Aproximación inicial a los datos ----------------------------------------

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

dim(Iris) # cuidado con las mayúsculas


# Visualizaciones basicas -------------------------------------------------

# Ver algunas cosas de los datos

plot(iris)
hist(iris$Sepal.Length, 
     main = "Histogram Sepal Length",
     xlab = "Length (cms)",
     col = "red") # Se puede cambiar el color 

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

tibble(variable = names(iris)) %>% # Al usar data_frame() da un warning
  mutate(class = map(iris, typeof)) %>% 
  kable()


# Formas de segmentar
setosa <- iris %>% 
  filter(Species == "setosa")
setosa2 <- iris[iris$Species == "setosa", ] # Es lo mismo que lo anterior


# Cambiar nombres de variables --------------------------------------------
colnames(setosa)

#FORMA 1
colnames(setosa) <-  c("largo_sepalo", "ancho_sepalo", "largo_petalo", "ancho_petalo", "especie")

#FORMA 2
colnames(setosa)[colnames(setosa) == "largo_sepalo"] <- "Largo2"

#FORMA 3
names(setosa)[3] <- "Petalo2"


# Transformar a tidy data con pivot_longer()

iris %>% 
  tidyr::pivot_longer(cols = -Species, 
                      names_to = "Type",
                      values_to = "value")

# Separar campos
iris %>% 
  tidyr::pivot_longer(cols = -Species, 
                      names_to = c("part", "dimension"),
                      names_pattern = "(.*)\\.(.*)", # Expresión regular
                      values_to = "value")


# Gráficos con R base
plot(iris$Sepal.Length)
plot(iris$Sepal.Length, iris$Sepal.Width)
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species, pch = 19) # Ver otros plot character (pch)

plot(iris$Petal.Length, iris$Petal.Width,
     col = iris$Species, 
     pch = 17,
     xlab = 'Longitud del pétalo', 
     ylab = 'Ancho del pétalo')
title(main = 'IRIS', 
      sub = 'Exploración de los pétalos según especie',
      col.main = 'blue', 
      col.sub = 'blue')
legend("bottomright", 
       legend = levels(iris$Species),
       col = unique(iris$Species), 
       ncol = 3, 
       pch = 19, 
       bty = "n")

boxplot(Petal.Length ~ Species, 
        data = iris, 
        notch = T)


# Ahora con ggplot
ggplot(iris, aes(x = Species, y = Sepal.Width)) +
  geom_boxplot(notch = T, aes(fill = Species)) +
  scale_fill_manual(name = "Especie", values = c('#a6cee3','#1f78b4','#b2df8a'))

ggplot(iris, aes(x = Species, y = Sepal.Width)) +
  geom_boxplot(notch = T, aes(fill = Species)) +
  scale_fill_viridis_d(name = "Especie")

ggplot(iris, aes(x = Species, y = Sepal.Width)) + 
  geom_jitter(aes(shape = Species))

ggplot(iris, aes(x = Species, y = Sepal.Width)) + 
  geom_violin(fill = '#a6cee3') + 
  coord_flip()

p <- ggplot(iris, aes(x = Species, y = Sepal.Width)) + 
  geom_boxplot() + 
  geom_jitter(aes(color = Species)) # Cuidado con el orden de las capas

# Podríamos guardar algunas cosas

# Plots
# Una alternativa es usar la interfaz de RStudio "Export" o save image as
# También podemos hacerlo con código

ggsave(p, filename = "boxplot_especies.png",
       width = 20,
       height = 15,
       units = "cm")

# Dataframe

edad <- c(2, 4, 67, 33, 2)
ciudad <- c("Santiago", "Talca", "Puerto Montt", "Santiago", "Arica")

df <- data.frame(edad, ciudad)
write.csv(df, "ciudades.csv", row.names = FALSE) 

