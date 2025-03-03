#banco_ingestao
#20250303

banco_ingestao <- function(leitura){
  
  leitura_tratada <- preparo_dados_sensores(leitura = leitura)
  # retornar uma lista com informações para inserir no banco
  if (!is.null(leitura_tratada)) {
    
    # conectar
    con <- dbConnect(duckdb::duckdb(), "dados/dados_arduino.duckdb")
    
    
    ts <- Sys.time()
    leitura_final <- append(leitura_tratada,ts)
   
    # Inserir dados na tabela
    dbExecute(con, "INSERT INTO dados_sensores VALUES (?, ?, ?, ?, ?, ?)", 
              params =  leitura_final)
    
  }else{
        cat("Dados inválidos, não inseridos no banco!\n")
      }
  Sys.sleep(0.5)
}
  
  
