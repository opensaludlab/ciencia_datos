#Data Visualization 
#install.packages("tidyverse")
library(tidyverse)


# Visualizaci?n de datos  -------------------------------------

ggplot2::mpg
mpg
view(mpg)

help(mpg)

?mpg
#displ: tama?o del motor en litros
#hwy: n?mero de millas recorridas en autopista 
#por gal?n de combustible (3.78541)



# Gr?fico de puntos -------------------------------------------------------
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy)) 

# agregar color a varable coches ------------------------------------------


ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=class))

?mpg



#OBS
#colour=british
#color=american
#R acepta las dos


# Cambio del tama?o de los puntos -----------------------------------------


ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=class))





# Transparencia de los puntos ---------------------------------------------




ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha=class))


# Forma de los puntos ----------------------------------------------------




ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape= class))



#obs=ggplot solo trabaja un maximo de 6 formas discretas... de la 7 en adelante no aparece


# Elecci?n del color en forma manual --------------------------------------

#Elecci?n manual de est?ticas: nombre del argumento como funci?n fuerea del mapping para configurar



ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), color="red")

#color  = nombre del color en formato string
#size   = tama?o del punto en mm
#shape  = forma del punto con n?meros desde el 0 al 25
#0-14   = son formas huecas solo se puede cambiar el color
#15-20  = formas llenas de color por tanto se le puede cambiar el color otra vez
#21-25  = formas con borde y relleno, se les puede cambiar el color (borde) y el fill (relleno)
#googlear ggplot2 quick reference shape


# Escalas y configuraci?n de identidad ------------------------------------


d=data.frame(p=c(0:25))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)

ggplot(data=mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),
             shape = 23, size = 10, color = "red", fill = "yellow")







# Ejercicios y resultados -------------------------------------------------




#1)Toma el dataset de mpg anterior y di qu? variables son categ?ricas.
#manufacturer, model, drv,  trans, fl, class

view(mpg)

#manufacturer, model, drv,  trans, fl, class

#3)Toma el dataset de mpg anterior y di qu? variables son cont?nuas.
#displ, year, cyl, ctv, hwy

#4) Dibuja las variables cont?nuas con color, tama?o y forma respectivamente. 
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=year))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour= cyl))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=hwy))

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=year))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size= cyl))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=hwy))



#5)En qu? se diferencian las est?ticas para variables cont?nuas y categ?ricas?

#las variables categoriales se pueden mapear con shape y las cont?nuas no 
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=manufacturer))

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=model))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape= drv))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=trans))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=fl))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=drv))

#6) Qu? ocurre si haces un mapeo de la misma variable a m?ltiples est?ticas?
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ, size=displ))

#Funciona pero depende si es categorial o cont?nua. Yo hice una variable continua con est?tica color y size, 
#pero sin shape porque esta est?tica no corre para variables cont?nuas. 

#7) Vamos a conocer una est?tica nueva 
#llamada stroke. Qu? hace? ?Con qu? formas funciona bien? 
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ))


ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=model))

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=year))#no funciona con a?o. Arroj? un gr?fico completamente negro
#plotea c?rculos dependiendo de la relevancia y solo funciona con variables contnuas o num?ricas
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ, color=displ))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, stroke=displ, color=class))


#8) ?Qu? ocurre si haces un mapeo de una est?tica 
#a algo que no sea directamente el nombre de una variable (por ejemplo aes(color = displ < 4))?
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ < 4))






#Plotea y lo hace arrojando leyenda con vector l?gico.  False para rojo y True para celeste. 
#Esto significa que todos los cruces menores a 4 para displ y hwy est?n con color celeste.
#Por tanto, la visualizaci?n nos puede ayudar a ver con el color celeste solo los datos de 
#displ con motor inferior a 4.0
?stroke

### PROBLEMAS
#1)STARKOVERFLOW. copiar muy bien los c?digos. cuidado con los detalles, puntos comas, mayusculas, etc
#cierre de par?ntesis debe cerrar y doble comillas. ayuda hacer intro para alinear los par?ntesis
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, 
                           y=hwy, 
                           colour=displ < 4
  )
  )
