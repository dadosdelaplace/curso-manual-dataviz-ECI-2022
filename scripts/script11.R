# ----- tibble -----

# Nuestro primer tibble
library(tibble)
tabla_tb <- tibble("x" = 1:50,
                   "y" = rep(c("a", "b", "c", "d", "e"), 10),
                   "z" = 11:60,
                   "logica" = rep(c(TRUE, TRUE, FALSE, TRUE, FALSE), 10))
tabla_tb

# Así sería en data.frame
tabla_df <-
  data.frame("x" = 1:50,
             "y" = rep(c("a", "b", "c", "d", "e"), 10),
             "z" = 11:60,
             "logica" = rep(c(TRUE, TRUE, FALSE, TRUE, FALSE), 10))
tabla_df

# Puedes imprimir las filas y columnas que quieras con `print()`,
# pero por defecto te aseguras de no saturar la consola.
print(tabla_tb, n = 13, width = Inf)

# La función `tibble()` construye las variables secuencialmente,
# pudiendo hacer uso en la propia definición de variables recién
# definidas en dicha definición.
tibble("x" = 1:5,
       "y" = c("a", "b", "c", "d", "e"),
       "z" = 11:15,
       "logica" = c(TRUE, TRUE, FALSE, TRUE, FALSE),
       "x*z" = x * z)

# Si accedes a una columna que no existe avisa con un warning.
tabla_tb$variable_inexistente

# No solo no te cambiará el tipo de datos sino que 
# no te cambiará el nombre de las variables
# (los `data.frame` transforma los caracteres que no sean letras).
tibble(":)" = "emoticono", " " = "en blanco", "2000" = "número")

# Resumen de variables
glimpse(tabla_tb)

