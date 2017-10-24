//
//  VCRCountCell.h
//  Vacarious
//
//  Created by Anton Remizov on 1/19/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* ACCountCellIdentifier;

@interface ACCountCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* titleLabel;
@property (nonatomic, weak) IBOutlet UILabel* countLabel;
@property (nonatomic, weak) IBOutlet UIImageView* iconImageView;
@property (nonatomic, weak) IBOutlet UIButton* leftButton;
@property (nonatomic, weak) IBOutlet UIButton* rightButton;
@property (nonatomic, copy) void(^valueChanged)(NSInteger value);
@property (nonatomic, assign) NSInteger value;

@end
