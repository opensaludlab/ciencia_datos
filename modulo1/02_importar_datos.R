## Academia OpenSalud LAB


# Cargar librerías --------------------------------------------------------

library(haven)

# Cargar datos ------------------------------------------------------------

ens <- read_sav("data/ENS_2017.sav")
View(ens)

tabaquismo <- ens %>% 
  select(1:11, starts_with("ta"))
inicio_tab <- tabaquismo %>% 
  select(ta6)
inicio_tab$ta6 <- as_factor(inicio_tab$ta6)
levels(inicio_tab$ta6)
inicio_tab2 <- inicio_tab %>% 
  filter(ta6 != "NO RESPONDE", ta6 != "NO SABE")
inicio_tab2$ta6 <- as.numeric(inicio_tab2$ta6)
inicio_tab2 %>% 
  ggplot(aes(ta6)) +
  geom_histogram(bins = 40) +
  scale_x_continuous(breaks = seq(0, 70, by = 5))

edad_tab <- inicio_tab2 %>% 
  group_by(ta6) %>% 
  summarise(n = n())


# Seleccion de variables curso --------------------------------------------


encuesta <- ens %>% 
  select(1, 3:5, 8:9, 11, 1088:1094, 1099:1101, 1106, 
         starts_with(c("ta", "h", "di", "m2", "m4", "m5", "m8", "m9")))

write.csv(encuesta, "data/encuesta.csv")

df <- read.csv("data/encuesta.csv")

colnames(encuesta)
