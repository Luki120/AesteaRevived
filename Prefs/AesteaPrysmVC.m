#import "AesteaPrysmVC.h"


static const char *aestea_prysm_colors_changed = "me.luki.aestearevivedprefs/prysmColorsApplied";


@implementation AesteaPrysmVC

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AesteaPrysm" target:self];
	return _specifiers;

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];
	setNavBarTintColorForVC(self);

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];
	nilOutNavBarTintColorForVC(self);

}

@end


@implementation AESPrysmDisabledToggleColorsVC

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AESPrysm Disabled Toggle Colors" target:self];
	return _specifiers;

}


- (void)viewDidLoad {

	[super viewDidLoad];

	int register_token = 0;
	notify_register_dispatch(aestea_prysm_colors_changed, &register_token, dispatch_get_main_queue(), ^(int token) {
		[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyPrysmToggleColorsNotification object:nil];
	});

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];
	setNavBarTintColorForVC(self);

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];
	nilOutNavBarTintColorForVC(self);

}


- (id)readPreferenceValue:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile: kPath]];
	return settings[specifier.properties[@"key"]] ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile: kPath]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:kPath atomically:YES];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyPrysmToggleColorsNotification object:nil];

	[super setPreferenceValue:value specifier:specifier];

}

@end


@implementation AESPrysmEnabledToggleColorsVC

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AESPrysm Enabled Toggle Colors" target:self];
	return _specifiers;

}


- (void)viewDidLoad {

	[super viewDidLoad];

	int register_token = 0;
	notify_register_dispatch(aestea_prysm_colors_changed, &register_token, dispatch_get_main_queue(), ^(int token) {
		[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyPrysmToggleColorsNotification object:nil];
	});

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];
	setNavBarTintColorForVC(self);

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];
	nilOutNavBarTintColorForVC(self);

}


- (id)readPreferenceValue:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile: kPath]];
	return settings[specifier.properties[@"key"]] ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile: kPath]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:kPath atomically:YES];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyPrysmToggleColorsNotification object:nil];

	[super setPreferenceValue:value specifier:specifier];

}

@end
