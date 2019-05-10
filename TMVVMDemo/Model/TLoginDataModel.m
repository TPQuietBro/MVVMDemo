//
//  TLoginDataModel.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TLoginDataModel.h"
#import "TObserverDefine.h"
@interface TLoginDataModel()

@end
@implementation TLoginDataModel

#pragma mark - init methods
- (instancetype)init{
    if (self = [super init]) {
        [self initItems];
    }
    return self;
}

- (void)initItems{
    
}

- (void)requestToLoginWithParam:(id)param completionBlock:(void (^)(id, NSError *))block{
    NSLog(@"传入的参数是 : %@",param);
    // 模拟网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *result = [NSString stringWithFormat:@"%@ 登录成功了",param[@"username"]];
        block(result,nil);
    });
}

#pragma mark - getter / setter
@end
