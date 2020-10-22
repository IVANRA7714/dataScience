cinco <- 5
seis = 6
doce = 6+6
doce
.var_name <- 7

my.sumary <- function (x) {
  suma <- sum(x)
  total <- length(x)
  promedio <- suma/total
  return(promedio)
}

s <-1:10
my.sumary(s)
v <-my.sumary(s)

var1 <- 3
var2 <- 6

if(var1==var2) {
  print("Son iguales")
} else if(var1<var2) {
  print("var1 es menor que var2")
} else {
  print("Ninguna de las anteriores")
}

caso<- "T1"

switch(caso,
       T1={ X <- "Entró en el caso T1"},
       T2={ X <- "Entró en el caso T2"},
       T3={ X <- "Entró en el caso T3"},
       stop("No pasó nada")
       )

v<-LETTERS[1:4]
for(i in v) {
  print(i)
}

mensaje <- "dentro del while loop"
contador <- 1

while(contador < 10) {
  print(mensaje)
  contador = contador+1
  
  if (contador >5) {
    break
  }
}

