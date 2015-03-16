//
//  AboveStatusView.h
//  SinaClient_Demo
//
//  Created by zym on 15/3/13.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTIRichLabel.h"


@interface AboveStatusView : UIView

@property (nonatomic, strong)TTIRichLabel *contentLabel;

-(void)initLayoutConstraint;
-(void)removeLayoutConstraint;

@end
