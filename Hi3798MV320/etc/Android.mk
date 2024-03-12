ifeq ($(strip $(CHIPNAME)),Hi3798MV320)
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := limitApplications.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/etc
LOCAL_SRC_FILES := limitApplications.xml
include $(BUILD_PREBUILT)
endif
