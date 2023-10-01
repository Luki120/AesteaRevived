#import "AesteaVC.h"


@implementation AesteaVC {

	UIImageView *iconView;
	UILabel *versionLabel;
	UIStackView *navBarStackView;
	UIView *headerView;
	UIImageView *headerImageView;
	OBWelcomeController *changelogController;

}


// ! Lifecycle

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	return _specifiers;

}


- (id)init {

	self = [super init];
	if(!self) return nil;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{ registerAesteaTintCellClass(); });

	[self setupUI];

	return self;

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

	UIImage *iconImage = [UIImage imageWithContentsOfFile:rootlessPathNS(@"/Library/PreferenceBundles/AesteaPrefs.bundle/Assets/Aestea@2x.png")];
	UIImage *bannerImage = [UIImage imageWithContentsOfFile:rootlessPathNS(@"/Library/PreferenceBundles/AesteaPrefs.bundle/Assets/Banner.png")];
	UIImage *changelogButtonImage = [UIImage systemImageNamed:@"atom"];

	self.navigationItem.titleView = [UIView new];

	if(!navBarStackView) {
		navBarStackView = [UIStackView new];
		navBarStackView.axis = UILayoutConstraintAxisVertical;
		navBarStackView.spacing = 0.5;
		navBarStackView.alignment = UIStackViewAlignmentCenter;
		navBarStackView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.navigationItem.titleView addSubview: navBarStackView];
	}

	if(!iconView) {
		iconView = [UIImageView new];
		iconView.image = iconImage;
		iconView.contentMode = UIViewContentModeScaleAspectFit;
		iconView.translatesAutoresizingMaskIntoConstraints = NO;
		[navBarStackView addArrangedSubview: iconView];
	}

	if(!versionLabel) {
		versionLabel = [UILabel new];
		versionLabel.text = @"AesteaRevived 0.9.2";
		versionLabel.font = [UIFont boldSystemFontOfSize:12];
		versionLabel.textAlignment = NSTextAlignmentCenter;
		[navBarStackView addArrangedSubview: versionLabel];
	}

	if(!headerView) {
		headerView = [UIView new];
		headerView.frame = CGRectMake(0,0,200,200);	
	}

	if(!headerImageView) {
		headerImageView = [UIImageView new];
		headerImageView.image = bannerImage;
		headerImageView.contentMode = UIViewContentModeScaleAspectFill;
		headerImageView.clipsToBounds = YES;
		headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[headerView addSubview: headerImageView];
	}

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

// ! Selectors

- (void)showWtfChangedInThisVersion {

	AudioServicesPlaySystemSound(1521);

	UIImage *tweakIconImage = [UIImage imageWithContentsOfFile:rootlessPathNS(@"/Library/PreferenceBundles/AesteaPrefs.bundle/Assets/AesteaIcon.png")];
	UIImage *checkmarkImage = [UIImage systemImageNamed:@"checkmark.circle.fill"];

	if(changelogController) { [self presentViewController:changelogController animated:YES completion:nil]; return; }
	changelogController = [[OBWelcomeController alloc] initWithTitle:@"AesteaRevived" detailText:@"0.9.2" icon:tweakIconImage];
	[changelogController addBulletedListItemWithTitle:@"Code" description:@"Refactoring ⇝ everything works the same, but better." image:checkmarkImage];

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
	backdropView.clipsToBounds = YES;
	[changelogController.viewIfLoaded insertSubview:backdropView atIndex:0];

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

		[[NSFileManager defaultManager] removeItemAtPath:kPath error:nil];
		[self crossDissolveBlur];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Meh" style:UIAlertActionStyleDefault handler:nil];

	[alertController addAction:confirmAction];
	[alertController addAction:cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];

}


- (void)crossDissolveBlur {

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
	backdropView.alpha = 0;
	backdropView.clipsToBounds = YES;
	[self.view addSubview: backdropView];

	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

		backdropView.alpha = 1;

	} completion:^(BOOL finished) { [self launchRespring]; }];

}


- (void)launchRespring {

	pid_t pid;
	const char* args[] = {"killall", "backboardd", NULL};
	posix_spawn(&pid, rootlessPathC("/usr/bin/killall"), NULL, NULL, (char* const*)args, NULL);

}

// ! UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	tableView.tableHeaderView = headerView;
	return [super tableView:tableView cellForRowAtIndexPath:indexPath];

}

// ! Dark juju

static void aestea_setTitle(PSTableCell *self, SEL _cmd, NSString *title) {

	struct objc_super superSetTitle = {
		self,
		[self superclass]
	};

	id (*superCall)(struct objc_super *, SEL, NSString *) = (void *)objc_msgSendSuper;
	superCall(&superSetTitle, _cmd, title);

	self.titleLabel.textColor = kAESTintColor;
	self.titleLabel.highlightedTextColor = kAESTintColor;

}

static void registerAesteaTintCellClass() {

	Class AesteaTintCellClass = objc_allocateClassPair([PSTableCell class], "AesteaTintCell", 0);
	Method method = class_getInstanceMethod([PSTableCell class], @selector(setTitle:));
	const char *typeEncoding = method_getTypeEncoding(method);
	class_addMethod(AesteaTintCellClass, @selector(setTitle:), (IMP) aestea_setTitle, typeEncoding);

	objc_registerClassPair(AesteaTintCellClass);

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


- (void)launchDiscord { [self launchURL: [NSURL URLWithString: @"https://discord.gg/jbE3avwSHs"]]; }
- (void)launchPayPal { [self launchURL: [NSURL URLWithString: @"https://paypal.me/Luki120"]]; }
- (void)launchGitHub { [self launchURL: [NSURL URLWithString: @"https://github.com/Luki120/AesteaRevived"]]; }
- (void)launchIWantTranslucent { [self launchURL: [NSURL URLWithString:@"https://luki120.github.io/depictions/web/?p=me.luki.iwanttranslucent"]]; }

- (void)launchURL:(NSURL *)url { [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil]; }

@end
