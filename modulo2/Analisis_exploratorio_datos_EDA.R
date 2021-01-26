# Análisis exploratorio de datos (EDA) ------------------------------------

# Introducción ------------------------------------------------------------

"
Este capítulo te mostrará cómo usar la visualización y la transformación 
para explorar tus datos de manera sistemática, una tarea que las personas 
de Estadística suelen llamar análisis exploratorio de datos, o EDA (por sus 
siglas en inglés exploratory data analysis). El EDA es un ciclo iterativo 
en el que:
1.Generas preguntas acerca de tus datos.
2.Buscas respuestas visualizando, transformando y modelando tus datos.
3.Usas lo que has aprendido para refinar tus preguntas y/o generar nuevas 
interrogantes.
"

#Requisitos indispensables

#install.packages("tidyverse")
library(tidyverse)
#install.packages("datos")
library(datos)
#install.packages("gglot2")
library(ggplot2)

# Preguntas ---------------------------------------------------------------


# Variación ---------------------------------------------------------------

"
La variación es la tendencia de los valores de una variable a cambiar de una 
medición a otra. La mejor manera de entender dicho patrón es visualizando la 
distribución de los valores de la variable.
"

#Visualizando distribuciones

"
Cómo visualizar la distribución de una variable dependerá de si la variable
es categórica o continua.
"

#Para examinar la distribución de una variable categórica, usa un gráfico
#de barras

ggplot(data = diamantes) +
  geom_bar(mapping = aes(x = corte))

#La altura de las barras muestra cuántas observaciones corresponden a cada 
#valor de x. Puedes calcular estos valores con dplyr::count()

diamantes %>% 
  count(corte)


#Para examinar la distribución de una variable continua, usa un histograma

ggplot(data = diamantes) +
  geom_histogram(mapping = aes(x = quilate), binwidth = 0.5)

#Puedes calcular esto manualmente combinando dplyr::count() y 
#ggplot2::cut_width()

diamantes %>% 
  count(cut_width(quilate, 0.5))

#A continuación, vemos como luce la gráfica anterior cuando 
#acercamos la imagen a solo los diamantes con un tamaño menor a 
#tres quilates y escogemos un intervalo más pequeño (bindwidth=0.1)

pequenos <- diamantes %>% 
  filter(quilate < 3)

ggplot(data = pequenos, mapping = aes(x = quilate)) +
  geom_histogram(binwidth = 0.1)

#Te recomendamos usar "geom_freqpoly()" (polígonos de frecuencias) en 
#lugar de "geom_histogram()". Es mucho más fácil entender líneas que 
#barras que se sobreponen.

ggplot(data = pequenos, mapping = aes(x = quilate, colour = corte)) +
  geom_freqpoly(binwidth = 0.1)


#Valores típicos

"
Tanto en gráfico de barra como en histogramas, las barras altas muestran
los valores más comunes de una variable y las barras más cortas muestran
los valores menos comunes. Espacios que no tienen barras revelan valores
que no fueron observados en tus datos.
"

#En el siguiente histograma sugiere varias preguntas interesantes ¿?

ggplot(data = pequenos, mapping = aes(x = quilate)) +
  geom_histogram(binwidth = 0.01)


#En el siguiente histograma muestra la duración (en minutos) de 272 
#erupciones del géiser Fiejo Fiel en el Parque Nacional Yellowstone.
#La duración de las erupciones parece estar agrupada en dos conjuntos:
#1. erupciones cortas (con duración de alrededor de 2 minutos) y 
#2. erupciones largas (4-5 minutos), y pocos datos en el intervalo intermedio.

ggplot(data = fiel, mapping = aes(x = erupciones)) +
  geom_histogram(binwidth = 0.25)


#Valores inusuales 

"
Los valores atípicos, conocidos como outliers, son puntos en los datos que 
parecen no ajustarse al patrón. Cuando tienes una gran cantidad de datos, 
es difícil identificar los varlores atípicos en un histograma.
"

#Tomaremos la distribución de la variable y del set de datos de diamantes.
#La única evidencia de existencia de outliers son límites insuales en el 
#eje horizontal

ggplot(diamantes) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)

