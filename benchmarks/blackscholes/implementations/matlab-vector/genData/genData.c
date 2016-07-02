// Copyright (c) 2007 Intel Corp.

// Black-Scholes
// Analytical method for calculating European Options
//
// 
// Reference Source: Options, Futures, and Other Derivatives, 3rd Edition, Prentice 
// Hall, John C. Hull,

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>


// input data generator
//Precision to use
#define fptype2 double

typedef struct OptionData2_ {
        fptype2 s;          // spot price
        fptype2 strike;     // strike price
        fptype2 r;          // risk-free interest rate
        fptype2 divq;       // dividend rate
        fptype2 v;          // volatility
        fptype2 t;          // time to maturity or option expiration in years 
                           //     (1yr = 1.0, 6mos = 0.5, 3mos = 0.25, ..., etc)  
        const char *OptionType;  // Option type.  "P"=PUT, "C"=CALL
        fptype2 divs;       // dividend vals (not used in this test)
        fptype2 DGrefval;   // DerivaGem Reference Value
} OptionData2;

//Total number of options in optionData.txt
#define MAX_OPTIONS 1000

OptionData2 data_init[] = {
    #include "optionData.txt"
};

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

int main (int argc, char **argv)
{
    int i;

#ifdef PARSEC_VERSION
#define __PARSEC_STRING(x) #x
#define __PARSEC_XSTRING(x) __PARSEC_STRING(x)
        printf("PARSEC Benchmark Suite Version "__PARSEC_XSTRING(PARSEC_VERSION)"\n");
	fflush(NULL);
#else
        printf("PARSEC Benchmark Suite\n");
	fflush(NULL);
#endif //PARSEC_VERSION
#ifdef ENABLE_PARSEC_HOOKS
   __parsec_bench_begin(__parsec_blackscholes);
#endif

   if (argc != 4)
    {
            //printf("Usage:\n\t%s <nthreads> <inputFile> <outputFile>\n", argv[0]);
        printf("Usage:\n\t%s <nthreads> <numOptions> <outputFile>\n", argv[0]);
        exit(1);
    }
    int nThreads   = atoi(argv[1]);
    int numOptions = atoi(argv[2]);
    //char *inputFile = argv[2];
    char *outputFile = argv[3];

    //Read input data from file
    //file = fopen(inputFile, "r");
    // if(file == NULL) {
    //   printf("ERROR: Unable to open file `%s'.\n", inputFile);
    //   exit(1);
    // }
    // rv = fscanf(file, "%i", &numOptions);
    // if(rv != 1) {
    //   printf("ERROR: Unable to read from file `%s'.\n", inputFile);
    //   fclose(file);
    //   exit(1);
    // }
    if(nThreads > numOptions) {
      printf("WARNING: Not enough work, reducing number of threads to match number of options.\n");
      nThreads = numOptions;
    }

#if !defined(ENABLE_THREADS) && !defined(ENABLE_OPENMP) && !defined(ENABLE_TBB)
    if(nThreads != 1) {
        printf("Error: <nthreads> must be 1 (serial version)\n");
        exit(1);
    }
#endif


    FILE* fp =fopen("inputData.m","w");
    fprintf(fp, "function [otype,sptprice,strike,rate,volatility,otime,DGrefval] = inputData (numOptions) \n");
    // block 1
    fprintf(fp, "data_init_s = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.2f ", data_init[i].s);
    }
    fprintf(fp, "];\n");
    // block 2
    fprintf(fp, "data_init_strike = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.2f ", data_init[i].strike);
    }
    fprintf(fp, "];\n");
    // block 3
    fprintf(fp, "data_init_r = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.4f ", data_init[i].r);
    }
    fprintf(fp, "];\n");
    // block 4
    fprintf(fp, "data_init_divq = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.2f ", data_init[i].divq);
    }
    fprintf(fp, "];\n");
    // block 5
    fprintf(fp, "data_init_v = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.2f ", data_init[i].v);
    }
    fprintf(fp, "];\n");
    // block 6
    fprintf(fp, "data_init_t = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.2f ", data_init[i].t);
    }
    fprintf(fp, "];\n");
    // block 7
    fprintf(fp, "data_init_optionType = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "'%c' ", data_init[i].OptionType[0]);
    }
    fprintf(fp, "];\n");
    // block 8
    fprintf(fp, "data_init_divs = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.2f ", data_init[i].divs);
    }
    fprintf(fp, "];\n");
    // block 9
    fprintf(fp, "data_init_DGrefval = [ ");
    for(int i=0;i<MAX_OPTIONS;i++){
        fprintf(fp, "%.18f ", data_init[i].DGrefval);
    }
    fprintf(fp, "];\n");
    fprintf(fp, "MAX_OPTIONS = 1000;\n");
    fprintf(fp, "indexVector = mod((1:numOptions)-1, MAX_OPTIONS) + 1;\n");
    fprintf(fp, "otype       = data_init_optionType(indexVector) == 'P';\n");
    fprintf(fp, "sptprice    = data_init_s(indexVector);\n");
    fprintf(fp, "strike      = data_init_strike(indexVector);\n");
    fprintf(fp, "rate        = data_init_r(indexVector);\n");
    fprintf(fp, "volatility  = data_init_v(indexVector);\n");
    fprintf(fp, "otime       = data_init_t(indexVector);\n");
    fprintf(fp, "DGrefval    = data_init_DGrefval(indexVector);\n");
    fprintf(fp, "end");
    fclose(fp);

#ifdef ENABLE_PARSEC_HOOKS
    __parsec_bench_end();
#endif

    return 0;
}

