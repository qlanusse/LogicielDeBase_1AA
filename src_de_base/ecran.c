#include "ecran.h"
#include <stdio.h>
#include <cpu.h>
#include <string.h>
#include <const.h>

uint32_t pos_x, pos_y;

/*
uint16_t *ptr_mem(uint32_t lig, uint32_t col) {
    return (uint16_t*) (MEM_VIDEO + 2*(lig*NB_COL +col));
}
*/

/*
void ecrit_car(uint32_t lig, uint32_t col, char c, uint32_t coul_texte, uint32_t coul_fond) {
    *ptr_mem(lig, col) = c | (coul_texte << 8) | (coul_fond << 12);
}
*/

void efface_ecran(void) {
    for (uint16_t l = 0 ; l < NB_LIG ; l++) {
        for (uint16_t c = 0 ;  c < NB_COL ; c++) {
            ecrit_car(l, c, ' ', 15, 0);
        }
    }
}

/*
void place_curseur(uint32_t lig, uint32_t col) {
    uint16_t pos = col + (lig*80);
    outb(0x0F, 0x3D4);
    outb((uint8_t) pos, 0x3D5);
    outb(0x0E, 0x3D4);
    outb((uint8_t) (pos >> 8), 0x3D5);
    pos_x = col;
    pos_y = lig;
}
*/

void traite_car(char c) {
    if(pos_x == 80) {
        if(pos_y == 24) {
            defilement();
            place_curseur(24, 0);
        } else {
            pos_x--;
            traite_car('\n');
        }
    }

    if ( (c < 127) && (c > 31)) {
        ecrit_car(pos_y, pos_x, c, 15, 0);
        pos_x++;
    } else {
        if(c == 8) {
            if (pos_x > 0) {
                pos_x--;
            }
        } else if (c == 9) {
            pos_x++;
            while(pos_x%8 != 0){
                pos_x++;
            }
            if (pos_x >= 80){
                pos_x = 79;
            }
        } else if (c == 10) {
            if (pos_y < NB_LIG){
                pos_y++;
            }
            pos_x = 0;
        } else if (c == 12) {
            efface_ecran();
            pos_y = 0;
            pos_x = 0;
        } else if (c == 13) {
            pos_x = 0;
        }
    }
    place_curseur(pos_y, pos_x);
}

void defilement(void) {
    for(uint16_t l = 1 ; l < NB_LIG ; l++){
        memmove(ptr_mem(l-1, 0), ptr_mem(l, 0), NB_COL*2);
    }
    for(uint16_t c = 0 ; c < NB_COL ; c++){
        ecrit_car(24, c, ' ', 15, 0);
    }
}


void console_putbytes(char *chaine, int32_t taille) {
    for (uint32_t i = 0 ; i < taille ; i++) {
        traite_car(chaine[i]);
    }
}

void ecrit_haut_droite(char *chaine, uint32_t taille) {
    pos_x = NB_COL - taille;
    pos_y = 0;
    console_putbytes(chaine, taille);
}
