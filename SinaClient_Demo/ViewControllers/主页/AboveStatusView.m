//
//  AboveStatusView.m
//  SinaClient_Demo
//
//  Created by zym on 15/3/13.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "AboveStatusView.h"
#import "APPHeader.h"

@implementation AboveStatusView


-(void)initLayoutConstraint
{
    [self addConstraints:@[[NSLayoutConstraint
                            constraintWithItem:_contentLabel
                            attribute:NSLayoutAttributeBottom
                            relatedBy:NSLayoutRelationEqual
                            toItem:self
                            attribute:NSLayoutAttributeBottom
                            multiplier:1.0f
                            constant: - 10.0f],
                           
                           [NSLayoutConstraint
                            constraintWithItem:_contentLabel
                            attribute:NSLayoutAttributeLeft
                            relatedBy:NSLayoutRelationEqual
                            toItem:self
                            attribute:NSLayoutAttributeLeft
                            multiplier:1.0f
                            constant:20.0f],
                           
                           [NSLayoutConstraint
                            constraintWithItem:_contentLabel
                            attribute:NSLayoutAttributeTop
                            relatedBy:NSLayoutRelationEqual
                            toItem:self
                            attribute:NSLayoutAttributeTop
                            multiplier:1.0f
                            constant: 10.0f],
                           
                           [NSLayoutConstraint
                            constraintWithItem:_contentLabel
                            attribute:NSLayoutAttributeRight
                            relatedBy:NSLayoutRelationEqual
                            toItem:self
                            attribute:NSLayoutAttributeRight
                            multiplier:1.0f
                            constant: -20.0f],
                           
                           ]];

}

-(void)removeLayoutConstraint
{
    [self removeConstraints:self.constraints];
}
-(void)awakeFromNib
{
    self.contentLabel = [[TTIRichLabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentLabel.numberOfLines = 0;
    _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentLabel];
    
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
}

-(void)updateConstraints
{
    [super updateConstraints];
    _contentLabel.preferredMaxLayoutWidth = UIScreenWidth - 40;
}


@end
