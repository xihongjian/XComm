//
//  UIFont+Size.m
//  LoveStudy
//
//  Created by xpg on 16/8/9.
//  Copyright © 2016年 xpg. All rights reserved.
//

#import "UIFont+Size.h"

@implementation UIFont(Size)

- (CGFloat)getHeight
{
    NSString* s = @"测试";
    NSDictionary* attributes = @{s : self};
    return [s sizeWithAttributes:attributes].height;
}

@end