#si no aparece el ?cono ">" en la consola y aparece un +, es porque
#R esta pensando o tu no has terminado el script. Se debe forzar aplicando enter
#hasta que aparezca el ?cono de habilitaci?n
#2)abortar secuencias o comandos: con esc
#3) el + tiene que ir siempre al final de la l?nea sino R no v a entender 
#bien la instrucci?n

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, colour=displ < 4))
#4)si no funciona una funci?n preguntar a R con un interrogante. 
#Por ejemplo, si no funciona ggplot hacer interrogante de la funci?n
?ggplot
#para ver la documentaci?n en help dentro de R
#5)
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)


#Errores: copiar errores y pegar en google para buscar la soluci?n


# Divisi?n de gr?ficos: funciones wrap y grid -----------------------------


###DIVISI?N DEL PLOT EN DIFERENTES FACETS O SUBPLOT
#para hacer un gr?fico para dichas subcategor?as
#facet_wrap(~<FORMULA_VARIABLE>): la varible debe ser discreta

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=2)




ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=3)


#Tambi?n se puede utilizar el facet_wrap para combinar dos variables
#con facet_grid
#facet_grid(<FORMULA_VARIBLE1>~<FORMULA_VARIBLE2>)
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_grid(drv~cyl)

?mpg

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_grid(.~cyl)


#1)Qu? ocurre si hacemos un facet de una variable cont?nua?
###Se puede hacer pero... el resultado 
###que no es lo que uno espera ya que el n?mero de gr?ficos puede ser enorme!
#R plotea cada una de las observaciones por separado.
#Lo que no tiene mucho sentido.
#2)Qu? significa si alguna celda queda vac?a en el gr?fico facet_grid(drv~cyl)?
###Tambi?n aparece vac?o la fila/columna correspondiente en el gr?fico con puntos.


#?Qu? relaci?n guardan esos huecos vac?os con el gr?fico siguiente?

ggplot(data = mpg) +
  geom_point(mapping = aes(x=drv, y = cyl)) 
#Es una l?gica similar al facet_wrap

#3)Qu? gr?ficos generan las siguientes dos instrucciones? ?Qu? hace el punto? ?Qu? diferencias hay de escribir la variable antes o despu?s de la virgula?
###Representa el conjunto de puntos filtrados en columnas i filas respectivamente.

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(cyl~.)


ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~drv)

?mpg





#1)plotea la realci?n entre desplazamiento del motor por litro y millas
#de carretera por gal?n en el subset de datos de n?mero de cilindradas

#2)plotea la realci?n entre desplazamiento del motor por litro y millas 
#de carretera por gal?n en el subset de datos de tipos de tracciones de los autos

#4)El primer facet que hemos pintado era el siguiente:

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 3)

#?Qu? ventajas crees que tiene usar facets en lugar de la est?tica del color? 
#?Qu? desventajas? ?Qu? cambiar?a si tu dataset fuera mucho m?s grande?

#La ventaja que tiene el usar facet_wrap es poder analizar el efecto de la correlaci?n
#sobre subset de datos espec?ficos. Es decir, se puede observar por separado los 
#elementos de una variable (columna) 

#La desventaja es que solo es ?til en variables discretas. No sirve para variables 
#continuas. Y creo que es mas ?til con set data madianos o peque?os

#Ser?a mucho la cantidad de plot que tendr?a que realizar R. Lo que hace la visualizaci?n ilegible
###El n?mero de colores o subdivisiones puede dificultar el entendimiento del gr?fico. 
###En el caso de un dataset grande, muchos colores pueden hacer el gr?fico incomprensible
###mientras que los subplots pueden agilizar el filtrado y la comprensi?n de cada categor?a.


#5)Investiga la documentaci?n de ?facet_wrap y contesta a las siguientes preguntas:

