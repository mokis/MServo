
int counter = 0;

void setup() {
  Serial.begin(9600);
  pinMode(2, OUTPUT);  
}

void loop() {
  digitalWrite(2, HIGH);   
  delay(10);               
  digitalWrite(2, LOW);    
  delay(10);               

  if (Serial.available()) {
    Serial.println(Serial.read());
    counter = 0;
  } else {
    counter++;
  }
  
  if (counter > 3) {
    Serial.print(analogRead(A0), DEC);
    Serial.print(", ");
    Serial.print(analogRead(A1), DEC);
    Serial.print(", ");
    Serial.print(analogRead(A2), DEC);
    Serial.print(", ");
    Serial.println(analogRead(A3), DEC);
    counter = 0;
  }
  
}
