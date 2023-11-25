#include "halt.h"

void hcf() {
    asm ("cli");
    for (;;) {
        asm ("hlt");
    }
}