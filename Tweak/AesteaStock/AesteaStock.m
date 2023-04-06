#import "Headers/Headers.h"


static void new_setToggleColors(CCUIRoundButton *self, SEL _cmd) {

	loadPrefs();

	UIViewController *ancestor = [self _viewControllerForAncestor];
	if([ancestor isKindOfClass: NSClassFromString(@"CCUIConnectivityAirplaneViewController")]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"airplaneColor" fallback:@"ff9f0a"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemOrangeColor;

		if(colorAirplaneDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offAirplaneColor" fallback:@"147efb"];	

		else self.normalStateBackgroundView.backgroundColor = nil;

	}

	else if([ancestor isKindOfClass: NSClassFromString(@"CCUIConnectivityCellularDataViewController")]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"cellularColor" fallback:@"30d158"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemGreenColor;

		if(colorCellularDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offCellularColor" fallback:@"147efb"];

		else self.normalStateBackgroundView.backgroundColor = nil;


	}

	else if([ancestor isKindOfClass: NSClassFromString(@"CCUIConnectivityWifiViewController")]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"wifiColor" fallback:@"147efb"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

		if(colorWiFiDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offWiFiColor" fallback:@"147efb"];

		else self.normalStateBackgroundView.backgroundColor = nil;

	}

	else if([ancestor isKindOfClass: NSClassFromString(@"CCUIConnectivityBluetoothViewController")]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bluetoothColor" fallback:@"147efb"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

		if(colorBluetoothDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offBluetoothColor" fallback:@"147efb"];

		else self.normalStateBackgroundView.backgroundColor = nil;

	}

	else if([ancestor isKindOfClass: NSClassFromString(@"CCUIConnectivityAirDropViewController")]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"airdropColor" fallback:@"147efb"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

		if(colorAirdropDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offAirdropColor" fallback:@"147efb"];

		else self.normalStateBackgroundView.backgroundColor = nil;

	}

	else if([ancestor isKindOfClass: NSClassFromString(@"CCUIConnectivityHotspotViewController")]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"hotspotColor" fallback:@"147efb"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

		if(colorHotspotDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offHotspotColor" fallback:@"147efb"];

		else self.normalStateBackgroundView.backgroundColor = nil;

	}

}

static void (*origDMTW)(CCUIRoundButton *, SEL);
static void overrideDMTW(CCUIRoundButton *self, SEL _cmd) {

	origDMTW(self, _cmd);
	[self setToggleColors];

	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(setToggleColors) name:AesteaDidApplyToggleColorsNotification object:nil];

}

// Credits to the original creator of the tweak ⇝ https://github.com/jakeajames/RealCC

static void (*origButtonTapped)(CCUILabeledRoundButton *, SEL, id);
static void overrideButtonTapped(CCUILabeledRoundButton *self, SEL _cmd, id button) {

	origButtonTapped(self, _cmd, button);

	if([self.title isEqualToString:[[NSBundle bundleWithPath: @"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey: @"CONTROL_CENTER_STATUS_WIFI_NAME" value:@"CONTROL_CENTER_STATUS_WIFI_NAME" table:@"Localizable"]] 
		|| [self.title isEqualToString:[[NSBundle bundleWithPath: @"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey: @"CONTROL_CENTER_STATUS_WLAN_NAME" value:@"CONTROL_CENTER_STATUS_WLAN_NAME" table:@"Localizable"]]) {

			SBWiFiManager *wifiManager = [NSClassFromString(@"SBWiFiManager") sharedInstance];

		if([wifiManager wiFiEnabled]) [wifiManager setWiFiEnabled: NO];

	}

	if([self.title isEqualToString: [[NSBundle bundleWithPath: @"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey: @"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" value: @"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" table: @"Localizable"]]) {

		BluetoothManager *bluetoothManager = [NSClassFromString(@"BluetoothManager") sharedInstance];

		BOOL enabled = [bluetoothManager enabled];

		if(enabled) {

			[bluetoothManager setEnabled: NO];
			[bluetoothManager setPowered: NO];

			bluetoothEnabled = NO;

		}

		else bluetoothEnabled = YES;

	}

}

static BOOL (*origEnabled)(BluetoothManager *, SEL);
static BOOL overrideEnabled(BluetoothManager *self, SEL _cmd) {

	bluetoothEnabled = !origEnabled(self, _cmd);
	return origEnabled(self, _cmd);

}

static BOOL (*origSetEnabled)(BluetoothManager *, SEL, BOOL);
static BOOL overrideSetEnabled(BluetoothManager *self, SEL _cmd, BOOL enabled) {

	return origSetEnabled(self, _cmd, bluetoothEnabled);

}

static BOOL (*origSetPowered)(BluetoothManager *, SEL, BOOL);
static BOOL overrideSetPowered(BluetoothManager *self, SEL _cmd, BOOL powered) {

	return origSetPowered(self, _cmd, bluetoothEnabled);

}

__attribute__((constructor)) static void init() {

	MSHookMessageEx(NSClassFromString(@"CCUIRoundButton"), @selector(didMoveToWindow), (IMP) &overrideDMTW, (IMP *) &origDMTW);
	MSHookMessageEx(NSClassFromString(@"CCUILabeledRoundButton"), @selector(buttonTapped:), (IMP) &overrideButtonTapped, (IMP *) &origButtonTapped);
	MSHookMessageEx(NSClassFromString(@"BluetoothManager"), @selector(enabled), (IMP) &overrideEnabled, (IMP *) &origEnabled);
	MSHookMessageEx(NSClassFromString(@"BluetoothManager"), @selector(setEnabled:), (IMP) &overrideSetEnabled, (IMP *) &origSetEnabled);
	MSHookMessageEx(NSClassFromString(@"BluetoothManager"), @selector(setPowered:), (IMP) &overrideSetPowered, (IMP *) &origSetPowered);

	class_addMethod(
		NSClassFromString(@"CCUIRoundButton"),
		@selector(setToggleColors),
		(IMP) &new_setToggleColors,
		"v@:"
	);

}
