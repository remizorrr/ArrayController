//
//  UIImage+Icon.h
//  Vacarious
//
//  Created by Anton Remizov on 12/5/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Icon)

+ (UIImage*) imageWithIcon:(UIImage*)icon ofSize:(CGSize)size background:(UIColor*)background blend:(UIColor*)blend;
+ (UIImage*) imageWithIcon:(UIImage*)icon ofSize:(CGSize)size blend:(UIColor*)blend;

@end
