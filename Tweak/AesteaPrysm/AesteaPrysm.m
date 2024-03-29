#import "Headers/Headers.h"


static void new_setAESPrysmToggleColors(PrysmConnectivityModuleViewController *self, SEL _cmd) {

	loadPrefs();

	if(pryColorOnState) {
		self.airplaneButton.altStateColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryAirplaneColor" fallback:@"ff9f0a"];
		self.wifiButton.altStateColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryWiFiColor" fallback:@"147efb"];
		self.bluetoothButton.altStateColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryBluetoothColor" fallback:@"147efb"];
		self.cellularButton.altStateColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryCellularColor" fallback:@"30d158"];
		self.airdropButton.altStateColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryAirDropColor" fallback:@"147efb"];
	}

	else {
		self.airplaneButton.altStateColor = UIColor.systemOrangeColor;
		self.wifiButton.altStateColor = UIColor.systemBlueColor;
		self.bluetoothButton.altStateColor = UIColor.systemBlueColor;
		self.cellularButton.altStateColor = UIColor.systemGreenColor;
		self.airdropButton.altStateColor = UIColor.systemBlueColor;
	}

	if(pryColorAirplaneDisabledState)

		self.airplaneButton.subviews[1].backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryOffAirplaneColor" fallback:@"147efb"];

	else self.airplaneButton.subviews[1].backgroundColor = nil;

	if(pryColorWiFiDisabledState)

		self.wifiButton.subviews[1].backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryOffWiFiColor" fallback:@"147efb"];

	else self.wifiButton.subviews[1].backgroundColor = nil;

	if(pryColorBluetoothDisabledState)

		self.bluetoothButton.subviews[1].backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryOffBluetoothColor" fallback:@"147efb"];

	else self.bluetoothButton.subviews[1].backgroundColor = nil;

	if(pryColorCellularDisabledState)

		self.cellularButton.subviews[1].backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryOffCellularColor" fallback:@"147efb"];

	else self.cellularButton.subviews[1].backgroundColor = nil;

	if(pryColorAirDropDisabledState)

		self.airdropButton.subviews[1].backgroundColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"pryOffAirDropColor" fallback:@"147efb"];

	else self.airdropButton.subviews[1].backgroundColor = nil;

}

static void (*origVDLS)(PrysmConnectivityModuleViewController *, SEL);
static void overrideVDLS(PrysmConnectivityModuleViewController *self, SEL _cmd) {

	origVDLS(self, _cmd);
	new_setAESPrysmToggleColors(self, _cmd);

	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(setAESPrysmToggleColors) name:AesteaDidApplyPrysmToggleColorsNotification object:nil];

}

static id observer;
static void appDidFinishLaunching() {

	observer = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {

		MSHookMessageEx(NSClassFromString(@"PrysmConnectivityModuleViewController"), @selector(viewDidLayoutSubviews), (IMP) &overrideVDLS, (IMP *) &origVDLS);

		class_addMethod(
			NSClassFromString(@"PrysmConnectivityModuleViewController"),
			@selector(setAESPrysmToggleColors),
			(IMP) &new_setAESPrysmToggleColors,
			"v@:"
		);

		[NSNotificationCenter.defaultCenter removeObserver: observer];

	}];

}

__attribute__((constructor)) static void init() {

	if(kAkaraExists || kBSCExists) return;
	appDidFinishLaunching();

}
