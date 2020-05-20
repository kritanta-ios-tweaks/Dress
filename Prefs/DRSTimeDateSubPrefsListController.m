#import "DRSTimeDateSubPrefsListController.h"
#import <Preferences/PSControlTableCell.h>
#import <Preferences/PSEditableTableCell.h>

@interface PSEditableTableCell (Interface)
- (id)textField;
@end

@implementation DRSTimeDateSubPrefsListController

- (instancetype)init {
    self = [super init];

    if (self) {
        DRSAppearanceSettings *appearanceSettings = [[DRSAppearanceSettings alloc] init];
        self.hb_appearanceSettings = appearanceSettings;
    }

    return self;
}

- (id)specifiers {
    return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    if (SYSTEM_VERSION_LESS_THAN(@"13.0")) {
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] enabled:NO];
    }

	NSFileManager *fileManager = [NSFileManager defaultManager];

	NSString *pathForFile = @"/Library/MobileSubstrate/DynamicLibraries/Kalm.dylib";

	if ([fileManager fileExistsAtPath:pathForFile])
    {
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:12 inSection:0] enabled:NO];
        [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:13 inSection:0] enabled:NO];

        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,100)];
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,200,100)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/DressPrefs.bundle/KalmAlert@3x.png"];
        self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;

        [self.headerView addSubview:self.headerImageView];
        [NSLayoutConstraint activateConstraints:@[
            [self.headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
            [self.headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
            [self.headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
            [self.headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
        ]];

        _table.tableHeaderView = self.headerView;
    }

}

- (void)loadFromSpecifier:(PSSpecifier *)specifier {
    NSString *sub = [specifier propertyForKey:@"DRSSub"];
    NSString *title = [specifier name];

    _specifiers = [[self loadSpecifiersFromPlistName:sub target:self] retain];

    [self setTitle:title];
    [self.navigationItem setTitle:title];
}

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}

- (bool)shouldReloadSpecifiersOnResume {
    return false;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled {

    UITableViewCell *cell = [self tableView:self.table cellForRowAtIndexPath:indexPath];

    if (cell) {
        cell.userInteractionEnabled = enabled;
        cell.textLabel.enabled = enabled;
        cell.detailTextLabel.enabled = enabled;
        
        if ([cell isKindOfClass:[PSControlTableCell class]]) {
            PSControlTableCell *controlCell = (PSControlTableCell *)cell;

            if (controlCell.control)
                controlCell.control.enabled = enabled;

        } else if ([cell isKindOfClass:[PSEditableTableCell class]]) {
            PSEditableTableCell *editableCell = (PSEditableTableCell *)cell;
            ((UITextField*)[editableCell textField]).alpha = enabled ? 1 : 0.4;

        }

    }

}

@end