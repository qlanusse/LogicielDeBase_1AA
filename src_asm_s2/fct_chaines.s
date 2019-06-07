/*
   uint64_t taille;
   uint64_t taille_chaine(void)
   {
     for (taille = 0; chaine[taille] != ’\0’; taille++);
     return taille;
   }
 */
    .data
        .comm taille, 8
        .comm dep, 8
        .comm ptr, 8
        .comm tmp, 1
    .text
    .globl taille_chaine
    .globl inverse_chaine
taille_chaine:
    enter $0, $0
    movb $0, taille
    leaq chaine, %r10

boucle_for:
    movq taille, %r11
    movb (%r10, %r11, 1), %al
    // jmp ssi chaine[taille] = 0
    cmpb $0, %al
    je fin_taille_chaine
    // taille ++
    addq $1, taille
    jmp boucle_for   

fin_taille_chaine:
    movq taille, %rax
    leave
    ret

inverse_chaine:
    enter $0, $0
    // dep = taille - 1
    movq taille, %rax
    subq $1, %rax
    movq %rax, dep
    // ptr = chaine
    leaq chaine, %rax
    movq %rax, ptr
boucle_while_inverse:
    // jmp ssi dep <= 0
    cmpq $0, dep
    jle fin_boucle_inverse
    // tmp = *ptr
    movq ptr, %r10
    movb (%r10), %al
    movb %al, tmp
    // *ptr = ptr[dep]
    movq ptr, %r10
    movq dep, %r11
    movb (%r10, %r11, 1), %al
    movb %al, (%r10)
    // ptr[dep] = tmp
    movq ptr, %r10
    movb tmp, %al
    movq dep, %r11
    movb %al, (%r10, %r11, 1)
    // dep -= 2
    subq $2, dep
    // ptr++
    addq $1, ptr
    jmp boucle_while_inverse
fin_boucle_inverse:
    leave
    ret
