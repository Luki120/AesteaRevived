#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>


@interface AesteaAkaraVC : PSListController
@end


@interface AESAkaraEnabledToggleColorsVC : PSListController
@end


@interface AESAkaraDisabledToggleColorsVC : PSListController
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end