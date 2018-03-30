//
//  MARUITextView.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARUITextView.h"

@interface MARUITextView ()
- (void)_setup;
- (void)_textChanged:(NSNotification *)notification;
@end

@implementation MARUITextView

#pragma mark - Accessors

@synthesize placeholder = _placeholder;
@synthesize placeholderTextColor = _placeholderTextColor;

- (void)setText:(NSString *)string {
    [super setText:string];
    [self setNeedsDisplay];
}


- (void)insertText:(NSString *)string {
    [super insertText:string];
    [self setNeedsDisplay];
}


- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


- (void)setPlaceholder:(NSString *)string {
    if ([string isEqual:_placeholder]) {
        return;
    }
    
    _placeholder = string;
    [self setNeedsDisplay];
}


- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}


- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _setup];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self _setup];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.text.length == 0 && self.placeholder) {
        // Inset the rect
        rect = UIEdgeInsetsInsetRect(rect, self.contentInset);
        
        // TODO: This is hacky. Not sure why 8 is the magic number
        if (self.contentInset.left == 0.0f) {
            rect.origin.x += 8.0f;
        }
        rect.origin.y += 8.0f;
        
        // Draw the text
        [_placeholderTextColor set];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByTruncatingTail;
        style.alignment = self.textAlignment;
        [_placeholder drawInRect:rect withAttributes:@{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:style}];
//        [_placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
    }
}

#pragma mark - Private

- (void)_setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderTextColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
}


- (void)_textChanged:(NSNotification *)notification {
    [self setNeedsDisplay];
}


@end