?facet_wrap
#?Qu? hace el par?metro nrow?
#?Y el par?metro ncol?
#?Qu? otras opciones sirven para controlar el layout de los paneles individuales?
#?Por qu? facet_grid() no tiene los par?metros de nrow ni de ncol?

#1)Par?metro nrow: n?mero de filas

#2)Par?metro ncol: n?mero de columnas

#3)NO entend?

#4)porque trabaja con dos variables que en el dataframe corresponden a filas y columnas.
###Define el n?mero de filas (y columnas) en las cuales distribuir los subplots 
##generados por el facet. En el caso del grid, como las variables indican 
##autom?ticamente los niveles de las filas y de las columnas,
###no tiene sentido a?adirle dichas opciones de visualizaci?n gr?ficas. 

#6)Razona la siguiente afirmaci?n:

#Cuando representemos un facet con facet_grid() conviene poner
#la variable con mis niveles ?nicos en las columnas.

#Los gr?ficos tienden a ser m?s anchos que altos (la proporci?n est?ndar es de 16:9 
#o formato panor?mico) as? que si una variable tiene m?s niveles que otra, 
#conviene que est? en la dimensi?n m?s grande del gr?fico, es decir, la anchura. 

###ELEMENTOS VISUALES DIFERENTES###
#eL OBJETO GEOM: OBJETO geom?trico que se utiliza en ggplot para representar
#visualmente el dato.
#diagramas de l?eas=geomline
#boxplot
#skaterplot=geometry plot=gr?fico de puntos
#son diferentes dimensiones 

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)


#diferentes geometricas
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y = hwy))


# Gr?fico smooth ----------------------------------------------------------


ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy))

#subdivisi?n de los autos seg?n tracci?n de acuerdo
#a un gr?fico smooth
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv))

#esto mismo a?adiendo colores
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv, color=drv))

#combinaci?n de capas
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y = hwy, color=drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv, color=drv))


# Mostrar leyenda ---------------------------------------------------------




ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, group=drv, color=drv),
              show.legend = T)
#sin leyenda
ggplot(data=mpg)+
  geom_smooth(mapping = aes(x=displ, y = hwy, group=drv, color=drv),
              show.legend = F)


# Combinaci?n de gr?ficos -------------------------------------------------


# Eliminaci?n sombra intervalos de confianza ------------------------------


#combinaci?n de gr?ficos nuevamente
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))+
  geom_smooth(mapping = aes(x=displ,Y=hwy))
#para evitar tipo de repetici?n, configurar directamente en el ggplot2
ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) + #ac? poner el mapping global
  geom_point(mapping = aes(shape=class))+#ac? poner mapping local
  geom_smooth(mapping = aes(color=drv))

#elegir subconjuntos filtrando los datos 
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(mapping = aes(color=class)) +
  geom_smooth(data = filter(mpg, class=="suv"), se = F)# se=F elimina el
#intervalo de confianza 
#alrededor de la curva

# Ejercicios y soluciones -------------------------------------------------


#TAREA
#1)Ejecuta este c?digo en tu cabeza y predice el resultado. 
#Luego ejecutalo en R y comprueba tu hip?tesis:
ggplot(data = mpg, mapping = aes(x=displ, y = hwy,color = drv)) + 
  geom_point() + 
  geom_smooth( se = F)






#si, se comprueba mi imaginaci?n. solo me falt? imaginar la leyenda.
###

#2)?Qu? hace el par?metro show.legend = F? 







#no muestra la leyenda



#?Qu? pasa si lo eliminamos? 




# depende de si necesitamos la leyenda, si no lo ponemos, no sale leyenda




#?Cuando lo a?adir?as y cuando lo quitar?as?




#lo quitar?a cuando los gr?ficos se expliquen por si solos.
###Muestra o oculta la leyenda cuando hace falta. Revisa el v?deo si no sabes cuando ponerlo o quitarlo.

