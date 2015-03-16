//
//  TTIViewController.m
//  youlvshi
//
//  Created by zym on 14-8-14.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "TTIViewController.h"

@interface TTIViewController ()

@end

@implementation TTIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //点击屏幕任意位置取消键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
    
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    
}

-(void)tapPressed
{
    [self.view endEditing:YES];
}


@end
