//
//  NSString+Category.h
//  iOSCodeProject
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 zym. All rights reserved.
//


/**
 *  字符格式操作帮助类，例：验证手机号，判断输入框内容是否合理等。
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TTIFormatValidate : NSObject




/**
 *  去除href标签
 *
 *  @param string 字段
 *
 *  @return <#return value description#>
 */
+ (NSString *)validateHref:(NSString *)string;

/**
 *  校验出文本中的@
 *
 *  @param string 字段
 *
 *  @return <#return value description#>
 */
+(NSArray *)calidateAT:(NSString *)string;

/**
 *  检验出文本中的话题
 */
+(NSArray *)calidateTask:(NSString *)string;

/**
 *  匹配出text中的url
 *
 *  @param string 字段
 *
 *  @return <#return value description#>
 */
+(NSArray *)calidateHttp:(NSString *)string;

@end
