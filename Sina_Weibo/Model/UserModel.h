//
//  UserModel.h
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StatusModel;

@interface UserModel : NSObject

@property (nonatomic) int64_t id;                       //用户UID
@property (nonatomic, strong) NSString *idstr;          //字符串型的用户UID
@property (nonatomic, strong) NSString *screen_name;        //用户昵称
@property (nonatomic, strong) NSString *name;       //友好显示名称
@property (nonatomic) int province;         //用户所在省级ID
@property (nonatomic) int city;                 //用户所在城市ID
@property (nonatomic, strong) NSString *location;//用户所在地
@property (nonatomic, strong) NSString *avatar_large;//用户头像地址（大图），180×180像素
@property (nonatomic, strong) NSString *avatar_hd;//用户头像地址（高清），高清头像原图
@property (nonatomic, strong) NSString *description_user;//用户个人描述
@property (nonatomic, strong) NSString *url;//用户博客地址
@property (nonatomic, strong) NSString *profile_image_url;//用户头像地址（中图），50×50像素
@property (nonatomic, strong) NSString *profile_url;//用户的微博统一URL地址
@property (nonatomic, strong) NSString *domain;//用户的个性化域名
@property (nonatomic, strong) NSString *weihao;//用户的微号
@property (nonatomic, strong) NSString *gender;//性别，m：男、f：女、n：未知
@property (nonatomic) int followers_count;//粉丝数
@property (nonatomic) int friends_count;//关注数
@property (nonatomic) int statuses_count;//微博数
@property (nonatomic) int favourites_count;//收藏数
@property (nonatomic, strong) NSString *created_at;//用户创建（注册）时间
@property (nonatomic) BOOL following;//暂未支持
@property (nonatomic) BOOL allow_all_act_msg;//是否允许所有人给我发私信，true：是，false：否
@property (nonatomic) BOOL geo_enabled;//是否允许标识用户的地理位置，true：是，false：否
@property (nonatomic) BOOL verified;//是否是微博认证用户，即加V用户，true：是，false：否
@property (nonatomic) int verified_type;//暂未支持
@property (nonatomic, strong) NSString *remark;//用户备注信息，只有在查询用户关系时才返回此字段
@property (nonatomic, strong) StatusModel *status;//用户的最近一条微博信息字段
@property (nonatomic) BOOL allow_all_comment;//是否允许所有人对我的微博进行评论，true：是，false：否
@property (nonatomic, strong) NSString *verified_reason;//认证原因
@property (nonatomic) BOOL follow_me;//该用户是否关注当前登录用户，true：是，false：否
@property (nonatomic) int online_status;//用户的在线状态，0：不在线、1：在线
@property (nonatomic) int bi_followers_count;//用户的互粉数
@property (nonatomic, strong) NSString *lang;//用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语


@end
