//
//  TObserverInfo.h
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/8.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TObserverKiller;
@interface TObserverInfo : NSObject
@property (nonatomic, strong) NSObject *target;
@property (nonatomic, strong) NSString *keyPath;
- (instancetype)initWithObserverKiller:(TObserverKiller *)killer;
@end
