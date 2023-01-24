#include <stdio.h>
//#include "mult.h"
#include "mult.h"

//float simpleMult(float a, float b) {
//  return a * b;
//}

int main(void) {
  float a = 7;
  float b = 8;
  
  float c = simpleMult(a, b);
  
  printf("%f times %f is %f\n", a, b, c);
  return 0;
}