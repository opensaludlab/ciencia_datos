## Bootcamp Data Science para el sector público de salud
## OpenSalud LAB

## Taller Estructura de datos

# install.packages("tidyverse")
library(tidyverse)

# Vectores - Matrices y Arrays - Listas - DataFrames



## Vectores ----

dbl_var <- c(1, 2.5, 4.5)

int_var <- c(1L, 6L, 10L)

.Machine$integer.max
.Machine$double.xmax

log_var <- c(TRUE, FALSE, T, F)

chr_var <- c("este es", "un mensaje")
chr_var2 <- c("1", "2", "3")

typeof(dbl_var)
typeof(int_var)
typeof(log_var)
typeof(chr_var)

# Vectores atómicos y coerción
str(c("a", 1))

x <- c(FALSE, FALSE, TRUE)

as.numeric(c(FALSE, FALSE, TRUE))

sum(x)



## Listas ----

list_x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(list_x)
is.list(list_x)
unlist(list_x)

str(list_x[1])
str(list_x[[1]])

# Formas de nombrar los elementos de las listas
list_x2 <- list(a = 1:3, b = "a", c = c(TRUE, FALSE, TRUE), d = c(2.3, 5.9))
names(list_x2)
list_x2$a
list_x2[["a"]]

list_x3 <- purrr::set_names(list_x[1:4], c("a", "b", "c", "d"))

# Listas recursivas
recursive <- list(list(list(list())))
str(recursive)
is.recursive(recursive)

# Ejemplo del uso de una lista
mtcars
model <- lm(mpg ~ wt, data = mtcars)
is.list(model)
model$residuals
plot(model$residuals)


## Matrices y Arrays ----

m <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, byrow = FALSE)
m

a <- array(1:12, c(2, 3, 2))
a

b <- 1:6
dim(b) <- c(3, 2)
dim(b) <- c(2, 3)


# Ejemplo de matrices
population2018 <- c(123, 345, 300)

population2019 <- c(100, 120, 30)

population <- matrix(c(population2018, population2019), nrow = 3, byrow = FALSE)

length(population)
dim(population)

colnames(population) <- c("Population2018", "Population2019")
rownames(population) <- c("Italy", "France", "Germany")


# Seleccionar por nombre
population["Italy", ]

population[, "Population2018"]

population[c("Italy", "Germany"), ]

population[, c("Population2018", "Population2019")]

# Seleccionar por índice
population[1, ]

population[, 2]


# Expandiendo la matriz
population <- cbind(population, Population2020 = c(123, 23, 125))

population <- rbind(population, Spain = c(123, 200, 12))


# Algunas estadísticas usando matrices
str(population)

rowSums(population)

enriched_m <- cbind(population, Total = rowSums(population))

colSums(population)

enriched_m <- rbind(population, Total = colSums(population))

mean(population)

mean(population[, 2])

max(population["Spain", ])

population / 2
population * 3
population[, 2] <- population[, 2] * 2
View(population)

# Encontrar el índice
which(population == max(population), arr.ind = TRUE)



## Data Frames ----

df <- data.frame(x = 1:3, y = c("a", "b", "c"))

str(df)
names(df)
rownames(df)
colnames(df)
length(df)
class(df)
is.data.frame(df)

# Subseting
df[, 1]
df[1:2, ]

df |> 
  select(x)


# Combinar dataframes
cbind(df, data.frame(z = 3:1))

rbind(df, data.frame(x = 10, y = "z"))

iris
str(iris)

# Subseting
sepal_length <- iris$Sepal.Length
class(sepal_length)
typeof(sepal_length)
str(sepal_length)
