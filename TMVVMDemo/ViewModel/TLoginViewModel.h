//
//  TLoginViewModel.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCommand.h"
@class TLoginDataModel;
@interface TLoginViewModel : NSObject
@property (nonatomic, strong, readonly) NSString *name1;
@property (nonatomic, strong, readonly) NSString *name2;
@property (nonatomic, strong) TCommand *command;
- (void)bindDataModel:(TLoginDataModel *)dataModel;
@end
