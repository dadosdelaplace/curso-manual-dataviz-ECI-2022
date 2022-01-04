# ----- listas -----

# primera lista
# * un vector de caracteres (de longitud 2)
# * un caracter (vector de longitud 1)
# * un vector de números (de longitud 3)

variable_1 <- c("Paloma", "Gregorio")
variable_2 <- "Madrid"
variable_3 <- c(25, 30, 26)
lista <- list("progenitores" = variable_1,
              "lugar_nacimiento" = variable_2,
              "edades_hermanos" = variable_3)
lista
length(lista)
class(lista) # de tipo lista

# Accedemos por índice
lista[[1]]

# Accedemos por nombre
lista$progenitores

# Varios elementos
lista[1:2]

# otra lista
# * `nacimiento`: una fecha.
# * `notas_insti`: un `data.frame`.
# * `teléfonos`: vector de números.
# * `nombre_padres`: vector de texto.
fecha_nacimiento <- as.Date("1989-09-10")
notas <- data.frame("biología" = c(5, 7), "física" = c(4, 5),
                    "matemáticas" = c(8, 9.5))
row.names(notas) <- # Nombre a las filas
  c("primer_parcial", "segundo_parcial")
tlf <- c("914719567", "617920765", "716505013")
padres <- c("Juan", "Julia")
# Guardamos TODO en una lista (con nombres de cada elemento)
datos <- list("nacimiento" = fecha_nacimiento,
              "notas_insti" = notas, "teléfonos" = tlf,
              "nombre_padres" = padres)
datos
names(datos)
length(datos)

# Acceder a elementos
datos[[1]]
datos$nacimiento

datos[[2]]
datos$notas_insti

# Lista de listas
lista_de_listas <- list("lista_1" = datos[3:4], "lista_2" = datos[1:2])
names(lista_de_listas) # Nombres de los elementos del primer nivel
names(lista_de_listas[[1]]) # Nombres de los elementos guardados en el primer elemento, que es a su vez una lista
lista_de_listas[[1]][[1]] # Elemento 1 de la lista guardada como elemento 1 de la lista superior

# Como valor que devuelve una función
igualdad_nombres <- function(persona_1, persona_2) {
  
  return(list("son_iguales" = toupper(persona_1) == toupper(persona_2),
              "nombres" = c(persona_1, persona_2)))
}
resultado <- igualdad_nombres("Javi", "Lucía")
resultado$son_iguales
resultado$nombres

# Una lista no se puede vectorizar de forma inmediata, por lo
# cualquier operación aritmética aplicada a una lista dará
# error (para ello está disponible la función `lapply()`,
# cuyo uso corresponde a otros cursos más avanzados).
datos <- list("a" = 1:5, "b" = 10:20)
datos / 2
lapply(datos, FUN = function(x) { x / 2})
