#import "Headers/Headers.h"


static void new_setAESAkaraToggleColors(AkaraConnectivityRoundButtonViewController *self, SEL _cmd) {

	loadPrefs();

	if([self.buttonName isEqualToString:@"Airplane"]) {

		if(akColorAirplaneDisabledState)

			self.ccRoundButton.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akOffAirplaneColor" fallback:@"147efb"];

		else self.ccRoundButton.normalStateBackgroundView.backgroundColor = nil;

		if(akColorOnState)

			self.ccRoundButton.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akAirplaneColor" fallback:@"ff9f0a"];

		else self.ccRoundButton.selectedStateBackgroundView.backgroundColor = UIColor.systemOrangeColor;

	}

	else if([self.buttonName isEqualToString:@"Wi-Fi"]) {

		if(akColorWiFiDisabledState)

			self.ccRoundButton.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akOffWiFiColor" fallback:@"147efb"];

		else self.ccRoundButton.normalStateBackgroundView.backgroundColor = nil;

		if(akColorOnState)

			self.ccRoundButton.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akWiFiColor" fallback:@"147efb"];

		else self.ccRoundButton.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

	}

	else if([self.buttonName isEqualToString:@"Bluetooth"]) {

		if(akColorBluetoothDisabledState)

			self.ccRoundButton.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akOffBluetoothColor" fallback:@"147efb"];

		else self.ccRoundButton.normalStateBackgroundView.backgroundColor = nil;

		if(akColorOnState)

			self.ccRoundButton.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akBluetoothColor" fallback:@"147efb"];

		else self.ccRoundButton.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

	}

	else if([self.buttonName isEqualToString:@"Cellular"]) {

		if(akColorCellularDisabledState)

			self.ccRoundButton.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akOffCellularColor" fallback:@"147efb"];

		else self.ccRoundButton.normalStateBackgroundView.backgroundColor = nil;

		if(akColorOnState)

			self.ccRoundButton.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akCellularColor" fallback:@"30d158"];

		else self.ccRoundButton.selectedStateBackgroundView.backgroundColor = UIColor.systemGreenColor;

	}

	else if([self.buttonName isEqualToString:@"Hotspot"]) {

		if(akColorHotspotDisabledState)

			self.ccRoundButton.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akOffHotspotColor" fallback:@"147efb"];

		else self.ccRoundButton.normalStateBackgroundView.backgroundColor = nil;

		if(akColorOnState)

			self.ccRoundButton.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akHotspotColor" fallback:@"147efb"];

		else self.ccRoundButton.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

	}

	else if([self.buttonName isEqualToString:@"AirDrop"]) {

		if(akColorAirDropDisabledState)

			self.ccRoundButton.normalStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akOffAirDropColor" fallback:@"147efb"];

		else self.ccRoundButton.normalStateBackgroundView.backgroundColor = nil;

		if(akColorOnState)

			self.ccRoundButton.selectedStateBackgroundView.backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"akAirDropColor" fallback:@"147efb"];

		else self.ccRoundButton.selectedStateBackgroundView.backgroundColor = UIColor.systemBlueColor;

	}

}

static void (*origDMTW)(CCUIRoundButton *self, SEL _cmd);

static void overrideDMTW(CCUIRoundButton *self, SEL _cmd) {

	origDMTW(self, _cmd);

	UIViewController *ancestor = [self _viewControllerForAncestor];
	if(![ancestor isKindOfClass:NSClassFromString(@"AkaraConnectivityRoundButtonViewController")]) return;

	for(MTMaterialView *materialView in self.subviews)

		if([materialView isKindOfClass:NSClassFromString(@"MTMaterialView")]) materialView.weighting = 0;

}

static void (*origVDLS)(AkaraConnectivityRoundButtonViewController *self, SEL _cmd);

static void overrideVDLS(AkaraConnectivityRoundButtonViewController *self, SEL _cmd) {

	origVDLS(self, _cmd);
	new_setAESAkaraToggleColors(self, _cmd);

	[NSDistributedNotificationCenter.defaultCenter removeObserver:self];
	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(setAESAkaraToggleColors) name:@"akToggleColorsApplied" object:nil];

}

static void (*origADFL)(SpringBoard *self, SEL _cmd, id);

static void overrideADFL(SpringBoard *self, SEL _cmd, id app) {

	origADFL(self, _cmd, app);

	MSHookMessageEx(NSClassFromString(@"CCUIRoundButton"), @selector(didMoveToWindow), (IMP) &overrideDMTW, (IMP *) &origDMTW);
	MSHookMessageEx(NSClassFromString(@"AkaraConnectivityRoundButtonViewController"), @selector(viewDidLayoutSubviews), (IMP) &overrideVDLS, (IMP *) &origVDLS);

	class_addMethod(		
		NSClassFromString(@"AkaraConnectivityRoundButtonViewController"),
		@selector(setAESAkaraToggleColors),
		(IMP) &new_setAESAkaraToggleColors,
		"v@:"
	);

}

__attribute__((constructor)) static void init() {

	if(kBSCExists || kPrysmExists) return;
	MSHookMessageEx(NSClassFromString(@"SpringBoard"), @selector(applicationDidFinishLaunching:), (IMP) &overrideADFL, (IMP *) &origADFL);

}
