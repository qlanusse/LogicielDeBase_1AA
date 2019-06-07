    .data
        .comm res, 8
    .text
    .globl mult_simple
    .globl mult_egypt
    .globl mult_native
mult_simple:
    enter $0, $0
    movq $0, res

native_while:
    cmpq $0, y
    // jmp ssi y == 0
    je common_end
    // res = res + x
    movq x, %rax
    addq %rax, res
    // y -=
    subq $1, y
    jmp native_while

mult_egypt:
    enter $0, $0
    movq $0, res

egypt_while:
    cmpq $0, y
    // jmp ssi y == 0
    je common_end
    // jmp ssi y%2 != 1
    testq $1, y
    jz end_of_if
    // res = res + x
    movq x, %rax
    addq %rax, res
end_of_if:
    // x = x*2
    shlq $1, x
    // y = y / 2
    shrq $1, y
    jmp egypt_while


mult_native:
    enter $0, $0
    movq x, %rax
    mulq y
    leave
    ret    

common_end:
    // return res
    movq res, %rax
    leave
    ret
