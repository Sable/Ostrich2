#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "common.h"
#include "common_rand.h"

int main(int argc, char* argv[]) {
    stopwatch sw;

    if (argc < 2) {
        printf("usage: %s x\n", argv[0]);
        return 0;
    }

    int n = atoi(argv[1]); 
    double x = 0;
    double y = 0;
    stopwatch_start(&sw);
    for (int i = 0; i < n; ++i) {
       x += common_randJS(); 
    }
    stopwatch_stop(&sw);
    y = common_randJS();
    printf("{ \"time\": %f, \"output\": \"%f,%f\" }\n", get_interval_by_sec(&sw), x, y);
}
