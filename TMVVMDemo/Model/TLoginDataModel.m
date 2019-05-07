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

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private
- (void)handleData:(void (^)(id))block{
    SAFE_BLOCK(block,@"这是初始值");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SAFE_BLOCK(block,@"数据改变了被监听到了");
    });
}
#pragma mark - getter / setter
@end
