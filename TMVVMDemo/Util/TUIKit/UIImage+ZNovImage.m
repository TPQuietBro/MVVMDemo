//
//  UIImage+ZNovImage.m
//  ZNovel
//
//  Created by 唐鹏 on 2019/4/2.
//  Copyright © 2019 ZNovel. All rights reserved.
//

#import "UIImage+ZNovImage.h"

@implementation UIImage (ZNovImage)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

@end
