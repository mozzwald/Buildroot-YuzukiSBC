################################################################################
#
# libretro-common Buildroot package
#
################################################################################

# master-branch snapshot from GitHub
LIBRETRO_COMMON_VERSION = master
LIBRETRO_COMMON_SITE = https://github.com/libretro/libretro-common/archive/refs/heads/
LIBRETRO_COMMON_SOURCE = $(LIBRETRO_COMMON_VERSION).tar.gz
LIBRETRO_COMMON_NO_CHECK_HASH_FOR = LIBRETRO_COMMON

# permissive upstream licensing
LIBRETRO_COMMON_LICENSE = MIT
LIBRETRO_COMMON_LICENSE_FILES = LICENSE

# no build step: cores compile these sources directly
define LIBRETRO_COMMON_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/include/libretro-common
	cp -r $(@D)/include $(@D)/compat $(@D)/file $(@D)/formats \
	     $(@D)/glsym $(@D)/libco $(@D)/net $(@D)/rthreads \
	     $(@D)/streams $(@D)/utils \
	     $(TARGET_DIR)/usr/include/libretro-common/
endef

$(eval $(generic-package))

