#
# BoardConfig.mk
# Product-specific compile-time definitions.
#

#################################################################################
##  Variable configuration definition
################################################################################
# Define product line
HI_PRODUCT_LINE := STB
#HI_PRODUCT_LINE := DPT

# SDK configure
HI_CHIPS := hi3798mv320
ifeq ($(strip $(HI_TARGET_ARCH_SUPPORT)),32only)
ifeq ($(strip $(HI_KPI_OPTIMIZE)),true)
HI_SDK_ANDROID_CFG := androidp/hi3798mv32dms_hi3798mv320_android_kpi_cfg.mak
else
HI_SDK_ANDROID_CFG := androidp/hi3798mv32dms_hi3798mv320_android_cfg.mak
endif
HI_SDK_SECURE_CFG := androidp/hi3798mv32dms_hi3798mv320_android_security_cfg.mak
HI_SDK_TEE_CFG := androidp/hi3798mv32dms_hi3798mv320_android_tee_cfg.mak
HI_SDK_RECOVERY_CFG := androidp/hi3798mv32dms_hi3798mv320_android_recovery_cfg.mak
HI_SDK_ANDROID_APPLOADER_CFG := androidp/hi3798mv32dms_hi3798mv320_android_apploader_cfg.mak
HI_SDK_SECURE_APPLOADER_CFG :=
HI_SDK_TEE_APPLOADER_CFG :=
HI_APPLOADER_IMG_CFG :=

else #HI_TARGET_ARCH_SUPPORT

HI_SDK_ANDROID_CFG :=
HI_SDK_SECURE_CFG :=
HI_SDK_TEE_CFG :=
HI_SDK_RECOVERY_CFG :=

endif

SDK_CFG_DIR := configs/$(HI_CHIPS)
ifeq ($(strip $(TARGET_HAVE_APPLOADER)),false)
ifeq ($(strip $(HI_SECURITY_L2)),true)
ifeq ($(strip $(HI_TEE)),true)
SDK_CFGFILE := $(SDK_CFG_DIR)/$(HI_SDK_TEE_CFG)
else
SDK_CFGFILE := $(SDK_CFG_DIR)/$(HI_SDK_SECURE_CFG)
endif
else
ifeq ($(strip $(HI_TEE)),true)
SDK_CFGFILE := $(SDK_CFG_DIR)/$(HI_SDK_TEE_CFG)
else
SDK_CFGFILE := $(SDK_CFG_DIR)/$(HI_SDK_ANDROID_CFG)
endif
endif

else #TARGET_HAVE_APPLOADER

ifeq ($(strip $(HI_SECURITY_L2)),true)
ifeq ($(strip $(HI_TEE)),true)
SDK_CFGFILE := $(SDK_CFG_DIR)/$(HI_SDK_TEE_APPLOADER_CFG)
else
SDK_CFGFILE := $(SDK_CFG_DIR)/$(HI_SDK_SECURE_APPLOADER_CFG)
endif
else
SDK_CFGFILE := $(SDK_CFG_DIR)/$(HI_SDK_ANDROID_APPLOADER_CFG)
endif
endif

# Kernel configure
RAMDISK_ENABLE := true

ANDROID_KERNEL_CONFIG := hi3798mv320_android_defconfig
RECOVERY_KERNEL_CONFIG := hi3798mv320_android_recovery_defconfig

