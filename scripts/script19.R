# ----- tidyverse  -----

library(tidyverse)

# Conjunto starwars
starwars
class(starwars)
dim(starwars)

# Resumen por columnas
glimpse(starwars)

# Imprimir personalizado
print(starwars, n = 5, width = Inf)

# Las películas de los tres primeros personajes
starwars$films[1:3]

# ----- Seleccionar filas (filter y slice) -----

# seleccionar filas en base al cumplimiento de una o varias 
# condiciones lógicas respecto a las variables.
starwars %>% filter(eye_color == "brown") # con ojos marrones

# A la «antigua» usanza
starwars[starwars$eye_color == "brown", ]
starwars %>% filter(eye_color != "brown") # NO tengan ojos marrones

# con ojos marrones, azules o rojos
starwars %>%
  filter(eye_color %in% c("brown", "blue", "red"))
# Con between filtramos por rango
starwars %>% filter(between(height, 120, 160))

# humanos con ojos marrones
starwars %>% filter(eye_color == "brown", species == "Human")

# humanos con ojos marrones, azules o rojos, que no sean humanos, y menos de 50a
starwars %>% 
filter(eye_color %in% c("brown", "blue", "red"),
       species != "Human", birth_year < 50)

# slice: extramos filas por índice de fila.
starwars %>% slice(1) # primera fila

# slice: extramos filas por índice de fila.
starwars %>% slice(5:10) # filas de la 5 a la 10
starwars %>% slice(seq(2, 10, by = 2)) # filas pares hasta la décima
starwars %>% slice(c(3, 4, 10, 20, 33)) # filas 3, 4, 10, 20 y 33

# Podemos extraer directamente las primeras o últimas filas
starwars %>% slice_head(n = 5) # 5 primeras filas 
starwars %>% slice_tail(n = 2) # 2 últimas filas 

# También podemos hacer una extracción al azar de filas
starwars %>% slice_sample(n = 5) # 5 al azar

# 100 con reemplazamiento
# (si fuera sin reemplazamiento, daría error)
starwars %>% slice_sample(n = 100, replace = TRUE) 

# Podemos extraer filas en función del mín/máx de una variable
starwars %>% slice_min(height, n = 5) # los 5 más bajitos
starwars %>% # los 5 más bajitos (sin empates, exactamente 5)
slice_min(height, n = 5, with_ties = FALSE) 
starwars %>% slice_max(mass, n = 7) # los 7 más pesados

# Reordenar filas (arrange)

# Con arrange ordenamos en base al orden de la variable que introduzcamos
starwars %>% arrange(height) # de bajitos a altos, yoda al poder

# Por defecto lo hace ascendente pero podemos cambiarlo
starwars %>% arrange(desc(height))

# Podemos combinar varios criterios: ordenados de bajitos a altos,
# y en caso de empate, de pesados a ligeros. Un dato NA va siempre al final
starwars %>% arrange(height, desc(mass))

# Podemos combinar varias acciones en pocas líneas
starwars %>%
  filter(eye_color == "brown",
         species == "Human", sex == "male") %>%
  arrange(height, desc(mass))

# Eliminamos por índices
starwars %>% slice(-(1:5)) # eliminamos las 5 primeras filas

# Eliminamos duplicados
# Eliminamos registros con igual par (color_pelo, color_ojos)
starwars %>% distinct(hair_color, eye_color)

# Eliminamos duplicados
starwars %>% # Eliminamos registros con igual par (color_pelo, color_ojos)
  distinct(hair_color, eye_color,
           .keep_all = TRUE) # .keep_all = TRUE mantiene todas columnas

# Duplicamos el conjunto para probarlo
duplicado_starwars <- rbind(starwars, starwars)
dim(duplicado_starwars)

# Eliminamos duplicados (filas exactamente iguales)
duplicado_starwars %>% distinct()
dim(duplicado_starwars %>% distinct())

# Añadir filas (bind_rows)
starwars_nuevo <- bind_rows(starwars, starwars[1:3, ])
dim(starwars)
dim(starwars_nuevo)
starwars_nuevo

# ----- Operaciones con columnas ----- 

# Seleccionar columnas (select)

# select: columnas a seleccionar sin comillas
# seleccionamos solo 1 columna: color de pelo
starwars %>%  select(hair_color)

# seleccionamos solo 3 columnas: pelo, piel y ojos
starwars %>% select(hair_color, skin_color, eye_color)

# desde nombre hasta año nacim.
starwars %>% select(name:birth_year)

# Podemos seleccionar columnas por sufijo y prefijo
starwars %>% select(ends_with("color")) # acaban en "color"

starwars %>% select(starts_with("h")) # empiezan por h
starwars %>% select(contains("h")) # contienen la h

starwars %>% # seleccionamos todas menos 3 columnas: pelo, piel y ojos
  select(-c(hair_color, skin_color, eye_color))

