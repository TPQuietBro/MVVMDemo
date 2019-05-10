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
#import "TObserver.h"

@interface TLoginViewController ()
@property (nonatomic, strong) TLoginView *loginView;
@property (nonatomic, strong) TLoginDataModel *model;
@property (nonatomic, strong) TLoginViewModel *viewModel;
@property (nonatomic, strong) TObserverAgent *kvoAgent;

@property (nonatomic, strong) UILabel *resultLabel;
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
        make.size.mas_equalTo(CGSizeMake(280, 140));
    }];
    
    self.loginView = loginView;
    
    self.model = [TLoginDataModel new];
    self.viewModel = [TLoginViewModel new];
    
    // viewModel 绑定model
    [self.viewModel bindDataModel:self.model];
    
    // view 绑定 viewModel
    [self.loginView bindViewModel:self.viewModel];

    // 监听网络回调
    Weakify(self);
    self.kvoAgent = [[TObserverAgent alloc] init];
    [self.kvoAgent t_addObserverForTarget:self.viewModel keyPath:@t_keypath(self.viewModel,command.result) handler:^(NSDictionary *change, id target, NSString *keyPath) {
        Strongify(self);
        TCommandResult *newValue = change[NSKeyValueChangeNewKey];
        [self.resultLabel setText:newValue.responseObject];
    }];
    
    
    // 显示结果
    [self.view addSubview:self.resultLabel];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (UILabel *)resultLabel{
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.textColor = [UIColor purpleColor];
        _resultLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _resultLabel;
}


@end
