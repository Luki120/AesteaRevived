#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>


@interface AesteaPrysmVC : PSListController
@end


@interface AESPrysmDisabledToggleColorsVC : PSListController
@end


@interface AESPrysmEnabledToggleColorsVC : PSListController
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end