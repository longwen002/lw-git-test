
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

#apploader config
#true: build system with loader
#false: build system with recovery
TARGET_HAVE_APPLOADER := false

# kernel devmem config
KERNEL_CONFIG_DEVMEM := false

# recovery graphic parameter
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

#Product usage selection, possible values are: shcmcc/telecom/aosp/demo
#shcmcc stands for the ShangHai Mobile video base mode.
#telecom stands for the China iptv and cable  centralized procurement mode.
#aosp stands for android ott and oversea project
#Please modify here before compilation
PRODUCT_TARGET := aosp

# setup iptv common feature
HI_IPTV_FEATURE := false

HI_TELECOM_IPTV_FEATURE := false
HI_CMCC_IPTV_FEATURE := true
# telecom iptv feature(HI_TELECOM_IPTV_FEATURE) is based on iptv common feature(HI_IPTV_FEATURE)
ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)),true)
HI_IPTV_FEATURE := true
PRODUCT_TARGET := telecom
else ifeq ($(strip $(HI_CMCC_IPTV_FEATURE)),true)
HI_IPTV_FEATURE := true
PRODUCT_TARGET := shcmcc
endif

# setup kpi feature
HI_KPI_OPTIMIZE := false


PQ_TYPE := default
ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)),true)
PQ_TYPE := telecom
endif
ifeq ($(strip $(HI_CMCC_IPTV_FEATURE)),true)
PQ_TYPE := cmcc
endif

#Setup SecurityL1
HI_SECURITY_L1 := false

#Setup SecurityL2
HI_SECURITY_L2 := false

#setup android target arch, such as, 32only/64kernel/32prefer/64prefer
HI_TARGET_ARCH_SUPPORT := 32only

#Verimatrix Advanced support
#setup android tee
HI_TEE := false

SUPPORT_REMOTE_RECOVERY := true
# telecom no this feature
ifeq ($(strip $(HI_KPI_OPTIMIZE)),true)
	ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)),true)
	SUPPORT_REMOTE_RECOVERY := false
	endif
endif
# enable TIF
HI_ENABLE_TIF := true

# A/B update
#AB system update config
AB_PARTITION_SUPPORT := false
AB_UPGRADER_SUPPORT := true
#AVB configure
BOARD_AVB_ENABLE := false

ifeq ($(strip $(TARGET_BUILD_VARIANT)), user)
BOARD_AVB_ENABLE := true
else ifeq ($(strip $(TARGET_BUILD_VARIANT)), userdebug)
BOARD_AVB_ENABLE := true
endif

HI_NSV_SUPPORT := false
ifeq ($(strip $(HI_NSV_SUPPORT)), true)
BOARD_AVB_ENABLE := true
endif

ifeq ($(strip $(BOARD_AVB_ENABLE)), true)
RECOVERY_SUPPORT_AVB := true
endif

$(shell rm -f $(OUT_DIR)/avb.flag)
ifeq ($(strip $(BOARD_AVB_ENABLE)), true)
$(shell touch $(OUT_DIR)/avb.flag)
endif

ifeq ($(strip $(AB_UPGRADER_SUPPORT)), true)
AB_OTA_UPDATER := $(AB_PARTITION_SUPPORT)
#create avbsupport file for python
ifeq ($(strip $(BOARD_AVB_ENABLE)), true)
$(shell touch build/tools/releasetools/avbsupport)
else
$(shell rm -rf build/tools/releasetools/avbsupport)
endif
endif

ifeq ($(SUPPORT_ANDROIDTV), true)
HI_TEE := false
endif

ifeq ($(strip $(HI_TEE)),true)
HI_SECURITY_L2 := false
endif

