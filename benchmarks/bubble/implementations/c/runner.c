#include<stdio.h>
#include<stdlib.h>
#include "bubble.h"
#include "common.h"
#include "common_rand.h"

int main(int argc, char *argv[])
{
  int size;
  int divisor;
  if(argc == 3){    
    size = atoi(argv[1]); 
    divisor = atoi(argv[2]);
  }
  else{
    printf("Please provide appropriate arguments\n");
    exit(1);
  } 
 
  int *A = (int*)malloc(size*sizeof(int));
  int i;
  for(i=0; i <size; i++){
    A[i] = abs(common_rand()%divisor);
  } 
  stopwatch sw;   
  stopwatch_start(&sw);
  bubble(A,size);
  stopwatch_stop(&sw);
  double elapsed_time = get_interval_by_sec(&sw);

  printf("{\"options\":%d, \"time\":%f}\n",size, elapsed_time);

  free(A);
  return 0;
}
