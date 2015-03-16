//
//  TTIFont.m
//  iOSCodeProject
//
//  Created by Fox on 14-7-19.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "TTIFont.h"

@implementation TTIFont

+ (void)showAllSystemFonts{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"ICFont Index:%ld   Family name: %@",(long)indFamily, [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@" Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

+ (UIFont *)appFontWithSize:(float )size{
    return [UIFont fontWithName:@"GillSans" size:size];
}

+ (CGFloat)lineHeight:(UIFont *)font{
    return (font.ascender - font.descender) + 1;
}

+(float)calHeightWithText:(NSString *)text font:(UIFont *)font limitWidth:(float)limitWidth
{
        
        NSDictionary *attribute = @{NSFontAttributeName: font};
        
        CGSize retSize = [text boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
        
        return ceil(retSize.height);
}

+(float)calWidthWithText:(NSString *)text font:(UIFont *)font limitHeight:(float)limitHeight
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, limitHeight)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return ceil(retSize.width);
}


@end
