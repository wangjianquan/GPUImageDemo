//
//  ViewController.m
//  WjqGUImageDemo
//
//  Created by landixing on 2017/3/22.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "ViewController.h"
#import "CustomGPUImageViewController.h"
#import "customVC.h"
#import "CustomFirstGPUImageFilterViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

@interface ViewController ()<GPUImageMovieDelegate>
{

    GPUImageVideoCamera * videoCamera;//滤镜
    GPUImageSepiaFilter * filter;
    NSURL * movieURL;
    GPUImageMovieWriter * movieWriter;
}

@property (strong , nonatomic) UIButton * action;
@property (strong , nonatomic) UIButton * customBtn;
@property (strong , nonatomic) GPUImageMovie * movie;
@property (strong , nonatomic) GPUImageView * imageView;

@property (strong , nonatomic) AVPlayer * theAudioPlayer;



@property (strong , nonatomic) NSURL * url;
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton * action = [UIButton buttonWithType:UIButtonTypeCustom];
    [action setTitle:@"滤镜组合" forState:UIControlStateNormal];
    [action setTintColor:[UIColor whiteColor]];
    [action setBackgroundColor:[UIColor blackColor]];
    [action addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:action];
    _action = action;
    WS(weakSelf);
    [self.action  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(20);
        make.left.equalTo(weakSelf.view).offset(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    UIButton * customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setTitle:@"自定义美白效果" forState:UIControlStateNormal];
    [customBtn addTarget:self action:@selector(custBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [customBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:customBtn];
    _customBtn = customBtn;
    [_customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(action.mas_bottom).offset(50);
        make.leading.equalTo(action);
        make.trailing.equalTo(action);
        make.height.mas_equalTo(40);
    }];
    
    UIButton * customBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn2 addTarget:self action:@selector(customBtn2Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [customBtn2 setTitle:@"滤镜样式" forState:UIControlStateNormal];
    [customBtn2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:customBtn2];
    [customBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(customBtn.mas_bottom).offset(50);
        make.leading.equalTo(customBtn);
        make.trailing.equalTo(customBtn);
        make.height.mas_equalTo(40);
    }];
    
}


- (void)actionClick:(UIButton * )sender{
    
    CustomGPUImageViewController * controlelr = [[CustomGPUImageViewController alloc]initWithNibName:@"CustomGPUImageViewController" bundle:nil];    
    
     [self.navigationController pushViewController:controlelr animated:YES];
}

//自定义样式
- (void)custBtnClick:(UIButton *)sender
{
    CustomFirstGPUImageFilterViewController * vc =[[ CustomFirstGPUImageFilterViewController alloc]initWithNibName:@"CustomFirstGPUImageFilterViewController" bundle:nil];
    
    [self  presentViewController:vc animated:YES completion:nil];
}

- (void)customBtn2Click:(UIButton *)sender{
    customVC * controlelr = [[customVC alloc]init];
    [self.navigationController pushViewController:controlelr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
