#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <AudioToolbox/AudioServices.h>
#import <spawn.h>




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


@interface AESRootListController : PSListController {
    
    UITableView * _table;

}
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *headerImageView;
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