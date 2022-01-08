# ----- importar/exportar -----


# Pasajeros del RMS Titanic (archivo .RData)
# Fuente original de los datos: <https://www.kaggle.com/c/titanic/overview>
load("./DATOS/titanic.RData") # carga nativa .RData
library(tibble)
titanic <- as_tibble(titanic)
glimpse(titanic)
titanic

# Datos covid del ISCIII (archivo .csv)
library(readr)
titanic <- read_csv(file = "./DATOS/titanic.csv")
titanic

# desde url
datos_ISCIII <- read_csv(file = "https://cnecovid.isciii.es/covid19/resources/casos_tecnica_ccaa.csv")
datos_ISCIII
dim(datos_ISCIII)
glimpse(datos_ISCIII)

# Discursos de los jefes de Estado (archivo .txt)
discurso_1937 <-
  read_delim(file = "https://raw.githubusercontent.com/lirondos/discursos-de-navidad/master/data/speeches/1937.txt", delim = "\t")
discurso_1937

# De cada frase guardada (cada fila) podemos extraer cada palabra
# con la función `str_split()`
library(stringr)
# Primera frase separando palabras
str_split(discurso_1937[1, ], pattern = " ")

# Pisos en Boston (archivo Excel .xlsx)
library(readxl)
boston <- read_xlsx(path = "./DATOS/Boston.xlsx")
boston
glimpse(boston)

# Estadísticas del Eurostat (desde paquete)
library(eurostat) # instalar la primera vez
datos_disponibles <- search_eurostat("passengers")
datos_disponibles
View(datos_disponibles)

# Datos del AEMET (desde paquete + API)
# Clave para conectar con la API del AEMET
api_key <- "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYXZhbHYwOUB1Y20uZXMiLCJqdGkiOiIwNGUwYmQzNi1jZTMxLTQ5OTQtOTdkMy1hMzc4MDc1MzlhMjgiLCJpc3MiOiJBRU1FVCIsImlhdCI6MTY0MTU0OTg4MywidXNlcklkIjoiMDRlMGJkMzYtY2UzMS00OTk0LTk3ZDMtYTM3ODA3NTM5YTI4Iiwicm9sZSI6IiJ9.RCAITYkYO_uPOzTA830tuq6LZNgmiUGuQ2vB6hrZioI"
Sys.setenv(AEMET_API_KEY = api_key) 
# Instalamos paquete climaemet
library(devtools)
install_github("ropenspain/climaemet")

# Estaciones del AEMET
library(climaemet)
tabla_estaciones <- as_tibble(aemet_stations())
tabla_estaciones

datos_bcn_aeropuerto <-
  as_tibble(aemet_last_obs("0076"))
datos_bcn_aeropuerto

datos <-
  as_tibble(aemet_daily_clim("0076",
                             start = "2018-01-01",
                             end = "2021-12-31"))
datos

# Datos electorales (desde paquete + API)

library(devtools)
install_github("ropenspain/infoelectoral")
library(infoelectoral)
datos_2019 <- municipios(tipo_eleccion = "congreso",
                         anno = 2019, mes = 11)

# Partidas de ajedrez (desde Github) 
# Instalamos paquete desde Github
library(devtools)
install_github("JaseZiv/chessR")
# Accedemos a datos de chess.com
library(chessR)
datos <- get_game_data(usernames = "dadosdelaplace")
head(datos)

