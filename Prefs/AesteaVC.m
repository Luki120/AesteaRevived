#import "AesteaVC.h"


@implementation AesteaVC {

	UIImageView *iconView;
	UILabel *versionLabel;
	UIStackView *navBarStackView;
	UIView *headerView;
	UIImageView *headerImageView;
	OBWelcomeController *changelogController;

}

#pragma mark Lifecycle

- (id)init {

	self = [super init];
	if(self) [self setupUI];
	return self;

}


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
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


- (void)setupUI {

	UIImage *iconImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/AesteaPrefs.bundle/Assets/Aestea@2x.png"];
	UIImage *bannerImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/AesteaPrefs.bundle/Assets/Banner.png"];
	UIImage *changelogButtonImage = [UIImage systemImageNamed:@"atom"];

	self.navigationItem.titleView = [UIView new];

	navBarStackView = [UIStackView new];
	navBarStackView.axis = UILayoutConstraintAxisVertical;
	navBarStackView.spacing = 0.5;
	navBarStackView.alignment = UIStackViewAlignmentCenter;
	navBarStackView.distribution = UIStackViewDistributionFill;
	navBarStackView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.navigationItem.titleView addSubview: navBarStackView];

	iconView = [UIImageView new];
	iconView.image = iconImage;
	iconView.contentMode = UIViewContentModeScaleAspectFit;
	iconView.translatesAutoresizingMaskIntoConstraints = NO;
	[navBarStackView addArrangedSubview: iconView];

	versionLabel = [UILabel new];
	versionLabel.text = @"AesteaRevived 3.2";
	versionLabel.font = [UIFont boldSystemFontOfSize:12];
	versionLabel.textAlignment = NSTextAlignmentCenter;
	[navBarStackView addArrangedSubview: versionLabel];

	headerView = [UIView new];
	headerView.frame = CGRectMake(0,0,200,200);
	headerImageView = [UIImageView new];
	headerImageView.image = bannerImage;
	headerImageView.contentMode = UIViewContentModeScaleAspectFill;
	headerImageView.clipsToBounds = YES;
	headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
	[headerView addSubview: headerImageView];

	UIButton *changelogButton = [UIButton new];
	changelogButton.alpha = 0.65;
	changelogButton.tintColor = UIColor.whiteColor;
	[changelogButton setImage:changelogButtonImage forState: UIControlStateNormal];
	[changelogButton addTarget:self action:@selector(showWtfChangedInThisVersion) forControlEvents: UIControlEventTouchUpInside];

	UIBarButtonItem *changelogButtonItem = [[UIBarButtonItem alloc] initWithCustomView: changelogButton];
	self.navigationItem.rightBarButtonItem = changelogButtonItem;

	[self layoutUI];

}


- (void)layoutUI {

	[iconView.widthAnchor constraintEqualToConstant: 30].active = YES;
	[iconView.heightAnchor constraintEqualToConstant: 30].active = YES;

	[navBarStackView.topAnchor constraintEqualToAnchor: self.navigationItem.titleView.topAnchor constant : -0.5].active = YES;
	[navBarStackView.bottomAnchor constraintEqualToAnchor: self.navigationItem.titleView.bottomAnchor].active = YES;
	[navBarStackView.leadingAnchor constraintEqualToAnchor: self.navigationItem.titleView.leadingAnchor].active = YES;
	[navBarStackView.trailingAnchor constraintEqualToAnchor: self.navigationItem.titleView.trailingAnchor].active = YES;

	[headerImageView.topAnchor constraintEqualToAnchor: headerView.topAnchor].active = YES;
	[headerImageView.bottomAnchor constraintEqualToAnchor: headerView.bottomAnchor].active = YES;
	[headerImageView.leadingAnchor constraintEqualToAnchor: headerView.leadingAnchor].active = YES;
	[headerImageView.trailingAnchor constraintEqualToAnchor: headerView.trailingAnchor].active = YES;

}


