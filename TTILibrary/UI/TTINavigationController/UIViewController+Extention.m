//
//  UIViewController+Extention.m
//  hx
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "UIViewController+Extention.h"

@implementation UIViewController (Extention)

- (void)customizeNavigationBar:(UIImage *)image_ios6 image_ios7:(UIImage *)image_ios7  shadow:(BOOL)hidden;

{
    //IOS7+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0f) {
        
        [self.navigationController.navigationBar setBackgroundImage:image_ios7 forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
        
    }else{
        
        [self.navigationController.navigationBar setBackgroundImage:image_ios6 forBarMetrics:UIBarMetricsDefault];
        
    }
    
    if (hidden) {
        self.navigationController.navigationBar.clipsToBounds = YES;
    }
}


@end
