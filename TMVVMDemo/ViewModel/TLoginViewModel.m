//
//  TLoginViewModel.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TLoginViewModel.h"
#import "TLoginDataModel.h"

@interface TLoginViewModel()

@end
@implementation TLoginViewModel

#pragma mark - init methods
- (instancetype)init{
    if (self = [super init]) {
        [self initItems];
    }
    return self;
}

- (void)initItems{
    
}

#pragma mark - public
- (void)bindDataModel:(TLoginDataModel *)dataModel{
    
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter
@end
