library(tidyverse)
library(treemap)

tempo<- data %>%
  group_by(sexo, rango_edad)%>%
  summarise(tdes= weighted.mean(tdes, pob))

gr <- ggplot(tempo, aes(x=sexo, y=rango_edad, fill=tdes)) +
  geom_tile(color="black") +
  scale_fill_continuous(low="#ffeda0", high="#f03b20") +
  labs(title="Tasa de desaparecidos promedio \n2010-2015",
       x="Sexo", y="Edad", fill="Tasa de desaparecidos") +
  coord_fixed() +
  theme_bw()

ggsave(paste('~/dataScience/graficas',"4.png",sep = "/"), plot=gr, width = 12, height = 12)

#_________________________________

#Treemaps#
tempo <- data %>%
  filter(year==2011) %>%
  group_by(ent, nom_ent) %>%
  summarise(total = sum(total)) %>%
  ungroup() %>%
  
  mutate(totales = sum(total),
         porcentaje = round((total/totales)*100,2))

png(paste('~/dataScience/graficas',"5.png",sep = "/"), width = 12, height = 12, units="in", res=300)

treemap(tempo, index = "ent", vSize = "porcentaje", vColor = "index",
        type = "index", title="Porcentaje de desaparecidos por entidad \n2011",
        palette = "Reds", title.legend = "",
        border.col = "grey", border.lwd = 0.5)
dev.off()

#_________________________________

#Scatter map
tempo <- data %>%
  group_by(inegi, nom_ent, nom_mun)%>%
  summarise(tdes=round(weighted.mean(tdes, pob),2),
            total=round(mean(total),2))

gr <- ggplot(tempo, aes(x=total, y=tdes)) +
  geom_point(color="maroon") +
  geom_text(aes(label=inegi), color="maroon", size=3, vjust=-1, hjust=0) +
  labs(title="Total de desaparecidos vs Tasa de desaparecidos",
       x="Total de desaparecidos", y="Tasa de desaparecidos") +
  theme_bw()
ggsave(paste('~/dataScience/graficas', "6.png", sep="/"), plot=gr, width = 12, height = 12)

#_________________________________

# Líneas de tendencia
#1 linea recta
gr <- ggplot(tempo, aes(x=total, y=tdes)) +
  geom_point(color="maroon") +
  geom_text(aes(label=inegi), color="maroon", size=3, vjust=-1, hjust=0) +
  geom_smooth(method="lm", se=T) +
  labs(title="Total de desaparecidos vs Tasa de desaparecidos",
       x="Total de desaparecidos", y="Tasa de desaparecidos") +
  theme_bw()
ggsave(paste('~/dataScience/graficas', "7.png", sep="/"), plot=gr, width = 12, height = 12)

#2 escalas
gr <- ggplot(tempo, aes(x=total, y=tdes)) +
  geom_point(color="maroon") +
  geom_text(aes(label=inegi), color="maroon", size=3, vjust=-1, hjust=0) +
  geom_smooth() +
  labs(title="Total de desaparecidos vs Tasa de desaparecidos",
       x="Total de desaparecidos", y="Tasa de desaparecidos") +
  theme_bw() +
  scale_x_log10() + scale_y_log10()
ggsave(paste('~/dataScience/graficas', "8.png", sep="/"),plot=gr, width=12, height = 12)

#_________________________________

# Fiebre #
##########
# Sirve para ver tendencia en el tiempo
tempo <- data %>%
  group_by(sexo, year) %>%
  summarise(tdes = round(weighted.mean(tdes, pob),2))

gr <- ggplot(tempo, aes(x=year, y=tdes, color=sexo)) +
  geom_line() +
  geom_point() +
  geom_text(aes(label=tdes), vjust=-1) +
  labs(title="Tendencia de la tasa de desaparecidos \n 2010-2015",
       x="Año", y="Tasa de desaparecidos", color="Sexo") +
  theme_bw() +
  scale_colour_manual(values = c("Hombre" = "red", "Mujer" = "blue"))
ggsave(paste('~/dataScience/graficas', "9.png", sep="/"), plot=gr, width=12, height = 12)

#_________________________________

# Area
# Otra forma seria ver el % de desaparecidos hombres y mujeres por año
tempo <- data %>%
  group_by(sexo, year) %>%
  summarise(total = sum(total)) %>%
  ungroup() %>%
  group_by(year) %>%
  mutate(totales = sum(total),
         porcentaje = round((total/totales)*100,2))

gr <- ggplot(tempo, aes(x=year, y=porcentaje, fill=sexo)) +
  geom_area() +
  geom_point( data=tempo[tempo$sexo=='Mujer',])+
  geom_text(aes(label=porcentaje), vjust=-1, data=tempo[tempo$sexo=='Mujer',]) +
  scale_fill_manual(values=c("#67a9cf", "#ef8a62")) +
  labs(title="Porcentaje de desaparecidos por sexo \n 2010-2015",
       x="Año", y="% de desaparecidos", fill="Sexo") +
  theme_bw()
ggsave(paste('~/dataScience/graficas', "10.png", sep="/"), plot=gr, width=12, height = 12)






