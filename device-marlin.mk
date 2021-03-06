#
# Copyright (C) 2016 The Android Open-Source Project
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

# This file includes all definitions that apply to ALL marlin devices
#
# Everything in this directory will become public

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 560dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

## Kernel build from source
PRODUCT_OUT := out/target/product/marlin
TARGET_OUT_INTERMEDIATES := ${PRODUCT_OUT}/obj
KERNEL_DEFCONFIG := marlincon_defconfig
KERNEL_SRC_DIR := kernel
KERNEL_CFG_NAME := marlin
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android- 
TARGET_KERNEL_APPEND_DTB := true

-include kernel/AndroidKernel.mk

# Check for availability of kernel source
ifneq ($(wildcard $(KERNEL_SRC_DIR)/Makefile),)
  # Give precedence to TARGET_PREBUILT_KERNEL
  ifeq ($(TARGET_PREBUILT_KERNEL),)
    TARGET_KERNEL_BUILT_FROM_SOURCE := true
  endif
endif

ifneq ($(TARGET_KERNEL_BUILT_FROM_SOURCE), true)
# Use prebuilt kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/google/marlin-kernel/Image.gz-dtb
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

endif #TARGET_KERNEL_BUILT_FROM_SOURCE


-include device/google/marlin/device-common.mk

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/google/marlin/marlin/overlay

# display
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=560

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.vc_call_vol_steps=7

# HWUI cache sizes
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.texture_cache_size=72 \
    ro.hwui.layer_cache_size=48 \
    ro.hwui.path_cache_size=32

PRODUCT_COPY_FILES += \
    vendor/icl/marlin/proprietary/config/init.marlin.host.rc:root/init.marlin.rc:icl \
    device/google/marlin/init.common.usb.rc:root/init.marlin.usb.rc \
    device/google/marlin/fstab.common:root/fstab.marlin \
    device/google/marlin/ueventd.common.rc:root/ueventd.marlin.rc \
    device/google/marlin/init.recovery.common.rc:root/init.recovery.marlin.rc

# Sensor hub init script
PRODUCT_COPY_FILES += \
    device/google/marlin/init.common.nanohub.rc:root/init.marlin.nanohub.rc

# Sensor packages
PRODUCT_PACKAGES += \
    sensors.marlin \
    activity_recognition.marlin

# NFC packages
PRODUCT_PACKAGES += \
    nfc_nci.marlin

PRODUCT_COPY_FILES += \
    device/google/marlin/nfc/libnfc-nxp.marlin.conf:system/etc/libnfc-nxp.conf

# Led packages
PRODUCT_PACKAGES += \
    lights.marlin

# Thermal packages
PRODUCT_PACKAGES += \
    thermal.marlin

# VR packages
PRODUCT_PACKAGES += \
    vr.marlin
