#include "const.h"

    .text
    .globl ptr_mem
    .globl ecrit_car
    .globl place_curseur
ptr_mem:
/*uint16_t *ptr_mem(uint32_t lig, uint32_t col) { 
    return (uint16_t*) (MEM_VIDEO + 2*(lig*NB_COL +col));
} 
*/
    //lig = 8(%ebp)
    // col = 12(%ebp)


    //return (uint16_t*) (MEM_VIDEO + 2*(lig*NB_COL +col))
    enter $0, $0
    movl $NB_COL, %eax
    mull 8(%ebp)
    addl 12(%ebp), %eax
    movl $2, %ecx
    mull %ecx
    addl $MEM_VIDEO, %eax
    jmp fin
ecrit_car:
/*
void ecrit_car(uint32_t lig, uint32_t col, char c, uint32_t coul_texte, ui
        nt32_t coul_fond) {
    *ptr_mem(lig, col) = c | (coul_texte << 8) | (coul_fond << 12);
}
*/
    // lig = 8(%ebp)
    // col = 12(%ebp)
    // c = 16(%ebp)
    // coul_texte = 20(%ebp)
    // coul_fond = 24(%ebp)
    
    enter $0, $0
    //*ptr_mem(lig, col)
    pushl 12(%ebp)
    pushl 8(%ebp)
    call ptr_mem
    add $8, %esp
    // = c | (coul_texte << 8) | (coul_fond << 12)
    movl 16(%ebp), %ecx
    movl 20(%ebp), %edx
    shl $8, %edx
    or %edx, %ecx
    movl 24(%ebp), %edx
    shl $12, %edx
    or %edx, %ecx
    movl %ecx, (%eax)
    jmp fin

place_curseur:
/*                                                         
void place_curseur(uint32_t lig, uint32_t col) {           
    uint16_t pos = col + (lig*80);                         
    outb(0x0F, 0x3D4);                                     
    outb((uint8_t) pos, 0x3D5);                            
    outb(0x0E, 0x3D4);                                     
    outb((uint8_t) (pos >> 8), 0x3D5);                     
    pos_x = col;                                           
    pos_y = lig;                                           
}                                                          
*/  
    // pos = -2(%ebp)
    // lig = 8(%ebp)
    // col = 12(%ebp)
                                                       
    enter $4, $0
    //uint16_t pos = col + (lig*80)
    movl 8(%ebp), %eax
    movl $80, %edx
    mull %edx
    movl 12(%ebp), %ecx
    addl %eax, %ecx
    movw %cx, -2(%ebp)
    //outb(0x0F, 0x3D4)
    movb $0x0F, %al
    movl $0x3D4, %dx
    outb %al, %dx
    //outb((uint8_t) pos, 0x3D5);
    movb %cl, %al
    movl $0x3D5, %dx
    outb %al, %dx
    //outb(0x0E, 0x3D4)
    movb $0x0E, %al
    movl $0x3D4, %dx
    outb %al, %dx
    //outb((uint8_t) (pos >> 8), 0x3D5)
    movb %ch, %al
    movl $0x3D5, %dx
    outb %al, %dx
    //pos_x = col
    movl 12(%ebp), %eax
    movl %eax, pos_x
    //pos_y = lig
    movl 8(%ebp), %eax
    movl %eax, pos_y
    jmp fin


fin:
    leave
    ret
