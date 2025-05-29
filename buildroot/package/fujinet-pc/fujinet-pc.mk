################################################################################
#
# fujinet-pc – host-side FujiNet utility
#
################################################################################

# ----------------------------------------------------------------------------- 
# Where to fetch it
# -----------------------------------------------------------------------------
FUJINET_PC_VERSION		     = origin/master
FUJINET_PC_SITE              = https://github.com/FujiNetWIFI/fujinet-firmware.git
FUJINET_PC_SITE_METHOD       = git
FUJINET_PC_NO_CHECK_HASH_FOR = FUJINET_PC

FUJINET_PC_DEPENDENCIES = expat mbedtls host-cmake \
	host-python3 host-python-jinja2 host-python-pyyaml

#FUJINET_PC_PATCHES = 0001-fix-python-bin-call.patch

FUJINET_PC_AUTORECONF = NO

################################################################################
#  Build
################################################################################

define FUJINET_PC_BUILD_CMDS
	$(TARGET_MAKE_ENV) \
		PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
		cd $(@D) && \
		./build.sh -c -p ATARI -y -- \
		   -DCMAKE_TOOLCHAIN_FILE=$(HOST_DIR)/share/buildroot/toolchainfile.cmake \
		   -DMBEDTLS_ROOT_DIR=$(STAGING_DIR)/usr/lib \
		   -DPYTHON_EXECUTABLE=$(HOST_DIR)/bin/python3
endef

# install the resulting executable
define FUJINET_PC_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/dist/fujinet \
		$(TARGET_DIR)/usr/bin/fujinet-pc
endef

# (The upstream repo is GPL-3.0; keep it for completeness)
FUJINET_PC_LICENSE       = GPL-3.0
FUJINET_PC_LICENSE_FILES = LICENSE

$(eval $(generic-package))
