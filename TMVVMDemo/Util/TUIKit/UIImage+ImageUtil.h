//
//  UIImage+ImageUtil.h
//  ZNovel
//
//  Created by 唐鹏 on 2019/4/2.
//  Copyright © 2019 ZNovel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageUtil)

/**
 生成纯色图片

 @param color 传入的颜色
 @return 一张纯色图
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
