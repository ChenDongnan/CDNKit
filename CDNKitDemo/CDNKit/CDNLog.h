//
//  CDNLog.h
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/3.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#ifndef CDNLog_h
#define CDNLog_h

#ifdef DEBUG 
#define LogMethod \
    NSLog(@"method:%s,   line:%d\n--------------",__func_,__LINE__);


#else
#define LogMethod;
#endif
#endif /* CDNLog_h */
