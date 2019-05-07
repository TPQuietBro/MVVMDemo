//
//  NSObject+TObserver.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#define T_Observe(target,keypath) [target addObserver:self keyPath:@t_keypath(target,keypath)]

typedef void(^Handler)(id newValue);

@interface NSObject (TObserver)
@property (nonatomic, strong) Handler handler;
- (NSObject *)addObserver:(id)observer keyPath:(NSString *)keyPath;
- (void)statusChangeHandler:(void(^)(id newValue))handler;
@end

