//
//  CDNInsertLabel.m
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/6/24.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import "CDNInsetLabel.h"

@implementation CDNInsetLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _textInsets = UIEdgeInsetsZero;
}

// 修改绘制文字的区域，edgeInsets增加bounds
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    /*
     调用父类该方法
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     */
    CGRect rect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.textInsets.left;
    rect.origin.y -= self.textInsets.top;
    rect.size.width += self.textInsets.left + self.textInsets.right;
    rect.size.height += self.textInsets.top + self.textInsets.bottom;
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}
@end
