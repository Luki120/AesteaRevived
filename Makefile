export TARGET = iphone:clang:latest:latest

INSTALL_TARGET_PROCESSES = SpringBoard

SUBPROJECTS += Tweak/AesteaAkara Tweak/AesteaBSC Tweak/AesteaPrysm Tweak/AesteaStock Prefs

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
