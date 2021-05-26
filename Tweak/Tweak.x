#import "AesteaRevived.h"




%group AesteaRevived


%hook CCUIRoundButton


- (void)didMoveToWindow {

	%orig;

	ancestor = [self _viewControllerForAncestor];

	if ([ancestor isKindOfClass: %c(CCUIConnectivityAirplaneViewController)]) {

		if (colorOnStateSwitch)

			[[self selectedStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:airplaneColor]];

		if (colorAirplaneDisabledState)

			[[self normalStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:offAirplaneColor]];	

	}


	if ([ancestor isKindOfClass: %c(CCUIConnectivityCellularDataViewController)]) {

		if (colorOnStateSwitch)

			[[self selectedStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:cellularColor]];

		if (colorCellularDisabledState)

			[[self normalStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:offCellularColor]];

	}


	if ([ancestor isKindOfClass: %c(CCUIConnectivityWifiViewController)]) {

		if (colorOnStateSwitch)

			[[self selectedStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:wifiColor]];

		if (colorWiFiDisabledState)

			[[self normalStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:offWiFiColor]];

	}


	if ([ancestor isKindOfClass: %c(CCUIConnectivityBluetoothViewController)]) {

		if (colorOnStateSwitch)

			[[self selectedStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:bluetoothColor]];

		if (colorBluetoothDisabledState)

			[[self normalStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:offBluetoothColor]];

	}


	if ([ancestor isKindOfClass: %c(CCUIConnectivityAirDropViewController)]) {

		if (colorOnStateSwitch)

			[[self selectedStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:airdropColor]];

		if (colorAirdropDisabledState)

			[[self normalStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:offAirdropColor]];

	}


	if ([ancestor isKindOfClass: %c(CCUIConnectivityHotspotViewController)]) {

		if (colorOnStateSwitch)

			[[self selectedStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:hotspotColor]];

		if (colorHotspotDisabledState)

			[[self normalStateBackgroundView] setBackgroundColor:[GcColorPickerUtils colorWithHex:offHotspotColor]];

	}
}

%end




// Credits to the original creator of the tweak: https://github.com/jakeajames/RealCC


%hook CCUILabeledRoundButton


- (void)buttonTapped: (id)arg1 {


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

			}

			else

				bluetoothEnabled = YES;

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
%end




%ctor {

	preferences = [[HBPreferences alloc] initWithIdentifier:@"love.litten.aesteapreferences"];
	[preferences registerBool:&enabled default:YES forKey:@"Enabled"];
	[preferences registerBool:&colorOnStateSwitch default:YES forKey:@"colorOnState"];
	
	[preferences registerBool:&colorAirplaneDisabledState default:NO forKey:@"colorAirplaneDisabledState"];
	[preferences registerBool:&colorCellularDisabledState default:NO forKey:@"colorCellularDisabledState"];
	[preferences registerBool:&colorWiFiDisabledState default:NO forKey:@"colorWiFiDisabledState"];
	[preferences registerBool:&colorBluetoothDisabledState default:NO forKey:@"colorBluetoothDisabledState"];
	[preferences registerBool:&colorAirdropDisabledState default:NO forKey:@"colorAirdropDisabledState"];
	[preferences registerBool:&colorHotspotDisabledState default:NO forKey:@"colorHotspotDisabledState"];


	// Toggle On Colors


	[preferences registerObject:&airplaneColor default:@"ff9f0a" forKey:@"airplaneColor"];
	[preferences registerObject:&cellularColor default:@"30d158" forKey:@"cellularColor"];
	[preferences registerObject:&wifiColor default:@"147efb" forKey:@"wifiColor"];
	[preferences registerObject:&bluetoothColor default:@"147efb" forKey:@"bluetoothColor"];
	[preferences registerObject:&airdropColor default:@"147efb" forKey:@"airdropColor"];
	[preferences registerObject:&hotspotColor default:@"30d158" forKey:@"hotspotColor"];


	// Toggle Off Colors


	[preferences registerObject:&offAirplaneColor default:@"147efb" forKey:@"offAirplaneColor"];
	[preferences registerObject:&offCellularColor default:@"147efb" forKey:@"offCellularColor"];
	[preferences registerObject:&offWiFiColor default:@"147efb" forKey:@"offWiFiColor"];
	[preferences registerObject:&offBluetoothColor default:@"147efb" forKey:@"offBluetoothColor"];
	[preferences registerObject:&offAirdropColor default:@"147efb" forKey:@"offAirdropColor"];
	[preferences registerObject:&offHotspotColor default:@"147efb" forKey:@"offHotspotColor"];

	

	if (enabled)

		%init(AesteaRevived);

}