#Para facilitar la visualización de outliers, necesitamos acercar la imagen
#a los varlores más pequeños del eje vertical con "coord_cartesian()"

ggplot(diamantes) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

#Al usar los límites, nos permite observar tres valores inusuales:
#0, 30 aprox y 60 aprox. Estos valores podemos removerlos con dplyr

inusual <- diamantes %>% 
  filter(y < 3 | y > 20) %>% 
  select(precio, x, y, z) %>%
  arrange(y)
inusual



# Valores faltantes -------------------------------------------------------

"
Si has encontrado valores inusuales en tu set de datos y simplemente quieres
seguir con el resto de tu análisis, tienes dos opciones:
1. Desecha la fila completa donde están los valores inusuales.
2. Reemplazar los valores inusuales con valores faltantes.
"

#Desecha la fila completa donde están los outliers

diamantes2 <- diamantes %>% 
  filter(between(y, 3, 20))
#¡NO ES RECOMENDABLE!
#Que una medida sea inválida no significa que todas las mediciones lo están.


#Reemplazar los valores inusuales con valores faltantes

diamantes2 <- diamantes %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
#La manera más fácil es usar mutate() para reemplazar la variable con una 
#copia editada de la misma. Usamos ifelse() para reemplazar outliers con NA.


#ggplot no incluye los valores faltantes, pero emite una advertencia que 
#fueron removidos

ggplot(data = diamantes2, mapping = aes(x = x, y = y)) + 
  geom_point()
#> Warning: Removed 9 rows containing missing values (geom_point)


#Para eliminar esa alerta, define na.rm = TRUE 

ggplot(data = diamantes2, mapping = aes(x = x, y = y)) + 
  geom_point(na.rm = TRUE)


#En datos::vuelos los valores faltantes en la variable "horario_salida"
#indicaban que el vuelvo había sido cancelado, por lo que uno querría 
#comparar el horario de salida programado para los vuelos cancelados y 
#los no cancelados.

datos::vuelos %>% 
  mutate(
    cancelados = is.na(horario_salida),
    hora_programada = salida_programada %/% 100,
    minuto_programado = salida_programada %% 100,
    salida_programada = hora_programada + minuto_programado / 60
  ) %>% 
  ggplot(mapping = aes(salida_programada)) + 
  geom_freqpoly(mapping = aes(colour = cancelados), binwidth = 1/4)

#El gráfico no es tan bueno porque hay muchos más vuelos no cancelados que 
#cancelados. 


# Covariación -------------------------------------------------------------

#¿que és la covariación? la tendencia de los valores de dos o más variables
#a variar simultáneamente de una manera relacionada, como por ejemplo: a 
#mayor cantidad de albañiles, menos tiempo se demorarán en construir
#(prporción indirecta)

#antes de comenzar comentaremos algunos comandos que utilizaremos
#el mapeo (mapping), que usa la función aes(). La función aes 
#(por aestethics) indica la ‘estética’ del gráfico, osea
#define qué variables irán en el gráfico y en qué ejes.

#point (geom_point()): para gráficos de puntos o dispersión, donde x e y son variables continuas
#bar (geom_bar()): par gráficos de barras, donde x es una variable discreta
#boxplot (geom_boxplot()): para diagrmas de cajas y bigotes, donde x es una variable discreta e y 
#es una variable continua


#Una variable categórica y una variable continua

ggplot(data = diamantes, mapping = aes(x = precio)) + 
  geom_freqpoly(mapping = aes(colour = corte), binwidth = 500)

ggplot(diamantes) + 
  geom_bar(mapping = aes(x = corte))

ggplot(data = diamantes, mapping = aes(x = precio, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = corte), binwidth = 500)

ggplot(data = diamantes, mapping = aes(x = corte, y = precio)) +
  geom_boxplot()

ggplot(data = millas, mapping = aes(x = clase, y = autopista)) +
  geom_boxplot()

ggplot(data = millas) +
  geom_boxplot(mapping = aes(x = reorder(clase, autopista, FUN = median), y = autopista))

ggplot(data = millas) +
  geom_boxplot(mapping = aes(x = reorder(clase, autopista, FUN = median), y = autopista)) +
  coord_flip()


