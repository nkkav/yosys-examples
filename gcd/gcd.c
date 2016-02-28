#ifdef PROFILE
#include <stdio.h>
#endif

int gcd(int a, int b)
{
  int result;
  int x, y;
	
  x = a;
  y = b;
  if (x!=0 && y!=0) {
    while (x != y) {
      if (x >= y) {
        x = x - y;
      } else {
        y = y - x;
      }
    }
    result = x;
  } else {
    result = 0;
  }
  return (result);			
}

#ifdef PROFILE
int main ()
{
  int A, B, Y, Y_Ref, Passed;
  FILE *file_pointer;

  file_pointer = fopen("gcd_test_data.txt", "r");
  Passed = 1;

  while (!feof(file_pointer))
  {
    /* Read test data from file */
    fscanf (file_pointer, "%d %d %d\n", &A, &B, &Y_Ref);

    /* Model GCD algorithm */
    Y = gcd(A, B);

    /* Test GCD algorithm */
    if (Y != Y_Ref)
    {
      printf ("Error. A=%d B=%d Y=%d Y_Ref=%d\n", A,B,Y,Y_Ref);
      Passed = 0;
    }
  }

  if (Passed == 1) {
    printf ("GCD algorithm test passed ok\n");
  }
}
#endif