#3)?Qu? hace el par?metro se de la funci?n geom_smooth()?



#el parametro se dibuja la sombra del intervalo de confianza de la curva



#?Qu? pasa si lo eliminamos? 
#desaparece el intervalo de confianza




#?Cuando lo a?adir?as y cuando lo quitar?as?
#lo a?adir?a para saber la varianza de los datos y lo eliminar?a 
#observar solo el comportamiento de los datos
###se elimina o muestra el error est?ndar de los datos en forma de corredor. De la documentaci?n de R:

###se elimina o muestra el error est?ndar de los datos en forma de corredor. De la documentaci?n de R:

#se: standard error

#4) Describe qu? hacen los dos siguientes gr?ficos 
#y di si ser?n igual y diferente. Justifica tu respuesta.
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  
  geom_point() + 
  geom_smooth()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y = hwy)) + 
  geom_smooth(mapping = aes(x=displ, y = hwy))


#son iguales porque el primero tiene un mapping global que re?ne los mapping locales del segundo
###Son los mismos ya que el mapping global en el primer caso es igual a los dos locales en el segundo.







#10)?Este va para nota!

#Reproduce el c?digo de R que te genera el siguiente gr?fico. 
#Investiga algunos par?metros adicionales que te har?n falta de ggplot2 
#como stroke entre otros.




ggplot(data = mpg, mapping = aes(x=displ, y = hwy) ) + 
  geom_point(mapping = aes(fill = drv), size = 4, 
             shape = 23, col = "white", stroke = 2)


# Gr?fico de barras -------------------------------------------------------


#Diagrama de barras
#se utiliza con mas observaciones. datos mas grades. Por tanto, utilizaremos 
#el data set de diamonds
diamonds
view(diamonds)
#Ejemplo del data set de diamantes
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut))#aparece la Y como count. el bar chart, un histograma, 
#un pol?gono de frecuencias, 
#son gr?ficos que toman los datos, agruparlos por categor?as y representar el 
#n?mero de elementos que cae dentro de cada uno de las secciones o grupos
#calcula nuevos valores el plot. entonces hace una serie de operaciones,
#de transformaciones, antes de poder llevar a cabo la represntaci?n gr?fica
#para calcular los valores utilza un algoritmo llamado stat.
#se siguen tres pasos para llegar a la representaci?n gr?fica:
#1) tenemos los datos crudos en el data set de diamonds
#2)geometry bar utiliza una funci?n llamada stat count para calcular cuantos 
#elementos caen dentro de cada uno de los cortes
#3) finalmente geometry bar utiliza esta informaci?n transformada que la hace 
#autom?ticamente ggplot, para llevar a cabo la representaci?n gr?fica 
#donde las categor?as pertenecen al eje de las x mientras que el count pertenece
#al eje de las y
#para saber mas de geom_bar
?geom_bar


# Funci?n stat_count ------------------------------------------------------


#el valor por defecto es count es decir, geom_bar=stat_count: es el mismo resultado
ggplot(data=diamonds)+
  stat_count(mapping = aes(x=cut))

#toda la geometr?a tiene un stat. podemos usar geometr?as sin las preocupacioens estad?sticass
#el propio ggplot las infiere autom?ticamente.

#creaci?n de subconjunto de los diamantes. Peque?o data set 
#de otro dataset mas grande
demo_diamonds <- tribble(
  ~cut,      ~freqs,
  "Fair",       1610, 
  "Good",       4906,
  "Very Good", 12082,
  "Premium",   13791, 
  "Ideal",     21551
)


# Stat identidad ----------------------------------------------------------


#vamos a cambair el estad?stico del count a la identidad.
#esto me dejar? mapear la altura de las barras de los raw values
#a una variable Y que yo tengo ya autom?ticamente

ggplot(data=demo_diamonds)+
  geom_bar(mapping = aes (x=cut, y=freqs), 
           stat="identity")
#esto es manual y diferente al stat_count autom?tico de r


