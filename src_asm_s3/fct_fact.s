/*
uint64_t fact(uint64_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        return n * fact(n - 1);
    }
}
*/

    .text
    .globl fact
fact:
    enter $16, $0
    // jmp if n > 1
    cmpq $1, %rdi
    jnbe else
if:
    movq $1, %rax
    jmp fin
else:
    movq %rdi, -16(%rbp)
    subq $1, %rdi
    call fact
    // Récupération n initial
    movq -16(%rbp), %rdi
    mulq %rdi
    // Call erreur_fact en cas d'erreur
    cmpq $0, %rdx
    je fin
    call erreur_fact
fin:
    leave
    ret

