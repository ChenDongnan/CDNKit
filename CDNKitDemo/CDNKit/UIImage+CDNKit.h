//
//  UIImage+CDNKit.h
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/4.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDNKit)
/**
 *  将图片缩小至指定宽度
 *
 *  @param sourceImage 原图片
 *  @param defineWidth 目标图片宽度
 *
 *  @return 缩小后的图片
 */
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**
 *  由颜色值生成图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  裁剪图片指定区域
 *
 *  @param rect 指定区域
 *
 *  @return 裁剪后的图片
 */
- (instancetype)cutImageWithRect:(CGRect)rect;

/**
 *  @function 裁剪成圆形图片
 *
 *  @param margin     边框宽度
 *  @param boardColor 边框颜色
 *
 *  @return 裁剪后的圆形图片
 */
- (instancetype)circleWithBoardWidth:(CGFloat)margin boardColor:(UIColor *)boardColor;
/**
 *  @function 不改变图片边框的拉伸图片
 *
 *  @param img 原图
 *
 *  @return 拉伸后的新图
 */
- (instancetype)resizeableImage;

/**
 *  @function 加水印（图片）
 *
 *  @param bgImage   背景图片（就是衬在下面的图片）
 *  @param logoImage logo图片
 *  @param scale     logo图片的缩放比例
 *
 *  @return 加过水印之后的新图片
 */
- (instancetype)watermarkImage:(UIImage *)watermarkImage anCDNLogoScale:(CGFloat)scale;



@end
