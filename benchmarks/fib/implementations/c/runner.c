#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <string.h>

typedef struct __stopwatch_t{
    struct timeval begin;
    struct timeval end;
}stopwatch;

void stopwatch_start(stopwatch *sw){
    if (sw == NULL)
        return;

    memset(&sw->begin, 0, sizeof(struct timeval));
    memset(&sw->end  , 0, sizeof(struct timeval));

    gettimeofday(&sw->begin, NULL);
}

void stopwatch_stop(stopwatch *sw){
    if (sw == NULL)
        return;

    gettimeofday(&sw->end, NULL);
}

double
get_interval_by_sec(stopwatch *sw){
    if (sw == NULL)
        return 0;
    return ((double)(sw->end.tv_sec-sw->begin.tv_sec)+(double)(sw->end.tv_usec-sw->begin.tv_usec)/1000000);
}

extern int fib(int x);

int main(int argc, char* argv[]) {
    stopwatch sw;

    if (argc < 2) {
        printf("usage: %s x\n", argv[0]);
        return 0;
    }

    int n = atoi(argv[1]); 
    stopwatch_start(&sw);
    int x = fib(n);
    stopwatch_stop(&sw);
    printf("{ \"time\": %f, \"output\": %d }\n", get_interval_by_sec(&sw), x);
}
