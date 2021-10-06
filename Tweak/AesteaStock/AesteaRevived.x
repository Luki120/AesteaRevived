#import "../Headers/Headers.h"


%hook CCUIRoundButton


%new


- (void)setToggleColors {


	loadPrefs();

	UIViewController *ancestor = [self _viewControllerForAncestor];

	if([ancestor isKindOfClass: %c(CCUIConnectivityAirplaneViewController)]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"airplaneColor" fallback:@"ff9f0a"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemOrangeColor;

		if(colorAirplaneDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offAirplaneColor" fallback:@"147efb"];	

		else self.normalStateBackgroundView.backgroundColor = nil;

	}


	if([ancestor isKindOfClass: %c(CCUIConnectivityCellularDataViewController)]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"cellularColor" fallback:@"30d158"];

		if(colorCellularDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offCellularColor" fallback:@"147efb"];

	}


	if([ancestor isKindOfClass: %c(CCUIConnectivityWifiViewController)]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"wifiColor" fallback:@"147efb"];

		else self.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

		if(colorWiFiDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offWiFiColor" fallback:@"147efb"];

		else self.normalStateBackgroundView.backgroundColor = nil;

	}


	if([ancestor isKindOfClass: %c(CCUIConnectivityBluetoothViewController)]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bluetoothColor" fallback:@"147efb"];

		if(colorBluetoothDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offBluetoothColor" fallback:@"147efb"];

	}


	if([ancestor isKindOfClass: %c(CCUIConnectivityAirDropViewController)]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"airdropColor" fallback:@"147efb"];

		if(colorAirdropDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offAirdropColor" fallback:@"147efb"];

	}


	if([ancestor isKindOfClass: %c(CCUIConnectivityHotspotViewController)]) {

		if(colorOnState)

			self.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"hotspotColor" fallback:@"147efb"];

		if(colorHotspotDisabledState)

			self.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"offHotspotColor" fallback:@"147efb"];

	}

}


- (void)didMoveToWindow { // create a notification observer && call the function we need


	%orig;

	[self setToggleColors];

	[NSDistributedNotificationCenter.defaultCenter removeObserver:self];
	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(setToggleColors) name:@"toggleColorsApplied" object:nil];


}


%end




// Credits to the original creator of the tweak: https://github.com/jakeajames/RealCC


%hook CCUILabeledRoundButton


- (void)buttonTapped:(id)arg1 {


	%orig;

	if([self.title isEqualToString: [[NSBundle bundleWithPath: @"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey: @"CONTROL_CENTER_STATUS_WIFI_NAME" value: @"CONTROL_CENTER_STATUS_WIFI_NAME" table: @"Localizable"]] 
		|| [self.title isEqualToString: [[NSBundle bundleWithPath: @"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey: @"CONTROL_CENTER_STATUS_WLAN_NAME" value: @"CONTROL_CENTER_STATUS_WLAN_NAME" table: @"Localizable"]]) {
			
			SBWiFiManager *wifiManager = (SBWiFiManager*)[%c(SBWiFiManager) sharedInstance];
		
		if([wifiManager wiFiEnabled])
			
			[wifiManager setWiFiEnabled: NO];
		
	}

	if([self.title isEqualToString: [[NSBundle bundleWithPath: @"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey: @"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" value: @"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" table: @"Localizable"]]) {
			
		BluetoothManager *bluetoothManager = (BluetoothManager*)[%c(BluetoothManager) sharedInstance];

		BOOL enabled = [bluetoothManager enabled];

		if(enabled) {

			[bluetoothManager setEnabled: NO];
			[bluetoothManager setPowered: NO];

			bluetoothEnabled = NO;

		} else bluetoothEnabled = YES;

	}
	
}

%end




%hook BluetoothManager


- (BOOL)enabled {

	bluetoothEnabled = !%orig;
	return %orig;

}

- (BOOL)setEnabled:(BOOL)arg1 {

	return %orig(bluetoothEnabled);

}

- (BOOL)setPowered:(BOOL)arg1 {

	return %orig(bluetoothEnabled);

}


%end




%ctor {


	loadPrefs();


}
