//
//  TTIClient.m
//  AFNetWorkingDemo
//
//  Created by zym on 14-8-8.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "TBClientManager.h"
#import "TBClientConfig.h"
#import "AFNetworkActivityLogger.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APPHeader.h"

static TBClientManager *instance = nil;

@interface TBClientManager ()

@end

@implementation TBClientManager

#pragma mark - shareInstance
+(TBClientManager *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[TBClientManager alloc] init];
        
    });
    
    return instance;
}


-(id)init{
    self = [super init];
    if (self) {
        //设置baseurl
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:NET_BASEURL]];
        
        //AF2.0默认是使用AFJSONResponseSerializer自行对JSON进行解析。（如果请求成功，但是JSON无法解析，错误代码为3840）
        //想要AF2.0使用第三方解析，那么需要将设置为AFHTTPResponseSerializer即可，那么返回值为respondata，需要自己解析。
        self.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        
        //AF2.0只支持text/json，application/json，text/javascript三种格式，如果需要支持其他格式，请自行添加。
        self.operationManager.responseSerializer.acceptableContentTypes = [self.operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
        [[AFNetworkActivityLogger sharedLogger] startLogging];
    }
    return self;
}

-(void)parseResponse:(id)response
           operation:(AFHTTPRequestOperation *)operation
           success:(void(^)(AFHTTPRequestOperation *operetion,id response))success
           failure:(void(^)(AFHTTPRequestOperation *operetion,id response))failure{
    
    if (operation.error) {
        
        if (operation.error.code == 3840) {
            failure(operation,[NSDictionary dictionaryWithObjects:@[@"3804", @"数据格式错误"] forKeys:@[NET_CODE, NET_MESSAGE]]);
            return;
        }else if (operation.error.code == -1004)
        {
            failure(operation,[NSDictionary dictionaryWithObjects:@[@"-1004", @"无法连接到服务器"] forKeys:@[NET_CODE, NET_MESSAGE]]);
            return;
        }else
        {
            NSString *code = [NSString stringWithFormat:@"%ld",(long)operation.error.code];
            failure(operation,[NSDictionary dictionaryWithObjects:@[code, operation.error.localizedDescription] forKeys:@[NET_CODE, NET_MESSAGE]]);
            return;
        }
    }else{
        
        success(operation,response);
//        NSDictionary *responseDic = (NSDictionary *)response;
//        
//        if (![responseDic isKindOfClass:[NSDictionary class]] || ![responseDic objectForKey:NET_CODE]) {
//            failure(operation,[NSDictionary dictionaryWithObjects:@[@"401", NET_NETWORKERROR_TXT] forKeys:@[NET_CODE, NET_MESSAGE]]);
//            return;
//        }
//        
//        if ([[responseDic objectForKey:NET_CODE] integerValue] ==1 )
//        {
//            if (success)
//            {
//                success(operation,[responseDic objectForKey:NET_RESULT]);
//                return;
//
//            }
//
//        }else{
//            if (failure) {
//                failure(operation,responseDic);
//                return;
//            }
//        }
    }

}

#pragma mark - HTTP API

-(void)accessTokenWithCode:(NSString *)code
                   success:(TBClientManagerBlock)success
                   failure:(TBClientManagerBlock)failure
{
    NSString *posturl = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",SINA_APP_KEY,SINA_APP_SECRET,code,SINA_REDIRECT_URL];
    
    [self.operationManager POST:posturl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self parseResponse:responseObject operation:operation success:success failure:failure];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self parseResponse:operation.responseObject operation:operation success:success failure:failure];
    }];
}

-(void)usersShowWithAccess_token:(NSString *)access_token
                             uid:(int)uid
                     screen_name:(NSString *)screen_name
                         success:(TBClientManagerBlock)success
                         failure:(TBClientManagerBlock)failure{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:SINA_APP_KEY forKey:@"source"];
    [params setValue:access_token forKey:@"access_token"];
    [params setValue:[NSNumber numberWithInt:uid] forKey:@"uid"];
    [params setValue:screen_name forKey:@"screen_name"];
    
    
    [self.operationManager GET:@"https://api.weibo.com/2/statuses/public_timeline.json"
                     parameters:params
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            [self parseResponse:responseObject operation:operation success:success failure:failure];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [self parseResponse:operation.responseObject operation:operation success:success failure:failure];
                        }];
}

-(void)friends_timelineWithSince_id:(int64_t)since_id
                             max_id:(int64_t)max_id
                              count:(int)count
                               page:(int)page
                           base_app:(int)base_app
                            feature:(int)freature
                          trim_user:(int)trim_user
                            success:(TBClientManagerBlock)success
                            failure:(TBClientManagerBlock)failure{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:SINA_APP_KEY forKey:@"source"];
    [params setValue:@"2.00Hy6MWDXTPvpBdac11ca5fe07VXEa" forKey:@"access_token"];
    [params setValue:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setValue:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setValue:[NSNumber numberWithInt:base_app] forKey:@"base_app"];
    [params setValue:[NSNumber numberWithInt:freature] forKey:@"freature"];
    [params setValue:[NSNumber numberWithInt:trim_user] forKey:@"trim_user"];
    
    [self.operationManager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json"
                    parameters:params
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           
                           [self parseResponse:responseObject operation:operation success:success failure:failure];
                           
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           [self parseResponse:operation.responseObject operation:operation success:success failure:failure];
                       }];
    
}


-(void)public_timelineWithAccess_token:(NSString *)access_token
                           count:(int )count
                            page:(int)page
                        base_app:(int)base_app
                         success:(TBClientManagerBlock)success
                         failure:(TBClientManagerBlock)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:SINA_APP_KEY forKey:@"source"];
    [params setValue:access_token forKey:@"access_token"];
    [params setValue:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setValue:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setValue:[NSNumber numberWithInt:0] forKey:@"base_app"];

    
    [self.operationManager GET:@"https://api.weibo.com/2/statuses/public_timeline.json"
                    parameters:params
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self parseResponse:responseObject operation:operation success:success failure:failure];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self parseResponse:operation.responseObject operation:operation success:success failure:failure];
    }];
}



@end


