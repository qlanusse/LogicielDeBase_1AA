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
    // n = 8(%ebp)
    .text
    .globl fact
fact:
    enter $0, $0
    //jmp if n > 1
    cmpl $1, 8(%ebp)
    jnbe else
if:
    movl $1, %eax
    jmp fin
else:
    // Storage n
    pushl 8(%ebp)
    subl $1, (%esp)
    // Appel de fonction
    call fact
    add $4, %esp
    // Multiplication
    mull 8(%ebp)
    // Call erreur_fact en cas d'erreur
    cmpl $0, %edx
    je fin
    pushl 8(%ebp)
    call erreur_fact
fin:
    leave
    ret
