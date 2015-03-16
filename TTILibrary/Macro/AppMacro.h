//
//  AppMacro.h
//  iOSCodeProject
//
//  Created by Fox on 14-7-17.
//  Copyright (c) 2014年 zym. All rights reserved.
//

/**
 *  项目内公共常用宏定义
 */

#ifndef iOSCodeProject_AppMacro_h
#define iOSCodeProject_AppMacro_h

#pragma mark - Format
/**
 *  生成字符串
 *
 *  @param ... 格式化参数
 *
 *  @return 得到的字符串
 */
#define str(...) [NSString stringWithFormat:__VA_ARGS__]

/**
 *  根据名字返回对应的图片
 */
#define img(name) [UIImage imageNamed:name]


#pragma mark - Block

/**
 *  弱引用对象
 *
 *  @param self 当前对象
 *
 *  @return 弱应用对象
 */
#define WEAKSELF typeof(self) __weak weakSelf = self;

/**
 *  强引用对象
 *
 *  @param self 当前对象
 *
 *  @return 强引用对象
 */
#define STRONGSELF typeof(self) __strong strongSelf = self;

#pragma mark - Debug

#ifdef DEBUG

/**
 *  在Debug模式下，输出内容
 */
#define DLOG(...)   NSLog(__VA_ARGS__)

/**
 *  在Debug模式下，输出Point信息
 *
 *  @param p 点
 *
 *  @return 点的x和y
 */
#define DLOGPOINT(p)	NSLog(@"%f,%f", p.x, p.y);

/**
 *  在Debug模式下，输出Size信息
 *
 *  @param size 大小
 *
 *  @return 大小的width和height
 */
#define DLOGSIZE(size)	NSLog(@"%f,%f", size.width, size.height);

/**
 *  在Debug模式下，输出Fame信息
 *
 *  @param  p  位置信息
 *
 *  @return 位置的x、y、width和height
 */
#define DLOGRECT(p)	NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

#else

#define DLOG(...)
#define DLOGPOINT(p)
#define DLOGSIZE(p)
#define DLOGRECT(p)

#endif

#pragma mark - Tools methods
/**
 *  判断一个对象是否为空
 *
 *  @param thing 对象
 *
 *  @return 返回结果
 */
static inline BOOL ICIsObjectEmpty(id thing){
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

/**
 *  判断一个字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回结果
 */
static inline BOOL ICIsStringEmpty(NSString *string){
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}

//程序全局委托
#ifndef APPLICATIONDELEGATE
#define APPLICATIONDELEGATE   (AppDelegate*)[[UIApplication sharedApplication] delegate]
#endif

//安全释放
#ifndef RELEASE
#define RELEASE(x)         if(nil != (x)){ [(x) release]; (x) = nil;}
#endif

#pragma mark - iPhone5 adaptation


//是否为iPhone6
#ifndef iPhone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//是否为iPhone6P
#ifndef iPhone6P
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#endif


//是否为iPhone5
#ifndef iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//是否为iPhone4
#ifndef iPhone4
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//设备屏幕高度
#ifndef UIScreenHeight
#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#endif

//设备屏幕宽度
#ifndef UIScreenWidth
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width
#endif

//是否为ios7
#ifndef IOS7
#define IOS7            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?YES:NO)
#endif

//是否为ios6
#ifndef IOS6
#define IOS6            ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0?YES:NO)
#endif

//如果为ios7，则返回20的冗余
#ifndef IOS7_PADDING
#define IOS7_PADDING    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?20:0)
#endif

//区分真机和模拟器
//TARGET_OS_IPHONE  是否为真机
//TARGET_IPHONE_SIMULATOR  是否为模拟器
/*
if (TARGET_OS_IPHONE) {
    //真机
}else{
    //非真机
}
 */

//区分是否为ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#endif
