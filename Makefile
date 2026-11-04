TARGET := iphone:clang:7.0:3.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CellBarsX

CellBarsX_FILES = Tweak.x
CellBarsX_CFLAGS = -fobjc-arc -Wno-gcc-compat -isystem /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/6.0/include/

include $(THEOS_MAKE_PATH)/tweak.mk
