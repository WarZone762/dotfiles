#include QMK_KEYBOARD_H

enum {
    REPEAT_M1 = SAFE_RANGE,
    REPEAT_M2,
};

bool repeat_m1 = false;
bool repeat_m2 = false;

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case REPEAT_M1:
            if (record->event.pressed) {
                repeat_m1 = true;
            } else {
                repeat_m1 = false;
            }
            break;
        case REPEAT_M2:
            if (record->event.pressed) {
                repeat_m2 = true;
            } else {
                repeat_m2 = false;
            }
            break;
    }
    return true;
};

void matrix_scan_user(void) {
    if (repeat_m1) {
        tap_code(KC_MS_BTN1);
    }
    if (repeat_m2) {
        tap_code(KC_MS_BTN2);
    }
}
