
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

