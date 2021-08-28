@import UIKit;
#import "GcColorPickerUtils.h"


// Prefs variables

static BOOL colorOnState = YES;


static BOOL colorAirplaneDisabledState;
static BOOL colorCellularDisabledState;
static BOOL colorWiFiDisabledState;
static BOOL colorBluetoothDisabledState;
static BOOL colorAirdropDisabledState;
static BOOL colorHotspotDisabledState;


static BOOL bluetoothEnabled;
static BOOL reallyDisableTogglesOnTap;


UIViewController *ancestor;


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.aestearevivedprefs.plist";


static void loadPrefs() {


	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefsKeys];
	NSMutableDictionary *prefs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	colorOnState = prefs[@"colorOnState"] ? [prefs[@"colorOnState"] boolValue] : YES;
	colorAirplaneDisabledState = prefs[@"colorAirplaneDisabledState"] ? [prefs[@"colorAirplaneDisabledState"] boolValue] : NO;
	colorCellularDisabledState = prefs[@"colorCellularDisabledState"] ? [prefs[@"colorCellularDisabledState"] boolValue] : NO;
	colorWiFiDisabledState = prefs[@"colorWiFiDisabledState"] ? [prefs[@"colorWiFiDisabledState"] boolValue] : NO;
	colorBluetoothDisabledState = prefs[@"colorBluetoothDisabledState"] ? [prefs[@"colorBluetoothDisabledState"] boolValue] : NO;
	colorAirdropDisabledState = prefs[@"colorAirdropDisabledState"] ? [prefs[@"colorAirdropDisabledState"] boolValue] : NO;
	colorHotspotDisabledState = prefs[@"colorHotspotDisabledState"] ? [prefs[@"colorHotspotDisabledState"] boolValue] : NO;


}


// Interfaces


@interface CCUIRoundButton : UIView
@property (nonatomic, strong) UIView *normalStateBackgroundView; 
@property (nonatomic, strong) UIView *selectedStateBackgroundView;
- (void)setToggleColors;
- (id)_viewControllerForAncestor;
@end


@interface CCUILabeledRoundButton
@property (nonatomic, copy, readwrite) NSString *title;
@end


@interface SBWiFiManager
- (id)sharedInstance;
- (void)setWiFiEnabled:(BOOL)enabled;
- (bool)wiFiEnabled;
@end


@interface BluetoothManager
- (id)sharedInstance;
- (void)setEnabled:(BOOL)enabled;
- (bool)enabled;
- (void)setPowered:(BOOL)powered;
- (bool)powered;
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end