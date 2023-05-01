KEYBOARD := ktec/ergodone
KEYMAP := my-keymap
KEYMAP_PATH := keymaps/${KEYMAP}

SRC := common.c macros.c key_overrides.c tap_dance.c
SRC := $(addprefix src/,${SRC})
TARGET := $(subst /,_,${KEYBOARD})_${KEYMAP}.hex

default: ${TARGET} move

keymap_generated.c: ${KEYMAP}.json
	cd ../..; qmk json2c ${KEYMAP_PATH}/${KEYMAP}.json > ${KEYMAP_PATH}/keymap_generated.c

${TARGET}: keymap.c keymap_generated.c ${SRC}
	cd ../..; qmk compile -j4 -kb ${KEYBOARD} -km ${KEYMAP}

move:
	cd ../..; mv ../../../${TARGET} ${KEYMAP_PATH}/${TARGET}
