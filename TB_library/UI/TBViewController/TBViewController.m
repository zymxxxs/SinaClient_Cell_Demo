//
//  TBViewController.m
//  TBLibrary
//
//  Created by zym on 15/4/28.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "TBViewController.h"

@interface TBViewController ()

@end

@implementation TBViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //点击屏幕任意位置取消键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}


-(UIView *)superView
{
    return self.view;
}

-(void)tapPressed
{
    [self.view endEditing:YES];
}




@end
