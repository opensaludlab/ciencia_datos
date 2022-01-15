library(readxl)
library(writexl)
library(tidyverse)
library(janitor)

indicators <- read_excel("Talleres/data/Popular_Indicators.xlsx", sheet = "Data")

str(indicators)
colnames(indicators)
unique(indicators$`serie Name`)
tail(indicators)

indicators <- read_excel("Talleres/data/Popular_Indicators.xlsx", 
                         sheet = "Data",
                         range = "A1:Y11068")


listado <- read_excel("Talleres/data/listado_pacientes.xlsx", skip = 7) 
head(listado)
tail(listado)

listado <- read_excel("Talleres/data/listado_pacientes.xlsx",
                      range = cell_rows(c(9:2089))) |> 
  select(-c(2:3)) |> 
  clean_names()


# Leer multiples archivos

files <- list.files(path = "Talleres/data", pattern = "archivo", full.names = TRUE) |> 
  map_df(~ read_excel(., col_names = TRUE))


# Leer archivos con varias hojas

sheet_names <- excel_sheets("Talleres/data/archivo1.xlsx")
sheet_names

list_all <- lapply(sheet_names, function(x) {
  as.data.frame(read_excel("Talleres/data/archivo1.xlsx", sheet = x, col_names = TRUE))
})

names(list_all) <- sheet_names
list_all
list_all$febrero


# Varios archivos, varias hojas

library(data.table)

files_path <- list.files(path = "Talleres/data", pattern = "archivo", full.names = TRUE)

names_files <- list.files(path = "Talleres/data", pattern = "archivo") |>
  str_extract_all(pattern = ".*[^.xlsx]", simplify = TRUE)


df_list <- lapply(files_path, function(x) {
  sheets <- excel_sheets(x)
  dfs <- lapply(sheets, function(y) {
    read_excel(x, sheet = y, col_names = TRUE)
  })
  names(dfs) <- sheets
  dfs
})

names(df_list) <- names_files


# Otras forma de entrar a ver los datos en una lista

df_list$archivo1$enero
walk(df_list, .f = print)


# Pasar de una lista a dataframe
data <- rbindlist(lapply(df_list, rbindlist, id = "mes"))



# Guardar Excel

write_xlsx(data, "Talleres/data/data_completa.xlsx")