- (void)showWtfChangedInThisVersion {

	AudioServicesPlaySystemSound(1521);

	UIImage *tweakIconImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/AesteaPrefs.bundle/Assets/AesteaIcon.png"];
	UIImage *checkmarkImage = [UIImage systemImageNamed:@"checkmark.circle.fill"];

	changelogController = [[OBWelcomeController alloc] initWithTitle:@"AesteaRevived" detailText:@"3.2" icon:tweakIconImage];
	[changelogController addBulletedListItemWithTitle:@"Code" description:@"Aestea is fully respringless now. All changes apply on the fly." image:checkmarkImage];
	[changelogController addBulletedListItemWithTitle:@"General" description:@"Added full seamless Akara, Big Sur Center & Prysm support." image:checkmarkImage];

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithSettings: settings];	
	backdropView.clipsToBounds = YES;
	backdropView.layer.masksToBounds = YES;
	backdropView.translatesAutoresizingMaskIntoConstraints = NO;
	[changelogController.viewIfLoaded insertSubview:backdropView atIndex:0];

	[backdropView.topAnchor constraintEqualToAnchor: changelogController.viewIfLoaded.topAnchor].active = YES;
	[backdropView.bottomAnchor constraintEqualToAnchor: changelogController.viewIfLoaded.bottomAnchor].active = YES;
	[backdropView.leadingAnchor constraintEqualToAnchor: changelogController.viewIfLoaded.leadingAnchor].active = YES;
	[backdropView.trailingAnchor constraintEqualToAnchor: changelogController.viewIfLoaded.trailingAnchor].active = YES;

	changelogController.viewIfLoaded.backgroundColor = UIColor.clearColor;
	changelogController.view.tintColor = kAESTintColor;
	changelogController.modalInPresentation = NO;
	changelogController.modalPresentationStyle = UIModalPresentationPageSheet;
	[self presentViewController:changelogController animated:YES completion:nil];

}


- (void)shatterThePrefsToPieces {

	AudioServicesPlaySystemSound(1521);

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"AesteaRevived" message:@"Do you want to destroy this preferences and rebuild them fresh upon a respring?" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

		NSFileManager *fileM = [NSFileManager defaultManager];

		[fileM removeItemAtPath:@"/var/mobile/Library/Preferences/me.luki.aestearevivedprefs.plist" error:nil];

		[self crossDissolveBlur];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Meh" style:UIAlertActionStyleDefault handler:nil];

	[alertController addAction:confirmAction];
	[alertController addAction:cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];

}


- (void)crossDissolveBlur {

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithSettings: settings];
	backdropView.alpha = 0;
	backdropView.frame = self.view.bounds;
	backdropView.clipsToBounds = YES;
	backdropView.layer.masksToBounds = YES;
	[self.view addSubview: backdropView];

	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

		backdropView.alpha = 1;

	} completion:^(BOOL finished) { [self launchRespring]; }];

}


- (void)launchRespring {

	pid_t pid;
	const char* args[] = {"sbreload", NULL, NULL, NULL};
	posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);

}


#pragma mark Table View Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	tableView.tableHeaderView = headerView;
	return [super tableView:tableView cellForRowAtIndexPath:indexPath];

}

@end


@implementation AesteaContributorsVC

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AesteaContributors" target:self];
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


@implementation AesteaLinksVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AesteaLinks" target:self];
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


- (void)launchDiscord {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://discord.gg/jbE3avwSHs"] options:@{} completionHandler:nil];

}


- (void)launchPayPal {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://paypal.me/Luki120"] options:@{} completionHandler:nil];

}


- (void)launchPayPalLitten {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://paypal.me/Litteeen"] options:@{} completionHandler:nil];

}


- (void)launchGitHub {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://github.com/Luki120/AesteaRevived"] options:@{} completionHandler:nil];

}


- (void)launchIWantTranslucent {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://luki120.github.io/depictions/web/?p=me.luki.iwanttranslucent"] options:@{} completionHandler:nil];

}


- (void)launchLune {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://repo.litten.love/depictions/Lune/"] options:@{} completionHandler:nil];

}


- (void)launchRose {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://repo.litten.love/depictions/Rose/"] options:@{} completionHandler:nil];

}

@end


@implementation AesteaTableCell

- (void)setTitle:(NSString *)t {

	[super setTitle:t];
	self.titleLabel.textColor = kAESTintColor;

}

@end
