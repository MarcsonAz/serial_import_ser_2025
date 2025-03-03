# arquivo inicial de testes
# 
# 


### COM O ARDUINO CONECTADO E RODANDO O CÓDIGO: 
### serial_import_ser_2025\arduino\sketch_teste_numero_aleatorio.ino


pacman::p_load(char = c("dplyr","serial","purrr"))

# CHAMAR FUNCOES
funcoes <- fs::dir_ls('./codigos/funcoes/')
for(fun in funcoes){
  source(fun)
}





# portas
listPorts()

porta <- "COM5"
baudrate <- "9600"

conexao <- serial::serialConnection(port=porta,mode = paste0(baudrate,",n,8,1"))

open(conexao)
isOpen(conexao)

i = 1
dados <- list()

while (i<1000) { # Loop para ler continuamente - 
  leitura <- read.serialConnection(conexao)
  print(leitura)
  dados <- append(dados,leitura)
  banco_ingestao(leitura) # chama as funcoes para inserir dados no banco
  Sys.sleep(1.5)
  i = i + 1
}

close(conexao) # Lembre de fechar a conexão quando terminar

 


# meu que funcionou
# while (i<10) { # Loop infinito para ler continuamente
# 
# 
# Sys.sleep(1)
# i = i + 1
# }
# 
# 

