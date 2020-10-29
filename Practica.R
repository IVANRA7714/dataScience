#Descarga e importa la base de datos adult (recuerda usar read.csv)
adult <- read_csv("dataScience/adult.data",col_names = FALSE)
View(adult)

#Renombra la columnas acorde a sus nombres en la descripción del dataset (ver la url)
#La variable "Listing of attributes" va al final, si no la pones aparece en NA
names(adult)= c("age","workclass","fnlwgt","education","education-num","marital-status","occupation","relationship","race","sex","capital-gain","capital-loss","hours-per-week","native-country","Listing of attributes")
names(adult)

#Transforma la base de datos a Tibble
adultos <- as_tibble(adult)
str(adultos)

#Filtra los hombres de la base de datos por la columna de sexo y guárdala en una variable "hombres"
#Si la base la importas desde Github "Male" es sin espacio previo
hombres <- filter(adultos, sex == "Male")

#Selecciona sola las columans de age, education, native-country
#La variable "native-country" es necesario llamarla como valor debido al guión medio
select(adultos,age, education, "native-country")

#Ordena las observaciones por pais de forma ascendente
arrange(adultos,"native-country")

#Ordena las observaciones por edad de forma descedendente
arrange(adultos,desc(age))

#Crea una nueva base que agrupe las observaciones por sexo y pais con una variable 
#"count" que contenga la cantidad que hay por grupo.
Base_ageCountry <- summarise(group_by(adultos, sex, 'native-country'), count = n())

str(Base_ageCountry)
Base_ageCountry
