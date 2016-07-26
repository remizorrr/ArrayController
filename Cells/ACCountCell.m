//
//  VCRCountCell.m
//  Vacarious
//
//  Created by Anton Remizov on 1/19/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import "ACCountCell.h"

NSString* ACCountCellIdentifier = @"ACCountCell";

@interface ACCountCell ()
{
}
@end

@implementation ACCountCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setValue:(NSInteger)value {
    _value = value;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)value];
    
    if (value == 0) {
        [self.leftButton setImage:[UIImage imageNamed:@"left_disabled.png"]
                             forState:UIControlStateNormal];
        self.leftButton.userInteractionEnabled = NO;
    } else {
        [self.leftButton setImage:[UIImage imageNamed:@"left.png"]
                             forState:UIControlStateNormal];
        self.leftButton.userInteractionEnabled = YES;
    }

}

- (IBAction)decrease:(id)sender {
    --self.value;
    if (self.valueChanged) {
        self.valueChanged(self.value);
    }
}

- (IBAction)increase:(id)sender {
    ++self.value;
    if (self.valueChanged) {
        self.valueChanged(self.value);
    }
}

@end
