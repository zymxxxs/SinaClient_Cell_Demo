//
//  TBViewController.h
//  TBLibrary
//
//  Created by zym on 15/4/28.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  点击屏幕任何位置，隐藏键盘。
 *  快速设置backItem的title（系统pop手势不会失效）
 *  建议直接使用或者继承使用。
 */

@interface TBViewController : UIViewController

/**
 *  用于替代self.view使用、
 */
@property (nonatomic, strong) UIView *superView;

@end
