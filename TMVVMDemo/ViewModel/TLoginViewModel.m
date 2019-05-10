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
@property (nonatomic, strong) TLoginDataModel *dataModel;
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
    Weakify(self);
    self.command = [[TCommand alloc] initWithRequestBlock:^(id param, CompletionHandler completionHandler) {
        Strongify(self);
        [self.dataModel requestToLoginWithParam:param completionBlock:^(id responseObject, NSError *error) {
            SAFE_BLOCK(completionHandler,error,responseObject);
        }];
    }];
}

#pragma mark - public
- (void)bindDataModel:(TLoginDataModel *)dataModel{
    self.dataModel = dataModel;
}

- (void)dealloc{
    ASLog(@"viewModel dealloced");
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter
@end
