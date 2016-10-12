#include <stdio.h>
#include <stdlib.h>

void usage(char* progname) {
  printf("%s %s %s %s\n", progname, "multiplier1", "multiplier2", "max-number");
}

int calculateSum(int multiplier1, int multiplier2, int maxNum) {
  int sum = 0;
  for (int i = 1; i < maxNum; i++) {
    if ((i % multiplier1 == 0) || (i % multiplier2 == 0)) {
      sum += i;
    }
  }
  return sum;
}

int main(int argc, char** argv) {
  int status = 0;
  int multiplier1 = 0;
  int multiplier2 = 0;
  int maxNum = 0;

  if (argc == 4) {
    multiplier1 = atoi(argv[1]);
    multiplier2 = atoi(argv[2]);
    maxNum = atoi(argv[3]);

    if (multiplier1 > 0 && multiplier2 > 0 && maxNum > 0) {
      printf("%i\n", calculateSum(multiplier1, multiplier2, maxNum));
    } else {
      status = 2;
      fprintf(stderr, "%s\n", "ERROR: all parameters have to be positive numbers");
    }

  } else {
    status = 1;
    fprintf(stderr, "%s\n", "ERROR: to much or less parameters");
  }

  if (status != 0) {
    usage(argv[0]);
  }


  return status;
}
