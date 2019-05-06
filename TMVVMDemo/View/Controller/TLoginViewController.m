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
    [self setSubviewsLayout];
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
    
    self.viewModel = [TLoginViewModel new];
    self.model = [TLoginDataModel new];
    
    [self.viewModel bindDataModel:self.model];
    [self refreshData];
    
    [self.viewModel addObserver:self forKeyPath:@"command.result" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.viewModel.command excute:@"hello world"];
   
}

- (void)dealloc{
    [self.viewModel removeObserver:self forKeyPath:@"command.result"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([@"name1" isEqualToString:keyPath] || [@"name2" isEqualToString:keyPath]) {
        if (change[NSKeyValueChangeNewKey]) {
//            [self refreshData];
            NSLog(@"---%@",change[NSKeyValueChangeNewKey]);
        }
    } else if ([@"command.result" isEqualToString:keyPath]){
        NSLog(@"请求的结果 : %@",self.viewModel.command.result.responseObject);
    }
}

- (void)refreshData{
    [self.loginView bindViewModel:self.viewModel];
}


- (void)setSubviewsLayout{
    
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter


@end
