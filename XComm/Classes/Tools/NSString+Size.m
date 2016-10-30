//
//  NSString-Size.m
//  LoveStudy
//
//  Created by xpg on 16/8/9.
//  Copyright © 2016年 xpg. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString(Size)

- (CGFloat)getHeightWithFont:(UIFont*)font
{
    NSString* s = @"测试";
    NSDictionary* attributes = @{s : font};
    return [s sizeWithAttributes:attributes].height;
}

@end
