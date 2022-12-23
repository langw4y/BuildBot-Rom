# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/galang8664/local_manifest.git --depth 1 -b evoxr .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j 30 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j 8

# build rom
source build/envsetup.sh
lunch evolution_lancelot-userdebug
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 20G
ccache -o compression=true
ccache -z 
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Dhaka
mka bacon -j10

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
