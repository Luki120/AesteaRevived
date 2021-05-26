include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = AesteaPrefs

AesteaPrefs_FILES = AESAppearanceSettings.m AESRootListController.m AESContributorsRootListController.m
AesteaPrefs_CFLAGS = -fobjc-arc
AesteaPrefs_FRAMEWORKS = UIKit
AesteaPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
AesteaPrefs_PRIVATE_FRAMEWORKS = Preferences
AesteaPrefs_INSTALL_PATH = /Library/PreferenceBundles

include $(THEOS_MAKE_PATH)/bundle.mk