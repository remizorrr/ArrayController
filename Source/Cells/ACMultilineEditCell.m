//
//  VCROverviewCell.m
//  Vacarious
//
//  Created by Anton Remizov on 9/23/15.
//  Copyright (c) 2015 Appcoming. All rights reserved.
//

#import "ACMultilineEditCell.h"

NSString* ACMultilineEditCellIdentifier = @"ACMultilineEditCell";

@implementation ACMultilineEditCell

- (void)awakeFromNib {
    self.textView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    // Initialization code
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self refreshSize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateSize
{
    if (_heightConstraint.constant != [_textView intrinsicContentSize].height) {
        [UIView animateWithDuration:0.4
                              delay:0.0f
                            options:0
                         animations:^{
                             _heightConstraint.constant = [_textView intrinsicContentSize].height;
                             [self layoutIfNeeded];
                             [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)textViewDidChange:(UITextView *)aTextView
{
    [self refreshSize];
}

- (void) refreshSize {
    [self.textView setNeedsLayout];
    [self.textView layoutIfNeeded];
    [self.textView layoutIfNeeded];
    
    [self updateSize];
    
    if (self.heightChangeBlock) {
        self.heightChangeBlock([_textView intrinsicContentSize].height);
    }
    if (self.textChangedBlock) {
        self.textChangedBlock(self.textView.text);
    }
}
@end
