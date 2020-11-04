library(nycflights13)
library(dplyr)

flights
airlines
flights$carrier

flights2 = flights %>% select(year:day, hour, origin, dest, tailnum, carrier)

flights2 %>%
  left_join(airlines)

weather
df = flights2 %>% left_join(weather)
filter(df, year==2013, month==1, day==1, hour==5, origin=="EWR")

planes
flights2 %>% left_join(planes, by "tailnum")


flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)

(df1 <- tibble(x = c(1,1,3,4), y = 1:4))
(df2 <- tibble(x = c(1,1,2), z = c("a,","b","a")))

nrow(df1)
df1 %>% semi_join(df2, by="x") %>% nrow()

install.packages("datos")
library(datos)
library(tidyverse)

tabla4a %>%
  pivot_longer(cols = c(`1999`,`2000`), names_to="anio", values_to = "casos")

tabla2 %>%
  pivot_wider(names_from = tipo, values_from = cuenta)

set.seed(1234)
df<-data.frame(identifier = rep(1:5, each=3),
           location = rep(c("up","down","left","up","center"),each=3),
           period=rep(1:3,5),
           counts = sample(35,15, replace = TRUE),
           values=runif(15,5,10))[-c(4,8,11),]
df

(df.wide <- reshape(df, idvar = "identifier", timevar = "period",
                   v.names = c("values","counts"), direction = "wide"))

tabla3 %>%
  separate(tasa,into = c("casos","poblacion"))

tabla3 %>%
  separate(tasa,into = c("casos","poblacion"),sep = "/")

tabla3 %>%
  separate(tasa,into = c("casos","poblacion"),sep = "/",convert = TRUE)

tabla3 %>%
  separate(anio,into = c("siglo","anio"), sep=2)
  summarise(tab)
  
#________________________________________________
#Actividad 3 y 4

  library(datos)
  library(tidyverse)
  
  personas <- tribble(
    ~nombre, ~nombres, ~valores,
    #-----------------|--------|------
    "Phillip Woods", "edad", 45,
    "Phillip Woods", "estatura", 186,
    "Phillip Woods", "edad2", 50,
    "Jessica Cordero", "edad", 37,
    "Jessica Cordero", "estatura", 156
  )
  
  #¿Qué pasaría si trataras de pivotar esta tabla a lo ancho? ¿Por qué?
  personas %>%
    pivot_wider(names_from = "nombre", values_from = "valores")
    #No se puede pivotar porque no hay una lista de valores únicos.
  
  #¿Cómo podrías agregar una nueva columna que identifique de manera única cada 
  #valor?
  personas %>%
  (personas2 <- reshape(personas, idvar = "nombre", timevar = "nombres",
                        v.names= c("valores"), direction = "wide"))
  
  embarazo <- tribble(
    ~embarazo, ~hombre, ~mujer,
    "sí", NA, 10,
    "no", 20, 12
  )
  embarazo
  
  embarazo %>%
    pivot_longer(cols = c(hombre,mujer), names_to="sex", values_to = "casos")
  