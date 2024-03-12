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

#-----------------------------------------------------------------------
# system filescopy
#-----------------------------------------------------------------------

# init
# FIXME be covered with GSI in PureAndroid.
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/init.bigfish.rc:root/init.bigfish.rc
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/init.hi.rc:root/init.hi.rc

# vendor_init
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/vendor/etc/init/hw/init.bigfish.rc:vendor/etc/init/hw/init.bigfish.rc



ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)), true)
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/ueventd.telecom.rc:vendor/ueventd.rc
else
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/ueventd.rc:vendor/ueventd.rc
endif

# Target arch
ifeq ($(strip $(HI_TARGET_ARCH_SUPPORT)), 32prefer)
    PRODUCT_COPY_FILES += system/core/rootdir/init.zygote32_64.rc:root/init.zygote32_64.rc
else ifeq ($(strip $(HI_TARGET_ARCH_SUPPORT)), 64prefer)
    PRODUCT_COPY_FILES += system/core/rootdir/init.zygote64_32.rc:root/init.zygote64_32.rc
endif

#-----------------------------------------------------------------------
# features filescopy
#-----------------------------------------------------------------------

# Features of cts
ifeq ($(strip $(HI_LOWRAM)), true)
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/hi_tv_features_lowmem.xml:vendor/etc/permissions/hi_tv_features.xml
else
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/hi_tv_features.xml:vendor/etc/permissions/hi_tv_features.xml
endif
# Feature of faketouch
ifneq ($(strip $(SUPPORT_ANDROIDTV)), true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.faketouch.xml:vendor/etc/permissions/android.hardware.faketouch.xml
endif

#-----------------------------------------------------------------------
# filesystem filescopy
#-----------------------------------------------------------------------

# fstab
ifeq ($(strip $(HI_LOWRAM)), true)
ifeq ($(strip $(AB_PARTITION_SUPPORT)), true)
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/fstab.enableswap_ab:vendor/etc/fstab.bigfish
else
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/fstab.enableswap:vendor/etc/fstab.bigfish
endif
else
ifeq ($(strip $(AB_UPGRADER_SUPPORT)), true)
ifeq ($(strip $(AB_PARTITION_SUPPORT)), true)
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/fstab.bigfish_ab:vendor/etc/fstab.bigfish
else
    ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)), true)
        PRODUCT_COPY_FILES += \
            $(CHIPNAME_DIR)/etc/fstab.telecom:vendor/etc/fstab.bigfish
    else ifeq ($(strip $(HI_CMCC_IPTV_FEATURE)), true)
        PRODUCT_COPY_FILES += \
            $(CHIPNAME_DIR)/etc/fstab.cmcc:vendor/etc/fstab.bigfish
    else
        PRODUCT_COPY_FILES += \
            $(CHIPNAME_DIR)/etc/fstab.bigfish:vendor/etc/fstab.bigfish
    endif
endif
else
    ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)), true)
        PRODUCT_COPY_FILES += \
            $(CHIPNAME_DIR)/etc/fstab.telecom:vendor/etc/fstab.bigfish
    else ifeq ($(strip $(HI_CMCC_IPTV_FEATURE)), true)
        PRODUCT_COPY_FILES += \
            $(CHIPNAME_DIR)/etc/fstab.cmcc:vendor/etc/fstab.bigfish
    else
        PRODUCT_COPY_FILES += \
            $(CHIPNAME_DIR)/etc/fstab.bigfish:vendor/etc/fstab.bigfish
    endif
endif
endif
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/fstab.data:root/fstab.data

# Recovery restore
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/restore:system/etc/restore

#-----------------------------------------------------------------------
# input filescopy
#-----------------------------------------------------------------------

# ir_user
PRODUCT_COPY_FILES += \
   $(HIVENDOR_PLATFORM_PATH)/prebuilts/Vendor_0001_Product_0001.idc:vendor/usr/idc/Vendor_0001_Product_0001.idc \
   $(HIVENDOR_PLATFORM_PATH)/prebuilts/Vendor_0001_Product_0001.kl:vendor/usr/keylayout/Vendor_0001_Product_0001.kl \
   $(HIVENDOR_PLATFORM_PATH)/prebuilts/Vendor_0001_Product_0001.kcm:vendor/usr/keychars/Vendor_0001_Product_0001.kcm \
   $(HIVENDOR_PLATFORM_PATH)/prebuilts/RemoteB016.idc:system/usr/idc/RemoteB016.idc
#-----------------------------------------------------------------------
# media filescopy
#-----------------------------------------------------------------------

PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/media_codecs.xml:/vendor/etc/media_codecs.xml

# media_codecs.xml
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/media_codecs_performance.xml:/vendor/etc/media_codecs_performance.xml \
    $(HIVENDOR_PLATFORM_PATH)/etc/media_profiles.xml:/vendor/etc/media_profiles_V1_0.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video_hivendor.xml:vendor/etc/media_codecs_google_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:vendor/etc/media_codecs_google_audio.xml \
    $(HIVENDOR_PLATFORM_PATH)/etc/media/mediacodec.policy:/vendor/etc/seccomp_policy/mediacodec.policy

# nxplayer packagename whitelist
PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/etc/nxplayer_package_whitelist.xml:/vendor/etc/nxplayer_package_whitelist.xml

#-----------------------------------------------------------------------
# audio filescopy
#-----------------------------------------------------------------------

