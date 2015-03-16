//
//  TTIClient.m
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "TTIClient.h"

@implementation TTIClient

static TTIClient *instance = nil;

//单例
+(TTIClient *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TTIClient alloc] init];
    });
    
    return instance;
}


-(void)accessTokenWithCode:(NSString *)code success:(TTIClientManagerBlock)success failure:(TTIClientManagerBlock)failure
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:SINA_APP_KEY forKey:@"client_id"];
//    [params setObject:SINA_APP_SECRET forKey:@"client_secret"];
//    [params setObject:@"authorization_code" forKey:@"grant_type"];
//    [params setObject:code forKey:@"code"];
//    [params setObject:SINA_REDIRECT_URL forKey:@"redirect_uri"];
    
    NSString *posturl = [NSString stringWithFormat:@"%@?client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",NET_ACCESS_TOKEN,SINA_APP_KEY,SINA_APP_SECRET,code,SINA_REDIRECT_URL];
    
    [self.manager POST:posturl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self parseResponse:responseObject operation:operation success:success failure:failure];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self parseResponse:operation.responseObject operation:operation success:success failure:failure];
    }];
}
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
                         failure:(TTIClientManagerBlock)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:source forKey:@"source123"];
    [params setValue:access_token forKey:@"access_token"];
    [params setValue:[NSNumber numberWithLongLong:since_id] forKey:@"since_id"];
    [params setValue:[NSNumber numberWithLongLong:max_id] forKey:@"max_id"];
    [params setValue:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setValue:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setValue:[NSNumber numberWithInt:base_app] forKey:@"base_app"];
    [params setValue:[NSNumber numberWithInt:feature] forKey:@"feature"];
    [params setValue:[NSNumber numberWithInt:feature] forKey:@"trim_user"];
    
    [self.manager GET:@"2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self parseResponse:responseObject operation:operation success:success failure:failure];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self parseResponse:operation.responseObject operation:operation success:success failure:failure];
    }];

}


@end
