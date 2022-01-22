# ----- Operaciones aritméticas con vectores numéricos -----

# Multiplicamos por 2 a CADA ELEMENTO del vector
z <- c(2, 4, 6)
2 * z

# Sumamos 3 a CADA ELEMENTO DEL VECTOR
z + 3
# Restamos 5 a CADA ELEMENTO DEL VECTOR
z - 5
sqrt(z) # Hacemos la raíz cuadrada de CADA ELEMENTO DEL VECTOR
z^2 # Elevamos al cuadrado CADA ELEMENTO DEL VECTOR

# Suma de vectores
x <- c(1, 3, 5)

# Reciclando elementos
y <- c(1, 3, 5, 7)
z + y

# Suma de vectores lógicos
sum(x < 2) # sumamos el vector de TRUE/FALSE --> número de TRUE


# ----- Operaciones estadísticas con vectores numéricos -----

# Operaciones estadísticas
sum(y) # suma
mean(y) # media
median(y) # mediana
cumsum(y) # suma acumulada

# percentiles
y <- c(1, 2, 5, 5, 8, 9, 10, 10, 10, 11, 13, 15, 20, 23, 24, 29)
quantile(y) # Percentiles por defecto: cuartiles (0%-25%-50%-75%-100%)

y <- c(1, 2, 5, 5, 8, 9, 10, 10, 10, 11, 13, 15, 20, 23, 24, 29)
quantile(y, probs = c(0.15, 0.3, 0.7, 0.9)) # Percentiles p15, p30, p70 y p90

# ----- Operaciones con ausentes -----
    
x <- c(1, NA, 3, NA, NA, 5, 6)
# eliminando datos ausentes antes de aplicar la función
sum(x, na.rm = TRUE) 
mean(x, na.rm = TRUE)

# ----- Seleccionar elementos -----
    
# Seleccionar por índice
edades <- c(20, 30, 32, NA, 61)
edades[3] # accedemos a la edad de la tercera persona en la lista
edades[4] # accedemos a la edad de la cuarta persona (que no la tenemos guardada)
y <- c("hola", "qué", "tal", "todo", "ok", "?")
y[1:2] # Solo queremos acceder a los elementos en la posición 1 y 2
y[c(1:2, length(y))] # Solo accedemos a los elementos en la posición 1, 2 y además el que ocupa la última posición (recuerda: length(y) nos da la longitud total del vector)

# Selección de varios
edades[c(3, 4)] # queremos acceder a la vez al tercer y cuarto elemento

# Eliminamos en lugar de seleccionary
y[-2] # Nos muestra todo y salvo el elemento que ocupa la segunda posición

# Selección por condiciones lógicas
x <- c(7, 20, 18, 3, 19, 9, 13, 3, 45)
y <- c(17, 21, 58, 33, 15, 59, 13, 1, 45)
x[x >= 18] # mayores de 18 años del conjunto x
y[x >= 18] # mayores de 18 años del conjunto y

# Limpiar datos de ausentes
x <- c(7, NA, 20, 3, 19, 21, 25, 80, NA)
x[is.na(x)] # solo valores ausentes
x[!is.na(x)] # sin valores ausentes: ! es el símbolo de la negación

# Combinar condiciones
x[x >= 18 & x <= 25] # los valores que cumplen ambas (&): entre 18 y 25 años

# Vectores con nombre
x <- c("edad" = 31, "tlf" = 613910687, "cp" = 33007) # cada número tiene un significado distinto
x
x[c("edad", "cp")] # seleccionamos los elementos que tienen ese nombre asignado

# Names
names(x) # Consultamos nombres
names(x) <- c("años", "móvil", "dirección") # Cambiamos nombres
names(x) # Consultamos nuevos nombres
x

# ----- which/NULL -----
    
# Decidir el lugar que ocupan los valores que cumplen una condición
x <- c(7, NA, 20, 3, 19, 21, 25, 80, NA)
x[x >= 18] # Accedemos a los elementos que cumplen la condición
which(x >= 18) # Obtenemos los lugares que ocupan los elementos que cumplen la condición

# which.maxx / which.min
x
max(x, na.rm = TRUE) # máximo de x (si no eliminamos NA, nos devolverá NA)
min(x, na.rm = TRUE) # mínimo de x (si no eliminamos NA, nos devolverá NA)
which.max(x) # Lugar que ocupa el máximo
which.min(x) # Lugar que ocupa el mínimo

    
# ----- Ordenar -----   

# Ordenar de menor a mayor
edades <- c(81, 7, 25, 41, 65, 20, 32, 23, 77)
sort(edades) # orden de joven a mayor

# Ordenar de mayor a menor
sort(edades, decreasing = FALSE) # orden de mayor a joven

# Otra forma: Order
order(x) 
x[order(x)] # accedemos a los índices ordenados

    
    
    