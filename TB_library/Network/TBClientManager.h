//
//  TTIClient.h
//  AFNetWorkingDemo
//
//  Created by zym on 14-8-8.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBClientConfig.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@class TBClientManager;

typedef void(^ TBClientManagerBlock)(AFHTTPRequestOperation *operetion,id response);

@interface TBClientManager : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;   //网络请求管理


/**
 *  通用的解析方法
 *  1、继承直接调用即可。
 *  2、如果需要其他解析方式，可以继承重写，或者在子类写其他解析方法。
 *
 *  @param response  返回数据
 *  @param operation 请求
 *  @param success   成功block
 *  @param failure   失败block
 */
-(void)parseResponse:(id)response
           operation:(AFHTTPRequestOperation *)operation
             success:(void(^)(AFHTTPRequestOperation *operetion,id response))success
             failure:(void(^)(AFHTTPRequestOperation *operetion,id response))failure;

/**
 *  单例
 *
 *  @return 单例
 */
+(TBClientManager *)manager;

#pragma mark - HTTP API


-(void)accessTokenWithCode:(NSString *)code
                   success:(TBClientManagerBlock)success
                   failure:(TBClientManagerBlock)failure;

-(void)usersShowWithAccess_token:(NSString *)access_token
                             uid:(int)uid
                     screen_name:(NSString *)screen_name
                         success:(TBClientManagerBlock)success
                         failure:(TBClientManagerBlock)failure;

-(void)friends_timelineWithSince_id:(int64_t)since_id
                             max_id:(int64_t)max_id
                              count:(int)count
                               page:(int)page
                           base_app:(int)base_app
                            feature:(int)freature
                          trim_user:(int)trim_user
                            success:(TBClientManagerBlock)success
                            failure:(TBClientManagerBlock)failure;


-(void)public_timelineWithAccess_token:(NSString *)access_token
                           count:(int )count
                            page:(int)page
                        base_app:(int)base_app
                         success:(TBClientManagerBlock)success
                         failure:(TBClientManagerBlock)failure;



@end
