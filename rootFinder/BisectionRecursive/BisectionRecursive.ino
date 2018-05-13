float a = 10.0;
float guess = 1.0;
const float tolerance = 1E-2;
float xR;

void setup() {

  guess = bisectionNR(guess, a / guess);
}
float bisectionNR(float xL, float xU) {
  float root = (xL + xU) / 2;
  while (!isApproxEqual(f(root), 0.0)) {
    if (f(xL)*f(root) < 0) {
      return bisectionR(xL, root);
  }
}

float f(float x) {
  return x * x - a;
}

bool isApproxEqual (float a, float b) {
  return abs(a - b) < tolerance;
}

void loop (){
}

