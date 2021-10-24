library(tidyverse)
library(lubridate)

# Carga de datos repositorio remoto

casos <- read_csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto3/TotalesPorRegion_std.csv")

str(casos)
unique(casos$Region)
unique(casos$Categoria)


# Uso de filter, group_by y summarise
casos |> 
  filter(Region != "Total",
         Categoria == "Casos nuevos totales") |>
  group_by(Anio = year(Fecha)) |> 
  summarise(Total_nuevos = sum(Total, na.omit = TRUE))

resumen_chile <- casos |>
  filter(Region != "Total",
         Categoria == "Casos nuevos totales") |>
  group_by(Region, Anio = year(Fecha), Mes = month(Fecha)) |> 
  summarise(Total_nuevos = sum(Total, na.omit = TRUE))
  
casos |> 
  filter(Region != "Total",
         Categoria == "Casos nuevos totales") |> 
  group_by(Region, Anio = year(Fecha)) |> 
  summarise(Tota_nuevos = sum(Total, na.omit = TRUE)) |>
  print(n = 32)

casos |> 
  filter(Categoria == "Casos nuevos totales") |> 
  group_by(Semana = week(Fecha)) |> 
  summarise(Total = sum(Total)) |> 
  mutate(Var = (Total / lag(Total) - 1) * 100) |> #Calcular porcentage de variación semanal
  filter(Semana != 53) |> 
  ggplot(aes(Semana, Var)) +
  geom_line() +
  geom_smooth()

casos_nuevos_rm <- casos |> 
  filter(Categoria == "Casos nuevos totales",
         Region == "Metropolitana") |> 
  mutate(Nuevos = Total - lag(Total),
         Fecha = ymd(Fecha))


# Uso de select

casos |> 
  #select(Categoria, Total)
  select(-c(Categoria, Total))

casos |> 
  select_if(is.numeric)

casos |> 
  filter(Region != "Total",
         Categoria == "Fallecidos totales") |> 
  #arrange(-Total) |> 
  arrange(Fecha, .by_group = TRUE) |> 
  #head(20)  
  tail(20)

casos |> 
  filter(Region %in% c("Valparaiso", "Maule"))

casos |> 
  filter(Region %in% c("Total", "Metropolitana") == FALSE) |> 
  #filter(!Region %in% c("Total", "Metropolitana")) |> 
  slice_max(Total, n = 5)

casos |> 
  filter(between(Total, 1000, 2000))


# Plots

casos_nuevos_rm |> 
  ggplot(aes(Fecha, Nuevos)) +
  geom_col()

#install.packages("zoo")
library(zoo)

casos_nuevos_rm <- casos_nuevos_rm |> 
  mutate(Media_movil = rollmean(Nuevos, k = 7, fill = NA),
         mi_color = ifelse(Media_movil > 0, "tipo1", "tipo2"))


plot <- casos_nuevos_rm |> 
  ggplot(aes(Fecha, Media_movil, fill = mi_color)) +
  geom_col(show.legend = FALSE) +
  scale_x_date(breaks = "month",
               date_labels = "%b-%Y") +
  scale_fill_manual(values = c("#fc8d62", "#66c2a5")) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        plot.title = element_text(size = 23, face = "bold"),
        plot.subtitle = element_text(size = 16)) +
  labs(title = "Variación de casos nuevos diarios COVID-19",
       subtitle = "Región Metropolitana, Chile",
       caption = "Fuente: Ministerio de Ciencias y Tecnología | Elaborado por Paulo Villarroel",
       x = "",
       y = "\nVariación casos nuevos (media movil semanal)") +
  annotate(
    geom = "curve", x = as.Date("2021-09-18"), y = 0, xend = as.Date("2021-08-01"), yend = 250, 
    curvature = .3, arrow = arrow(length = unit(3, "mm"))
    ) +
  annotate(geom = "text", x = as.Date("2021-06-20"), y = 270, label = "Fiestas patrias", hjust = "left", size = 5)


# Loop para gráfico para cada región

casos_nuevos_regiones <- casos |> 
  filter(Categoria == "Casos nuevos totales") |> 
  group_by(Region) |> 
  mutate(Nuevos = Total - lag(Total),
         Fecha = ymd(Fecha),
         Media_movil = rollmean(Nuevos, k = 7, fill = NA),
         mi_color = ifelse(Media_movil > 0, "tipo1", "tipo2"))


regiones <- unique(casos$Region)

for(i in seq_along(regiones)) {
  
  plot_regiones <- casos_nuevos_regiones |> 
    filter(Region == regiones[i]) |> 
    ggplot(aes(Fecha, Media_movil, fill = mi_color)) +
    geom_col(show.legend = FALSE) +
    scale_x_date(breaks = "month",
                 date_labels = "%b-%Y") +
    scale_fill_manual(values = c("#fc8d62", "#66c2a5")) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
          plot.title = element_text(size = 23, face = "bold"),
          plot.subtitle = element_text(size = 16)) +
    labs(title = "Variación de casos nuevos diarios COVID-19",
         subtitle = paste0(regiones[i], ", Chile"),
         caption = "Fuente: Ministerio de Ciencias y Tecnología",
         x = "",
         y = "\nVariación casos nuevos (media movil semanal)")
  
  print(plot_regiones)
  
}
