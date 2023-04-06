static NSString *const kPath = @"/var/mobile/Library/Preferences/me.luki.aestearevivedprefs.plist";

static NSNotificationName const AesteaDidApplyToggleColorsNotification = @"AesteaDidApplyToggleColorsNotification";
static NSNotificationName const AesteaDidApplyAkaraToggleColorsNotification = @"AesteaDidApplyAkaraToggleColorsNotification";
static NSNotificationName const AesteaDidApplyBSCToggleColorsNotification = @"AesteaDidApplyBSCToggleColorsNotification";
static NSNotificationName const AesteaDidApplyPrysmToggleColorsNotification = @"AesteaDidApplyPrysmToggleColorsNotification";

#define kAESTintColor [UIColor colorWithRed:0.64 green:0.67 blue:1.0 alpha:1.0]

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end
