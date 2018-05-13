float a = 10.0;
float guess = 1.0;
const float tolerance = 1E-2;
float xL = 
float xU = 5.0;
float xR; 


void setup() {
  Serial.begin(9600);
  while(!isApproxEqual(f(guess),0.0)){
    guess = (guess + a/guess)/2;
  }
  Serial.println("The square root of \(a) is \(guess)");
}

float f(float x) {
  return x*x-a;
}

bool isApproxEqual (float a, float b){
  return abs(a-b)<tolerance;
}

