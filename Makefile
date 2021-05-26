export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:latest

DEBUG = O
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += Tweak Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"