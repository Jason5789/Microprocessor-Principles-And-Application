#include <xc.h>
extern unsigned int mysqrt(unsigned int a);

void main(void) {
    volatile unsigned int result1 = mysqrt(20);
    while(1);
    return;
}