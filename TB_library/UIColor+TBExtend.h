//
//  UIColor+Utils.h
//  iOSCodeProject
//
//  Created by zym on 14-7-19.
//  Copyright (c) zym. All rights reserved.
//

//#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import <UIKit/UIKit.h>


#undef	RGB
#define RGB(R,G,B)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]

#undef	RGBA
#define RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#undef	HEX_RGB
#define HEX_RGB(V)		[UIColor colorForHex:V]

#undef	HEX_RGBA
#define HEX_RGBA(V, A)	[UIColor colorForHex:V alpha:A]


@interface UIColor (TBExtend)

/**
 *  通过十六进制获取颜色
 *
 *  @param hexColor 十六进制
 *
 */
+ (UIColor *)colorForHex:(NSString *)hexColor;


+ (UIColor *)colorForHex:(NSString *)hexColor alpha:(float)alpha;

/**
 *  生成随机颜色
 */
+ (UIColor *)randomColor;

@end


//#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)