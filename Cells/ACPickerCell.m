//
//  VCRPickerCell.m
//  Vacarious
//
//  Created by Anton Remizov on 11/24/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import "ACPickerCell.h"

NSString* ACPickerCellIdentifier = @"ACPickerCell";

@interface ACPickerCell() <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation ACPickerCell

- (void)awakeFromNib {
    [self.picker reloadAllComponents];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPickerItems:(NSArray *)pickerItems {
    _pickerItems = pickerItems;
    [self.picker reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerItems.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerItems[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.selectionChanged) {
        self.selectionChanged(row);
    }
}

- (IBAction)toggle:(id)sender {
    if (self.toggleBlock) {
        self.toggleBlock();
    }
}
@end
