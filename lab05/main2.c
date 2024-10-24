#include <xc.h>
extern unsigned int gcd(unsigned int a,unsigned int b);

void main(void) {
    volatile unsigned int result2 = gcd(12321,65535);
    while(1);
    return;
}