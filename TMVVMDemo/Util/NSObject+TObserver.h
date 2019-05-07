//
//  NSObject+TObserver.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#define T_Observe(target,keypath) [target addObserver:self keyPath:@t_keypath(target,keypath)]

typedef void(^Handler)(id newValue,id observer);

@interface NSObject (TObserver)
- (NSObject *)addObserver:(NSObject *)observer keyPath:(NSString *)keyPath;
- (void)statusChangeHandler:(Handler)handler;

@end

