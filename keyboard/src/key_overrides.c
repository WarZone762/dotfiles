#include QMK_KEYBOARD_H

const key_override_t dlr_override  = ko_make_basic(MOD_MASK_SHIFT, KC_DLR, KC_TILD);
const key_override_t plus_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_PLUS, KC_1, 1);
const key_override_t lbrc_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LBRC, KC_2, 1);
const key_override_t lcbr_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LCBR, KC_3, 1);
const key_override_t lprn_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_LPRN, KC_4, 1);
const key_override_t ampr_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_AMPR, KC_5, 1);

const key_override_t eql_override  = ko_make_with_layers(MOD_MASK_SHIFT, KC_EQL, KC_6, 1);
const key_override_t rprn_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_RPRN, KC_7, 1);
const key_override_t rcbr_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_RCBR, KC_8, 1);
const key_override_t rbrc_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_RBRC, KC_9, 1);
const key_override_t astr_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_ASTR, KC_0, 1);
const key_override_t exlm_override = ko_make_basic(MOD_MASK_SHIFT, KC_EXLM, KC_PERC);

const key_override_t pipe_override = ko_make_basic(MOD_MASK_SHIFT, KC_PIPE, KC_GRV);
const key_override_t bsls_override = ko_make_basic(MOD_MASK_SHIFT, KC_BSLS, KC_HASH);
const key_override_t at_override   = ko_make_basic(MOD_MASK_SHIFT, KC_AT, KC_CIRC);

const key_override_t kc1_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_1, KC_PLUS, 1 << 1);
const key_override_t kc2_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_2, KC_LBRC, 1 << 1);
const key_override_t kc3_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_3, KC_LCBR, 1 << 1);
const key_override_t kc4_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_4, KC_LPRN, 1 << 1);
const key_override_t kc5_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_5, KC_AMPR, 1 << 1);

const key_override_t kc6_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_6, KC_EQL, 1 << 1);
const key_override_t kc7_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_7, KC_RPRN, 1 << 1);
const key_override_t kc8_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_8, KC_RCBR, 1 << 1);
const key_override_t kc9_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_9, KC_RBRC, 1 << 1);
const key_override_t kc0_override = ko_make_with_layers(MOD_MASK_SHIFT, KC_0, KC_ASTR, 1 << 1);

const key_override_t **key_overrides = (const key_override_t *[]){
    &dlr_override,
    &plus_override,
    &lbrc_override,
    &lcbr_override,
    &lprn_override,
    &ampr_override,
    &eql_override,
    &rprn_override,
    &rcbr_override,
    &rbrc_override,
    &astr_override,
    &exlm_override,
    &pipe_override,
    &bsls_override,
    &at_override,
    &kc1_override,
    &kc2_override,
    &kc3_override,
    &kc4_override,
    &kc5_override,
    &kc6_override,
    &kc7_override,
    &kc8_override,
    &kc9_override,
    &kc0_override,
    NULL,
};
