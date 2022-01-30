# ----- cualitativas -----


library(tidyverse)
# Nuestra muestra
starwars

# Tamaño muestral
nrow(starwars)

# Incursión en lo aleatorio
valores_moneda <- c("cara", "cruz")
sample(x = valores_moneda, size = 30, replace = TRUE)

# Si lo ejecutamos de nuevo, al ser aleatorio, saldrán otras
# 30 tiradas distintas.
sample(x = valores_moneda, size = 30, replace = TRUE)

# Moneda trucada
tirada_equi <- sample(x = valores_moneda, size = 500, replace = TRUE)
tirada_trucada <-
  sample(x = valores_moneda, size = 500, prob = c(0.7, 0.3), replace = TRUE)

# Número de caras (de 500 tiradas)
sum(tirada_equi == "cara")
sum(tirada_trucada == "cara")

# Número de características medidas
ncol(starwars)

# Características
names(starwars)

# Modalidades variable sex
unique(starwars$sex)

# ----- Factores -----
estado <-
  c("grave", "leve", "sano", "sano", "sano", "grave",
    "grave", "leve", "grave", "sano", "sano")
estado
class(estado)

# ¿Cómo convertir una variable a cualitativa o factor?
# Haciendo uso de la función `as_factor` del paquete `{forcats}`.
estado_fct <- as_factor(estado)
estado_fct
class(estado_fct)

# Imagina que ese día en el hospital no tuviésemos a nadie en
# estado grave aunque ese día nuestra variable no tome dicho valor,
# el estado `grave` es un nivel permitido que podríamos tener,
# así que aunque lo eliminemos, por ser un factor, el nivel
# permanece (no lo tenemos ahora pero es un nivel permitido).
estado_fct[estado_fct %in% c("sano", "leve")]

# eliminar un nivel no usado en ese momento
fct_drop(estado_fct[estado_fct %in% c("sano", "leve")])

# Ampliar niveles
fct_expand(estado_fct, c("UCI", "fallecido"))

# Contar niveles
fct_count(estado_fct)

# Orden por frecuecnia
fct_infreq(estado_fct)

# agrupar niveles
fct_lump_min(estado_fct, min = 3)
fct_lump_min(estado_fct, min = 5)
fct_lump_min(estado_fct, min = 5, other_level = "otros")

# count()
starwars %>%
  filter(!is.na(species)) %>%
  count(species)

# diagrama de barras
ggplot(starwars %>%
         filter(!is.na(species)) %>%
         count(species),
       aes(y = species, x = n, fill = n)) +
  geom_col() +
  scale_fill_continuous_tableau() +
  labs(fill = "Frecuencia absoluta",
       x = "Número de personajes", y = "Especies")

# barras reagrupando niveles
ggplot(starwars %>%
         filter(!is.na(species)) %>%
         mutate(species =
                  fct_lump_min(species, min = 3,
                               other_level = "Otras especies")) %>%
         count(species),
       aes(y = species, x = n, fill = n)) +
  geom_col() +
  scale_fill_continuous_tableau() +
  labs(fill = "Frecuencia absoluta",
       x = "Número de personajes", y = "Especies")

# personalizando
library(showtext)
font_add_google(family = "Roboto", name = "Roboto")
showtext_auto()

ggplot(starwars %>%
         filter(!is.na(species)) %>%
         mutate(species =
                  fct_lump_min(species, min = 3,
                               other_level = "Otras especies")) %>%
         count(species),
       aes(y = species, x = n, fill = n)) +
  geom_col() +
  scale_fill_continuous_tableau() +
  labs(fill = "Frecuencia absoluta",
       x = "Número de personajes", y = "Especies") +
  theme(panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "white", 
                                       color = "white"),
        panel.grid.major.y =
          element_line(size = 0.05, color = "black"),
        panel.grid.major.x =
          element_line(size = 0.1, color = "black"),
        text = element_text(size = 13),
        axis.title =
          element_text(family = "Roboto", size = 23),
        axis.text.x = element_text(family = "Roboto",
                                   size = 15),
        axis.text.y = element_text(family = "Roboto",
                                   size = 15))
# Tablas de frecuencias

