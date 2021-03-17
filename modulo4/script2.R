### base de datos salud.xlsx ###
################################
library(rio)
Base <- import("salud.xlsx")
head(Base)
## TEST PARA UNA MEDIA
?t.test
## La población el nivel medio de colesterol
## difiere de 200
#  Ho: mu = 200 vs Ha: mu != 200
t.test(Base$COLESTEROL, mu=200, alternative="two.sided")
## como p-value = 9.88e-07 < alfa (5%) se rechaza Ho
# es decir, tengo evidencia para afirmar que el nivel
# medio de colesterol difiere de 200 mg/dL

# Poblacion sana --> colesterol < 200
#  Ho: mu = 200 vs Ha: mu < 200
t.test(Base$COLESTEROL, mu=200, alternative="less")
## como 4.94e-07 < alfa (5%) se rechaza Ho
# es decir, tengo evidencia para afirmar que el nivel
# medio de colesterol es inferior de 200 mg/dL
attach(Base)

## ¿nivel medio de HDL > 46?
t.test(HDL, mu=46, alternative="greater")
# p-value = 0.002203 significativo
# se rechaza Ho en favor de Ha. es decir, hay 
# evidencia estadística para afirmar que ha mejorado
# el nivel de HDL en la poblacion (ref. HDL=46)

## SOLO DIABETICOS -
# ¿tienen el colesterol controlado (< 220)?
# sea mu_d = nivel medio de colesterol de diabéticos
# Ho: mu_d = 220 vs Ha: mu_d < 220
# libreria dplyr
library(dplyr)
# funcion que "filtra"... filter
coldiab = filter(Base, DIABETES=="Si")$COLESTEROL
table(DIABETES)
t.test(coldiab, mu=220, alternative="less")
# p-value = 0.1285 NO se rechaza Ho, no tengo evidencia
# para afirmar que "esta controlado"

## SOLO MUJERES
# ¿Nivel de HDL > 50?
hdlmuj = filter(Base, SEXO=="Femenino")$HDL
t.test(hdlmuj, mu=50, alternative="greater")
# p-value = 0.3016

### TEST SOBRE PROPORCIONES ###
###############################
?prop.test

# los fumadores son minoria
# Sea P = proporcion de fumadores
# Ho: P = 0.5 vs Ha: P < 0.5
#x = num de fumadores
#n = num de entrevistados
table(FUMA)
prop.test(x=120, n=350, alternative="less",
correct=F)
## notese que asume Ho: P = 0.5
prop.test(x=120, n=350, alternative="less",
correct=T)

# Ho: P = 0.3 vs Ha: P > 0.3
prop.test(x=120, n=350, p=0.3, alternative="greater")
#  p-value = 0.04539 < 0.05, se rechaza Ho.
 
### Alternativa - usar test Z - libreria TeachingDemos
library(TeachingDemos)
# antes de usar el test, necesitamos un vector de 0/1
fuma <- ifelse(FUMA =="Si", 1, 0)
# Ho: P = 0.3 vs Ha: P > 0.3
z.test(fuma,mu=0.30, stdev=sqrt(0.3*(1-0.3)), 
alternative="greater")
prop.test(x=120, n=350, p=0.3, alternative="greater",
correct=F)


### TEST de comparacion de medias ###
#####################################
# ¿Colesterol Femenino vs Masculino?
# Ho: Col_masc = Col_feme vs Ha: Col_masc != Col_Feme
t.test(COLESTEROL~SEXO)

# Diabeticos presentan niveles medios de HDL inferior
# a los no diabeticos
t.test(HDL~DIABETES, alternative="greater", var.equal=T)
# con varianzas distintas
t.test(HDL~DIABETES, alternative="greater", var.equal=F)
# y como son las varianzas??
# Ho: sigmaD/sigmaND = 1 vs Ha: sigmaD/sigmaND !=1
var.test(HDL~DIABETES)
# como valor-p=  0.6711 no hay evidencia para afirmar
# que difieren.. debe usar el test t con var.equal=T

#### colesterol dep vs no dep?
# deportistas tiene colesterol inferior a los nodeport
var.test(COLESTEROL~DEPORTE)
# se pueden asumir iguales
# Ho: Cnod = Csid vs Ha: Cnod > Csip
# los "no" están alfabeticamente antes del "si"

t.test(COLESTEROL~DEPORTE, alternative="greater", var.equal=T)

#como valor-p es pequeño, se rechaza Ho. Es decir,
# hay evidencia para afirmar que los "no" deportista
# tienen un nivel de colesterol mayor que el nivel
# de colesterol de los "si" deportista


## TEST de comparación de proporciones  ##
##########################################
# ¿Los Masculino fuman mas que las Femeninas?
# Sea Pm = proporcion de fumadores Masculino
# Sea Pf = proporcion de fumadores Femenino
# Ho: Pf = Pm vs Ha: Pf < Pm
# se necesita contar cuantos masc/feme - fuman
table(SEXO, FUMA)
# Esta tabla permite generar 3 tablas de % 
prop.table(table(SEXO, FUMA))*100  # % respecto al total

prop.table(table(SEXO, FUMA),1)*100  # % respecto al total fila
prop.table(table(SEXO, FUMA),2)*100  # % respecto al total columna
# revise que tabla es la mas apropiada ... es este caso TOTAL FILA

table(SEXO, FUMA) -> t1
t1
prop.test(t1, alternative="greater", correct=F)
prop.test(x=c(63,57), n=c(201,149), alternative="less",
correct=F)
# para alfa=10%, se rechaza Ho, ya que el valor-p  9%

chisq.test(t1)
prop.test(x=c(63,57), n=c(201,149), alternative="less",
correct=T)
prop.test(x=c(63,57), n=c(201,149), alternative="two.sided",
correct=T)
## Test chi.cuadrado
# Ho: Sexo y Fumar son independientes   versus
# Ha: Sexo y Fumar NO son independientes
# chi.cuadrado NO tiene direccion, es decir = vs !=

# FUMA y NEDU ¿están asociados?
table(FUMA,NEDU) -> t2
t2
prop.table(table(FUMA,NEDU),2)*100
chisq.test(t2)

table(DEPORTE,NEDU) -> t3
t3
prop.table(table(NEDU, DEPORTE),1)*100
chisq.test(t3)


table(DIABETES,NEDU) -> t4
t4
prop.table(table(NEDU, DIABETES),1)*100
chisq.test(t4)

## Asociacion entre variables continuas...
plot(EDAD,COLESTEROL)
cor(EDAD,COLESTEROL)
# modelo de regresion lineal simple
m1 <- lm(COLESTEROL~EDAD)
summary(m1)
# graficamos sobre el diagrama de puntos la linea de regresion
abline(m1, col="red")