# Proporci?n --------------------------------------------------------------


#ahora mostramos un diagrama de barras para mostrar la porporci?n
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, Y=..prop.., group=1))

#queremos traer la atenci?n en una transformaci?n estad?stica
#directamente en nuestro c?digo.
#porejemplo, podemos utilizar la funci?n stat summary
#esta funci?n resume los valores Y para cada valor de x 
#todo un conjunto de datos del mundo de la estad?stica
#ver valores m?nimos m?ximos o medias, medianas, etc podemos utilizar un ggplot


# Funci?n stat_summary ----------------------------------------------------


ggplot(data=diamonds)+
  stat_summary(
    mapping = aes(x=cut, y=depth),
    fun.ymin=min,
    fun.ymax=max, 
    fun.y=median
  )

ggplot(data=diamonds)+
  stat_summary(
    mapping = aes(x=cut, y=price),
    fun.ymin=min,
    fun.ymax=max, 
    fun.y=median
  )

ggplot(data=diamonds)+
  stat_summary(
    mapping = aes(x=cut, y=price),
    fun.ymin=min,
    fun.ymax=max, 
    fun.y=media
  )


# Ejercicios y soluciones -------------------------------------------------


###TAREA
#!)?Qu? hace el par?metro geom_col? ?En qu? se diferencia de geom_bar?
ggplot(data=demo_diamonds)+
  geom_bar(mapping = aes (x=cut, y=freqs), 
           stat="identity")
ggplot(data=demo_diamonds)+
  geom_col(mapping = aes (x=cut, y=freqs), 
           stat="identity")



#no se diferencian en nada. lo mismo que geom_bar

###Seg?n la documentaci?n exacta, os sumar? los valores subministrados como y en el dataset:
#There are two types of bar charts: geom_bar makes the height of the 
#bar proportional to the number of cases in each group 
#(or if the weight aethetic is supplied, the sum of the weights). 
#If you want the heights of the bars to represent values in the data, 
#use geom_col instead. geom_bar uses stat_count by default: it counts 
#the number of cases at each x position. geom_col uses stat_identity: 
#it leaves the data as is.

#2)La gran mayor?a de geometr?as y de stats vienen por parejas 
#que siempre se utilizan en conjunto. Por ejemplo geom_bar con stats_count. 
#Haz una pasada por la documentaci?n y la chuleta de ggplot y establece una 
#relaci?n entre esas parejas de funciones. ?Qu? tienen todas en com?n?
#la transformaci?n de los datos 

#3) Cuando hemos pintado nuestro diagrama de barras con sus proporciones, 
#necesitamos configurar el par?metro group = 1. ?Por qu??
#para mostrar las proporciones por barra. De lo contrario todas las barras aparecer?n 
#de igual proporci?n

###Seg?n la documentaci?n de R:

#Aesthetics
#geom_smooth understands the following aesthetics 
#(required aesthetics are in bold):

#<strong>x</strong>

# <strong>y</strong>

alpha

colour

fill

group

linetype

size

weight

#Computed variables
#y: predicted value
#ymin: lower pointwise confidence interval around the mean
#ymax: upper pointwise confidence interval around the mean
#se: standard error

#4)Qu? problema tienen los dos siguientes gr?ficos?
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group=1))
#no demuestran las proporciones correspondientes porque no est? group=1

###Porque si no, la proporci?n no se calcula para cada una de las 
###categor?as del eje de las X. 

#5)?Qu? variables calcula la funci?n stat_smooth? ?Qu? par?metros
#controlan su comportamiento?
#e + stat_smooth(method = "lm", formula = 
#y ~ x, se=T, level=0.95) x, y | ..se.., ..x.., ..y.., ..ymin.., ..ymax.. 


# Colores y formas de gr?ficos --------------------------------------------


###COLORES Y FORMAS DE LOS GR?FICOS 
ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, colour=cut))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=cut))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=clarity))

ggplot(data=diamonds)+
  geom_bar(mapping  = aes(x=cut, fill=color))


