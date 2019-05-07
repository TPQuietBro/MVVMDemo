//
//  TCommand.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/6.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TCommand.h"

@implementation TCommandResult

@end

@interface TCommand()
@property (nonatomic, strong) CancelRequestBlock cancelBlock;
@property (nonatomic, strong) RequestBlock requestBlock;
@property (nonatomic, strong) TCommandResult *result;
@property (nonatomic, assign) BOOL isLoading;
@end
@implementation TCommand

#pragma mark - init methods
- (instancetype)initWithRequestBlock:(RequestBlock)requestBlock{
    self = [super init];
    if (self) {
        _requestBlock = [requestBlock copy];
    }
    return self;
}

- (instancetype)initWithRequestBlock:(RequestBlock)requestBlock cancelBlock:(CancelRequestBlock)cancelBlock{
    self = [super init];
    if (self) {
        _requestBlock = [requestBlock copy];
        _cancelBlock = [cancelBlock copy];
    }
    return self;
}

- (void)setResultBlock:(CompletionHandler)resultBlock{
    _requestBlock = [resultBlock copy];
}

- (void)excute:(id)param{
    self.isLoading = YES;
    __weak typeof(self) weak_self = self;
    SAFE_BLOCK(self.requestBlock,param,^(NSError *error,id result){
        __strong typeof(weak_self) strong_self = weak_self;
        strong_self.isLoading = NO;
        // 监听readonly属性
        [self willChangeValueForKey:@"result"];
        strong_self.result.error = error;
        strong_self.result.responseObject = result;
        [self didChangeValueForKey:@"result"];
    });
}

- (void)cancel{
    SAFE_BLOCK(self.cancelBlock);
}

#pragma mark - getter

- (TCommandResult *)result{
    if (!_result) {
        _result = [[TCommandResult alloc] init];
    }
    return _result;
}

@end
