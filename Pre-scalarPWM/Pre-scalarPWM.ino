  uint8_t pwmPin = 11;
  void setup(){
      pinMode(pwmPin,OUTPUT);
      Serial.begin(9600);
  }
  void loop() {
      for (int i=0; i<255; i++) {
        Serial.print(TCCR2A,BIN);
        Serial.print(TCCR2B,BIN);
        Serial.print("\t\t");
        Serial.println(OCR2A, BIN);
        analogWrite(pwmPin,i);
        Serial.print(TCCR2A,BIN);
        Serial.print(TCCR2B,BIN);
        Serial.print("\t\t");
        Serial.println(OCR2A, BIN);
        delay(30);
     }
  }
