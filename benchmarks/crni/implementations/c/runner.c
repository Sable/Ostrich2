/*
 Copyright
*/

 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
 #include <math.h>

 #define C_PI 3.14159265358979323846

  double **createMatrix(int m, int n, double value){
    double** arr = (double**)malloc(m * sizeof(double*));
    arr[0] = (double*)malloc(m*n*sizeof(double));
    for(int i=1;i<m;i++){
        arr[i] = arr[i-1] + n;
    }
    for(int i=0,i2=m*n;i<i2;i++)
        arr[0][i] = value;
    return arr;
 }

 double *createVector(int m, double value){
    double *vector = (double*)malloc(m * sizeof(double));
    for(int i=0;i<m;i++)
        vector[i] = value;
    return vector;
 }

 void freeMatrix(double** arr){
    free(arr[0]);
    free(arr);
 }

 double* copyVector(double* vector, int n){
    double *rtn = createVector(n,0);
    for(int i=0;i<n;i++){
        rtn[i] = vector[i];
    }
    return rtn;
 }

 void printMatrix(double** arr, int m, int n){
    printf("Matrix output:\n");
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            printf("%g ", arr[i][j]);
        }
        printf("\n");
    }
 }

 void printVector(double* v, int n){
    printf("Vector output:\n");
    for(int i=0;i<n;i++){
        printf("%g ", v[i]);
    }
    printf("\n");
 }

 double* tridiagonal(double* A, double* pD, double* C, double* pB, int n){
    double* B = copyVector(pB,n);
    double* D = copyVector(pD,n);
    for(int k=1;k<n;k++){
        double mult = A[k-1] / D[k-1];
        D[k] = D[k] - mult * C[k-1];
        B[k] = B[k] - mult * B[k-1];
    }

    double *X = createVector(n,0);
    X[n-1] = B[n-1] / D[n-1];
    for(int k=n-2;k>=0;k--){
        X[k] = (B[k]-C[k]*X[k+1])/D[k];
    }
    free(B);
    free(D);
    return X;
 }

 double** crnich(double a, double b, int c, int n, int m){
    double h=a/(n-1);
    double k=b/(m-1);
    double r=c*c*k/(h*h);
    double s1=2+2.0/r;
    double s2=2.0/r-2;
    double** U = createMatrix(n, m, 0);

    for(int i1=1;i1<n-1;i1++){
        U[i1][0] = sin(C_PI*h*i1) + sin(3*C_PI*h*i1);
    }

    double* Vd = createVector(n, s1);
    Vd[0]   = 1;
    Vd[n-1] = 1;
    double* Va = createVector(n-1, -1);
    Va[n-2] = 0;
    double* Vc = createVector(n-1, -1);
    Vc[0]   = 0;
    double* Vb = createVector(n, 0);
    Vb[0]   = 0;
    Vb[n-1] = 0;

    for(int j1=1;j1<m;j1++){
        for(int i1=1;i1<n-1;i1++){
            Vb[i1] = U[i1-1][j1-1] + U[i1+1][j1-1] + s2 * U[i1][j1-1];
        }
        double* X=tridiagonal(Va, Vd, Vc, Vb, n);
        for(int k=0;k<n;k++){
            U[k][j1] = X[k];
        }
        free(X);
    }
    free(Va);
    free(Vb);
    free(Vc);
    free(Vd);
    return U;
 }

 void initInput(int scale){
    double a=2.5;  // a=rand*3;
    double b=1.5;  // b=1.5;
    int c=5;       // c=2;
    int m=2300;    // 321; % n=floor(rand*1389);
    int n=2300;    // 321; % n=floor(rand*529);

    clock_t time0 = clock();
    for(int ii=0;ii<scale;ii++){
      double** U=crnich(a, b, c, n, m);
      freeMatrix(U);
    }
    double elapsed = (clock() - time0)/1000000.0;

    printf("{ \"time\": %f }\n", elapsed);
 }

 int main(int argc, char* argv[]){
    if(argc!=2) {
        fprintf(stderr, "usage: runner <scale>\n");
        exit(99);
    }
    int scale = atoi(argv[1]);
    initInput(scale);
    return 0;
 }
