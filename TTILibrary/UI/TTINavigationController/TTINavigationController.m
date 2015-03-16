//
//  TTINavigationController
//  TTINavigationController
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "TTINavigationController.h"
#import "TTINavigationItems.h"
#import "UIColor+Utils.h"
#import "AppMacro.h"

#define NAVIGATIONBAR_BG @"navigationBar_BG"
#define NAVIGATIONBAR_LEFTITEM_IMAGE @"navgationBar_backIcon"

@interface TTINavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation TTINavigationController

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
    
    //背景图片设置
    
    
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NAVIGATIONBAR_BG] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    //字体设置
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0f],NSForegroundColorAttributeName : [UIColor blackColor]}];
    
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    

/*************************/
    //该处为IOS7的左滑收拾如果需要，打开即可。
    
    //IOS7系统原生的右划返回上层
    //对系统的leftBarButtonItem自定义之后，改手势失效，需要重新代理。
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        
//        self.interactivePopGestureRecognizer.delegate = self;
//    }
    
    
/************************/
    
}

#pragma mark - 重载父类进行改写
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //先进入子Controller
    [super pushViewController:viewController animated:animated];
    
    //替换掉leftBarButtonItem
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        
        //也可以使用自定义方法创建leftItem
        viewController.navigationItem.leftBarButtonItem = [self customLeftBackButton];
        
    }
    

}

#pragma mark - 自定义返回按钮图片
-(UIBarButtonItem *)customLeftBackButton{
    
    UIImage *image = [UIImage imageNamed:NAVIGATIONBAR_LEFTITEM_IMAGE];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:image forState:UIControlStateNormal];

    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0,30);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    return backItem;
;
    
}

#pragma mark - 返回按钮事件(pop)
-(void)popViewController
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


@end
