//
//  VCRArrayViewController.h
//  Vacarious
//
//  Created by Anton Remizov on 3/14/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACController.h"

@interface ACViewController : UIViewController

@property (nonatomic, readonly) UITableView* tableView;
@property (nonatomic, copy) void(^completionBlock)(BOOL save);

- (void) setViewModel:(NSArray*)viewModel;
- (void) setViewModelBlock:(NSArray*(^)())vmBlock;
- (void) refreshModel;

+ (void) registerNib:(UINib*)nib forIdentifier:(NSString*)identifier;
+ (void) registerClass:(Class)class forIdentifier:(NSString*)identifier;
@end
