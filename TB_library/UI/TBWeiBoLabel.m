//
//  TBWeiBoLabel.m
//  Sina_Weibo
//
//  Created by zym on 15/9/23.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//


#import "TBWeiBoLabel.h"
#import "UIColor+TBExtend.h"
#import "TBTextAttachment.h"

#define URL_REGULAR @"(%s*r)+|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)"
#define TOPIC_REGULAR @"#[^#]+#"
#define ACCOUNT_REGULAR @"(@([\u4e00-\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))"

@interface TBWeiBoLabel ()<NSLayoutManagerDelegate>

@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSArray *links;
@property (nonatomic) BOOL isTouchMoved;
@property (nonatomic) NSRange selectedRange;

@end

@implementation TBWeiBoLabel

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

-(void)commitInit
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.links = [NSArray array];
    
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

#pragma mark - overriwd

-(NSTextContainer *)textContainer{
    if (!_textContainer) {
        _textContainer = [[NSTextContainer alloc] init];
        _textContainer.maximumNumberOfLines = self.numberOfLines;
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

-(void)setText:(NSString *)text{
    [super setText:text];
    [self statusTextToAttibuted:text];
}

- (void)setSelectedRange:(NSRange)range
{
    //移除attribute
    if (self.selectedRange.length && !NSEqualRanges(self.selectedRange, range)){
        [_textStorage removeAttribute:NSBackgroundColorAttributeName
                                range:self.selectedRange];
    }
    
    //添加attribute
    if (range.length){
        [_textStorage addAttribute:NSBackgroundColorAttributeName value:[UIColor colorForHex:@"c59fd4"]
                             range:range];
    }
    
    // Save the new range
    _selectedRange = range;
    
    [self setNeedsDisplay];
}

-(void)statusTextToAttibuted:(NSString *)text
{
    if (!text.length) {
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:@{NSFontAttributeName : self.font,
                                      NSForegroundColorAttributeName : [UIColor blackColor]}
                              range:NSMakeRange(0, attributedString.string.length)];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.maximumLineHeight = 21.f;
    paragraphStyle.minimumLineHeight = 21.f;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, text.length)];
    
    [self attibutedStatusTextToHighlight:attributedString];
    [self attibutedStatusTextToEmoticons:attributedString];
    [self.textStorage setAttributedString:attributedString];
    
}

-(void)attibutedStatusTextToHighlight:(NSMutableAttributedString *)attributedString
{
    NSMutableArray *tempLinks = [NSMutableArray array];
    NSRange range = NSMakeRange(0, attributedString.string.length);
    NSString *string = attributedString.string;
    
    NSDictionary *definition = @{[NSNumber numberWithInteger:TBWeiboLinkTypeURL]:URL_REGULAR,
                                 [NSNumber numberWithInteger:TBWeiboLinkTypeAccount]:ACCOUNT_REGULAR,
                                 [NSNumber numberWithInteger:TBWeiboLinkTypeTopic]:TOPIC_REGULAR};
    
    for (id key in definition) {
        NSString *expression = definition[key];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSArray *mathes = [regex matchesInString:string
                                         options:NSMatchingReportProgress
                                           range:range];
        for (NSTextCheckingResult *result in mathes) {
            [attributedString addAttributes:@{NSFontAttributeName : self.font,
                                              NSForegroundColorAttributeName : [UIColor colorForHex:@"9B59B6"]}
                                      range:[result range]];
            [tempLinks addObject:@{@"key" : [string substringWithRange:[result range]],
                                   @"range" : [NSValue valueWithRange:[result range]],
                                   @"type" : key }];
        }
    }
    self.links = tempLinks;
}

-(void)attibutedStatusTextToEmoticons:(NSMutableAttributedString *)attributedString
{
    NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"default_Info" ofType:@"plist"];
    NSString *lxhPath = [[NSBundle mainBundle] pathForResource:@"lxh_Info" ofType:@"plist"];
    
    NSArray *emoticonPaths = @[defaultPath,lxhPath];
    for (NSString *path in emoticonPaths) {
        NSDictionary *emoticonDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *emoticons = emoticonDic[@"emoticons"];
        
        for (NSDictionary *emoticonDic in emoticons) {
            NSString *cht = [emoticonDic objectForKey:@"cht"];
            NSString *chs = [emoticonDic objectForKey:@"chs"];
            while ([attributedString.string rangeOfString:cht].location != NSNotFound) {
                
                NSRange chtRange = [attributedString.string rangeOfString:cht];
                if (chtRange.location != NSNotFound) {
                    [self setEmoticonWithRange:chtRange
                                   emoticonDic:emoticonDic
                              attributedString:attributedString];
                }
            }
            while ([attributedString.string rangeOfString:chs].location != NSNotFound) {
                
                NSRange chsRange = [attributedString.string rangeOfString:chs];
                if (chsRange.location != NSNotFound) {
                    [self setEmoticonWithRange:chsRange
                                   emoticonDic:emoticonDic
                              attributedString:attributedString];
                }
            }

        }
    }
    
}
-(void)setEmoticonWithRange:(NSRange)range emoticonDic:(NSDictionary *)emoticonDic attributedString:(NSMutableAttributedString *)attributedString
{
    

    TBTextAttachment *attachment = [[TBTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:emoticonDic[@"png"]];
    attachment.font = self.font;
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    [attributedString replaceCharactersInRange:range
                          withAttributedString:attachmentString];
    
}


-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    _textContainer.size = bounds.size;
    CGRect textBounds;
    NSRange glyphRange = [_layoutManager glyphRangeForTextContainer:_textContainer];
    textBounds = [_layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:_textContainer];
    
    textBounds.origin = bounds.origin;
    textBounds.size.width = ceilf(textBounds.size.width);
    textBounds.size.height = ceilf(textBounds.size.height);
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
        NSRange range = [dic[@"range"] rangeValue];
        if ((touchedChar >= range.location) && touchedChar < (range.location + range.length)) {
            return dic;
        }
    }
    
    return nil;
}

#pragma mark - touches methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    
    NSDictionary *touchedLink = [self linkDicToPoint:touchLocation];
    if (touchedLink) {
        self.selectedRange = [touchedLink[@"range"] rangeValue];
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
        NSRange range = [[touchedLink objectForKey:@"range"] rangeValue];
        NSString *touchedSubstring = [touchedLink objectForKey:@"key"];
//        RichLinkType linkType = (RichLinkType)[[touchedLink objectForKey:RichLabelLinkTypeKey] intValue];
//        if (_linkerHandler) {
//            _linkerHandler(touchedSubstring,range,linkType);
//        }
    }
    else
    {
        [super touchesEnded:touches withEvent:event];
    }
    
    self.selectedRange = NSMakeRange(0, 0);
}

@end
