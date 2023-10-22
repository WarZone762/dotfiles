#include QMK_KEYBOARD_H

#define REPEAT_DELAY 30

enum {
    REPEAT_M1 = SAFE_RANGE,
    REPEAT_M2,
};

bool repeat_m1 = false;
uint16_t repeat_timer_m1 = 0;

bool repeat_m2 = false;
uint16_t repeat_timer_m2 = 0;

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case REPEAT_M1:
            repeat_m1 = record->event.pressed;
            repeat_timer_m1 = timer_read();
            break;
        case REPEAT_M2:
            repeat_m2 = record->event.pressed;
            repeat_timer_m2 = timer_read();
            break;
    }
    return true;
};

void matrix_scan_user(void) {
    if (repeat_m1 && timer_elapsed(repeat_timer_m1) > REPEAT_DELAY) {
        tap_code(KC_MS_BTN1);
        repeat_timer_m1 += REPEAT_DELAY;
    }
    if (repeat_m2 && timer_elapsed(repeat_timer_m2) > REPEAT_DELAY) {
        tap_code(KC_MS_BTN2);
        repeat_timer_m2 += REPEAT_DELAY;
    }
}
