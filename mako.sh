#!/bin/bash

# Add Colors to unhappiness
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

clear

# Piasek Kernel Version
BASE_SAND_VER="Piasek-KK"
VER=".v8"
SAND_VER=$BASE_SAND_VER$VER

# Piasek Variables
export LOCALVERSION="~"`echo $SAND_VER`
export CROSS_COMPILE=${HOME}/android/linaro/bin/arm-linux-gnueabihf-
export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER=Piasek
export KBUILD_BUILD_HOST="kernel"

DATE_START=$(date +"%s")

echo
echo -e "${green}"
echo " Piasek Kernel Install:                   "
echo "__________ __                      __     "
echo "\______   \__|____    ______ ____ |  | __ "
echo " |     ___/  \__  \  /  ___// __ \|  |/ / "
echo " |    |   |  |/ __ \_\___\ \  ___/|    <  "
echo " |____|   |__(____  /____  >\___  >__|_ \ "
echo "                  \/     \/     \/     \/ "
echo -e "${restore}"
echo

echo -e "${green}"
echo "--------------------------"
echo "Show: Piasek Mako Settings"
echo "--------------------------"
echo -e "${restore}"

MODULES_DIR=${HOME}/android/zipmaker/cwm/system/lib/modules
KERNEL_DIR=`pwd`
OUTPUT_DIR=${HOME}/android/zipmaker/zip
CWM_DIR=${HOME}/android/zipmaker/cwm
ZIMAGE_DIR=${HOME}/android/Piasek-KK/arch/arm/boot
CWM_MOVE=/home/piasek/Pulpit/
ZIMAGE_ANYKERNEL=${HOME}/android/zipmaker/cwm/kernel
ANYKERNEL_DIR=${HOME}/android/zipmaker

echo -e "${red}"; echo "COMPILING VERSION:"; echo -e "${blink_red}"; echo "$LOCALVERSION"; echo -e "${restore}"
echo "CROSS_COMPILE="$CROSS_COMPILE
echo "ARCH="$ARCH
echo "MODULES_DIR="$MODULES_DIR
echo "KERNEL_DIR="$KERNEL_DIR
echo "OUTPUT_DIR="$OUTPUT_DIR
echo "CWM_DIR="$CWM_DIR
echo "ZIMAGE_DIR="$ZIMAGE_DIR
echo "CWM_MOVE="$CWM_MOVE
echo "ZIMAGE_ANYKERNEL="$ZIMAGE_ANYKERNEL
echo "ANYKERNEL_DIR="$ANYKERNEL_DIR

echo -e "${green}"
echo "-------------------------"
echo "Making: Piasek Mako Defconfig"
echo "-------------------------"
echo -e "${restore}"

make "mako_defconfig"
#make -j3 > /dev/null
make -j4

echo -e "${green}"
echo "-------------------------"
echo "Create: Piasek Kernel and Zip"
echo "-------------------------"
echo -e "${restore}"

rm `echo $MODULES_DIR"/*"`
find $KERNEL_DIR -name '*.ko' -exec cp -v {} $MODULES_DIR \;
echo

cp -vr $ZIMAGE_DIR/zImage $ZIMAGE_ANYKERNEL
echo

cd $CWM_DIR
zip -r `echo $SAND_VER`.zip *
mv  `echo $SAND_VER`.zip $OUTPUT_DIR

echo -e "${green}"
echo "-------------------------"
echo "The End: AK is Born"
echo "-------------------------"
echo -e "${restore}"

cp -vr $OUTPUT_DIR/`echo $SAND_VER`.zip $CWM_MOVE
echo

cd $ANYKERNEL_DIR
echo
cd $KERNEL_DIR

echo -e "${green}"
echo "-------------------------"
echo "Build Completed in:"
echo "-------------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo
