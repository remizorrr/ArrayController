//
//  VCRTextView.h
//  Vacarious
//
//  Created by Anton Remizov on 11/9/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTextView : UITextView

@property (nonatomic, strong) NSString* placeholderText;
@property (nonatomic, strong) UIColor* placeholderTextColor;
@property (nonatomic, assign) IBInspectable BOOL autoresize;
- (void) setDefaultText;

@end
