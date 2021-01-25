#'---
#'title: "Introducción Limpieza de datos OpenLab Salud"
#'author: "Macarena Valenzuela Beltrán-Rladies Concepción"
#'date: "19 de enero 2021"
#'output: github_document
#'---

#'Instalación de librerías ------------------------------------------------


#'install.packages("tidyverse")# este es el comando para instalar paquetes
library(tidyverse)



#' Limpieza de datos ------------------------------------------------------



table1


#' **Función gather** ----------------------------------------------------------



#' veamos la tabla 4a

table4a

#'transformemos la tabla  en una tabla que contenga en forma limpia los casos

tablacasos <- table4a %>% 
  gather(`1999`, `2000`, key = "año", value = "casos")

#'imprimamos la tabla recien creada 

tablacasos

#'veamos la tabla 4a

table4b

#'transformemos la tablaa en una tabla que contenga en forma limpia los valores de la población

tablapoblacion <- table4b %>% 
  gather(`1999`, `2000`, key = "año", value = "poblacion")

#'imprimimos la tabla recién creada

tablapoblacion

#'unamoslas dos tablas recién credas

nuevatabla <- left_join(tablacasos,tablapoblacion)

#'obtención de una tabla de datos limpios

nuevatabla


#' **Función spread** ----------------------------------------------------------


#'veamos la tabla 2

table2

#'separamos la dos variables de la columna type

table2 %>% 
  spread(key = type, value = count) -> tablanueva2

#'imprimimos la tabla recién creada

tablanueva2


#' **Función separate()** ------------------------------------------------------


#'veamos la tabla 3

table3

#'separamos los valores de la columna rate

table3 %>% 
  separate(rate, into = c("cases", "population"))

#'creamos una nueva tabla con la nueva transformación de datos

tablanueva3 <- table3 %>% 
  separate(rate, into = c("cases", "population"))


#'imprimimos la nueva tabla creada 

tablanueva3


#' **Función unite()** --------------------------------------------------


#'veamos la tabla 5

table5

#'juntamos las columnas century y year en una nueva columna llamada new_year y omitimos el símbolo (_) creados entre los valres

table5 %>% 
  unite(new_year, century, year, sep = "") %>% 
  separate(rate, into = c("cases", "population"))

?unite

#'creamos una nueva tabla 

tabla5nueva <- table5 %>% 
  unite(new_year, century, year, sep = "") %>% 
  separate(rate, into = c("cases", "population"))

#'imprimimos la nueva tabla creada 

tabla5nueva
