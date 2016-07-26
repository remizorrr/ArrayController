//
//  VCRPickerCell.m
//  Vacarious
//
//  Created by Anton Remizov on 11/24/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import "ACDatePickerCell.h"

NSString* ACDatePickerCellIdentifier = @"ACDatePickerCell";

@interface ACDatePickerCell()

@end

@implementation ACDatePickerCell

- (void)awakeFromNib {
    // Initialization code
    [self.picker setDatePickerMode:UIDatePickerModeDateAndTime];
    [self.picker setDatePickerMode:UIDatePickerModeDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)dateChanged:(UIDatePicker*)sender {
    if (self.selectionChanged) {
        self.selectionChanged(sender.date);
    }
}

- (IBAction)toggle:(id)sender {
    if (self.toggleBlock) {
        self.toggleBlock();
    }
}
@end
