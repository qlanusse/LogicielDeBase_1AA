    .text
    .globl inverse
    .globl decoupe
inverse:

/*void inverse(struct cellule_t **l)
{
    struct cellule_t *res, *suiv;
    res = NULL;
    while (*l != NULL) {
        suiv = (*l)->suiv;
        (*l)->suiv = res;
        res = *l;
        *l = suiv;
    }
    *l = res;
}
*/
    // res = -16(%rbp)
    // suiv = -8(%rbp)

    enter $16, $0
    // res = NULL
    movq $0, -8(%rbp)
while:
    // JMP ssi *l == $0
    cmpq $0, (%rdi)
    je end_while
    //suiv = (*l)->suiv
    movq (%rdi), %r11
    movq 8(%r11), %r10
    movq %r10, -16(%rbp)
    //(*l)-> suiv = res
    movq -8(%rbp), %r10
    movq (%rdi), %r11
    movq %r10, 8(%r11)
    //res = *l
    movq (%rdi), %r10
    movq %r10, -8(%rbp)
    //*l = suiv
    movq -16(%rbp), %r10
    movq %r10, (%rdi)
    jmp while
end_while:
    //*l = res
    movq -8(%rbp), %r10
    movq %r10, (%rdi)
    jmp fin

decoupe:
/*
struct cellule_t *decoupe(struct cellule_t *l,
        struct cellule_t **l1,
        struct cellule_t **l2)
{
    struct cellule_t fictif1, fictif2;
    *l1 = &fictif1;
    *l2 = &fictif2;
    while (l != NULL) {
        if (l->val % 2 == 1) {
            (*l1)->suiv = l;
            *l1 = l;
        } else {
            (*l2)->suiv = l;
            *l2 = l;
        }
        l = l->suiv;
    }
    (*l1)->suiv = NULL;
    (*l2)->suiv = NULL;
    *l1 = fictif1.suiv;
    *l2 = fictif2.suiv;
    return l;
}
*/

    // fictif1 = -32(%rbp)
    // fictif2 = -16(%rbp)
    // l = %rdi
    // l1 = %rsi
    // l2 = %rdx
    
    enter $32, $0
    //*l1 = &fictif1
    leaq -32(%rbp), %r10
    movq %r10, (%rsi)
    //*l2 = &fictif2
    leaq -16(%rbp), %r10
    movq %r10, (%rdx)
while_decoupe:
    // jmp ssi l == $0
    cmpq $0, %rdi
    je fin_while_decoupe
    // jmp ssi l->val %2 != 1
movq (%rdi), %r10
    testq $1, (%rdi)
    jz else
if:
    // (*l1)->suiv = l
    movq (%rsi), %r10
    movq %rdi, 8(%r10)
    //*l1 = l
    movq %rdi, (%rsi)
    jmp end_if
else:
    // (*l2)->suiv = l
    movq (%rdx), %r10
    movq %rdi, 8(%r10)
    //*l2 = l
    movq %rdi, (%rdx)
    jmp end_if
end_if:
    // l = l->suiv
    movq 8(%rdi), %rdi

    jmp while_decoupe
fin_while_decoupe:
    //(*l1)->suiv = $0
    movq (%rsi), %r10
    movq $0, 8(%r10)
    //(*l2)->suiv = $0
    movq (%rdx), %r10
    movq $0, 8(%r10)
    //*l1 = fictif1.suiv
    movq -32+8(%rbp), %r10
    movq %r10, (%rsi)
    //*l2 = fictif2.suiv
    movq -16+8(%rbp), %r10
    movq %r10, (%rdx)
    //return 1
    movq %rdi, %rax
fin:
    leave
    ret
    

