library(serial)


listPorts()

porta <- "COM5"
baudrate <- "9600"

conexao <- serial::serialConnection(port=porta,mode = paste0(baudrate,",n,8,1"))

open(conexao)
  
library(DBI)

# Conectando a um banco SQLite (arquivo local)
con <- dbConnect(RSQLite::SQLite(), "meubanco.sqlite")
dbExecute(con, "PRAGMA journal_mode = WAL;")

while(TRUE) {
  leitura_raw <- serial::read.serialConnection(conexao)
  timestamp <- as.integer(Sys.time())  # Timestamp atual em segundos
  leitura <- strsplit(leitura_raw, ",")[[1]]
  
  print(leitura)
  
  # Inserir cada leitura no banco com o mesmo timestamp
  
  dbExecute(con, "BEGIN TRANSACTION")
  
if(length(leitura)>0){
  for (valor in leitura) {
    valor_int <- as.integer(valor)

    if (!is.na(valor_int)) {
      dbExecute(con, paste0(
        "INSERT INTO sensor_log (tempo, leitura) VALUES (",
        timestamp, ", ", valor_int, ")"
      ))
      
    }
  }
  
  dbExecute(con, "COMMIT")
}
  Sys.sleep(10)  # Aguarda 10 segundos entre as leituras
}


close(conexao)