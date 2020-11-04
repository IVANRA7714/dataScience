#CARGAR LIBRERIAS PARA CONEXIONES
library(DBI)
library(RMySQL)

#CREAR UNA CONEXION
con <- dbConnect(
  RMySQL::MySQL(),
  dbname = "tweater",
  host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
  port = 3306,
  user = "student",
  password = "datacamp"
)

tables <- dbListTables(con)

users <- dbReadTable(con,"users")
users_aux <- dbReadTable(con,tables[3])

all_tables <- lapply(tables, dbReadTable, conn = con)
comments <- all_tables[[1]]
#___________________________________________________________

#POSTGRESQL

library(RPostgreSQL)

conps <- dbConnect(
  RPostgreSQL::PostgreSQL(),
  dbname = "pfmegrnargs",
  host = "hh-pgsql-public.ebi.ac.uk",
  port = 5432,
  user = "reader",
  password = "NWDMCE5xdipIjRrp"
)

dbExistsTable(conps,"rnc_rna_precomputed")

#df_postgres <- dbGetQuery(
                          
df_mysql <- dbGetQuery(con,"Select
                       user_id, message
                       FROM comments
                       WHERE tweat_id=77")
View(df_mysql)

