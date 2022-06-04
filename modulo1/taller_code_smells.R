## Code smells

# Errores tipográficos / sintaxis

a <- "Paulo"
my_variable <- "Paulo"
mane <- "Paulo"
this_is_my_large_name_of_variable <- "Paulo"


# Identación

name <- function(name) {
  if (name == "Paulo") {
    print(name)
  }
}


# Copy & Paste


# Repetir código (don´t repeat yourself DRY)

library(tidyverse)

data_covid <- read_csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv")

data_covid |>
  filter(location == "Argentina") |>
  summarise(total_deaths = sum(new_deaths, na.rm = TRUE))

data_covid |>
  filter(location == "Chile") |>
  summarise(total_deaths = sum(new_deaths, na.rm = TRUE))

data_covid |>
  filter(location == "Peru") |>
  summarise(total_deaths = sum(new_deaths, na.rm = TRUE))



countries <- c("Argentina", "Chile", "Peru")

data_covid |>
  filter(location %in% countries) |>
  group_by(location) |>
  summarise(total_deaths = sum(new_deaths, na.rm = TRUE))


# Comentarios no necesarios


# Comentar / descomentar

#x <- 1:6
x <- c("a", "b", "c", "d")

cat("My favorite numbers are", x)


cat(
  "My favorite numbers are",
  if (is.numeric(x)) {
    x
  } else {
    "none"
  }
)


# No programar en inglés


# No pensar en el futuro


# Usar if else con moderación
# Ejemplo tomado de https://github.com/jennybc/code-smells-and-feels

get_some_data <- function(config, outfile) {
  if (config_ok(config)) {
    if (can_write(outfile)) {
      if (can_open_network_connection(config)) {
        data <- parse_something_from_network()
        if(makes_sense(data)) {
          data <- beautify(data)
          write_it(data, outfile)
          return(TRUE)
        } else {
          return(FALSE)
        }
      } else {
        stop("Can't access network")
      }
    } else {
      ## uhm. What was this else for again?
    }
  } else {
    ## maybe, some bad news about ... the config? 
  }
}


# Usar funciones con responsabilidad única (single responsibility principle)

covid_deaths <- function(country) {
  
  data_covid <- read_csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv")
  total_deaths <- as.data.frame(
    data_covid |>
      filter(location == country) |>
      summarise(total_deaths = sum(new_deaths, na.rm = TRUE))
  )

  print(total_deaths)
  write.csv(total_deaths, "modulo1/deaths.csv")
  
}

covid_deaths("Chile")
