#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

#import "GcColorPickerUtils.h"


// Utils

HBPreferences* preferences;


// Prefs variables

BOOL enabled;
BOOL colorOnStateSwitch = YES;


static BOOL colorAirplaneDisabledState;
static BOOL colorCellularDisabledState;
static BOOL colorWiFiDisabledState;
static BOOL colorBluetoothDisabledState;
static BOOL colorAirdropDisabledState;
static BOOL colorHotspotDisabledState;


static BOOL bluetoothEnabled;
static BOOL reallyDisableTogglesOnTap;


UIViewController* ancestor;


// Colors

NSString* airplaneColor = @"ff9f0a";
NSString* cellularColor = @"30d158";
NSString* wifiColor = @"147efb";
NSString* bluetoothColor = @"147efb";
NSString* airdropColor = @"147efb";
NSString* hotspotColor = @"30d158";


NSString* offAirplaneColor = @"147efb";
NSString* offCellularColor = @"147efb";
NSString* offWiFiColor = @"147efb";
NSString* offBluetoothColor = @"147efb";
NSString* offAirdropColor = @"147efb";
NSString* offHotspotColor = @"147efb";


// Interfaces

@interface CCUIRoundButton : UIControl
@property (nonatomic, retain) UIView* normalStateBackgroundView; 
@property (nonatomic, retain) UIView* selectedStateBackgroundView;
- (id)_viewControllerForAncestor;
@end


@interface SBIconController : UIViewController
- (void)viewDidAppear:(BOOL)animated;
@end


@interface CCUILabeledRoundButton
@property(nonatomic, copy, readwrite) NSString *title;
@end


@interface SBWiFiManager
- (id)sharedInstance;
- (void)setWiFiEnabled: (BOOL)enabled;
- (bool)wiFiEnabled;
@end


@interface BluetoothManager
- (id)sharedInstance;
- (void)setEnabled: (BOOL)enabled;
- (bool)enabled;
- (void)setPowered: (BOOL)powered;
- (bool)powered;
@end