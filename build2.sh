#!/bin/bash

function tg_sendText() {
curl -s "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d "parse_mode=html" \
-d text="${1}" \
-d chat_id=$CHAT_ID \
-d "disable_web_page_preview=true"
}

function tg_sendFile() {
curl -F chat_id=$CHAT_ID -F document=@${1} -F parse_mode=markdown https://api.telegram.org/bot$BOT_TOKEN/sendDocument
}

cd /tmp/rom # Depends on where source got synced

tg_sendText "Lunching"
# Normal build steps
. build/envsetup.sh
lunch evolution_lancelot-userdebug
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 20G # It took less than 6 GB for less than 2 hours in 2 builds for Samsung A10
ccache -o compression=true # Will save times and data to download and upload ccache, also negligible performance issue
ccache -z

tg_sendText "Starting Compilation.."

# Compilation by parts if you get RAM issue but takes nore time!
#mka api-stubs-docs -j8
#mka system-api-stubs-docs -j8
#mka test-api-stubs-docs -j8
#mka bacon -j8 | tee build.txt

make bacon -j28 | tee build.txt

(ccache -s && echo '' && free -h && echo '' && df -h && echo '' && ls -a out/target/product/a20e/) | tee final_monitor.txt
sleep 1s
tg_sendFile "final_monitor.txt"
sleep 2s
tg_sendFile "build.txt"
