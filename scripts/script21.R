# ----- tidyverse: profundizando  -----

# ----- elecciones ----- 

# leemos datos de wikipedia
library(rvest)
library(tidyverse)
wiki <-
  paste0("https://en.wikipedia.org/wiki/Opinion_polling_for_the_next_Spanish_general_election")

# Leemos html
html <- read_html(wiki)
# Seleccionamos las tablas del HTML
tablas <- html_elements(html, ".wikitable")

# Obtenemos las dos primeras tablas: encuestas de 2022 y 2021
encuestas_2022 <- html_table(tablas[[1]])
encuestas_2022
encuestas_2021 <- html_table(tablas[[2]])
encuestas_2021

# Renombramos columnas
nombre_cols <-
  c("casa", "fechas", "muestra", "participacion", "PSOE", "PP",	"Vox",
    "UP", "Cs", "ERC", "MP", "JxCat",	"PNV",	"EHBildu", "CUP",
    "CC", "BNG", "NA+", "PRC", "EV", "ventaja")
names(encuestas_2022) <- names(encuestas_2021) <- nombre_cols
encuestas_2022
encuestas_2021

# Eliminar filas
encuestas_2022 <- encuestas_2022 %>% slice(-1)
encuestas_2022
encuestas_2021 <- encuestas_2021 %>% slice(-1)
encuestas_2021


# Añadir columna de año
encuestas_2022 <- encuestas_2022 %>% mutate(anno = 2022)
encuestas_2021 <- encuestas_2021 %>% mutate(anno = 2021)

# Juntar tablas
encuestas <- rbind(encuestas_2022, encuestas_2021)

# Convertir a numéricas
encuestas_depurado <-
  encuestas %>%
  # Quitamos "," como millares en números
  mutate(muestra = gsub("?", "", gsub(",", "", muestra)),
         participacion = gsub("?", NA, participacion)) %>%
  mutate_at(vars(!contains(c("casa", "fechas"))), as.numeric)
encuestas_depurado

# Convertir las fechas de campo
fechas_intermedias <- str_split(encuestas_depurado$fechas, "–")
fechas_intermedias <-
  map_dfr(fechas_intermedias,
          function(x) { tibble("fecha_inicio" = x[1],
                               "fecha_final" = x[2]) })
fechas_intermedias <-
  fechas_intermedias %>% 
  mutate(fecha_final = ifelse(is.na(fecha_final),
                              fecha_inicio, fecha_final))
fechas_intermedias <-
  fechas_intermedias %>% 
  mutate(fecha_inicio =
           ifelse(nchar(fecha_inicio) <= 2,
                  paste(fecha_inicio,
                        paste0(rev(rev(unlist(str_split(fecha_final, "")))[1:3]),
                               collapse = "")), fecha_inicio))
library(lubridate)
encuestas_depurado <-
  bind_cols(encuestas_depurado,
            fechas_intermedias) %>%
  mutate(fecha_inicio = dmy(paste(fecha_inicio, anno)),
         fecha_final = dmy(paste(fecha_final, anno))) %>%
  select(-c(fechas, anno, fecha_inicio)) %>%
  relocate(fecha_final, .after = casa)
encuestas_depurado

# Limpiamos nombres de encuestas
encuestas_depurado <-
  encuestas_depurado %>%
  # Limpiamos nombre encuestas
  mutate(casa = toupper(map_chr(str_split(casa, "\\["),
                                function (y) { y[1] } )))
# Consultas

# ¿Cuáles son las 10 encuestas con mayor tamaño muestral?
encuestas_depurado %>% slice_max(muestra, n = 10)

# ¿Cuáles son las encuestas más recientes?
encuestas_depurado %>% arrange(desc(fecha_final))

# ¿Cuáles son las 5 encuestas en las que el PSOE tiene mayor proyección?
encuestas_depurado %>% slice_max(PSOE, n = 5)

# ¿Cuál es la encuesta del CIS en la que el PP tiene mayor proyección?
encuestas_depurado %>%
  filter(casa == "CIS") %>%
  slice_max(PP, n = 1)

# ¿Cuál es el promedio de las encuestas del PSOE y PP por casa encuestadora?
encuestas_depurado %>%
  select(-fecha_final) %>%
  group_by(casa) %>%
  summarise(media_PSOE = mean(PSOE), media_PP = mean(PP)) %>%
  ungroup()

# ¿Cuál es son las 3 casas encuestadoras más sesgada hacia el PSOE
# (con mayor diferencia de promedio de PSOE vs PP)? ¿Y hacia el PP?
encuestas_depurado %>%
  select(-fecha_final) %>%
  group_by(casa) %>%
  summarise(media_PSOE = mean(PSOE), media_PP = mean(PP)) %>%
  ungroup() %>%
  mutate(diferencia = media_PSOE - media_PP) %>%
  slice_max(diferencia, n = 3)
encuestas_depurado %>%
  select(-fecha_final) %>%
  group_by(casa) %>%
  summarise(media_PSOE = mean(PSOE), media_PP = mean(PP)) %>%
  ungroup() %>%
  mutate(diferencia = media_PP - media_PSOE) %>%
  slice_max(diferencia, n = 3)
