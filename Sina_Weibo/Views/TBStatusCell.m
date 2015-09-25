//
//  TBHomeViewCell.m
//  Sina_Weibo
//
//  Created by zym on 15/9/22.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//

#import "TBStatusCell.h"
#import "TBLibraryHeader.h"
#import "TBStatusView.h"

@interface TBStatusCell ()

@property (nonatomic, strong) TBStatusView *statusView;
@property (nonatomic, strong) TBStatusView *retweetedStatusView;

@property (nonatomic, strong) MASConstraint *statusBottomConstraint;
@property (nonatomic, strong) MASConstraint *retweetedstatusBottomConstraint;
@property (nonatomic, strong) MASConstraint *retweetedstatusTopConstraint;

@end

@implementation TBStatusCell

- (void)awakeFromNib {
    
    self.avatar.layer.cornerRadius = 22.f;
    self.avatar.clipsToBounds = YES;
    self.screen_name.textColor = [UIColor colorForHex:@"9B59B6"];
    
    self.statusView = [TBStatusView new];
    [self.contentView addSubview:self.statusView];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatar.mas_bottom);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        self.statusBottomConstraint = make.bottom.mas_equalTo(self.contentView);
    }];
    
    self.retweetedStatusView = [TBStatusView new];
    self.retweetedStatusView.backgroundColor = [UIColor colorForHex:@"f3f3f3"];
    self.retweetedStatusView.text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.retweetedStatusView];
    
    [self.retweetedStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.retweetedstatusTopConstraint = make.top.mas_equalTo(self.statusView.mas_bottom);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        self.retweetedstatusBottomConstraint = make.bottom.mas_equalTo(self.contentView);
    }];
    
    @weakify(self)
    [RACObserve(self, statusModel) subscribeNext:^(StatusModel *model) {
        @strongify(self)
        self.statusView.text.text = model.text;
        self.created_at.text = [self timeReversal:model.created_at];
        self.screen_name.text = model.user.screen_name;
        self.source.text = [self validateHref:model.source];
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_large]];
        
        
        if (model.retweeted_status) {
            NSString *retweeted_statusText = [NSString stringWithFormat:@"@%@:%@",model.retweeted_status.user.screen_name,model.retweeted_status.text];
            self.retweetedStatusView.text.text = retweeted_statusText;
            
            [self.statusBottomConstraint uninstall];
            [self.retweetedstatusBottomConstraint install];
            self.retweetedStatusView.hidden = NO;
        }else{
            [self.statusBottomConstraint install];
            [self.retweetedstatusBottomConstraint uninstall];
            self.retweetedStatusView.hidden = YES;
        }
    }];
    

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
    eeZoneFormatter.dateFormat  = @"EEE MMM dd HH:mm:ss z yyyy";
    //必须设置，否则无法解析
    eeZoneFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
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

- (NSString *)validateHref:(NSString *)string
{
    if (!string.length) {
        return @"";
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=.*?>(.*?)</a>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@"$1"];
    return modifiedString;
    
    //@用户名   @[\u4e00-\u9fa5a-zA-Z0-9_-]{4,30}   (@([\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))
    //＃＃ #[^#]+#  (#[\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+#)
    //url (%s*r)+|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)
}

@end
