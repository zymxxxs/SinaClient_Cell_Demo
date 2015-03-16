//
//  RichLabel.m
//  SinaClient_Demo
//
//  Created by zym on 15/3/11.
//  Copyright (c) 2015年 zym. All rights reserved.


#import "TTIRichLabel.h"
#import "TTIFormatValidate.h"
#import "UIColor+Utils.h"
#import "TTITextAttachment.h"

NSString * const RichLabelLinkTypeKey = @"linkType";
NSString * const RichLabelRangeKey = @"range";
NSString * const RichLabelLinkKey = @"link";

@interface TTIRichLabel ()<NSLayoutManagerDelegate>

@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSArray *links;
@property (nonatomic) BOOL isTouchMoved;

@property (nonatomic) NSRange selectedRange;

@end

@implementation TTIRichLabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self commitInit];
    }
    return self;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commitInit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

-(void)commitInit
{
    //self.backgroundColor = [UIColor redColor];
    self.userInteractionEnabled = YES;
    [self statusTextToAttributed:self.text];
    //self.font = []
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _textContainer.size = self.bounds.size;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    _textContainer.size = self.bounds.size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textContainer.size = self.bounds.size;
    
}

#pragma mark - overriwed
-(NSTextContainer *)textContainer
{
    if (!_textContainer) {
        _textContainer = [[NSTextContainer alloc] init];
        _textContainer.maximumNumberOfLines = self.numberOfLines;
        //文字距离container左右的间距，默认是5.0f
        _textContainer.lineFragmentPadding = 0.0f;
    }
    return _textContainer;
}

-(NSTextStorage *)textStorage
{
    if (!_textStorage) {
        _textStorage = [[NSTextStorage alloc] init];
        [_textStorage addLayoutManager:self.layoutManager];
        
    }
    return _textStorage;
}
-(NSLayoutManager *)layoutManager
{
    if (!_layoutManager) {
        _layoutManager = [[NSLayoutManager alloc] init];
        _layoutManager.delegate = self;
        [_layoutManager addTextContainer:self.textContainer];
    }
    return _layoutManager;
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self statusTextToAttributed:text];
}

- (void)setSelectedRange:(NSRange)range
{
    //移除attribute
    if (self.selectedRange.length && !NSEqualRanges(self.selectedRange, range)){
        [_textStorage removeAttribute:NSBackgroundColorAttributeName range:self.selectedRange];
    }
    
    //添加attribute
    if (range.length){
        [_textStorage addAttribute:NSBackgroundColorAttributeName value:[UIColor lightGrayColor] range:range];
    }
    
    // Save the new range
    _selectedRange = range;
    
    [self setNeedsDisplay];
}

- (void)statusTextToAttributed:(NSString *)text;
{
    if (text.length == 0) {
        return ;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedString addAttributes:@{NSFontAttributeName : self.font,
                                      NSForegroundColorAttributeName : [UIColor blackColor]}
                              range:NSMakeRange(0, text.length)];
    
    //获取link的临时array
    NSMutableArray *tempLinks = [NSMutableArray array];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2.0f;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, text.length)];
    
    //转换@
    NSArray *arrayAt = [TTIFormatValidate calidateAT:text];
    [arrayAt enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSTextCheckingResult class]]) {
            
            [attributedString addAttributes:@{NSFontAttributeName : self.font,
                                              NSForegroundColorAttributeName : [UIColor colorForHex:@"9B59B6"]}
                                      range:[(NSTextCheckingResult *)obj range]];
            
            [tempLinks addObject:@{RichLabelLinkKey : [text substringWithRange:[(NSTextCheckingResult *)obj range]],
                                   RichLabelRangeKey : [NSValue valueWithRange:[(NSTextCheckingResult *)obj range]],
                                   RichLabelLinkTypeKey : @(RichLinkTypeUserName)}];
        }
    }];
    //转换http
    NSArray *arrayHttp = [TTIFormatValidate calidateHttp:text];
    [arrayHttp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSTextCheckingResult class]]) {
            
            [attributedString addAttributes:@{NSFontAttributeName : self.font,
                                              NSForegroundColorAttributeName : [UIColor colorForHex:@"9B59B6"]}
                                      range:[(NSTextCheckingResult *)obj range]];
            
            [tempLinks addObject:@{RichLabelLinkKey : [text substringWithRange:[(NSTextCheckingResult *)obj range]],
                                   RichLabelRangeKey : [NSValue valueWithRange:[(NSTextCheckingResult *)obj range]],
                                   RichLabelLinkTypeKey : @(RichLinkTypeUrl)}];
            
        }
    }];
    
    
    //转换＃＃换题
    NSArray *arrayTask = [TTIFormatValidate calidateTask:text];
    [arrayTask enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSTextCheckingResult class]]) {
            
            [attributedString addAttributes:@{NSFontAttributeName : self.font,
                                              NSForegroundColorAttributeName : [UIColor colorForHex:@"9B59B6"]}
                                      range:[(NSTextCheckingResult *)obj range]];
            
            [tempLinks addObject:@{RichLabelLinkKey : [text substringWithRange:[(NSTextCheckingResult *)obj range]],
                                   RichLabelRangeKey : [NSValue valueWithRange:[(NSTextCheckingResult *)obj range]],
                                   RichLabelLinkTypeKey : @(RichLinkTypeTask)}];
            
        }
    }];
    
    NSDictionary *emojiDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"]];
    NSArray *emoticon_group_emoticons = emojiDic[@"emoticon_group_emoticons"];
    [emoticon_group_emoticons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           
        NSDictionary *dic = (NSDictionary *)obj;

        

        
        
        NSString *cht = [dic objectForKey:@"cht"];
        for (int i = 0; ; i++) {
            NSRange chtRange = [attributedString.string rangeOfString:cht];
            if (chtRange.length) {
                TTITextAttachment *attachment = [[TTITextAttachment alloc] init];
                attachment.image = [UIImage imageNamed:dic[@"png"]];
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                attachment.fontDescender = self.font.descender;
                attachment.lineHeight = self.font.lineHeight + 2;
                [attributedString replaceCharactersInRange:chtRange withAttributedString:attachmentString];
            }else{
                break;
            }
        }
        
        NSString *chs = [dic objectForKey:@"chs"];
        
        for (int i = 0; ; i++) {
            NSRange chsRange = [attributedString.string rangeOfString:chs];
            if (chsRange.length) {
                
                NSRange chsRange = [attributedString.string rangeOfString:chs];
                if (chsRange.length) {
                    
                    TTITextAttachment *attachment = [[TTITextAttachment alloc] initWithData:nil ofType:nil];
                    attachment.image = [UIImage imageNamed:dic[@"png"]];
                    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                    attachment.fontDescender = self.font.descender;
                    attachment.lineHeight = self.font.lineHeight + 2;
                    [attributedString replaceCharactersInRange:chsRange withAttributedString:attachmentString];

                }
                
            }else{
                break;
            }
        }
        
    }];
    
    self.links = tempLinks;
    
    [self.textStorage setAttributedString:attributedString];
}

