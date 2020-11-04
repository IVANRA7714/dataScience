library(ggplot2)

p<-ggplot(iris, aes(x = Petal.Length, y = Petal.Width, colour = Species)) +
  geom_point() +
  geom_smooth() + 
  facet_grid(~ Species)
p

library(tidyverse)
library(treemap)