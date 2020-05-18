#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

// Helps To Detect iOS Version
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

// Preferences
HBPreferences* preferences;

// Enabled Switch - Extern Because It's Used In The RootListController
extern BOOL enabled;

// DRM
BOOL dpkgInvalid;

// Time And Date
BOOL hideTimeAndDateSwitch = NO;
BOOL hideOnlyDateSwitch = NO;
BOOL hideLunarCalendarSwitch = NO;
NSString* timeAndDateAlphaValue = @"1.0";
NSString* timeAndDateAlignmentControl = @"1";
NSString* fontNameInput = @"";
NSString* fontSizeControl = @"80";
BOOL useCustomFontSizeForDefaultSwitch = NO;
BOOL useCompactDateFormatSwitch = NO;

// FaceID Lock
BOOL hideFaceIDLockSwitch = NO;
NSString* faceIDLockAlphaValue = @"1.0";
BOOL customFaceIDAxisSwitch = NO;
NSString* faceIDXAxisControl = @"187.5";
NSString* faceIDYAxisControl = @"406.0";
NSString* customFaceIDSizeControl = @"0.0";

// Homebar
BOOL hideHomebarSwitch = NO;
NSString* homebarAlphaControl = @"1.0";

// CC Grabber
BOOL hideCCGrabberSwitch = NO;
NSString* ccGrabberAlphaControl = @"1.0";

// Swipe Text
BOOL hideSwipeTextSwitch = NO;
NSString* swipeTextInput = @"";

// Notifications
BOOL hideNoOlderNotificationsSwitch = NO;
BOOL hideNotificationCenterTextSwitch = NO;
BOOL hideNotificationsClearButtonSwitch = NO;
NSString* notificationsAlphaControl = @"1.0";
NSString* notificationsHeaderViewAlphaControl = @"1.0";
NSString* noOlderNotificationsTextInput = @"";
NSString* noOlderNotificationsTextAlignmentControl = @"1";
NSString* notificationCenterTextInput = @"";
BOOL alwaysExpandedNotificationsSwitch = NO;
BOOL notificationsScrollRevealSwitch = NO;
BOOL hideDNDBannerSwitch = NO;

// Quick Actions
BOOL hideQuickActionsSwitch = NO;
NSString* quickActionsAlphaControl = @"1.0";
BOOL customQuickActionsXAxisSwitch = NO;
BOOL customQuickActionsYAxisSwitch = NO;
NSString* customQuickActionsXAxisValueControl = @"50.0";
NSString* customQuickActionsYAxisValueControl = @"50.0";

// BOOL timeDateEvanescoSwitch = NO;
// NSString* inactivityDurationTimeDateControl = @"3.0";
// NSString* fadeDurationTimeDateControl = @"1.0";
// NSString* fadeAlphaTimeDateControl = @"0.0";

// BOOL faceIDLockEvanescoSwitch = NO;
// NSString* inactivityDurationFaceIDLockControl = @"3.0";
// NSString* fadeDurationFaceIDLockControl = @"1.0";
// NSString* fadeAlphaFaceIDLockControl = @"0.0";

// BOOL notificationsEvanescoSwitch = NO;
// NSString* inactivityDurationNotificationsControl = @"3.0";
// NSString* fadeDurationNotificationsControl = @"1.0";
// NSString* fadeAlphaNotificationsControl = @"0.0";

// BOOL quickActionsEvanescoSwitch = NO;
// NSString* inactivityDurationQuickActionsControl = @"3.0";
// NSString* fadeDurationQuickActionsControl = @"1.0";
// NSString* fadeAlphaQuickActionsControl = @"0.0";

// NSString* animationCurveControl = @"0";
NSString* customLockDurationControl = @"0";

// Time And Date
@interface SBFLockScreenDateView : UIView
@end

@interface SBFLockScreenDateSubtitleDateView : UIView
@end

// FaceID Lock
@interface SBUIProudLockIconView : UIView
@end

// Homebar
@interface CSHomeAffordanceView : UIView
@end

// Swipe Text
@interface CSTeachableMomentsContainerView : UIView
@property(nonatomic, strong, readwrite)UIView* controlCenterGrabberContainerView;
@end

@interface SBUICallToActionLabel : NSObject
@property(nonatomic, assign, readwrite)BOOL hidden;
@property(nonatomic, copy, readwrite)NSString* text;
@end

// Notifications
@interface NCNotificationListView : UIView
@end

@interface NCNotificationListCell : UIView
@end

// No Older Notifications Text
@interface NCNotificationListSectionRevealHintView : UIView
@end

// Notification Center Text
@interface NCNotificationListHeaderTitleView : UIView
@property(nonatomic, copy, readwrite)NSString* title;
@end

// Quick Actions
@interface CSQuickActionsView : UIView
@end

// Lunar Label
@interface SBFLockScreenAlternateDateLabel : UIView
@property(nonatomic, assign, readwrite)BOOL hidden;
@end

// Needed For Custom Font
@interface SBUILegibilityLabel : UIView
@property(nonatomic, assign, readwrite)NSString* string;
@property (assign,nonatomic) long long textAlignment;
- (void)setFont:(UIFont *)arg1;
- (id)_viewControllerForAncestor;
@end

// Needed For DRM Alert
@interface SBIconController : UIViewController
- (void)viewDidAppear:(BOOL)animated;
@end