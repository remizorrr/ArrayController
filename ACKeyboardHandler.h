//
//  ACKeyboardHandler.h
//  Vacarious
//
//  Created by Anton Remizov on 11/14/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACKeyboardHandler : NSObject

- (instancetype)initWithKeyboardAnimateBlock:(void(^)(CGFloat height))animateKeyboardHeightChange;

@property (nonatomic, copy) void(^animateKeyboardHeightChange)(CGFloat height);
@property (nonatomic, assign) BOOL enabled;

@end
