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
@property (nonatomic, strong) NSString *name1;
@property (nonatomic, strong) NSString *name2;
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
    [dataModel handleData:^(NSArray *data) {
        self.name1 = data.firstObject;
        self.name2 = data.lastObject;
    }];
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter
@end