# Seleccionamos solo la columnas numéricas
starwars %>% select(where(is.numeric))

# Extraer columnas (pull) 
starwars %>% select(name)
starwars %>% pull(name)

# Renombrar (rename) y reordenar (relocate) columnas
# rename: renombrar columnas, primero el nuevo y luego el antiguo
starwars %>% rename(nombre = name, altura = height, peso = mass)
starwars %>% # altura y masa detrás de color de piel
  relocate(height, mass, .after = skin_color) 
starwars %>% # color de piel, pelo y ojos antes de peso
  relocate(hair_color, skin_color, eye_color, .before = mass) 

# Muchas de las funciones vistas pueden ir acompañadas de `at` o o `if`,
# como `select_at` o `rename_if`, que nos permite hacer
# operaciones más finas y personalizadas. Por ejemplo, vamos a
# renombrar con `rename_if()` las columnas, pasándolas a mayúscula
# con `toupper`, pero solo aquellas que sean de tipo numérico.
starwars %>% rename_if(is.numeric, toupper)

# ----- Crear nuevas variables (mutate) -----

# Mutate: nos añade nuevas columnas usando funciones
# aplicadas a nuestras variables
starwars %>% mutate(height_m = height / 100) # altura en metros
print(starwars %>% mutate(height_m = height / 100), width = Inf)

# Otra opción es quedarnos solo con las columnas nuevas creadas
starwars %>% transmute(height_m = height / 100)
print(starwars %>%
      # Calculamos altura en metros y el IMC
      mutate(height_m = height / 100,
             BMI = mass / (height_m^2)), width = Inf)

# Como ves por defecto añade las columnas al final
# pero podemos reordenar las columnas como ya hemos visto.
starwars %>%
  mutate(height_m = height / 100, BMI = mass / (height_m^2)) %>%
  relocate(height_m, BMI, .after = name)

# También podemos pasarle una función propia que queramos definir,
# no solo funciones de `R`. Vamos a definir la función que nos
# calcula el IMC, a la que llamaremos `BMI_fun`, que necesita
# solo de dos argumentos: la altura en metros y el peso.
BMI_fun <- function(m, h) {

return(m / h^2)
}
BMI_fun(90, 1.6)

starwars %>%
  mutate(height_m = height / 100, BMI = BMI_fun(mass, height_m)) %>%
  relocate(height_m, BMI, .after = name)

# Películas de los 3 primeros personajes
starwars$films[1:3]
length(starwars$films[1])
# Mapeamos la lista con length
n_films <- starwars$films %>% map(length)
n_films[1:5]
# Mapeamos la lista con length pero devolvemos un vector de números enteros
starwars$films %>% map_int(length)
# Añadimos a los datos
starwars %>%
  mutate("n_peliculas" = map_int(films, length)) %>%
  select(c(name, homeworld, n_peliculas))

# ----- Recategorizar columnas (cut y case_when) -----
print(starwars %>%
      mutate("estat_categoria" =
               cut(height,
                   breaks = c(-Inf, 120, 180, Inf))),
    width = Inf)
starwars %>%
transmute("estat_categoria" =
            cut(height, breaks = c(-Inf, 120, 180, Inf)))
starwars %>%
transmute("estat_categoria" = cut(height, breaks = c(-Inf, 120, 180, Inf),
                                  labels = c("bajos", "medios", "altos")))

# Vamos a categorizar en bajitos a los que miden menos de 180 cm
starwars %>%
mutate(talla = factor(height < 180, labels = c("bajos", "altos")))

starwars %>%
transmute(altura =
            case_when(height > 180 ~ "altos",
                      height > 120 ~ "bajos",
                      height > 0 ~ "enanos",
                      TRUE ~ "ausentes"))

# ----- Datos ausentes y outliers (drop_na y mutate) -----
starwars %>% drop_na()
starwars %>% drop_na(mass, height, sex, gender, birth_year)
starwars %>%
  # Variables cuanti
  mutate(across(where(is.numeric),
                ~replace(.x, is.na(.x), mean(.x, na.rm = TRUE))))

# outliers
library(anomalize)
# Importante: quitar antes missings
starwars %>% drop_na(mass) %>% anomalize(mass, method = "gesd")
print(starwars %>%
        drop_na(mass) %>%
        anomalize(mass, method = "gesd") %>%
        rename(outlier = anomaly) %>%
        # Eliminamos la variables auxiliares creadas
        select(-c(mass_l1, mass_l2)) %>%
        mutate(outlier = (outlier == "Yes")), width = Inf)
print(starwars %>%
        drop_na(mass) %>%
        anomalize(mass, method = "gesd") %>%
        rename(outlier = anomaly) %>%
        # Eliminamos la variables auxiliares creadas
        select(-c(mass_l1, mass_l2)) %>%
        mutate(outlier = (outlier == "Yes"),
               mass = ifelse(outlier, mean(mass), mass)),
      width = Inf)

