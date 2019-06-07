#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <inttypes.h>

struct cell_t {
    uint8_t val;
    struct cell_t *suiv;
};

struct liste_t {
    struct cell_t tete;
};

struct liste_t *nouv_liste(void)
{
    struct liste_t *new_list = malloc(sizeof(struct liste_t));
    struct cell_t *head_cell = malloc(sizeof(struct cell_t));
    new_list->tete = *head_cell;
    return new_list;
}

bool est_vide_liste(struct liste_t *liste)
{
    if (liste->tete.suiv != NULL) {
        return false;
    }
    return true;
}

void inserer_tete_liste(uint8_t val, struct liste_t *liste)
{
    struct cell_t *new_cell = malloc(sizeof(struct cell_t));
    new_cell->val = val;
    new_cell->suiv = liste->tete.suiv;
    liste->tete.suiv = new_cell;
}

bool supprimer_val_liste(uint8_t val, struct liste_t *liste)
{
    struct cell_t *prec = &(liste->tete);
    for ( ; (prec->suiv != NULL) && (prec->suiv->val != val) ; prec = prec->suiv );
    if (prec->suiv != NULL) {
        struct cell_t *tmp = prec->suiv;
        prec->suiv = prec->suiv->suiv;
        free(tmp);
        return true;
    } else {
        return false ;
    }

//    struct cell_t *tmp = malloc(sizeof(struct cell_t));
//    struct cell_t *current_cell = malloc(sizeof(struct cell_t));
//    *current_cell = liste->tete;
//    while (current_cell->suiv != NULL){
//        if (current_cell->suiv->val == val) {
//            tmp = current_cell->suiv;
//            current_cell->suiv = tmp->suiv;
//            free(tmp);
//            return true;
//        }
//        current_cell = current_cell->suiv;
//    }
//    return false;
}

void afficher_liste(struct liste_t *liste)
{
    struct cell_t *current_cell = malloc(sizeof(struct cell_t));
    *current_cell = liste->tete;
    while (current_cell->suiv != NULL) {
        printf("%d ", current_cell->suiv->val);
        current_cell = current_cell->suiv;
    }
    printf("\n");
}

void detruire_liste(struct liste_t **liste)
{
    while (!est_vide_liste(*liste)) {
        struct cell_t *tmp = (*liste)->tete.suiv;
        (*liste)->tete.suiv = tmp->suiv;
        free(tmp);
    }
    free(*liste);
    *liste = NULL;
//    struct cell_t *tete = malloc(sizeof(struct cell_t));
//    struct cell_t *tmp = malloc(sizeof(struct cell_t));
//    *tete = (*liste)->tete;
//    while (tete->suiv != NULL) {
//        tmp = tete->suiv;
//        tete->suiv = tmp->suiv;
//        free(tmp);
//    }
//    free(tete);
//    free(*liste);
//    *liste = NULL;
}

