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
    self.command = [[TCommand alloc] initWithRequestBlock:^(id param, CompletionHandler completionHandler) {
        NSLog(@"传入的参数是 : %@",param);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completionHandler(nil,@"request success");
        });
    }];
}

#pragma mark - public
- (void)bindDataModel:(TLoginDataModel *)dataModel{
    self.dataModel = dataModel;
    __weak typeof(self) weak_self = self;
    [self.dataModel handleData:^(NSString *data) {
        weak_self.name1 = data;
    }];
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter
@end
