#include <math.h>

#include "numprime.h"

int numprime(int n) {
	int total = 0;
	for (int i = 2; i <= n; ++i) {
		int is_prime = 1;
		for (int j = 2; j <= sqrt(i); ++j) {
			if (i % j == 0) {
				is_prime = 0;
				break;
			}
		}
		total += is_prime;
	}
	return total;
}
