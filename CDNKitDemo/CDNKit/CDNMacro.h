

//
//  CDNMacro.h
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/3.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#ifndef CDNMacro_h
#define CDNMacro_h
/** RGB颜色 */
#define CDNRGBColor(r,g,b,a) [UIColor  colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/** 随机色 */
#define CDNRandomColor CDNRGBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255),1)

#endif /* CDNMacro_h */
