# ----- intro a ggplot2 -----

library(tidyverse)

# Primer intento: scatter plot o diagrama de puntos

### Datos: gapminder
library(gapminder)
gapminder
glimpse(gapminder)

# Filtraremos los datos de 1997
gapminder_1997 <- gapminder %>% filter(year == 1997)
gapminder_1997

# Diagrama de puntos
ggplot(gapminder_1997, aes(x = gdpPercap, y = pop)) +
  geom_point()

### Mapeado de elementos (aesthetics)
ggplot(gapminder_1997, aes(y = gdpPercap, x = pop)) +
  geom_point()

ggplot(gapminder_1997, aes(y = gdpPercap, x = lifeExp)) +
  geom_point()

# Color con palabra reservada
ggplot(gapminder_1997, aes(y = gdpPercap, x = lifeExp)) +
  geom_point(color = "red")

# Color en hexadecimal, de la página https://htmlcolorcodes.com/es/
ggplot(gapminder_1997, aes(y = gdpPercap, x = lifeExp)) +
  geom_point(color = "#2EA2D8")

# Color opaco
ggplot(gapminder_1997, aes(y = gdpPercap, x = lifeExp)) +
  geom_point(color = "#A02B85", size = 4)

# alpha = 50%
ggplot(gapminder_1997, aes(y = gdpPercap, x = lifeExp)) +
  geom_point(color = "#A02B85", size = 8, alpha = 0.4)

# mapear en aes() para que dependan de los datos, por ejemplo,
# asignándole un color a cada dato en función de su continente
ggplot(gapminder_1997, aes(y = gdpPercap, x = lifeExp, color = continent)) +
  geom_point(size = 4.5)

# combinarlo con lo que hemos hecho anteriormente e indicarle 
# además que queremos el tamaño en función de la población,
# con cierto grado de transparencia. 
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7)

# añadir las variables en función de la forma de la geometría
# (en este caso la forma de los «puntos») con `shape = ...`,
# haciéndola depender de `continent` 
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp, shape = continent, size = pop)) +
  geom_point(alpha = 0.7)

### Scales y paletas de colores
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.7)

# ejes escala logarítmica
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  # Eje Y con escala logarítmica
  scale_y_log10()

# escala colores manual
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  # Escala manual de colores
  scale_color_manual(values = c("#A02B85", "#2DE86B", "#4FB2CA",
                                "#E8DA2D", "#E84C2D"))

# paletas
library(ggthemes)

# scale_color_economist()
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_economist()

# scale_color_excel()
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_excel()

# scale_color_tableau()
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_tableau()

devtools::install_github(repo = "https://github.com/aljrico/harrypotter")
library(harrypotter)
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  scale_color_hp_d(option = "gryffindor")

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  scale_color_hp_d(option = "hufflepuff")


devtools::install_github("G-Thomson/Manu")
library(Manu)
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  # paleta del pájaro Takahē - Porphyrio hochstetteri
  scale_colour_manual(values = get_pal("Takahe"))

devtools::install_github("BlakeRMills/MetBrewer") 
library(MetBrewer)
MetBrewer::met.brewer("Renoir")
MetBrewer::met.brewer("Monet")
MetBrewer::met.brewer("Hokusai")

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  scale_colour_manual(values = met.brewer("Klimt"))

### Geometrías (geom)

# Sin separar por continente
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp)) +
  geom_line(alpha = 0.8) +
  scale_y_log10() +
  scale_color_tableau()

# Separando por continente
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent)) +
  geom_line(alpha = 0.8) +
  scale_y_log10() +
  scale_color_tableau()

# geom_hex
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           fill = continent, size = pop)) +
  geom_hex(alpha = 0.8) +
  scale_y_log10() + scale_fill_tableau()

# geom_tile()
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_tile(alpha = 0.8) +
  scale_y_log10() +
  scale_color_tableau()

# geom_text()
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop, label = country)) +
  geom_text(alpha = 0.8) +
  scale_y_log10() +
  scale_color_tableau()

### Componer (facets)

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  facet_wrap(~ continent)

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  facet_wrap(~ continent, nrow = 3)

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  facet_wrap(~ continent, ncol = 4)

