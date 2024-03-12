
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
#-----------------------------------------------------------------------
#system property
#-----------------------------------------------------------------------

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.target=$(PRODUCT_TARGET)

# VtsTreblePlatformVersionTest#testFirstApiLevel
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=28

PRODUCT_PROPERTY_OVERRIDES += \
    fw.max_users=5 \
    fw.show_multiuserui=true

# bluetooth switch
PRODUCT_PROPERTY_OVERRIDES += \
    config.disable_bluetooth=true

# Preferential nxplayer cache setting
PRODUCT_PROPERTY_OVERRIDES += \
    media.hp.cache.type=time \
    media.hp.cache.low=500 \
    media.hp.cache.high=12000 \
    media.hp.cache.total=20000 \
    media.hp.cache.maxsize=80 \
    media.hp.hls.md=0

#setup UI density for shcmcc/telecom/aosp
PRODUCT_PROPERTY_OVERRIDES += \
     ro.sf.lcd_density=240
#1080 UI set to false
persist.display.720p=false
#add png and jpeg decoder.accelerated
PRODUCT_PROPERTY_OVERRIDES += \
     ro.decoder.accelerated=false

PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.log.switch=false

#support release for dhcp4,ipoe4,dhcp6,ipoe6
ifeq ($(strip $(HI_KPI_OPTIMIZE)),true)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.ethernet.releasemode=ipoe4,ipoe6,dhcp6
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.ethernet.releasemode=ipoe4,ipoe6,dhcp4,dhcp6
endif

#wifi disguise, default false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.ethernet.wifidisguise=false

#dhcp+ field32, default false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.dhcp.field32=false

#dhcp lease, store dhcp ip address
PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.dhcp.clientip=0.0.0.0

#dhcp lease, store dhcp prefix
PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.dhcp.prefix=0

#check full dhcp, default false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.dhcp.full=false

#network coexist mode,default false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.nousefwmark=true

#network coexist mode,default true
PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.coexist=true

#network priority ,default ethernet
#support value : wifi and ethernet
PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.firstpriority=ethernet

# to avoid effect original process
PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.ipv6.support=true

PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.ipv6.auto.statelesstime=5000

PRODUCT_PROPERTY_OVERRIDES += \
    persist.network.ipv6.ppp.statelesstime=10000

# to specify vendorspecinfo prefix length
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendorspecinfo.prefix.length=5

# doublestack for pppoe and ipoe auto switch
PRODUCT_PROPERTY_OVERRIDES += \
    persist.ethernet.doublestack=false

# PureAndroid
# network doesn't support type mobile
PRODUCT_PROPERTY_OVERRIDES += ro.radio.noril=true

# add drm service enable property for PlayReady/Widevine
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true

# Configure Widevine Stream Cache Size for HD content
PRODUCT_PROPERTY_OVERRIDES += ro.com.widevine.cachesize=16777216

# widevine debug switch
PRODUCT_PROPERTY_OVERRIDES += drm.widevine.debug=false

# For application to get the OpenGL ES version
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# wifi driver
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0
    # wifi.driver.enable=false

# When set to TRUE this flag sets EGL_SWAP_BEHAVIOR_PRESERVED_BIT in eglSwapBuffers
# which will end up preserving the whole frame causing a significant increase in memory bandwidth and decrease in performance
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false

# set ro.kernel.android.checkjni false for apk compatibility
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=false

# Disable lockscreen by default
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lockscreen.disable.default=true

# Disable hardware menu key
PRODUCT_PROPERTY_OVERRIDES += \
    qemu.hw.mainkeys=1

# DEFAULT STORAGE
PRODUCT_PROPERTY_OVERRIDES += \
    ro.defaultStorage.enable=false

# DLNA&Skyplay Toast
PRODUCT_PROPERTY_OVERRIDES += \
    ro.toastshow.enable=false

#Default enforce 3D FramePacking Output
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.fpk.enforce=true

# Dobly DMA Certification
PRODUCT_PROPERTY_OVERRIDES += \
    ro.dolby.dmacert.enable=false

