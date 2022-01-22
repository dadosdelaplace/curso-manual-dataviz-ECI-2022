# ----- if-else -----

#  Comprobar cuales son menores de edad
edades <- c(14, 17, 24, 56, 31, 20, 87, 73)
edades < 18

# funciones `any()` y `all()` podemos saber si todos o alguno
# de los elementos de un vector cumplen una condición
all(edades >= 18) # todos mayores de edad
any(edades < 18) # existe algun menor de edad

# primer if
if (any(edades < 18)) { # TRUE si al menos una persona mayor de edad
  
  print("existe alguna persona mayor de edad")
  
}

if (all(edades >= 18)) { # TRUE si TODOS son mayores de edad
  
  print("todas las personas son mayores de edad")
  
}

# if - else {}
if (all(edades >= 18)) { # TRUE si TODOS son mayores de edad
  
  print("todas las personas son mayores de edad")
  
} else { # si hay alguno menor de edad 
  
  print("existe alguna persona menor de edad")
}

# algo más complejo
if (all(edades >= 18)) { # TRUE si TODOS son mayores de edad
  
  print("todas las personas son mayores de edad")
  
} else { # si hay alguno menor de edad 
  
  print(glue("Existe alguna persona menor de edad. Sus edades son: {edades[edades < 18]}"))
}

# if - else anidados
if (all(edades >= 18)) { # TRUE si TODOS son mayores de edad
  
  print("todas las personas son mayores de edad")
  
} else if (all(edades >= 16)) { # si todos los menores de edad tienen >=16
  
  print("Existe alguna persona menor de edad pero todos con 16 años o más")
  
} else {
  
  print("Existe alguna persona menor de 16 años")
  
}

# ifelse () vectorizado


# NA si no cumple la condición, la edad si se cumple.
ifelse(edades >= 18, edades, NA)

# también con caracteres (con cualquier tipo de dato)
nombres <- c("Juan", "María", NA, NA, "Lucía", "Carmen", "Javier",
             NA, "Carlos", NA, "Gregorio", "Paloma")

# Si tiene ausente --> "nombre_desconocido"
# Si no tiene ausente --> nombres originales
nombres <- ifelse(is.na(nombres), "nombre_desconocido", nombres)
nombres
