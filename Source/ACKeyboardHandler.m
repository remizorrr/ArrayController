//
//  ACKeyboardHandler.m
//  Vacarious
//
//  Created by Anton Remizov on 11/14/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import "ACKeyboardHandler.h"

@implementation ACKeyboardHandler
{
    BOOL keyboardIsShown;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _enabled = YES;
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (instancetype)initWithKeyboardAnimateBlock:(void(^)(CGFloat height))animateKeyboardHeightChange {
    self = [self init];
    if (self) {
        self.animateKeyboardHeightChange = animateKeyboardHeightChange;
    }
    return self;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeHeight:)
                                                 name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications
{
}

- (void) updateKeyboardHeight:(CGFloat)height {
    if (self.animateKeyboardHeightChange) {
        self.animateKeyboardHeightChange(height);
    }
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (!self.enabled) {
        return;
    }
    keyboardIsShown = YES;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSUInteger tmpOption = [[aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:[[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                          delay:0.0f
                        options:(tmpOption << 16)
                     animations:^{
                         [self updateKeyboardHeight:kbSize.height];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)keyboardDidChangeHeight:(NSNotification*)aNotification
{
    if (!self.enabled) {
        return;
    }
    if (!keyboardIsShown) {
        return;
    }
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSUInteger tmpOption = [[aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:[[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                          delay:0.0f
                        options:(tmpOption << 16)
                     animations:^{
                         [self updateKeyboardHeight:kbSize.height];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (!self.enabled) {
        return;
    }
    keyboardIsShown = NO;
    NSUInteger tmpOption = [[aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:[[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                          delay:0.0f
                        options:(tmpOption << 16)
                     animations:^{
                         [self updateKeyboardHeight:0.0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

@end
