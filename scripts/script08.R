# ----- Matrices -----

# Ejemplos de variables unidimensionales (vectores)
c(1, 4, NA, -2, 0)
c("a", NA, "b", "c")
c(TRUE, TRUE, FALSE, TRUE)

# Primera matriz: crear matric por columnas
estaturas <- c(150, 160, 170, 180, 190)
pesos <- c(60, 70, 80, 90, 100)
datos_matriz <- cbind(estaturas, pesos) # Construimos la matriz por columnas
datos_matriz # nuestra primera matriz

# Visualizar la matriz
View(datos_matriz)

# Crear matriz por filas
rbind(estaturas, pesos) # Construimos la matriz por filas

# Matriz de 3 columnas
edades <- c(14, 24, 56, 31, 20, 87, 73) # vector numérico de longitud 7
tlf <- c(NA, 683839390, 621539732, 618211286, NA, 914727164, NA)
cp <- c(33007, 28019, 37005, 18003, 33091, 25073, 17140)
datos_matriz <- cbind(edades, tlf, cp) 
datos_matriz

# Añadimos una fila
rbind(datos_matriz, c(27, 620125780, 28051))

# Añadimos una columna
cbind(datos_matriz, "estaturas" = c(160, 155, 170, 181, 174, NA, 165))


# Calculamos dimensiones
dim(datos_matriz)
dim(datos_matriz)[1]
dim(datos_matriz)[2]
nrow(datos_matriz)
ncol(datos_matriz)

# Matriz de ceros
matrix(0, nrow = 5, ncol = 3) # 5 filas, 3 columnas, todo 0's

# Matriz a partir de un vector
z <- matrix(1:15, ncol = 5) # Matriz con el vector 1:5 con 5 columnas (ergo 3 filas)
z

# # Matriz transpuesta
datos_matriz
t(datos_matriz) 

# Operaciones con matrices: se hacen elemento a elemento
datos_matriz / 5
datos_matriz + 3

# Matriz de caracteres
nombres <- c("Javier", "Carlos", "María", "Paloma")
apellidos <- c("Álvarez", "García", "Pérez", "Liébana")
cbind(nombres, apellidos)

# Matriz de valores lógicos
var1 <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
var2 <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
cbind(var1, var2)
cbind(var1, var2) + 1

# Acceder a elementos con [i]
datos_matriz
datos_matriz[1, 3] # elemento (1, 3)
datos_matriz[1, ] # fila 1
datos_matriz[, 3] # columna 3

# Acceder por nombre
datos_matriz[, c("edades", "tlf")]

# Asignar nombres a filas
row.names(datos_matriz) <- c("Javi", "Laura", "Patricia", "Carlos",
                             "Juan", "Luis", "Carla")
datos_matriz["Javi", "edades"]


# ----- Operaciones por filas y columnas (apply) -----

# Matriz a usar
datos_matriz <- cbind(estaturas, pesos)
datos_matriz

# Media por columnas (MARGIN = 2)
apply(datos_matriz, MARGIN = 2, FUN = "mean")

# Media por filas (MARGIN = 1)
apply(datos_matriz, MARGIN = 1, FUN = "mean")

# Argumentos extras
datos_matriz <- cbind(edades, tlf, cp) 
datos_matriz
# Media por columnas (MARGIN = 2)
apply(datos_matriz, MARGIN = 2, FUN = "mean", na.rm = TRUE)

# ----- Tablas: data.frames -----

Recapitulando:
  
# Sumamos un año a todas las personas
datos_matriz[, "edades"] + 1

# Añadimos texto a una matriz numérico y repetimos suma
nombres <- c("Sonia", "Carla", "Pepito", "Carlos", "Lara", "Sandra", "Javi")
datos_matriz_nueva <- cbind(nombres, datos_matriz)
datos_matriz_nueva[, "edades"] + 1 # error

# Construimos el primer data.frame
nombres <- c("Sonia", "Carla", "Pepito", "Carlos", "Lara", "Sandra", "Javi")
apellidos <- c(NA, "González", "Fernández", "Martínez", "Liébana", "García", "Ortiz")
cp <- c(28019, 28001, 34005, 18410, 33007, 34500, 28017)
edades <- c(45, 67, NA, 31, 27, 19, 50)
tlf <- c(618910564, 914718475, 934567891, 620176565, NA, NA, 688921344)
casado <- c(TRUE, FALSE, FALSE, NA, TRUE, FALSE, FALSE)
fecha_creacion <-
  as.Date(c("2021-03-04", "2020-10-12", "1990-04-05",
            "2019-09-10", "2017-03-21", "2020-07-07",
            "2000-01-28"))
# En cada variable tenemos 7 registros, uno por persona,
# pero ahora tenemos un popurrí de variables, 

# Juntamos todo en una matriz (juntamos por columnas)
datos_matriz <-
  cbind(nombres, apellidos, edades, tlf, cp, casado, fecha_creacion)
datos_matriz # MAL: todo a texto


# Creamos nuestro primer data.frame
tabla <- data.frame(nombres, apellidos, edades, tlf, cp,
                    casado, fecha_creacion)
tabla
class(tabla)

# Nombres a las variables
tabla <- data.frame("nombre" = nombres, "apellido" = apellidos, 
                    "edad" = edades, "teléfono" = tlf, 
                    "cp" = cp, "casado" = casado,
                    "fecha_registro" = fecha_creacion)
tabla
View(tabla)

# Añadimos una nueva columna con nº de hermanos/as
hermanos <- c(0, 0, 1, 5, 2, 3, 0)
tabla <- data.frame(tabla, "n_hermanos" = hermanos)
tabla

# Selección de columnas y filas
tabla[, 3] # Accedemos a la tercera columna
tabla[5, ] # Accedemos a la quinta fila
tabla[5, 3] # Accedemos a la tercera variable del quinto registro

# Sacamos datos de datasets
install.packages("datasets")
library(datasets)
datasets::USArrests
View(USArrests)

# Cabecera
head(USArrests)

# Nombre variables
names(USArrests)

# Nombre filas
row.names(USArrests)

# Dimensiones
dim(USArrests)
nrow(USArrests)
ncol(USArrests)

# Selección de filas 2 y 10, y variables Murder y Assault
USArrests[c(2, 10), c("Murder", "Assault")]

# Cambio de nombres
names(USArrests) <- c("asesinato", "agresion",
                      "pobl_urbana", "violacion")

# Filtrado con subset
subset(USArrests, subset = pobl_urbana > 70, select = c("asesinato"))
subset(USArrests, subset = pobl_urbana < 70 & agresion > 250,
       select = c("asesinato", "violacion"))