-(NSDictionary *)linkDicToPoint:(CGPoint )location
{
    if (!self.textStorage.string.length) {
        return nil;
    }
    //点击文字的行数
    NSUInteger touchedChar = [_layoutManager glyphIndexForPoint:location inTextContainer:_textContainer];
    
    //获取行数所在矩阵的rect
    NSRange lineRange;
    CGRect lineRect = [_layoutManager lineFragmentUsedRectForGlyphAtIndex:touchedChar effectiveRange:&lineRange];
    //判断点击是否在矩阵内
    if (CGRectContainsPoint(lineRect, location) == NO){
        return nil;
    }
    
    for (NSDictionary *dic in self.links) {
        NSRange range = [dic[RichLabelRangeKey] rangeValue];
        if ((touchedChar >= range.location) && touchedChar < (range.location + range.length)) {
            return dic;
        }
    }
    
    return nil;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    //使用容器计算出bounds
    //先保存
    CGSize savedTextContainerSize = _textContainer.size;
    NSInteger savedTextContainerNumberOfLines = _textContainer.maximumNumberOfLines;
    
    _textContainer.size = bounds.size;
    _textContainer.maximumNumberOfLines = numberOfLines;
    
    CGRect textBounds;
    @try
    {
        NSRange glyphRange = [_layoutManager glyphRangeForTextContainer:_textContainer];
        textBounds = [_layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:_textContainer];
        
        
        textBounds.origin = bounds.origin;
        textBounds.size.width = ceilf(textBounds.size.width);
        textBounds.size.height = ceilf(textBounds.size.height);
    }
    @finally
    {
        // 还原
        _textContainer.size = savedTextContainerSize;
        _textContainer.maximumNumberOfLines = savedTextContainerNumberOfLines;
    }
    
    return textBounds;
}

- (void)drawTextInRect:(CGRect)rect
{
    
    // Calculate the offset of the text in the view
    NSRange glyphRange = [_layoutManager glyphRangeForTextContainer:_textContainer];

    
    // 开始画
    [_layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:CGPointZero];
    [_layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:CGPointZero];
    
}



#pragma mark - touches methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    
    NSDictionary *touchedLink = [self linkDicToPoint:touchLocation];
    if (touchedLink) {
        self.selectedRange = [touchedLink[RichLabelRangeKey] rangeValue];
    }else
    {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    _isTouchMoved = YES;
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    self.selectedRange = NSMakeRange(0, 0);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[super touchesEnded:touches withEvent:event];
    
    if (_isTouchMoved)
    {
        self.selectedRange = NSMakeRange(0, 0);
        return;
    }
    
    // Get the info for the touched link if there is one
    NSDictionary *touchedLink;
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    touchedLink = [self linkDicToPoint:touchLocation];
    
    if (touchedLink)
    {
        NSRange range = [[touchedLink objectForKey:RichLabelRangeKey] rangeValue];
        NSString *touchedSubstring = [touchedLink objectForKey:RichLabelLinkKey];
        RichLinkType linkType = (RichLinkType)[[touchedLink objectForKey:RichLabelLinkTypeKey] intValue];
        if (_linkerHandler) {
            _linkerHandler(touchedSubstring,range,linkType);
        }
    }
    else
    {
        [super touchesEnded:touches withEvent:event];
    }
    
    self.selectedRange = NSMakeRange(0, 0);
}

@end
