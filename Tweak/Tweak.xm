#import "Dress.h"

BOOL enabled;

// BOOL timeDateTimerRunning = NO;
// BOOL faceIDLockTimerRunning = NO;
// BOOL notificationsTimerRunning = NO;
// BOOL homebarTimerRunning = NO;
// BOOL quickActionsTimerRunning = NO;

/*

	I Deleted The Evanesco Mode Code For Now Until I Find A Better Way To Do It

*/

BOOL revealed = NO;

BOOL kalmInstalled = NO;


// Time And Date

%group TimeAndDate

%hook SBFLockScreenDateView

- (void)didMoveToWindow {

	%orig;

	if (hideTimeAndDateSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;

}

- (void)setAlpha:(double)alpha {

	%orig([timeAndDateAlphaValue doubleValue]);

}

- (void)setAlignmentPercent:(double)arg1 {

	if ([timeAndDateAlignmentControl intValue] == 0)
		%orig(-1.0); // left
	else if ([timeAndDateAlignmentControl intValue] == 1)
		%orig(0.0); // center
	else if ([timeAndDateAlignmentControl intValue] == 2)
		%orig(1.0); // right

}

- (void)setUseCompactDateFormat:(BOOL)arg1 {

	if (useCompactDateFormatSwitch)
		%orig(YES);
	else
		%orig;

}

%end

%hook SBFLockScreenDateSubtitleDateView

- (void)didMoveToWindow {

	%orig;

	if (hideOnlyDateSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;

	SBFLockScreenAlternateDateLabel* label = MSHookIvar<SBFLockScreenAlternateDateLabel *>(self, "_alternateDateLabel");

	if (hideLunarCalendarSwitch)
		label.hidden = YES;
	else
		label.hidden = NO;

}

%end

%hook SBUILegibilityLabel

- (void)didMoveToWindow {

	%orig;

	if (!(SYSTEM_VERSION_LESS_THAN(@"13.0"))) { // Not Working On iOS 12 So I Need To Make Sure The User Is On iOS 13
	UIViewController* ancestor = [self _viewControllerForAncestor];
	
	if ([ancestor isKindOfClass: %c(SBFLockScreenDateViewController)])
		if (!([fontNameInput isEqual:@""]))
			[self setFont:[UIFont fontWithName:fontNameInput size:[fontSizeControl intValue]]];

	if ([ancestor isKindOfClass: %c(SBFLockScreenDateViewController)])
		if ([fontNameInput isEqual:@""] && useCustomFontSizeForDefaultSwitch)
			[self setFont:[UIFont systemFontOfSize:[fontSizeControl intValue]]];

	}

}

%end

%end

// FaceID Lock

%group FaceID

%hook SBUIProudLockIconView

- (void)layoutSubviews {

	%orig;

	[self setAlpha:[faceIDLockAlphaValue doubleValue]];

	BSUICAPackageView* lockView = MSHookIvar<BSUICAPackageView *>(self, "_lockView");

	if (hideFaceIDLockSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;

	if (customFaceIDAxisSwitch)
		lockView.frame = CGRectMake([faceIDXAxisControl doubleValue], [faceIDYAxisControl doubleValue], 23 + [customFaceIDSizeControl doubleValue], 33 + [customFaceIDSizeControl doubleValue]);

}

- (void)setAlpha:(double)alpha {

	%orig([faceIDLockAlphaValue doubleValue]);

}

%end

%end

// Homebar

%group Homebar 

%hook CSHomeAffordanceView

- (void)didMoveToWindow {

	%orig;

	if (hideHomebarSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;

}

- (void)setAlpha:(double)alpha {

	%orig([homebarAlphaControl doubleValue]);

}

%end

%end

// Swipe Text And CC Grabber

%group SwipeTextAndCCGrabber

%hook CSTeachableMomentsContainerView // iX iOS 13

- (void)_layoutCallToActionLabel {
	
	%orig;

	SBUILegibilityLabel* label = MSHookIvar<SBUILegibilityLabel *>(self, "_callToActionLabel");

	if (hideSwipeTextSwitch)
		label.hidden = YES;
	else
		label.hidden = NO;

	if (!([swipeTextInput isEqual:@""]))
		label.string = swipeTextInput;

}

- (void)didMoveToWindow {

	%orig;

	if (hideCCGrabberSwitch)
		self.controlCenterGrabberContainerView.hidden = YES;
	else
		self.controlCenterGrabberContainerView.hidden = NO;

	self.controlCenterGrabberContainerView.alpha = [ccGrabberAlphaControl doubleValue];

}

%end

%hook SBDashBoardTeachableMomentsContainerView // iX iOS 12

- (void)_layoutCallToActionLabel {

	%orig;

	SBUILegibilityLabel* label = MSHookIvar<SBUILegibilityLabel *>(self, "_callToActionLabel");

	if (hideSwipeTextSwitch)
		label.hidden = YES;
	else
		label.hidden = NO;

	if (!([swipeTextInput isEqual:@""]))
    	label.string = swipeTextInput;

}

%end

%hook SBUICallToActionLabel

- (void)layoutSubviews { // Home Button Devices Before Recognized

	%orig;

	if (hideSwipeTextSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;

	if (!([swipeTextInput isEqual:@""]))
    	self.text = swipeTextInput;

}

- (void)_updateLabelTextWithLanguage:(id)arg1 {  // Home Button Devices Before Recognized

    %orig;

	if (hideSwipeTextSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;
    
	if (!([swipeTextInput isEqual:@""]))
		self.text = swipeTextInput;

}

%end

%end

// Notifications

%group Notifications

%hook NCNotificationListView

// if (!([NSStringFromClass([self.superview class]) isEqualToString:@"NCNotificationListView"])) return;       This Will Help Later

- (BOOL)isRevealed { // needed to set the alpha of the title and clear button

	revealed = %orig;

	return %orig;

}

- (BOOL)_isGrouping {

	if (alwaysExpandedNotificationsSwitch)
		return NO;
	else
		return %orig;

}

- (void)setPerformingGroupingAnimation:(BOOL)arg1 {

	if (notificationsScrollRevealSwitch)
		%orig(YES);
	else
		%orig;

}

%end

%hook NCNotificationListCell

- (void)setAlpha:(double)alpha {

	%orig([notificationsAlphaControl doubleValue]);

}

%end

// No Older Notifications Text

%hook NCNotificationListSectionRevealHintView

- (void)didMoveToWindow {

	%orig;

	SBUILegibilityLabel* label = MSHookIvar<SBUILegibilityLabel *>(self, "_revealHintTitle");

	if (hideNoOlderNotificationsSwitch)
		label.hidden = YES;
	else
		label.hidden = NO;

	if (!([noOlderNotificationsTextInput isEqual:@""])) {
		label.textAlignment = NSTextAlignmentCenter;
    	label.string = noOlderNotificationsTextInput;

	}

	if ([noOlderNotificationsTextAlignmentControl intValue] == 0)
		label.textAlignment = NSTextAlignmentLeft; // left
	else if ([noOlderNotificationsTextAlignmentControl intValue] == 1)
		label.textAlignment = NSTextAlignmentCenter; // center
	else if ([noOlderNotificationsTextAlignmentControl intValue] == 2)
		label.textAlignment = NSTextAlignmentRight; // right

}

%end

// Notification Center Text

%hook NCNotificationListHeaderTitleView

- (void)didMoveToWindow {

	%orig;

	if (hideNotificationCenterTextSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;

	if  (!([notificationCenterTextInput isEqual:@""]))
		self.title = notificationCenterTextInput;

}

%end

// Clear Notifications Button

%hook NCNotificationListSectionHeaderView

- (void)didMoveToWindow {

	%orig;

	UIControl* clearButton = MSHookIvar<UIControl *>(self, "_clearButton");	

	if (hideNotificationsClearButtonSwitch)
		clearButton.hidden = YES;
	else
		clearButton.hidden = NO;

}

- (void)setAlpha:(double)alpha {

	if (revealed)
		%orig([notificationsHeaderViewAlphaControl doubleValue]);
	else
		%orig;

}

%end

// DND Banner

%hook DNDNotificationsService

- (void)_queue_postOrRemoveNotificationWithUpdatedBehavior:(BOOL)arg1 significantTimeChange:(BOOL)arg2 {

	if (hideDNDBannerSwitch)
		return;
	else
		%orig;

}

%end

%end

// Quick Actions

%group QuickActions

%hook CSQuickActionsView

- (void)didMoveToWindow {

	%orig;

	if (hideQuickActionsSwitch)
		self.hidden = YES;
	else
		self.hidden = NO;

}

- (CGFloat)_insetX {

	if (customQuickActionsXAxisSwitch)
		return [customQuickActionsXAxisValueControl doubleValue];
	else
		return %orig;
	
}

- (CGFloat)_insetY {

	if (customQuickActionsYAxisSwitch)
		return [customQuickActionsYAxisValueControl doubleValue];
	else
		return %orig;
	
}

- (void)setAlpha:(double)alpha {

	if ([quickActionsAlphaControl doubleValue] != 1.0) // without checking it, it would break the fade animation if the alpha is 1.0
		%orig([quickActionsAlphaControl doubleValue]);
	else
		%orig;

}

%end

// Custom Auto Lock Duration

%hook CSBehavior

- (void)setIdleTimerDuration:(long long)arg1 {

	if ([customLockDurationControl intValue] == 0)
		%orig;
	else if ([customLockDurationControl intValue] == 1)
		%orig(3); // apparently 10 seconds
	else if ([customLockDurationControl intValue] == 2)
		%orig(4); // apparently 15 seconds
	else if ([customLockDurationControl intValue] == 3)
		%orig(5); // apparently 20 seconds
	else if ([customLockDurationControl intValue] == 4)
		%orig(6); // apparently 25 seconds
	else if ([customLockDurationControl intValue] == 5)
		%orig(7); // apparently 30 seconds

}

%end

%end

%group DressIntegrityFail

%hook SBIconController

- (void)viewDidAppear:(BOOL)animated {

    %orig; //  Thanks to Nepeta for the DRM
    if (!dpkgInvalid) return;
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Dress"
		message:@"Seriously? Pirating a free Tweak is awful!\nPiracy repo's Tweaks could contain Malware if you didn't know that, so go ahead and get Dress from the official Source https://repo.litten.love/.\nIf you're seeing this but you got it from the official source then make sure to add https://repo.litten.love to Cydia or Sileo."
		preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Aww man" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

			UIApplication *application = [UIApplication sharedApplication];
			[application openURL:[NSURL URLWithString:@"https://repo.litten.love/"] options:@{} completionHandler:nil];

	}];

		[alertController addAction:cancelAction];

		[self presentViewController:alertController animated:YES completion:nil];

}

%end

%end

%ctor {
  
    // Thanks To Nepeta For The DRM
    dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/love.litten.dress.list"];

    if (!dpkgInvalid) dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/love.litten.dress.md5sums"];

    if (dpkgInvalid) {
        %init(DressIntegrityFail);
        return;
    }

	preferences = [[HBPreferences alloc] initWithIdentifier:@"love.litten.dresspreferences"];

    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];

	// Time And Date
	[preferences registerBool:&hideTimeAndDateSwitch default:NO forKey:@"hideTimeAndDate"];
	[preferences registerBool:&hideOnlyDateSwitch default:NO forKey:@"hideOnlyDate"];
	[preferences registerBool:&hideLunarCalendarSwitch default:NO forKey:@"hideLunarCalendar"];
	[preferences registerObject:&timeAndDateAlphaValue default:@"1.0" forKey:@"timeAndDateAlpha"];
	[preferences registerObject:&timeAndDateAlignmentControl default:@"1" forKey:@"timeAndDateAlignment"];
	[preferences registerObject:&fontNameInput default:@"" forKey:@"fontName"];
	[preferences registerObject:&fontSizeControl default:@"80" forKey:@"fontSize"];
	[preferences registerBool:&useCustomFontSizeForDefaultSwitch default:NO forKey:@"useCustomFontSizeForDefault"];
	[preferences registerBool:&useCompactDateFormatSwitch default:NO forKey:@"useCompactDateFormat"];

	// FaceID Lock
	[preferences registerBool:&hideFaceIDLockSwitch default:NO forKey:@"hideFaceIDLock"];
	[preferences registerObject:&faceIDLockAlphaValue default:@"1.0" forKey:@"faceIDLockAlpha"];
	[preferences registerBool:&customFaceIDAxisSwitch default:NO forKey:@"customFaceIDAxis"];
	[preferences registerObject:&faceIDXAxisControl default:@"187.5" forKey:@"faceIDXAxis"];
	[preferences registerObject:&faceIDYAxisControl default:@"406.0" forKey:@"faceIDYAxis"];
	[preferences registerObject:&customFaceIDSizeControl default:@"0.0" forKey:@"customFaceIDSize"];

	// Homebar
	[preferences registerBool:&hideHomebarSwitch default:NO forKey:@"hideHomebar"];
	[preferences registerObject:&homebarAlphaControl default:@"1.0" forKey:@"homebarAlpha"];

	// CC Grabber
	[preferences registerBool:&hideCCGrabberSwitch default:NO forKey:@"hideCCGrabber"];
	[preferences registerObject:&ccGrabberAlphaControl default:@"1.0" forKey:@"ccGrabberAlpha"];

	// Swipe Text
	[preferences registerBool:&hideSwipeTextSwitch default:NO forKey:@"hideSwipeText"];
	[preferences registerObject:&swipeTextInput default:@"" forKey:@"swipeText"];

	// Notifications
	[preferences registerBool:&hideNoOlderNotificationsSwitch default:NO forKey:@"hideNoOlderNotifications"];
	[preferences registerBool:&hideNotificationCenterTextSwitch default:NO forKey:@"hideNotificationCenterText"];
	[preferences registerBool:&hideNotificationsClearButtonSwitch default:NO forKey:@"hideNotificationsClearButton"];
	[preferences registerObject:&notificationsAlphaControl default:@"1.0" forKey:@"notificationsAlpha"];
	[preferences registerObject:&notificationsHeaderViewAlphaControl default:@"1.0" forKey:@"notificationsHeaderViewAlpha"];
	[preferences registerObject:&noOlderNotificationsTextInput default:@"" forKey:@"noOlderNotificationsText"];
	[preferences registerObject:&noOlderNotificationsTextAlignmentControl default:@"1" forKey:@"noOlderNotificationsTextAlignment"];
	[preferences registerObject:&notificationCenterTextInput default:@"" forKey:@"notificationCenterText"];
	[preferences registerBool:&alwaysExpandedNotificationsSwitch default:NO forKey:@"alwaysExpandedNotifications"];
	[preferences registerBool:&notificationsScrollRevealSwitch default:NO forKey:@"notificationsScrollReveal"];
	[preferences registerBool:&hideDNDBannerSwitch default:NO forKey:@"hideDNDBanner"];

	// Quick Actions
	[preferences registerBool:&hideQuickActionsSwitch default:NO forKey:@"hideQuickActions"];
	[preferences registerObject:&quickActionsAlphaControl default:@"1.0" forKey:@"quickActionsAlpha"];
	[preferences registerBool:&customQuickActionsXAxisSwitch default:NO forKey:@"customQuickActionsXAxis"];
	[preferences registerBool:&customQuickActionsYAxisSwitch default:NO forKey:@"customQuickActionsYAxis"];
	[preferences registerObject:&customQuickActionsXAxisValueControl default:@"50.0" forKey:@"customQuickActionsXAxisValue"];
	[preferences registerObject:&customQuickActionsYAxisValueControl default:@"50.0" forKey:@"customQuickActionsYAxisValue"];

	// Evanesco Mode
	// [preferences registerBool:&timeDateEvanescoSwitch default:NO forKey:@"timeDateEvanesco"];
	// [preferences registerObject:&inactivityDurationTimeDateControl default:@"3.0" forKey:@"inactivityDurationTimeDate"];
	// [preferences registerObject:&fadeDurationTimeDateControl default:@"1.0" forKey:@"fadeDurationTimeDate"];
	// [preferences registerObject:&fadeAlphaTimeDateControl default:@"0.0" forKey:@"fadeAlphaTimeDate"];

	// [preferences registerBool:&faceIDLockEvanescoSwitch default:NO forKey:@"faceIDLockEvanesco"];
	// [preferences registerObject:&inactivityDurationFaceIDLockControl default:@"3.0" forKey:@"inactivityDurationFaceIDLock"];
	// [preferences registerObject:&fadeDurationFaceIDLockControl default:@"1.0" forKey:@"fadeDurationFaceIDLock"];
	// [preferences registerObject:&fadeAlphaFaceIDLockControl default:@"0.0" forKey:@"fadeAlphaFaceIDLock"];
	
	// [preferences registerBool:&notificationsEvanescoSwitch default:NO forKey:@"notificationsEvanesco"];
	// [preferences registerObject:&inactivityDurationNotificationsControl default:@"3.0" forKey:@"inactivityDurationNotifications"];
	// [preferences registerObject:&fadeDurationNotificationsControl default:@"1.0" forKey:@"fadeDurationNotifications"];
	// [preferences registerObject:&fadeAlphaNotificationsControl default:@"0.0" forKey:@"fadeAlphaNotifications"];

	// [preferences registerBool:&quickActionsEvanescoSwitch default:NO forKey:@"quickActionsEvanesco"];
	// [preferences registerObject:&inactivityDurationQuickActionsControl default:@"3.0" forKey:@"inactivityDurationQuickActions"];
	// [preferences registerObject:&fadeDurationQuickActionsControl default:@"1.0" forKey:@"fadeDurationQuickActions"];
	// [preferences registerObject:&fadeAlphaQuickActionsControl default:@"0.0" forKey:@"fadeAlphaQuickActions"];

	// [preferences registerObject:&animationCurveControl default:@"0" forKey:@"animationCurve"];
	[preferences registerObject:&customLockDurationControl default:@"0" forKey:@"customLockDuration"];

	NSFileManager *fileManager = [NSFileManager defaultManager];

	NSString *pathForFile = @"/Library/MobileSubstrate/DynamicLibraries/Kalm.dylib";

	if ([fileManager fileExistsAtPath:pathForFile]){ 
		#ifdef DEBUG
		NSLog(@"Dress: Kalm Detected");
		#endif

		kalmInstalled = YES;
	}

	if (!dpkgInvalid && enabled) {
        BOOL ok = false;
        
        ok = ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"/var/lib/dpkg/info/%@%@%@%@%@%@%@%@%@%@%@.dress.md5sums", @"l", @"o", @"v", @"e", @".", @"l", @"i", @"t", @"t", @"e", @"n"]]
        );

        if (ok && [@"litten" isEqualToString:@"litten"]) {
			
			if (!kalmInstalled)
				%init(TimeAndDate);
			
			%init(FaceID);
			%init(Homebar);
			%init(SwipeTextAndCCGrabber);
			%init(Notifications);
			%init(QuickActions);

            return;
        } else {
            dpkgInvalid = YES;
        }
    }
}