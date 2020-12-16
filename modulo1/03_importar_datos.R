## Academia OpenSAlud LAB
## Ciencia de Datos para el sectro público de salud
## Sesión importar datos

################################
### ARCHIVO AUN EN DESARRLLO ###
################################

library(tidyverse)

# Desde SPSS
library(haven)

# Encuesta nacional de salud 2017 (http://epi.minsal.cl/bases-de-datos/)
ens <- read_sav("data/ENS_2017.sav") 
View(ens)

# Desde un repositorio en internet
covid <- read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv", encoding = "UTF-8")
View(covid)

# Desde Excel
library(readxl)

poblacion_comunas <- read_excel("data/poblacion_comunas.xlsx")
View(poblacion_comunas)


# Desde un CSV
# Es imporante fijarse en el tipo de separador
casos <- read.csv("data/casos_covid.csv")

# Desde datos espaciales
# En http://www.ide.cl/ se pueden encontrar datos geográficos de Chile
library(sf)
library(chilemapas)

help(package = "chilemapas")

comunas_rm <- mapa_comunas[mapa_comunas$codigo_region == 13, ]
ss_rm <- divisiones_salud %>% 
  filter(str_detect(nombre_servicio_salud, "Metropolitano"))

rm <- st_as_sf(comunas_rm) # Con esta función se puede trabajar como si fuera un data frame
ggplot() + 
  geom_sf(data = rm, aes(fill = codigo_comuna), show.legend = FALSE)


# Guardar datos -----------------------------------------------------------

  
  
  