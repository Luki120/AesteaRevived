#import "AesteaPrysmVC.h"


static void postNSNotification() {

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"prysmToggleColorsApplied" object:nil];

}


@implementation AesteaPrysmVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AesteaPrysm" target:self];

	return _specifiers;

}


- (void)viewDidLoad {

	[super viewDidLoad];

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)postNSNotification, CFSTR("me.luki.aestearevivedprefs/prysmColorsApplied"), NULL, 0);

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.navigationController.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationController.navigationBar.barTintColor = AESTintColor;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}


- (id)readPreferenceValue:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:prefsKeys atomically:YES];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"prysmToggleColorsApplied" object:nil];

}


@end


@implementation AESPrysmDisabledToggleColorsVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AESPrysm Disabled Toggle Colors" target:self];

	return _specifiers;

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.navigationController.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationController.navigationBar.barTintColor = AESTintColor;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}


- (id)readPreferenceValue:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:prefsKeys atomically:YES];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"prysmToggleColorsApplied" object:nil];

}


@end


@implementation AESPrysmEnabledToggleColorsVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AESPrysm Enabled Toggle Colors" target:self];

	return _specifiers;

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.navigationController.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationController.navigationBar.barTintColor = AESTintColor;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}


- (id)readPreferenceValue:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:prefsKeys atomically:YES];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"prysmToggleColorsApplied" object:nil];

}


@end