# Absolute path helper
BOARD_LC_PI_PATH := $(BR2_BASE_DIR)/board/lctech/lc-pi-t113

# Copy any overlay into the target rootfs
BR2_ROOTFS_OVERLAY += $(BOARD_LC_PI_PATH)/rootfs

# Tell the generic logic where the post-image script and genimage.cfg live
BR2_ROOTFS_POST_IMAGE_SCRIPT += $(BOARD_LC_PI_PATH)/scripts/post-build.sh
BR2_ROOTFS_POST_SCRIPT_ARGS  += $(BOARD_LC_PI_PATH)
BR2_GENIMAGE_CFG             ?= $(BOARD_LC_PI_PATH)/scripts/genimage.cfg
BR2_GENIMAGE_OUTPUT          ?= $(BINARIES_DIR)/sdcard.img

