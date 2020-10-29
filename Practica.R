adult <- read_csv("dataScience/adult.data",col_names = FALSE)
View(adult)

names(adult)= c("Listing of attributes","age","workclass","fnlwgt","education","education-num","marital-status","occupation","relationship","race","sex","capital-gain","capital-loss","hours-per-week","native-country")
names(adult)

adultos <- as_tibble(adult)
str(adultos)

Hombres <- filter(adultos, sex == " Male")
