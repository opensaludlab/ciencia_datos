## Academia OpenSalud LAB
## Tipos de datos y operadores


# Tipo de datos -----------------------------------------------------------

# Vector

x = c(2,4,6,8)
y <- x + 8

data(uspop)
# Hacer un subseting vector
uspop[c(2, 5,7)]

x <- c(4,7,10, 13)
uspop[x]

# Dataframes

data("iris")

# Subseting de dataframe
iris["Species"]
iris$Species
iris[,3]
iris[, "Petal.Length"]
iris[2:5,c(1,5)] # Solo la primera especia
iris$Petal.Length

# Creemos un dataframe
nombres <- c("Paulo", "María", "Diego", "Marcela", "Soledad")
edades <- c(30, 22, 45, 19, 34)

curso <- data.frame(nombres, edades)
glimpse(curso)
str(curso)

## Una tabla de contigencia (untidy data)

data("HairEyeColor")
HairEyeColor[,,1]

# Tranformar la tabla de contingencia a tidydata
library(epitools)
library(knitr)
H <- expand.table(HairEyeColor)
kable(head(H))

# Listas

x <- list(rep('pepe', 3), 1:20)
x[[1]]
class(x[[1]])  # "character"
length(x[[1]]) # 3

x[[2]]
class(x[[2]])  # "integer"
length(x[[2]]) # 20

# is.list function 

a <- list(1, 2, 3)
b <- list(c("Jan", "Feb", "Mar")) 
c <- list(matrix(c(1, 2, 3, 4, 5))) 
d <- list(list("green", 12.3)) 

# Usando la función is.list()
is.list(a)
is.list(b) 
is.list(c) 
is.list(d) 

# Coerción ----------------------------------------------------------------

# Asignar tipo de dato
as.character(5)
as.logical(TRUE)
as.numeric("siete")

# Averiguar tipo de dato
class(iris)
class("academia")
is.logical(4)
is.character(4)

# Veamos el caso especial de los factores
as.factor(5)
as.factor("cinco")
factor_cinco <- as.factor("cinco")

# Coercionar de factor a character
as.character(factor_cinco)
as.numeric(factor_cinco)

# Cambio de tipo de datos
puntos = c("North", "South", "East", "East") 
puntos
puntos2 <- factor(puntos)
puntos2
as.numeric(puntos2)

# Creando un factor
metros <- factor(c(29, 28, 210, 28, 29))
levels(metros)

# Convertir factor a numeric
as.numeric(metros) #Mira la diferencia

metros2 <- as.numeric(as.character(metros))
str(metros2)

# Crear un vector
x <- c("female", "male", "male", "female") 

# Usar as.factor() para convertir vector a un factor 
as.factor(x)

# Convertir string a integer (strtoi function)

# Creemos un string vector 
x <- c("A", "B", "C")
y <- c("1", "2", "3") 

strtoi(x, 16L)
strtoi(y)


# Operadores --------------------------------------------------------------

# Aritméticos
5 * 3
6 + 4
8 - 5
7 / 3
5 %% 3 # Devuelve el residuo
4 %% 2
3 ^ 2
4 + "tres"
3 * NA
7 + NA

# Relacionales
5 > 4
4 == 4
"casa" != "perro"
"casa" > "auto" # Compara la posición alfabética de las letras
as.factor("casa") > "auto"

# Lógicos
# Todos los valores numéricos mayores a 0 son coercionados a TRUE, 0 es coercionado a FALSE
5 | 3
0 & 3
5 | 0
!(FALSE | FALSE)

# Orden de los operadores
5 * 3 + (4 ^ 2) + (FALSE | TRUE)
class(TRUE)
as.numeric(TRUE)
