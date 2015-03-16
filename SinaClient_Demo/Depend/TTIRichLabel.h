//
//  RichLabel.h
//  SinaClient_Demo
//
//  Created by zym on 15/3/11.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RichLinkType) {
    RichLinkTypeNone    = 0,
    RichLinkTypeUserName,
    RichLinkTypeTask,
    RichLinkTypeUrl
};

@interface TTIRichLabel : UILabel

@property (nonatomic) RichLinkType linkType;

@property (nonatomic, copy) void(^linkerHandler)(NSString *matchString, NSRange range,RichLinkType linktype);


@end
