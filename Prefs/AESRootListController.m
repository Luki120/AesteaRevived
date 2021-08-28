#include "AESRootListController.h"


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.aestearevivedprefs.plist";

#define tint [UIColor colorWithRed:0.64 green:0.67 blue:1.00 alpha:1.0]

static void postNSNotification() {


	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"toggleColorsApplied" object:nil];


}


@implementation AESRootListController


- (instancetype)init {

	self = [super init];

	if (self) {


		self.navigationItem.titleView = [UIView new];
		self.titleLabel = [UILabel new];
		self.titleLabel.text = @"3.1";
		self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
		self.titleLabel.textColor = UIColor.whiteColor;
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.navigationItem.titleView addSubview:self.titleLabel];

		self.iconView = [UIImageView new];
		self.iconView.alpha = 0;
		self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/AesteaPrefs.bundle/icon@2x.png"];
		self.iconView.contentMode = UIViewContentModeScaleAspectFit;
		self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.navigationItem.titleView addSubview:self.iconView];
		
		[NSLayoutConstraint activateConstraints:@[

			[self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
			[self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
			[self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
			[self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
			[self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
			[self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
			[self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
			[self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],

		]];

	}

	return self;

}

-(NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

	return _specifiers;

}


- (id)readPreferenceValue:(PSSpecifier*)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:prefsKeys atomically:YES];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"toggleColorsApplied" object:nil];

}


- (void)viewDidLoad {

	[super viewDidLoad];

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)postNSNotification, CFSTR("me.luki.aestearevivedprefs/colorsApplied"), NULL, 0);

	self.headerView = [UIView new];
	self.headerView.frame = CGRectMake(0,0,200,200);
	self.headerImageView = [UIImageView new];
	self.headerImageView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/AesteaPrefs.bundle/Banner.png"];
	self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
	self.headerImageView.clipsToBounds = YES;
	self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.headerView addSubview:self.headerImageView];
	
	[NSLayoutConstraint activateConstraints:@[

		[self.headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
		[self.headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
		[self.headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
		[self.headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
	
	]];

	_table.tableHeaderView = self.headerView;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	tableView.tableHeaderView = self.headerView;
	return [super tableView:tableView cellForRowAtIndexPath:indexPath];

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	CGRect frame = self.table.bounds;
	frame.origin.y = -frame.size.height;

	self.navigationController.navigationController.navigationBar.tintColor = UIColor.whiteColor;
	self.navigationController.navigationController.navigationBar.barTintColor = tint;
	[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
	self.navigationController.navigationController.navigationBar.translucent = YES;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

	CGFloat offsetY = scrollView.contentOffset.y;

	if (offsetY > 200) {

		[UIView animateWithDuration:0.2 animations:^{
			self.iconView.alpha = 1.0;
			self.titleLabel.alpha = 0.0;
		}];
	
	} else {
		
		[UIView animateWithDuration:0.2 animations:^{
			self.iconView.alpha = 0.0;
			self.titleLabel.alpha = 1.0;
		}];
	
	}
	
	if (offsetY > 0) offsetY = 0;
	self.headerImageView.frame = CGRectMake(0, offsetY, self.headerView.frame.size.width, 200 - offsetY);

}


- (void)shatterThePrefsToPieces {


	AudioServicesPlaySystemSound(1521);

	UIAlertController *resetAlert = [UIAlertController alertControllerWithTitle:@"AesteaRevived"
	message:@"Do you want to destroy this preferences and rebuild them fresh upon a respring?"
	preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

		NSFileManager *fileManager = [NSFileManager defaultManager];

		BOOL success = [fileManager removeItemAtPath:@"var/mobile/Library/Preferences/me.luki.aestearevivedprefs.plist" error:nil];

		if(success) [self blurEffect];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Meh" style:UIAlertActionStyleCancel handler:nil];

	[resetAlert addAction:confirmAction];
	[resetAlert addAction:cancelAction];

	[self presentViewController:resetAlert animated:YES completion:nil];


}


- (void)blurEffect {

	
	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithSettings:settings];
	backdropView.layer.masksToBounds = YES;
	backdropView.clipsToBounds = YES;
	backdropView.alpha = 0;
	backdropView.frame = self.view.bounds;
	[self.view addSubview:backdropView];

	[UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

		backdropView.alpha = 1;

	} completion:^(BOOL finished) {

		[self resetPrefs];

	}];

}


- (void)resetPrefs {


	pid_t pid;
	const char* args[] = {"sbreload", NULL, NULL, NULL};
	posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);


}


@end


@implementation EnabledToggleColorsRootListController


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Enabled Toggle Colors" target:self];

	return _specifiers;

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.navigationController.navigationController.navigationBar.tintColor = UIColor.whiteColor;
	self.navigationController.navigationController.navigationBar.barTintColor = tint;
	[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
	self.navigationController.navigationController.navigationBar.translucent = YES;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}


@end


@implementation DisabledToggleColorsRootListController


- (NSArray *)specifiers {
	
	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Disabled Toggle Colors" target:self];

	return _specifiers;

}

- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.navigationController.navigationController.navigationBar.tintColor = UIColor.whiteColor;
	self.navigationController.navigationController.navigationBar.barTintColor = tint;
	[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
	self.navigationController.navigationController.navigationBar.translucent = YES;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}

@end


@implementation ContributorsVC


- (NSArray *)specifiers {
	
	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AesteaContributors" target:self];

	return _specifiers;

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.navigationController.navigationController.navigationBar.tintColor = UIColor.whiteColor;
	self.navigationController.navigationController.navigationBar.barTintColor = tint;
	[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
	self.navigationController.navigationController.navigationBar.translucent = YES;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}


@end


@implementation AesteaLinksVC


- (NSArray *)specifiers {
	
	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AesteaLinks" target:self];

	return _specifiers;

}


- (void)discord {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://discord.gg/jbE3avwSHs"] options:@{} completionHandler:nil];


}


- (void)paypal {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://paypal.me/Luki120"] options:@{} completionHandler:nil];


}


- (void)paypalLitten {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://paypal.me/Litteeen"] options:@{} completionHandler:nil];


}


- (void)github {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/Luki120/AesteaRevived"] options:@{} completionHandler:nil];


}


- (void)iWantTranslucent {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://luki120.github.io/"] options:@{} completionHandler:nil];


}


- (void)lune {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://repo.litten.love/depictions/Lune/"] options:@{} completionHandler:nil];


}


- (void)rose {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://repo.litten.love/depictions/Rose/"] options:@{} completionHandler:nil];


}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.navigationController.navigationController.navigationBar.tintColor = UIColor.whiteColor;
	self.navigationController.navigationController.navigationBar.barTintColor = tint;
	[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
	self.navigationController.navigationController.navigationBar.translucent = YES;

}


- (void)viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];

	self.navigationController.navigationController.navigationBar.barTintColor = nil;

}


@end



@implementation AesteaTableCell


- (void)tintColorDidChange {

	[super tintColorDidChange];

	self.textLabel.textColor = tint;
	self.textLabel.highlightedTextColor = tint;

}


- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {

	[super refreshCellContentsWithSpecifier:specifier];

	if([self respondsToSelector:@selector(tintColor)]) {

		self.textLabel.textColor = tint;
		self.textLabel.highlightedTextColor = tint;

	}

}


@end