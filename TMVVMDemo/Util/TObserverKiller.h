//
//  TObserverKiller.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TObserverKiller : NSObject
@property (nonatomic, strong) NSObject *target;
@property (nonatomic, strong) NSObject *observer;
@property (nonatomic, strong) NSString *keyPath;
- (void)t_addObserver:(NSObject *)observer
               target:(NSObject *)target
              keyPath:(NSString *)keyPath;
@end
