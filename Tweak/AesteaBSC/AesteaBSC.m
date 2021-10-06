#import "../Headers/Headers.h"


void new_setAESBSCToggleColors(SCGroupedControlsModuleViewController *self, SEL _cmd) {

	loadPrefs();

	if(bscColorOnState) {

		self.wifiControlView.buttonView.selectedColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bscWiFiColor" fallback:@"147efb"];
		self.bluetoothControlView.buttonView.selectedColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bscBluetoothColor" fallback:@"147efb"];
		self.cellularControlView.buttonView.selectedColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bscAirplaneCellularColor" fallback:@"30d158"];

	}

	else {

		self.wifiControlView.buttonView.selectedColor = UIColor.systemBlueColor;
		self.bluetoothControlView.buttonView.selectedColor = UIColor.systemBlueColor;
		if(self.cellularControlView.style == 3) self.cellularControlView.buttonView.selectedColor = UIColor.systemGreenColor;
		else self.cellularControlView.buttonView.selectedColor = UIColor.systemOrangeColor;

	}


	if(bscColorAirplaneOrCellularDisabledState)

		self.cellularControlView.buttonView.defaultColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bscOffAirplaneCellularColor" fallback:@"147efb"];

	else self.cellularControlView.buttonView.defaultColor = [UIColor colorWithRed: 0.33 green: 0.30 blue: 0.33 alpha: 1.00];


	if(bscColorWiFiDisabledState)

		self.wifiControlView.buttonView.defaultColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bscOffWiFiColor" fallback:@"147efb"];

	else self.wifiControlView.buttonView.defaultColor = [UIColor colorWithRed: 0.33 green: 0.30 blue: 0.33 alpha: 1.00];


	if(bscColorBluetoothDisabledState)

		self.bluetoothControlView.buttonView.defaultColor = [GcColorPickerUtils colorFromDefaults:@"me.luki.aestearevivedprefs" withKey:@"bscOffBluetoothColor" fallback:@"147efb"];

	else self.bluetoothControlView.buttonView.defaultColor = [UIColor colorWithRed: 0.33 green: 0.30 blue: 0.33 alpha: 1.00];

}


void(*origVWA)(SCGroupedControlsModuleViewController *self, SEL _cmd, BOOL animated);

void overrideVWA(SCGroupedControlsModuleViewController *self, SEL _cmd, BOOL animated) {

	origVWA(self, _cmd, animated);

	new_setAESBSCToggleColors(self, _cmd);

	[NSDistributedNotificationCenter.defaultCenter removeObserver:self];
	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateStates) name:@"bscToggleColorsApplied" object:nil];
	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(setAESBSCToggleColors) name:@"bscToggleColorsApplied" object:nil];

}


void (*origADFL)(SpringBoard *self, SEL _cmd, id app);

void overrideADFL(SpringBoard *self, SEL _cmd, id app) {

	origADFL(self, _cmd, app);

	MSHookMessageEx(NSClassFromString(@"SCGroupedControlsModuleViewController"), @selector(viewWillAppear:), (IMP) &overrideVWA, (IMP *) &origVWA);

	class_addMethod (
		
		NSClassFromString(@"SCGroupedControlsModuleViewController"),
		@selector(setAESBSCToggleColors),
		(IMP)&new_setAESBSCToggleColors,
		"v@:"

	);

}

__attribute__((constructor)) static void init() {

	if(isAkaraInstalled || isPrysmInstalled) return;

	MSHookMessageEx(NSClassFromString(@"SpringBoard"), @selector(applicationDidFinishLaunching:), (IMP) &overrideADFL, (IMP *) &origADFL);

}
