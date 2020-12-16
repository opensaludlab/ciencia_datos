## Academia OpenSAlud LAB
## Ciencia de Datos para el sectro público de salud
## Sesión importar datos

################################
### ARCHIVO AUN EN DESARRLLO ###
################################


# Importar datos ----------------------------------------------------------
# R puede importar una gran cantidad de archivos. Pero revisaremos en más detalle los csv, excel y de repositorios.
# Esos tipos de archivos serán probablemente los que más te encuentres en tu día a día.

library(tidyverse)

## Desde un repositorio en internet
# Fíjate en el encoding
covid <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv")
View(covid)

covid2 <- read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv", encoding = "UTF-8")

# read_csv() viene por defecto con encoding UTF-8
positividad <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto65/PositividadPorComuna.csv")


## Desde Excel
library(readxl)

poblacion_comunas <- read_excel("data/poblacion_comunas.xlsx")
View(poblacion_comunas)

# Muchas veces se incluyen títulos o logos en los excel
# Con el argumento skip puedes omitir filas superiores
poblacion_comunas2 <- read_excel("data/poblacion_comunas2.xlsx", skip = 3)

# No siempre los Excel tienen un formato limpio
# Tienen columnas y filas vacias o con títulos que no sirven para analizar los datos
poblacion_comunas3 <- read_excel("data/poblacion_comunas3.xlsx", 
                                 range = "D6:F368")


## Desde un CSV

library(readr)
# Es imporante fijarse en el tipo de separador
# Cheat sheet Readr https://github.com/rstudio/cheatsheets/blob/master/data-import.pdf
# No confundir read_csv con read.csv / Son de librerías distintas. read_csv es de readr()
casos <- read_csv("data/casos_covid.csv")

casos2 <- read_csv("data/casos_covid.csv", col_types = cols( # Especificar el tipo de variable
  Comuna = col_factor(),
  Region = col_factor())
  )

# A veces, el archivo csv puede que no tenga encabezados de las variables
# Creemos un archivo de ejemplo
casos3 <- read_csv("data/casos_covid.csv", skip = 1)
write_csv(casos3, "data/casos_covid_sin_nombres.csv")
# Observa como se ve si abrimos este archivo
casos4 <- read_csv("data/casos_covid_sin_nombres.csv")
View(casos4)

# Podemos arreglar eso de 2 formas
read_csv("data/casos_covid_sin_nombres.csv", col_names = FALSE) # Poner nombres genéricos X1, X2, X3, ...
read_csv("data/casos_covid_sin_nombres.csv", col_names = c( # Agregar los nombres de las variables
  "Region",
  "Cod_region",
  "Comuna",
  "Cod_comuna",
  "Pobl",
  "Casos_conf")
  )

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


## Desde SPSS
library(haven)

# Veamos la Encuesta nacional de salud 2017 (http://epi.minsal.cl/bases-de-datos/)
# Primero debes descargar el archivo comprimido y extraer el archivo .sav
ens <- read_sav("data/ENS_2017.sav") 
View(ens)


## Desde una página web (Web scraping)
# Ejemplo tomado de https://www.datanalytics.com/libro_r/web-scraping.html 
library(rvest)
url.ibex <- "http://www.bolsamadrid.es/esp/aspx/Mercados/Precios.aspx?indice=ESI100000000"
tmp <- read_html(url.ibex)
tmp <- html_nodes(tmp, "table")
ibex <- html_table(tmp[[5]])


# En R también se puede hacer scraping de un PDF o una imagen.

# Guardar datos -----------------------------------------------------------

write_csv(iris, "data_clean/iris.csv")

install.packages("writexl")
library(writexl)
write_xlsx(iris, "data_clean/iris.xlsx")


# Manejo de NA ------------------------------------------------------------

# Los NA´s no permiten hacer operaciones matemáticas ni muchas otras cosas
pob <- read_excel("data/poblacion_comunas_NA.xlsx")

pob %>% group_by(Region) %>% 
  summarise(Pob_total = sum(Habitantes)) # Fíjate en la salida 

# Algunas Formas de manejar NA
summary(pob)
table(is.na(pob)) # Conteo total
sapply(pob, function(x) sum(is.na(x))) # Ver por columna
rowSums(is.na(pob)) # Por fila

pob %>% na.omit()

pob %>% group_by(Region) %>% 
  summarise(Pob_total = sum(Habitantes, na.rm = TRUE)) # No considerar NA en la operación

# Hay varias formas de trabajar con los NA´s o de imputar valores, pero eso lo veremos en otros módulos con más detalle


  