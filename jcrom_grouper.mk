#
# Copyright 2013 The Android Open-Source Project
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

# Inherit from those products. Most specific first.
$(call inherit-product, device/asus/grouper/device.mk)
# This is where we'd set a backup provider if we had one
#$(call inherit-product, device/sample/products/backup_overlay.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=nakasi BUILD_FINGERPRINT=google/nakasi/grouper:5.0.2/LRX22G/1649326:user/release-keys PRIVATE_BUILD_DESC="nakasi-user 5.0.2 LRX22G 1649326 release-keys"

# Discard inherited values and use our own instead.
PRODUCT_NAME := jcrom_grouper
PRODUCT_DEVICE := grouper
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 7
PRODUCT_MANUFACTURER := asus

#JCROM
$(call inherit-product, jcrom/asus/grouper/device-grouper.mk)
$(call inherit-product, jcrom/common/common.mk)
