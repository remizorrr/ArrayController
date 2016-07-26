//
//  VCREditCell.m
//  Vacarious
//
//  Created by Anton Remizov on 10/31/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import "ACEditCell.h"

NSString* ACEditCellIdentifier = @"ACEditCell";
CGFloat ACEditCellHeight = 44.0;

@interface ACEditCell () <UITextFieldDelegate>

@end
@implementation ACEditCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)textDidChange:(id)sender {
    if (self.textChangedBlock) {
        self.textChangedBlock(self.textField.text);
    }
}


@end
