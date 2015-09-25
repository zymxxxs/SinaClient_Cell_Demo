//
//  UINavigationItem+margin.m
//  toubei_iOS
//
//  Created by zym on 15/6/17.
//  Copyright (c) 2015年 toubei_zym. All rights reserved.
//

#import "UINavigationItem+margin.h"

@implementation UINavigationItem (margin)


-(void)setLeftBarButtonItem:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName]
                                                                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:target
                                                                      action:action];
    UIBarButtonItem *flexBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil
                                                                                       action:nil];
    flexBarButtonItem.width = -8.f;
    [self setLeftBarButtonItems:@[flexBarButtonItem,leftButtonItem]];
}


-(void)setRightBarButtonItem:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName]
                                                                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:target
                                                                      action:action];
    UIBarButtonItem *flexBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil
                                                                                       action:nil];
    flexBarButtonItem.width = -8.f;
    [self setRightBarButtonItems:@[flexBarButtonItem,rightButtonItem]];
}
@end
