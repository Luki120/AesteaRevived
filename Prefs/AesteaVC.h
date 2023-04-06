@import ObjectiveC.message;
@import Preferences.PSListController;
@import Preferences.PSSpecifier;
@import Preferences.PSTableCell;
@import AudioToolbox.AudioServices;
#import <spawn.h>
#import "Headers/Common.h"


@interface OBWelcomeController : UIViewController
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(NSInteger)arg1;
@end


@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
@end


@interface AesteaVC : PSListController
@end


@interface AesteaLinksVC : PSListController
@end


@interface AesteaContributorsVC : PSListController
@end

// Reusable

static void setNavBarTintColorForVC(UIViewController *self) {

	self.navigationController.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationController.navigationBar.barTintColor = kAESTintColor;

}

static void nilOutNavBarTintColorForVC(UIViewController *self) {

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}
