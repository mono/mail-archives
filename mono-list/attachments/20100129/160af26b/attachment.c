#include <stdio.h>
#include <string.h>

double test1 (double *vec, int length)
{
	double sum = 0;
	int i, j;
	for (i = 8; i < length; i++) {
		vec [i] = 2 * vec [i] - vec [i-1];
		for (j = 1; j < 8; j++)
			sum += 1.3 * vec [j - 1];
	}
	return sum;
}

int main (int argc, char **argv)
{
	const int iterations = 1000;
	const int length = 100000;
	double *vec = malloc (length * sizeof (double));
	int i;

	for (i = 0; i < length; i++) {
		vec [i] = i;
	}
	
	double sum = 0;
	for (i = 0; i < iterations; i++)
		sum += test1 (vec, length);

	printf ("result: %f\n", sum);	
}