#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>


@interface AesteaBSCVC : PSListController
@end

@interface AESBSCEnabledToggleColorsVC : PSListController
@end


@interface AESBSCDisabledToggleColorsVC : PSListController
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end