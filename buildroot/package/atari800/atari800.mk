ATARI800_VERSION = origin/master
ATARI800_SITE = https://github.com/atari800/atari800.git
ATARI800_SITE_METHOD = git
ATARI800_NO_CHECK_HASH_FOR = ATARI800

ATARI800_AUTORECONF = NO
ATARI800_DEPENDENCIES = sdl libpng host-pkgconf host-autoconf host-automake host-libtool host-m4

define ATARI800_CONFIGURE_CMDS
    cd $(@D) && \
    PATH="$(HOST_DIR)/bin:$$PATH" ./autogen.sh && \
    PATH="$(HOST_DIR)/bin:$$PATH" \
    ./configure \
        ac_cv_c_bigendian=no  \
        --prefix=/usr \
        --host=$(GNU_TARGET_NAME) \
        --build=$(GNU_HOST_NAME) \
        --with-video=sdl \
        --with-sound=sdl \
        --without-opengl \
        SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config \
        CC="$(TARGET_CC)" \
        CPP="$(TARGET_CPP)" \
        CXX="$(TARGET_CXX)" \
        LD="$(TARGET_LD)" \
        AR="$(TARGET_AR)" \
        RANLIB="$(TARGET_RANLIB)" \
        STRIP="$(TARGET_STRIP)" \
        PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
        PKG_CONFIG_SYSROOT_DIR="$(STAGING_DIR)" \
        PKG_CONFIG_LIBDIR="$(STAGING_DIR)/usr/lib/pkgconfig:$(STAGING_DIR)/usr/share/pkgconfig" \
        CFLAGS="-O3 -mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard \
            -ftree-vectorize -flto --sysroot=$(STAGING_DIR)" \
        CPPFLAGS="--sysroot=$(STAGING_DIR)" \
        LDFLAGS="--sysroot=$(STAGING_DIR)"
endef

define ATARI800_BUILD_CMDS
    $(MAKE) -C $(@D)
endef

define ATARI800_INSTALL_TARGET_CMDS
    $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
