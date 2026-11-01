#!/system/bin/sh
mkdir -p /tmp/t6_twrp /tmp/tee_twrp
cp -rfp /mnt/vendor/persist/t6/. /tmp/t6_twrp/ 2>/dev/null
cp -rfp /mnt/vendor/protect_f/tee/. /tmp/tee_twrp/ 2>/dev/null
chown -R system:system /tmp/t6_twrp /tmp/tee_twrp
exit 0
