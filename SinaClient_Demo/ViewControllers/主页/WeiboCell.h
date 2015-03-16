//
//  WeiboCell.h
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusModel.h"
#import "TTIRichLabel.h"
#import "AboveStatusView.h"
#import <MASConstraint.h>

@interface WeiboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *create_atLabel;
@property (weak, nonatomic) IBOutlet TTIRichLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromSource;
@property (weak, nonatomic) IBOutlet AboveStatusView *aboveStatusView;
@property (strong, nonatomic) NSLayoutConstraint *contentLabelBottomConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *abouveStatusViewLeftConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *abouveStatusViewTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *abouveStatusViewRightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *abouveStatusViewBottomConstraint;


-(void)reloadStatusModel:(StatusModel *)model;


@end
