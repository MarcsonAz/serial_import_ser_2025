# arquivo inicial de testes
# 
# 


### COM O ARDUINO CONECTADO E RODANDO O CÓDIGO: 
### serial_import_ser_2025\arduino\sketch_teste_numero_aleatorio.ino


pacman::p_load(char = c("dplyr","serial","purrr","DBI","duckdb","lubridate"))

# CHAMAR FUNCOES
funcoes <- fs::dir_ls('./codigos/funcoes/')
for(fun in funcoes){
  source(fun)
}





# portas
listPorts()

porta <- "COM5"
baudrate <- "9600"

con_serial <- serial::serialConnection(port=porta,mode = paste0(baudrate,",n,8,1"))

open(con_serial)
isOpen(con_serial)

i = 1
dados <- list()

while (i<1000) { # Loop para ler continuamente - 
  leitura <- read.serialConnection(con_serial)
  print(leitura)
  dados <- append(dados,leitura)
  banco_ingestao(leitura) # chama as funcoes para inserir dados no banco
  Sys.sleep(1.5)
  i = i + 1
}

close(con_serial) # fechar conexao serial

 





### ler dados brutos inseridos no banco ###########################################################
 
con <- dbConnect(duckdb::duckdb(), "dados/dados_arduino.duckdb")


df = dbGetQuery(con,"SELECT * FROM dados_sensores2")


## TESTES
## 

library(DBI)
library(duckdb)
library(lubridate)

# Conectar ao DuckDB
con <- dbConnect(duckdb::duckdb(), ":memory:")

# Criar uma tabela de exemplo
dbExecute(con, "CREATE TABLE minha_tabela (valor INTEGER, timestamp TIMESTAMP)")

# Dados para inserir
dados <- data.frame(valor = 1:5, timestamp = Sys.time())

# Inserir os dados na tabela
dbAppendTable(con, "minha_tabela", dados)

# Coletar os dados da tabela
dados_coletados <- dbReadTable(con, "minha_tabela")

# Extrair informações do timestamp
dados_coletados$ano <- year(dados_coletados$timestamp)
dados_coletados$mes <- month(dados_coletados$timestamp)
dados_coletados$dia <- day(dados_coletados$timestamp)
dados_coletados$hora <- hour(dados_coletados$timestamp)
dados_coletados$minuto <- minute(dados_coletados$timestamp)
dados_coletados$segundo <- second(dados_coletados$timestamp)

# Visualizar os dados coletados
print(dados_coletados)

# Desconectar do DuckDB
dbDisconnect(con, shutdown = TRUE)


DBI::dbListTables(conn = con)
 
dados_coletados <- dbReadTable(con, "numeros_arduino")

dbExecute(con, "DROP TABLE numeros_arduino")



(dia = lubridate::day(df$timestamp))










