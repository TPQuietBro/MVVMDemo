//
//  TLoginDataModel.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCommand.h"
@interface TLoginDataModel : NSObject
- (void)requestToLoginWithParam:(id)param completionBlock:(void(^)(id responseObject,NSError *error))block;
@end