# Dobly IPTV Certification
PRODUCT_PROPERTY_OVERRIDES += \
    ro.dolby.iptvcert.enable=false

# Dobly DVB Certification
PRODUCT_PROPERTY_OVERRIDES += \
    ro.dolby.dvbcert.enable=false

# Optimized Boot
ifeq ($(OPTIMIZED_BOOT_SUPPORT),true)
    PRODUCT_PROPERTY_OVERRIDES += \
        persist.prop.optboot.enabled=true \
        persist.prop.optboot.init=true \
        persist.prop.optboot.preload=true
endif

PRODUCT_PROPERTY_OVERRIDES += \
    hibrowser.default.fullscreen=true

PRODUCT_PROPERTY_OVERRIDES += \
    persist.graph.hwcursor=true \
    ro.graph.hwcursor.fb=/dev/graphics/fb1

# Screen orientation: landscape or portrait
#PRODUCT_PROPERTY_OVERRIDES += \
#    persist.sys.screenorientation=landscape

#adb
#PRODUCT_PROPERTY_OVERRIDES += \
#    ro.adb.secure = 1

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable.snapshot=true

TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop

#add for androidp healthd fake battery data
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.fake_battery=1

ifeq ($(HI_TEE_MEM),1G)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.low_ram=true
endif

# Whether display format self-adaption is enabled or not when HDMI is plugged in
# 0 -> disable; 1 -> enable
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.optimalfmt.enable=1

# Preferential display format: native, i50hz, p50hz, i60hz, p60hz or max_fmt
# persist.prop.optimalfmt.perfer is valid only if persist.prop.optimalfmt.enable=1
ifeq ($(strip $(PRODUCT_TARGET)), telecom)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.optimalfmt.perfer = max_fmt
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.optimalfmt.perfer = native
endif

# hdrmode default value 0:SDR, 1:Auto, 2:Dobly, 3:HDR10,4:HLG
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.hdrmode=1

# hdrmode auto mode strategy ,
# true : auto base on real hdmicap,
# false: auto mode set drv type auto mode
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.alwayshdr=false


# Whether CVBS is enabled or not when HDMI is plugged in
# false -> disable; true -> enable
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.cvbs.and.hdmi=false
#android cec switch is in defaults.xml as bellow ,don't modify this property
is_cec_enable := $(shell grep def_hdmi_control_enabled frameworks/base/packages/SettingsProvider/res/values/defaults.xml | grep "1")
ifneq ($(is_cec_enable),)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.hdmi.cec=true
endif
is_cec_enable := $(shell grep def_hdmi_stb_ctrl_tv_en frameworks/base/packages/SettingsProvider/res/values/defaults.xml | grep "1")
ifneq ($(is_cec_enable),)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.control.tv=1
endif

# the position of cvbs open on.
# disp0 -> open on disp0
# disp1 -> open on disp1
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.cvbs.open.at=disp1

# Output format adaption for 2D streams
# false -> disable; true -> enable
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.video.adaptformat=false

# colorspace and deepcolor flag for user set
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.scolorspacesettype= -1

# HI_UNF_HDMI_GetSinkCapability status flag

PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.capgetfailflag = -1

PRODUCT_PROPERTY_OVERRIDES += \
    vendor.gfx.hwc.fake.vsync=false

# prop for nxmediaplayer set vo windowAttr(leter box or add_black_side)
# 0 extrude (mean lettbox in vo proc/msp/*)
# 1 add black side
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.video.cvrs=0

PRODUCT_PROPERTY_OVERRIDES += \
    prop.service.bootop.type=bootanim

PRODUCT_PROPERTY_OVERRIDES += \

    bootanim.pic.isfullscreen=true

PRODUCT_PROPERTY_OVERRIDES += \
   persist.sys.bootanim.delconfig=false

#for karaoke
PRODUCT_PROPERTY_OVERRIDES += \
    persist.karaoke.enable=true

#PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwcursor.fb=/dev/graphics/fb1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.prop.heaac.filter=false \
    ro.prop.mpeg4aac.filter=false
