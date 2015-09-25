//
//  AboveStatusView.m
//  Sina_Weibo
//
//  Created by zym on 15/9/25.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//

#import "TBStatusView.h"

@implementation TBStatusView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.text = [TBWeiBoLabel new];
        self.text.numberOfLines = 0;
        self.text.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
        [self addSubview:self.text];
        
        [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(6);
            make.left.mas_equalTo(self).mas_offset(10);
            make.right.mas_equalTo(self).mas_offset(-10);
            make.bottom.mas_equalTo(self).mas_offset(-6).priorityLow();
        }];
        
    }
    return self;
}

@end
