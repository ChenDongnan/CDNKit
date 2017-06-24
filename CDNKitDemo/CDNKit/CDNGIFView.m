//
//  CDNGIFView.m
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/6.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import "CDNGIFView.h"

@implementation CDNGIFView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath {
    if (self = [super initWithFrame:frame]) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame data:(NSData *)_data {
    if (self = [super initWithFrame:frame]) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithData((CFDataRef)_data, (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
    }
    return self;
}


-(void)play {
    index ++;
    index = index%count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}

- (void)removeFromSuperview {
    [timer invalidate];
    timer = nil;
    [super removeFromSuperview];
}

-(void)dealloc {
    CFRelease(gif);
}

-(void)stopGif {
    [timer invalidate];
    timer = nil;
}



@end
