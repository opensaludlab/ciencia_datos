## Repasando librería dplyr
## Paulo Villarroel 
## Academia OpenSalud LAB Ciencia de datos para salud pública

library(tidyverse)
library(lubridate)
library(plotly)

# Funciones dplyr ---------------------------------------------------------

casos <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv")

# Ajustemos los nombre de las variables por uno más manejables
names_list_casos <- c("region", "cod_region", "comuna", "cod_comuna", "poblacion", "fecha", "casos")
names(casos) <- names_list_casos

# Usemos select, filter, group_by y mutate
antofagasta <- casos %>% 
  filter(region == "Antofagasta")

casos_agrup <- casos %>% 
  group_by(region, fecha) %>%
  mutate(total = sum(casos, na.rm = TRUE),
         incidencia_100mil = casos / poblacion * 100000) %>% 
  ungroup()

casos %>% 
  mutate(incidencia_100mil = casos / poblacion * 100000) %>% 
  head(20)

# usemos juntas las funciones de manipulación con visualización
casos_agrup %>% 
  filter(region == "Antofagasta") %>% 
  ggplot(aes(fecha, total)) +
  geom_path() +
  scale_x_date(breaks = "1 month", date_labels = "%B %Y") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1))

plot <- casos_agrup %>%
  ggplot(aes(fecha, total, color = region)) +
  geom_path() +
  scale_y_continuous(labels = scales::comma)
plot

#Agregemosle un poco de ineteractividad al gráfico
ggplotly(plot)


# Creemos dos tibbles para usar las funciones de dplyr
ingresos <- tribble(~mes, ~ingresos,
                   "Enero", 200,
                   "Febrero", 344,
                   "Marzo", 455,
                   "Abril", 222,
                   "Mayo", 890
                   )

ingresos <- ingresos %>% 
  mutate(dif = ingresos - lag(ingresos))

ingresos %>% 
  mutate(ifelse(dif > 0, "Ehhh", "Buuu"))

# Creemos otro tibble (ejemplo realizado en el taller)
llegadas <- tribble(~inicio, ~fin,
                    "2020-10-10 10:45", "2020-10-10 10:54",
                    "2020-11-02 22:20", "2020-11-03 01:33",
                    "2020-11-09 10:34", "2020-11-09 14:43"
                    )
llegadas$inicio <- ymd_hm(llegadas$inicio)
llegadas$fin <- ymd_hm(llegadas$fin)

llegadas <- llegadas %>% 
  mutate(time = fin - inicio,
         dif = time - lag(time))
  

# Veamos qué podemos hacer con el dataset Iris
# Fíjate que las funciones se pueden concatenar 
iris <- iris
colnames(iris)

sepal_iris <- iris %>% 
  select(Species, starts_with("Sepal"))

iris %>% select(Species, Petal.Length, Petal.Width)
iris %>% select_if(is.numeric)
iris %>% select(1:3)
iris %>% arrange(-Sepal.Length) %>% 
  head(20)
iris %>% filter(Species %in% c("setosa", "virginica"))
iris %>% filter(between(Petal.Length, 1.3, 5.5))


iris %>% 
  group_by(Species) %>% 
  summarise(media = mean(Petal.Length),
            min = min(Petal.Length),
            max = max(Petal.Length),
            p20 = quantile(Petal.Length, prob = 0.2),
            p80 = quantile(Petal.Length, prob = 0.8)
            )

# Mutate con case_when ----------------------------------------------------

casos_edad <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto16/CasosGeneroEtario.csv")

# transformamos a un formato tidy con pivot_longer()
casos_edad_long <- pivot_longer(casos_edad, 
                                cols = starts_with("20"),
                                names_to = "Fecha",
                                values_to = "Casos"
                                )

casos_edad_long$`Grupo de edad` %>% unique()

# Case_when() permite asignar un valor dada una condición que se puede especificar
casos_edad_long <- casos_edad_long %>% 
  mutate(grupo = case_when(
    `Grupo de edad` == "00 - 04 años" ~ "< 10 años",
    `Grupo de edad` == "05 - 09 años" ~ "< 10 años",
    `Grupo de edad` == "10 - 14 años" ~ "10 - 19 años",
    `Grupo de edad` == "15 - 19 años" ~ "10 - 19 años",
    `Grupo de edad` == "20 - 24 años" ~ "20 - 39 años",
    `Grupo de edad` == "25 - 29 años" ~ "20 - 39 años",
    `Grupo de edad` == "30 - 34 años" ~ "20 - 39 años",
    `Grupo de edad` == "35 - 39 años" ~ "20 - 39 años",
    `Grupo de edad` == "40 - 44 años" ~ "40 - 59 años",
    `Grupo de edad` == "45 - 49 años" ~ "40 - 59 años",
    `Grupo de edad` == "50 - 54 años" ~ "40 - 59 años",
    `Grupo de edad` == "55 - 59 años" ~ "40 - 59 años",
    `Grupo de edad` == "60 - 64 años" ~ "60 - 79 años",
    `Grupo de edad` == "65 - 69 años" ~ "60 - 79 años",
    `Grupo de edad` == "70 - 74 años" ~ "60 - 79 años",
    `Grupo de edad` == "75 - 79 años" ~ "60 - 79 años",
    `Grupo de edad` == "80 y más años" ~ "80 y más")
  )

casos_edad_long$grupo %>% unique()

# Ahora podemos usar los datos anteriores para hacer un gráfico
last_date <- max(casos_edad_long$Fecha)
sex <- as_labeller(c(M = "Masculino", F = "Femenino"))

casos_edad_long %>% 
  filter(Fecha == last_date) %>% 
  ggplot(aes(grupo, Casos, fill = grupo)) + 
  geom_col(show.legend = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(~ Sexo, labeller = sex) +
  labs(title = "Edad de casos confirmados COVID-19. Chile",
       subtitle = paste("Actualizado al", last_date),
       caption = "Fuente: Ministerio de Ciencias y Tecnología / Ministerio de Salud\nPlot: Paulo Villarroel",
       x = "",
       y = "N° de casos") +
  theme(plot.title = element_text(size = 18))


# Tipos de Joint -------------------------------------------------------------------

personas <- tribble(~nombre, ~edad, ~sexo, ~ciudad,
                     "Paulo", 39, "M", "Santiago",
                     "Maria", 23, "F", "Talca",
                     "Josefina", 67, "F", "Santiago",
                     "Roberto", 22, "M", "Calama",
                     "Trini", 27, "F", "Santiago"
                    )
compras <- tribble(~nombre, ~consola, ~juego,  ~valor,
                   "Paulo", "nintendo", "juego1", 60000,
                   "Maria", "xboxs", "juego1", 55000,
                   "Josefina", "xboxs", "juego3", 58000,
                   "Paulo", "nintendo", "juego4", 45000,
                   "Roberto", "ps5", "juego5", 67000,
                   "Roberto", "ps5", "juego7", 33000,
                   "Luis", "nintendo", "juego2", 63000,
                   "Paola", "ps5", "juego3", 46000
                   )

left_join <- left_join(personas, compras)
right_join <- right_join(personas, compras)
inner_join <- inner_join(personas, compras)
full_join <- full_join(personas, compras)
semi_join <- semi_join(personas, compras)
anti_join <- anti_join(personas, compras)

