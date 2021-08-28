export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:latest

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += Tweak Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"