# ----- bucles -----

# primer for
# Recorremos cada uno de los 5 elementos e
# imprimimos un mensaje que depende de i
library(glue)
nombres <- c("Javi", "Laura", "Carlos", "Lucía", "Mar")
edades <- c(32, 51, 18, 43, 29)
for (i in 1:5) { 
  
  print(glue("{nombres[i]} tiene {edades[i]} años")) 
  
}

# Conjunto de índices
1:5
1:length(nombres)

# Podemos hacer que el bucle empiece en `1` y
# termine en el último lugar (sea el que sea).
for (i in 1:length(nombres)) { 
  
  print(glue("{nombres[i]} tiene {edades[i]} años")) 
  
}

# bucle con índices que no sean números
dias_semana <- c("lunes", "martes", "miércoles", "jueves",
                 "viernes", "sábado", "domingo")
nombre_mayuscula <- NULL
for (dias in dias_semana) { # dias recorre los días de la semana tomando sus valores
  
  print(toupper(dias)) # Imprimimos en mayúsculas el día
}

# Cambiar variables
for (i in 1:nrow(swiss)) {
  
  # si cumple la condición dicha fila, ponemos ausente.
  if (swiss$Fertility[i] > 80) { 
    
    swiss$Fertility <- NA
    
  }
}
swiss

# Operaciones por filas
suma <- rep(0, nrow(swiss))
for (i in 1:nrow(swiss)) {
  
  suma[i] <- sum(swiss[i, ])
}
suma

# while
max_ciclos <- 10
ciclos <- 1
# Mientras el número de ciclos sea inferior 10, imprime
while(ciclos <= max_ciclos) {
  
  print(paste("Todavía no, vamos por el ciclo ", ciclos)) # Pegamos la frase al número de ciclo por el que vayamos con paste
  ciclos <- ciclos + 1
  
}

# while que nunca se cumple
while (1 > 0) { # Nunca va a dejar de ser cierto
  
  print("Presiona ESC para salir del bucle")
  
}

# break
for(i in 1:10) {
  if (i == 7) {
    
    break # si i es 7, el bucle frena aquí (nunca llegará a imprimir el 7 ni los sucesivos)
    
  }
  print(i)
}

# next
for(i in 1:10) {
  if (i == 7) {
    
    next # si i es 7, la iteración frenará aquí y pasará a la siguiente por lo que imprimirá todos menos el 7
    
  }
  print(i)
}

# repeat
conteo <- 0
repeat { 
  
  conteo <- conteo + 1
  if (conteo >= 100) { break }
  
}
conteo
