//
//  TBWeiBoLabel.h
//  Sina_Weibo
//
//  Created by zym on 15/9/23.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TBWeiboLinkType) {
    TBWeiboLinkTypeNone    = 0,
    TBWeiboLinkTypeAccount,
    TBWeiboLinkTypeTopic,
    TBWeiboLinkTypeURL
};

@interface TBWeiBoLabel : UILabel

@property (nonatomic) TBWeiboLinkType linkType;


@end
