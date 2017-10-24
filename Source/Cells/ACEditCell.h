//
//  VCREditCell.h
//  Vacarious
//
//  Created by Anton Remizov on 10/31/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* ACEditCellIdentifier;
extern CGFloat ACEditCellHeight;

@interface ACEditCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* iconImageView;
@property (nonatomic, strong) IBOutlet UITextField* textField;
@property (nonatomic, copy) void (^textChangedBlock)(NSString* text);

@end
