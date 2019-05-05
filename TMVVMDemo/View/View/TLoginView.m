//
//  TLoginView.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TLoginView.h"
#import "TLoginViewModel.h"
@interface TLoginView()

@end
@implementation TLoginView

#pragma mark - init methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    
}

- (void)setSubviewsLayout{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setSubviewsLayout];
}

#pragma mark - public

- (void)bindViewModel:(TLoginViewModel *)viewModel{
    
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter

@end
