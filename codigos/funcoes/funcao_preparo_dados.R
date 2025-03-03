# funcao prepara dados coletados na leitura
# 20250303


preparo_dados_sensores <- function(leitura){
  msg = "inicial"
  
  msg <- stringr::str_trim(leitura)
  if (nchar(msg) > 0) {
    #numeros <- as.numeric(unlist(strsplit(msg, ",")))
    

    funcionamento_completo <- as.numeric(substr(msg,1,1))
    
    funcionamento_sensor1  <- as.numeric(substr(msg,2,2))
    valor_sensor1          <- as.numeric(substr(msg,3,5))
    
    funcionamento_sensor2  <- as.numeric(substr(msg,6,6))
    valor_sensor2          <- as.numeric(substr(msg,7,9))
    
    digito_verificador     <- as.numeric(substr(msg,10,10))
    
    if (funcionamento_completo > 4) {
      cat("Erro - sem dados inseridos no banco.\n")
      return(NULL)
    }else{
      funcionamento_completo <- 1
    
      if (funcionamento_sensor1 > 7) {
        funcionamento_sensor1 <- 0
        valor_sensor1 <- 0
      }else{
        funcionamento_sensor1 <- 1
      }
      if (funcionamento_sensor2 > 7) {
        funcionamento_sensor2 <- 0
        valor_sensor2 <- 0
      }else{
        funcionamento_sensor2 <- 1
      }
        cat('Funcionamento OK! Dados preparados!\n')
        
    }
  }else{
    cat("Erro - sem dados inseridos no banco.\n")
    return(NULL)
  }
  
  return(
    list(
      funcionamento_completo,
      funcionamento_sensor1,
      valor_sensor1,
      funcionamento_sensor2,
      valor_sensor2
    )
  )

}



