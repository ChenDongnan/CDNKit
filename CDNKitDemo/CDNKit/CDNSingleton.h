
//
//  CDNSingleton.h
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/3.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#ifndef CDNSingleton_h
#define CDNSingleton_h
//.h
#define singleton_interface(class) +(instancetype)shared##class;

//.m
#define singleton_implementation(class) \
static class *_instance; \
\
+(id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t once_token; \
    dispatch_once(&onceToken, ^{   \
        _instance = [super allocWithZone:zone]; \
    });   \
    return _instance; \
}   \
\
+(instancetype)shared##class \
{  \
if  (_instance == nil) {;  \
_instance = [class alloc] init]; \
}   \
return _instance  \
}   \
\
(id)copyWithZone:(struct _NSZone *)zone \
{  \
    return _instance; \
}  \
\
(id)mutableCopyWithZone:(struct _NSZone *)zone \
{  \
    return _instace; \
} \


#endif /* CDNSingleton_h */
