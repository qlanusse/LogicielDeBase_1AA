#include "traitant.h"
#include <stdio.h>
#include <cpu.h>
#include <string.h>
#include <const.h>
#include <ecran.h>
#include <segment.h>

void init_traitant_IT32(void (*traitant)(void)){ 
    uint32_t* it = (uint32_t*) (IDT_ADR + 32*2*4);
    *it = (KERNEL_CS << 16) | ((uint32_t) traitant);
    *(it+1) = ((uint32_t) traitant & 0xFFFF0000) | 0x00008E00;
}

