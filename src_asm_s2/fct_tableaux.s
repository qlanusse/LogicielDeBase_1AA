/*
uint64_t i, j, ix_min;
int32_t tmp;
void tri_min(void)
{
    for (i = 0; i < taille - 1; i++) {
        for (ix_min = i, j = i + 1; j < taille; j++) {
            if (tab[j] < tab[ix_min]) {
                ix_min = j;
            }
        }
        tmp = tab[i];
        tab[i] = tab[ix_min];
        tab[ix_min] = tmp;
    }
}
*/

    .data
        .comm i, 8
        .comm j, 8
        .comm ix_min, 8
        .comm tmp, 4
    .text
    .globl tri_min
    .globl tri_min_opt

tri_min:
    enter $0, $0
    movq $0, i

for_1:
    //jmp ssi i >= taille-1
    movq taille, %rax
    sub $1, %rax
    cmpq %rax, i
    jnb fin_for_1
    // Initialisation for_2
    movq i, %r11
    movq %r11, ix_min
    addq $1, %r11
    movq %r11, j
for_2:
    //jmp ssi j >= taille
    movq taille, %rax
    cmpq %rax, j
    jae fin_for_2
    // jmp ssi tab[j] >= tab[ix_min]
    movq tab, %r10
    movq ix_min, %r11
    movl (%r10, %r11, 4), %eax
    movq j, %r11
    cmpl %eax, (%r10, %r11, 4)
    jnl fin_for_2
    // ix_min = j
    movq j, %r11
    movq %r11, ix_min
    // j++
    addq $1, j
    jmp for_2
fin_for_2:
    //tmp = tab[i]
    movq tab, %r10
    movq i, %r11
    movl (%r10, %r11, 4), %eax
    movl %eax, tmp
    //tab[i] = tab[ix_min]
    movq tab, %r10
    movq ix_min, %r11
    movl (%r10, %r11, 4), %eax
    movq i, %r11
    movl %eax, (%r10, %r11, 4)
    //tab[ix_min] = tmp
    movq tab, %r10
    movq ix_min, %r11
    movl tmp, %eax
    movl %eax, (%r10, %r11, 4)
    // i++
    addq $1, i
    jmp for_1
fin_for_1:
tri_min_opt:
    leave
    ret
