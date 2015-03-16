//
//  TTIClient.m
//  AFNetWorkingDemo
//
//  Created by zym on 14-8-8.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "TTIClientManager.h"
#import "TTIClientConfig.h"
#import <AFNetworkActivityLogger.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "AppMacro.h"


@interface TTIClientManager ()

@end


@implementation TTIClientManager


-(id)init{
    self = [super init];
    if (self) {
        //设置baseurl
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:NET_BASEURL]];
        
        //AF2.0默认是使用AFJSONResponseSerializer自行对JSON进行解析。（如果请求成功，但是JSON无法解析，错误代码为3840）
        //想要AF2.0使用第三方解析，那么需要将设置为AFHTTPResponseSerializer即可，那么返回值为respondata，需要自己解析。
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        

        
        
        //AF2.0只支持text/json，application/json，text/javascript三种格式，如果需要支持其他格式，请自行添加。
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
        [[AFNetworkActivityLogger sharedLogger] startLogging];
        
        //支持https协议
        //self.manager.securityPolicy.allowInvalidCertificates = YES;;
    }
    return self;
}

-(void)parseResponse:(id)response
           operation:(AFHTTPRequestOperation *)operation
           success:(void(^)(AFHTTPRequestOperation *operetion,id response))success
           failure:(void(^)(AFHTTPRequestOperation *operetion,id response))failure{
    
    if (operation.error) {
        
        if (operation.error.code == 3840) {
            
            failure(operation,@{NET_ERROR_CODE : @"3084",NET_ERROR :@"数据格式错误"});
            
            return;
            
        }else if (operation.error.code == -1004)
        {
            failure(operation,@{NET_ERROR_CODE : @"1004",NET_ERROR :@"无法连接到服务器"});
    
            return;
        }else
        {
            NSString *code = [NSString stringWithFormat:@"%ld",(long)operation.error.code];
            
            failure(operation , @{ NET_ERROR_CODE: code,NET_ERROR :operation.error.localizedDescription});
            
            return;
        }
    }else{
         
        NSDictionary *responseDic = (NSDictionary *)response;
        
        if (![[responseDic allKeys] containsObject:@"error"]&&![[responseDic allKeys] containsObject:@"error_code"])
        {
            if (success)
            {
                success(operation,responseDic);
                return;

            }

        }else{
            if (failure) {
                failure(operation,responseDic);
                return;
            }
        }
    }

}

@end


