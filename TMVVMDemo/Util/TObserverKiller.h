//
//  TObserverKiller.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/7.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TObserverKiller : NSObject
- (void)t_addObserver:(NSObject *)observer keyPath:(NSString *)keyPath;
- (void)t_removeAllObserver;
- (void)t_removeObserver:(NSObject *)observer keyPath:(NSString *)keyPath;
@end
