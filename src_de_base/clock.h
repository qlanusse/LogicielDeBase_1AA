#ifndef CLOCK_H_
#define CLOCK_H_
#include "inttypes.h"

void tic_PIT(void);

void set_frequency(uint16_t freq);

void demasq_irq(uint8_t irq);

#endif // CLOCK_H_
