/*
void tri_nain(int32_t tab[], uint32_t taille)
{
    for (uint32_t i = 0; i < taille - 1; ) {
        if (tab[i] > tab[i+1]) {
            int32_t tmp = tab[i];
            tab[i] = tab[i+1];
            tab[i + 1] = tmp;
            if (i > 0) {
                i = i - 1;
            }
        } else {
            i = i + 1;
        }
    }
}
*/

    //i = -4(ebp)
    //tmp = -8(ebp)
    //tab = 8(ebp)
    //taille = 12(ebp)
    

    .text
    .globl tri_nain
    .globl tri_nain_opt
tri_nain:
    enter $8, $0
    //for (uint64_t i = 0
    movl $0, -4(%ebp)
for:
    // jmp if (i >= taille - 1)
    movl 12(%ebp), %eax
    subl $1, %eax
    cmpl %eax, -4(%ebp)
    jge fin_for
    //jmp if (tab[i] <= tab[i+1])
    movl 8(%ebp), %edx
    movl -4(%ebp), %ecx
    // tab[i]
    movb (%edx, %ecx, 1), %al
    movl 8(%ebp), %edx
    movl -4(%ebp), %ecx
    addl $1, %ecx
    //tab[i+1]
    movb (%edx, %ecx, 1), %dl
    cmpb %dl, %al
    jle else
if:
    //int32_t tmp = tab[i]
    movl 8(%ebp), %edx
    movl -4(%ebp), %ecx
    movb (%edx, %ecx, 1), %al
    movb %al, -8(%ebp)
    //tab[i] = tab[i+1]
    movl 8(%ebp), %edx 
    movl -4(%ebp), %ecx      
    addl $1, %ecx            
      //tab[i+1]
    movb (%edx, %ecx, 1), %al
    subl $1, %ecx
    movb %al, (%edx, %ecx, 1)
    //tab[i + 1] = tmp
      //tmp
    movb -8(%ebp), %al 
    movl 8(%ebp), %edx
    movl -4(%ebp), %ecx   
    addl $1, %ecx
    movb %al, (%edx, %ecx, 1)
    //jmp if (i <= 0)
    movl -4(%ebp), %eax
    cmpl $0, %eax
    jle fin_for
    //i = i - 1
    subl $1, -4(%ebp)
    jmp for
else:
    //i = i + 1
    addl $1, -4(%ebp)
    jmp for
fin_for:
tri_nain_opt:
    leave
    ret
