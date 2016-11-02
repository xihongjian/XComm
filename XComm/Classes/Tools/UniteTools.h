//
//  UniteTools.h
//  LoveStudy
//
//  Created by xpg on 14/11/6.
//  Copyright (c) 2014年 xpg. All rights reserved.
//

#ifndef LoveStudy_UniteTools_h
#define LoveStudy_UniteTools_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//获取当前日期时间的字符串（yyyy-MM-dd HH:mm:ss）
FOUNDATION_EXTERN NSString* getCurrDate_UT();

//获取项目中数据的缓存根目录。
FOUNDATION_EXTERN NSString* getCacheRoot_UT();

//获取视频缓存根目录
FOUNDATION_EXTERN NSString* getVideoCacheRoot_UT();

//获取缓存数据根目录
FOUNDATION_EXTERN NSString* getDataRoot_UT();

//根据输入的URL拼接本地缓存地址。
FOUNDATION_EXTERN NSString* generatedVideoLocalPathWithUrl_UT(NSString* strUrl);

//创建目录
FOUNDATION_EXTERN void makePath_UT(NSString* path);

//图片缩放
FOUNDATION_EXTERN UIImage *zoomImageWithDstSize_UT(CGSize dstsize, UIImage *image);

//获取存储空间信息
FOUNDATION_EXTERN void getFileSysInfo(NSString** strused,
                                      NSString** strtotal,
                                      float* usedrate);


//用类类型实例化对象
id objectWithClass(Class oclass);


#endif
