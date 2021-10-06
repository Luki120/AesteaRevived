@import UIKit;
#import <substrate.h>
#import "GcUniversal/GcColorPickerUtils.h"


// Aestea Akara


static BOOL akColorOnState = YES;

static BOOL akColorAirplaneDisabledState;
static BOOL akColorWiFiDisabledState;
static BOOL akColorBluetoothDisabledState;


// Aestea BSC


static BOOL bscColorOnState = YES;

static BOOL bscColorAirplaneOrCellularDisabledState;
static BOOL bscColorWiFiDisabledState;
static BOOL bscColorBluetoothDisabledState;


// Aestea Stock

static BOOL colorOnState = YES;

static BOOL colorAirplaneDisabledState;
static BOOL colorCellularDisabledState;
static BOOL colorWiFiDisabledState;
static BOOL colorBluetoothDisabledState;
static BOOL colorAirdropDisabledState;
static BOOL colorHotspotDisabledState;

static BOOL bluetoothEnabled;

UIViewController *ancestor;


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.aestearevivedprefs.plist";


static void loadPrefs() {


	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefsKeys];
	NSMutableDictionary *prefs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

	// Aestea Akara

	akColorOnState = prefs[@"akColorOnState"] ? [prefs[@"akColorOnState"] boolValue] : YES;
	akColorAirplaneDisabledState = prefs[@"akColorAirplaneDisabledState"] ? [prefs[@"akColorAirplaneDisabledState"] boolValue] : NO;
	akColorWiFiDisabledState = prefs[@"akColorWiFiDisabledState"] ? [prefs[@"akColorWiFiDisabledState"] boolValue] : NO;
	akColorBluetoothDisabledState = prefs[@"akColorBluetoothDisabledState"] ? [prefs[@"akColorBluetoothDisabledState"] boolValue] : NO;


	// Aestea BSC

	bscColorOnState = prefs[@"bscColorOnState"] ? [prefs[@"bscColorOnState"] boolValue] : YES;
	bscColorAirplaneOrCellularDisabledState = prefs[@"bscColorAirplaneOrCellularDisabledState"] ? [prefs[@"bscColorAirplaneOrCellularDisabledState"] boolValue] : NO;
	bscColorWiFiDisabledState = prefs[@"bscColorWiFiDisabledState"] ? [prefs[@"bscColorWiFiDisabledState"] boolValue] : NO;
	bscColorBluetoothDisabledState = prefs[@"bscColorBluetoothDisabledState"] ? [prefs[@"bscColorBluetoothDisabledState"] boolValue] : NO;


	// Aestea Stock

	colorOnState = prefs[@"colorOnState"] ? [prefs[@"colorOnState"] boolValue] : YES;
	colorAirplaneDisabledState = prefs[@"colorAirplaneDisabledState"] ? [prefs[@"colorAirplaneDisabledState"] boolValue] : NO;
	colorCellularDisabledState = prefs[@"colorCellularDisabledState"] ? [prefs[@"colorCellularDisabledState"] boolValue] : NO;
	colorWiFiDisabledState = prefs[@"colorWiFiDisabledState"] ? [prefs[@"colorWiFiDisabledState"] boolValue] : NO;
	colorBluetoothDisabledState = prefs[@"colorBluetoothDisabledState"] ? [prefs[@"colorBluetoothDisabledState"] boolValue] : NO;
	colorAirdropDisabledState = prefs[@"colorAirdropDisabledState"] ? [prefs[@"colorAirdropDisabledState"] boolValue] : NO;
	colorHotspotDisabledState = prefs[@"colorHotspotDisabledState"] ? [prefs[@"colorHotspotDisabledState"] boolValue] : NO;


}


// Aestea Akara


@interface MTMaterialView : UIView
@property (nonatomic, assign, readwrite) CGFloat weighting;
@end


@interface CCUIRoundButton : UIView
@property (nonatomic, strong) UIView *normalStateBackgroundView; 
@property (nonatomic, strong) UIView *selectedStateBackgroundView;
- (void)setToggleColors;
- (id)_viewControllerForAncestor;
@end


@interface AkaraConnectivityRoundButtonViewController : UIViewController
@property (nonatomic, strong, readwrite) NSString *buttonName;
@property (nonatomic, strong, readwrite) CCUIRoundButton *ccRoundButton;
@end


@interface SpringBoard : UIApplication
@end


// Aestea BSC


@interface SCButtonView : UIView
@property (nonatomic, strong, readwrite) UIColor *defaultColor;
@property (nonatomic, strong, readwrite) UIColor *selectedColor;
@end


@interface SCGroupedControlView : UIView
@property (nonatomic, assign, readwrite) NSInteger style;
@property (nonatomic, strong, readwrite) SCButtonView *buttonView;
@end


@interface SCGroupedControlsModuleViewController : UIViewController
@property (nonatomic, strong, readwrite) SCGroupedControlView *wifiControlView;
@property (nonatomic, strong, readwrite) SCGroupedControlView *bluetoothControlView;
@property (nonatomic, strong, readwrite) SCGroupedControlView *cellularControlView;
- (void)updateStates;
@end


// Aestea Stock


@interface CCUILabeledRoundButton
@property (copy, nonatomic, readwrite) NSString *title;
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
