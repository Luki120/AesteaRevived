#import "AesteaAkaraVC.h"


static const char *aestea_akara_colors_changed = "me.luki.aestearevivedprefs/akaraColorsApplied";


@implementation AesteaAkaraVC

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AesteaAkara" target:self];
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


@implementation AESAkaraEnabledToggleColorsVC

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AESAkara Enabled Toggle Colors" target:self];
	return _specifiers;

}


- (void)viewDidLoad {

	[super viewDidLoad];

	int register_token = 0;
	notify_register_dispatch(aestea_akara_colors_changed, &register_token, dispatch_get_main_queue(), ^(int token) {
		[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyAkaraToggleColorsNotification object:nil];		
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

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyAkaraToggleColorsNotification object:nil];

	[super setPreferenceValue:value specifier:specifier];

}

@end


@implementation AESAkaraDisabledToggleColorsVC

- (NSArray *)specifiers {
	
	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AESAkara Disabled Toggle Colors" target:self];
	return _specifiers;

}


- (void)viewDidLoad {

	[super viewDidLoad];

	int register_token = 0;
	notify_register_dispatch(aestea_akara_colors_changed, &register_token, dispatch_get_main_queue(), ^(int token) {
		[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyAkaraToggleColorsNotification object:nil];		
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

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:AesteaDidApplyAkaraToggleColorsNotification object:nil];

	[super setPreferenceValue:value specifier:specifier];

}

@end
