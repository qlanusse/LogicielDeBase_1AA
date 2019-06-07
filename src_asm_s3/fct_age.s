/*uint16_t age(uint16_t annee_naissance)
{
    uint16_t age;
    age = 2016 - annee_naissance;
    return age;
}
*/
    .data
    .text
    .globl age
age:
    enter $16, $0
    // age = 2016 - annee_naissance
    subw $2018, %di
    negw %di
    movw %di, -2(%rbp)
    movw -2(%rbp), %ax
    leave
    ret
    movw $2018, %ax
    subw %di, %ax
    // return age
    leave
    ret
