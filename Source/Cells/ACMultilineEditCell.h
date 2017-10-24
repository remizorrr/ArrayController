//
//  VCROverviewCell.h
//  Vacarious
//
//  Created by Anton Remizov on 9/23/15.
//  Copyright (c) 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTextView.h"

extern NSString* ACMultilineEditCellIdentifier;

@interface ACMultilineEditCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* iconImageView;
@property(nonatomic,weak) IBOutlet ACTextView* textView;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* heightConstraint;

@property (nonatomic, copy) void (^heightChangeBlock)(float height);
@property (nonatomic, copy) void (^textChangedBlock)(NSString* text);

@end
