## Academia OpenSalud LAB
## Ciencia de Datos para el sector público de salud
## Sesión importar datos
## Autor: Paulo Villarroel


library(tidyverse)

# Importar datos ----------------------------------------------------------
# R puede importar una gran cantidad de archivos. Pero revisaremos en más detalle los csv, excel y de repositorios.
# Esos tipos de archivos serán probablemente los que más te encuentres en tu día a día.


## Desde un CSV

# library(readr) 
# Es imporante fijarse en el tipo de separador
# Cheat sheet Readr https://github.com/rstudio/cheatsheets/blob/master/data-import.pdf
# No confundir read_csv con read.csv / Son de librerías distintas. read_csv es de readr()

casos <- read_csv("data/casos_totales.csv")
read.table("data/casos_totales.csv", header = TRUE, sep = ",") # Fíjate en los acentos
read_csv(file.choose()) # Solo para ejemplo

casos2 <- read_csv("data/casos_totales.csv", col_types = cols( # Especificar el tipo de variable
  Comuna = col_factor(),
  Region = col_factor())
)

# A veces, el archivo csv puede que no tenga encabezados de las variables
# Observa como se ve si abrimos este archivo
casos3 <- read_csv("data/casos_covid_sin_header.csv")
View(casos3)

# Podemos arreglar eso de 2 formas
read_csv("data/casos_covid_sin_header.csv", col_names = FALSE) # Poner nombres genéricos X1, X2, X3, ...
read_csv("data/casos_covid_sin_header.csv", col_names = c( # Agregar manualmente los nombres de las variables
  "Region",
  "Cod_region",
  "Comuna",
  "Cod_comuna",
  "Pobl",
  "Fecha",
  "Casos_conf")
)


## Desde Excel
library(readxl)

# Truco poco estético, pero útil. Copiar desde Excel (solo en casos muy puntuales)
df <- read.table(file = "clipboard", sep = "\t", header = TRUE)

# Usando la ruta del archivo. Puedes ayudarte de getwd()
read_csv("C:/Users/pvill/OneDrive/Proyectos R/ciencia_datos/data/casos_totales.csv")

poblacion_comunas <- read_excel("data/poblacion_comunas.xlsx") # Esto facilita la reproducibilidad
View(poblacion_comunas)

# Muchas veces se incluyen títulos o logos en los excel
# Con el argumento skip puedes omitir filas superiores
poblacion_comunas2 <- read_excel("data/poblacion_comunas2.xlsx", skip = 6)

# No siempre los Excel tienen un formato limpio
# Tienen columnas y filas vacias o con títulos que no sirven para analizar los datos
poblacion_comunas3 <- read_excel("data/poblacion_comunas3.xlsx", 
                                 range = "D6:F368")

read_excel(file.choose(), sheet = "pob") # Solo para casos puntuales
read_excel(file.choose(), sheet = 1)

# Para importar varias hojas de Excel de forma simultanea
# Usaremos la función set_names() y map() de la librería PURRR (tidyverse)
path <- "data/indice_movilidad.xlsx"
path %>% excel_sheets()
movilidad <- path %>%
  excel_sheets() %>%
  set_names() %>%
  map_df(read_excel, # map_dfc para unir por columnas
      path = path,
      .id = "IM") # Esto agrega una nueva columna con el nombre de las hojas


# Con la librería "datapasta" se pueden hacer cosas interesantes de forma rápida
# Anda a https://cran.r-project.org/web/packages/datapasta/vignettes/how-to-datapasta.html y copia la tabla

library(datapasta)
# Para tablas en html
tribble_paste()


vector_paste()


unique(casos$Region) %>% dpasta()



## Desde un repositorio en internet

covid <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv")
View(covid)
# Fíjate en el encoding
covid2 <- read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv", encoding = "UTF-8")

# read_csv() viene por defecto con encoding UTF-8
positividad <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto55/Positividad_por_comuna.csv")


# Hagamos algo rápido ;)

library(plotly)

rm <- positividad %>% 
  filter(Region == "Metropolitana") %>% 
  mutate(positividad = round(positividad * 100, 1))

p <- ggplot(rm, aes(fecha, positividad, color = Comuna)) +
  geom_path(size = rel(0.2)) +
  labs(title = "Positividad test PCR COVID-19. Región Metropolitana",
       x = "",
       y = "Positividad (%)") +
  theme_classic() +
  theme(legend.position = "none") +
  scale_colour_grey()

ggplotly(p)


# Desde datos espaciales
# En http://www.ide.cl/ se pueden encontrar datos geográficos de Chile
library(sf)
library(chilemapas)

# Revisa la documentación para que veas todo lo que incluye esta librería
help(package = "chilemapas")

comunas_rm <- mapa_comunas[mapa_comunas$codigo_region == 13, ]
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


# En R también se puede hacer scraping de un PDF, una imagen y muchos otros formatos. Investígalos!


# Guardar datos -----------------------------------------------------------

write_csv(iris, "data_clean/iris.csv")

install.packages("writexl")
library(writexl)
write_xlsx(iris, "data_clean/iris.xlsx")


# Manejo de NA ------------------------------------------------------------

# Los NA´s no permiten hacer operaciones matemáticas ni muchas otras cosas
# Hay varias formas de trabajar con los NA o de imputar valores, pero eso lo veremos en otros módulos con más detalle

pob <- read_excel("data/poblacion_comunas_NA.xlsx")

pob %>% 
  group_by(Region) %>% 
  summarise(Pob_total = sum(Habitantes)) # Fíjate en la salida 

# Algunas Formas de identificar si hay NA en el dataset
is.na(pob)
table(is.na(pob)) # Conteo total
summary(pob)
sapply(pob, function(x) sum(is.na(x))) # Ver por columna
rowSums(is.na(pob)) # Por fila

# Un par de formas de manjar NA´s
pob %>% na.omit()

pob %>% 
  group_by(Region) %>% 
  summarise(Pob_total = sum(Habitantes, na.rm = TRUE)) # No considerar NA en la operación con na.rm

