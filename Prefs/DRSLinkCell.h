#import "DRSTableCell.h"

@interface DRSLinkCell : DRSTableCell

@property (nonatomic, readonly) BOOL isBig;

@property (nonatomic, retain, readonly) UIView *avatarView;

@property (nonatomic, retain, readonly) UIImageView *avatarImageView;

@property (nonatomic, retain) UIImage *avatarImage;

@end