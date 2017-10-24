//
//  UIImage+Icon.m
//  Vacarious
//
//  Created by Anton Remizov on 12/5/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import "UIImage+Icon.h"

@implementation UIImage (Icon)

+ (UIImage*) imageWithIcon:(UIImage*)icon ofSize:(CGSize)size background:(UIColor*)background blend:(UIColor*)blend {
    
    UIImage* blendedIconImage = [self imageWithIcon:icon ofSize:size blend:blend];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [background setFill];
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), blendedIconImage.CGImage);
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImg;
}

+ (UIImage*) imageWithIcon:(UIImage*)icon ofSize:(CGSize)size blend:(UIColor*)blend {
    // begin a new image context, to draw our colored image onto with the right scale
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    // set the fill color
    [blend setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake((size.width - icon.size.width)/2.0,
                             (size.height - icon.size.height)/2.0,
                             icon.size.width, icon.size.height);
    
    CGContextDrawImage(context, rect, icon.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

@end
