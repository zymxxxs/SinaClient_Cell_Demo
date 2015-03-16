//
//  TTIClient.h
//  AFNetWorkingDemo
//
//  Created by zym on 14-8-8.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTIClientConfig.h"
#import <AFHTTPRequestOperation.h>
#import <AFHTTPRequestOperationManager.h>


@class TTIClientManager;

typedef void(^ TTIClientManagerBlock)(AFHTTPRequestOperation *operetion,id response);

@interface TTIClientManager : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;   //网络请求管理


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


@end
