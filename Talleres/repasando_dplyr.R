## Repasando librería dplyr
## Paulo Villarroel 
## Academia OpenSalud LAB Ciencia de datos para salud pública

library(tidyverse)
library(lubridate)
library(plotly)

# Funciones dplyr ---------------------------------------------------------

casos <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19_std.csv")

names_list_casos <- c("region", "cod_region", "comuna", "cod_comuna", "poblacion", "fecha", "casos")
names(casos) <- names_list_casos


casos_agrup <- casos %>% 
  group_by(region, fecha) %>%
  mutate(total = sum(casos, na.rm = TRUE)) %>% 
  ungroup()

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
ggplotly(plot)


antofagasta <- casos %>% 
  filter(region == "Antofagasta")


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


iris <- iris
colnames(iris)

sepal_iris <- iris %>% 
  select(Species, starts_with("Sepal"))

iris %>% arrange(desc(Sepal.Length)) %>% head()

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

casos_edad_long <- pivot_longer(casos_edad, 
                                cols = starts_with("20"),
                                names_to = "Fecha",
                                values_to = "Casos"
                                )

casos_edad_long$`Grupo de edad` %>% unique()

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

