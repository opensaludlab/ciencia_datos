## Taller visualizaciones con ggplot2

# Cargar las librerías necesarias
library(tidyverse)
library(plotly)
library(zoo)

# Importar el dataset
fallecidos_raw <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto84/fallecidos_comuna_edad_totales_std.csv")

# Preparar la data
fallecidos <- fallecidos_raw |>
  dplyr::filter(
    Fecha >= "2021-01-01",
    Region == "Metropolitana"
  ) |>
  dplyr::mutate(
    Grupo_etario = case_when(
      Edad == "<=39" ~ "<=39",
      Edad == "40-49" ~ "40-69",
      Edad == "50-59" ~ "40-69",
      Edad == "60-69" ~ "40-69",
      Edad == "70-79" ~ ">=70",
      Edad == "80-89" ~ ">=70",
      Edad == ">=90" ~ ">=70"
    ),
    Grupo_etario = factor(Grupo_etario, levels = c("<=39", "40-69", ">=70"))
  ) |>
  dplyr::group_by(Grupo_etario, Fecha) |>
  dplyr::summarise(Fallecidos = sum(Total)) |>
  dplyr::mutate(Media_movil = round(rollmean(Fallecidos, k = 7, fill = NA), 1))


# Gráficar con ggplot2
fallecidos_plot <- fallecidos |>
  ggplot(aes(Fecha, Media_movil,
    color = Grupo_etario
  )) +
  geom_line(size = 1) +
  scale_color_manual(
    name = "Grupo etario",
    values = c("red", "blue", "green"),
    labels = c("Menores 39 años", "Entre 40 y 69 años", "Mayores 70 años")
  ) +
  theme_bw() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(
    x = "",
    y = "N° Fallecidos (Media móvil)",
    title = "Fallecimientos por COVID-19 durante 2021. Región Metropolitana, Chile",
    subtitle = "Media móvil semanal",
    caption = "\nFuente: Ministerio de Ciencias y Tecnología"
  )

fallecidos_plot

# Usando plotly
ggplotly(fallecidos_plot)
