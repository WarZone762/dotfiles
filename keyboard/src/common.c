#include QMK_KEYBOARD_H

#include "gpio.h"

static inline void rx_led_on(void) {
    setPinOutput(B0);
    writePin(B0, 0);
}
static inline void rx_led_off(void) {
    setPinOutput(B0);
    writePin(B0, 1);
}

layer_state_t layer_state_set_user(layer_state_t state) {
    switch (get_highest_layer(state)) {
        case 4:
            ergodox_board_led_on();
            break;
        default:
            ergodox_board_led_off();
            break;
    }
    return state;
}
