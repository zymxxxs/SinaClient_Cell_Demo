//
//  UIColor+Utils.m
//  iOSCodeProject
//
//  Created by zym on 14-7-19.
//  Copyright (c) zym. All rights reserved.
//


//#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "UIColor+TBExtend.h"

@implementation UIColor (TBExtend)

+ (UIColor *)colorForHex:(NSString *)hexColor{
    
    return [UIColor colorForHex:hexColor alpha:1.f];
}

+ (UIColor *)colorForHex:(NSString *)hexColor alpha:(float)alpha{
    if (hexColor.length!=6) {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [hexColor substringWithRange:range];
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];

}

+(UIColor *)randomColor{
    static BOOL seed = NO;
    if (!seed) {
        seed = YES;
        srandom((unsigned)time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];//alpha为1.0,颜色完全不透明
}

@end

//#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
