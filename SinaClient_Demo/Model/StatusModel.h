//
//  StatusModel.h
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "JSONModel.h"
#import "GeoModel.h"
#import "UserModel.h"

@interface StatusModel : JSONModel


@property (nonatomic, strong) NSString *created_at;             //微博创建时间
@property (nonatomic) int64_t id;                               //微博ID
@property (nonatomic) int64_t mid;                              //微博MID
@property (nonatomic, strong) NSString *idstr;                  //字符串型的微博ID
@property (nonatomic, strong) NSString *text;                   //微博信息内容
@property (nonatomic, strong) NSString *source;                 //微博来源
@property (nonatomic) BOOL favorited;                           //是否已收藏，true：是，false：否
@property (nonatomic) BOOL truncated;                           //是否被截断，true：是，false：否
@property (nonatomic, strong) NSString *in_reply_to_status_id;  //(暂未支持）回复ID
@property (nonatomic, strong) NSString *in_reply_to_user_id;    //（暂未支持）回复人UID
@property (nonatomic, strong) NSString *in_reply_to_screen_name;//（暂未支持）回复人昵称
@property (nonatomic, strong) NSString *thumbnail_pic;          //缩略图片地址，没有时不返回此字段
@property (nonatomic, strong) NSString *bmiddle_pic;            //中等尺寸图片地址，没有时不返回此字段
@property (nonatomic, strong) NSString *original_pic;           //原始图片地址，没有时不返回此字段
@property (nonatomic, strong) GeoModel *geo;                    //地理信息字段
@property (nonatomic, strong) UserModel *user;                  //微博作者的用户信息字段
@property (nonatomic, strong) StatusModel *retweeted_status;       //被转发的原微博信息字段，当该微博为转发微博时返回
@property (nonatomic) int reposts_count;                        //转发数
@property (nonatomic) int comments_count;                       //评论数
@property (nonatomic) int attitudes_count;                      //表态数
@property (nonatomic) int mlevel;                               //暂未支持
@property (nonatomic, strong) NSObject *visible;                //微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
@property (nonatomic, strong) NSObject *pic_ids;                //微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
@property (nonatomic, strong) NSArray *ad;                      //微博流内的推广微博ID

@end
