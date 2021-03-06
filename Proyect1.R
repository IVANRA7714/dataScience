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

#file.choose()

dir1 <- "/home/rstudio/dataScience/e.csv"

wbcd <- read.csv(dir1, stringsAsFactors = FALSE)
wbcd <- wbcd[-1]
wbcd <- wbcd[-1]
#wbcd$day_of_week_tz <- factor(wbcd$day_of_week_tz, levels = c("Monday", "Tuesday", "Wednesday","Thursday","Friday","Saturday","Sunday"), labels = c("1", "2","3","4","5","6","7"))
#wbcd$day_of_week_tz <- as.integer(wbcd$day_of_week_tz)
#wbcd <- select(wbcd, branch_office, hour_tz, visitor, tiempodeses)
as.data.frame(wbcd)
str(wbcd)

# Generamos una tabla con visitor

# recodificamos la columna diagnosis como factor
# los algoritmos requieren que el valor "objetivo" (columna de respuestas) sea un factor 
#wbcd$visitor <- as.character(wbcd$visitor)
  
wbcd$visitor <- factor(wbcd$visitor, levels = c("true", "false"), labels = c("Visitante", "No visitante"))

# Transformamos la tabla a porcentajes
round(prop.table(table(wbcd$visitor)) * 100, digits = 2)

## Entrenamiento
# separamos la DB en un set como entrenamiento y otro como prueba
nfilas <- floor(nrow(wbcd) * .80)
set.seed(123)
index <- sample(1:nrow(wbcd), nfilas) # 80%
wbcd_train <- wbcd[index, -6] # Obtener solo las muestras
wbcd_test <- wbcd[-index, -6] # Todo menos las muestras

wbcd_train_labels <- wbcd[index, 6]
#wbcd_train_labels <- wbcd_train_labels$visitor
wbcd_test_labels <- wbcd[-index, 6]


# Guardamos la clasificación de cada uno (B o M) de la primera columna
#wbcd_train_labels <- wbcd[1:nfilas, 1]
#wbcd_test_labels <- wbcd[(nfilas+1):nfilas, 1]
str(wbcd_train_labels)

# Generando el modelo
wbcd_model <- C5.0(wbcd_train, wbcd_train_labels)
wbcd_model
summary(wbcd_model)

## ------------- ------------- ------------- ------------- -------------
# Evaluamos el modelo
# Creamos un vector con las predicciones sobre nuestos datos de pruebas
wbcd_pred <- predict(wbcd_model, wbcd_test)

CrossTable(wbcd_test_labels, wbcd_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE)

## ------------- ------------- ------------- ------------- -------------
# boosts
# 
wbcd_boost10_model <- C5.0(wbcd_train, wbcd_train_labels,trials = 10)
wbcd_boost10_model
summary(wbcd_boost10_model)

wbcd_boost_pred10 <- predict(wbcd_boost10_model, wbcd_test)
CrossTable(wbcd_test_labels, wbcd_boost_pred10,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual', 'predicción'))