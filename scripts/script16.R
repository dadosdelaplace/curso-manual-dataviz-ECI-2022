# ----- Tidy vs messy data: daticos ordenados -----

library(tidyverse)
table4a

# Si te fijas, tenemos una columna `country`, representando una
# variable con el nombre de los países, ¡pero las otras columnas
# no representan cada una a una sola variable!
# Ambas son la misma variable, solo que medida en años distintos
# (que debería ser a su vez otra variable)

# Con pivot_longer le indicaremos lo siguiente:
# - `cols`: el nombre de las columnas que vamos a pivotar 
# (con comillas porque son números, no texto como nombre).
# - `names_to`: el nombre de la columna a la que vamos a mandar
# los valores que figuran ahora en los nombres de las columnas.
# - `values_to`: el nombre de la columna a la que vamos a mandar
# los valores.
table4a %>% pivot_longer(cols = c("1999", "2000"), names_to = "year",
                         values_to = "values")

# Ejemplo de messy data
relig_income

# Messy <- tidy No necesitamos las comillas en el nombre de columnas salvo que
# tengan caracteres que no sean letras
relig_income %>% pivot_longer(-religion, names_to = "ingresos",
                              values_to = "frecuencia")

# Messy data: una observación guardada en varias filas
table2
table2 %>% pivot_wider(names_from = type, values_from = count)

# Messy data: una celda con múltiples valores
table3
table3 %>% separate(rate, into = c("cases", "population"))

# Por defecto lo que hace es localizar como separador cualquier
# caracter que no sea alfa-numérico. Si queremos un caracter
# concreto para dividir podemos indicárselo explícitamente
table3 %>% separate(rate, into = c("cases", "population"), sep = "/")

# Si usas un separador que no está en los datos te devolverá
# dichas columnas vacías ya que no ha podido dividirlas.
table3 %>% separate(rate, into = c("cases", "population"), sep = ".")

# También podemos unirlas. Para ello vamos a usar la tabla `table5`
# del ya mencionado paquete. Con la función `unite()` vamos a unir
# el siglo (en `century`) y el año (en `year`), y al inicio le
# indicaremos como se llamará la nueva variable (`año_completo`).
table5 %>% unite(año_completo, century, year)
table5 %>%
    unite(año_completo, century, year, sep = "")

  