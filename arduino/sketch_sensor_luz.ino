// leitura do sensor de luminosidade e acendimento de LED

void setup() {
  Serial.begin(9600);
  pinMode(8, OUTPUT);
}

void loop() {
  int ldrValue = analogRead(A0);
  Serial.println(ldrValue);

  if (ldrValue > 600) {
    digitalWrite(8, HIGH);
  } else {
    digitalWrite(8, LOW);
  }

  delay(1000);
}