library(MetBrewer)
ggplot(gapminder,
       aes(y = lifeExp, x = pop, size = gdpPercap, color = continent)) +
  geom_point(alpha = 0.6) +
  scale_x_log10() +
  scale_colour_manual(values = met.brewer("Klimt")) +
  facet_wrap(~ year)

# facet_grid()
ggplot(gapminder %>% filter(year %in% c(1952,  1972, 1982,  2002)),
       aes(y = gdpPercap, x = lifeExp)) +
  geom_point(alpha = 0.9) +
  scale_y_log10() +
  facet_grid(year ~ continent)

### Coordenadas y tema

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_tableau() +
  labs(title = "EJEMPLO DE SCATTERPLOT CON GGPLOT2",
       subtitle =
         "Esperanza vida vs renta per cápita (año 1997)",
       caption = "Autor: Javier Álvarez Liébana | Datos: gapminder")

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_tableau() +
  labs(x = "Esperanza de vida", y = "Renta per cápita",
       color = "Continente", size = "Población",
       title = "EJEMPLO DE SCATTERPLOT CON GGPLOT2",
       subtitle =
         "Esperanza vida vs renta per cápita (año 1997)",
       caption = "Autor: Javier Álvarez Liébana | Datos: gapminder")

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_tableau() +
  labs(x = "Esperanza de vida",
       y = "Renta per cápita",
       color = NULL, size = "Población",
       title = "EJEMPLO DE SCATTERPLOT CON GGPLOT2",
       subtitle =
         "Esperanza vida vs renta per cápita (año 1997)",
       caption = "Autor: Javier Álvarez Liébana | Datos: gapminder")

# ocultar la leyenda
ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_tableau() +
  guides(size = "none") +
  labs(x = "Esperanza de vida",
       y = "Renta per cápita",
       color = NULL, size = "Población",
       title = "EJEMPLO DE SCATTERPLOT CON GGPLOT2",
       subtitle =
         "Esperanza vida vs renta per cápita (año 1997)",
       caption = "Autor: Javier Álvarez Liébana | Datos: gapminder")

ggplot(gapminder_1997,
       aes(y = gdpPercap, x = lifeExp,
           color = continent, size = pop)) +
  geom_point(alpha = 0.8) +
  # Eje Y con escala logarítmica
  scale_y_log10() +
  scale_color_tableau() +
  guides(size = "none", color = "none") +
  labs(x = "Esperanza de vida",
       y = "Renta per cápita",
       color = NULL, size = "Población",
       title = "EJEMPLO DE SCATTERPLOT CON GGPLOT2",
       subtitle =
         "Esperanza vida vs renta per cápita (año 1997)",
       caption = "Autor: Javier Álvarez Liébana | Datos: gapminder")

## Segundo intento: diagrama de barras

# geom_col()
ggplot(gapminder,
       aes(y = gdpPercap, x = year)) +
  geom_col()

gapminder_por_continente <-
  gapminder %>% group_by(year, continent) %>%
  summarise(sum_gdpPercap = sum(gdpPercap))
gapminder_por_continente

ggplot(gapminder_por_continente,
       aes(y = sum_gdpPercap, x = year,
           fill = continent)) +
  geom_col() +
  scale_fill_tableau()

ggplot(gapminder_por_continente,
       aes(y = sum_gdpPercap, x = year,
           fill = continent)) +
  geom_col(position = "dodge2") +
  scale_fill_tableau()

ggplot(gapminder_por_continente,
       aes(y = sum_gdpPercap, x = year,
           fill = continent)) +
  geom_col(position = "fill") +
  scale_fill_tableau()

# horizontales
ggplot(gapminder_por_continente,
       aes(y = sum_gdpPercap, x = year,
           fill = continent)) +
  geom_col() + coord_flip() +
  scale_fill_tableau() +
  labs(x = "Renta per cápita",
       y = "Año", color = "Continente",
       title = "EJEMPLO DE DIAGRAMA DE BARRAS CON GGPLOT2",
       subtitle =
         "Barras horizontales apiladas (agrupadas por continente y año)",
       caption = "Autor: Javier Álvarez Liébana | Datos: gapminder")


