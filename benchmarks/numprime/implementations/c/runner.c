#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <string.h>

#include "numprime.h"

struct stopwatch{
	struct timeval begin;
	struct timeval end;
};

void stopwatch_start(struct stopwatch *sw){
	if (sw == NULL)
		return;

	memset(&sw->begin, 0, sizeof(struct timeval));
	memset(&sw->end  , 0, sizeof(struct timeval));

	gettimeofday(&sw->begin, NULL);
}

void stopwatch_stop(struct stopwatch *sw){
	if (sw == NULL)
		return;
	gettimeofday(&sw->end, NULL);
}

double
get_interval_by_sec(struct stopwatch *sw){
	if (sw == NULL)
		return 0;
	return ((double)(sw->end.tv_sec-sw->begin.tv_sec)+(double)(sw->end.tv_usec-sw->begin.tv_usec)/1000000);
}


int main(int argc, char **argv) {
	struct stopwatch sw;

	if (argc < 2) {
		printf("usage: %s <input size>\n", argv[0]);
		return 1;
	}

	int n = atoi(argv[1]);
	stopwatch_start(&sw);
	int x = numprime(n);
	stopwatch_stop(&sw);
	printf("{ \"time\": %f, \"result\": %d }\n", get_interval_by_sec(&sw), x);

	return 0;
}
