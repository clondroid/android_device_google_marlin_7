#
# Copyright (C) 2016 The Android Open-Source Project
# Copyright (C) 2015-2017 The Android Container Open Source Project
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

# Container specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    service.adb.tcp.port=5555 \
    ro.boot.container.id=1 \
    debug.sf.nobootanimation=1

# fstab.marlin has been identified in aosp_marlin_con.mk
PRODUCT_COPY_FILES += \
    vendor/icl/marlin/proprietary/config/init.marlin.con.rc:root/init.marlin.rc:icl  \
    device/google/marlin/init.common.usb.rc:root/init.marlin.usb.rc \
    vendor/icl/marlin/proprietary/config/ueventd.marlin.con.rc:root/ueventd.marlin.rc:icl \
    device/google/marlin/init.recovery.common.rc:root/init.recovery.marlin.rc

# Container init.rc, overide init.rc copied from system/core/rootdir/init.rc
PRODUCT_COPY_FILES += \
    vendor/icl/marlin/proprietary/config/init.con.rc:root/init.rc:icl

# Container overide origina rc in system/etc/init
PRODUCT_COPY_FILES += \
    vendor/icl/marlin/proprietary/config/system/etc/init/keystore.rc:system/etc/init/keystore.rc:icl \
    vendor/icl/marlin/proprietary/config/system/etc/init/servicemanager.rc:system/etc/init/servicemanager.rc:icl \
    vendor/icl/marlin/proprietary/config/system/etc/init/surfaceflinger.rc:system/etc/init/surfaceflinger.rc:icl \
    vendor/icl/marlin/proprietary/config/system/etc/init/update_engine.rc:system/etc/init/update_engine.rc:icl \
    vendor/icl/marlin/proprietary/config/system/etc/init/audioserver.rc:system/etc/init/audioserver.rc:icl

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

