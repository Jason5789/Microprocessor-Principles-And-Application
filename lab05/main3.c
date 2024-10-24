#include <xc.h>
extern unsigned int multi_signed(unsigned char a,unsigned char b);

void main(void) {
    volatile unsigned int result3 = multi_signed(100,0);
    while(1);
    return;
}