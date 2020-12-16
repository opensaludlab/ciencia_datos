# Academia OpenSalud LAB Ciencia de Datos
# Sesión inicial para revisar funcionalidades básicas de R y RStudio


# Formas de escribir nombres de variables u objetos
# Usa el que desees, pero se consistente con ello a lo largo del código.
comunas.santiago
comunasSantiago
comunas_santiago_oriente

# No iniciar con números o símbolos. Tampoco usar acentos ni espacios
# RStudio te mostrará errores en la sintaxis
03 <- "casa"
tipo casa <- "chilena"
%casas <- c(10, 20, 44)

tipo_casa <- "chilena" # Este nombre si sirve

# Cargar librerias --------------------------------------------------------

# Las librerías solo se instalan 1 vez (por computador). Para eso se usa install.packages()
install.packages("tidyverse")
install.packages("knitr")
# Para usar una librería, es necesario activarla usando la función library()
library(tidyverse) # Esta librería la usaremos mucho!!!
library(knitr)

# Cargar data -------------------------------------------------------------

data(iris) # iris es un dataset que viene incluído por defecto en R
View(iris)

# Aproximación inicial a los datos ----------------------------------------

dim(iris) # n filas y columnas
str(iris) # Ver la estructura de los datos
names(iris) # Para ver los nombres de las variables
head(iris, 3) # Puedes indicarle a head() el n° de observaciones ue quieres ver. Por defecto muestra las primeras 6
tail(iris) # Con tail() puedes ver las últimas ovservaciones 
summary(iris) # Análisis con estadígrafos básicos para variables numéricas
glimpse(iris)
min(iris$Sepal.Length) # seleccionar una variable con $
max(iris$Sepal.Length)
unique(iris$Species) # listar valores únicos
table(iris$Species) # conteo de variables

dim(Iris) # cuidado con las mayúsculas! 


# Buscar ayuda ------------------------------------------------------------

?glimpse
example(colnames)
vignette(all = FALSE)
vignette(all = TRUE)
vignette("grid")

## Lo siguiente es solo para que puedas ver las cosas que se pueden hacer
## Las veremos en más detalles en los módulos posteriores

# Visualizaciones básicas -------------------------------------------------

# Ver algunas cosas de los datos (R base)

plot(iris)
hist(iris$Sepal.Length, 
     main = "Histogram Sepal Length",
     xlab = "Length (cms)",
     col = "red") # Se puede cambiar el color 

hist(iris$Sepal.Width, 
     main = "Histogram Sepal Width",
     xlab = "Width (cms)", 
     col = "blue")

# Usando uan de las librerías del tidyverse: dplyr
# Fíjate en el uso del pipe %>%. Se puede leer así como "dado lo anterior, ahora haz lo siguiente"
iris %>% 
  group_by(Species) %>% 
  summarise(avg = mean(Sepal.Length)) %>% 
  arrange(avg)


# Ver tipo de variables

data_frame(variable = names(iris)) %>% # Al usar data_frame() da un Warning. Cámbialo por tibble()
  mutate(class = map(iris, typeof)) %>% 
  kable()


# Formas de segmentar
# Fíjate en el uso de == para indicar equivalencia.
setosa <- iris %>% 
  filter(Species == "setosa")
setosa2 <- iris[iris$Species == "setosa", ] # Es lo mismo que lo anterior


# Cambiar nombres de variables --------------------------------------------

colnames(setosa)

# FORMA 1
colnames(setosa) <-  c("largo_sepalo", "ancho_sepalo", "largo_petalo", "ancho_petalo", "especie")

# FORMA 2
colnames(setosa)[colnames(setosa) == "largo_sepalo"] <- "Largo2"

# FORMA 3
names(setosa)[3] <- "Petalo2"


# Gráficos con R base
# Si bien no son tan lindos, son rápidos de generar y permiten obtener información de los datos
plot(iris$Sepal.Length)
plot(iris$Sepal.Length, iris$Sepal.Width)
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species, pch = 19) # Puedes usar otros plot character (pch)

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

## Ahora con ggplot2
# ggplot2 aporta mucha capacidad a las visualizaciones y permite gran personalización
# En el módulo de visualización y análisis exploratorio veremos más detalles de los gráficos

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

# Se puede guardar en un objeto un gráfico
p <- ggplot(iris, aes(x = Species, y = Sepal.Width)) + 
  geom_boxplot() + 
  geom_jitter(aes(color = Species)) # Cuidado con el orden de las capas. Intenta cambiando el orden de la línea 161 y 162
p

# Podríamos guardar algunas cosas

# Plots
# Una alternativa es usar la interfaz de RStudio "Export" o save image as
# Pero también podemos hacerlo con código

ggsave(p, filename = "boxplot_especies.png",
       width = 20,
       height = 15,
       units = "cm")

# Dataframe
# Crear un dataframe
edad <- c(2, 4, 67, 33, 2)
ciudad <- c("Santiago", "Talca", "Puerto Montt", "Santiago", "Arica")
df <- data.frame(edad, ciudad)

write.csv(df, "ciudades.csv", row.names = FALSE) # Averigua qué sucede si no se usa el argumento row.names

