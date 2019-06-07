/*
bool palin(char *chaine)
{
    uint32_t inf, sup;
    for (inf = 0, sup = strlen(chaine) - 1;
            (inf < sup) && (chaine[inf] == chaine[sup]);
            inf++, sup--);
    return inf >= sup;
}
*/

    //chaine = 8(%ebp)
    //inf = -4(%ebp)
    //sup = -8(%ebp)
    .text
    .globl palin
palin:
    enter $16, $0
    //sauvegarder chaine
    pushl 8(%ebp)
    //for (inf = 0
    movl $0, -4(%ebp)
    // sup = strlen(chaine)-1
    call strlen
    subl $1, %eax
    movl %eax, -8(%ebp)
    // récupération chaine
    popl 8(%ebp)
for:
    // (inf < sup) && (chaine[inf] == chaine[sup])
    movl -4(%ebp), %eax
    movl -8(%ebp), %ecx
    cmpl %eax, %ecx
    jna fin_for
    movl 8(%ebp), %edx
    movb (%edx, %eax ,1), %al
    cmpb %al, (%edx, %ecx)
    jne fin_for
    // inf++
    addl $1, -4(%ebp)
    //sup--
    subl $1, -8(%ebp)
    jmp for
fin_for:
    //return inf >= sup
    movl -8(%ebp), %eax
    cmpl %eax, -4(%ebp)
    setae %al
    leave
    ret
    
    

