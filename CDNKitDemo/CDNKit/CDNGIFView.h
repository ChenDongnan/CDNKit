//
//  CDNGIFView.h
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/6.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface CDNGIFView : UIView {
    CGImageSourceRef gif; //保存gif动画
    NSDictionary *gifProperties;  //保存gif动画属性
    size_t index; //gif动画播放开始的帧序号
    size_t count; //git动画总帧数
    NSTimer  *timer; //播放gif动画使用的timer
}

-(id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;
-(id)initWithFrame:(CGRect)frame data:(NSData *)_data;
-(void)stopGif;

@end
