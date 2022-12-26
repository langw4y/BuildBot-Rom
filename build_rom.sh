# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CipherOS/android_manifest.git -b twelve-L -g default,-mips,-darwin,-notdefault
git clone https://github.com/kitw4y/local_manifest.git --depth 1 -b cipher .repo/local_manifests
repo sync --force-sync --no-clone-bundle --current-branch --no-tags -j$(nproc --all)

# build rom 1
source build/envsetup.sh
lunch cipher_lancelot-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build command
mka bacon -j

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
