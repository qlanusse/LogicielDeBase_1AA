#include "clock.h"
#include <stdio.h>
#include <cpu.h>
#include <string.h>
#include <const.h>
#include <ecran.h>

uint32_t seconds = 0;
uint32_t hidden_time = 0;
uint32_t frequency = 50;

void tic_PIT(void) {
    outb(0x20, 0x20);

    hidden_time++;

    if(hidden_time == frequency) {
        hidden_time = 0;
        seconds ++;

        uint32_t nb_sec = (uint32_t) seconds%60;
        uint32_t nb_min = (uint32_t) (seconds/60)%60;
        uint32_t nb_h = (uint32_t) (seconds/3600)%60;

        char chaine[NB_COL];
        uint32_t taille = sprintf(chaine, "%02d:%02d:%02d", nb_h, nb_min, nb_sec);

        ecrit_haut_droite(chaine, taille);
    }
}

/*
void set_frequency(uint16_t freq) {
    frequency = freq;
    outb(0x34, 0x43);
    outb((QUARTZ/freq)%256, 0x40);
    outb((QUARTZ/freq) >> 8, 0x40);
}
*/


/*
void demasq_irq(uint8_t irq){
    uint32_t bool_tab = inb(0x21);

    uint32_t tmp = (bool_tab & (~(0x1 << irq)));

    outb(tmp, 0x21);
}
*/
