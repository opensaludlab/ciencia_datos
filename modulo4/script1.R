### OPENLAB    --    DataUC    ###
##########   Ricardo Aravena C.###
##################################
# Mod4 - Estadística Inferencial
# Primera parte

# libreria "muy útil" para leer bases de datos
#install.packages("rio")
library(rio)
getwd()   ## me indica el directorio base
dir()
Base <- import("salud.xlsx")
head(Base)

## algo simple - descriptivo
#############################
summary(Base)
quantile(Base$COLESTEROL)
hist(Base$COLESTEROL)        #Grafico
boxplot(Base$COLESTEROL~Base$SEXO)  #grafico comparativo..
boxplot(Base$TALLA~Base$SEXO)
boxplot(Base$PESO~Base$SEXO)
plot(Base$TALLA,Base$PESO)


# Tabulacion ... 
table(Base$FUMA,Base$SEXO)


attach(Base) # me apropio de la Base
table(FUMA,SEXO)

# mas que numero de casos.. porcentajes ¿filas / columnas?
prop.table(table(FUMA,SEXO),2)

# calculo del indice de masa corporal
# peso (en kgs) dividido por talla (en cms)
IMC = PESO / (TALLA/100)^2
mean(IMC)

# promedios 
aggregate(PESO~SEXO,FUN=mean)
aggregate(TALLA~SEXO,FUN=mean)
aggregate(IMC~SEXO,FUN=mean)
aggregate(PESO~DIABETES,FUN=mean)
aggregate(HDL~DIABETES, FUN=mean)

# y un largo etcetera...

