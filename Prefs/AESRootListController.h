#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <AudioToolbox/AudioServices.h>
#import <spawn.h>


// Global


UIViewController *popController;
UIBarButtonItem *respringButtonItem;
UIBarButtonItem *changelogButtonItem;
CAGradientLayer *gradient;
UIView *view;


@interface OBButtonTray : UIView
@property (nonatomic,retain) UIVisualEffectView * effectView;
- (void)addButton:(id)arg1;
- (void)addCaptionText:(id)arg1;;
@end


@interface OBBoldTrayButton : UIButton
- (void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
+ (id)buttonWithType:(long long)arg1;
@end


@interface OBWelcomeController : UIViewController
@property (nonatomic, retain) UIView * viewIfLoaded;
@property (nonatomic, strong) UIColor * backgroundColor;
@property (assign, nonatomic) BOOL _shouldInlineButtontray;
- (OBButtonTray *)buttonTray;
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(long long)arg1;
@end


@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
- (id)initWithSettings:(id)arg1;
@property (assign, nonatomic) BOOL blurRadiusSetOnce;
@property (assign, nonatomic) double _blurRadius;
@property (nonatomic, copy) NSString * _blurQuality;
@end


@interface EnabledToggleColorsRootListController : PSListController
@end


@interface DisabledToggleColorsRootListController : PSListController
@end


@interface AESRootListController : PSListController<UIPopoverPresentationControllerDelegate> {
    
    UITableView * _table;

}
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIBarButtonItem *respringButton;
@property (nonatomic, strong) OBWelcomeController *changelogController;
- (void)yes:(UIButton *)sender;
- (void)no:(UIButton *)sender;
- (void)showWtfChangedInThisVersion:(UIButton *)sender;
- (void)shatterThePrefsToPieces;
- (void)blurEffect;
- (void)resetPrefs;
@end


@interface AesteaTableCell : PSTableCell
@end


@interface AesteaLinksVC : PSListController
@end


@interface ContributorsVC : PSListController
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end