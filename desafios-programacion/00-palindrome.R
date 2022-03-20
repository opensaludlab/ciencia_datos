## Desafío de programación 00 Palindrome

# Crea un programa que permita identificar si una palabra es un palíndromo.
# Un palíndromo es una palabra que se lee igual de izquierda a derecha que de derecha a izquierda.


library(tidyverse)

palindrome <- function(x) {
  if (is.character(x) == FALSE) {
    "No es una palabra"
  } else {
    x <- tolower(x) |> 
       str_trim()
    split <- strsplit(x, "")[[1]]
    reversed <- rev(split)
    join <- paste(reversed, collapse = "")

    if (join == x) {
      "Es un palíndromo"
    } else {
      "No es un palíndromo"
    }
  }
}


# Ejemplos de uso

palindrome("paulo")
palindrome("radar ")
palindrome("ana")
palindrome("auto")
palindrome(44444)