# audio policy
USE_XML_AUDIO_POLICY_CONF := 1
ifeq ($(USE_XML_AUDIO_POLICY_CONF), 1)
    PRODUCT_COPY_FILES += \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/audio_policy_configuration.xml:vendor/etc/audio_policy_configuration.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/audio_policy_volumes.xml:vendor/etc/audio_policy_volumes.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/hi_default_volume_tables.xml:vendor/etc/default_volume_tables.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/primary_audio_policy_configuration.xml:vendor/etc/primary_audio_policy_configuration.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/r_submix_audio_policy_configuration.xml:vendor/etc/r_submix_audio_policy_configuration.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/a2dp_audio_policy_configuration.xml:vendor/etc/a2dp_audio_policy_configuration.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/audio_effects.xml:vendor/etc/audio_effects.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/usb_audio_policy_configuration.xml:vendor/etc/usb_audio_policy_configuration.xml \
      $(HIVENDOR_PLATFORM_PATH)/etc/audio/model.bin:vendor/etc/model.bin
else
    PRODUCT_COPY_FILES += $(HIVENDOR_PLATFORM_PATH)/etc/audio/conf/audio_policy.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/audio/alsa/asound.conf:system/etc/asound.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/audio/alsa/alsa.conf:system/usr/share/alsa/alsa.conf

#-----------------------------------------------------------------------
# hdmi filescopy
#-----------------------------------------------------------------------

PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/hdmi/hdmi_compatibility.ini:vendor/etc/hdmi/hdmi_compatibility.ini

#-----------------------------------------------------------------------
# network filescopy
#-----------------------------------------------------------------------

# pppoe
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/pppoe/ppp.conf:system/etc/ppp/ppp.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/pppoe/ppp.connect:system/etc/ppp/ppp.connect \
    $(HIVENDOR_PLATFORM_PATH)/etc/pppoe/ppp.disconnect:system/etc/ppp/ppp.disconnect

#vlan
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/vlan/vlan.start:system/etc/vlan/vlan.start \
    $(HIVENDOR_PLATFORM_PATH)/etc/vlan/vlan.stop:system/etc/vlan/vlan.stop

# Wifi
PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/wpa_supplicant.conf:vendor/etc/wifi/wpa_supplicant.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/wpa_supplicant.conf:vendor/etc/wifi/p2p_supplicant.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/wpa_supplicant.conf:data/vendor/wifi/wpa/wpa_supplicant.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/wpa_supplicant.conf:data/vendor/wifi/wpa/p2p_supplicant.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/p2p_supplicant_overlay.conf:vendor/etc/wifi/p2p_supplicant_overlay.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/icomm_p2p_supplicant_overlay.conf:vendor/etc/wifi/icomm_p2p_supplicant_overlay.conf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/rmbtdriver.sh:vendor/bin/rmbtdriver.sh
    # TODO VtsVndkDependency remove disallowed dependencies: libstdc++.so,FWK-ONLY
    # $(HIVENDOR_PLATFORM_PATH)/etc/wifi/iperf:vendor/bin/iperf \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/iwlist:vendor/bin/iwlist \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/iwpriv:vendor/bin/iwpriv \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/iwconfig:vendor/bin/iwconfig \
    $(HIVENDOR_PLATFORM_PATH)/etc/wifi/iw:vendor/bin/iw

# Bluetooth, for PureAndroid
# FIXME vendor/lib/libbinder.so causes 'CANNOT LINK EXECUTABLE' bug.
# NEVER copy system libs to vendor dir, that will break vndk's restriction.
# PRODUCT_COPY_FILES += \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libchrome.so:vendor/lib/libchrome.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/android.hardware.bluetooth@1.0.so:vendor/lib/android.hardware.bluetooth@1.0.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libaudioclient.so:vendor/lib/libaudioclient.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libprotobuf-cpp-lite.so:vendor/lib/libprotobuf-cpp-lite.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libtinyxml2.so:vendor/lib/libtinyxml2.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libevent.so:vendor/lib/libevent.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libbinder.so:vendor/lib/libbinder.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libaudioutils.so:vendor/lib/libaudioutils.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libaudiomanager.so:vendor/lib/libaudiomanager.so \
    $(HIVENDOR_PLATFORM_PATH)/bluetooth/ap6356s/libspeexresampler.so:vendor/lib/libspeexresampler.so

PRODUCT_COPY_FILES += \
    $(CHIPNAME_DIR)/prebuilts/mute.png:system/etc/mute.png \
    $(CHIPNAME_DIR)/prebuilts/panel.png:system/etc/panel.png \
    $(CHIPNAME_DIR)/prebuilts/hibootvideo_config.xml:system/etc/hibootvideo_config.xml

ifeq ($(strip $(HI_IPTV_FEATURE)),true)
PRODUCT_COPY_FILES += $(CHIPNAME_DIR)/etc/logcat.rc:/system/etc/init/logcat.rc
endif
ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)),true)
PRODUCT_COPY_FILES += $(CHIPNAME_DIR)/etc/dxjc_ctc.rc:/system/etc/init/dxjc_ctc.rc
endif
ifeq ($(strip $(HI_CMCC_IPTV_FEATURE)),true)
PRODUCT_COPY_FILES += $(CHIPNAME_DIR)/etc/ydjc_cmcc.rc:/system/etc/init/ydjc_cmcc.rc
endif
# preloaded-classes boot opt
PRODUCT_COPY_FILES += $(CHIPNAME_DIR)/etc/preloaded-classes1:system/etc/preloaded-classes1
PRODUCT_COPY_FILES += $(CHIPNAME_DIR)/etc/preloaded-classes2:system/etc/preloaded-classes2
#-----------------------------------------------------------------------
# end of filescopy
#-----------------------------------------------------------------------
