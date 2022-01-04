# ----- funciones -----

# Primera función: calcular área del rectángulo
calcular_area <- function(lado_1, lado_2) {
  
  # Cuerpo de la función (lo que hace)
  area <- lado_1 * lado_2
  
  # Resultado (lo que devuelve)
  return(area)
  
}

# Otra forma de definirlo, sin guardar cosas por el camino
calcular_area <- function(lado_1, lado_2) {
  
  # Resultado que devolvemos
  return(lado_1 * lado_2)
  
}


# Aplicación de la función con los parámetros por defecto
calcular_area(5, 3) # área de un rectángulo 5 x 3 


# Seguna función: área del rectángulo pero por defecto lado_2 = lado_1
calcular_area <- function(lado_1, lado_2 = lado_1) {
  
  # Cuerpo de la función
  area <- lado_1 * lado_2
  
  # Resultado que devolvemos
  return(area)
  
}
calcular_area(lado_1 = 5) # si no indicamos nada, lado_2 = lado_1

# Tercera función: devolvemos más argumentos
calcular_area <- function(lado_1, lado_2 = lado_1) {
  
  # Cuerpo de la función
  area <- lado_1 * lado_2
  
  # Resultado
  return(c("area" = area, "lado_1" = lado_1, "lado_2" = lado_2))
  
}
salida <- calcular_area(5, 3)
salida
salida["area"]
salida["lado_1"]
salida["lado_2"]
calcular_area(lado_1 = 5, lado_2 = 3)

# Variables locales/globales
x <- 1
funcion_ejemplo <- function() {
  
  print(x) # No devuelve nada per se, solo realiza la acción de imprimir en consola
}
funcion_ejemplo()

# Si una variable ya está definida fuera de la función
# (entorno global), y además es usada dentro de la misma cambiando
# su valor, el valor de dicha variable solo cambia dentro de la
# función pero no en el entorno global.
x <- 1
funcion_ejemplo <- function() {
  
  x <- 2
  print(x) # lo que vale dentro
}
funcion_ejemplo() # lo que vale dentro
print(x) # lo que vale fuera

# Si queremos que el cambio lo haga globalmente deberemos usar la
# doble asignación  (`<<-`).
x <- 1
y <- 2
funcion_ejemplo <- function() {
  
  x <- 3 # no cambia globalmente, solo localmente
  y <<- 0 # cambia globalmente
  print(x)
  print(y)
}
funcion_ejemplo() # lo que vale dentro
x # lo que vale fuera
y # lo que vale fuera
