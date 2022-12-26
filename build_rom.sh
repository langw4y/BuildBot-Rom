# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CipherOS/android_manifest.git -b twelve-L -g default,-mips,-darwin,-notdefault
repo sync --force-sync --no-clone-bundle --current-branch --no-tags -j$(nproc --all)
git clone https://github.com/kitw4y/device-new --depth 1 -b cipher device/xiaomi/lancelot
git clone https://github.com/kitw4y/android_device_xiaomi_mt6768-common --depth 1 -b lineage-20 device/xiaomi/mt6768-common 
git clone https://github.com/mt6768-dev/android_kernel_xiaomi_mt6768 --depth 1 -b  lineage-20 kernel/xiaomi/mt6768
git clone https://github.com/kitw4y/vendor_xiaomi --depth 1 -b TwistedScarlett vendor/xiaomi
git clone https://github.com/kitw4y/android_hardware_mediatek --depth 1 -b lineage-20 hardware/mediatek
git clone https://github.com/kitw4y/ImsService --depth 1 -b lineage-20 packages/app/ImsService
git clone https://github.com/kitw4y/android_packages_apps_MtkFMRadio --depth 1 -b lineage-20 packages/apps/MtkFMRadio
git clone https://github.com/kitw4y/vendor_mediatek_opensource_interfaces --depth 1 -b lineage-20 vendor_mediatek_opensource_interfaces
git clone https://github.com/kitw4y/vendor_goodix_opensource_interfaces --depth 1 -b lineage-20 vendor/goodix/opensource/interfaces
git clone https://github.com/kitw4y/android_device_mediatek_sepolicy_vnd --depth 1 -b lineage-20 device/mediatek/sepolicy_vndr

# build rom 1
source build/envsetup.sh
lunch cipher_lancelot-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build command
mka bacon -j

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
