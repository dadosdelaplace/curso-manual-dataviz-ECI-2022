# ----- cuantitativas continuas -----

## Basados en puntos
datos <-
  read_csv("https://raw.githubusercontent.com/zonination/perceptions/master/probly.csv")
datos

datos_pivot <-
  datos %>%
  pivot_longer(cols = everything(),
               names_to = "termino", values_to = "prob")

datos_final <-
  datos_pivot %>%
  filter(termino %in% c("Almost No Chance", "Chances Are Slight",
                        "Improbable", "About Even",
                        "Probable", "Almost Certainly")) %>%
  mutate(termino = fct_reorder(termino, prob))

# barras
ggplot(datos_final %>%
         group_by(termino) %>%
         summarise(media = mean(prob)),
       aes(x = termino, y = media, fill = termino)) +
  geom_col()

library(sysfonts)
library(showtext)
font_add_google(family = "Roboto", name = "Roboto")
showtext_auto()

theme_set(theme_void(base_family = "Roboto"))
theme_update(
  axis.text.x =
    element_text(color = "black", face = "bold", size = 13),
  axis.text.y = element_text(color = "black", size = 9),
  axis.line.x = element_line(color = "black", size = 1),
  panel.grid.major.y = element_line(color = "grey90", size = 0.7),
  plot.background = element_rect(fill = "white", color = "white"),
  plot.title = element_text(color = "black", face = "bold",
                            size = 27),
  plot.margin = margin(t = 15, r = 15, l = 15, b = 15))

ggplot(datos_final %>%
         group_by(termino) %>%
         summarise(media = mean(prob)),
       aes(x = termino, y = media, fill = termino)) +
  geom_col(alpha = 0.8) +
  scale_fill_brewer(palette = "RdBu") +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

# ¿Cómo podemos visualizar una variable continua? puntos
starwars_altura <-
  starwars %>%
  drop_na(height, species) %>%
  mutate(human = as_factor(species == "Human"))

library(ggbeeswarm)
ggplot(starwars_altura,
       aes(x = human, y = height,
           fill = human, color = human)) +
  geom_quasirandom(size = 4.5, width = 0.5, alpha = 0.5) +
  scale_x_discrete(labels = c("NO", "SÍ")) +
  guides(color = "none", fill = "none") +
  labs(x = "¿Son humanos?",
       y = "Altura (cm)",
       title = "ALTURA DE LOS PERSONAJES DE STARWARS")

ggplot(datos_final,
       aes(x = termino, y = prob,
           fill = termino, color = termino)) +
  geom_quasirandom(size = 3.5, width = 0.5,
                   alpha = 0.7) + 
  geom_quasirandom(size = 3.5, width = 0.5, shape = 1,
                   color = "black", stroke = 0.7) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(fill = "none") +
  labs(color = "Términos", x = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

# Cajas y bigotes

ggplot(datos_final,
       aes(x = termino, y = prob, fill = termino)) +
  geom_boxplot(alpha = 0.8) +
  scale_fill_brewer(palette = "RdBu") +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

ggplot(datos_final,
       aes(x = termino, y = prob,
           color = termino, fill = termino)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(alpha = 0.25, size = 1.5) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none", fill = "none")
labs(fill = "Términos",
     y = "Probabilidad (%)",
     title = "Percepción de la probabilidad")

# Con `coord_flip()` podemos invertir los ejes
ggplot(datos_final,
       aes(x = termino, y = prob,
           color = termino, fill = termino)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(alpha = 0.25, size = 1.5) +
  coord_flip() +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none", fill = "none") +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

# Histogramas y densidad
ggplot(datos_final,
       aes(x = prob, color = termino, fill = termino)) +
  geom_density(alpha = 0.4) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none") +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

ggplot(datos_pivot %>%
         mutate(termino = fct_reorder(termino, prob)),
       aes(x = prob, color = termino, fill = termino)) +
  geom_density(alpha = 0.4) +
  scale_fill_viridis_d() +
  scale_color_viridis_d() +
  facet_wrap(~ termino, scale = "free_y") +
  guides(color = "none", fill = "none")  +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

ggplot(datos_pivot %>%
         mutate(termino = fct_reorder(termino, prob)),
       aes(x = prob, color = termino, fill = termino)) +
  geom_histogram(alpha = 0.4) +
  scale_fill_viridis_d() +
  scale_color_viridis_d() +
  facet_wrap(~ termino, scale = "free_y") +
  guides(color = "none", fill = "none")  +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

ggplot(datos_pivot %>%
         mutate(termino = fct_reorder(termino, prob)),
       aes(x = prob, color = termino, fill = termino)) +
  geom_histogram(bins = 10, alpha = 0.4) +
  scale_fill_viridis_d() +
  scale_color_viridis_d() +
  facet_wrap(~ termino, scale = "free_y") +
  guides(color = "none", fill = "none")  +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

# densidades apiladas
library(ggridges)
ggplot(datos_pivot %>%
         mutate(termino = fct_reorder(termino, prob)),
       aes(y = termino, x = prob, fill = termino)) +
  geom_density_ridges(alpha = 0.4) +
  scale_fill_viridis_d() +
  scale_color_viridis_d() +
  guides(color = "none", fill = "none")  +
  labs(fill = "Términos",
       y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

# Gráficos de violín
ggplot(datos_final,
       aes(y = termino, x = prob,
           fill = termino)) +
  geom_violin(size = 1) +
  scale_fill_brewer(palette = "RdBu") +
  guides(fill = "none")  +
  labs(y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

library(colorspace)
ggplot(datos_final,
       aes(y = termino, x = prob)) +
  geom_violin(aes(fill = termino, color = termino,
                  fill = after_scale(lighten(fill, .4))),
              size = 1) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none", fill = "none")  +
  labs(y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

ggplot(datos_final,
       aes(y = termino, x = prob)) +
  geom_violin(aes(fill = termino, color = termino,
                  fill = after_scale(lighten(fill, .4))),
              size = 1, bw = 1.5) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  guides(color = "none", fill = "none")  +
  labs(y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

ggplot(datos_final,
       aes(y = termino, x = prob)) +
  geom_violin(aes(fill = termino, color = termino,
                  fill = after_scale(lighten(fill, .4))),
              size = 1, bw = 1.5) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  coord_flip() +
  guides(color = "none", fill = "none")  +
  labs(y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")

# Half-eye plots

library(ggdist)
ggplot(datos_final,
       aes(y = termino, x = prob)) +
  stat_halfeye(aes(fill = termino,
                   fill = after_scale(lighten(fill, .5))),
               .width = 0.5, adjust = 0.7, point_size = 2) +
  scale_fill_brewer(palette = "RdBu") +
  scale_color_brewer(palette = "RdBu") +
  coord_flip() +
  guides(color = "none", fill = "none")  +
  labs(y = "Probabilidad (%)",
       title = "Percepción de la probabilidad")
