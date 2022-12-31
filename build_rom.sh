# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-20.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/kitw4y/device-new --depth 1 -b los device/xiaomi/lancelot
git clone https://github.com/kitw4y/android_device_xiaomi_mt6768-common --depth 1 -b lineage-20 device/xiaomi/mt6768-common 
git clone https://github.com/mt6768-dev/android_kernel_xiaomi_mt6768 --depth 1 -b  lineage-20 kernel/xiaomi/mt6768
git clone https://github.com/galang8664/vendor_xiaomi_lancelot.git vendor/xiaomi/lancelot
git clone https://github.com/galang8664/common-vendor.git vendor/xiaomi/mt6768-common
git clone https://github.com/xiaomi-mt6785-dev/android_hardware_mediatek.git hardware/mediatek
git clone https://github.com/kitw4y/ImsService --depth 1 -b lineage-20 packages/app/ImsService
git clone https://github.com/kitw4y/android_packages_apps_MtkFMRadio --depth 1 -b lineage-20 packages/apps/MtkFMRadio
git clone https://github.com/kitw4y/vendor_mediatek_opensource_interfaces --depth 1 -b lineage-20 vendor_mediatek_opensource_interfaces
git clone https://github.com/kitw4y/vendor_goodix_opensource_interfaces --depth 1 -b lineage-20 vendor/goodix/opensource/interfaces
git clone https://github.com/kitw4y/android_device_mediatek_sepolicy_vndr --depth 1 -b lineage-20 device/mediatek/sepolicy_vndr

# build rom 1
source build/envsetup.sh
breakfast lineage_lancelot-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build command
brunch lancelot

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
