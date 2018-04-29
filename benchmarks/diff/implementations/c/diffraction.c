/*
* McGill Sable Lab
* 
* Author: Hanfeng Chen
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>

#define c_mean(a,b) (((a)+(b))/2)
#define pi 3.14159265358979323846

struct c_mag{
    double data[2];
    struct c_mag *next_mag;
};

// functions

struct c_mag *alloc_mag(){
    struct c_mag *m = (struct c_mag*)(malloc(sizeof(struct c_mag)));
    m->next_mag = NULL;
    return m;
}

void release_mag(struct c_mag *m){
    while(m){
        struct c_mag *temp = m->next_mag;
        free(m);
        m = temp;
    }
}

void print_mag(struct c_mag *m){
    struct c_mag *t = (m==NULL?NULL:m->next_mag);
    int cnt = 0;
    while(t){
        printf("%lf %lf\n", t->data[0], t->data[1]);
        cnt ++;
        t = t->next_mag;
    }
    printf("total with %d items\n", cnt);
}

int diffraction(int cells, double slitsize1, double slitsize2, int t1, int t2, struct c_mag *m){
    double distance   = 5;                    // Distance from slit to screen in meters.
    double wavelength = 633e-9;               // Wavelength of light in meters
                                       // (633 nm is HeNe laser line).
    double k          = 2 * pi / wavelength;  // Wavenumber.
    double cellsize   = slitsize1 + slitsize2;

    // The following constants are calculated from the inputs assuming that
    // SLITX >> WAVELENGTH.

    // Resolution of position of sources at slit.
    double slitres = wavelength / 100;

    // Resolution of pattern at screen.
    double screenres = distance / (cells * 10) * wavelength / c_mean(slitsize1, slitsize2);

    //Distance from center point to end of screen in meters.
    double screenlength = 3 * distance * wavelength / c_mean(slitsize1, slitsize2);

    for(double screenpt=0;screenpt<=screenlength;screenpt+=screenres){
        double complex wavesum = 0;
        for(double cellnum=0;cellnum<cells;cellnum++){
            for(double sourcept=0;sourcept<=slitsize1;sourcept+=slitres){
                double horizpos = (screenpt - (cellnum * cellsize + sourcept));
                double complex x = cabs(horizpos + I *distance);

                // Add up the wave contribution from the first slit.
                wavesum += t1 * cexp(I * k * x);
            }
            for(double sourcept=0;sourcept<=slitsize2;sourcept+=slitres){
                double horizpos = (screenpt - (cellnum * cellsize + slitsize1 + sourcept));
                double complex x = cabs(horizpos + I *distance);

                // Add up the wave contribution from the second slit.
                wavesum += t2 * cexp(I * k * x);
            }
        }
        double intensity = pow((cabs(wavesum)),2); // Intensity is electric field squared.

        // Normalize intensity so that it is approximately 1.
        struct c_mag *newdata = alloc_mag();
        newdata->data[0] = screenpt * 100;
        newdata->data[1] = intensity / (cells * cellsize / slitres);
        m->next_mag = newdata;
        m = newdata;
    }
    return 0;
}

// runner
int main(int argc, char** argv){
    int cells = 2;
    double slitsize1 = 1e-5;
    double slitsize2 = 1e-5;
    int t1 = 1, t2 = 0, scale = 0;
    int debug = 0;

    if(argc == 2){
        scale = atoi(argv[1]);
    }
    else {
        fprintf(stderr, "Only one argument is allowed.\n");
        exit(99);
    }

    // tic
    for(int i=0;i<scale;i++){
        struct c_mag *m = alloc_mag();
        diffraction(cells, slitsize1, slitsize2, t1, t2, m);
        if(debug) print_mag(m);
        release_mag(m);
    }
    // toc;
    // print elapsedTime
    return 0;
}