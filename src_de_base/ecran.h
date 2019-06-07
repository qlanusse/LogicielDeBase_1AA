#ifndef ECRAN_H_
#define ECRAN_H_
#include "inttypes.h"

uint16_t *ptr_mem(uint32_t lig, uint32_t col);

void ecrit_car(uint32_t lig, uint32_t col, char c, uint32_t coul_texte, uint32_t coul_fond);

void efface_ecran(void);

void place_curseur(uint32_t lig, uint32_t col);

void traite_car(char c);

void defilement(void);

void console_putbytes(char *chaine, int32_t taille);

void ecrit_haut_droite(char *chaine, uint32_t taille);

#endif // ECRAN_H_
