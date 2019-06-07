    .data
        .comm i, 1
        .comm res, 1
    .text
    .globl somme
somme:
    enter $0, $0
    movb $0, res
    movb $1, i

boucle_for:
    cmpb $10, i
    // jmp ssi i > 10
    ja fin_boucle
    //res = res + i
    movb i, %al
    addb %al, res
    // i += 1
    addb $1, i
    jmp boucle_for

fin_boucle:
    // return res
    movb res, %al
    leave
    ret
