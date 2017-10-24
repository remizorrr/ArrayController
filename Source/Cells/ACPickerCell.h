//
//  VCRPickerCell.h
//  Vacarious
//
//  Created by Anton Remizov on 11/24/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* ACPickerCellIdentifier;

@interface ACPickerCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* stateLabel;
@property (nonatomic, weak) IBOutlet UIButton* toggleButton;
@property (nonatomic, weak) IBOutlet UIPickerView* picker;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint* heightConstraint;
@property (nonatomic, strong) NSArray* pickerItems;
@property (nonatomic, copy) void (^selectionChanged)(NSInteger selection);
@property (nonatomic, copy) void (^toggleBlock)();


@end
