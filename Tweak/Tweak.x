#import "AesteaRevived.h"


BOOL enabled;


static BOOL bluetoothEnabled;


%group AesteaRevived


%hook CCUIRoundButton


- (void)didMoveToWindow {

	%orig;

	ancestor = [self _viewControllerForAncestor];

	if ([ancestor isKindOfClass: %c(CCUIConnectivityAirplaneViewController)]) {
		if (colorOnStateSwitch) {
			[[self selectedStateBackgroundView] setBackgroundColor:colorAirplane];
		}
		if (colorOffStateSwitch) {
			[[self normalStateBackgroundView] setBackgroundColor:offColorAirplane];
		}
	}

	if ([ancestor isKindOfClass: %c(CCUIConnectivityCellularDataViewController)]) {
		if (colorOnStateSwitch) {
			[[self selectedStateBackgroundView] setBackgroundColor:colorCellular];
		}
		if (colorOffStateSwitch) {
			[[self normalStateBackgroundView] setBackgroundColor:offColorCellular];
		}
	}

	if ([ancestor isKindOfClass: %c(CCUIConnectivityWifiViewController)]) {
		if (colorOnStateSwitch) {
			[[self selectedStateBackgroundView] setBackgroundColor:colorWifi];
		}
		if (colorOffStateSwitch) {
			[[self normalStateBackgroundView] setBackgroundColor:offColorWifi];
		}
	}

	if ([ancestor isKindOfClass: %c(CCUIConnectivityBluetoothViewController)]) {
		if (colorOnStateSwitch) {
			[[self selectedStateBackgroundView] setBackgroundColor:colorBluetooth];
		}
		if (colorOffStateSwitch) {
			[[self normalStateBackgroundView] setBackgroundColor:offColorBluetooth];
		}
	}

	if ([ancestor isKindOfClass: %c(CCUIConnectivityAirDropViewController)]) {
		if (colorOnStateSwitch) {
			[[self selectedStateBackgroundView] setBackgroundColor:colorAirDrop];
		}
		if (colorOffStateSwitch) {
			[[self normalStateBackgroundView] setBackgroundColor:offColorAirDrop];
		}
	}

	if ([ancestor isKindOfClass: %c(CCUIConnectivityHotspotViewController)]) {
		if (colorOnStateSwitch) {
			[[self selectedStateBackgroundView] setBackgroundColor:colorHotspot];
		}
		if (colorOffStateSwitch) {
			[[self normalStateBackgroundView] setBackgroundColor:offColorHotspot];
		}
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


-(BOOL)enabled {

	bluetoothEnabled = !%orig;
	return %orig;

}

-(BOOL)setEnabled:(BOOL)arg1 {

	return %orig(bluetoothEnabled);

}

-(BOOL)setPowered:(BOOL)arg1 {

	return %orig(bluetoothEnabled);

}


%end
%end




%ctor {

	preferences = [[HBPreferences alloc] initWithIdentifier:@"love.litten.aesteapreferences"];
	preferencesDictionary = [NSDictionary dictionaryWithContentsOfFile: @"/var/mobile/Library/Preferences/love.litten.aestea.colorspreferences.plist"];

    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];

	[preferences registerBool:&colorOnStateSwitch default:YES forKey:@"colorOnState"];
	[preferences registerBool:&colorOffStateSwitch default:NO forKey:@"colorOffState"];

	if (colorOnStateSwitch) {
		colorAirplaneString = [preferencesDictionary objectForKey: @"airplaneColor"];
		colorAirplane = [SparkColourPickerUtils colourWithString: colorAirplaneString withFallback: @"#147efb"];
		colorCellularString = [preferencesDictionary objectForKey: @"cellularColor"];
		colorCellular = [SparkColourPickerUtils colourWithString: colorCellularString withFallback: @"#147efb"];
		colorWifiString = [preferencesDictionary objectForKey: @"wifiColor"];
		colorWifi = [SparkColourPickerUtils colourWithString: colorWifiString withFallback: @"#147efb"];
		colorBluetoothString = [preferencesDictionary objectForKey: @"bluetoothColor"];
		colorBluetooth = [SparkColourPickerUtils colourWithString: colorBluetoothString withFallback: @"#147efb"];
		colorAirdropString = [preferencesDictionary objectForKey: @"airdropColor"];
		colorAirDrop = [SparkColourPickerUtils colourWithString: colorAirdropString withFallback: @"#147efb"];
		colorHoptspotString = [preferencesDictionary objectForKey: @"hotspotColor"];
		colorHotspot = [SparkColourPickerUtils colourWithString: colorHoptspotString withFallback: @"#147efb"];	
	}

	if (colorOffStateSwitch) {
		offColorAirplaneString = [preferencesDictionary objectForKey: @"offAirplaneColor"];
		offColorAirplane = [SparkColourPickerUtils colourWithString: offColorAirplaneString withFallback: @"#147efb"];
		offColorCellularString = [preferencesDictionary objectForKey: @"offCellularColor"];
		offColorCellular = [SparkColourPickerUtils colourWithString: offColorCellularString withFallback: @"#147efb"];
		offColorWifiString = [preferencesDictionary objectForKey: @"offWifiColor"];
		offColorWifi = [SparkColourPickerUtils colourWithString: offColorWifiString withFallback: @"#147efb"];
		offColorBluetoothString = [preferencesDictionary objectForKey: @"offBluetoothColor"];
		offColorBluetooth = [SparkColourPickerUtils colourWithString: offColorBluetoothString withFallback: @"#147efb"];
		offColorAirdropString = [preferencesDictionary objectForKey: @"offAirdropColor"];
		offColorAirDrop = [SparkColourPickerUtils colourWithString: offColorAirdropString withFallback: @"#147efb"];
		offColorHoptspotString = [preferencesDictionary objectForKey: @"offHotspotColor"];
		offColorHotspot = [SparkColourPickerUtils colourWithString: offColorHoptspotString withFallback: @"#147efb"];
	}

	// Toggle On Color
	[preferences registerObject:&airplaneColorValue default:@"147efb" forKey:@"airplaneColor"];
	[preferences registerObject:&cellularColorValue default:@"147efb" forKey:@"cellularColor"];
	[preferences registerObject:&wifiColorValue default:@"147efb" forKey:@"wifiColor"];
	[preferences registerObject:&bluetoothColorValue default:@"147efb" forKey:@"bluetoothColor"];
	[preferences registerObject:&airdropColorValue default:@"147efb" forKey:@"airdropColor"];
	[preferences registerObject:&hotspotColorValue default:@"147efb" forKey:@"hotspotColor"];

	// Toggle Off Color
	[preferences registerObject:&airplaneOffColorValue default:@"147efb" forKey:@"offAirplaneColor"];
	[preferences registerObject:&cellularOffColorValue default:@"147efb" forKey:@"offCellularColor"];
	[preferences registerObject:&wifiOffColorValue default:@"147efb" forKey:@"offWifiColor"];
	[preferences registerObject:&bluetoothOffColorValue default:@"147efb" forKey:@"offBluetoothColor"];
	[preferences registerObject:&airdropOffColorValue default:@"147efb" forKey:@"offAirdropColor"];
	[preferences registerObject:&hotspotOffColorValue default:@"147efb" forKey:@"offHotspotColor"];

	

	if (enabled) {
		%init(AesteaRevived);
	}

}
