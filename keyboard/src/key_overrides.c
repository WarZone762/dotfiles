#include QMK_KEYBOARD_H

const key_override_t dlr_override  = ko_make_basic(MOD_MASK_SHIFT, KC_DLR, KC_TILD);
const key_override_t plus_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_PLUS_F1), KC_1);
const key_override_t lbrc_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_LBRC_F2), KC_2);
const key_override_t lcbr_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_LCBR_F3), KC_3);
const key_override_t lprn_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_LPRN_F4), KC_4);
const key_override_t ampr_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_AMPR_F5), KC_5);

const key_override_t eql_override  = ko_make_basic(MOD_MASK_SHIFT, TD(TD_EQL_F6), KC_6);
const key_override_t rprn_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_RPRN_F7), KC_7);
const key_override_t rcbr_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_RCBR_F8), KC_8);
const key_override_t rbrc_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_RBRC_F9), KC_9);
const key_override_t astr_override = ko_make_basic(MOD_MASK_SHIFT, TD(TD_ASTR_F10), KC_0);
const key_override_t exlm_override = ko_make_basic(MOD_MASK_SHIFT, KC_EXLM, KC_PERC);

const key_override_t pipe_override = ko_make_basic(MOD_MASK_SHIFT, KC_PIPE, KC_GRV);
const key_override_t bsls_override = ko_make_basic(MOD_MASK_SHIFT, KC_BSLS, KC_HASH);
const key_override_t at_override   = ko_make_basic(MOD_MASK_SHIFT, KC_AT, KC_CIRC);

const key_override_t **key_overrides = (const key_override_t *[]){
    &dlr_override, &plus_override, &lbrc_override, &lcbr_override, &lprn_override, &ampr_override, &eql_override, &rprn_override, &rcbr_override, &rbrc_override, &astr_override, &exlm_override, &pipe_override, &bsls_override, &at_override, NULL,
};