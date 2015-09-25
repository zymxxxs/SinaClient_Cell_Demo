//
//  TBHomeViewCell.h
//  Sina_Weibo
//
//  Created by zym on 15/9/22.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusModel.h"

@interface TBStatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *created_at;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;

@property (nonatomic, strong) StatusModel *statusModel;

@end
