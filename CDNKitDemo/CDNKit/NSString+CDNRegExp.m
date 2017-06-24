//
//  NSString+CDNRegExp.m
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/3.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import "NSString+CDNRegExp.h"

@implementation NSString (CDNRegExp)
-(BOOL)match:(NSString *)pattern {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
    NSArray *result = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return result.count == 1;
}

-(BOOL)isNumber {
    return [self match:@"\\d"];
}

-(BOOL)isMobileNumber {
    return [self match:@"^1[3|4|5|7|8][0-9]\\d{8}$"];
}

-(BOOL)isLetter {
    return [self match:@"[a-zA-Z]"];
}

- (BOOL)isQQ{
    return [self match:@"^[1-9]\\d{4,10}$"];
}

- (BOOL)isEmail{
    return [self match:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"];
}

-(BOOL)isChineseCharacter {
    return [self match:@"[\\u4e00-\\u9fa5]"];
}

-(BOOL)isIDCard {
    return [self match:@"[^\\d{6}(18|19|20)\\d{2}(0[1-9]|1[12])(0[1-9]|[12]\\d|3[01])\\d{3}(\\d|[Xx])]"];
}
@end
