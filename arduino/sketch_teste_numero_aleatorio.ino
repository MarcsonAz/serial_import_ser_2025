void setup() {
  Serial.begin(9600);
  randomSeed(analogRead(0)); // iniciar gerador
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  enviarNumerosAleatorios();
  digitalWrite(LED_BUILTIN, LOW);
  delay(2000); 
}

void enviarNumerosAleatorios() {
  String mensagem = ""; // String para armazenar a sequência de números

  for (int i = 0; i < 10; i++) {
    int numeroAleatorio = random(0, 10); // Gera um número aleatório entre 0 e 99
    mensagem += String(numeroAleatorio); // Adiciona o número à string
  }

  Serial.println(mensagem); // Envia a string pela porta serial
  delay(150);
}