#include <stdio.h>
#include <math.h>

/*
    Bailey–Borwein–Plouffe (BBP) formula for π:

    π = Σ (1 / 16^k) *
        ( 4/(8k+1)
        - 2/(8k+4)
        - 1/(8k+5)
        - 1/(8k+6) )

    This converges fairly quickly and is famous because it can
    compute hexadecimal digits of π directly.
*/

double bbp_pi(int terms) {
    double pi = 0.0;

    for (int k = 0; k < terms; k++) {
        double factor = 1.0 / pow(16.0, k);

        double term =
              4.0 / (8.0 * k + 1.0)
            - 2.0 / (8.0 * k + 4.0)
            - 1.0 / (8.0 * k + 5.0)
            - 1.0 / (8.0 * k + 6.0);

        pi += factor * term;
    }

    return pi;
}

int main() {
    int terms = 40;

    double pi = bbp_pi(terms);

    printf("Approximation of pi with %d terms:\n", terms);
    printf("%.30f\n", pi);

    return 0;
}
