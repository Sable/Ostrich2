#include<stdio.h>
#include<stdlib.h>
#include "bubble.h"
#include "common.h"
#include "common_rand.h"

int main(int argc, char *argv[])
{
  int size;
  if(argc == 2){    
    size = atoi(argv[1]); 
  }
  else{
    printf("Please provide appropriate arguments\n");
    exit(1);
  } 
 
  int *A = (int*)malloc(size*sizeof(int));
  int i;
  for(i=0; i <size; i++){
    A[i] = abs(common_rand()%50);
  } 
  stopwatch sw;   
  stopwatch_start(&sw);
  bubble(A,size);
  stopwatch_stop(&sw);
  int elapsed_time = get_interval_by_sec(&sw);

  printf("{");
  printf("\"options\":");
  printf("%d",size);
  printf(", \"time\":");
  printf("%f",elapsed_time);
  printf("}");

  free(A);
  return 0;
}
