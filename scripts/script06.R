
# ----- vectores numéricos -----

# Concatenamos números
edades <- c(32, 27, 60, 61)
edades

# longitud de un vector
length(edades)

# Concatenamos vectores
c(edades, edades, 8)

# secuencias
seq(1, 21) # secuencia desde 1 hasta 21 de uno en uno

n <- 21
1:n # secuencia desde 1 hasta n (21) de uno en uno
n:1 # secuencia decreciente

seq(1, 10, by = 0.5) # secuencia desde 1 a 10 de 0.5 en 0.5
seq(1, 21, by = 1.7) # secuencia desde 1 a 21 de 1.7 en 1.7

seq(1, 50, l = 11) # secuencia desde 1 a 50 de longitud 11
seq(1, 50, l = 8) # secuencia desde 1 a 50 de longitud 8

# Vectores repetidos
rep(0, 7) # vector de 7 ceros
rep(c(0, 1, 2), 4) # repetimos el vector c(0, 1, 2) 4 veces
rep(c(0, 1, 2), each = 4) # cuatro 0, luego cuatro 1, luego cuatro 2

# ----- vectores de caracteres -----

# vector de caracteres
mi_nombre <- c("Mi", "nombre", "es", "Javier")
mi_nombre

# paste / paste0
paste(mi_nombre, collapse = "") # todo junto
paste(mi_nombre, collapse = " ") # separados por un espacio
paste(mi_nombre, collapse = ".") # separados por un punto .
paste0(mi_nombre) # todo junto sin nada separando


# pegamos caracteres a secuencisa de números
paste0("variable", 1:7) # a la palabra «variable» le pegamos los números del 1 al 7
paste("variable", 1:7, sep = "_") # separado por una barra baja

# paquete glue
library(glue)
edad <- 10:15 # edades
glue("La edad es de {edad} años")
# Otra forma sin definir variables a priori
glue("La edad es de {10:15} años")

# todo a mayúscula/minúscula
texto <- c("Hola.", "qué", "ase?", "todo", "bien.", "y yo",
           "que", "ME", "ALEGRO")
toupper(texto) # todo a mayúscula
tolower(texto) # todo a minúscula

# toda "o" en el texto será sustituida por *
gsub("o", "*", texto) 


# ----- vectores lógicos -----

# Vectores lógicos
x <- c(1.5, -1, 2, 4, 3, -4)
x < 2
x <= 2
x > 2
x >= 2
x == 2
x != 2

# Combinación de condiciones
x <- c(1.5, -1, 2, 4, 3, -4)
x < 3 & x > 0 # Solo los que cumplen ambas condiciones
x < 2 | x > 3 # Los cumplen al menos una de ellas


# ----- datos ausentes -----

# Vector con ausentes
x <- c(1, NA, 3, NA, NA, 5, 6) # Vector numérico con datos faltante
length(x) # longitud del vector
x

# Operaciones con ausentes --> ausente
2 * x
1 + NA + 3

# Detectar NA
is.na(x) # TRUE si está ausente (NA), FALSE si no lo está.

# Eliminar NA
na.omit(x)

# NaN: not a number
1/0
0/0

# Localizar NA, NaN, Infinite
x <- c(1, NA, 3, 4, Inf, 6, 7, Inf, NaN, NA)
is.na(x)
is.nan(x)
is.infinite(x)

