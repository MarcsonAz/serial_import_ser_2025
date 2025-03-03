# codigo para gerar o banco de dados
# 20250303

install.packages("duckdb")

library(duckdb)

# Conectar ao DuckDB
con <- dbConnect(duckdb::duckdb(), "dados/dados_arduino.duckdb")

# Criar a tabela (se não existir)
#dbExecute(con, "CREATE TABLE IF NOT EXISTS numeros_arduino (numero1 INTEGER, numero2 INTEGER, numero3 INTEGER, numero4 INTEGER, numero5 INTEGER, numero6 INTEGER, numero7 INTEGER, numero8 INTEGER, numero9 INTEGER, numero10 INTEGER, timestamp TIMESTAMP)")

dbExecute(con, "CREATE TABLE IF NOT EXISTS dados_sensores (
    funcionamento_completo INTEGER,
    funcionamento_sensor1 INTEGER,
    valor_sensor1 INTEGER,
    funcionamento_sensor2 INTEGER,
    valor_sensor2 INTEGER,
    timestamp VARCHAR(30)
)")

##dbExecute(con, "DROP TABLE dados_sensores")
##dbGetQuery(con, "SELECT * FROM dados_sensores") %>% as.data.frame()

dbDisconnect(con, shutdown=TRUE)


# 
# while (TRUE) {
#   dados <- read.serialConnection(conexao, n = 200)
#   mensagem <- rawToChar(dados)
#   mensagem <- str_trim(mensagem)
#   if (nchar(mensagem) > 0) {
#     numeros <- as.numeric(unlist(strsplit(mensagem, ",")))
#     timestamp <- Sys.time()
#     # Inserir dados na tabela
#     dbExecute(con, "INSERT INTO numeros_arduino VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", c(numeros, timestamp))
#     print(numeros)
#   }
#   Sys.sleep(0.5)
# }
# 
# # Fechar a conexão
# 
# closeSerialPort(conexao)
# 
# library(serial)
# library(stringr)
# library(duckdb)
# 
# porta <- "COM5"
# baudrate <- 9600
# 
# conexao <- openSerialPort(porta, baudrate = baudrate)
# 
# # Conectar ao DuckDB
# con <- dbConnect(duckdb::duckdb(), "dados_arduino.duckdb")
# 
# # Criar a tabela (se não existir)
# dbExecute(con, "CREATE TABLE IF NOT EXISTS dados_sensores (
#     funcionamento_completo INTEGER,
#     funcionamento_sensor1 INTEGER,
#     valor_sensor1 INTEGER,
#     funcionamento_sensor2 INTEGER,
#     valor_sensor2 INTEGER,
#     timestamp TIMESTAMP,
#     erro_sensor1 VARCHAR,
#     erro_sensor2 VARCHAR
# )")
# 
# while (TRUE) {
#   dados <- read.serialConnection(conexao, n = 200)
#   mensagem <- rawToChar(dados)
#   mensagem <- str_trim(mensagem)
#   if (nchar(mensagem) > 0) {
#     numeros <- as.numeric(unlist(strsplit(mensagem, ",")))
#     timestamp <- Sys.time()
#     
#     funcionamento_completo <- numeros[1]
#     funcionamento_sensor1 <- numeros[2]
#     valor_sensor1 <- numeros[3] * 100 + numeros[4] * 10 + numeros[5]
#     funcionamento_sensor2 <- numeros[6]
#     valor_sensor2 <- numeros[7] * 100 + numeros[8] * 10 + numeros[9]
#     digito_verificador <- numeros[10] # Ignorado
#     
#     erro_sensor1 <- NA
#     erro_sensor2 <- NA
#     
#     if (funcionamento_sensor1 > 7) {
#       erro_sensor1 <- "Erro no Sensor 1"
#     }
#     
#     if (funcionamento_sensor2 > 7) {
#       erro_sensor2 <- "Erro no Sensor 2"
#     }
#     
#     if (funcionamento_completo < 5) {
#       dbExecute(con, "INSERT INTO dados_sensores VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
#                 list(funcionamento_completo, funcionamento_sensor1, valor_sensor1,
#                      funcionamento_sensor2, valor_sensor2, timestamp, erro_sensor1, erro_sensor2))
#       print(paste("Dados inseridos:", mensagem))
#       
#       if(funcionamento_completo >= 2.5){
#         print(paste("Metade dos dados foram registrados"))
#       }
#       
#     } else {
#       print(paste("Dados não registrados:", mensagem))
#     }
#   }
#   Sys.sleep(0.5)
# }
# 
# dbDisconnect(con, shutdown=TRUE)
# closeSerialPort(conexao)