# Posici?n="Identidad" ----------------------------------------------------


## position="identity"
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( alpha=0.2, position="identity")#alpha 0.2 es para que quede mas transparente
#position es ver el overlapping de las barras... todas empiezan abajo y se van sobreponiendo
#sirve para geom 3d. este gr?fico se debe usar con transparencia (alpha=0.2)
#position identity para un scatterplot puede resultar fant?stico, pero para un geom bar
#es fatal
ggplot(data=diamonds,mapping  = aes(x=cut, colour = clarity))+
  geom_bar( fill= NA, position="identity")


# position="fill" ---------------------------------------------------------


##position = "fill" muy similar al stacket, pero sirven para comparar las proporciones. 
#todos quedan a la misma altura y se puede comparar proporciones. toda las barras altura 1
# y comparas proporciones
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="fill")#para diagrama de barra


# position"dodge" ---------------------------------------------------------


##position = "dodge"
ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="dodge")#coloca los objetos uno al lado del otro para evitar esa 
#oclusi?n que ocurr?a con el gr?fico de identity
#es mucho mas f?cil de comparar por coloraciones. 
#para diagrama de barras una al lado del otro


# Volvemos al gr?fico de puntos -------------------------------------------


#volvemos al scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy))#solo pinta una peque?a muestra. Los puntos no son 
#todas las obervaciones. esto es por el problema del overplotting.
#esto impide ver la concentraci?n de puntos porque se overlapean y se ven todos iguales los puntos
#la forma mejor de hacer la representaci?n es configurar mejor el par?metro 
#de ajustamiento de pisici?n llamado jitter
##position="jitter"


# position="jitter" -------------------------------------------------------


ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(position="jitter")#ac? los puntos no se overlapean. se puede ver mas en los gr?ficos
#a?ade un peque?o ruido aleatorio. Hace que peque?as diferencias por factores de escala 
#se revelen aparezcan, salgan a la luz, y que podamos ver de mejor manera la concentraci?n
#de puntos
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_jitter()#esto es lo mismo que lo anterior


# position="stack" --------------------------------------------------------


ggplot(data=diamonds,mapping  = aes(x=cut, fill=clarity))+
  geom_bar( position="stack")

?position_stack
?position_identity
?position_fill
?position_dodge
?position_jitter



# coord_flip(). Sistema de coordenadas ------------------------------------

##Sistemas de coordenadas en ggplot2
#el sistema de coordenadas de cualquier gr?fico es el sistema de coordenadas cartesiana
#pero existen otros sistemas de coordenadas que pueden ser realmente ?tiles
#la funci?n coodinate_flip

#coord_flip()-> cambia los papeles de x e Y para girar un gr?fico
ggplot(data=mpg, mapping = aes(x=class, y=hwy)) +
  geom_boxplot()

ggplot(data=mpg, mapping = aes(x=class, y=hwy)) +
  geom_boxplot() +
  coord_flip()

#como se lee un boxplot+
#lo mas importante es la caja 
#la raya representa el promedio, la media
#en la caja el primer y el tercer cuartil. Entre la primera raya y el centro
#se encuentra el 25% de los datos
#y entre la raya y la zona superior hay el 25% de los datos
#entre el 25 y el 75% de los datos caen dentro de la caja
#el rango intercuant?tilico es la distancia que hay desde la zona inferior de la caja 
#hasta la zona superior. 
#b?sicamente 1,5 veces ese valor es el maximo del pivote
#valores 1,5 veces del rango  intercuart?culo por encima o debajo de la caja tenemos aoutlayers

#coord_quickmap() -> configura el aspect ratio para mapas
#importante para representacion de datos geoespaciales con ggplot


# coord_quickmap ----------------------------------------------------------


es<- map_data("es")
#"es"=cpodigo iso de un pa?s en este caso es espa?a

install.packages("maps")

