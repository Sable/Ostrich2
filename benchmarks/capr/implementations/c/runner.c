
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

 void seidel(double** f, double** mask, int n, int m, int na, int mb){
    for(int ii=1;ii<n;ii++){
        for(int jj=1;jj<m;jj++){
            f[ii][jj] += mask[ii][jj]*(0.25*(f[ii-1][jj]+f[ii+1][jj]+f[ii][jj-1]+f[ii][jj+1])-f[ii][jj]);
        }
    }
    int ii = 0; //Symmetry on left boundary ii-1 -> ii+1.
    for(int jj=1;jj<m;jj++){
        f[ii][jj]+=mask[ii][jj]* (0.25*(f[ii+1][jj]+f[ii+1][jj]+f[ii][jj-1]+f[ii][jj+1])-f[ii][jj]);
    }
    int jj = 0; //Symmetry on lower boundary jj-1 -> jj+1.
    for(int ii=1;ii<n;ii++){
        f[ii][jj]+=mask[ii][jj]*(0.25*(f[ii-1][jj]+f[ii+1][jj]+f[ii][jj+1]+f[ii][jj+1])-f[ii][jj]);
    }
 }

 double gauss(int n, int m, double h, double** f){
    double q = 0;
    for(int ii=0;ii<n;ii++){
        q += (f[ii][m-1]+f[ii+1][m-1])*0.5;
    }

    for(int jj=0;jj<m;jj++){
        q += (f[n-1][jj]+f[n-1][jj+1])*0.5;
    }

    double cap = q * 4 ; // Four quadrants.
    return (cap * 8.854187);
 }


 double capacitor(double a, double b, double c, double d, int n, double tol, double rel){
    double h=0.5*c/n; // Grid size.

    int na=round(0.5*a/h);
    // double x=linspace(0, 0.5*c, n+1);
    int m=round(0.5*d/h);
    int mb=round(0.5*b/h);
    // double y=linspace(0, 0.5*d, m+1);

    // Initialize potential and mask array.
    double** f = createMatrix(n+1, m+1, 0);
    double** mask = createMatrix(n+1, m+1, rel);

    for(int ii=0;ii<=na;ii++){
        for(int jj=0;jj<=mb;jj++){
            mask[ii][jj] = 0;
            f[ii][jj] = 1;
        }
    }
    double oldcap = 0, cap = 0;
    for(int iter=0;iter < 1000; iter++){
        seidel(f, mask, n, m, na, mb); 
        cap = gauss(n, m, h, f);
        if(fabs(cap-oldcap)/cap < tol)
            break;
        else
            oldcap = cap;
    }
    freeMatrix(f);
    freeMatrix(mask);
    return cap;
 }

 void initInput(int scale){
    double a=(0.3257463)*2; // the numbers in parentheses are "rand's" made deterministic
    double b=8.65*(0.04039);
    double c=3.29*(0.55982);
    double d=(0.727561)*6.171;

    int n=floor(56.0980*(0.36));
    double tol=1.3e-13; // Tolerance.
    double rel=0.90;    // Relaxation parameter.

    clock_t time0 = clock();
    for(int ii=0,i2=scale*10;ii<i2;ii++){
      double cap=capacitor(a, b, c, d, n, tol, rel);
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