# fastboot configure
# boot regfiles distinguished by voltage,
# for HI3798MV320, divided into 3.3 V(BOOT_REG_NAME), 2.65 V(BOOT_REG1_NAME), 2.25 V(BOOT_REG2_NAME),
# 1.85 V(BOOT_REG3_NAME), 1.45 V(BOOT_REG4_NAME), 1.05 V(BOOT_REG5_NAME), 0.65 V(BOOT_REG6_NAME),
# 0 V(BOOT_REG7_NAME)
# However, if you choose security boot startup, only a reg table(BOOT_REG_NAME) will take effect.
#
BOOT_REG_NAME :=hi3798mv320dma_Hi3798MV320_LPDDR4-2666-2rank_2GB_32bitx1_2layers.reg
BOOT_REG1_NAME :=
BOOT_REG2_NAME :=
BOOT_REG3_NAME :=
BOOT_REG4_NAME :=
BOOT_REG5_NAME :=
BOOT_REG6_NAME :=
BOOT_REG7_NAME :=
BOOT_REG8_NAME :=
BOOT_REG9_NAME :=
BOOT_REG10_NAME :=hi3798mv200edmg_Hi3798MV320_LPDDR4-2666_2GB_32bitx1_2layers.reg
BOOT_REG11_NAME :=hi3798mv320dmb_Hi3798MV320_DDR4-2666_2GB_16bitx2_2layers.reg
BOOT_REG12_NAME :=hi3798mv320dma_Hi3798MV320_LPDDR4-2666_2GB_32bitx1_2layers.reg
BOOT_REG13_NAME :=
BOOT_REG14_NAME :=

# emmc fastboot configure
EMMC_BOOT_ENV_STARTADDR :=0x100000
EMMC_BOOT_ENV_SIZE=0x10000
EMMC_BOOT_ENV_RANGE=0x10000

# nand fastboot configure
NAND_BOOT_ENV_STARTADDR :=0x800000
NAND_BOOT_ENV_SIZE=0x10000
NAND_BOOT_ENV_RANGE=0x10000

#
# ext4 file system configure
# the ext4 file system just use in the eMMC
#
# BOARD_FLASH_BLOCK_SIZE :              we do not need to change it,but needed
# BOARD_SYSTEMIMAGE_PARTITION_SIZE:     system size,
# BOARD_USERDATAIMAGE_PARTITION_SIZE:   userdata size,
# BOARD_CACHEIMAGE_PARTITION_SIZE :     cache size
# 838860800 represent 838860800/1024/1024 = 800MB
# system,userdata,cache size should be consistent with the bootargs
#
# if ture, the data will be wiped at the end of upgrade process.
WIPE_DATA_IN_UPDATE := true

#The size of flash is 8G default now
ifeq ($(strip $(AB_UPGRADER_SUPPORT)), true)
RECOVERY_OTA_PARTITIONS := boot system vendor dtbo
AB_OTA_PARTITIONS := boot system vendor dtbo
endif
ifeq ($(strip $(AB_PARTITION_SUPPORT)), true)
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1308622848
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3613445324
BOARD_VENDORIMAGE_PARTITION_SIZE := 209715200
BOARD_CACHEIMAGE_PARTITION_SIZE := 834666496
BOARD_SECURESTORE_PARTITION_SIZE:= 8388608
BOARD_PRIVATEIMAGE_PARTITION_SIZE := 52428800
BOARD_BACKUPIMAGE_PARTITION_SIZE := 838860800
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096
else
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1782579200
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3613445324
BOARD_VENDORIMAGE_PARTITION_SIZE := 419430400
BOARD_CACHEIMAGE_PARTITION_SIZE := 834666496
BOARD_SECURESTORE_PARTITION_SIZE:= 8388608
BOARD_PRIVATEIMAGE_PARTITION_SIZE := 52428800
BOARD_BACKUPIMAGE_PARTITION_SIZE := 838860800
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096
ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)), true)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1258291200
BOARD_CACHEIMAGE_PARTITION_SIZE := 838860800
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3309305856
BOARD_CTCIMAGE_PARTITION_SIZE := 304087040
endif
ifeq ($(strip $(HI_CMCC_IPTV_FEATURE)), true)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1258291200
BOARD_CACHEIMAGE_PARTITION_SIZE := 838860800
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3345009868
BOARD_CMCCIMAGE_PARTITION_SIZE := 268435456
endif
endif

BOARD_RECOVERYIMAGE_PARTITION_SIZE := 20971520
BOARD_OTA_FRAMEWORK_VBMETA_VERSION_OVERRIDE := 0.0

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_USES_VENDORIMAGE := true

