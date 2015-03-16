//
//  UINavigationItem+margin.m
//  iCNavigationController
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "UINavigationItem+margin.h"
#import "AppMacro.h"

#define ios7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?YES:NO)

@implementation UINavigationItem (margin)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0


- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem

{
    if (ios7) {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        
        negativeSpacer.width = -7;
        if (iPhone6P) {
            negativeSpacer.width = -10;
        }
        [self setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem,nil]];
        
    } else {
        
        [self setLeftBarButtonItem:leftBarButtonItem];
        
    }
    
}



- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem

{
    
    if (ios7) {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem,nil]];
        
    } else {
        
        
        [self setRightBarButtonItem:rightBarButtonItem];
        
    }
    
}

#endif
@end