italy<- map_data("italy")
ggplot(italy, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()#facilita un aspecto mas real 

usa<- map_data("usa")
ggplot(usa, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()#facilita un aspecto mas real 


# coord_polar -------------------------------------------------------------


#coord_polar=uso coordenadas polares entre un barchart y un coxcomechart, el diagrama en tela de ara?a

ggplot(data=diamonds) +
  geom_bar(
    mapping = aes(x=cut, fill=cut),
    show.legend = F, #quitar leyenda
    width = 1 #agregar anchura
  ) +
  theme(aspect.ratio = 1)+#armar grafico perfectamente cuadrado
  labs(x=NULL, Y=NULL) +#eliminar etiquetas de arriba y abajo
  coord_flip()#para girar

ggplot(data=diamonds) +
  geom_bar(
    mapping = aes(x=cut, fill=cut),
    show.legend = F, #quitar leyenda
    width = 1 #agregar anchura
  ) +
  theme(aspect.ratio = 1)+#armar grafico perfectamente cuadrado
  labs(x=NULL, Y=NULL) +#eliminar etiquetas de arriba y abajo
  coord_polar()#para girar muy utilizado en las infograf?as y resumen de inforamci?n
#una vez realizado los an?lisis


# Gram?tica de ggplot2 ----------------------------------------------------


#ggplot(data=<DATA_FRAME>) +
#<GEOM_FUNCTION> (
#                 mapping = aes (<MAPPINGS>),
#                 stat=<STAT>,
#                 position = <POSITION>
#                 ) +
#  <COORDINATE_FUNCTION>() +
#  <FACET_FUNCTION>(
diamonds
stats_count()
coord_cartesian()

#partir siempre de un diagrama b?sico y luego combinar par?metros y coordenadas 
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..count..))
#tipo de plot
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..prop.., group=1))#..prop.. para la proporci?n
#agrego color
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))


# Coordenadas Polar -------------------------------------------------------



#cambio de coordenadas
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()
#creaci?n de gr?ficos por una varible determinada en este caso cut en Y
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)

#quitar informaci?n irrelevante en cada uno de los ejes
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL)


# Agregar t?tulo ----------------------------------------------------------

#agregar un t?tulo 
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB")


# Agregar descripci?n -----------------------------------------------------


# si quiero agregar un caption=una descripci?n abajo
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds")


# Agregar subt?tulo -------------------------------------------------------


#para agregar un subtitle
ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()+
  facet_wrap(~cut)+
  labs(x=NULL, y=NULL, title="Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds",
       subtitle = "Aprender ggplot puede ser hasta divertido ;)")



# Ejercicicios y soluci?n -------------------------------------------------


#TAREA AJUSTES AVANZADOS DE GGPLOT

#El siguiente gr?fico que genera el c?digo de R es correcto 
#pero puede mejorarse. ?Qu? cosas a?adir?as para mejorarlo?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point(shape=23, size=5, color="red", fill="yellow", stroke = cty)

ggplot(data=mpg, mapping = aes (x = cty,  y = hwy )) +
  geom_point(position = "jitter", color= "red")+
  geom_smooth()


#Investiga la documentaci?n de geom_jitter(). 
#?Qu? par?metros controlan la cantidad de ru?do aleatorio (jitter)?
?geom_jitter
#todas las de aes
#x

#y

#alpha

#colour

#fill

#group

#shape

#size

#stroke

#Compara las funciones geom_jitter contra geom_count 
#y busca semejanzas y diferencias entre ambas.

ggplot(mpg, aes(cyl, hwy))+
  geom_point()+
  geom_jitter()

ggplot(mpg, aes(cyl, hwy))+
  geom_point()+
  geom_count()

?geom_count

#las dos son utilizadas para solucionar porblemas de overlapping. 
#Sin embargo, la pirmera muestra los puntos sin overlapping y la segunda
#sirve para observar la concentraci?n de datos en cada localizaci?n

# Add aesthetic mappings
geom_jitter(aes(colour = class))

