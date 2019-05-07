//
//  TLoginViewController.m
//  TMVVMDemo
//
//  Created by 唐鹏 on 2019/5/5.
//  Copyright © 2019 唐鹏. All rights reserved.
//

#import "TLoginViewController.h"
#import "TLoginView.h"
#import <Masonry.h>
#import "TLoginDataModel.h"
#import "TLoginViewModel.h"

@interface TLoginViewController ()
@property (nonatomic, strong) TLoginView *loginView;
@property (nonatomic, strong) TLoginDataModel *model;
@property (nonatomic, strong) TLoginViewModel *viewModel;
@end

@implementation TLoginViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    
}
#pragma mark - init methods

- (void)initSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    TLoginView *loginView = [TLoginView new];
    loginView.layer.cornerRadius = 4;
    loginView.layer.masksToBounds = YES;
    [self.view addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(280, 100));
    }];
    
    self.loginView = loginView;
    
    self.model = [TLoginDataModel new];
    self.viewModel = [TLoginViewModel new];
    
    // viewModel 绑定model
    [self.viewModel bindDataModel:self.model];
    
    // view 绑定 viewModel
    [self.loginView bindViewModel:self.viewModel];
    
    
    // 执行操作
    [self.viewModel.command excute:@"hello world"];
}



@end