# lista de pelis
library(purrr)
library(tidyverse)
starwars_nueva <- starwars %>%
  mutate(n_films = map_int(films, length))
starwars_nueva %>% count()

# tabla de frecuencias absolutas
tabla_freq <- starwars_nueva %>% count(n_films)
tabla_freq

table(starwars_nueva$n_films)
class(table(starwars_nueva$n_films))

table(starwars_nueva %>% select(sex, n_films))

# Construimos de cero tabla
tabla_freq <- starwars_nueva %>%
  # n: frecuencia absoluta
  count(n_films) %>%
  # f_i: frecuencia relativa
  mutate(f_i = prop.table(n))
tabla_freq

prop.table(starwars_nueva$n_films)

# calcular frecuencias absolutas bidimensionales
starwars_nueva %>% count(sex, gender)

# Construimos de cero
tabla_freq <-
  starwars_nueva %>%
  # n: frecuencia absoluta
  count(n_films) %>%
  mutate(f_i = prop.table(n),
         N_i = cumsum(n)) # cumsum calcula la suma acumulada
tabla_freq

# Construimos de cero con acumuladas
tabla_freq <- starwars_nueva %>%
  count(n_films) %>%
  mutate(N_i = cumsum(n)) %>% # cumsum calcula la suma acumulada
  mutate(f_i = prop.table(n), # prop.table nos devuelve proporciones
         F_i = cumsum(f_i))
tabla_freq

# otra forma
tabla_freq <- starwars_nueva %>%
  count(n_films) %>%
  mutate(N_i = cumsum(n)) %>%
  mutate(f_i = prop.table(n),
         F_i = prop.table(N_i))
tabla_freq

# Pasamos frecuencias relativas a porcentajes
tabla_freq %>% mutate(f_i = f_i * 100,
                      F_i = F_i * 100)

# Renombramos
tabla_freq <- tabla_freq %>%
  rename(n_i = n, x_i = n_films)
tabla_freq

# ¿Cuál es el color de pelo que más aparece en `starwars`?
starwars_hair <-
  starwars %>%
  mutate(hair_color = fct_explicit_na(hair_color, na_level = "none")) %>%
  select(c(name, hair_color))
starwars_hair

tabla_freq <- starwars_hair %>%
  count(hair_color) %>%
  mutate(N_i = cumsum(n)) %>% # cumsum calcula la suma acumulada
  mutate(f_i = prop.table(n), # prop.table nos devuelve proporciones
         F_i = cumsum(f_i))
tabla_freq

# En porcentaje
tabla_freq <- 
  tabla_freq %>% mutate(f_i = 100 * f_i,
                        F_i = 100 * F_i)
tabla_freq 


# barras
library(showtext)
font_add_google(family = "Roboto", name = "Roboto")
showtext_auto()

ggplot(starwars %>%
         filter(!is.na(species)) %>%
         mutate(species =
                  fct_lump_min(species, min = 3,
                               other_level = "Otras especies")) %>%
         count(species),
       aes(y = species, x = n, fill = n)) +
  geom_col() +
  scale_fill_continuous_tableau() +
  labs(fill = "Frecuencia absoluta",
       x = "Número de personajes", y = "Especies") +
  theme(panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "white", 
                                       color = "white"),
        panel.grid.major.y =
          element_line(size = 0.05, color = "black"),
        panel.grid.major.x =
          element_line(size = 0.1, color = "black"),
        text = element_text(size = 13),
        axis.title =
          element_text(family = "Roboto", size = 23),
        axis.text.x = element_text(family = "Roboto",
                                   size = 15),
        axis.text.y = element_text(family = "Roboto",
                                   size = 15))

# nube de palabras
# install.packages("wordcloud2)
library(wordcloud2)
wordcloud2(starwars %>% drop_na(species) %>%
             mutate(species =
                      fct_lump_min(species, min = 2,
                                   other_level = "otras")) %>% 
             count(species),
           size = 0.8, color= 'random-dark')

# mosaico
# install.packages("treemapify")
library(treemapify)
ggplot(starwars %>% drop_na(species) %>%
         mutate(species =
                  fct_lump_min(species, min = 2,
                               other_level = "otras")) %>%
         count(species),
       aes(area = n, fill = species, label = species)) +
  geom_treemap() +
  scale_fill_manual(values = MetBrewer::met.brewer("Renoir")) +
  labs(fill = "Especies")

