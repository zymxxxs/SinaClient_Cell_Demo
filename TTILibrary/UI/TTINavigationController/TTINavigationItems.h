//
//  TTINavigationItems.h
//  iCNavigationController
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTINavigationItems : NSObject


/**
 *  自定义UIBarButtonItem
 *
 *  @param text                 内容
 *  @param normalImageName      默认图
 *  @param highlightedImageName 高粱图
 *  @param selectedImageName    选中图
 *  @param target               target
 *  @param action               方法
 *
 *  @return UIBarButtonItem
 */
UIBarButtonItem * createNavigationButtonItem(NSString *text,
                                             NSString *normalImageName,
                                             NSString *highlightedImageName,
                                             NSString *selectedImageName,
                                             id target ,
                                             SEL action);


@end
