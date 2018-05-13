// Purpose: Exercise 16-bit Timer1 counter in Normal Mode
// See: ATmega328P Datasheet, Section 15.11
// Consult AVR Timer Calculator:
// https://www.easycalculation.com/engineering/electrical/avr-timer-calculator.php

// prescale constants
uint8_t clkDiv1 = 1 << CS10;
uint8_t clkDiv8 = 1 << CS11;
uint8_t clkDiv64 = 1 << CS11 | 1 << CS10;
uint8_t clkDiv256 = 1 << CS12;
uint8_t clkDiv1024 = 1 << CS12 | 1 << CS10;
uint8_t ovfCount;

// Timer 1 Interrupt Service Routine
ISR(TIMER1_OVF_vect) {
//  ovfCount++;
//  if (!ovfCount)
  PORTB ^= (1 << PB5);
}

int main() {
  DDRB |= (1 << PB5);
  Serial.begin(9600);
  ovfCount = 0;
  cli();
  // Normal Mode
  TCCR1A = 0;
  // set up timer with (no) prescaler
  TCCR1B = clkDiv8;
  // initialize counter
  TCNT1 = 0;
  // Enable Timer1 interrupt ability
  TIMSK1 = 1 << TOIE1;
  // Enable global interrupt ability...
  sei();
  // stand down and let ISR respond to interrupts
  while (1);
}
