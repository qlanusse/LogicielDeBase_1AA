#include "liste.h"
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

#define TAILLE_TABLE 4

struct tablehash_t {
    uint64_t nbr_elem;
    struct liste_t *table[TAILLE_TABLE];
};

static int64_t hash(uint8_t x)
{
    return x % TAILLE_TABLE;
}

struct tablehash_t *nouv_tablehash(void)
{
    struct tablehash_t *tablehash = malloc(sizeof(struct tablehash_t));
    assert(tablehash != NULL);
    tablehash->nbr_elem = hash(0);
    return tablehash;
}

bool est_vide_tablehash(struct tablehash_t *th)
{
    // a changer
    (void)th;
    return false;
}

void inserer_val_tablehash(uint8_t val, struct tablehash_t *th)
{
    // a completer
    (void)val;
    (void)th;
}

void supprimer_val_tablehash(uint8_t val, struct tablehash_t *th)
{
    // a completer
    (void)val;
    (void)th;
}

void afficher_tablehash(struct tablehash_t *th)
{
    // a completer
    (void)th;
}

void detruire_tablehash(struct tablehash_t **th)
{
    // a completer
    (void)th;
}

