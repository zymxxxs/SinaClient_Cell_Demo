//
//  WeiboCell.m
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "WeiboCell.h"
#import <UIImageView+WebCache.h>
#import "TTILibray.h"
#import "TwitterText.h"


@implementation WeiboCell

- (void)awakeFromNib {

    //设置相关属性
    self.headImageView.layer.cornerRadius = 20.0f;
    self.headImageView.layer.masksToBounds = YES;
    
    self.contentLabel.font = [TTIFont appFontWithSize:14];
    self.userName.font = [TTIFont appFontWithSize:15];
    self.create_atLabel.font = [TTIFont appFontWithSize:12];
    
    self.userName.textColor = [UIColor colorForHex:@"9B59B6"];
    
    self.contentLabelBottomConstraint = [NSLayoutConstraint
                                         constraintWithItem:_contentLabel
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.contentView
                                         attribute:NSLayoutAttributeBottom
                                         multiplier:1.0f
                                         constant:- 8.0f];
}


-(void)reloadStatusModel:(StatusModel *)model
{
    //设置相关字段
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_large]];
    self.userName.text = model.user.screen_name;
    self.create_atLabel.text = [self timeReversal:model.created_at];
    self.fromSource.text = [TTIFormatValidate validateHref:model.source];
    self.contentLabel.text = model.text;
    
    if (model.retweeted_status) {

        //只是为了不出现恶心的警告
        [_aboveStatusView initLayoutConstraint];
        
        if (![self.contentView.constraints containsObject:_abouveStatusViewTopConstraint]) {
            [self.contentView addConstraint:self.abouveStatusViewTopConstraint];
        }
        if (![self.contentView.constraints containsObject:_abouveStatusViewLeftConstraint]) {
            [self.contentView addConstraint:_abouveStatusViewLeftConstraint];
        }
        if (![self.contentView.constraints containsObject:_abouveStatusViewBottomConstraint]) {
            [self.contentView addConstraint:_abouveStatusViewBottomConstraint];
        }
        if (![self.contentView.constraints containsObject:_abouveStatusViewRightConstraint]) {
            [self.contentView addConstraint:_abouveStatusViewRightConstraint];
        }
        if ([self.contentView.constraints containsObject:_contentLabelBottomConstraint]) {
            [self.contentView removeConstraint:_contentLabelBottomConstraint];
        }


        self.aboveStatusView.hidden = NO;
        NSString *retweeted_statusText = [NSString stringWithFormat:@"@%@：%@",model.retweeted_status.user.screen_name,model.retweeted_status.text];
        self.aboveStatusView.contentLabel.text = retweeted_statusText;
        
    }else
    {
        
        //只是为了不出现恶心的警告
        [_aboveStatusView removeLayoutConstraint];
        
        if ([self.contentView.constraints containsObject:_abouveStatusViewTopConstraint]) {
            [self.contentView removeConstraint:_abouveStatusViewTopConstraint];
        }
        if ([self.contentView.constraints containsObject:_abouveStatusViewLeftConstraint]) {
            [self.contentView removeConstraint:_abouveStatusViewLeftConstraint];
        }
        if ([self.contentView.constraints containsObject:_abouveStatusViewBottomConstraint]) {
            [self.contentView removeConstraint:_abouveStatusViewBottomConstraint];
        }
        if ([self.contentView.constraints containsObject:_abouveStatusViewRightConstraint]) {
            [self.contentView removeConstraint:_abouveStatusViewRightConstraint];
        }
        if (![self.contentView.constraints containsObject:_contentLabelBottomConstraint]) {
            [self.contentView addConstraint:_contentLabelBottomConstraint];
        }

        
        self.aboveStatusView.hidden = YES;
        self.aboveStatusView.contentLabel.text = @"";
        
    }
}



-(void)updateConstraints
{
    [super updateConstraints];
    self.contentLabel.preferredMaxLayoutWidth = UIScreenWidth - 40;
}

/**
 *  格林威治时间转换
 *
 *  @param datestring 时间
 */
-(NSString *)timeReversal:(NSString *)datestring
{

    NSString *localDateString = nil;
    
    NSDateFormatter *eeZoneFormatter = [NSDateFormatter new];
    eeZoneFormatter.dateFormat  = @"EEE MMM dd HH:mm:ss zzz yyyy";
    NSDate *date=[eeZoneFormatter dateFromString:datestring];
    
    
    NSTimeInterval distance = [[NSDate date] timeIntervalSinceDate:date];
    
    if (distance < 0){
        distance = 0;
    }
    
    if (distance < 60) {
        localDateString = [NSString stringWithFormat:@"%.0f%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        localDateString = [NSString stringWithFormat:@"%.0f%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        localDateString = [NSString stringWithFormat:@"%.0f%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        localDateString = [NSString stringWithFormat:@"%.0f%@", distance, (distance == 1) ? @"天前" : @"天前"];
    }else
    {
        NSDateFormatter *newformatter = [[NSDateFormatter alloc] init];
        [newformatter setDateStyle:NSDateFormatterMediumStyle];
        [newformatter setTimeStyle:NSDateFormatterShortStyle];
        [newformatter setDateFormat:@"YY-MM-dd HH:mm"];
        localDateString  = [newformatter stringFromDate:date];
    }
    
    return localDateString;
}


@end
