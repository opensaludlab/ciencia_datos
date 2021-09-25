## Bootcamp Data Science para el sector público de salud
## OpenSalud LAB

## Taller Estructura de datos


library(tidyverse)

# Vectores - Matrices - Listas - DataFrame



## Vectores ----

dbl_var <- c(1, 2.5, 4.5)

int_var <- c(1L, 6L, 10L)

.Machine$integer.max
.Machine$double.xmax

log_var <- c(TRUE, FALSE, T, F)

chr_var <- c("este es", "un mensaje")

typeof()

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
list_x[[1]]

list_x2 <- list("a" = 1:3,"b" = "a","c" = c(TRUE, FALSE, TRUE), "d" = c(2.3, 5.9))
names(list_x2)
list_x2$a
list_x2[["a"]]

recursive <- list(list(list(list())))
str(recursive)

mtcars
model <- lm(mpg ~ wt, data = mtcars)
is.list(model)
model$coefficients



## Matrices y Arrays ----

m <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
m

a <- array(1:12, c(2, 3, 2))
a

b <- 1:6
dim(b) <- c(3, 2)
dim(b) <- c(2, 3)



# Otras matrices
population2018 <- c(123, 345, 300)

population2019 <- c(100, 120, 30)

population <- matrix(c(population2018, population2019), nrow = 3, byrow = FALSE)

length(population)
dim(population)

colnames(population) <- c("Population2018", "Population2019")
rownames(population) <- c("Italy", "France", "Germany")


# Seleccionar por nombre
m["Italy", ]

m[, "Population2018"]

m[c("Italy", "Germany"), ]

m[, c("Population2018", "Population2019")]

m[1, ]

m[, 2]


# Expandiendo la matriz
m <- cbind(m, Population2020 = c(123, 23, 125))

m <- rbind(m, Spain = c(123, 200, 12))


# Algunas estadísticas
str(m)

rowSums(m)

enriched_m <- cbind(m, Total = rowSums(m))

colSums(m)

enriched_m <- rbind(m, Total = colSums(m))

mean(m)

mean(m[, 2])

max(m["Spain", ])

m/2
m*3
m[, 2] <- m[, 2]*2


# Encontrar el índice
which(m == max(m), arr.ind = TRUE)



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

sepal_length <- iris$Sepal.Length
class(sepal_length)
typeof(sepal_length)
str(sepal_length)
