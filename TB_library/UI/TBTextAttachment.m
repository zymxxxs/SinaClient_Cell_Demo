//
//  TBTextAttachment.m
//  Sina_Weibo
//
//  Created by zym on 15/9/24.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//

#import "TBTextAttachment.h"

@implementation TBTextAttachment

-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0,
                      self.font.descender,
                      self.font.ascender - self.font.descender,
                      self.font.ascender - self.font.descender);
}

@end
