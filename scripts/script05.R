
# ----- Datos numéricos -----

# Dato numérico (double)
a <- 1
class(a)
typeof(a)

# Dato numérico (entero)
a <- 1L
class(a)
typeof(a)

# Definimos dos variables numéricas
a <- 1
b <- -2

# Suma y resta
a + b
a - b

# Multiplicación y división
a * b
a / b

# Raíz cuadrada
sqrt(a)

# Valor absoluto
abs(b)

# Potencias
a^2
b^3

# ----- Datos de tipo texto -----

# Definimos una variable de tipo character
nombre <- "Javier"
class(nombre)
typeof(nombre)

# Pegar cadenas de texto
nombre <- "Javier"
apellido <- "Álvarez"
paste(nombre, apellido, sep = "") # todo junto
paste(nombre, apellido, sep = " ") # separados por un espacio
paste(nombre, apellido, sep = ".") # separados por un punto .

# Son equivalentes
paste(nombre, apellido, sep = "") # todo junto
paste0(nombre, apellido) # todo junto sin nada separando

# Paquete glue
install.packages("glue") # solo la primera vez
library(glue)
edad <- 32
glue("La edad es de {edad} años")
paste("La edad es de", edad, "años") # equivalente

# Ejemplo 2
edad <- 32
unidades <- "años"
glue("La edad es de {edad} {unidades}")

# ----- Datos lógicos -----

# Variables lógicas
soltero <- TRUE
class(soltero)
typeof(soltero)

carnet_conducir <- FALSE
class(carnet_conducir)
typeof(carnet_conducir)

# Comparativas
soltero == TRUE
soltero != TRUE # igual que soltero == FALSE
carnet_conducir == TRUE
carnet_conducir != TRUE
nombre == "Carlos"
edad < 32
edad == 32
edad >= 32

# Varias condiciones a la vez
edad > 32 | soltero # nos sirve con que alguna se cumpla
edad > 32 & soltero # deben cumplirse ambas
edad > 30 & soltero # deben cumplirse ambas

# ----- Datos de tipo fecha -----

# Cadena de texto
fecha_char <- "2021-04-21"
fecha_char + 1

# Fecha, mostrada como un texto pero guardada internamente como un número
fecha_date <- as.Date(fecha_char, format = "%Y-%m-%d")
fecha_date + 1

# Operaciones con fechas
fecha <- Sys.Date()
fecha
fecha - 7 # una semana antes
class(fecha) # de clase fecha

# Convertir a fecha
as.Date("2021-03-10")
as.Date("10-03-2020", "%d-%m-%Y") # con día-mes-año (4 cifras)
as.Date("10-03-20", "%d-%m-%y")  # con día-mes-año (2 cifras)
as.Date("03-10-2020", "%m-%d-%Y") # con mes-día-año (4 cifras)
as.Date("Octubre 21, 1995 21:24", "%B %d, %Y %H:%M") # fecha escrita

# Funciones del paquete lubridate
install.packages("lubridate")
library(lubridate)
ymd_hms("2017-11-28T14:02:00") # convertir a fecha una cadena año-mes-día + hora
ydm_hms("2017-22-12 10:00:00") # convertir a fecha una cadena año-día-mes + hora
dmy_hms("1 Jan 2017 23:59:59") # convertir a fecha una cadena textual de fecha + hora
mdy("July 4th, 2000") # convertir a fecha una cadena textual de fecha
ymd(20170131)

# Funciones del hoy y ahora
today()
now()

# Otras funciones
fecha <- now()
year(fecha)
month(fecha)
day(fecha)
wday(fecha, week_start = 1) # Día de la semana (empezando por el lunes)
hour(fecha)
minute(fecha)
second(fecha)
week(fecha) # Número de semana (del año)

# Comprando fechas
fecha_actual <- now()
fecha_actual > ymd(20170131) # Actual vs 2017-01-31
fecha_actual > ymd(21000131) # Actual vs 2100-01-31

