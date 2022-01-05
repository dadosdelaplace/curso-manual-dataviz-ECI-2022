# ----- Repaso: empezando a trastear con datos -----

# 1. ¿Cómo cargarías los datos sabiendo su nombre y el paquete en el
# que está?
library(datasets)
swiss

# otra forma
datasets::swiss
```

# 2. Tenemos los datos guardados en `swiss`, ¿qué tipo de objeto es?
  
class(swiss)

# Convertimos a matriz
as.matrix(swiss)
class(as.matrix(swiss))

# 3. ¿Cómo podríamos tener una descripción detallada de los datos?
  
# ? swiss en consola

# Nombres
names(swiss)
row.names(swiss)

# 4. ¿Cómo podríamos «ver» los datos?
# ¿Cuántas provincias hay incluidas?
# ¿Cuántas variables han sido medidas en cada una de ellas?*
  
# Cabecera de la tabla
head(swiss)

# Ver la tabla
View(swiss)

# Dimensiones
dim(swiss)
nrow(swiss)
ncol(swiss)

# 5. ¿Cómo podríamos definir una nueva variable de tipo texto
# con los nombres de filas que obtenemos de `row.names()`?
  
# Nombres
nombres <- row.names(swiss)
nombres

# Tabla nueva con nombres
tabla_nueva <- data.frame("provincias" = nombres, swiss)
head(tabla_nueva)

# Eliminamos nombre de las filas
row.names(tabla_nueva) <- NULL # anulamos nombre de filas
head(tabla_nueva)

# 6. ¿Cómo podemos decidir cual de las provincias tiene un
# indicador estandarizado de la fertilidad superior a 80?
  
# Accedemos a Fertility
tabla_nueva$Fertility > 80

# Filas exactas que cumplen dicha condición** (sus índices)
# podemos usar la función `which()`.
which(tabla_nueva$Fertility > 80)

# Nombres de dichas provincias
tabla_nueva$nombres[which(tabla_nueva$Fertility > 80)]

# 7. ¿Cómo podemos filtrar la tabla y seleccionar solo dichas
# provincias, las que tienen fertilidad superior a 80?*
  
tabla_nueva$Fertility > 80
tabla_nueva[tabla_nueva$Fertility > 80, ]

# usando subset
# sin filtrar columnas
subset(tabla_nueva, subset = Fertility > 80)

# filtrando columnas
subset(tabla_nueva, subset = Fertility > 80,
       select = c("provincias", "Fertility", "Education"))

# 8. ¿Cómo podemos añadir una nueva variable lógica que nos
# guarde `TRUE` si la fertilidad es superior a 80 y `FALSE`
# en caso contrario?
  
var_logica <- tabla_nueva$Fertility > 80
tabla_nueva_2 <- data.frame(tabla_nueva, "alta_fertilidad" = var_logica)

# sin filtrar columnas
subset(tabla_nueva_2, subset = alta_fertilidad == TRUE)

# igual (sin filtrar columnas)
subset(tabla_nueva_2, subset = alta_fertilidad)

# filtrando columnas
subset(tabla_nueva_2, subset = alta_fertilidad,
       select = c("provincias", "Fertility", "Education"))

# 9. ¿Cómo podemos definir una nueva variable de tipo fecha,
# que empiece el 1 de enero de 1888, acabe el 31 de diciembre de 1888,
# y las fechas estén equiespaciadas en el tiempo?
  
# secuencia de fechas
fechas <-
  seq(as.Date("1888-01-01"), as.Date("1888-12-31"), l = nrow(tabla_nueva_2))
fechas
class(fechas)
fechas + 1

# Tabla final
tabla_final <- data.frame(tabla_nueva_2, fechas)
head(tabla_final)