# Add aesthetic mappings
geom_jitter(aes(colour = class))

#?Cual es el valor por defecto del par?metro position de 
#un geom_boxplot? Usa el dataset de diamonds o de mpg para hacer una visualizaci?n 
#que lo demuestre.

#El valor del par?metro de posici?n es el carteriano por defecto
ggplot(data=diamonds, mapping = aes(x=cut, y=price)) +
  geom_boxplot() 




#Convierte un diagrama de barras apilado en un diagrama de sectores o de tarta usando la funci?n coord_polar()

ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, y = ..count..))

ggplot(data=diamonds)+
  geom_bar(mapping = aes (x=clarity, fill = clarity, y = ..count..))+
  coord_polar()



#?Qu? hace la funci?n labs()? Lee la documentaci?n y expl?calo correctamente.
?labs#modifica las las etiquetas de los ejes x e y, y las leyendas de plot


#?En qu? se diferencian las funciones coord_quickmap() y coord_map()?

usa<- map_data("usa")
ggplot(usa, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_quickmap()

usa<- map_data("usa")
ggplot(usa, aes(long, lat, group=group)) +
  geom_polygon(fill="blue", color="white") +
  coord_map()

?coord_quickmap#coord_map projects a portion of the earth, which is approximately spherical,
#onto a flat 2D plane using any projection defined by the mapproj package. Map projections do not, 
#in general, preserve straight lines, so this requires considerable computation. 
#coord_quickmap is a quick approximation that does preserve straight lines. 
#It works best for smaller areas closer to the equator.

?coord_map #es lo mismo 

#Investiga las coordenadas coord_fixed() e indica su funci?n.
?coord_fixed
#A fixed scale coordinate system forces a specified ratio between the physical 
#representation of data units on the axes. The ratio represents the number of 
#units on the y-axis equivalent to one unit on the x-axis. The default, ratio = 1, 
#ensures that one unit on the x-axis is the same length as one unit on the y-axis. 
#Ratios higher than one make units on the y axis longer than units on the x-axis, and vice versa. 
#This is similar to MASS::eqscplot(), but it works for all types of graphics.
ggplot(mtcars, aes(mpg, wt)) + 
  geom_point()+
  coord_fixed(ratio = 1)

ggplot(mtcars, aes(mpg, wt)) + 
  geom_point()+
  coord_fixed(ratio = 1/5)

ggplot(mtcars, aes(mpg, wt)) + 
  geom_point()+
  coord_fixed(xlim = c(15, 30))

#Investiga la geometr?a de la funci?n geom_abline(), geom_vline() y geom_hline() e indica su funci?n respectivamente.


?geom_abline#calculate slope and intercept
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_abline(intercept = 20)

?geom_vline#xinterpcept
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_vline(xintercept = 5)

ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_vline(xintercept = 1:5)

?geom_hline#yintercept
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point()+
  geom_hline(yintercept = 20)

# Calculate slope and intercept of line of best fit
coef(lm(mpg ~ wt, data = mtcars)) + 
  geom_abline(intercept = 37, slope = -5)
# But this is easier to do with geom_smooth:
coef(lm(mpg ~ wt, data = mtcars)) + 
  geom_smooth(method = "lm", se = FALSE)

# To show different lines in different facets, use aesthetics
ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  facet_wrap(~ cyl)

# You can also control other aesthetics
ggplot(mtcars, aes(mpg, wt, colour = wt)) +
  geom_point () 
geom_point()

geom_hline(aes(yintercept = wt, colour = wt), mean_wt) +
  facet_wrap(~ cyl)

#?Qu? nos indica el gr?fico siguiente acerca de la relaci?n entre el consumo en ciudad y en autopista del dataset de mpg?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point() + 
  geom_abline() + 
  coord_fixed()
#significa que en un ratio de 1/5  existe una directa proporci?n del rendimiento de los autos y en la ciudad. Los que rinden mas 
# en ciudad rinden mas en autopista
