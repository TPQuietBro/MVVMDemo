//
//  TCommand.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/6.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(NSError *error,id responseObject);

typedef void(^RequestBlock)(id param,CompletionHandler completionHandler);

typedef void(^CancelRequestBlock)(void);

@interface TCommandResult : NSObject
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id responseObject;
@end

@interface TCommand : NSObject
@property (nonatomic, assign, readonly) BOOL isLoading;
@property (nonatomic, strong, readonly) TCommandResult *result;
- (instancetype)initWithRequestBlock:(RequestBlock)requestBlock;
- (instancetype)initWithRequestBlock:(RequestBlock)requestBlock cancelBlock:(CancelRequestBlock)cancelBlock;
- (void)excute:(id)param;
- (void)cancel;
@end
