#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#

# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.1.3/g' package/base-files/files/bin/config_generate

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenWrt'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（281677160 build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i "s/OpenWrt /SunnyMan build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 增加带WiFi驱动，emmc写入和NTFS格式优盘挂载
packages=" \
brcmfmac-firmware-43430-sdio brcmfmac-firmware-43455-sdio kmod-brcmfmac wpad acl attr kmod-usb-hid kmod-mmc-spi \
kmod-sdhci dumpe2fs e2freefrag f2fs-tools fuse-utils lsattr mkhfs nfs-utils nfs-utils-libs squashfs-tools-mksquashfs \
squashfs-tools-unsquashfs swap-utils bash kmod-fs-ext4 kmod-fs-vfat kmod-fs-exfat dosfstools e2fsprogs ntfs-3g-utils \
badblocks usbutils kmod-usb-ohci-pci kmod-usb-uhci kmod-usb2-pci kmod-usb3 kmod-usb-storage-extras kmod-usb-storage-uas \
kmod-usb-net kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8150 kmod-usb-net-rtl8152 autocore-arm \
blkid lsblk parted fdisk cfdisk losetup tar gawk getopt perl perlbase-utf8 resize2fs tune2fs pv unzip \
lscpu htop iperf3 curl lm-sensors install-program 
"
sed -i '/FEATURES+=/ { s/cpiogz //; s/ext4 //; s/ramdisk //; s/squashfs //; }' \
    target/linux/armvirt/Makefile
for x in $packages; do
    sed -i "/DEFAULT_PACKAGES/ s/$/ $x/" target/linux/armvirt/Makefile
done

rm -f package/lean/shadowsocksr-libev/patches/0002-Revert-verify_simple-and-auth_simple.patch
sed -i '383,393 d' package/lean/shadowsocksr-libev/patches/0001-Add-ss-server-and-ss-check.patch
sed -i 's/PKG_RELEASE:=5/PKG_RELEASE:=6/' package/lean/shadowsocksr-libev/Makefile
sed -i '/PKG_SOURCE_VERSION:=/d' package/lean/shadowsocksr-libev/Makefile
sed -i '/PKG_SOURCE_URL/a PKG_SOURCE_VERSION:=4799b312b8244ec067b8ae9ba4b85c877858976c' \
    package/lean/shadowsocksr-libev/Makefile