# Security
ifeq ($(HI_SECURITY_L1),true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hs.security.l1.enable=$(HI_SECURITY_L1)
ifneq (,$(wildcard $(CHIPNAME_DIR)/security/releasekey.x509.pem))
ifneq (,$(wildcard $(CHIPNAME_DIR)/security/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := \
    $(CHIPNAME_DIR)/security/releasekey
else
$(warning $(CHIPNAME_DIR)/security/releasekey.pk8 does not exist!)
endif
else
$(warning $(CHIPNAME_DIR)/security/releasekey.x509.pem does not exist!)
endif
endif

ifeq ($(strip $(HI_SECURITY_L2)),true)
PRODUCT_DEFAULT_DEV_CERTIFICATE := \
    $(CHIPNAME_DIR)/security/releasekey
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hs.security.l1.enable=true
HI_SECURITY_L2_SYSTEM_CHECK := false
endif

ifeq ($(strip $(HI_TEE)),true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.media.hp.drm.tee=true \
    ro.media.hp.drm.tee=true \
    ro.media.hp.drm.playready=true
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.media.hp.drm.tee=false \
    ro.media.hp.drm.playready=false
endif

PRODUCT_PROPERTY_OVERRIDES += \
ro.sys.apkcontrol.mode=none

#network stream output of nxplayer. sideband, overlay.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.media.np.output=sideband
#nxplayer cache config,low cache 200 ms
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.media.np.cache.low=200
#nxplayer cache config,high cache 5 s
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.media.np.cache.high=5300
#nxplayer cache config,max cache size 80M
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.media.np.cache.maxsize=80

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.media.hp.softdetect.name=mobile

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.media.np.hls.live.start=0

PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.media.np.set.connectid=true
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.media.np.perform.reconnmod=0

#default value false mean dhcp is work,true means suying is work
PRODUCT_PROPERTY_OVERRIDES += \
    ro.thirdparty.dhcp=false

# smart_suspend, deep_launcher, deep_restart, deep_resume;
ifeq ($(strip $(HI_TELECOM_IPTV_FEATURE)),true)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.suspend.mode=deep_launcher \
    persist.sys.media.uvmos=true \
    persist.prop.standby.longpress=false \
    persist.prop.music.supportpic=true \
    persist.prop.suspend.dialog=false
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.suspend.mode=deep_restart \
    persist.prop.standby.longpress=true \
    persist.prop.music.supportpic=false \
    persist.prop.suspend.dialog=true
endif

PRODUCT_PROPERTY_OVERRIDES += \
    persist.low_ram.wp.enable=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hdmi.device_type=4

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hdmi.wake_on_hotplug=false

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.adoptable=force_on \
    ro.vold.primary_physical=false
#   fw.disable_quota=true

# MediaScanner
PRODUCT_PROPERTY_OVERRIDES += \
    ro.mediaScanner.enable=false


#for karaoke
PRODUCT_PROPERTY_OVERRIDES += \
    persist.karaoke.enable=true


# Whether fastplay should be played completely or not: true or false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.fastplay.fullyplay=false

# Whether bootanimation should be played or not: true or false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.bootanim.enable=true

# Whether bootanimation use system or base vol: true use system, false use base
PRODUCT_PROPERTY_OVERRIDES += \
	persist.animation.use.sysvolume=false
PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.audio.volume=42
# Whether bootanimation can be adjust vol or not:true or false
PRODUCT_PROPERTY_OVERRIDES += \
	persist.animation.volume.adjust=false

# Whether write suspend state when smart suspend or not: true or false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.suspend.state=false

# Whether wakeup when cec resume or not: true or false
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cec.hardware=false

# HIVENDOR add begin
# wifi check internet,according to the systemproperty of "persist.wifi.checkinternet"
# to determin check internet access or not, false as defaul
# true->check internet access, false->do not check internet access
PRODUCT_PROPERTY_OVERRIDES += \
    persist.wifi.checkinternet=false
# HIVENDOR add end
# HIVENDOR add begin
# disalbe surfaceflinger backpressure flag In order to
# avoid HWC2.0 maybe not signaled release fence yet.
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.disable_backpressure = 1
#HIVENDOR add end

# HIVENDOR add begin
# config frame buffer number to 3.
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
# HIVENDOR add end

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hi.product = ${CHIPNAME}

#for STB send cec standby msg not rely on the active source msg that tv feedback.
#because there is a big difference betweewn difference tv on this msg
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.hdmi.keep_awake = false

#the chip not surrport compress
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.graph.gfx2d_compress = false

# HIVENDOR add begin
# The number of fb buffers
PRODUCT_PROPERTY_OVERRIDES += \
    ro.audio.flinger_standbytime_ms = 1000 \
    ro.gpu.num_fb_buffers = 3
#HIVENDOR add end

# setup iptv feature
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.feature = iptv
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.optlevel=3 \
    persist.unlock.opt=true \
    persist.bootopt.app.ds=true
# sf latch buffer not wait fence signaled
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.latch_unsignaled=1
# update priority ACTION_BOOT_COMPLETED receiver for com.shcmcc.setting
ifeq ($(strip $(HI_CMCC_IPTV_FEATURE)),true)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.broadcast.opt=false
endif

ifeq ($(strip $(HI_IPTV_FEATURE)),true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.media.timeshift=0 \
    ro.media.dolby=0 \
    ro.media.maxresolution=0 \
    ro.flash.size=8G \
    ro.memory.size=2G \
    sys.settings.support.net.flags=7 \
    sys.settings.support.ap.flags=0 \
    sys.settings.support.bluetooth=1 \
    sys.deepdiagnose.support=1 \
    sys.settings.support.spdif=0 \
    persist.sys.language=ZH \
    persist.sys.country=CN \
    sys.settings.suspport.languages=zh-CN \
    ro.product.locale.language=zh \
    ro.product.locale.region=CN \
    persist.prop.hdcp.hdcp2x=true
endif

ifeq ($(strip $(HI_KPI_OPTIMIZE)),true)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.key.opt=true \
    persist.sys.defwallpaper.disable=true \
    persist.vendor.media.np.tcp.rwimeout=2000 \
    persist.window_anim.opt=true \
    persist.hdmi.fmtdelaytime=250 \
    persist.antutu.opt=true \
    persist.softAP.opt=true \
    persist.sys.aync.callback=true \
    persist.bestv.opt=true \
    persist.sys.media.np.softdetect.async=true \
    persist.vendor.media.np.async.destroy=true \
    persist.sys.media.uvmos=false \
    persist.vendor.media.np.first.bypass=true \
    persist.vendor.media.np.kpi.needwh=false \
    persist.vendor.media.np.switch.black=false \
    persist.vendor.media.np.kpi.qsall=false \
    persist.vendor.media.np.kpi.qsnet=true \
    persist.vendor.media.np.preloads=true \
    ro.audio.flinger_standbytime_ms = 1000 \
    persist.sf.rebuildlayer.optimize=true \
    persist.decodeallocator.optimize=true \
    debug.hwui.renderer=opengl
endif

ifeq ($(strip $(PRODUCT_TARGET)),telecom)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.custom.settings=com.android.smart.terminal.settings
else ifeq ($(strip $(PRODUCT_TARGET)),shcmcc)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.custom.settings=android.settings.chinamobile.SETTINGS
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.prop.custom.settings=android.settings.SETTINGS
endif
