rm(list=ls())
setwd("~")

####################
# Machine Learning #
# Decision Trees	 #
#   			 		     #
####################

#install.packages(c("C50", "gmodels"))
library(tidyverse)
library(gmodels) # Herramientas para evaluar árbol de decisión
library('C50') # Genera el árbol de decisión

dir1 <- "dataScience"

wbcd <- read.csv(dir1, stringsAsFactors = FALSE)
wbcd <- wbcd[-1]
str(wbcd)

# Generamos una tabla con visitor

# recodificamos la columna diagnosis como factor
# los algoritmos requieren que el valor "objetivo" (columna de respuestas) sea un factor 
wbcd$visitor <- as.character(wbcd$visitor)
  
wbcd$visitor <- factor(wbcd$visitor, levels = c("TRUE", "FALSE"), labels = c("Visitante", "No visitante"))

# Transformamos la tabla a porcentajes
round(prop.table(table(wbcd$visitor)) * 100, digits = 2)

## Entrenamiento
# separamos la DB en un set como entrenamiento y otro como prueba
nfilas <- floor(nrow(wbcd) * .80)
set.seed(123)
index <- sample(1:nrow(wbcd), nfilas) # 80%
wbcd_train <- wbcd[index, -1] # Obtener solo las muestras
wbcd_test <- wbcd[-index, -1] # Todo menos las muestras

wbcd_train_labels <- wbcd[index, 1]
wbcd_test_labels <- wbcd[-index, 1]

# Guardamos la clasificación de cada uno (B o M) de la primera columna
#wbcd_train_labels <- wbcd[1:nfilas, 1]
#wbcd_test_labels <- wbcd[(nfilas+1):nfilas, 1]
str(wbcd_train_labels)

# Generando el modelo
wbcd_model <- C5.0(wbcd_train, wbcd_train_labels)
wbcd_model
summary(wbcd_model)
