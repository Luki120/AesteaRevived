ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:latest
FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AesteaRevived
$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei
$(TWEAK_NAME)_LIBRARIES = sparkcolourpicker

include $(THEOS_MAKE_PATH)/tweak.mk


after-install::
	install.exec "sbreload"
	
	export THEOS_DEVICE_IP = 192.168.0.7	

