//
//  StatusModel.h
//  Sina_Weibo
//
//  Created by zym on 15/9/23.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface StatusModel : NSObject

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic) int64_t id;
@property (nonatomic) int64_t mid;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic) BOOL favorited;
@property (nonatomic) BOOL truncated;
@property (nonatomic, copy) NSString *in_reply_to_status_id;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic) int reposts_count;
@property (nonatomic) int comments_count;
@property (nonatomic) int attitudes_count;
@property (nonatomic) int mlevel;
@property (nonatomic, strong) StatusModel *retweeted_status;

@end
