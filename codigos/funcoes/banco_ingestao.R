#banco_ingestao
#20250303 - v1
#20250316 - v2
# https://duckdb.org/docs/stable/guides/overview.html

banco_ingestao <- function(leitura){
  
  leitura_tratada <- preparo_dados_sensores(leitura = leitura)
  # retornar uma lista com informações para inserir no banco
  if (!is.null(leitura_tratada)) {
    
    # conectar
    con_banco <- dbConnect(duckdb::duckdb(), "dados/dados_arduino.duckdb")
    
    ts <- lubridate::now()
    leitura_final <- cbind(leitura_tratada,data.frame(timestamp = ts ))
   
    # Inserir dados na tabela
    a = dbAppendTable(con_banco,"dados_sensores2",leitura_final)
    
    
    insercao_status <- tryCatch({
      dbAppendTable(con_banco,"dados_sensores2",leitura_final)
      1 
    }, error = function(e) {
      print(paste("Erro na inserção:", e$message))
      0  
    })
    
    # Exibir o status da inserção
    if (insercao_status == 1) {
      print("Inserção realizada com sucesso.\n")
    } else {
      print("Falha na inserção.")
    }
    
    
    Sys.sleep(0.5)
    dbDisconnect(con_banco, shutdown=TRUE) # fechar consexao com o banco de dados
    
  }else{
        cat("Dados inválidos, não inseridos no banco!\n")
        Sys.sleep(0.5)
  }
}
  
  
