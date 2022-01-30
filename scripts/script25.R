# ----- resumiendo datos -----

library(skimr)
starwars %>% skim()


# Medidas de centralización y dispersión
starwars %>% summarise(media = mean(mass),
                       mediana = median(mass))

# Primero eliminamos NA
starwars %>% drop_na(mass) %>%
  summarise(media = mean(mass), mediana = median(mass))

# Al realizar el cálculo los ignora
starwars %>%
  summarise(media = mean(mass, na.rm = TRUE),
            mediana = median(mass, na.rm = TRUE))

# Media de todas las cuantitativas
starwars_nueva %>%
  summarise(media = across(where(is.numeric), mean, na.rm = TRUE))

# Media y mediana de todas las cuantitativas
starwars_nueva %>%
  summarise(media = across(where(is.numeric), mean, na.rm = TRUE),
            mediana = across(where(is.numeric), median, na.rm = TRUE))

categorias <- c("muy bajo", "bajo", "medio", "alto", "muy alto")
starwars_talla <- 
  starwars %>%
  mutate(talla =
           cut(height, breaks = c(-Inf, 80, 120, 160, 190, Inf),
               labels = categorias))

# Mediana (hay que pasárselo como número)
starwars_talla %>%
  summarise(mediana =
              categorias[median(as.numeric(talla), na.rm = TRUE)])

# moda
library(modeest)

# Media y mediana y moda de mass y n_films
resumen <- 
  starwars_nueva %>%
  summarise(media = across(c(mass, n_films), mean, na.rm = TRUE),
            mediana = across(c(mass, n_films), median, na.rm = TRUE),
            moda_n_films = mfv(n_films, na_rm = TRUE),
            moda_mass = mlv(mass, na.rm = TRUE))
resumen

# multimodales
n <- 900
datos <-
  tibble("unimod" = rnorm(n, 5, 1),
         "bimod" = c(rnorm(n/2, 3, 1), rnorm(n/2, 7, 1)),
         "trimod" = c(rnorm(n/3, 2, 1), rnorm(n/3, 5, 1),
                      rnorm(n/3, 8, 1)))
# Tidy data
datos <-
  pivot_longer(datos, cols = everything(),
               names_to = "tipo", values_to = "values")

# Estadisticas
datos %>% 
  group_by(tipo) %>% 
  summarise(media = mean(values),
            mediana = median(values))

library(ggridges)
ggplot(datos,
       aes(y = tipo, x = values, fill = tipo)) +
  geom_density_ridges(alpha = 0.7, height = 1) +
  scale_fill_manual(values = met.brewer("Klimt")) +
  labs(fill = "Distribución",
       y = "Distribución",
       title = "DISTRIBUCIONES MULTIMODALES")

ggplot(datos,
       aes(y = tipo, x = values, fill = tipo)) +
  geom_density_ridges(alpha = 0.7, height = 1) +
  stat_density_ridges(quantile_lines = TRUE,
                      quantiles = c(0.25, 0.5, 0.75),
                      color = "black", alpha = .8,
                      size = 0.7) + 
  scale_fill_manual(values = met.brewer("Klimt")) +
  labs(fill = "Distribución",
       y = "Distribución",
       title = "DISTRIBUCIONES MULTIMODALES")

# medidas de dispersión 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     