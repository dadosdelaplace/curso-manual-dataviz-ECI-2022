# ----- profundizando ggplot2 -----



# ----- Personalizando el tema: NETFLIX -----

# Datos
netflix <-
  read_csv('https://raw.githubusercontent.com/elartedeldato/datasets/main/netflix_titles.csv')
netflix

# Filtramos por instituto
netflix_hs <- netflix %>%
  filter(str_detect(toupper(description), "HIGH SCHOOL"))
netflix_hs 

# Añadir el año en el que se estrenó, con la función year(),
# que nos devuelve el año de una fecha concreta.
# Esa fecha concreta la vamos a construir con mdy().
library(lubridate)
mdy("August 26, 2016")
netflix_final <- 
  netflix_hs %>%
  mutate(year = year(mdy(date_added))) %>%
  filter(!is.na(year))

# Agrupar 
netflix_resumen <- 
  netflix_final %>%
  group_by(year) %>%
  count() %>%
  ungroup()
netflix_resumen

# Diagrama de barras color rojo
ggplot(netflix_resumen, aes(x = year, y = n)) +
  geom_col(fill = "red")

# Modificando la escala de los ejes
ggplot(netflix_resumen, aes(x = year, y = n)) +
  geom_col(fill = "red") +
  scale_x_continuous(breaks = netflix_resumen$year)

# Escala de fecha
ggplot(netflix %>%
         mutate(date_added = mdy(date_added)) %>%
         filter(!is.na(date_added) &
                  date_added > as.Date("2020-07-01")) %>%
         group_by(date_added) %>% count(),
       aes(x = date_added, y = n)) +
  geom_col(fill = "red") +
  scale_x_date(date_breaks = '1 month') 

# Personalizando tema: título
ggplot(netflix_resumen, aes(x = year, y = n)) +
  geom_col(fill = "red") +
  scale_x_continuous(breaks = netflix_resumen$year) +
  labs(title = "NETFLIX",
       subtitle = "Películas y series de instituto",
       caption = "Basada en El Arte del Dato (https://elartedeldato.com) | Datos: Kaggle")

# Fuentes
library(sysfonts)
library(showtext)
font_add_google(family = "Bebas Neue",
                name = "Bebas Neue")
showtext_auto()
gg <- ggplot(netflix_resumen, aes(x = year, y = n)) +
  geom_col(fill = "red") +
  scale_x_continuous(breaks = netflix_resumen$year) +
  theme_void() +
  theme(legend.position = "none",
        plot.title = element_text(family = "Bebas Neue",
                                  color = "red", size = 80)) +
  labs(title = "NETFLIX",
       subtitle = "Películas y series de instituto",
       caption = "Basada en El Arte del Dato (https://elartedeldato.com) | Datos: Kaggle")
gg

# Fondo gráfico
gg <- 
  gg +
  theme(panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black", 
                                       color = "black"))
gg

# Grid horizontal
gg <- gg +
  theme(panel.grid.major.y =
          element_line(size = 0.1, color = "white"))
gg

# Subtítulo y caption
font_add_google(family = "Permanent Marker",
                name = "Permanent Marker")
showtext_auto()
gg <- gg + 
  theme(plot.subtitle = element_text(family = "Permanent Marker",
                                     size = 21, color = "white"),
        plot.caption =  element_text(family = "Permanent Marker",
                                     color = "white", size = 19),
        axis.text = 
          element_text(size = 15, family = "Permanent Marker",
                       color = "white"))
gg

# Márgenes
gg <- gg +
  theme(plot.margin = margin(t = 4, r = 4, b = 4, l = 8, "pt"))
gg

# Anotación
gg <- gg  +
  annotate("text", label = "(hasta enero)", 
           x = 2021, y = 11, hjust = 0.3, vjust = 0, family = "Permanent Marker", size = 5, color='white', angle = 20) +
  annotate("curve", x = 2021, y = 9, xend = 2021, yend = 5,
           color = "white")
gg


# ----- Gráficos en coordenadas polares -----
library(HistData)
Nightingale
glimpse(Nightingale)

# preprocesado
datos <-
  Nightingale %>% 
  select(Date, Month, Year, contains("rate"))

datos <-
  datos %>%
  pivot_longer(cols = 4:6, names_to = "causa",
               values_to = "tasa") %>%
  rename(fecha = Date, mes = Month, year = Year) 

