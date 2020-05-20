//
// DRSTableCell.m
//  
// This code is directly from HBTintedTableCell in Cephie 
// Apache 2.0 License for code used in DRSPrefsLicense located in preference bundle
//

#import "DRSTableCell.h"

@implementation DRSTableCell

- (void)tintColorDidChange {
	[super tintColorDidChange];
	self.textLabel.textColor = self.tintColor;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];

	if ([self respondsToSelector:@selector(tintColor)]) {
		self.textLabel.textColor = self.tintColor;
	}
}

@end