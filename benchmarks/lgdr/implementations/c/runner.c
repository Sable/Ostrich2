/*
 Copyright
*/

 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
 #include <math.h>

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

 void freeMatrix(double** arr){
    free(arr[0]);
    free(arr);
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

 double** PN_Legendre_vectN(double *x, int lenx, int n){
    double** PNa = createMatrix(lenx, n+1, 0);
    for(int i=0;i<lenx;i++)
        PNa[i][0] = 1;
    if(n > 0){
        for(int i=0;i<lenx;i++)
            PNa[i][1] = x[i];
    }

    if(n > 1){
        for(int j=0;j<n-1;j++){
            for(int k=0;k<lenx;k++){
                PNa[k][j+2] = (1.0/(j+2))*((2*j+3)*x[k]*PNa[k][j+1]-(j+1)*PNa[k][j]);
            }
        }
    }

    for(int j=0;j<=n;j++){
        for(int k=0;k<lenx;k++){
            PNa[k][j] = PNa[k][j] * sqrt(j+1-1.0/2);
        }
    }
    return PNa;
 }

 double** PNx_Legendre_vectN(double *x, int lenx, int n){
    double** PNxa = createMatrix(lenx, n+1, 0);
    for(int i=0;i<lenx;i++)
        PNxa[i][0] = 0;
    if(n > 0){
        for(int i=0;i<lenx;i++)
            PNxa[i][1] = 1;
    }

    if(n > 1){
        for(int k=0;k<lenx;k++){
            PNxa[k][2] = 3 * x[k];
        }
    }

    if(n > 2){
        for(int j=0;j<n-2;j++){
            for(int k=0;k<lenx;k++){
                PNxa[k][j+3] = (1.0/(j+2))*(2*(j+1+3.0/2)*x[k]*PNxa[k][j+2]-(j+1+2)*PNxa[k][j+1]);
            }
        }
    }

    for(int j=0;j<=n;j++){
        for(int k=0;k<lenx;k++){
            PNxa[k][j] *= sqrt(j+1-1.0/2);
        }
    }
    return PNxa;
 }

 double** PNxx_Legendre_vectN(double *x, int lenx, int n){
    double** PNxxa = createMatrix(lenx, n+1, 0);
    for(int i=0;i<lenx;i++)
        PNxxa[i][0] = 0;
    if(n > 0){
        for(int i=0;i<lenx;i++)
            PNxxa[i][1] = 0;
    }

    if(n > 1){
        for(int k=0;k<lenx;k++){
            PNxxa[k][2] = 3;
        }
    }

    if(n > 2){
        for(int k=0;k<lenx;k++){
            PNxxa[k][3] = 15 * x[k];
        }
    }

    if(n > 3){
        for(int j=0;j<n-3;j++){
            for(int k=0;k<lenx;k++){
                PNxxa[k][j+4] = (1.0/(j+2))*(2*(j+1+5.0/2)*x[k]*PNxxa[k][j+3]-(j+5)*PNxxa[k][j+2]);
            }
        }
    }

    for(int j=0;j<=n;j++){
        for(int k=0;k<lenx;k++){
            PNxxa[k][j] *= sqrt(j+1-1.0/2);
        }
    }
    return PNxxa;
 }

  void initInput(int scale){
    double x[] = {0,0.3,0.9,0.7,0.5};
    int lenx = 5;
    int n = 5;

    clock_t time0 = clock();
    for(int ii=0;ii<scale;ii++){
        double** PNa  = PN_Legendre_vectN(x, lenx, n);
        double** PNxa = PNx_Legendre_vectN(x, lenx, n);
        double** PNxxa= PNxx_Legendre_vectN(x, lenx, n);
        freeMatrix(PNa);
        freeMatrix(PNxa);
        freeMatrix(PNxxa);
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