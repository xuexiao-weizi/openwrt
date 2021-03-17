#!/bin/bash

#sudo wget https://github.com/hibuddies/openwrt/releases/download/AFILES/mk_openwrt_src_20201028.tar.gz
#sudo wget https://github.com/hibuddies/openwrt/releases/download/AFILES/Armbian_20.10_Aml-s9xxx_buster_5.9.2-flippy-47+.img.xz
#sudo wget https://github.com/hibuddies/openwrt/releases/download/AFILES/Armbian_20.10_Aml-s9xxx_buster_5.4.73-flippy-47+o.img.xz
#sudo wget https://github.com/hibuddies/openwrt/releases/download/AFILES/Armbian_20.10_Beikeyun_buster_5.4.73-flippy-47+o.img.xz

wget $(curl -s https://api.github.com/repos/hibuddies/openwrt/releases/35535623 | grep browser_download_url | cut -d '"' -f 4)

