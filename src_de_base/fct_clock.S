#include "const.h"
    .text
    .globl set_frequency
    .globl demasq_irq

    // freq : 8(%ebp)

set_frequency:
    enter $0, $0
    // frequency = freq
    movl 8(%ebp), %eax
    movl %eax, frequency
    // outb(0x34, 0x43)
    movb $0x34, %al
    movw $0x43, %dx
    outb %al, %dx
    // outb((QUARTZ/freq)%256, 0x40);
    movl $QUARTZ, %eax
    movl 8(%ebp), %ecx
    movl $0, %edx
    divl %ecx
      // movb %eax, %al
    movw $0x40, %dx
    outb %al, %dx
    // outb((QUARTZ/freq) >> 8, 0x40);
    movl $QUARTZ, %eax
    movl 8(%ebp), %ecx
    movl $0, %edx
    divl %ecx
    movb %ah, %al 
    movw $0x40, %dx
    outb %al, %dx

    jmp fin

demasq_irq:
    //tmp = -8(%ebp)
    // bool_tab = -4(%ebp)
    // irq = 8(%ebp)

    enter $8, $0
    // bool_tab = inb(0x21)
    movw $0x21, %dx
    inb %dx, %al
    movb %al, -4(%ebp)
    // uint32_t tmp = (bool_tab & (~(0x1 << irq)));
    movl $1, %ecx
    movb 8(%ebp), %cl
    shlb %cl, %dl
    notb %dl
    movb -4(%ebp), %cl
    andb %cl, %dl
    movb %dl, -8(%ebp)
    // outb(tmp, 0x21)
    movb -8(%ebp), %dl
    movb %dl, %al
    movw $0x21, %dx
    outb %al, %dx
    jmp fin
    
fin:
    leave
    ret