ifeq ($(strip $(BOARD_AVB_ENABLE)), true)
ifeq ($(strip $(AB_PARTITION_SUPPORT)), true)
BOARD_BOOTIMAGE_PARTITION_SIZE := 31457280
else
BOARD_BOOTIMAGE_PARTITION_SIZE := 62914560
endif

#AVB key and algorithm used for vbmeta, system and vendor
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := $(CHIPNAME_DIR)/security/avb_rsa2048_private_key.pem

ifeq ($(strip $(HI_NSV_SUPPORT)), true)
MSID_REE := 0x00000000
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --prop MSID_REE:$(MSID_REE)
endif

BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS := --hash_algorithm sha256
BOARD_AVB_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_SYSTEM_KEY_PATH := $(CHIPNAME_DIR)/security/testkey_rsa2048.pem
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS := --hash_algorithm sha256
BOARD_AVB_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VENDOR_KEY_PATH := $(CHIPNAME_DIR)/security/testkey_rsa2048.pem
BOARD_AVB_VENDOR_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_ROLLBACK_INDEX_LOCATION := 2

endif
#
# ubifs file system configure
# the ubifs file system just use in Nand Flash
#
# the PAGE_BLOCK_SIZE parameter will be only used
# for making the ubifs img, for example system_4k_1M.ubi
# 4k_1M: 4k: the nand pagesize, 1M:the nand blocksize
#
# if you want make the system.ubi with 2k pagesize and 128k blocksize
# just add 2k_128k at the end of PAGE_BLOCK_SIZE,
# example:
#      PAGE_BLOCK_SIZE:=8k_2M 4k_1M 2k_128k

PAGE_BLOCK_SIZE :=16k_4M 8k_2M 4k_1M

################################################################################
##  Stable configuration definitions
################################################################################

# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
ifeq ($(RAMDISK_ENABLE),false)
TARGET_NO_KERNEL := true
else
TARGET_NO_KERNEL := false
endif
BOARD_KERNEL_BASE :=0x3000000
BOARD_KERNEL_PAGESIZE :=16384
TARGET_NO_RECOVERY := false
TARGET_NO_RADIOIMAGE := true
TARGET_ARCH := arm

# Note: we build the platform images for ARMv7-A _without_ NEON.
#
# Technically, the emulator supports ARMv7-A _and_ NEON instructions, but
# emulated NEON code paths typically ends up 2x slower than the normal C code
# it is supposed to replace (unlike on real devices where it is 2x to 3x
# faster).
#
# What this means is that the platform image will not use NEON code paths
# that are slower to emulate. On the other hand, it is possible to emulate
# application code generated with the NDK that uses NEON in the emulator.
#
ifeq ($(strip $(HI_TARGET_ARCH_SUPPORT)),32only)
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_USES_64_BIT_BINDER := true
else ifeq ($(strip $(HI_TARGET_ARCH_SUPPORT)),64kernel)
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_USES_64_BIT_BINDER := true
else ifeq ($(strip $(HI_TARGET_ARCH_SUPPORT)),32prefer)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
TARGET_CPU_ABI := arm64-v8a
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := cortex-a9
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_USES_64_BIT_BINDER := true
TARGET_PREFER_32_BIT := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_SUPPORTS_32_BIT_APPS := true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES := $(subst zygote32,zygote32_64,$(PRODUCT_DEFAULT_PROPERTY_OVERRIDES))
else ifeq ($(strip $(HI_TARGET_ARCH_SUPPORT)),64prefer)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
TARGET_CPU_ABI := arm64-v8a
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := cortex-a9
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_USES_64_BIT_BINDER := true
TARGET_PREFER_64_BIT := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_SUPPORTS_32_BIT_APPS := true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES := $(subst zygote32,zygote64_32,$(PRODUCT_DEFAULT_PROPERTY_OVERRIDES))
endif