datos <-
  datos %>%
  mutate(causa = gsub(".rate", "", causa),
         causa =
           case_when(causa == "Disease" ~ "infecciosas",
                     causa == "Wounds" ~ "heridas",
                     causa == "Other" ~ "otras",
                     TRUE ~ "otras"),
         periodo =
           factor(ifelse(fecha >= as.Date("1855-04-01"),
                         "APRIL 1855 TO MARCH 1856",
                         "APRIL 1854 TO MARCH 1855"),
                  levels = c("APRIL 1855 TO MARCH 1856",
                             "APRIL 1854 TO MARCH 1855")))
datos

# diagrama de barras
ggplot(datos %>%
         filter(periodo == "APRIL 1854 TO MARCH 1855"),
       aes(mes, tasa, fill = causa)) + 
  geom_col() +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST (April 1854 - March 1855)",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

ggplot(datos %>%
         filter(periodo == "APRIL 1855 TO MARCH 1856"),
       aes(mes, tasa, fill = causa)) + 
  geom_col() +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST (April 1855 - March 1856)",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

# facet_wrap
ggplot(datos, aes(mes, tasa, fill = causa)) + 
  geom_col() +
  facet_wrap( ~ periodo) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

# colores
ggplot(datos, aes(mes, tasa, fill = causa)) + 
  geom_col() +
  facet_wrap( ~ periodo)  +
  scale_fill_manual(values =
                      c("#C42536", "#5aa7d1", "#6B6B6B")) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

# reordenamos meses
datos <- 
  datos %>%
  mutate(mes =
           fct_relevel(mes, "Apr", "May", "Jun", "Jul",
                       "Aug", "Sep", "Oct", "Nov", "Dec",
                       "Jan", "Feb", "Mar"))
gg <-
  ggplot(datos, aes(mes, tasa, fill = causa)) + 
  geom_col() +
  facet_wrap( ~ periodo)  +
  scale_fill_manual(values =
                      c("#C42536", "#5aa7d1", "#6B6B6B")) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")
gg

# coordenadas polares
datos <- 
  datos %>%
  mutate(mes =
           fct_relevel(mes, "Jul", "Aug", "Sep", "Oct",
                       "Nov", "Dec", "Jan", "Feb",
                       "Mar", "Apr", "May", "Jun"))

ggplot(datos, aes(mes, tasa, fill = causa)) + 
  geom_col(width = 1) +
  coord_polar() +
  scale_fill_manual(values =
                      c("#C42536", "#5aa7d1", "#6B6B6B")) +
  facet_wrap( ~ periodo) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData")

gg <- 
  ggplot(datos, aes(mes, tasa, fill = causa)) + 
  geom_col(width = 1) +
  coord_polar() +
  scale_fill_manual(values =
                      c("#C42536", "#5aa7d1", "#6B6B6B")) +
  scale_y_sqrt() +
  scale_x_discrete(labels =
                     c("JULY", "AUGUST", "SEPT.",
                       "OCTOBER", "NOVEMBER", "DECEMBER",
                       "JANUARY", "FEBRUARY", "MARCH",
                       "APRIL", "MAY", "JUNE")) +
  facet_wrap( ~ periodo) +
  labs(fill = "Causas",
       title = "DIAGRAM OF THE CAUSES OF MORTALITY",
       subtitle = "IN THE ARMY IN THE EAST",
       caption = "Author: J. Álvarez Liébana | Data: HistData") 
gg + theme(axis.title.y = element_blank(),
           axis.text.y = element_blank(),
           axis.ticks.y = element_blank())

# fuentes y tema
library(sysfonts)
library(showtext)
font_add_google(family = "Roboto",
                name = "Roboto")
font_add_google(family = "Cinzel Decorative",
                name = "Cinzel Decorative")
font_add_google(family = "Quattrocento",
                name = "Quattrocento")

showtext_auto()

angulo <- seq(-20, -340, length.out = 12)
gg + theme_void() +
  theme(
    # Eje y limpio
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    # Eje x (el radial)
    axis.text.x =
      element_text(face = "bold", size = 9, angle = angulo,
                   family = "Roboto"),
    panel.grid.major.x = element_line(size = 0.01, color = "black"),
    legend.position = "bottom",
    plot.background = element_rect(fill = alpha("cornsilk", 0.5)),
    plot.title =
      element_text(hjust = 0.5, size = 21,
                   family = "Cinzel Decorative"),
    plot.subtitle =
      element_text(hjust = 0.5, size = 15,
                   family = "Cinzel Decorative"),
    plot.caption =
      element_text(size = 9, family = "Quattrocento"),
    strip.text =
      element_text(hjust = 0.5, size = 7,
                   family = "Quattrocento"),
    plot.margin = margin(t = 5, r = 7, b = 5, l = 7, "pt"))
