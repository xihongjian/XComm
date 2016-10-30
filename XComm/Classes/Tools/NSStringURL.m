//
//  NSStringURL.m
//  LoveStudy
//
//  Created by xpg on 14/11/6.
//  Copyright (c) 2014年 xpg. All rights reserved.
//

#import "NSStringURL.h"

@implementation NSString(URL)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)URLEncodedStringNull
{
    
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
