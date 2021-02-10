#### Otras librerías de visualización de datos


# Paquete HIGHCHARTER -----------------------------------------------------



#install.packages("highcharter")
library(highcharter)


# Gráfico de barras con Highcharter ---------------------------------------

#### El gráfico más popular y más usado
#### Permite visualizar conteos o cantidades agrupadas
#### No usemos muchas categorías! Podemos saturar el espacio
#### Revisemos una estadística contingente. Cantidad de muertes cada 100.000 
#### habitantes por cancer de mama.
#install.packages("readr")
library(readr) # para leer el csv

library(dplyr) # para limpiar el csv

by_country <- readr::read_csv("by_country.csv") #subimos nuestra base de datos

breast_cancer_clean <- by_country %>% # llamo la base de datos
  select(Country, Value)# filtro los valores que me interesan

#### Tenemos listo nuestra base para graficar, 
#### la gramática para utilizar los highcharts es: 


####       hchart(dataframe, tipo_grafico, hcaes(mapeo))     



hchart(breast_cancer_clean, "column", hcaes(x= Country, y= Value))

#### Este gráfico puede ser mejorado ¿Cómo?

#### Agreguemos  un título y reordenemos las filas.

library(forcats) # esta librería nos va a permitir ordenar nuestras columnas

conteo_clases <- breast_cancer_clean %>% 
  arrange(-Value) %>% 
  mutate(Country = fct_inorder(Country))

barchart01 <- hchart(conteo_clases, "column", hcaes(x = Country, y = Value), name = "Deaths per 100.000 population") %>% 
  hc_title(text = "Estadísticas de Cancer de mama año 2016 / Organización Panamericana de la Salud")

barchart01 ### veamos nuestro chart


# Gráficos de lineas con highcharter --------------------------------------

#### Los gráficos de lineas se utilizan por lo general cuando nuestros datos
#### tienen algún tipo de variable temporal (fechas o años).

#### Revisemos los datos de muertes producto de cancer de mama en Chile, entre
#### los años 2000 y 2016:

breast_cancer_año <- readr::read_csv("breast_pais.csv")

count_año <- breast_cancer_año %>% 
  select(Country, Year, Value) %>% 
  filter( Year>=2010) #limpiamos nuestra data un poco

hchart(count_año, "line", hcaes(Year, Value, group=Country))

#### usaremos la funciòn  #### hc_tooltip ##### para modificar el tooltip y 
#### hc_legend #### para mejorar las leyendas:

linechart02 <- hchart(count_año, "line", hcaes(Year, Value, group=Country)) %>% 
  hc_tooltip(table = TRUE, valueDecimals = 2) %>%  ### para comparar entre años de manera más simple
  hc_legend(layout = "horizontal") %>%### posición de la leyenda 
  hc_title(text="Estadísticas de Cancer de mama por país/ Organización Panamericana de la Salud")

linechart02 ## Revisemos nuestro gráfico


# Gráfico de puntos con Highcharter --------------------------------------------

#### El gráfico de puntos o scatter plot se utiliza para observar la
#### relación entre dos variables continuas. 
#### usaremos una base de datos del paquete "datos", que nos permite relacionar el PIB per capita 
#### a la esperanza de vida. 

# remotes::install_github("cienciadedatos/datos")

library(datos)       # datos
?datos
?paises

paises <- paises %>% 
  filter(anio==2007)

hchart(paises, "scatter", hcaes(pib_per_capita, esperanza_de_vida, group = continente))

#### Existen muchas maneras de mejorar este gráfico, por ejemplo:
#### - Podemos agregar *captions* y código html para introducir texto explicativo.
#### - Podemos simplificar el tooltip, dejando solo el nombre de cada país.
#### - Podemos cambiar la escala del gráfico, para que este no se "cargue de un lado".

################## Texto explicativo:

texto_explicativo <- "Extracto de datos de <b>Gapminder</b> sobre <b>expectativa de vida</b>, <b>PIB per cápita</b> y <b>población</b>, según país.<br/>
                      Se utilizará un <i>escala logarítmica</i> en el eje x por la asimetría de la variable."

#### podemos utilizar <b> </b> para negrita
#### <b/> para salto de línea
#### <i> para itálica (o cursiva)

chart_scatter03 <- hchart(
  paises, # nuestra base de datos
  "scatter", #tipo de gráfico
  hcaes(pib_per_capita, esperanza_de_vida, group = continente, z = poblacion),
  maxSize = 30) %>%  # para fijar y setar el tamaño máximo
  hc_tooltip(pointFormat = "{point.pais}") %>%  # para que nos muestre solo el país
  hc_caption(text = texto_explicativo) %>% #añadimos nuestro texto explicativo
  hc_title(text = "Relación entre PIB y Esperanza de vida") %>% #agregamos título
  hc_xAxis(type = "logarithmic") # señalamos el tipo de escala de nuestro eje x

chart_scatter03


# Gráficos con facetas en Highcharter -------------------------------------

#### Primero observemos como se realiza este gráfico con ggplot2, a través de la función face_wrap

library(ggplot2)
self_harm <- readr::read_csv("self_harm.csv") #base de datos

self_auxiliar <- self_harm %>% 
  select(Year, Value)

ggplot(self_harm) + # nuestra base de datos
  geom_point(aes(Year, Value), color = "gray90", data =self_auxiliar, size = 1) + #agregamos las estéticas
  geom_line(aes(Year, Value, color = Sex), size = 1.5) + #tipo de gráfico
  scale_color_viridis_d(end = 0.8) + #escala de colores
  facet_wrap(vars(Country)) + # variable para hacer la separación
  labs(title = "Distribución de tasas de suicidio") # Título 

#### ¿Cómo podemos hacer esto en Highcharter?

self_aux <- self_harm %>% 
  filter(Sex=="Both sexes")

face_wrap_chart_04 <- hchart(
  self_aux, 
  "line",
  hcaes(Year, Value, group = Country, colorize= Sex),
  yAxis = c(0, 1, 2) # parte clave para asignar cada grupo a cada eje Y
) %>% 
  # esta es la parte donde se crean *manualmente* 3 ejes.
  hc_yAxis_multiples(
    create_yaxis(
      naxis = 3, #número de ejes
      lineWidth = 2, #tamaño
      title = purrr::map(0:2, ~list(text = "Country")) #nombre en cada faceta
    )
  ) %>% 
  hc_title(text = "") %>% #titulo del gráfico
  hc_tooltip(table = TRUE) #arregamos la tooltip

face_wrap_chart_04

# Gráficos de Dona con Highcharter ----------------------------------------

#### Los gráficos de Dona son muy parecidos a los gráficos de pie, pero 
#### se les quita un parte del centro para reducir la distorción visual
#### y percibir mejor la distribución.
library(readxl)
library(scales)
hospitalizacion_etario <- read_excel("hospitalizacion_etario.xlsx")

#### Cálculo de los porcentajes para generar la dona


hosp <- mutate(hospitalizacion_etario, porcentaje = percent(Casos/sum(Casos)))

donut_chart_05 <- hchart(
  hosp, "pie", hcaes(x = Edad, y = Casos),
  name = "Casos",
  innerSize = "80%",
  dataLabels = list(format = "{point.name}<br>({point.porcentaje})")
)

donut_chart_05


