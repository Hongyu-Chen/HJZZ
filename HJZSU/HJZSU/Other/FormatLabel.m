//
//  FormatLabel.m
//  VideoData
//
//  Created by pro1 on 2019/3/1.
//  Copyright © 2019 pro1. All rights reserved.
//

#import "FormatLabel.h"

@implementation FormatLabel

- (void)setText:(NSString *)text{
    [super setText:text];
    if (self.lineSpcae > 0 || self.wordSpace > 0 || self.firstLineHeadIndent > 0) {
        NSMutableAttributedString *attributedString;
        if (self.attributedText) {
            attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        }
        else{
            attributedString = [[NSMutableAttributedString alloc] initWithString:text];
            [self setNormaFormatWith:attributedString];
        }
        if (self.wordSpace > 0) {
            [attributedString setAttributes:@{NSKernAttributeName:@(self.wordSpace)} range:NSMakeRange(0, [text length])];
        }
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = self.textAlignment;
        if (self.lineSpcae > 0 || self.firstLineHeadIndent > 0) {
            if (self.lineSpcae > 0) {
                [paragraphStyle setLineSpacing:self.lineSpcae];
            }
            if (self.firstLineHeadIndent > 0) {
                [paragraphStyle setFirstLineHeadIndent:self.firstLineHeadIndent];
            }
        }
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        self.attributedText = attributedString;
    }
}

- (void)setHeightLightWords:(NSArray *)words heightLightColors:(NSArray *)colors htightLightFont:(NSArray *)fonts{
    if (!words || words.count == 0) {
        return;
    }
    NSString *text = self.text;
    NSMutableAttributedString *attributedString;
    if (self.attributedText) {
        attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    else{
        attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [self setNormaFormatWith:attributedString];
    }
    
    for (NSString *str in words) {
        NSInteger index = [words indexOfObject:str];
        if (IsNullString(text)) {
            break;
        }
        NSRange rang = [text rangeOfString:str];
        if (rang.location == NSNotFound) {
            break;
        }
        UIColor *color = colors || colors.count > 0 ? (index >= words.count ? colors.lastObject : colors[index]) : (self.textColor ? self.textColor : [UIColor blackColor]);
        UIFont *font = fonts || fonts.count > 0 ? (index >= fonts.count ? fonts.lastObject : fonts[index]) : (self.font ? self.font : [UIFont systemFontOfSize:13]);
        [attributedString addAttribute:NSForegroundColorAttributeName
                              value:color
                              range:rang];
        
        [attributedString addAttribute:NSFontAttributeName
                              value:font
                              range:rang];
    }
    self.attributedText = attributedString;
}
- (void)setImage:(UIImage *)image toIndex:(NSInteger)index imageFrame:(CGRect)frame{
    if (!image) {
        return;
    }
    NSString *text = self.text;
    NSMutableAttributedString *attributedString;
    if (self.attributedText) {
        attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    else{
        attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [self setNormaFormatWith:attributedString];
    }
    
    if (image) {
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = image;
        attach.bounds = frame;
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
        if (index >= text.length) {
            index = text.length;
        }
        else if (index < 0){
            index = 0;
        }
        [attributedString insertAttributedString:attachString atIndex:index];
    }
    self.attributedText = attributedString;
}

- (void)setNormaFormatWith:(NSMutableAttributedString *)attributedString{
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:self.textColor ? self.textColor : [UIColor blackColor]
                             range:NSMakeRange(0 , self.text.length)];
    [attributedString addAttribute:NSFontAttributeName
                             value:self.font ? self.font : [UIFont systemFontOfSize:13]
                             range:NSMakeRange(0 , self.text.length)];
}

@end
