//
//  NSString+CDNEncrypt.h
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/3.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CDNEncrypt)
/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)md5;
/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)sha1;
@end
