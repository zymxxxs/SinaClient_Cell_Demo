//
//  NSString+Category.h
//  iOSCodeProject
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "TTIFormatValidate.h"




@implementation TTIFormatValidate



+(NSString *)validateHref:(NSString *)string
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<a href=.*?>(.*?)</a>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@"$1"];
    
    return modifiedString;
    
    //@用户名   @[\u4e00-\u9fa5a-zA-Z0-9_-]{4,30}   (@([\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))
    //＃＃ #[^#]+#  (#[\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+#)
    //url (%s*r)+|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)
}

+(NSArray *)calidateAT:(NSString *)string
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(@([\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
}

+(NSArray *)calidateTask:(NSString *)string
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#[^#]+#" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
}
+(NSArray *)calidateHttp:(NSString *)string
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(%s*r)+|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
}
@end
