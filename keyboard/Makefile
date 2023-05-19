KEYBOARD := ktec/ergodone
KEYMAP := my-keymap
QMK_DIR := ${HOME}/qmk_firmware

SRC := common.c macros.c key_overrides.c
SRC := $(addprefix src/,${SRC})
OUT_DIR := firmware
TARGET_NAME := $(subst /,_,${KEYBOARD})_${KEYMAP}.hex
TARGET := ${OUT_DIR}/${TARGET_NAME}

default: ${TARGET}

src/keymap_generated.c: ${KEYMAP}.json
	qmk json2c ${KEYMAP}.json > src/keymap_generated.c

${TARGET}: keymap.c src/keymap_generated.c ${SRC}
	qmk compile -kb ${KEYBOARD} -km ${KEYMAP}
	mv -v ${QMK_DIR}/${TARGET_NAME} ${TARGET}

flash: ${TARGET}
	./hid_bootloader_cli -w -v -mmcu=atmega32u4 ${TARGET}

