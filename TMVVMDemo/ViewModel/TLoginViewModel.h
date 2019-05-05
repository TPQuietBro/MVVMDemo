//
//  TLoginViewModel.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TLoginDataModel;
@interface TLoginViewModel : NSObject
- (void)bindDataModel:(TLoginDataModel *)dataModel;
@end
