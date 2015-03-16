//
//  TTIClient.h
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "TTIClientManager.h"

@interface TTIClient : TTIClientManager

/**
 *  单例
 *
 *  @return 单例
 */
+(TTIClient *)shareInstance;

/**
 *  获取oauth2的access_token接口
 *
 *  @param client_id     申请应用时分配的AppKey
 *  @param client_secret 申请应用时分配的AppSecret
 *  @param grant_type    请求的类型，填写authorization_code
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 */

-(void)accessTokenWithCode:(NSString *)code
              success:(TTIClientManagerBlock)success
              failure:(TTIClientManagerBlock)failure;
/**
 *  获取当前登录用户及其所关注用户的最新微博
 *
 *  @param source       采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey
 *  @param access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *  @param since_id     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *  @param max_id       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *  @param count        单页返回的记录条数，最大不超过100，默认为20。
 *  @param page         返回结果的页码，默认为1。
 *  @param base_app     是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *  @param feature      过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *  @param trim_user    返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。

 *  @param success      <#success description#>
 *  @param failure      <#failure description#>
 */


-(void)friendsTimelineWithsource:(NSString *)source
                    access_token:(NSString *)access_token
                    since_id:(int64_t)since_id
                    max_id:(int64_t)max_id
                    count:(int)count
                    page:(int)page
                    base_app:(int)base_app
                    feature:(int)feature
                    trim_user:(int)trim_user
                   success:(TTIClientManagerBlock)success
                   failure:(TTIClientManagerBlock)failure;


@end