ARCH_ARM_HAVE_TLS_REGISTER := true

BOARD_USES_GENERIC_AUDIO := true

# no hardware camera
USE_CAMERA_STUB := true

ifeq ($(strip $(SUPPORT_ANDROIDTV)), true)
ifneq ($(strip $(TARGET_BUILD_VARIANT)), eng)
WITH_DEXPREOPT := true
DONT_DEXPREOPT_PREBUILTS := true
endif
endif

# Enable dex-preoptimization to speed up the first boot sequence
# of an SDK AVD. Note that this operation only works on Linux for now
#ifeq ($(HOST_OS),linux)
#  ifeq ($(WITH_DEXPREOPT),)
#    WITH_DEXPREOPT := true
#  endif
#endif

# Build OpenGLES emulation guest and host libraries
#BUILD_EMULATOR_OPENGL := true

# Build and enable the OpenGL ES View renderer. When running on the emulator,
# the GLES renderer disables itself if host GL acceleration isn't available.
USE_OPENGL_RENDERER := true

# Buildin GPU gralloc and GPU libraries.
BUILDIN_HI_GPU := true
#BUILDIN_HI_GPU_MIDGARD := true
# Buildin NDK extensions
BUILDIN_HI_EXT := true
HI_GPU_DIR := utgard

# Configure buildin smp
TARGET_CPU_SMP := true

# Disable use system/core/rootdir/init.rc
# use $(HIVENDOR_PLATFORM_PATH)/etc/init.rc
TARGET_PROVIDES_INIT_RC := true

# Configure Board Platform name
TARGET_BOARD_PLATFORM := bigfish
TARGET_BOOTLOADER_BOARD_NAME := bigfish

# Define sdk boot table configures directory
SDK_BOOTCFG_DIR := $(SDK_DIR)/source/boot/sysreg/$(HI_CHIPS)
# Configure Linux Kernel Version
HI_LINUX_KERNEL := linux-4.9.y
# Define linux kernel source path.
HI_KERNEL_SOURCE := $(SDK_DIR)/source/kernel/$(HI_LINUX_KERNEL)

# Set /system/bin/sh to mksh, not ash, to test the transition.
TARGET_SHELL := mksh
#ENHANCE_APPLICATION_COMPATIBILITY := true
ENHANCE_APPLICATION_COMPATIBILITY := false
SUPPORT_IPV6 := true

# widevine Level setting
ifeq ($(HI_TEE),true)
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 1
else
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3
endif

TARGET_RECOVERY_FSTAB := $(TOP)/bootable/recovery/etc/recovery.emmc.fstab
TARGET_RELEASETOOLS_EXTENSIONS := $(CHIPNAME_DIR)/releasetools

ifeq ($(DISABLE_FULL_TREBLE),true)
	# disable full_treble
	BOARD_SYSTEMSDK_VERSIONS := 28
	PRODUCT_FULL_TREBLE_OVERRIDE := false
	PRODUCT_TREBLE_LINKER_NAMESPACES := false
	DEVICE_MANIFEST_FILE := $(CHIPNAME_DIR)/vendor/etc/vintf/manifest_noTreble.xml
else
	# treble
	TARGET_USES_MKE2FS := true
	PRODUCT_FULL_TREBLE_OVERRIDE := true
	BOARD_SYSTEMSDK_VERSIONS := 28
	BOARD_VNDK_VERSION := current
	DEVICE_MANIFEST_FILE := $(CHIPNAME_DIR)/vendor/etc/vintf/manifest.xml
endif
# for AndroidP, API_LEVEL > 27
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# property
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Declaration for selinux policies dir and files.
PRODUCT_SEPOLICY_SPLIT := true
include $(HIVENDOR_PLATFORM_PATH)/system/sepolicy/BoardSepolicy.mk

# system as root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# for property: ro.vendor.build.security_patch
# This property must be modified when products release everytime.
VENDOR_SECURITY_PATCH=2018-08-20
