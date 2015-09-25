//
//  ViewController.m
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "OAuthViewController.h"
#import "TBLibraryHeader.h"

@interface OAuthViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *oauthWebView;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSURLRequest *oauthRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@&dispaly=%@",@"1683370155",@"https://github.com/TheSolitary",@"mobile"]]];
    [_oauthWebView loadRequest:oauthRequest];
    _oauthWebView.delegate = self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL.absoluteString rangeOfString:@"code="].location != NSNotFound) {
        NSString *code = [[request.URL.query componentsSeparatedByString:@"="] objectAtIndex:1];
        [[TBClientManager manager] accessTokenWithCode:code success:^(AFHTTPRequestOperation *operetion, id response) {
            [[NSUserDefaults standardUserDefaults] setObject:[response objectForKey:@"access_token"] forKey:@"token"];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } failure:^(AFHTTPRequestOperation *operetion, id response) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
    }
    
    return YES;
    
}

@end
