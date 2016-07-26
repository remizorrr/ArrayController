//
//  VCRSwitchCell.m
//  Vacarious
//
//  Created by Anton Remizov on 10/31/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import "ACSwitchCell.h"

NSString* ACSwitchCellIdentifier = @"ACSwitchCell";

@implementation ACSwitchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)didChange:(id)sender {
    if (self.changedBlock) {
        self.changedBlock(self.switchView.on);
    }
}
@end
