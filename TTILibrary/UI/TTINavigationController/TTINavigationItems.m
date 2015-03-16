//
//  NavigationItems.m
//  iCNavigationController
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "TTINavigationItems.h"

@implementation TTINavigationItems

UIBarButtonItem * createNavigationButtonItem(NSString *text,
                                             NSString *normalImageName,
                                             NSString *highlightedImageName,
                                             NSString *selectedImageName,
                                             id       target,
                                             SEL      action) {
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [actionBtn setTitle:text forState:UIControlStateNormal];
    [actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (text.length) {
        actionBtn.frame = CGRectMake(0, 0, 44, 44);
        actionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }

    if (normalImageName) {
        //有图片则大小根据图片大小设置
        UIImage *imgDefault = [UIImage imageNamed:normalImageName];
        [actionBtn setFrame:CGRectMake(0, 0, imgDefault.size.width, imgDefault.size.height)];
        [actionBtn setBackgroundImage:imgDefault forState:UIControlStateNormal];
    }
    if (highlightedImageName) {
        UIImage *imgHighlighted = [UIImage imageNamed:highlightedImageName];
        [actionBtn setBackgroundImage:imgHighlighted forState:UIControlStateHighlighted];
    }
    if (selectedImageName) {
        UIImage *imgHighlighted = [UIImage imageNamed:selectedImageName];
        [actionBtn setBackgroundImage:imgHighlighted forState:UIControlStateSelected];
    }
    
    [actionBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:actionBtn];
}

@end
