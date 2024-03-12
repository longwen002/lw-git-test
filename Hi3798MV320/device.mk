
#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
ifneq ($(TARGET_PRODUCT), $(CHIPNAME))
    include $(CHIPNAME_DIR)/customer.mk
else
	include device/$(HIVENDOR)/$(TARGET_PRODUCT)/customer.mk
endif

TARGET_BOARD_PLATFORM := bigfish
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_AAPT_CONFIG := normal large xlarge tvdpi hdpi xhdpi xxhdpi

# emmc adapt flag
HI_EMMC_ADAPT := true

# for ethernet and hipppoe frameworks compile
# for AndroidP
# FRAMEWORKS_BASE_SUBDIRS += \
    $(addsuffix /java, \
        hipppoe\
        pppoe\
        ethernet\
    )

#for karaoke
CFG_HI_KARAOKE_SUPPORT := y

$(call inherit-product, $(CHIPNAME_DIR)/device_property.mk)
$(call inherit-product, $(CHIPNAME_DIR)/device_copyfile.mk)
$(call inherit-product, $(BUILD_DIR)/product_package.mk)
$(call inherit-product, $(BUILD_DIR)/tablet-dalvik-heap.mk)
$(call inherit-product-if-exists, $(HIVENDOR_PLATFORM_PATH)/tech_platform/patch/tech_platform.mk)
# wifi and bluetooth PRODUCT_PACKAGES config
include $(CHIPNAME_DIR)/wifi_bt.mk
