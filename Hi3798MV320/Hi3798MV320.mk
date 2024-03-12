HI_PRODUCT_LINE := STB
HIVENDOR := hisilicon
HIVENDOR_PLATFORM_PATH := device/$(HIVENDOR)/bigfish

SDK_NAME := sdk
SDK_DIR  := $(HIVENDOR_PLATFORM_PATH)/$(SDK_NAME)
BUILD_DIR:= $(HIVENDOR_PLATFORM_PATH)/build
ETC_DIR  := $(HIVENDOR_PLATFORM_PATH)/etc

ENABLE_TREBLE := true
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# NOTICE: disable full_treble requires selinux permissive.
DISABLE_FULL_TREBLE := true

# Set true for AndroidTV supported
SUPPORT_ANDROIDTV := false

# Supported full language
FULL_LANGUAGE_LOCALES_SUPPORT := n

# Optimized Boot Support begin
# 1. If AndroidTV supported, set OPTIMIZED_BOOT_SUPPORT false.
# 2. Set OPTIMIZED_BOOT_TAILOR_Lx before inherit full_base.mk.
ifneq ($(strip $(SUPPORT_ANDROIDTV)), true)
    OPTIMIZED_BOOT_SUPPORT := true
    ifeq ($(OPTIMIZED_BOOT_SUPPORT),true)
        # Tailor L1 with CTS supported
        OPTIMIZED_BOOT_TAILOR_L1 := true
        # Tailor L2 without CTS supported
        # OPTIMIZED_BOOT_TAILOR_L2 := true
    endif
    ifeq ($(OPTIMIZED_BOOT_TAILOR_L1),true)
        PRODUCT_PROPERTY_OVERRIDES += ro.optimizedboot.tailor.level=L1
    else
        ifeq ($(OPTIMIZED_BOOT_TAILOR_L2),true)
            PRODUCT_PROPERTY_OVERRIDES += ro.optimizedboot.tailor.level=L2
        endif
    endif
endif
# Optimized Boot Support end

# AndroidTV mk
ifeq ($(strip $(SUPPORT_ANDROIDTV)), true)
   $(call inherit-product-if-exists, $(BUILD_DIR)/androidtv.mk)
else
   $(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
endif


CHIPNAME := Hi3798MV320
PRODUCT_NAME := Hi3798MV320
PRODUCT_DEVICE := Hi3798MV320
PRODUCT_BRAND := HiSTBAndroid
PRODUCT_MODEL := Hi3798MV320
PRODUCT_MANUFACTURER := Hivendor
CHIPNAME_DIR := device/$(HIVENDOR)/$(CHIPNAME)
BOARD_BLUETOOTH_DEVICE_REALTEK := n

DEVICE_PACKAGE_OVERLAYS := $(CHIPNAME_DIR)/overlay \
                           device/google/atv/overlay

ifeq ($(FULL_LANGUAGE_LOCALES_SUPPORT), y)
    ADDITIONAL_FONTS_FILE := $(CHIPNAME_DIR)/etc/fonts.xml
else
    DEVICE_PACKAGE_OVERLAYS += $(CHIPNAME_DIR)/languages_overlay
endif

# Support thirdparty security app
-include $(CHIPNAME_DIR)/netflix.mk

$(call inherit-product, $(CHIPNAME_DIR)/device.mk)
ifeq ($(BOARD_BLUETOOTH_DEVICE_REALTEK),y)
$(call inherit-product, $(HIVENDOR_PLATFORM_PATH)/bluetooth/rtkbt/bluetooth/rtkbt.mk)
endif
