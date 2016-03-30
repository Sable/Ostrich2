void bubble(int *A, int n)
{
  int temp;
  int i,j;
  for(i=0; i<n-1; i++){
    for(j=0; j<n-1; j++){
      if(A[j] > A[j+1]){
        temp = A[j];
        A[j] = A[j+1];
        A[j+1] = temp;
      }
    }
  }
}
