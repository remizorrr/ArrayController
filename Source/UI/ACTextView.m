//
//  VCRTextView.m
//  Vacarious
//
//  Created by Anton Remizov on 11/9/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import "ACTextView.h"

#define DEFAULT_STRING @"Placeholder Text"

@interface ACTextView ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation ACTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBegin:) name:UITextViewTextDidBeginEditingNotification object:nil];
}

- (void) textDidBegin:(id) sender {
    if ([self.text isEqualToString:self.placeholderText]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setDefaultText {
    self.text = self.placeholderText;
    self.textColor = self.placeholderTextColor;
}


- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    if (self.text.length == 0 ) {
        [self setDefaultText];
    }
    return YES;
}

- (CGSize)intrinsicContentSize {
    CGSize old = [super intrinsicContentSize];

    if (self.autoresize) {
        UIView* container = nil;
        for (UIView* view in self.subviews) {
            if ([NSStringFromClass([view class]) containsString:@"UITextContainerView"]) {
                container = view;
                break;
            }
        }
        return CGSizeMake(container.frame.size.width
                          , container.frame.size.height);
    } else {
        
    }
    return old;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self invalidateIntrinsicContentSize];
    self.heightConstraint.constant = self.intrinsicContentSize.height;
}
@end
