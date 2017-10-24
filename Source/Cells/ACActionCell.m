//
//  VCRActionCell.m
//  Vacarious
//
//  Created by Anton Remizov on 10/31/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import "ACActionCell.h"

NSString* ACActionCellIdentifier = @"ACActionCell";

@implementation ACActionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
