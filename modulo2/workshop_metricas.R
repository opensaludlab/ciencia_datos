library(tidyverse)
library(lubridate)
library(readxl)
library(Rmisc)

# Carga del archivo
atenciones <- read_excel("modulo2/data/Atenciones_Urgencia_2021.xlsx")


## Limpieza ----

# Selección de una parte del archivo (patologías respiratorias), usando slice()
respiratorias <- atenciones |> 
  slice(4:11)

# Ajuste de nmbre de variable y limpieza de las variables usando expresiones regulares (regex)
respiratorias <- respiratorias |> 
  rename(tipo = "Tipo atención") |> 
  mutate(tipo = str_remove(tipo, pattern = " \\(([^\\)]+)\\)"))

# Dado que el dataframe no es tidy, lo ajustamos a un formato largo con pivot_longer()
respiratorias_long <- respiratorias |> 
  pivot_longer(cols = -tipo,
               names_to = "fecha",
               values_to = "n")

# Parseo de tipo de variables para poder trabajar mejor con ellas
respiratorias_long <- respiratorias_long |> 
  mutate(tipo = factor(tipo),
         fecha = ymd(fecha))


## Análisis estadísticos ----

# Breve análísis exploratorio con DataExplorer
#install.packages("DataExplorer")
library(DataExplorer)

introduce(respiratorias_long)
plot_intro(respiratorias_long)

# Algunas métricas generales
sum(respiratorias_long$n)
min(respiratorias_long$n)
max(respiratorias_long$n)

# Calculamos varias métricas de resumen de nuestro dataframe.
# Fíjate en la agrupación con group_by() y los diferentes resultados que podrías obtener.
# Intenta cambialos. Aplica otras funciones de lubridate como quarter 

respiratorias_long |> 
  group_by(mes = month(fecha)) |> # Prueba usando quarter(), week(), year()
  #group_by(tipo, mes = month(fecha)) |> 
  dplyr::summarise(total = sum(n),
            min = min(n),
            max = max(n),
            IQR = IQR(n),
            mean = mean(n),
            se = sd(n),
            median = median(n),
            q10 = quantile(n, probs = 0.1),
            q90 = quantile(n, probs = 0.9),
            upper_ci = CI(n, 0.95)[1],
            lower_ci = CI(n, 0.95)[3]
            ) |> 
  View()

# Intervalo de confianza 95% (librería Rmisc)
CI(respiratorias_long$n, 0.95)


# Generación de tabla resumen
attach(respiratorias_long)

numero <- cut(n, breaks = nclass.Sturges(n))
Freq <- as.data.frame(table(numero))
tabla <- transform(Freq, cum_freq = cumsum(Freq), 
                   rel = prop.table(Freq), cum_rel = cumsum(prop.table(Freq)))
tabla

detach(respiratorias_long)


## Plots ----

# Histograma usando R base
hist(respiratorias_long$n)

# Usando ggplot2
respiratorias_long |> 
  ggplot(aes(n)) +
  geom_boxplot()

respiratorias_long |> 
  ggplot(aes(n, tipo)) +
  geom_boxplot()

respiratorias_long |> 
  ggplot(aes(n)) +
  geom_histogram() +
  facet_wrap(~ tipo)

respiratorias_long |> 
  ggplot(aes(fecha, n, color = tipo)) +
  #geom_path()
  geom_smooth(se = FALSE)


# El mismo gráfico anterior, pero más lindo 

library(RColorBrewer)

respiratorias_long |> 
  ggplot(aes(fecha, n, color = tipo)) +
  geom_smooth(se = FALSE, size = 1.5, alpha = 0.8) +
  theme_classic() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  labs(title = "Atenciones diarias de urgencia en hospitales públicos de Chile - 2021",
       subtitle = "Por causa respiratoria\nCurva suavizada por método LOESS\n",
       caption = "\nElaborado por Paulo Villarroel\nBootcamp Data Science OpenSalud LAB (datascience.opensaludlab.org)\nFuente: DEIS - Chile",
       x = "",
       y = "N° atenciones diarias",
       color = "Motivo atención") +
  theme(plot.title = element_text(size = 21, face = "bold"),
        plot.subtitle = element_text(size = 14)) +
  scale_color_brewer(palette = "Set2")

  