#Dos variables categóricas

ggplot(data = diamantes) +
  geom_count(mapping = aes(x = corte, y = color))

diamantes %>% 
  count(color, corte)

diamantes %>% 
  count(color, corte) %>%  
  ggplot(mapping = aes(x = color, y = corte)) +
  geom_tile(mapping = aes(fill = n))

#Dos variables continuas

ggplot(data = diamantes) +
  geom_point(mapping = aes(x = quilate, y = precio))

ggplot(data = diamantes) + 
  geom_point(mapping = aes(x = quilate, y = precio), alpha = 1 / 100)


##los comandos geom_bin2d (crea cuadrados) y geom_hex (crea hexágonos)dividen 
#el plano cartesiano en unidades o contenedores bidimensionales y luego usan 
#un color de relleno para mostrar cuántos puntos pueden ser clasificados en cada contenedor

ggplot(data = pequenos) +
  geom_bin2d(mapping = aes(x = quilate, y = precio))

#install.packages("hexbin")
library(hexbin)

ggplot(data = pequenos) +
  geom_hex(mapping = aes(x = quilate, y = precio))

#segmentaremos la variable "quilate" y definiremos unidades o intervalos, para 
#después graficar una diagrama de cajas para cada grupo

ggplot(data = pequenos, mapping = aes(x = quilate, y = precio)) + 
  geom_boxplot(mapping = aes(group = cut_width(quilate, 0.1)))

#una solución para poder comparar los gráficos de caja donde contengan el mismo "n" o 
#igual cantidad de observaciones es:

ggplot(data = pequenos, mapping = aes(x = quilate, y = precio)) + 
  geom_boxplot(mapping = aes(group = cut_number(quilate, 20)))


# Patrones y modelos ------------------------------------------------------

"
Los patrones en tus datos entregan pistas acerca de las relaciones entre 
variables. Si existe una relación sistemática entre dos variables, esto 
aparecerá como un patrón en tus datos.
"

#Un diagrama de dispersión de la duración de las erupciones del géiser Viejo
#Fiel contra el tiempo de espera entre erupciones muestra un patrón: tiempos
#de espera más largos están asociados con erupciones más largas.

ggplot(data = faithful) +
  geom_point(mapping = aes(x = eruptions, y = waiting))


#install.packages("modelr")
library(modelr)

#Creamos un modelo que predice el precio a partir de la variable quilate y 
#después calcula los residuales.

mod <- lm(log(precio) ~ log(quilate), data = diamantes)

diamantes2 <- diamantes %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamantes2) + 
  geom_point(mapping = aes(x = quilate, y = resid))


#Una vez removida la fuerte relación entre quilate y precio, puedes observar
#lo que esperarías sobre la relación entre corte y precio: los diamantes de 
#mejor calidad son más costoso según su tamaño.

ggplot(data = diamantes2) + 
  geom_boxplot(mapping = aes(x = corte, y = resid))


# Argumentos en ggplot2 ---------------------------------------------------

"
Usaremos expresiones más concisas para escribir código de ggplot2. 
"

#Usualmente los primeros argumentos de una función son tan importantes que 
#deberías saberlos de memoria. ggplot(), data y mapping. aes() x e y.

ggplot(data = faithful, mapping = aes(x = eruptions)) +
  geom_freqpoly(binwidth = 0.25)


#Escribimos el código para el gráfico anterior de manera más precisa

ggplot(faithful, aes(eruptions)) +
  geom_freqpoly(binwidth = 0.25)

#La transición de %>% a +. Nos gustaría que esta no fuera necesaria, pero  
#ggpolt2 fue creado antes de que el pipe fuera descubierto.

diamantes %>% 
  count(corte, claridad) %>% 
  ggplot(aes(claridad, corte, fill = n)) + 
  geom_tile()


# Aprendiendo más ---------------------------------------------------------

"
Si quieres seguir aprendiendo más a cerca de ggplot2, te recomendamos 
consultar una copia del libro de ggplot2 de Hadley Wickham.
Otro recurso útil es `R Graphics Cookbook`de Winston Chang.
También se recomienda `Graphical Data Analysis with R` de Antony Unwin.
"