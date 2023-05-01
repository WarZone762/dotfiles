#include QMK_KEYBOARD_H

const key_override_t dlr_override  = ko_make_basic(MOD_MASK_SHIFT, KC_DLR, S(KC_GRV));
const key_override_t plus_override = ko_make_basic(MOD_MASK_SHIFT, KC_PLUS, KC_1);
const key_override_t lbrc_override = ko_make_basic(MOD_MASK_SHIFT, KC_LBRC, KC_2);
const key_override_t lcbr_override = ko_make_basic(MOD_MASK_SHIFT, KC_LCBR, KC_3);
const key_override_t lprn_override = ko_make_basic(MOD_MASK_SHIFT, KC_LPRN, KC_4);
const key_override_t ampr_override = ko_make_basic(MOD_MASK_SHIFT, KC_AMPR, KC_5);

const key_override_t eql_override  = ko_make_basic(MOD_MASK_SHIFT, KC_EQL, KC_6);
const key_override_t rprn_override = ko_make_basic(MOD_MASK_SHIFT, KC_RPRN, KC_7);
const key_override_t rcbr_override = ko_make_basic(MOD_MASK_SHIFT, KC_RCBR, KC_8);
const key_override_t rbrc_override = ko_make_basic(MOD_MASK_SHIFT, KC_RBRC, KC_9);
const key_override_t astr_override = ko_make_basic(MOD_MASK_SHIFT, KC_ASTR, KC_0);
const key_override_t exlm_override = ko_make_basic(MOD_MASK_SHIFT, KC_EXLM, S(KC_5));

const key_override_t pipe_override = ko_make_basic(MOD_MASK_SHIFT, KC_PIPE, KC_GRV);
const key_override_t bsls_override = ko_make_basic(MOD_MASK_SHIFT, KC_BSLS, S(KC_3));
const key_override_t at_override   = ko_make_basic(MOD_MASK_SHIFT, KC_AT, S(KC_6));

const key_override_t **key_overrides = (const key_override_t *[]){
    &dlr_override, &plus_override, &lbrc_override, &lcbr_override, &lprn_override, &ampr_override, &eql_override, &rprn_override, &rcbr_override, &rbrc_override, &astr_override, &exlm_override, &pipe_override, &bsls_override, &at_override, NULL,
};