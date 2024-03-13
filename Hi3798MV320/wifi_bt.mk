# chip version
BOARD_HAVE_BLUETOOTH_CHIP_VERSION := Hi3798MV320

# ---------------------------------------------------------------------------------
# Enable WiFi or Bluetooth or WiFi+Bluetooth module used in the board.
# Supported modules:
#   RealTek RTL8761BTV (only BT)
#   RealTek RTL8822CS (11ac 2x2 2.4G+5G)(Supported mode: STA, AP, WiFi Direct And BT)
# HI_WIFI_SUPPORT: Whether the module supports wifi
# HI_BLUETOOTH_ANDROID_SUPPORT: Whether the module supports bluetooth
# HI_SDIO_DETECT_SUPPORT: Whether the module supports sdio_detect
# *******Attention:*************
# PCIE device, bluetooth can not use realtek driver
# SDIO device, bluetooth can not use realtek driver
# ******************************
# BOARD_WIFI_VENDOR: What type of vendor is used, you can find its usage in the file
# BOARD_BLUETOOTH_DEVICE_REALTEK: Whether it is realtek's Bluetooth,if it’s not realtek, don’t need to add
# BOARD_HAVE_BLUETOOTH_RTK_IF: Bluetooth interface type of the module(uart,usb),if it’s not realtek, don’t need to add
# BOARD_HAVE_BLUETOOTH_RTK_COEX: Not used temporarily,default true,if it’s not realtek, don’t need to add
# ---------------------------------------------------------------------------------

#RTL8822CS
BOARD_WIFI_BLUETOOTH_DEVICE_RTL8822CS := y
# RTL8761BTV
BOARD_BLUETOOTH_DEVICE_RTL8761BTV := y

ifeq ($(strip $(BOARD_WIFI_BLUETOOTH_DEVICE_RTL8822CS)),y)
HI_WIFI_SUPPORT := y
HI_BLUETOOTH_ANDROID_SUPPORT := y
# setup gpio suspend for ir_user
BOARD_GPIO_BLUETOOTH_SUSPEND := 0x2c
endif

ifeq ($(strip $(BOARD_BLUETOOTH_DEVICE_RTL8761BTV)),y)
HI_BLUETOOTH_ANDROID_SUPPORT := y
endif
ifeq ($(strip $(HI_WIFI_SUPPORT)),y)
# wpa_supplicant config, default use BCM
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := HI_WIFI_DYNAMIC
endif

ifeq ($(strip $(HI_BLUETOOTH_ANDROID_SUPPORT)),y)
# BroadCom Bluetooth
BOARD_HAVE_BLUETOOTH_BCM := y

# Realtek Bluetooth
HI_SDIO_DETECT_SUPPORT := y
BOARD_BLUETOOTH_DEVICE_REALTEK := y
BOARD_HAVE_BLUETOOTH_RTK := true
$(call inherit-product, $(HIVENDOR_PLATFORM_PATH)/system/bluetooth/rtkbt/rtkbt.mk)
endif
