//
//  TLoginView.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TLoginViewModel;
@interface TLoginView : UIView
- (void)bindViewModel:(TLoginViewModel *)viewModel;
@end