ggplot(starwars %>% drop_na(species) %>%
         mutate(species =
                  fct_lump_min(species, min = 2,
                               other_level = "otras")) %>%
         count(species),
       aes(area = n, fill = species, label = species)) +
  geom_treemap() +
  geom_treemap_text(colour = "white", place = "centre",
                    size = 17) +
  scale_fill_manual(values = MetBrewer::met.brewer("Renoir")) +
  labs(fill = "Especies") +
  guides(fill = "none")

# HEMICICLO
# install.packages("ggparliament")
library(ggparliament)
election_data

rusia <- election_data %>%
filter(country == "Russia" & year == 2016)

rusia_parlamento <-
as_tibble(parliament_data(election_data = rusia, type = "semicircle",
parl_rows = 9, party_seats = rusia$seats))
rusia_parlamento

parlamento <-
  ggplot(rusia_parlamento,
         aes(x = x, y = y, colour = party_short)) +
  geom_parliament_seats()
parlamento

parlamento +
  draw_partylabels(type = "semicircle",
                   party_names = party_long,
                   party_seats = seats,
                   party_colours = colour) + 
  draw_totalseats(n = 450, type = "semicircle")

parlamento +
  draw_totalseats(n = 450, type = "semicircle") +
  theme_ggparliament() +
  labs(color = "Partidos",
       title = "Resultados de las elecciones de Rusia 2016") +
  scale_colour_manual(values = rusia_parlamento$colour, 
                      limits = rusia_parlamento$party_short) +
  theme(plot.margin = margin(t = 4, r = 4, b = 4, l = 8, "pt"),
        plot.title = element_text(size = 30))

# ----- Análisis univariante: cualitativas ordinales -----


# Tablas de frecuencias para ordinales
notas_curso <-
  c("aprobado", "aprobado", "notable", "suspenso",
    "suspenso", "aprobado", "notable", "sobresaliente",
    "aprobado", "aprobado", "suspenso", "suspenso",
    "suspenso", "aprobado", "sobresaliente", "notable",
    "notable", "sobresaliente", "suspenso", "aprobado")
notas_curso

notas_curso <- tibble("notas" = notas_curso)

# Frecuencias absolutas + relativas
notas_freq <-
  notas_curso %>%
  count(notas) %>%
  mutate(f = n / sum(n))
notas_freq

notas_curso <- notas_curso %>%
  mutate(notas =
           factor(notas,
                  levels = c("suspenso", "aprobado",
                             "notable", "sobresaliente"),
                  ordered = TRUE))
notas_curso %>% pull(notas)

notas_freq_acum <-
  notas_curso %>%
  count(notas) %>%
  rename(n_i = n) %>%
  mutate(f_i = n_i / sum(n_i),
         N_i = cumsum(n_i),
         F_i = cumsum(N_i))
notas_freq_acum

library(MetBrewer)
ggplot(notas_freq_acum,
       aes(x = notas, y = n_i,
           fill = as.factor(n_i))) +
  geom_col(alpha = 0.7) +
  scale_fill_manual(values = met.brewer("Klimt")) +
  guides(fill = "none") +
  labs(x = "Notas", y = "Frec. absolutas acumuladas",
       title = "FRECUENCIAS ABSOLUTAS Y RELATIVAS")

ggplot(notas_freq_acum,
       aes(x = notas, y = N_i,
           fill = as.factor(N_i))) +
  geom_col(alpha = 0.7) +
  scale_fill_manual(values = met.brewer("Klimt")) +
  guides(fill = "none") +
  labs(x = "Notas", y = "Frec. absolutas acumuladas",
       title = "FRECUENCIAS ABSOLUTAS Y RELATIVAS")

ggplot(notas_freq_acum,
       aes(x = notas, y = F_i,
           fill = as.factor(F_i))) +
  geom_col(alpha = 0.7) +
  scale_fill_manual(values = met.brewer("Klimt")) +
  guides(fill = "none") +
  labs(x = "Notas", y = "Frec. relativas acumuladas",
       title = "FRECUENCIAS ABSOLUTAS Y RELATIVAS")

  