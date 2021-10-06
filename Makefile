export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:latest

SUBPROJECTS += Tweak/AesteaAkara Tweak/AesteaBSC Tweak/AesteaStock Prefs

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"