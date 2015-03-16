//
//  TTITextAttachment.m
//  SinaClient_Demo
//
//  Created by zym on 15/3/12.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "TTITextAttachment.h"

@implementation TTITextAttachment

-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
#warning 为神马返回的lineFrag的高度这么小呢。干！！！
    return CGRectMake(0, self.fontDescender, self.lineHeight, self.lineHeight);
}

@end
