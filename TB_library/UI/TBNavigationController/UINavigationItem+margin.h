//
//  UINavigationItem+margin.h
//  toubei_iOS
//
//  Created by zym on 15/6/17.
//  Copyright (c) 2015年 toubei_zym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (margin)


-(void)setLeftBarButtonItem:(NSString *)imageName target:(id)target action:(SEL)action;
-(void)setRightBarButtonItem:(NSString *)imageName target:(id)target action:(SEL)action;

@end
