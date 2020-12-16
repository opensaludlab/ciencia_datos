## Academia OpenSAlud LAB
## Ciencia de Datos para el sectro público de salud
## Sesión importar datos

#### ARCHIVO AUN EN DESARRLLO ####


# Cargar librerías --------------------------------------------------------
library(tidyverse)
library(haven)

# Cargar datos ------------------------------------------------------------

# Encuesta nacional de salud 2017
# La encuesta se puede encontrar en http://epi.minsal.cl/bases-de-datos/
ens <- read_sav("data/ENS_2017.sav") # SPSS
View(ens)

# Desde un repositorio
covid <- read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv", encoding = "UTF-8")

# Desde Excel


# Desde un CSV


# Desde ...


  
  
  