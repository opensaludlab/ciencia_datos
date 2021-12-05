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
  dplyr::mutate(Media_movil = round(rollmean(Fallecidos, k = 7, fill = NA), 1)) |>
  dplyr::ungroup()


# Graficar con ggplot2
fallecidos_plot <- fallecidos |>
  ggplot(aes(Fecha, Fallecidos)) +
  geom_line(aes(color = Grupo_etario), size = 0.8, alpha = 0.3) +
  geom_line(aes(Fecha, Media_movil, color = Grupo_etario), size = 1.5) +
  scale_color_manual(
    name = "Grupo etario",
    values = c("#7fc97f", "#beaed4", "#fdc086"),
    labels = c("Menores 39 años", "Entre 40 y 69 años", "Mayores 70 años")
  ) +
  theme_bw() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y") +
  labs(
    x = "",
    y = "N° Fallecidos",
    title = "Fallecimientos por COVID-19 por grupo etario. Región Metropolitana, Chile. 2021",
    subtitle = "Se incluyen tanto casos confirmados como sospechosos.\nSe usó la media móvil semanal para suavizar la curva.",
    caption = "\nFuente: Ministerio de Ciencias y Tecnología"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
    plot.title = element_text(size = 17)
  )

fallecidos_plot

# Usando plotly
ggplotly(fallecidos_plot)
