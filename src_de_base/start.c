#include <cpu.h>
#include <inttypes.h>

#include <const.h>
#include "ecran.h"
#include <stdio.h>
#include <clock.h>
#include <traitant.h>

// on peut s'entrainer a utiliser GDB avec ce code de base
// par exemple afficher les valeurs de x, n et res avec la commande display

// une fonction bien connue
uint32_t fact(uint32_t n)
{
    uint32_t res;
    if (n <= 1) {
        res = 1;
    } else {
        res = fact(n - 1) * n;
    }
    return res;
}

void kernel_start(void)
{
    efface_ecran();
    // initialisations
    //demasq_irq(0);
    //init_traitant_IT32(traitant_IT_32);

    printf("J'aime les licornes\n");
    for (int i = 0 ; i < (25*80)+200 ; i++){
        printf("%d ", i);
    }

    set_frequency(50);
    // démasquage des interruptions externes
    sti();
    while (1) {
        // cette fonction arrete le processeur
        hlt();
    }
}

