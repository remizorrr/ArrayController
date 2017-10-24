//
//  VCRArrayViewController.h
//  Vacarious
//
//  Created by Anton Remizov on 3/14/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACController.h"

#import "ACEditCell.h"
#import "ACActionCell.h"
#import "ACCountCell.h"
#import "ACPickerCell.h"
#import "ACSwitchCell.h"
#import "ACDatePickerCell.h"
#import "ACHeaderCell.h"
#import "ACMultilineEditCell.h"
#import "ACKeyboardHandler.h"

typedef NS_ENUM(NSUInteger, ACViewControllerNavigationState) {
    ACViewControllerNavigationStateBack,
    ACViewControllerNavigationStateDone,
    ACViewControllerNavigationStateSaveCancle,
    ACViewControllerNavigationStateDefault
};
extern NSString* ACCellIdentifier;

@interface ACViewController : UIViewController

@property (nonatomic, readonly) IBOutlet UITableView* tableView;
@property (nonatomic, readonly) ACKeyboardHandler* keyboardHandler;
@property (nonatomic, copy) void(^completionBlock)(BOOL save);
@property (nonatomic, strong) ACController* arrayController;
@property (nonatomic, assign) ACViewControllerNavigationState navigationState;

- (void) setViewModel:(NSArray*)viewModel;
- (void) setViewModelBlock:(NSArray*(^)())vmBlock;
- (void) refreshModel;
- (void) setCustomSaveTitle:(NSString*)saveTitle cancelTitle:(NSString*)cancelTitle;
- (Class) dataControllerClass;
- (Class) tableViewClass;

+ (void) registerNib:(UINib*)nib forIdentifier:(NSString*)identifier;
+ (void) registerClass:(Class)class forIdentifier:(NSString*)identifier;
@end
