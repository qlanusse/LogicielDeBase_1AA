#include "liste.h"
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    // la fonction srandom initialise le generateur de
    //   nombres aleatoires
    srandom(time(NULL));
    // ensuite, on utilise random() pour recuperer une valeur
    //   aleatoire entre 0 et une valeur max tres grande
    // si on veut par exemple recuperer des entiers entre 0 et
    //   9, on utilisera un modulo : random() % 10
    // a completer

    struct liste_t *liste = nouv_liste();
    printf ("liste vide ? -> %d\n", est_vide_liste(liste));
    afficher_liste(liste);

    for (uint8_t i = 0 ; i < 10 ; i++) {
        inserer_tete_liste(i, liste);
    }
    printf ("liste vide ? -> %d\n", est_vide_liste(liste));
    printf("Liste remplie :\n");
    afficher_liste(liste);
    printf("\n");
    //while(jo

    printf ("liste vide ? -> %d\n", est_vide_liste(liste));
   
    supprimer_val_liste(5, liste);
    printf("Liste sans la valeur 5 :\n");
    afficher_liste(liste);

    printf("\n");
    detruire_liste(&liste);
    afficher_liste(liste);

    return 0;
}

