rm(list=ls())
gc()
library(tidyverse)
library(brazilmaps)
library(plotly)
library(RColorBrewer)
library(GADMTools)
setwd("~/rrg1@de.ufpe.br/UFSM/Dashboards/Soybean")

soy_data <- read_csv("soy_data.csv", col_types = cols(CODIGO = col_double(), 
                      PT2017 = col_double(), PT2018 = col_double(), 
                      QT2017 = col_double(), QT2018 = col_double()))

map_rs<- get_brmap("City") %>% filter(State==43) %>% inner_join(soy_data, c("City" = "CODIGO"))  %>%
  mutate(rQT2017 =  cut(QT2017,  breaks = quantile(na.omit(QT2017)))
         )

my_blue = brewer.pal(n = 9, "Oranges")


PRODUCTION2017a<- map_rs %>%
  ggplot(aes(map_id = MUNICIPIOS)) +
  geom_sf(aes(fill = QT2017), size = 0.05) #+ xlim(c(52,50)) +
  scale_fill_gradient(name = "% Votos PSOL",low = my_blue[3], high = my_blue[7], na.value = "grey90")
PRODUCTION2017a

PRODUCTION2017b<- map_rs %>%
  ggplot(aes(map_id = MUNICIPIOS)) +
  geom_sf(aes(fill = QT2017), size = 0.05) +
  scale_fill_gradient(low = my_blue[3], high = my_blue[7], na.value = "grey90")
  # scale_fill_manual(values = c(my_blue))


my_blue = brewer.pal(n = 9, "Blues")

PRODUCTION2017c<- map_rs %>%
  ggplot(aes(map_id = MUNICIPIOS)) +
  geom_sf(aes(fill = QT2017), size = 0.05) +
  scale_fill_gradient(name = "% Votos PSOL",low = my_blue[3], high = my_blue[7], na.value = "grey90")



# save.image("dados.RData")
